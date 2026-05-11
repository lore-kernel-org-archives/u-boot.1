Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6CACD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026E8803C6;
	Mon, 11 May 2026 14:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qsfFwkJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE2481E18; Mon, 11 May 2026 14:42:31 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F58800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd0209f25c1so119313866b.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778503349; x=1779108149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbZ/SZn+CeCWTYxyn3i5XppYRtQvKpYYuerUpWAHLa4=;
 b=qsfFwkJDHcCRZwZDTWF2+180E7QxMZWi1LVIWOeck+6192YmnABJWCVyA13IKf0yvV
 GA0iMBCx/cOUBLykTdTrSOGgjLx9UCvD1e3YZkuy/1a0KZN2hBdMEKI1CqgusuvrDr8L
 s9iJrPPb6x9AZ2gokyKZ+Jf7KokkT2dXoRNYhSp4TbuPOcB98iSL0c1feeyTAZQIdNl4
 wvJknd4XR6hLloifzDH924dWNj098g6OlkXwjJpEOpRHGkZf/Lq7X++CWdJTFVcB+ygA
 Opc9Qr/6ZCdGyj5JyWm+0085tzMHDIAO7kEWoBFdDmViXKFApZoiheN1MqJR8/J5xB/a
 2X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778503349; x=1779108149;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sbZ/SZn+CeCWTYxyn3i5XppYRtQvKpYYuerUpWAHLa4=;
 b=Ktup7wEZ2qSHencfYetzsgL9JeENuLGNJ8zdfvbP5qyxSHpKjwXcDp4gs1iaAHA263
 r10idcNvOZx3Zqa1cIIHOzxNHibIaeHJ1Y2nq7yBl7tOkrTRih1dPDDtm5zEUOn0YjKw
 MQ14ILoaZUshFJANa37QTJ/fXDeRX3VAT49c0p6YlD6f02V9GAvPXUNn04M5+A2V7QFV
 4nR/SaGlmFm/pJ9ghv062yS4FY404g66RMBwZ6dcEI1BLao+gM4M5oNJXiSiqKn6G85x
 AJLbWuHz3iBp8GGwYxPGmc26Z1aAGIV2sQ6z/16pPhus05s64boOzhsMtQKkb7Pw4+y0
 njlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gxWuGUUURCroVkRSo5/ZkNAdalmTjDgVaLd71EpVvXLnGt48qmssAOnrxOuWqVjexavLaN5Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5VKj9CXrc0MeTBfBerAcpjq4LMI50V89RRZujAC3bJINxljFq
 cqvCXwqmzWuHHV6TzTReSXknGOfJUvqtVhu+0jaS38Lz4fRx0UDSeH/2NjXzs8MDOdg=
X-Gm-Gg: Acq92OGtYaVVER7gnUwDnF3N3nlFdaOWb20xHi0jAz/nsO5DOLW/EbmP4NKxrvStb1N
 3v+vSiqLvFaly+0RIBrwn8Alg2nh+NSne56IibVJOiLumrWcJCmmD3JFsdR7BTil3uErSWFCqLD
 JIQ4rTdKrp13lZVoYajcc21ZcL6iioVREe6FAWzzQFQS6GG/0eZEF7JJfbF6m6A+m/oY622rf5J
 hp/tedFaS9vfORcK2BdGH3XoB3oawaL6u9CK72xPTKKFOnxBi00rxr0GmquNBvsZKGTb41tFGn1
 zbAFyhVW+FDh73W2Gm9pkSQxYdAJ9y3BD+SGtmNwjfMsyZJjf2xinK28wSaln8+TcimWtp5fjab
 LiSg78p/lu0BVJpQcxNnfA+szbdRnUJx/DVtaPynsTAq/KFYsAdi6nnTs/w/GGKK/vTMHsNlBPU
 StS33xZXaMD5iHWYgbDGAMI2iNKSwvTtzrEdp5L+KlKZ1P48keDifU3QdI2L2MNQHVNk8L
X-Received: by 2002:a17:907:8689:b0:bce:b80d:2843 with SMTP id
 a640c23a62f3a-bceb80d33a7mr369573766b.32.1778503348585; 
 Mon, 11 May 2026 05:42:28 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcd54804fbbsm276627466b.46.2026.05.11.05.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 05:42:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Biswapriyo Nath <nathbappai@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
References: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
Subject: Re: [PATCH RFC 0/3] Add clk and pinctrl drivers for SM6125 SoC
Message-Id: <177850334735.2534315.15944891920559056602.b4-ty@b4>
Date: Mon, 11 May 2026 14:42:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Wed, 04 Feb 2026 16:10:51 +0000, Biswapriyo Nath wrote:
> This is still RFC because micro SD card does not work with u-boot but it
> works in Linux. I do not know how to troubleshoot the issue. Any pointers
> would be really helpful.
> 
> Changes:
> - Add sm6125 clock driver.
> - Enable sm6125 clock driver in qcom_defconfig.
> - Add sm6125 pinctrl driver.
> 
> [...]

Applied, thanks!

[1/3] clk/qcom: Add SM6125 clock driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ea85b6b00fac
[2/3] qcom_defconfig: Enable SM6125 clock driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f1338a45cb7c
[3/3] drivers: pinctrl: Add Qualcomm SM6125 TLMM driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/2cf1f2f6a490

Best regards,
-- 
// Casey (she/they)


