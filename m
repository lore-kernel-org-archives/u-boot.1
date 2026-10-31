Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64541606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YLHT28+p;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PfYuV2Tl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3035280F40;
	Sat, 31 Oct 2026 09:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bhh9F1DVdZnF; Sat, 31 Oct 2026 09:29:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A54C80FA7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438985;
	b=gtfnooJ93S4zZeDn10V/88blyahDzRg4zlWFmgHxiM5a3FA1cW52QWOUc5xI/T0+Ti5J
	 uccSODsreEgxPv/4WmROFkPyNfWBbU5FuCpcPOATZrggfiZBXu4yWPHveisVCDLPxcpF4
	 HC5b5khd5HDQg0bTGs9dSBo1Tz4TfSUK/uEJFIydK/ru4C7nyT2ImEfmYa8p1cvYRYQtC
	 S/NWioEz1Y2nEskhKjlixc80ucqzN/ONUm6yl3+Ni0XTRJREUUNvHPiG50+HeH/D3yZBg
	 TDYMq7gP+6d2l8pYBp1COIo6pxRK7MnrMyXeU+YyHJSK5CEfS8PJMVIfVFWGLm7V/dw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793438985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KRaLYpFC8KfuofTIljQsHa90qnwHRAjoeENu6GGXAB8=;
	b=J4ARY0I4M/PskGnvAkDE5fmfaacSnao34ds7GQBiEHTVuC9mbLiVyKun30rOvHvvOgZZ
	 oggPA35n+3doG0k9T3F9Ktm8qnkLYZyb22c5Z2TIOQPpC+dNqRkJFqGII/Ir6OOiRTcZC
	 db4rwQZlt7Ehdxuo2Z7XqkwuwTJW+YXunIBHxHldC6IsotQsyMgMs+05v4vzRfa8Qj5ZE
	 4JcYCSYDrqqJd/oudxAEYxaCYJM1k2wDNca19DrwaQq5xaH6o7JTSqHsh1gvJNt61B6WD
	 6jqphkBP1tlRGp+COcz1I6emcvm/0eo2xoOYfLNpmarjnZnIViExGIvVfcsHdovvVvw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PfYuV2Tl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793438985;
	bh=KRaLYpFC8KfuofTIljQsHa90qnwHRAjoeENu6GGXAB8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YLHT28+ptI2N78IldVgiRaDUQu68/PjaW/cpC3QO473PKowGFTKHGm08lMHh1jq3O
	 ekT+UTbzBohyQg2gzjtAzlXq9pxu2tlw/HsvwpU8sI/lWskQkBHnBD8BNr5rnicwzd
	 fF7rgNDKyMxX8nZY30v7suB7PFnEJ6wZAL/rZy6F7Loo217QmrTXm4MpxXY4Yu/N/R
	 SFBH31QYj+Ik5983lWHN/a3+wVlE95ZXu7ePvPviI8tD0rX6aS4tprOfeLNn9YJzPC
	 Bzp5ucYUxp/As8Hvk63Pt2pGnQJrQq8Wu/K8r0wED7epcp9u6CmMYH4buJ1vUJtzK9
	 z05jLhmbfW03g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A54C80FA7;
	Sat, 31 Oct 2026 09:29:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB6DC156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B15F980FA7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UKlbKLYW6ZO8 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:29:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B217480F40
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438980;
 b=dH97IYTGRGT+RSxKIjAm6l2KT8I33QW+PH43NH61yES8wXCG3nCUQSGjGmtJpXCSxVMB
 RB9bxdNIDq3JIopWZMDnBXkCO78twJEF0t32Jo5aoHAX7DaK0ohA/9PceSMS8dp8f+wmH
 zSHM6kgdT9qhnqdI4DNqbp6A5gZd8Z0BJdxs5VSJi0GAIBysbJJHrfeglBRbi06nvfEGf
 x2UBKrKfr0tQMB333p34NPkAbHdVYrIMmDYn8+Ia5LFxOk+ris1ZavSGnpL0duc86GG/S
 QTFFw3HVP9uqh4R9ILlxQsZUg5RC9kxuDTY4e7EvqZBpOi4Er4kjE3ZvTeny2ykvitg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793438980;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=KRaLYpFC8KfuofTIljQsHa90qnwHRAjoeENu6GGXAB8=;
 b=TkZPuP5+8DQ6h9x6c8xKsSKBCS7AN2TlFmcF0FED4dXRy8XqtxLZu50fLbPUZP1hNfcF
 wvU3DRUYpxRaNUBmG7DItcIj/NdYyoGgvNf/o9f18GOpmxiRT1cxa9DosYXcY6mJF3D+X
 2KpKhWQ27M76QSOaXrFJyeifMc/tlQmbQHyT0/kC1e16OjXF5iYW0kd+/pVKXs46zxP8A
 1eRuV5Y6bmQjCJyj67VlLhxX51lMqGSO0JL/Tm2kGbpF26ixqtrYmi+RAML+lwl6zRxQz
 EfOjZJfDXPqetNssqBn8Wa/7h3XgZIblu29ZhR4tB5fPIGm7GFmxKgh6ZigO2jfHVXg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PfYuV2Tl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PfYuV2Tl
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B217480F40
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:39 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so1970494a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793438977; cv=none;
 d=google.com; s=arc-20260327;
 b=sJeT6WV7w8I1RyQCHIn3Ju3OEdTgFUYn21Q4oaj2blMvIZ7pdOjNqDqkicwetxWFMR
 hi3q8pXN8jgImczK7Pln9OmmC+ThIo8yMhNiGzIMRH8cfMFvcgrkKLmcLblL7XoFJWCG
 pTg0elQT2XLszqlg9fprLRbhXNfu6JIYxDFm/45xwqyWIUr+0OvV2ThPJRB4rHMknzpp
 XiyG+ASENshTB6Apdjc53IwUbMU4Ete1PV9KQdcBlY1GRy5Jl3XSE5A04RG+FZ7QAU69
 7buHfNIZMgkXU/p7oaBTNA39dtfoOEetn8yjVeSuKt2l40LMZxY4bsTWO83BO7+w/sxg
 LUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=KRaLYpFC8KfuofTIljQsHa90qnwHRAjoeENu6GGXAB8=;
 fh=eSGTpZ/+rqpDSLRAETcqVHJrTBA7Fx3Zl7gWkQXUacs=;
 b=JOJNCsGED+ikdVZ2VgRAgrwvCn2T1JCl41m03ivMMGIJnkNg35ug1DnvNHMgGb2VmZ
 rRjWSU0ol1PPQmqxkGKOjFX5D60C/7PSxeEqvW88I7upBHlRj+A3sz8VU7dRzYOM9k/P
 AegZSVINQ4M09S3hAyfpP6k5xUI5EQMLXVSD5ftwPFdMEtK3OFq7odNXNLXGjiQfmjXU
 J+4UWpNAea9Du7mODPAj+ENpoioHHXpQLAYCOR8St0UUe84SR/gFO4tVSBRB/VeL1xwX
 S1ZKc6A6SmmlXl5q+J6zbb/5n7otLa39N/sbw1++GdJU/1dFgd2fjWEpKmXvv7iejo57
 dH5Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793438977; x=1794043777;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KRaLYpFC8KfuofTIljQsHa90qnwHRAjoeENu6GGXAB8=;
 b=PfYuV2Tl22GuYlZmjPRrU9p4ROcEUY6mwIvW2yGUmuP8zIEffytlWxGMeEXzw9hYCz
 PwzKmvUtOuLjgPJKtnll/rVSyqLt4RHEgaafG42DFMDn//J3ETZkkFx1hiwv14eHvlN4
 EvrhmoSEnkmjr+CyDAIx+//l5gcowi0WWtjHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793438977; x=1794043777;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KRaLYpFC8KfuofTIljQsHa90qnwHRAjoeENu6GGXAB8=;
 b=omAk/GuHz156VWLaAwU5S/TL9qOJMUc0LQY5fr6DyhKeiGWaBQ2MHxBk8lhdrWRHZW
 /TQYr3o+EUvtpSrowsdhYFyeHXa4k3XyIZM3xBDEA5UsfoPcI2enATochY20GnUgMyFg
 jyG7B/9/+UmP63a9kgFY9mdaNxGlUuFkd2iNg9tYNX7P1D9lAoJc9Ei9l84I/Dm+kUPv
 48gxoLTRUzQRJW0/Tpgd5HSSwrOO8zGk/UJt4mdr0M8Nr+8xyOdSIt3JtL570CkIEjAW
 2LZV7bqeE0IxeKlLR7SPIGpFiC7NYc0V+yU3EI+vM086/b7SPIUD7I+DMoqors1ptjad
 OE3g==
X-Gm-Message-State: AFq9FYILUiAlAzQZ/EDAHrgBUaHVOSd/SEvmVl7WqIbl8xOOnwVi8OO3
 1Nhv0AOqlUdD7pdTXtYRmvgk0lQKpWSYR6x5UtC1IXOzW6EQYzWTfF4QyrZmId883kW158u0jD/
 Wg+EHVzjYAWccYZqFQTFP98HRjiB6TBiqWEzH7OjN
X-Gm-Gg: AYBFou0gkrdEywqUnkoaGZZ197CvjyTUFdWL2XEnrQe3GAEoP0JXhxc7ZijNSCry/Rc
 PhfKPTWQyInrpFgwpWe4j5a1nwdjDGb9r1gO66q0C/zPPD3W4wo7jS/WJBeJbyDBrjGGY9H3zdI
 vT40kxiOfbIo9GVmZ9k86vyNypDC+uvOqK/sLk3CjDG+hkR7lwSrAfSWh1Gsyx2G/Y+6aRuyDvQ
 uDuEsn6IGp2FDWWOOQ99ZTUWLp3XaZoDXmE11snjd88obph04v8MtH7PTQJs/pfCbA5h8TOw/07
 7D5zVP8AptJGoXOIJMFau55gLMTKEh0f7MOQrhfPZOPtkjf/J511KvARfS+YBGRX9ItjUYAjZzG
 y0szWZTsEQyJgxpMuuUcJ8j76RSjMerw448RM5XVyutEEblzLZyctFgNgyBNCH9mqL8HNjW8=
X-Received: by 2002:aa7:d0d9:0:b0:6ac:5c83:bb9f with SMTP id
 4fb4d7f45d1cf-6b4d46766e2mr2472529a12.9.1793438977265; Sat, 31 Oct 2026
 02:29:37 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:29:32 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:29:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:29:32 -0700
X-Gm-Features: AclHuK-6GzTPX30HARkw03Dm4A0G59nj6ZZWMCsTrrntLXx-8St9d0JF_iVoZ08
Message-ID: <CAFLszTiYEvqOU-GYM4+Kx6REFMyYOyrTJTon2n7pCEPSoupZJQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] reset: dispatch DT-declared reset modes via the
 reboot-mode framework
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Balaji,

On 2026-10-20T16:46:19, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:

> Patch 5 (the device tree change) depends on these series, which add or
> change the monaco-evk, talos-evk and shikra board files it touches:

There is one more dependency here. The qcs6490-rb3gen2 change edits
arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi, but mainline removed that
file in b0f80cb42ff ("dts: qcom: remove hardcoded memory maps").

Anyway I'll leave this to you to figure out with the maintainer :-)

Regards,
Simon
