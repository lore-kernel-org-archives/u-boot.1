Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A1DC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EEBD40629;
	Thu,  6 Aug 2026 13:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S2lZ77s9p0ZR; Thu,  6 Aug 2026 13:05:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C30A140743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021518;
	bh=Y0RMLl1/1XG23Ygvl/G4fhKZsWHDGmGC8ZewjwyATeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SS81WVPx7AQ1f4HRGPA4EguddiTUKSE2vtZQXeYE867PnG0SDo8eIDwcfbixI9UTk
	 LWwLW9g48H1XeTAyuAT1Hl9ZMIdCDBy3hZxwdSNwpyodEi1DOUUJPvTS1CvRYZuNAq
	 8gR+quUbph9bHgKJQ7HYtYCQ2cAVDMmiW4NYG+Z0naolQspWWBzXY2SbmFdEWFzk8n
	 Ps0jkpOigQkPP3cdDYNnqWNpmGQQuTcDvs1bEB94m/KvO8xMwMwqW5mGwygUfuMPZA
	 2ef4bCMASzNTDvKY6CazFhwpnVWO+w6A7PcbcbqMkfjSsMfWhbxBSAjMdVW0seuATl
	 sB9geLUwxo6Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C30A140743;
	Thu,  6 Aug 2026 13:05:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E3A1198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 301C14059A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nuoly8PkNAW4 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:48:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3C43C4059E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C43C4059E
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C43C4059E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:04 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso1103148f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786020482; x=1786625282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y0RMLl1/1XG23Ygvl/G4fhKZsWHDGmGC8ZewjwyATeE=;
 b=gpOXtEVmnd9QQ3r5Q+OT9ISc/+lDk89t8bWoroOIpIzSL3sDbyfcjCE0NUX85aqvte
 vi6t5+zvI9I3TUM5WOPaRiwQv3J9VHQHJRNOocLPl5zagkQJpXHKU106RpbGUHP0nYEm
 Dqs1h8+WXXfWkR+ARX9SuJd5OxRNVOGIy1MmTuFwFR7uvWcwFEaeonf7+ygPYXTMZsVW
 gXs4Q5xEa0dbl7fpJRdthhB75nJd2vUZRBJg7OkG9jO2WmaaQaUR3gX84DWeNtx+nc3S
 cvWZJjFTtcYNr+IqfHf5T7TteG2+0IkgRu9jcBEKRc0EIa9fOZ2kQ9xMJ0YfOU+LrwSp
 RMpg==
X-Gm-Message-State: AOJu0YyOlbHCkE66YcFIV0LhbQks0T13BNSDyesNC87wtML3djZCF7/K
 P9Qd3CKtOCfjBfjF/y0dmV/czZ2TFdsVfmZqWMfvwr7ZnK6sTmEdruobrLcpjK7J
X-Gm-Gg: AR+sD12V5cRAbxUePLJB/js+25HHZsuGfvt9NnHSTcAkjN+brC4sE/Obe3I2EVJzmrB
 7UMQFcfGExQK1vWEKeZGKfrh1J9UfEVZq13g5/aKTt6crVxwVdQ2Lj0PJYZraEHQNOqkRRIw+yX
 I9xPESEFdCo4dPfg7QfulTqh4sEFICsXC8TacGy3Sxa517FM6GPssRCyUwwJAArBoHAFLMMZNdW
 fo6lcyTEJONnocT2y3XAomc3YgOsEBv4Qcy4O5gGwuYcHazWKTckg6uhm4A8DvnL+9Rgscfl3jt
 A3SwLRmQbAOTOJzopd8WdCaYG5vUsrvYyEBVOESqpMoSHyK0NDgDOl/grOaScfRKq4BuCkMz0/h
 HEelHlhOI21H+XJfdY/UfYrIYO8uF0M35iq6RJ3FZns1vrz+y20rsQfkkvpuDtuQ55h580RFXpy
 jE3Wl/U5QYLP47BTUTSDuOCbMrO9JEbTetP5kgbBIT+QAkPSMt5Jw8e4OF3hW7v859i3s=
X-Received: by 2002:a05:6000:290d:b0:47f:f42e:9715 with SMTP id
 ffacd0b85a97d-47ff42e974fmr11182201f8f.12.1786020482168; 
 Thu, 06 Aug 2026 05:48:02 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b183b2sm6662832f8f.24.2026.08.06.05.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:48:01 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 1/2] gpio: vybrid: read and write the GPIO block,
 not the PORT block
Date: Thu,  6 Aug 2026 14:47:59 +0200
Message-ID: <20260806124800.262013-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806124800.262013-1-mehmet.fide@gmail.com>
References: <20260806124800.262013-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786020482; x=1786625282;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y0RMLl1/1XG23Ygvl/G4fhKZsWHDGmGC8ZewjwyATeE=;
 b=bdg0MHbCnah03kovZs/2k14v0UkyFJEA0sasUrHQMSb7b8xh9yzAc/GM1Obw7w0lGd
 4nib9j4B0oW4TDwb5yS4tui8Uqvy29g4CuIskxpQ9sWtmcsf/dAM1dCMnRaVt6s6VBc1
 Ty9wGnh9NzGq8fLfTBR54/onKlebxllFQf8OPBNrny/ZQGTGcBGyb1cYm7nLNc4YBhjg
 utkeFAYoDa3KTbLpV60tkEtSl+oR/QR6W3OLhv0ig2H0r+HyIcdQaR5V3JojqmU3EYgn
 F/3G7sy+NVMZvviLNCYlwbsQXcTBt8dbEA8ba8m7q3OUgx3f9TlJrRQ2gj1kRaZxR5O9
 PieQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bdg0MHbC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The Vybrid GPIO node describes two register ranges: the PORT block, which
holds the pin control and interrupt registers, and the GPIO block, which
holds the registers this driver touches (PDOR, PSOR, PCOR, PTOR, PDIR):

	gpio0: gpio@40049000 {
		compatible = "fsl,vf610-gpio";
		reg = <0x40049000 0x1000 0x400ff000 0x40>;

vybrid_gpio_odata_to_plat() takes the first range, so every set, clear and
read goes to the PORT block: an output never changes level, an input
returns a pin control register, and the write lands on the pin control
register of an unrelated pad. The gpio command reports success either way.

The direction is not affected. imx_iomux_gpio_set_direction() applies
IOMUXC itself, so a pin requested as an output is driven, but always to
the reset value of PDOR.

The single range device tree this driver was written against described the
GPIO block alone:

	gpio1: gpio@400ff000 {
		compatible = "fsl,vf610-gpio";
		reg = <0x400ff000 0x40>;

so the first range was the right one until the device trees were
synchronised with Linux. Take the second range when the node has one and
keep the first as the fallback, which is what the Linux driver does for the
single range imx7ulp binding.

Tested on a Colibri VF50: with the fix "gpio set 50" sets bit 18 of PDOR in
the GPIO block at 0x400ff040 and the pin drives its load, and the display
reset and backlight lines the board wires to GPIOs work again. Without it
the register never changes.

Fixes: e8a9521e649f ("vf500/vf610: synchronise device trees with linux")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/gpio/vybrid_gpio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/vybrid_gpio.c b/drivers/gpio/vybrid_gpio.c
index 5b4bba96da7..3d2e16e8ef3 100644
--- a/drivers/gpio/vybrid_gpio.c
+++ b/drivers/gpio/vybrid_gpio.c
@@ -109,7 +109,13 @@ static int vybrid_gpio_odata_to_plat(struct udevice *dev)
 	struct vybrid_gpio_plat *plat = dev_get_plat(dev);
 	fdt_addr_t base_addr;
 
-	base_addr = dev_read_addr(dev);
+	/*
+	 * The first reg range is the PORT block (pin control), the second one
+	 * the GPIO block this driver reads and writes.
+	 */
+	base_addr = dev_read_addr_index(dev, 1);
+	if (base_addr == FDT_ADDR_T_NONE)
+		base_addr = dev_read_addr(dev);
 	if (base_addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-- 
2.54.0

