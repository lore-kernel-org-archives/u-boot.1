Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649E0CF8854
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 18:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078E988DA9;
	Fri,  4 Oct 2024 20:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GP+RYKnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5DCC88CC1; Fri,  4 Oct 2024 17:24:44 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2C288C44
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 17:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7d666fb3fb9so1350619a12.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728055481; x=1728660281; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L7fA8L/WnJu0U5ylyPOngXB/0ZZRy+p96CmRPvcDhuE=;
 b=GP+RYKnT9vWwVd60ZRXXv9ULtEP4SqqxH/9WEd98Tlt1WRne4gFuNghiG+Tq6FYeYA
 f510zx3hMMF378OH9K43Dxfvq2cs52vnZmo+8K03Dvn0RBcOSYCZJO+ar2t/pf0NWGF5
 G5evnMO6qMDCzaOpzpg5QDenqvx7Icpip2pnAmNSpAbhV6D101+K917ID+sVnVF/RZLg
 k2rqrUrOX26Lm8hw67d+fUBIwC617clH6r4+n7RiunH/7VuuTfzWFr/2D4Pt3XbzhlmZ
 db8c++lmKd9vi7GQDQ0NqsyZW+j2PCWrQeukqrYs46pL9o75i96nW4i804yhl6sx7Q1P
 HspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728055481; x=1728660281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L7fA8L/WnJu0U5ylyPOngXB/0ZZRy+p96CmRPvcDhuE=;
 b=phsJCzubmHZsZ3qwWMXBGCrVvbfcyE3aOGfR7EoR9rWMiYDe0B7Gs+3IGSMLZrqz2h
 0aGmhgqSMg/auZH6xFOmzyYTRD5nqFf23Ro6KPEeUhTja0TZytUVEQ8d7GYhTshkZFCj
 V4Vs75fS/P9QzWB40KqaxHWewVHsy5VMAMkJpfqCz4G6za8+FwErQF7u27SIYa+WyVdG
 lgzjV+AgmFiZP9ljWqR3Liy8aaE9K5Ts1b8AyvcXfRK5ivnrBzGk2EvJmex51YFNVuLe
 +bbWLoBj5Q3pl11Zfu2AoQyyxBWGNywOo49Y8G3PL2+ywuvduXozulc01Hrgo3uT/ZkV
 dQxg==
X-Gm-Message-State: AOJu0YxKAAKA9Zp8Ips72YV+U4aUUmCeHHhg8lisqdMhL1/W3WHbgnl/
 QN6fUmKbhjbvgTKOaw/M0EntJYjGWabHE42Z6Z9cFUraB4sd1YelcAOi1Wxa6cYRvmS/xp0M2Ag
 qTtW+iujV0ouJhhLW61EZnmfcfY/smIZS5mOx0w==
X-Google-Smtp-Source: AGHT+IEGSzJHvMRBV6kouw+LEfXaHBY/6soFOLTUl0JrtiQU4wUQMZ/aVIpjqZE++Hbf8TeVfLxKgGCMt9cxYiiDtTE=
X-Received: by 2002:a05:6a20:d80d:b0:1cf:1250:80a7 with SMTP id
 adf61e73a8af0-1d6e02db695mr3954474637.12.1728055480753; Fri, 04 Oct 2024
 08:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-6-raymond.mao@linaro.org> <87msjk5msl.fsf@prevas.dk>
In-Reply-To: <87msjk5msl.fsf@prevas.dk>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 4 Oct 2024 11:24:28 -0400
Message-ID: <CAEfUkUJPGpQtG1aWAVrsSvj1ceeTNkbjzX67xT4nONpZFFVkqg@mail.gmail.com>
Subject: Re: [PATCH v8 05/27] sha1: Remove sha1 non-watchdog API
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Marek Vasut <marex@denx.de>, Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Anand Moon <linux.amoon@gmail.com>
X-Mailman-Approved-At: Fri, 04 Oct 2024 20:53:14 +0200
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

Hi Rasmus,

On Fri, 4 Oct 2024 at 03:50, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
wrote:

> Raymond Mao <raymond.mao@linaro.org> writes:
>
> > We don't need an API specially for non-watchdog since sha1_csum_wd
> > supports it by disabling CONFIG_HW_WATCHDOG and CONFIG_WATCHDOG.
> > Set 0x10000 as default chunk size for SHA1.
> >
>
> I have to say I believe this is a step in the wrong direction. Having
> everybody call a function with that _wd suffix is ugly, as is having
> them all pass some pre-defined constant. Moreover, nowadays what happens
> every chunksize bytes isn't restricted to watchdog handling.
>
> So yes, we don't need an API specially for non-watchdog, but why not
> just make sha1_csum() be the interface to call, and let the "maybe we
> need to call schedule() once in a while" be an implementation detail of
> sha1_csum().
>
> The same as with our zlib implementaion; we don't have a separate _wd
> set of routines, we've just hooked schedule() into the main loop of that
> inflate algorithm.
>
> The reason I keep the ` _csum_wd()` one is to align to other hash APIs
currently we have.
For MD5, SHA256, SHA512, we only have `_csum_wd()` but no `_csum()` - SHA1
is a
special one due to the historical problem I guess.
The minimum refactoring I did here is to unify the interface and make it
adaptable to the
MbedTLS library I introduced with this series.
Yes, I agree some optimizations or refactoring are needed for the hash APIs,
but I will prefer to do this in a new series other than increasing the
scope of this patch set.

[snip]

Regards,
Raymond
