Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389A9C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 06:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2E487075;
	Tue,  5 Dec 2023 07:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KneyYGGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23AC586FB2; Tue,  5 Dec 2023 07:22:29 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C579887494
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 07:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bfa5a6cffso2017021e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 22:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701757346; x=1702362146; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YAP9VwZZ33+C/1XygcEuDj4t2FowNo1tpcY0Y8TmuV8=;
 b=KneyYGGl1M8zxb4eCURhaS4NYUj6vTz6rHMotF+TpvijOIc8gnKiUYFHLwRGYD9tAG
 Wiv2ul9IER/z3wi5vxsxKMRyYnDsWrjX1OKmJftdGgJMYIr4PN/xgALWpT1mLE2zvHpd
 8BkML8Yw5D1kZDzOjgn7q3OTt6eZFAfPO1L02Cm8RSlbr6PKP53T7B1pvi/a//wrfuQa
 aM9OmojE3cg/JInkwwBtX8lcr6OcRHAR5dy7IcqgD8eWrbszB7CpXSiURkgQPJaE5rlr
 dT7H1io+rogcSCnLCA2Ixvzs5hrLf+g8LKJSo40iV2wAqyjsekLP4OBcepyReR+IPfT4
 /81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701757346; x=1702362146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YAP9VwZZ33+C/1XygcEuDj4t2FowNo1tpcY0Y8TmuV8=;
 b=aec8K46d1d4f2aULgXzf6CPtUCLhffvVZttMMq3N4kr/JO0mRFiRRgEuYKTTsZmqrU
 F/M+0PW3Jehh+OfH9i6tgdAzqIJQ4LLIBNeMlk2fuJ6UUg6niLgoWeArIDeLDgC0f6Cp
 Wzr1KiQY3wr6YMb3p9iYIuUhBUoLJPVEgbsgYlCD5BrKizn9kjZBd2FnrH4wkUHvPNpy
 3SUbRR5OFuznbHQmHiS4OGGuIaxnKZe4ylQ+UIsz5Rx0OCR++T86yh1e4QM8UkarYoRU
 FZl5pe5Pn5lCDINNgaERCfaPw0jHt7gjvEhrhiok2K3fA65+N8SWM50WhPXfXrFBWsb0
 uzyQ==
X-Gm-Message-State: AOJu0Yz9l0fMbNMerXbnBGWVBFOkfR4l4zt+h/DR+9VBHohnaN2OMPno
 YfngtX7z7VM2VGD9szNS3r3tCu1Uq+ed7xDZCbX0iA==
X-Google-Smtp-Source: AGHT+IHO6eq3hRgzqT9iO3TSmDPd6T8SeaWtj3TYe9lwFMyCZKjlVeCByYocqcjMsW8aiYFaA9qASXbQVysiMMW83Vw=
X-Received: by 2002:a05:6512:2022:b0:50b:f2f4:279 with SMTP id
 s2-20020a056512202200b0050bf2f40279mr1320188lfs.110.1701757345981; Mon, 04
 Dec 2023 22:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-16-raymond.mao@linaro.org>
 <CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com>
 <CAEfUkUKaBotDRyReCLc_R628VzZ1CmaNdq_nCp=kd8iCn5R6-Q@mail.gmail.com>
 <CAPnjgZ0Hxsbv7EHbcnvLtmRSrPgMDfOFS+KmvYBcZgVC1Je4Ng@mail.gmail.com>
In-Reply-To: <CAPnjgZ0Hxsbv7EHbcnvLtmRSrPgMDfOFS+KmvYBcZgVC1Je4Ng@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Dec 2023 08:21:49 +0200
Message-ID: <CAC_iWjKhmJ4BrH73-5sg8XGjMfJbsx8oWLsz3sGKdP8jdoHBDg@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
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

Hi Simon,

We did discuss this in OSFC but perhaps you forgot.  The discussion
was based on the mail here [0].

On Tue, 5 Dec 2023 at 02:52, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Mon, 4 Dec 2023 at 12:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > When `OF_BOARD` is defined, the FDT should be from one of  the board-specific mechanisms:
> > 1. FDT from a bloblist via boot args
> > 2. FDT in memory
> > I don't think we need a new build option to distinguish these two, since it can be done in runtime by checking whether the boot args follow the FW Handoff spec conventions and the FDT exists in the bloblist.
>
> No, I would really like this to be deterministic, so we can fail if
> something goes wrong. The bloblist should be 'declared' as the way to
> boot, for a board.

We *are* deterministic. I am just going to repeat what we discussed in
OSFC for completeness.
OF_BLOBLIST makes little sense because we are not going to add a
Kconfig per blolblist entry.
I haven't looked at what the patch does yet but the idea was really simple.
- Under OF_BOARD (which can arguably be renamed to OF_PREVIOUS_STAGE
or something like that)  if CONFIG_BLOB is enabled we scan for a
bloblist
- If CONFIG_BLOB is enabled but no bloblist is provided we fail the boot
- If CONFIG_BLOB is not enabled we do what we did up to now, maybe
with a message that this is going to be obsoleted once enough boards
migrate to a bloblist

IOW if support for a bloblist is enabled we expect to find one from
the previous bootloader. I've lost count of how many times I repeated
this, but here it goes again
The device tree can come
- From u-boot
- From a previous stage loader *somehow* (eg. passed on a bloblist,
passed on a register, read from an EEPROM etc)

We should keep that distinction and create subcategories for the
'comes from a previous stage loader', rather than adding arbitrary
config options which only confuse people

Regards
/Ilias
>
> If in the future all boards a reusing bloblist for this feature, then
> sure, we can drop it. But we have things like rpi which do their own
> thing.
>
> > If it fulfills the above conditions, we can take the FDT from bloblist, otherwise from the predefined memory address.
> > This is fully backward compatible without adding a new build option.
>
> Again, we need to obtain the FDT from the bloblist if and only if the
> board requires it. It creates a lot of confusion to have it as an
> optional feature, when we know which way it should be.
>
> Ultimately OF_BOARD should go away. We just need to push bloblist to
> other projects and closed-source firmware as the correct way to pass a
> DT.
>
> Regards,
> Simon
> [.]

[0] https://lore.kernel.org/u-boot/CAPnjgZ0SqVyj_drLEQrP21zPYCco3HOP-rYD+nKJMa0BVYpMDA@mail.gmail.com/
