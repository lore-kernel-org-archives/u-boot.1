Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348EAE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 00:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD728957B;
	Fri,  6 Dec 2024 01:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YnyU64Ln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07EA98957D; Fri,  6 Dec 2024 01:00:43 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8188A89576
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 01:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so234409266b.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 16:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733443240; x=1734048040; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K7kLktjog8CHeAyd5R4VsbUK0sk7Z1PAPdA7zjwArTc=;
 b=YnyU64LnzlDrNFa5xcn5E3uGIUYp7LM/M++y1lk2y+mihbojkTBpoPSKmUw9BjRM1v
 3SMVh63U5Eyad68sw8VjHcLGUi7/xguJzm7sHYCqCr3qpw5/cB44yOB3Y2TWC1WwhCUT
 v8nD0ippl4u9JHMOEw4QiniX/thiJA3jf1Q07velNm1J+qu+XuOCzkmPqHy3faxhuQi4
 xDp2GD6n1j0WZ9Nuu99oTe920zRUAqZT9pAVRciGMwa/mGaNEfo69XWzfNZpGYpVGmEo
 J2XcyN8HP64LXKUMcT52Ek2BXpShbK4eaF8VVJudAEXQ8WJD+bT4hxRA0G4+n4r+8+85
 OSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733443240; x=1734048040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K7kLktjog8CHeAyd5R4VsbUK0sk7Z1PAPdA7zjwArTc=;
 b=PgrTFF/IuEmo1RYehO6OsYheo45fCtBqFpnTOCryXxwmckcyB98Uk/NKi0kFR0cZi1
 E4rwXGjp5S8OgDpHs4wgdIUk5wABggStkVI//AbD8ePOYrs+ZQ2YKJlzmqDx6pNEXUz1
 cFjMFJQegWoosL3w3Y9NAAuZ/2mfbZ9yMkMzmGWSwL9DunF4Ma8eREZF+MRgjdAB3k0p
 G98fZ6kYjui8vpp5GRinejHBE9ET0RzHB8L/B1lVJ5gJGuPnPU30XWnUQr9+3ceAVkiT
 P6j4Ox7r20s7h9gKVmbivrYQEVsNRUONdS9qBo6bfXQAkuxad4whUyM9YDGe6PK7a+ey
 2B3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpqJFiscDXu7kGB3bHJ2cQjiafZvHIJLhWSdNNrTTZjmuK5pS1Ny4czjSsRJpT3y4xhHnXeco=@lists.denx.de
X-Gm-Message-State: AOJu0Ywno85ALYMzf4t70oT538SwOYmiaPQA/874Ad8CGmIqmUvVAOY5
 Wx70oB9DBNwNC1tG/GLXDbbw6ztCo1V6lEmivLmoGRCrQg9Ne22V5hw8Ug/mZG5H99JMgjJalrX
 7TzCTpTpZDF7SBm/CgHtfa8EO86WypLpB+lsVRAWtppTkR9yW9N8SHA==
X-Gm-Gg: ASbGncsBivhDGiuAsVEAMaD6nHJxkAi1yzmUrk3mc358ZjaXTvQl/sZ3E6fj0AAYHWp
 O1CKtRenNGPvZHjgVc1ZaYJnWFB9sUcdVyzEMUKlThgO4/gVMMfsb0JltpQNkPJ0=
X-Google-Smtp-Source: AGHT+IGmfhZmSkRIBNMtx0uHbbnyYKjKdYHP2muPBt/HvCdAGA1UWiREyPE4YPlhtOwL5iuCXMuUwAFZMhLcZDPJEM8=
X-Received: by 2002:a17:906:308d:b0:aa6:34d6:92bc with SMTP id
 a640c23a62f3a-aa639ff6474mr61090066b.13.1733443239863; Thu, 05 Dec 2024
 16:00:39 -0800 (PST)
MIME-Version: 1.0
References: <c049545f-be40-494c-9b6b-3d8b9f3559bc@gmx.de>
In-Reply-To: <c049545f-be40-494c-9b6b-3d8b9f3559bc@gmx.de>
From: =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome.forissier@linaro.org>
Date: Fri, 6 Dec 2024 01:00:29 +0100
Message-ID: <CA+NB=maM9YOt=enZEexRfppAgWJuomAMGWNmjPZEo8w5E+fAiA@mail.gmail.com>
Subject: Re: Mismatch between wget online help and accepted syntax
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

On Fri, 6 Dec 2024 at 00:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> Hello Jerome,
>
> origin/next qemu-riscv64_smode_defconfig with HTTPS enabled showed me:
>
> => wget 192.168.103.3:/hweb/arm64/helloworld.efi
> invalid uri, no file path
> Invalid URL. Use http(s)://
> => help wget
> wget - boot image via network using HTTP/HTTPS protocol
>
> Usage:
> wget [loadAddress] url
> wget [loadAddress] [host:]path
>
> Here the longtext help is not consistent with the implementation.
>

It looks like you're missing commit a37064cb2e48 ("net: lwip: wget: fix
legacy syntax"),
aren't you?

https://github.com/u-boot/u-boot/commit/a37064cb2e482739908e76d6a53914301c8bb8ee

Regards,
-- 
Jerome


> Best regards
>
> Heinrich
>
