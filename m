Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E940DCCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 16:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E1483631;
	Tue, 21 Oct 2025 18:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vi8Viyk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1938E835B0; Tue, 21 Oct 2025 18:08:33 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144C5831D6
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 18:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-427091cd4fdso2807545f8f.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062910; x=1761667710; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FCxNb0JJPpYVoIqvS5xANIVhkrxRRB0itQwgMyFEQlI=;
 b=vi8Viyk6Iy01VTx8Di8TqSMqLyqTrLS6ttoCJV9dbeZNQiQoYIqFsEJ7UK4Od57gt4
 o7m4QkFd49YnmOLlw+DwW6kA83FzhuGnGKiggxnQk++lA9mNeBCLn7lmI/9RJbYgE+7W
 f/0zfRMFXORRTRaPu/+6JD4w2yHYhjdmVBw+DroqoZddIKZy9akTIK1ZARyV50BmJIHd
 iNc9AXBkBVan72HTVH0fVfZoqqxj3sS7NjE7O4SqLm3nhxOW9Dgop2nOQbZiVAiQsOQq
 vKyShUGefSWox6Rd2DT9d7PBr0kRbIIIcNVwoz59OpDwAoUGgz2EZvepAZ5eMw0Drj/h
 Pysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062910; x=1761667710;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCxNb0JJPpYVoIqvS5xANIVhkrxRRB0itQwgMyFEQlI=;
 b=FNnMxH1jywdK8cYTFyJ7uMWme5twYnldc171KcBU4rnt9FHeHhBa65QRPh9qBuUcQZ
 BfPcjbk0E6NYvz+CP2y5kzzajkIF+6iKthrCDvKuW7sAoZaviCdNrjxgmg4n71GuMj9w
 J/p1DJNAkEgQgIlg09mibtWRDKYu9e6t99f0tWgu6Y6FlHLK70737pBGAqyAxjehjF9C
 WaH3AEaeC9ZJChgWH2GQYfKWu8vNAdNPCYH9IaYD0sL3NgQLhLRQNuUxSFPqS0p9tXQY
 Zebud4aWk8RAPMEbvtSsgJDGJvV/fOMI23Kk9kZzC0yS+s8lrqXIdec8M1PYWVyH0iSo
 yzEQ==
X-Gm-Message-State: AOJu0Yy4L1W1R57McntQz51BB6LD6Vx8egHl+ZiCmtenMeDV+gmj5A12
 t8ORsAk6KVD20xNBISau5CiIgEUJf1tKPWVGlD9BGnnJDc9hsxosE37LZrfaOPfvJao=
X-Gm-Gg: ASbGncv8Gw6SDSEPs75zd8vnS+nPnjGdE7GPMoRyvEzSNMnfPO2HDaSlse6WIzq7cVD
 bg81L1O+gn2VC7zFZNONngaRx6yJNc9LYSPN2V/xo5Men6PUoK1KLkguqzyDJty5anVhuFzOujr
 6xwM8GRsALTNXL8JXxSruUxbajkc48TXPaqTxQDTGFgIBHYjBLw9zIVQMU7UvTkYJCnMMokhWpI
 oKDLcY8EiETzJuHR0+L3Wuk8Op8apefaV973ZP525NRmnZyhN123C8T6QosPDLQLrRJILqmrfOw
 XqP/jZNm+4HPRxkrjNe1bAUBQ4VjNm2M17ZFjA5IyHgrznMtFQPVYT79r6vWIT7s23vyYIbj0QN
 +tON/ici1xGrYF/luh0guWMtFblVCfYjg4ihAPls13f1jFdqfNXxUQkXoE8Nahjs0H/OPLT/1iw
 x0O9B8PWR5eKDHIXUeGEcIs8O4K+8=
X-Google-Smtp-Source: AGHT+IEDbRWbw5NJz975ee9A0T+FmObvT+lqbMBUe5hUdTgtUvHnEZ03KDTQSvEiJwvW73KD6f/4AQ==
X-Received: by 2002:a05:6000:2284:b0:425:75ab:cce5 with SMTP id
 ffacd0b85a97d-42704d14427mr13539035f8f.5.1761062910512; 
 Tue, 21 Oct 2025 09:08:30 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:ff54:533:2c9b:1f57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm20830245f8f.13.2025.10.21.09.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:08:30 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 21 Oct 2025 17:08:26 +0100
Subject: [PATCH 2/6] mmc: fsl_esdhc_imx: Cannot test unsigned to be < 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-clk_funcs-v1-2-acf51a40eea7@linaro.org>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
In-Reply-To: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Schocher <hs@nabladev.com>, 
 Jim Liu <JJLIU0@nuvoton.com>, Stanley Chu <yschu@nuvoton.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Testing an unisgned member of a struct to be <= 0 will only detect the
case when it is 0. So correct this error test to a working version that
will behave as expected.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/fsl_esdhc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 926113f79d363a3e69bcb3ca46fb8fb3c2178e91..7dc76563b7e43f692d709a299e006ed0e2d6f3b7 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1543,7 +1543,7 @@ static int fsl_esdhc_probe(struct udevice *dev)
 	init_clk_usdhc(dev_seq(dev));
 
 	priv->sdhc_clk = mxc_get_clock(MXC_ESDHC_CLK + dev_seq(dev));
-	if (priv->sdhc_clk <= 0) {
+	if (!priv->sdhc_clk || IS_ERR_VALUE(priv->sdhc_clk)) {
 		dev_err(dev, "Unable to get clk for %s\n", dev->name);
 		return -EINVAL;
 	}

-- 
2.47.3

