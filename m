Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328ACD5E396
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF7E8944E;
	Mon, 18 Nov 2024 07:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911256;
	bh=FZpdWdNKPa8UE9QJ8n+pmNNrYrN6/mGXlBVpZ5/w1GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nUWIHxhYV3CeJWmryCqOuRnDG0w0thIZNBUg50YH8xHaPnMFVgBiYXTkjqlgx62Uj
	 S53bRcSCYFABwh2vM/6YhnHt9OpXAduSU1snR63rW0mUs+F18HMYHpjdz7YlmVLkR6
	 WrLIc2RVNeDTYGy8X+udhmhQaZEFqVUGxVwekpcDN24kQr0FWUMD6WRposlNUAVE32
	 Lg8UUax9/+4XK8am5S1cUaT96y7Ffmh3RTonxDfAbgiRNeOpa3xIjkuDuqarsdbS6G
	 +qzM32W2GqjodHX98QTVJ7o43ZWqDbJPRM57vPOaT7yEXoQXQkoVFJJjegzjllyIMP
	 yTo+20CVgtwUg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CA49B893FC;
 Mon, 18 Nov 2024 07:27:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911253;
 bh=FZpdWdNKPa8UE9QJ8n+pmNNrYrN6/mGXlBVpZ5/w1GE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lYuOYBhkkvtXHgeB/M6nkriZMbwli9UHDdnPn6U6HO+ktPW180vYa4a7sLCjuIYrU
 a8P07/1krJ/X1DqQ3JkINbbjGmjdUj8Kk/kPGw5dXysxhz5iHE8G1qp3zVYQChHUQR
 YU9uUH70IxX+uLt8N/wPDC8Fsx85Z/jpjpzC/54dRPbJnRczker08kZ9k5tR/KvDp+
 9AckiAoE2daWxjrm+wvuZMbb4/88ByJ9jx4W47WOkWJK5Ly/6Y0j6FCitNxtsNJlHw
 Wud5RjWeySj1Cmp/15lfL8R7kvT8WBC4/lwKZr8BZCExuVfliE26xuI3RfJc5zl5zf
 oNQe47zIAmkGg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/20] siemens: imximage.cfg: sync image names
Date: Mon, 18 Nov 2024 07:27:04 +0100
Message-Id: <20241118062715.32989-11-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

sync the image names in imximage.cfg with
the ones used in arch/arm/dts/imx8qxp-u-boot.dtsi

Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v1)

 board/siemens/capricorn/imximage.cfg | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/board/siemens/capricorn/imximage.cfg b/board/siemens/capricorn/imximage.cfg
index f73c5a7a9b0..7fd3fb8b72e 100644
--- a/board/siemens/capricorn/imximage.cfg
+++ b/board/siemens/capricorn/imximage.cfg
@@ -15,12 +15,18 @@ DCD_SKIP true
 
 /* SoC type IMX8QX */
 SOC_TYPE IMX8QX
-/* Append seco container image */
-APPEND ahab-container.img
+/*
+ * Append seco container image,
+ * use same name as in arch/arm/dts/imx8qxp-u-boot.dtsi
+ */
+APPEND mx8qxc0-ahab-container.img
 /* Create the 2nd container */
 CONTAINER
-/* Add scfw image with exec attribute */
-IMAGE SCU capricorn-scfw-tcm.bin
+/*
+ * Add scfw image with exec attribute
+ * use same name as in arch/arm/dts/imx8qxp-u-boot.dtsi
+ */
+IMAGE SCU mx8qx-mek-scfw-tcm.bin
 
 /* Add SPL image with exec attribute */
 IMAGE A35 spl/u-boot-spl.bin 0x00100000
-- 
2.20.1

