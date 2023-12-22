Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A0C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAFBD874D5;
	Fri, 22 Dec 2023 16:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XN5WLEBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F16D870B5; Fri, 22 Dec 2023 16:13:29 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16402871CF
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28b09aeca73so1395053a91.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703258004; x=1703862804; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/rIhhgdIW7IiaOdSgY+a+0QVlk/vdkQMWCf8BoKauZs=;
 b=XN5WLEBCTAfmRsqaEQvcfoW8oUVcJPR6gQF4paohsqbuVeikgqho4+WR6kuA2pTV07
 pz9jjONmYU138IYCGguMU6/P1AFhYN0BeEgVH09eECDC/x2pLxJb4Y7+9n25/k+ir0xG
 qgZ3asuEI3W6PEOuyqXSMjN0xkiKeMzyMVimAwCRK4LZlLZMRNK9HWkvQ2rbNLbeqykE
 0bXG2AQN7eEP8E1zu5Q6P+4ZCWLKD/JF9dqGcbFO1mwdl+3DqTklZLR6h/jroxp6RBH0
 LDgyrwKoTH4zHxT6888UPOs96Sd6Aav74HAJLW/uCWne71AeVP5AvEtN+8Li4PwWUYTR
 SAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703258004; x=1703862804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/rIhhgdIW7IiaOdSgY+a+0QVlk/vdkQMWCf8BoKauZs=;
 b=AurcwmkbgT0JAicqwD6IRR/d2F9/kUK/5MrujzXNLXxDzayO9l5+zXvd+0i+eYBLoZ
 bkDI5PpbXL6hO8NzV7oeh9CjOrrNKuFioDr1VDS/JGSqahTbGhkUSXUW410l+4Bnrzzi
 IrplI3xWcpenIxHEtIErWr4oYV3MaFZuaPSfHT0ErijoivAvNlNcT2uJuByLrW6AO7xS
 enf3AffpcWBf8HB1OCOCEdYOvLs/8BJo2uX8E32seOqlYSCMIkcB7yNy+gK8dWAQoJhC
 akOGFBVn2r2EOeeuDrM8i3qtaBb0Zcj/rReGg+M3U12yw/N/Q/c/5Kmapjv8DSXjAKiE
 Szhg==
X-Gm-Message-State: AOJu0YwW+VGI4ShNFq1hSyL/63ayCQ4jq1Dk7jWRgyaUGNSa0+moT4To
 7J6EGt4tm+lECznkMlaUFUes7p53T7wV+bniXJjRM0NZbOnCPA==
X-Google-Smtp-Source: AGHT+IHFcrdelADVCx/5IBXurOTTVOLrS79fiqOwQ5Po5aiPLENrlSfEohNo9Ixm+tkclPSh3ljy/dbje2IQzfhLEwg=
X-Received: by 2002:a17:90a:7848:b0:28b:765c:163e with SMTP id
 y8-20020a17090a784800b0028b765c163emr1816111pjl.16.1703258004300; Fri, 22 Dec
 2023 07:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-2-raymond.mao@linaro.org>
 <CAC_iWjJWOBcsnVqqPoLSVNAZH7qvLsQ576Xa2_JQFBjZmeBLTA@mail.gmail.com>
In-Reply-To: <CAC_iWjJWOBcsnVqqPoLSVNAZH7qvLsQ576Xa2_JQFBjZmeBLTA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 22 Dec 2023 10:13:13 -0500
Message-ID: <CAEfUkUKH0zMZ2Ngun7pgXfZsRj3tucfZXj4kX_T9vFz+GVwgBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] bloblist: add API to check the register conventions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
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

On Fri, 22 Dec 2023 at 05:55, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> ...
> The function looks correct, but the name is a bit off. There are no
> registers conventions check AFAICT. We are just comparing 2 addresses.
> Am I missing anything?
>
The function name is from the spec. Below is the section describes the
expectation of arg[0-3]:
https://github.com/FirmwareHandoff/firmware_handoff/blob/main/source/register_conventions.rst

Thanks and regards,
Raymond
