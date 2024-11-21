Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA7AD75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB3E989682;
	Thu, 21 Nov 2024 06:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166781;
	bh=mqwgnJgzRg1F2+ZmfKD3ajZKLujnACkbxZAv0gms1xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ohQe4kJNiOSkgow+0/4C+FKZlHmscKYtcdNrglgyY/m4IdIsC58hOze+/DaSfnp0m
	 y1zjqReV2ai9pkncKSWygoykF/EBXg5mwiUhFASQdmdq8dbb8PVvx6e2CXQcYlsY2b
	 g8DplVnY+K2+djFAEZ5KnuGH1UaUwwnZ48Fq491DJxNRv0fmwg67KWV2DpJ7LwmyBY
	 90YaUDd5dGJ/jOIugPKbHUyS+ELo2CRa3lM7uPsiVRfrXKAeGEm8ABJkFbf0IqqxTI
	 qTgRIu2APAPjI0XehCXl4xUJTHL3vpoP1A2ulw//lTeMYRZ14p4GtXVeVuHsL3EF6U
	 LuRdi/EuiFnYQ==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F391189668;
 Thu, 21 Nov 2024 06:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166777;
 bh=mqwgnJgzRg1F2+ZmfKD3ajZKLujnACkbxZAv0gms1xo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LbAYNmfe+7/t186iHTYXthT3ddmNFZ9z8uTmgjAG2w1FbYz9ua/jerzL6reQT7y8C
 J14JbwjTVXkej0lNgrt0SBTc7M27wTTwLfktu4aoO6/UooY8w4GKrb2n6HuPL9sPx4
 ORTjteqL3t81DmlHludayej4feB1h78+/njEc7SGhvdhjSaNsrC4PD9IZoJAqfgh+j
 ENlhxL+sz7UwCOYfi5QRpKLEYBVHc+i8faAry20XYwPtKA0eY3o9BtrfWEX+Xevyy9
 aFnYnuUOPBtofp9urpmVUbEH5xBGfRjGLkrvLj1Cy4FB53udvPwlc2GWir9n1Czx5v
 X3H6tTcYdirMQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 09/20] siemens: imximage.cfg: correct comment
Date: Thu, 21 Nov 2024 06:25:50 +0100
Message-Id: <20241121052601.72880-10-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

fix wrong comment.

Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---

(no changes since v2)

Changes in v2:
- add Reviewed-by from Alexander

 board/siemens/capricorn/imximage.cfg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/siemens/capricorn/imximage.cfg b/board/siemens/capricorn/imximage.cfg
index e45f2c9589e..f73c5a7a9b0 100644
--- a/board/siemens/capricorn/imximage.cfg
+++ b/board/siemens/capricorn/imximage.cfg
@@ -21,5 +21,6 @@ APPEND ahab-container.img
 CONTAINER
 /* Add scfw image with exec attribute */
 IMAGE SCU capricorn-scfw-tcm.bin
-/* Add ATF image with exec attribute */
+
+/* Add SPL image with exec attribute */
 IMAGE A35 spl/u-boot-spl.bin 0x00100000
-- 
2.20.1

