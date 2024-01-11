Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEB9C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 11:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9A2878B1;
	Thu, 11 Jan 2024 12:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704971196;
	bh=mgRxb0Ute1IXcajlj0ojnGJBNZ1gN923FB5s8DpW6U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fByALXq/Q6YOYHs2vlHSle0s6soc61cHqLN5FyrwXunupbTMW5SlryaXYr2jJ+6YQ
	 paGkAe2EB+wNbYIo8883rKhBgvBq9OGwEbvb4+5KU1suh4pcYNlIhtSYsGOQ7MfQf7
	 ubJFtJyGw6GP8c4edvhNuvKuq6XjRzetNovJ0AzBwMQ/buapKlw7TeryifZMHViFYb
	 EeloA2He72Y18URpHt4iPT308DqWSxIfHLoU+YSiBU0kT8Kt048oq81ik3/Dv6nN+0
	 DwEi8UlnuaNNQcSjOHpUkVjdLURmHPxO41ICSE2rhfMMgP4boDbvIpjbivwb8k4Hff
	 zxWV2J4GPiUSA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 510A9878B1;
 Thu, 11 Jan 2024 12:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704971193;
 bh=mgRxb0Ute1IXcajlj0ojnGJBNZ1gN923FB5s8DpW6U8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U7u4bQikFuqo7NBxV025Ti9wPPEaqDiBoIcnnZbrfize5LO2+0bD4AnPRTxgzR0wc
 pNZ8RKzu9DEO14tlVb5GEZsvi3+E33yzl9RA5RtJhurgSiTkEH+cRILCIgIJ0Xu2OS
 V65xpIxlZUVXmJees/YUaaXrZ8BiHiPe+2Fp6ClVajphnHCf9fdzvM4UN5hZOvUgfM
 LGFutWG/OqDlMXZbOpSqucrWq+23MZjZ1lHs0UP1bxQrYY0yAjxCKBFVvpCPJ+n5Rg
 L2pq5sFgkt/1xmD9oInbjWxtALorXzECg8wlxSoRfPdPOxxnnCWv7dUpWAIPunLnzB
 H33VQ6hAVNVkQ==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 NXP u-boot <uboot-imx@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/3] arm: config: Enable CRC8 support in SPL on imx287 XEA
 board
Date: Thu, 11 Jan 2024 12:06:10 +0100
Message-Id: <20240111110611.2051821-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111110611.2051821-1-lukma@denx.de>
References: <20240111110611.2051821-1-lukma@denx.de>
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

The boot0/1 feature uses simple CRC8 to check (in SPL) if
SPI-NOR content is not corrupted, hence the need to enable
it.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

(no changes since v1)

 configs/imx28_xea_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index c1b0487f7e..64a0561a34 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -123,4 +123,5 @@ CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MXS_SPI=y
+CONFIG_SPL_CRC8=y
 # CONFIG_SPL_OF_LIBFDT is not set
-- 
2.39.2

