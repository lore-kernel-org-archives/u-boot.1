Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F86CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F41484659;
	Wed, 27 May 2026 03:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bBr2dEPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03247848EE; Tue, 26 May 2026 23:29:14 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D52D848D8
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 23:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.fardjoume@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-672645dbfeaso13695087a12.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779830951; cv=none;
 d=google.com; s=arc-20240605;
 b=ZlONm2O4tIlV0mqv61bDkEAgwR69JKXJJcYTd0VpKJFDrSd1iJXhMRQrRr4t8o1woy
 YvipjLUXEW15tCapPgsr8d88q9NTdQfRAxrw4xovQkq5x43vYj0taxm7NG4XR4Z/3uLQ
 +x9LQYf728pvROVfoJCCw+1xGMH29vhi1CVpRvZStajFWdJUF96pv7l5PpK1ZJBw1PfR
 RjnhgvnABTuXPFEab3hgmIUyKj3kbrlQnZTWnEukn4Sp7Sf+NE9de4OPqXL/6IqsoXIQ
 GrmoAJzArnpR7PEm+VbiclRkqsdAdaMx9nC6bSUDt32i8d69vvdQTnBTDD2MOLFJ4Qet
 Inuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=fGEMpM4AMka/prriDlDc0uXLTvNwp6k/JNHApZU6oug=;
 fh=ltf7oQj+eZVnCkvY31RgM6/jlYdbL6i2CcJqEoEx+Ag=;
 b=MpJelC+vTRGqAoVb1euq0/DBeOcMtY8ceAkp75cWDE6z/1QwCX+gnyyUZGdUW/F9vZ
 jn/WTPSkSYbj2HHDeZy6Dqb3GmAdb94uzMId5POj4+c2euoTLfHpPRWpVfeQYa4VCl9Z
 Fv4XRtybvBR+pVgRtIKV4Sb2kiak8X1IM5qMkJl3rgu1p5e+VeJlfoH6nldRpCT4p4fh
 nBpCez135mRS///IwtbD78IZPMtKUVCKpM5db1C66D6a2kddqQHIVB1t175y3L7pj5lN
 g2S2OGMBQJTDYYph6ShW1jFyhZQamXUif29pnz/2h+vrxR/3M+Nwm8CHmzT+Ct7PThFz
 D/rQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779830951; x=1780435751; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fGEMpM4AMka/prriDlDc0uXLTvNwp6k/JNHApZU6oug=;
 b=bBr2dEPx0Q2qsyE9iImFlNq6TJefUiPpniw7JvlNFW9q4/2uuKnSBAzSFDFHlSN991
 nMyKwCBK2iFgQW1stzvo+w3v9vv0vJWdLWI0AiPf/ExnCdE1bo/If4AQ+xRS53GNT/Ex
 lrLUSHGMq0AuqFjQ6d5HbqnBU9BtSJ0tqqF/IcQbnyJrVJNSnDJ64Dhnc0vga1DJ1pyh
 6r0uclA+3VM9JEfORGy/C3E49TIDAr/0P52ddU0SkhehjwYoGpvMAkAY95ty5YMIyzqp
 npk5wfjHVwR7Lf/HSREsMvVx+Yl39OxzIHWmq0VChomKCrS0qxxUyR9OtZUgyfWZsIvR
 pogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779830951; x=1780435751;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fGEMpM4AMka/prriDlDc0uXLTvNwp6k/JNHApZU6oug=;
 b=sf1Bxaw+ZGSY3Z50UrGvU6XX0b2iAX8Y80FBtROudevh2l291eiVh4P4ldH+5TbZ4G
 UiuQguj3k8fGYCOYdmPAGouKd7Yf0XagfMYyJ0MmwLi09yzNHft0JC1pyADwN+4KZ41d
 N81DdUw3/ZsdQyAmqM2ErQaxdGd63ePM818ytJ/BvFuQDS0iWn1PXD7qCES54rVpDCY7
 UoKeAbsMo5fhAK1318xHFn/xL+qfbqatcaAga9A89LIuF9Asn65b6YCOrORS7Sb53Xgo
 c7YEbU2JLdXz31xtcOaS1zNKrP/YnvRLvNSO9tedT2FRG1pQB2203qdA7Ogn2bDF3L5S
 qFcw==
X-Gm-Message-State: AOJu0Yz4jzZnCECmDkkNqTxf4rCcMZbfnaMm8T5VlVwS/yMQs/2IPv8Z
 FJYFtJOhGsTSt+wSCnYDG9x48LkcSiSNK5TFacos4waJaW1E9z/AQqWjVmIHhN1d8zmZdY8SOQb
 kZGmTDq9hT29ERoK5f6tou7r4vxd43OtNWDO2
X-Gm-Gg: Acq92OG7mRnoWjt94uKA8iUi8immIkFXgJ1t4WjtpnmhERym+TQHE23QmbrtTMxBcN7
 mkTbOebRzY4vjeXah2hQ2qeVsjS/LvcTC3dH0d3KwetPHNiZNUpRLsXfJZnAs3d7RX5eYNM0hck
 XPIn5HnMqO3k36d4ue/OBQFp25YYpUmMOBFVcDHEsPs3/xIorLQluMl8GZDv677BlnFRppznmI3
 l1jEYPzJka22BvOtfAsG+7we6LFoX5NSwzoT22MlFoC39gz/+N+Hk4xQVHPJ4DH+gPMEQI1HyP4
 hdWH/yXO
X-Received: by 2002:a17:907:3e87:b0:be2:36d7:573b with SMTP id
 a640c23a62f3a-be236d757b1mr434706366b.12.1779830951315; Tue, 26 May 2026
 14:29:11 -0700 (PDT)
MIME-Version: 1.0
From: Omar Ivan Fardjoume <ivan.fardjoume@gmail.com>
Date: Tue, 26 May 2026 18:28:59 -0300
X-Gm-Features: AVHnY4JbzXOyCewaqKA11maWlcUCdthbZwvCrD6QF23dgKubCwbmPkd0BUq4YF4
Message-ID: <CAM+fx6Ny0ncWr=6nxTWpy_VpaRj-R4pkU_fNcVEdK-B35O4GSg@mail.gmail.com>
Subject: PATCH mmc: sunxi: fix MACH_SUN9I typo in get_mclk_offset()
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 27 May 2026 03:18:29 +0200
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

Hi, first thanks for everything you do.
I was working on reviving a cubieboard4 a80 board and I found and fix
two issues that prevented eMMC from working on sun9i-A80 boards:
1. The get_mclk_offset() function used the non-existent Kconfig symbol
   CONFIG_MACH_SUN9I_A80 instead of CONFIG_MACH_SUN9I, causing the
   MMC2 clock register to be written at 0x06000090 instead of
   0x06000418. This corrupted the CMD2 response and made eMMC
   completely unresponsive.
2. The legacy (SPL) sunxi_mmc_init() did not include CONFIG_MACH_SUN9I
   in the 8-bit bus width condition, so MMC2 (eMMC) would only use
   4-bit mode in the SPL, which is insufficient for reliable boot.
Tested on a Cubieboard4 A80: with both fixes, SPL loads U-Boot proper
and boots Debian 12 from eMMC with no SD card present.
Signed-off-by: Omar Ivan Fardjoume <ivan.fardjoume@email.com>
---
 drivers/mmc/sunxi_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 4c5fbf8960f..3d5e7c1a234 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -546,7 +546,7 @@ struct mmc *sunxi_mmc_init(int sdc_no)
  cfg->voltages = MMC_VDD_32_33 | MMC_VDD_33_34;
  cfg->host_caps = MMC_MODE_4BIT;

- if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
+ if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I)
|| IS_ENABLED(CONFIG_MACH_SUN9I) ||
      IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
IS_ENABLED(CONFIG_MACH_SUN55I_A523)) &&
      (sdc_no == 2))
  cfg->host_caps = MMC_MODE_8BIT;
@@ -663,7 +663,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {

 static unsigned get_mclk_offset(void)
 {
- if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
+ if (IS_ENABLED(CONFIG_MACH_SUN9I))
  return 0x410;

  if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
