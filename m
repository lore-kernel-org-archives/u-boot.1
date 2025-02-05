Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ACAC02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9420880F42;
	Wed,  5 Feb 2025 14:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oOoCb6Zu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04E76806C9; Wed,  5 Feb 2025 14:12:06 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F2080562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e479e529ebcso5635987276.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 05:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738761122; x=1739365922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4OuWf/6vuJsK5UxETDAeRstQUfGj95WIlLCMjBHvya4=;
 b=oOoCb6ZuPoFQwCse+1+gOclNAbL4vhm1M9rrSoeiqKcNVihWHJ1pdPvZcb0kwaa5N/
 c0vLI9O3m2iiPpJJStUO1ma7D3BFmWbkgwlYiAKd23tSui+RxgcMeOsnvN/ySSIbzzW4
 56KoPEsFx/LyM09Y0bh4koipj8DMPP2uvjbkzfnwmx6BuO+4sLRtAq9RD6wk1irjS4FJ
 srYEud8S4V0JGHa/LjXF4VYvCLfZm+s5C3GpLIK3CdJJqtzK9W5GeIPWvCQrS3OgPRgB
 //VFpRvU4hi6fvPJYu4fln5PNQ+RUhGLeQjoK2oac4jR04NMx/33TuYuCR60VlFlrhUZ
 7vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738761122; x=1739365922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4OuWf/6vuJsK5UxETDAeRstQUfGj95WIlLCMjBHvya4=;
 b=eA1rrmhaIW0+q1VizbvFUcICxHJI+3+Bf0QQfzIz+7CX/NDKdYyqbUwpJx4J50EPdm
 zqtU/312MZUs8Cdat0GpFtMPVwwhb1DjBT9O81K0dbsqGhDLyDMnv3tZV2B8EGW/fHXM
 VpAO3Zs+lMmW/83YmMj0nT4AxvMpkdZZXs36bE0L/KZrKEXhClXPZkGWwv10eoFdK4xd
 TW7gcqNBu/BEYxxz11XwNoOsf2+Q1mULv6Vy7N0WhBOBzskNpaXLB8FWIDQLW7oRsIll
 aQurfMzzCUF1MAICZ+N53U+KrhPnyql5nrZlJ7eU9zfHPVcLc7iWOgfWfEeRVW9CcBAK
 lnFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOD+i2EA9PNU9K0xBxTdbiQ0d6pDwOYAZ/eqKPivjJWzhqZ5YnglOpy0tgCB9aBY4Z0lEE5Ws=@lists.denx.de
X-Gm-Message-State: AOJu0Yxwjvh3lKMohxDcmbqHoDA1ATstPtM5BsP9IQu4+odrurguGuAV
 Rsx2iQjTz6EXWx5sDuGMw/AOZNW9mdRS4jWbpLJ8wiC8Kg6B2hnSCU1iGOkvkAKpjjMD9VnJHh/
 Cls+f4u7G3dPwEm6tg1HzZ99D2vAlWYQMzgw/Uw==
X-Gm-Gg: ASbGncuJP6Uj5KnDwpEcmUe+4GRidyFzadfpZAUJoq5FpA04L4qA7ag0I3kPxoScgbJ
 U5AQei/goLYVuyvzRiqWrRUabCtJ95LXt1Lcjia/O6xPI6eBmJgAfbFbjvZgmYg23whgjJP78
X-Google-Smtp-Source: AGHT+IEm64yLq39QeHQsjVEFl3o8XOkjokmngu3WrRGqt4w9rAAB6jXFxXDUH0a5mX03J8rr6o6fjQPh4/ShfgBdeik=
X-Received: by 2002:a05:6902:15c2:b0:e5a:b05e:4da5 with SMTP id
 3f1490d57ef6-e5b25c1431emr1944318276.43.1738761122570; Wed, 05 Feb 2025
 05:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
 <CAC_iWjJnGGLhSyZFyF3jju9Evq9hY792jsDD4bL33H+6E2x9+w@mail.gmail.com>
 <6e34f324-f9ea-476c-854d-92574f35ae9d@amd.com>
In-Reply-To: <6e34f324-f9ea-476c-854d-92574f35ae9d@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 15:11:26 +0200
X-Gm-Features: AWEUYZmWqz93KZXm762znSP5_l5Az3tjg-4FJ519_hNbshHRTJAPD9O1aOnaM7Y
Message-ID: <CAC_iWjL+p=f+UKyKTEu0fB1pNKWKYE1uvqJs43LU6y7vjn_z9w@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
To: Michal Simek <michal.simek@amd.com>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Marc Zyngier <maz@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Sam Day <me@samcday.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>, 
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

On Wed, 5 Feb 2025 at 14:42, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi,
>
> On 2/5/25 09:22, Ilias Apalodimas wrote:
> > I'm just replying to myself here but I'll send a v2 when the patches
> > are reviewed.
> >
> > I can add the linker under an ifdef, so u-boot size won't change
> > unless a Kconfig options is selected
>
> I think you can just do it for alignment not really big ifdef in the file.

Yes that's what I meant, I can have all the ALIGN(4096) stuff in an ifdef.

Cheers
/Ilias
> Definitely this will be needed for our mini configurations which are running out
> of OCM.
> Feel free to look at xilinx_*_mini* configurations.
>
> Thanks,
> Michal
