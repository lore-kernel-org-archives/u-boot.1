Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72623CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104DE848EE;
	Mon,  1 Jun 2026 23:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QkqgEWCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E165984931; Mon,  1 Jun 2026 23:16:30 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1276084894
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bebac79fff8so219549066b.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 14:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780348588; cv=none;
 d=google.com; s=arc-20240605;
 b=fkxvmRsIzrGBvFu8nDLh0ZCmrLi1/D09hNAv7ebab5DEvI9VzBSHYG1lNvJrWm9XNV
 WDJt9evFiv64VtiqQVAtat9JqQYdk7Xwo3EBimrAeNfw0HpS2CoqoidHkUrez6Ahhw5c
 9kdcBZe8DBPgAJfeJ7RZLwYB0ZYLNkI5HyzQs56QFAUWn5Bp1F9soxllcu2qbGRdKJbX
 Kc4qLrd2phxOQGJvOVJsAIejCaK4IYe9CVaCCFqJyQCzw61+2sBa3pGN0vWs0i4tDK2+
 4HTSBblVZZNyr3SCDeI0yF3nTVeJD7iacez2RWYT+EZKpGy+ls0kTfMUNwHGSfI/zwtl
 y8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IXSmP+LuCsbNxu0wqBFPGAHZwp4i3l2h5oLqV2RzJbA=;
 fh=OMmYmy4pRava9ReZmkDbHlpm1+MNvlesKKTVPKd7JfI=;
 b=AjLg0rGp3eEJnDUCueUnjLgwri34jcLWb1D4S2zDVCR0pafkuIfeysBtCIPF5gFBkU
 +OgP0cVwc1Yhy7mVxZMHXOHCf89PXzPtwhv9tBkBZ9WMXADUFACUf+MqS0Y4/huIHFZp
 j+Z7Isgr+BtriPvmOZEDCTvRufJoMGdQ9dBSBcy1FRCPPyNQKDVuRVnPc+cHiPXzK27F
 S0bkDmV6tq6051VU/dwcoaLgXu0HA0xne5Yw4T2CG8FsUWnD3zGxqh/Mdu5VMmoa4xQm
 2I/8Q4mF6FmPRyf8LAnWLjg+bVFc2zSbbqK6iAVC0yKbuH+zZxuNtTDZ1b9mMw54EF5N
 k+Wg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780348588; x=1780953388; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IXSmP+LuCsbNxu0wqBFPGAHZwp4i3l2h5oLqV2RzJbA=;
 b=QkqgEWCenoeEqG4JY2VSF0/2H2OdswusgjE4I7zoka/PpG7kGPKJh7Mahb9V45Amjy
 UrNUE3plU+hRouoeIpFW3lf5+S6264zptvs2ABRkN0q6fnJOHuOfV/mPSUkYwOaUNjHT
 thcU9ljl1ZOVCcXoz74tNwPVMLSs/iG/Jq7n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348588; x=1780953388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXSmP+LuCsbNxu0wqBFPGAHZwp4i3l2h5oLqV2RzJbA=;
 b=G/hhCd/8Ex0BVDmNNqza4IsW4kO8GOarZYw94rv118rG6Dx+87lrMnaYsUHY51cM2x
 ugwfWvfK0QQTpkEhvjrJWJszDcrv0GUbk7Ip1Qu5V5uM2enVYZpRK6KD5K5Vr/cMludA
 PutX0my3jZYFootkWxk4IthC3qcXJDiSg8u1UTlJYhZJqsHH/3/2OYijBIHBQuUAllja
 LWlZdJj2nBBdQKuudR0w42JuzXy9u1AO8aeUXgvMT8TrrCLwtMfstmdynoK+pmLkZeKo
 rqA7jEuK8Nsow9OUq+VaLyAbFF61d+2b3tuPpAsoujXyhOCdzJubZtOPrkTnrU3/thzO
 6NxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9c3Kr/MXzcOYgwBPVHWGN+BrJ6A2lzMaIIVkl/4X7cIUYwDkv31tUWjW1EgdWJg5CdxJrFtSM=@lists.denx.de
X-Gm-Message-State: AOJu0YxO6JZNJjTgR3JhB+hE9i3Io7K2LgvY5gAbnIliZuinBKyBFNXr
 vIrK/HyUlCN3PaP+phCkcJZ239pG5muOxfAblird2pTBWy3oueKmDKFaWpYpeoLa1hiM0Avyrcf
 KP2iYAAAaBI+8QrrDECIMWsosiExAHrdqI7dwwKI4
X-Gm-Gg: Acq92OErBJFXiOZtndXgtv2+tGIsj6aFq8yduLzkX0IFbQFpY3I/1eQU8jLCyJCUrc9
 +DwWOMlOLBA2Eq0kWOaxmhbbqeceja3OP+6GmqcMBZNbtWBbJ6wtwev8qFgScAQt+CmsR/ZPyUg
 XzVZiMDwkj+6vB4ZmKdBnrN4hdv5ygVGr6V/fWYQJRnS8gtENu1rE4qi+cALO/KzgZbH8AbO9v+
 FF4cNTVS2dbRBNRosvqGOzREFUaZhdISSPd6yVVTW7bP5ZUMIRbh1l0zq9tR3uzx8IO7y8hE90I
 GJj+VxoG71FZGT0k
X-Received: by 2002:a17:906:3097:b0:bef:30a1:8c52 with SMTP id
 a640c23a62f3a-bef30a1a3aemr20953266b.46.1780348588527; Mon, 01 Jun 2026
 14:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
 <20260527095123.50797-7-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260527095123.50797-7-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 15:16:13 -0600
X-Gm-Features: AVHnY4LtkgESnAhd7BiA8f020Apa4y6PcNaMHvz9pkF6fMX6Km_su7Yn3Uf_wtM
Message-ID: <CAFLszTjPzjmgvw8h5mYf4YE++j5zc1StzaxVftqLOFQyprncOQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] arm: dts: tqma7: integrate tq,
 eeprom sysinfo driver
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-27T09:51:17, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> arm: dts: tqma7: integrate tq,eeprom sysinfo driver
>
> Add sysinfo node for tq,eeprom sysinfo driver.
>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
