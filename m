Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7109D3E2C1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B071890F6;
	Mon, 28 Oct 2024 20:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fGtswHgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCEE48909F; Mon, 28 Oct 2024 20:53:29 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81530890F6
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e3d523a24dso3592463a91.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730145206; x=1730750006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tm6WiAujO5YGmLSEFIZVrXWghtgLP8mEl0wRdP22nH8=;
 b=fGtswHgkO85BPL0fF+RF2K2Dar7PdI6rSJDqzZct33//DNzUqnsfFzMaHW4XfHoOtd
 jYGGfLVRewjg8/tkKhtAZiCMWP7QOdGj59kymuspprVBnFxcc5HGzU54sVIcGfavHLTw
 ZUIZcZflXCD308Jkd2HaUqlc7WV0CbOxnT+gTFKBixRWpAxLqc2Ti+yWvfqXVpFHUNWo
 dlPzYVYJNl/D79dDtl7PMyS8/xpRpHfplu9bDV8k9rXZDd3KCbLO4hH2xjpJzVXgAPX2
 tqwsAlp4o7aCEQvABOG3IsqHLzAcqetj9O7eaVHax7cTrF43JymdDHjWKUmEyJMTqGWi
 41Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730145206; x=1730750006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tm6WiAujO5YGmLSEFIZVrXWghtgLP8mEl0wRdP22nH8=;
 b=W7rEIPplyXZNH3XEQn42BZY5/SaEyJLXsI55eAPMOHrSeq99muZr9wECkl8wS+SShJ
 0dwjSxB+yVVKVwdVwUri3R4MmqUe8fv15SnKfLGV1Ttdz+kLY3Wt2HDGdCipp9vJycCO
 X89dXtQ9cythfQTOby7BPNIMXXcH5NY9TFo19ZpDpwWimi1Ve1VwqMcGIFtqiyBTMP78
 AEAIoeURgr6wlgCLBM38ZLWbZz7hpngpxoPImCGXfZVmbLGKLpH6Ap0Tzrim6gS+DuJj
 sz0eneJily7os3/jhk7rY2HWVgmedRFFQuSo+sEgOfgEsiHvZX6Gm9kSYvGXjeR5CgmL
 KWVQ==
X-Gm-Message-State: AOJu0YwvZtiyMHhcwOkEM20SSEq0+UGyMVBfEPVJWjKIxLTw0CWoKhqp
 4bMezK0QSmJHHpWNLYnEzc622k9xALvweplisds1P7ncxJUid+7bcMaeu+zt6URYplVpf3GFAdV
 zmqcYdhPVmKeg3z86OHjqnUxPAW/U9ODDLwWkbg==
X-Google-Smtp-Source: AGHT+IGIkBarIklVUcXcjpeBcNIyu2SUW58tCjsDfYr2n7l4Y6SoRYVvBLFHgLfdER6KnkhO9Csda8xGpGW3eQNKsIU=
X-Received: by 2002:a17:90a:b111:b0:2e2:d16e:8769 with SMTP id
 98e67ed59e1d1-2e8f106926emr10926629a91.15.1730145205829; Mon, 28 Oct 2024
 12:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-6-raymond.mao@linaro.org>
 <CAFLszTjPh34RrHQjnD5mFk-fG4GGHAZjsTmskrTqPHdaQrvfZQ@mail.gmail.com>
In-Reply-To: <CAFLszTjPh34RrHQjnD5mFk-fG4GGHAZjsTmskrTqPHdaQrvfZQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 28 Oct 2024 15:53:14 -0400
Message-ID: <CAEfUkUJgK9VvstMdjtVqpPeQk5h87g4NXyN9NMtnSSSqEeWirw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] armv8: Add arch-specific sysinfo platform driver
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Michal Simek <michal.simek@amd.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexander Gendin <agendin@matrox.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Simon,

On Mon, 28 Oct 2024 at 13:04, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add sysinfo platform driver for all armv8 platforms to retrieve
> > hardware information on processor and cache.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Combine with #8(v1) patch.
> > - Remove the handling of the common strings and values.
> >
> >  arch/arm/cpu/armv8/Makefile  |   2 +
> >  arch/arm/cpu/armv8/sysinfo.c | 292 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 294 insertions(+)
> >  create mode 100644 arch/arm/cpu/armv8/sysinfo.c
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> I have to wonder who wants this information. Doesn't Linux know it
> already, based on the compatible string?
>
> Not all platforms have those compatible strings, so this patch provides
those register-based
common values for all arm64 platforms.
The idea is to read SMBIOS values following below sequence of priority:
1. sysinfo driver if it exists (for arch register-based values).
2. sysinfo-smbios subnode if it exists (for common strings or enum values).
3. search in the entire DTB (for those ones expected to exist in DTB like
memory or slot type,
   which is WIP and not included in this patch set yet).

Regards,
Raymond
