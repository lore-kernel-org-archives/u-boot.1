Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE6EC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C97875A4;
	Mon, 15 Jan 2024 14:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705326721;
	bh=PrjkoXv+vwSXZpQ1VjdDiM+qC/qWMJWDolcPau6PQws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g0y45GamT+5rCxYI7jdJE6eCfb+4XD/Q/X837R1KxfQFoklfXZUwvccwvFoojK1iZ
	 wn1o6X6bKRkr5+f3la0BaevrCZjiJdx2PCtPxtNEqaJwgP4G3SCpTiFIKnVc1hfORE
	 dg2QVzysyYWRaFJAt46sKzGYYgSEyFiStsY/yXj9wo01gMYyA3GqqcOg0JxLN1G/n8
	 Zw8WgMLJ9aM2ZLxVQ4n7FGuGm3XIU9QzW/giTOPnVgQQkEXZ36c364Vw8Tg3eAJZYb
	 9atzSJ1Mm92lW9CAOz12QAA/VYcCZoatb20RPydx9ib12csRyGLTcqHSqd8TZJCtG0
	 J9czrwY2e9acA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C62D686EF1;
 Mon, 15 Jan 2024 14:51:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705326720;
 bh=PrjkoXv+vwSXZpQ1VjdDiM+qC/qWMJWDolcPau6PQws=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TxJ7DvSn457wZRXlXcDPBoi1JWCWk6NeoEtN5j2BFOioxnekacmChvKqBuxeqZ4yH
 NuX7Dgvast9kb8Qljk2iZaVphn4UV0SjtgNpje+HBrE1z1sgx/xZlQWyBJJhr3ftIY
 o+jxq0s8gU9J3EoYmx2lQ+ekfmmiRFuu6E3DS4o3466Dg0bm2SodaKFVlvoTqUQAIr
 xONUXdHJWQhlB5rQG7sW2zax1ESchYQonYcBL1KMnb26Kk/i3WAtpe93A0XWGNdv0b
 df0cuTuMAvnEwb2Zg94QHubeSkVPPa+WtNhbRMqeuBbuY0jTgnQfPx409AMqGsM7O3
 J7JML309RTYRg==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 NXP u-boot <uboot-imx@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/3] arm: config: Enable CRC8 support in SPL on imx287 XEA
 board
Date: Mon, 15 Jan 2024 14:51:29 +0100
Message-Id: <20240115135130.2789123-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115135130.2789123-1-lukma@denx.de>
References: <20240115135130.2789123-1-lukma@denx.de>
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

Changes in v3:
- None

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

