Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DACEF46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 17:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8616283EC6;
	Mon,  6 Apr 2026 19:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YihVF0Nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DE483F98; Mon,  6 Apr 2026 19:13:50 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A940A83C2B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 19:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso522480166b.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775495628; cv=none;
 d=google.com; s=arc-20240605;
 b=k1HB3QYU+gkG4OQmcLYfbQ4sjr7ojtz5yX1oAf00k+oRWs0F2zFOPLBMgVDwOJ5/hD
 yynOxIhqn6BUbAOSYTdAFbEOguqZ5k8EMQ0H4X7TVW84XpKvV3ltx2ozPQg2qrkXTAK/
 xCKU000dmCUw40IAdkDiGzkqIK+8wtuszqwWac1TZdr9b0g14xC+lcPwH1YDOjMPXLTA
 LRaKShIevbftTkfa5RQzzJU8QQK2tWvoo0l/TAl1VtrRnvJcjAldjOXLhTvxICgSSZgI
 TVx/iL+K1+1Y2CQdmcgYXTq7S4kFP7tQBQCVi/OFAWjlbTIGt+a425FlnVdU9O5KO2+Y
 bVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+0EjFyjrf2S4/z+p2e1DJ6KQGmDX64qZmdasf2o1D5A=;
 fh=ogW//3OKe2Aeg9xakE0UGGJqt/gZlhyG8skxLfqDLJg=;
 b=SWoOUFLifU7bbIjsK+tEtBKgH2KUzNBqbo0S5qestMpkpH6QVrft6jV9Fj3buW2n8p
 PlXPsqeSbnLPfY+syWZpZZnfmElFWX9CPodf9SJUgFDsUYRx80UKWyt+ylr/XDYm1OQ7
 Z/Dop/bf/f3FyuRPqJvKtmL4ZJ5XVEGjyG6aS8vhxlUVZ+H+48VLg4rjXNtk+CCoSrpv
 YpiK3o69itL5UAj2ainls/YDwiPZsaD1GDlGlyx8b8HFiP4I5E8QawOSFaUZ8i2ebCoT
 Ols+4Udi2bEHkegz1vh+I9fj9pRWX9jyK1cQDpqRkxsUxPtQ3XlwqtS8KH5GLDyIxOuF
 kIXg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775495628; x=1776100428; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+0EjFyjrf2S4/z+p2e1DJ6KQGmDX64qZmdasf2o1D5A=;
 b=YihVF0NzUsx+iR//l9tQfY7INenyd8WAlEnM3T1Ze3sX2bRVbv7/mHgqD/c/6zegeZ
 fbIngD6x+Gyk6EpSq0b3m8qffwht4bxnKtSiiNgt0+voQMfT/1L+HR72a6RHixNEp6wt
 OakuQcySQXAmpTenLy3dlbw5vBRkZEnIWYJU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775495628; x=1776100428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0EjFyjrf2S4/z+p2e1DJ6KQGmDX64qZmdasf2o1D5A=;
 b=ZTtyVPlshzcYj0AuNJDa1nZrx/LhciL80DJMYH8ard07mRrBMwOJ0bcC7/2aHSH4cU
 hic6A8jJjPWmrjH2dPbxAgmzVEDNbrB7xu7hFjmhEsKEavLDdiAegD9wKB9T9AqoAp4g
 OW6BqQWbLw7BD5D3vr6pGx5XvAmOukb7o/+hJWB9Yp1IAIfAN1WD05EQ4zbIWYZXmp2T
 bLqZX8gtd4qdTlYcnDhqvNCmTFaj1XqAWzxrY6bvSpciaIQ/hgh93AE3WoJuui7Do45t
 ME1DPZgRMtNa2uWWkFIzmoZ9y6i2iMIctia4kUH/IKhIY7+eNQJj6TK/zaJCt0+oJbaY
 vX1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcxSoIdA5edxV6q+HYuSd0+vXk6fRWv++YGt41HPfTRWLR9lDsrgb14/cqvSsJ9Ful8m+nWAo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb0kREeE/i7eROv50xLmLZlBAqY27JTO76LBYzqX+yuXxjZLAp
 sHgpV9WkEgj7dPww8HmyYdhy6kKOtrImXhsWUzDxEdvBDca92zz2oYNPGWgIIYRfsuhf2ztFS44
 MnyUCGZjbtIm9RysvX+Xstok65oZqIcWVPlFQlqZS
X-Gm-Gg: AeBDietoFOucUY3TVXfJk9p1xR2M+SGJ6MiMVkV3+Bdg5IRXUxCeIgcz2J4EEnprlPr
 /bpkkrNFNda9GEqkHmOgToqRWVeciJGI+xOI0wkI4vH63AaWxPX86ray6x8nPBCN/3zaipfpf8g
 dsjkYUsWA4/sdr34sXrAgimf9u0XL2kSIy0wfjDJJqub9mRyWtIR+WY4W4sJ6M/RedZCf1w6TiK
 U0c0W+zjeyrj2DPR4zJHID1/27EJ399F1+FCZxK7y9GxqBWsXxTs9D/KS2s9Zp3fcxlYNfAFyOM
 QilpDQ==
X-Received: by 2002:a17:907:1c9b:b0:b98:1129:52 with SMTP id
 a640c23a62f3a-b9c677fbd30mr646809866b.28.1775495627944; Mon, 06 Apr 2026
 10:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
 <20260403135205.26979-5-ansuelsmth@gmail.com>
In-Reply-To: <20260403135205.26979-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 11:13:35 -0600
X-Gm-Features: AQROBzA4zyt7H2lId7wxJH11b5cn1vkN4PRUSe259_Jeg_xW8B93WVsC0Ue9qWk
Message-ID: <CAFLszTgw3B7rzMWCwzP6YBn7HGX2QRkkZt8waBgZ8qxTrCiUVw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] misc: fw_loader: implement request_firmware_size()
 OP
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Justin Klaassen <justin@tidylabs.net>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-04-03T13:51:57, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement request_firmware_size() OP
>
> It might be useful to get the firmware size before reading it to allocate
> the correct size. This is needed for case where the firmware size change
> across different firmware version and is not always the same. In such case
> the only way to handle this scenario is to allocate a big-enough buffer to
> read the firmware.
>
> To better handle this, introduce the request_firmware_size() OP to get the
> firmware size before reading it. This way proper buffer can be allocated
> and dynamic firmware size can be better supported.
>
> FS loader is updated to handle the new .get_size() handler.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> @@ -122,6 +115,28 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
> +static int __fw_get_filesystem_firmware_prepare(struct udevice *dev)

Please can you avoid double-underscore prefix for static functions?
Something like fw_fs_prepare() would be cleaner.

> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> @@ -143,9 +158,43 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
> +     firmwarep = dev_get_priv(dev);
> +     if (!firmwarep) {
> +             ret = -ENOMEM;
> +             goto out;
> +     }

This cannot happen, since driver model ensures the priv data exists.

Also how about using 'priv' as the variable name? We normally use a
'p' suffix to indicate a parameter which returns a value.

> diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
> @@ -174,3 +174,23 @@ int request_firmware_into_buf(struct udevice *dev,
> +int request_firmware_size(struct udevice *dev, const char *name)
> +{

The function needs a kerneldoc comment in the implementation.

Regards,
Simon
