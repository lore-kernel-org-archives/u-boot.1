Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E08C46CD2
	for <u-boot@archiver.kernel.org>; Sun, 24 Dec 2023 18:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5DC4875EB;
	Sun, 24 Dec 2023 19:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="C+SFo9lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556518765A; Sun, 24 Dec 2023 19:13:02 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1051386F28
 for <u-boot@lists.denx.de>; Sun, 24 Dec 2023 19:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 024f43c9-a288-11ee-abd4-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 024f43c9-a288-11ee-abd4-005056999439;
 Sun, 24 Dec 2023 19:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=Ks5ykOCQJzjhPiXJCr6HzYq9MwiWk5P+a5jaD/0Z2zk=;
 b=C+SFo9lOqUPKQUaiDRKsbHMytgoBHszP45MHL1wA3YsCR23GslXWzXu2QYCYDvGdduoMiiXTwxj/A
 SL3W2udVhwRJLiE0YOJSwyRWmypIl7lHA/dtSAoTlfcsmiuLxT3l7hCZCb48HRCRJeUInF7ZwGLAau
 xSBGolWDqfeRLE4w=
X-KPN-MID: 33|2TNofwHqmEApDLsOAyuxpYJ7ymeYyQQaMWiyBSBOwqfxn6zI7ElZV0F8Q2F4IwJ
 RO9eLrnsOAs+9VCMbBxCb3w==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|7RtdIqLIFCwNdPZtUUs2HR3lII4+082pFPzBWgjHD2FIFN/g/Ja3cqYHJEMQQGS
 wLYMUL6IFWpcWxtdJai0o/Q==
X-Originating-IP: 80.61.163.207
Received: from copland.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1177e942-a288-11ee-acaa-00505699d6e5;
 Sun, 24 Dec 2023 19:12:59 +0100 (CET)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com,
 xypron.glpk@gmx.de, Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] arm: apple: Disable SMBIOS again
Date: Sun, 24 Dec 2023 19:12:55 +0100
Message-ID: <20231224181255.4954-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Apple machines do not have memory below 4G.  Since U-Boot does
not support the SMBIOS 3 header structures this means we can't
support SMBIOS on these machines.  Unfortunately the refactoring
of the SMBIOS code this cycle accidentally enabled it again.

Fixes: 53fab13a7b1 ("efi: Use the installed SMBIOS tables")
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 configs/apple_m1_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index d58a9030db..b868d0e319 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -21,5 +21,5 @@ CONFIG_USB_KEYBOARD=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
-# CONFIG_GENERATE_SMBIOS_TABLE is not set
+# CONFIG_SMBIOS is not set
 CONFIG_LMB_MAX_REGIONS=64
-- 
2.43.0

