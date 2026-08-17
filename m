Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6061FC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0F9C40765;
	Mon, 17 Aug 2026 16:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uN3buOD2w45P; Mon, 17 Aug 2026 16:24:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 061D74064F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786983856;
	bh=3PN4wrcu27sxkJCiRCgDJHCdjsIncJYK5wf3DV/rWJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BJ4KEKdQlKxCiU7QtYwz4Os7EssKgXp8+gA6eKlL0qcJbY4OyGJX+h0QtG8+2vzl+
	 Eywsf6OffUU8YGkv6BpdRUuRQwiu/QhG9mCh8kCAw9uVAzL7pX3jMFUEtxuLO6rVN3
	 2N66lVQrZxN9f7zbd/zi77JUeZovYlIsJ38JWnBIoc79bIBfAQ9WoVTF+ssb66ov51
	 BG46PYDWp9fZFBogdj38TfteKN5WiTQaDtEu/MOOkxnNkeQiLQyMIeNbGkNLvBptS1
	 VVmnlJG2q7O1eaLkV57AOQYCFXDnLhQl9+38nhC3LyUbFgXhEcpYxrhZgHY5OXH3pO
	 INtxpvoMF4IfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 061D74064F;
	Mon, 17 Aug 2026 16:24:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F088194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00D5A607A9
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytRO9B6Zq5xv for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:24:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0AF8660792
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AF8660792
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GhAWgBEG
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AF8660792
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:24:12 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-476a130c138so3760664f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786983851; x=1787588651;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3PN4wrcu27sxkJCiRCgDJHCdjsIncJYK5wf3DV/rWJA=;
 b=GhAWgBEG/Fi7RUBycMXh9+6B9bU6iBZrW8i66bjE6Nl1SPLDXPECunh4vNNHolKOj3
 wOBl+z2pBGFhGk4WeTIhtF1a6iGEcZKRj4EEiRNKvEy9wZjgz9sUblH/O8q8HtMnOHJ4
 78KQSOAYx/BPnV+rh2F2VYpHnjJ/KwI9b5tFIN0H8ySlWDy4EzifNGIz1KU4SQGItVmQ
 yYEnv/V9YbYeUxOOTmOR2pzOIUMWDPSn+T6rjXMoRDemRFQAJ1/k5jE8/vl4q00TNmkS
 0IOrur5Pe7AbqGpFAeF8yS4KjTFROU39SdYuNVFk7ZVezeDqv81fgplb7i+q4gFEI1O8
 gWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786983851; x=1787588651;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3PN4wrcu27sxkJCiRCgDJHCdjsIncJYK5wf3DV/rWJA=;
 b=clhVq8+zXIsLM8fMDocVqCENaVSex+XCO9OM1ZDdSsn1mn1cvhHZKzyybh5lDYycgH
 jeQhNPTJettBuMVLkaI8g3gHmnDKX6cA2ju3RsnBl/8KRcnjqXrd7KBVROmXW3QBqSVq
 SMn9bWwsiocktE0IFX5ruJ2mcH9QvzFGtMDG3oIkeb/tooX7X+RZhflfnJZ6IzOmUuhT
 9B9mPbUnlPrsVJt8bjsEW6fNbEZ64PwvEzQmcNqJCBwVqjFFq3aFNvROm++lnO6WGUGx
 F+i6w9GQ5mc/8/EQAy5Y98AWJi5lALSHkPgCUD6Wf195v3Ntyt7t9Wd+WTu2j/N/RKyt
 vRWA==
X-Gm-Message-State: AOJu0YxZSyiKiVh5By4e1uDTEpTzbY/k16HkJ6f4ll81MEVNnS1SzwqB
 uv0yTfkmQsJwH7wkISguxaRSb54L7D2fd7zF6YYvOh3SbqeC2R/wk1MedNvQsW0dWZ7NmhpZSfL
 CJP8K2Js=
X-Gm-Gg: AR+sD13+HCoYyTjkOE3IS3B2OqUckFUi2cpFICXiIZyaeA2cpTk6RDBpD5k4Tk4z7YL
 62B9c+o7vEMi4S0s/6TmBp6V5suWedCenbFPNyrlk0qxIytjoOrJiawt4/YwZE/7agpdHD+INZh
 WfeHLoW2qvRO2XMOeL+PSenwbav0MsEkVrmoNq3DCg1YU/gtJ97h2VZeUBiTMVIjEQaz19lVyYf
 Y8cjqomGw7Ld2dbiru0NVydr15Hx8wNe9L2PNAzev9fsXdH26YJpE4DjQc5+eUs2cukVxPgDTdm
 rbiGDPkI+Ac2FBzth9IdLlb1lkgPYXJ2hlAB1T8zkg6Ab88B8GKUZF+fNkVOsf0csoV1uanca1E
 OX1wlDnkRCHRTrYP/ibyZnFlnsb2pvSPe28MZnt+VtCcnBWFMFQss3UuFxWHEaS7UNROPt2mips
 1duzjAtXdjmIor7+miGYgHJcGJLV2YavHnYnSy3dmP0bDUq5uU/TgCSDiTpb1uDX9celNCvoDH
X-Received: by 2002:a05:6000:645:b0:47f:ff13:105e with SMTP id
 ffacd0b85a97d-4816078a3ebmr37856874f8f.28.1786983850797; 
 Mon, 17 Aug 2026 09:24:10 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:7281:1989:ca4f:c9c9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7bc6esm5648540f8f.19.2026.08.17.09.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:24:10 -0700 (PDT)
Date: Mon, 17 Aug 2026 18:24:08 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 5/8] configs: stemmy: Enable SD card regulators
Message-ID: <aoM1qFGsUwv43DGK@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-5-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ux500-external-sdcard-v2-5-ca9a110bd9c6@kernel.org>
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

On Mon, Aug 17, 2026 at 11:31:54AM +0200, Linus Walleij wrote:
> Have ARCH_U8500 imply the fixed regulator driver needed by level
> shifters on the supported boards. The architecture already enables the
> regulator core and Nomadik GPIO driver.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Nitpick: "arm: u8500: ..." or something like that might be a better
$subject prefix for this.

Anyway:

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 62aa9e8cc565..2a01ac9b7675 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1276,6 +1276,7 @@ config ARCH_U8500
>  	imply CLK
>  	imply DM_PMIC
>  	imply DM_REGULATOR
> +	imply DM_REGULATOR_FIXED
>  	imply DM_RTC
>  	imply NOMADIK_GPIO
>  	imply NOMADIK_MTU_TIMER
> 
> -- 
> 2.55.0
> 
