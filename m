Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A85CC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 16:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D07C887FD;
	Sat, 20 Jul 2024 18:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721494496;
	bh=KOxq2UKxAXvqp6T16eNTU20xEfBN9ngfclNBXEuLSBk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rVQn9IahQ74svELvVzSbBKILChcnp6FrWAsRQoqJcfhEdC8odW6CYupuUJpEgGl85
	 pxAayncJ4RyG2bDu7v1B01LKlN1PVsZYrr7Nsq+tsrRuZMUYVHB29SVGQgI+woT3RN
	 chqN2zCX83lzV1L3v+ERykyKND81Egm5Afmyl+5R91r2n0UWNCEQKWpEKMkX5Dtotn
	 lP8weYluVyAEO4MM2g4MUq9d+ZCaW35XGu9p80mSAn7Jn57eyYXoM5k8P/83KtQA78
	 Ik6HMKuzlVK7mBUS1PW+eZe87zN890RVjqZPtZJi5iUbKRCDT8C2/y9NxdJzWwN32l
	 YcFtdfU6A1mKA==
Received: from crub.agik.hopto.org (p508b6272.dip0.t-ipconnect.de
 [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 227F6886C3;
 Sat, 20 Jul 2024 18:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721494495;
 bh=KOxq2UKxAXvqp6T16eNTU20xEfBN9ngfclNBXEuLSBk=;
 h=From:To:Cc:Subject:Date:From;
 b=P2hRGsUAF1tZgK0/OPLLy/4eMI5kszotILftGOSu3k7ChNOO7XkWpKXJpHV/M3n5z
 aC6W7M8R56EjyJefqSfeusf3NL2yB1IStCeGdyPrRVqeyc28w3YO/xD8Ad+jGEJTYA
 NbDZMNJ5jzorlJJUAEU1+5Say/Z6+zfyI7Fdl5+upqyeXA0xGm9fSqd79J3wJSQTA7
 RGvD2iOUyWCQ5ANcU39hPWh4MIi3mJx8KutFMtQrAeO3mae6d7vVbEZPXjI3pr8PNW
 zlrlh5kxPOgtokI5QKTWkBwAEgJQWkrDu45eR86D5fyQybPdTfdV5tJrXhE7/DSC6D
 KeTK8iQFfJxfw==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH] pxm2: switch to DM_I2C
Date: Sat, 20 Jul 2024 18:54:39 +0200
Message-Id: <20240720165439.3620434-1-agust@denx.de>
X-Mailer: git-send-email 2.25.1
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

Enable DM_I2C to avoid board removal warning.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>
---
 configs/pxm2_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/pxm2_defconfig b/configs/pxm2_defconfig
index 366d8fc3ae..c2f869391d 100644
--- a/configs/pxm2_defconfig
+++ b/configs/pxm2_defconfig
@@ -89,7 +89,8 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+# CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_SPEED=400000
 # CONFIG_SPL_DM_MMC is not set
-- 
2.25.1

