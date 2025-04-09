Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0CBC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 10:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABC848362A;
	Wed,  9 Apr 2025 12:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Rzm1Xav4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529018363C; Wed,  9 Apr 2025 12:28:42 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C43F83622
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 12:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso37747385e9.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744194519; x=1744799319; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sQmkGQkblhzyek0hWzrmhj4+9FZR05iNrV9kpQy93go=;
 b=Rzm1Xav4n/M2P3BKTK6jV/F+qv5qcWcDRII53LQfunXPuLNHsLq2zj12o7oC1cMscc
 gRjRL2qIpLeuoca1emI4T6Weq241T0/6kwvLjCLspmw1nnMIwRAwp7R3cKErOjX1T6XD
 f/akWOoGIeYuCmrnn6V/gPAA2V8GBcfJHe+tW8jYEDiBfsuvKIMxt/8TkAhfGSjVT/4/
 ZMcO2zaTN8wdQT+Sio83xUxsuQ6kc9oE671wOl83+/J4Lc7fjTvtSDpjtISZiTJeDyTX
 McGWz2hMdMAP2lwXgVucwq+7uCvJsW6Yp/IvS1AttoYAFTsZMIKdw9AXJ7sNyixQiaBf
 6zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744194519; x=1744799319;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQmkGQkblhzyek0hWzrmhj4+9FZR05iNrV9kpQy93go=;
 b=G22h4xCP5bnZCKj3+aEuBma97Alf3UIR4o5Q2gWUg2oft07NG7cHX3hxPHApTqepSX
 9dB26xWC+dTc6fpyAQvwc1BJ/ajUcVTN0hhM3OeTMK5+gsz5uoxT71hw+bDzactzzXlm
 fU+lJKRHlWhEnxQq2MuFg24DMVi9OSQEuIgOmTQIJ5kqRVef/tzDw0HM9kGMYREyPwIv
 URN43/5LPRueyPVdk+4hRv2yzQaqSG83HhWwZqfaTV/c0hWVbODPh42cI/srERAhiIN/
 xarORJCzUpobuSRzQHzgPkeGDV709YSAMN4SmvHFPsirkpnxCrSFWwP7G6hu0OsQ3mEW
 vxPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqPSE2lh6cOPOvIr0Z1olkfOkZgTuADXdCV/zHGLI3Ml+51fmeQlc3dWfqYFfJQmjb2me6ouE=@lists.denx.de
X-Gm-Message-State: AOJu0YxPphfNFx2Vp5Sw8hH15PkbYolBgP12dXpZfQ7xRI2/MsTs6FLv
 /YM6o48omH8qbo1XDGuXrFesfrlTVkARQOEq7UZiKFa3xmfY5sTKa9ugsUEYHiY=
X-Gm-Gg: ASbGnctgAk+Lx8/ZVSIYIPkV2zFo0SIzPAxcdVP57J9lw8UIHXB6vI4C1vAufZ/503c
 pge1jF15H1hhSm2o6nUqgeHgR2f0pKT59zzUqIcXNowM4AKZpTHDpka5lIItqpv94qeqTJCosvJ
 GDzAAounb1D5BTwy64VGVOYNlZWvVU5Ui+EhqMQFOi6jpe1eUsOe35e15ifOyRQjMSne/AttJzj
 pbN3OyxBwOeHKLCM9fV7uYyf4EQ9OIc5BACF4LXIQR/kU0Q6OG3btXsZXKkNMkpP9drBAwu8Za5
 4Bie2xIXXvGXRV8y3M6k+FyQkO8c+OeKtPUBIA==
X-Google-Smtp-Source: AGHT+IHfZRvpHzqguewN6zcq3gaWNuI4RLZNSSoxReAILT+cfqfn59mqTIjtCxR/XtJhYuzOKAB97w==
X-Received: by 2002:a05:600c:34cf:b0:43c:ec4c:25b1 with SMTP id
 5b1f17b1804b1-43f1ed63472mr18811375e9.23.1744194519568; 
 Wed, 09 Apr 2025 03:28:39 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f235b050fsm11678735e9.40.2025.04.09.03.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 03:28:39 -0700 (PDT)
Message-ID: <74fc8034-625b-439e-9af6-1d4fcb693c37@suse.com>
Date: Wed, 9 Apr 2025 12:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] board: starfive: spl: support DeepComputing
 FML13V01
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
 <20250409071836.26629-5-heinrich.schuchardt@canonical.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250409071836.26629-5-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 09/04/2025 09:18, Heinrich Schuchardt wrote:
> On the DeepComputing Framework motherboard (FML13V01) choose the matching
> FIT configuration.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> v3:
> 	no change
> v2:
> 	rebased
> ---
>   board/starfive/visionfive2/spl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
> index 3e4d3e21988..9a3081ef06f 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -125,7 +125,10 @@ int board_fit_config_name_match(const char *name)
>   	if (strncmp(name, "starfive/", 9))
>   		return -EINVAL;
>   	name += 9;
> -	if (!strncmp(product_id, "VF7110", 6)) {
> +	if (!strncmp(product_id, "FML13V01", 8) &&
> +	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
> +		return 0;
> +	} else if (!strncmp(product_id, "VF7110", 6)) {
>   		version = get_pcb_revision_from_eeprom();
>   		if ((version == 'b' || version == 'B') &&
>   		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))

