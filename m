Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314E7C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5981E80A2A;
	Thu,  6 Feb 2025 14:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HVf17veY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB0D80885; Thu,  6 Feb 2025 13:31:29 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CD4807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5dc82e38c10so1897636a12.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845087; x=1739449887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J+djlXfAUrPc3nBt+XixDFxebBZOcCwg/PigXbfj7UA=;
 b=HVf17veYJ+adeS6ur8F6zVKLIGGAYkTGfu7avzPgJa+bN8UfLwBzrRn70Lumix3Yq1
 0nVngTsyh7YobZTexi0E6W7e0xcdkn099qwMHUGW3ESYDAMDOCklnCxmEAdp1dl8lv62
 L2J2VB6Ni52JK2wPw04VCJEftCbk63mXdIzK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845087; x=1739449887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J+djlXfAUrPc3nBt+XixDFxebBZOcCwg/PigXbfj7UA=;
 b=NcjBWRTRAQ7gna6GVDZvgTkQ/iwbffFPuaEkkIZZUPkdqU+dw91PPU28mBKSnx0PY7
 Typrk+5WkFHrBeoCFQmNzp9D9U36wsvQZ9dkJD6XrFDuGuscI3kv5sYCfkt12tnwjZLt
 /5JTkgon4drTrDdvq1Iinb+fB+d8iEGAqNTeEy9HjvJ7tOWS3n1BBghYg341cdaKxwJk
 hDcvCumTCHN3xvyP1mKW3ddcRDD9rITyJkYuc9KaCu3nxGm3xK8MtFWJXUzDlFaMfRtR
 /RTCxweacu4ABYkZqQ5z0Q9J0JrxuhcgAd/qUDjQW1WoMKjCaqOw66w0gNjrYZMnDmHs
 JzWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJHjYAWPdxDBbSM9vlrMbO/AfEHm59QUK3Aw6XqdITkCn4qRKtWyZq+3TcfXmXzsytDhh3Hg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6ZV4bHATaygFDLwrHpvklWKbIsPfTUUsWGqfLxDY5qrVZSzCz
 WzTJHlRMt2UhMJ/wgzEdEr2SOLKiU6dg5q0mGNl18hgL5IJ3yYcWjuPnMQsn6fAZTF9oqWcWxrx
 tqvhyN78Ihs3SA8QN6CPLz/z4ZLDaXALEdhvY
X-Gm-Gg: ASbGncs3ivfgNDqPPqCEYgzSsZWIP8Ivyub289q3SY2wROxS3fXqUWCXJhR723lkeFS
 AmAFR28kHglI4tBxbEkvmhU9RT6YfLVZN0HLLqijIOF6Dh+/iqis8mPJhB0LK/00ejCrl7beWyA
 ==
X-Google-Smtp-Source: AGHT+IFGeBNKIYqXUrH4wp/a5AyUhWUvW42nC1kh367Ge3cOqY7Tv3dsD0lwMhhH+3Iapc8N7IGyaknYcPvBW0brNDE=
X-Received: by 2002:a17:907:72d0:b0:ab6:de35:730a with SMTP id
 a640c23a62f3a-ab75e2101afmr756163166b.8.1738845086634; Thu, 06 Feb 2025
 04:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20250205071714.635518-3-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:31:14 -0700
X-Gm-Features: AWEUYZlqBRh_HsPuxXPzlq_-6BRoRBoyU48-658Nakhj-2JxGj33pXYs1_S1_v0
Message-ID: <CAFLszTg3rKQHGMawKTE1RGdqbdFnkkXW26Y99WpNRDOusp6yxg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] doc: update meminfo with arch specific information
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Feb 2025 14:07:31 +0100
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

Hi Ilias,

On Wed, 5 Feb 2025 at 00:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Since we added support in meminfo to dump live page tables, describe
> the only working architecture for now (aarch64) and add links to public
> documentation for further reading.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  doc/usage/cmd/meminfo.rst | 71 +++++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 18 deletions(-)

This is useless information for most people. I would rather have it
behind a flag.

Regards,
Simon
