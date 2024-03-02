Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E487CC54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 14:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AE287E83;
	Sat,  2 Mar 2024 15:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="KayB/z7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C46787D37; Sat,  2 Mar 2024 15:51:17 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACA0E87DB3
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 15:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709391075;
 bh=GGT8lXqtkapMo0opBoSr8bYufuq81lIN4q/lMeRaN2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KayB/z7XJASiAtdOW+A3bd0ysGvUhsNwSVaypHrqxpSAzoy7v33T0IVJ/DonfIn4g
 aEjXX+NBSiTvmk92xDdoAaaVAbqvF0KivnigTBtXi788DdqNIgfiYJx9DuvBSOLFvp
 Ko5S1onw1x3x+2ot0Ut9w67xZt4RuMofkPDhnpHP4SztjDsRIgDeQhxHJZzOCw8uaM
 Mxgc80XxpBhmtm6ZVDy3Zb49iMarCSHk3aUUq5D1fXIzfhVKINrPjgwJEn2I9DpEkq
 fTbONV/eFXtvS7rjtXqnWCd4HJZq+ycANGc/6hI3LThq+hXoWietWKaqBEB7qKrzvM
 pxZze+PyXWCnA==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id D43ED378208D;
 Sat,  2 Mar 2024 14:51:14 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] =?UTF-8?q?rockchip:=20spl-boot-order:=20Fix=20spel?=
 =?UTF-8?q?ling=20succes=E2=86=92success?=
Date: Sat,  2 Mar 2024 14:50:56 +0000
Message-ID: <20240302145107.168080-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302145107.168080-1-chris.obbard@collabora.com>
References: <20240302145107.168080-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix a simple spelling mistake in a comment.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

 arch/arm/mach-rockchip/spl-boot-order.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 2c39a215c10..e548a7dc718 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -29,7 +29,7 @@
  *   -ENOSYS, if the device matching the node can not be mapped onto a
  *            SPL boot device (e.g. the third MMC device)
  *   -1, for unspecified failures
- *   a positive integer (from the BOOT_DEVICE_... family) on succes.
+ *   a positive integer (from the BOOT_DEVICE_... family) on success.
  */
 
 static int spl_node_to_boot_device(int node)
-- 
2.43.0

