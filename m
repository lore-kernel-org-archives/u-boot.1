Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C483D65C7E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EDB4896CA;
	Fri, 15 Nov 2024 15:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lbt37cP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C360896C6; Fri, 15 Nov 2024 15:21:23 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D18E3896A5
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cf8593ca4bso1877876a12.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680480; x=1732285280; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=emWwBKmFcC/IN4+OVFD/egPrwu97Pbl9yGUGBAMWlqg=;
 b=Lbt37cP2yoWyY0yXhDTqzeJywMkf1qZSk4feWr6T+a2QTtE3i8KMhzNgFVrfUZ85lf
 o7xWJ615UT4eRtvhQkeh79ksX5qiwxmJFVOhN9+zChlhlKih47TQpLsghez0DOk1yYh+
 jEEovSp5L+xG1hWCIGYmFdMdlyz83aw+vexy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680480; x=1732285280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=emWwBKmFcC/IN4+OVFD/egPrwu97Pbl9yGUGBAMWlqg=;
 b=aZ6hoxdtWEJULvdzBG+xcXZ+V7bE8AHwtwZK4aJEyuXGmEdNQwjDq4xnvP0D46m/zS
 Ro8z3Q5e/0SQbqgPTOP2IypVYrmKkcPcGmaEAP0Mz33si6cbDW3KhHpzdcdAo5sFPUid
 pZnPb8Ol2rgE3YLaKje4Ff97rKmcBq2Ky3C1HDnUh3xRyik9Rz0qGy7vzQ8G0pDp1RHB
 bwJ94Fk1w0C61Mh8y3nnL2Vj6ZSS4x/mWv0DaboyKPf1TA7OMCw+AhoW8lMNI5iE/L5p
 r4fvgemmQEPXljDwxBILztPihmrIAB+q5LZjq4aVzaMprgFAzHkdcrJfSx58dVDLA35R
 kN6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgITMoCe/3cPKk0inlh8q1l6IgWQslbuGgd7vuixC/+Mpk+e5ca7D12bsqvPWiKPMp4IffjJY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw24357uO7eIjQqRF0PlGWCHfj9POWsYCkubNdWWEsG87yDTiIZ
 Ut0bxDG+c8ZsNUJ0Iec6rg47/L0SnleLtDP3dXMrvDxP1GQlMJb61eIWGlGJB8UnQ/lNNtKiYBO
 kuh5kdHmSlMu/NObvR7sVgj4Liw2yP/7tXaCs
X-Google-Smtp-Source: AGHT+IHgaMAcKkeGlsRitpwbLCd8Waj1Pc4CB+XU3GFLVL92paLne17z1tarkh25xuXibec+lswXNxcn8xwCDMuDnLw=
X-Received: by 2002:a17:906:fd88:b0:a80:f840:9004 with SMTP id
 a640c23a62f3a-aa4833f60e2mr232848466b.12.1731680480185; Fri, 15 Nov 2024
 06:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20241114142004.2051240-1-jerome.forissier@linaro.org>
 <CAC_iWjL5Uedu+2DnibFBXJveB3qckLUKUwY4B-s1D+Lup-fwkQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL5Uedu+2DnibFBXJveB3qckLUKUwY4B-s1D+Lup-fwkQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:21:04 -0700
Message-ID: <CAFLszTh79SwMV3kUFeK2-fR8=dU4R3ceRfL=pbi4Lb-G8v+2-g@mail.gmail.com>
Subject: Re: [PATCH] doc: cmd: wget: document lwIP syntax
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
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

On Thu, 14 Nov 2024 at 07:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jerome
>
> +CC Simon, since he asked for an update on the docs
>
> On Thu, 14 Nov 2024 at 16:20, Jerome Forissier <jerome.forissier@linaro.org> wrote:
>>
>> The lwIP version of wget supports a different syntax with a URL,
>> in addition to the legacy syntax. Document that.
>>
>> While we're at it, fix a couple of minor issues in the legacy
>> syntax:
>> - hostIPaddr can be an IP address or a DNS name
>> - path is mandatory
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  doc/usage/cmd/wget.rst | 71 +++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 60 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
