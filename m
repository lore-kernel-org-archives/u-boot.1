Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3FAD3C906
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCBD6892E7;
	Sat, 19 Oct 2024 13:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U2x4E1pN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8970A892E3; Sat, 19 Oct 2024 13:51:17 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67274892A0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so21584476d6.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338674; x=1729943474; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xb8vz7B367oEx0arBlfaS+mN5Jfts3PakFXTTFc8QRo=;
 b=U2x4E1pN7hlT7gJ7K+1KsPTbhdz90eowzy7Sj7pCy0tpF1ocjO5QRP9kcv4YmKO7j+
 FbQqc4Ngiceo2mzQgLcfnfpAZWXwW5Wg7Qz7X9VXqXBT35lsC3wN8qSRgjgSRXZUfgvF
 lTuS4XIG8rt+6ANdZ2pey2aXPcQ5j42Yur1j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338674; x=1729943474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xb8vz7B367oEx0arBlfaS+mN5Jfts3PakFXTTFc8QRo=;
 b=YepNnOxWCz7d+mN5vqDNRwiRgrthoLPyYn3YFgebyio4BrlQAyVfIvATdm7KylpqRp
 cXz7uWLcZqD0lBA9EASjtc6yuGb98sgv9CYv3AyXZuRgAvalfFNdXF2vkPBZ4mohs1dY
 ahTvVl3NpZtw9vKX6QGreE55kQLr4gykN7jtZgAzSqxY2co5mr0UGcuHWTCwbtoR+4FB
 90YvBnl8pPCUDBx+IAI/8dW48a4UMcjuC4tCeR0eAFhAo9iwW3ryHNxKn1Cqb/xSjW/O
 wiM4upveMhgORqDypoiOlodOc6mgu3pe5wLJhHK5q2CmKh2omv5j8PSuRH2w+nHjXby8
 RLtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4bgYOEQgvvkg87gpklFmzVOCKjUnU++iN5P+4MeJXzWvFo/gYtWQ1ozw15ohfi8IIe5al6kQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwgDdXaEi6gGgu/KbkUg2s/Ah2HFI4CeIVfwdGq3bhSNN19kwWg
 KoqLm2PGvtI2/Um9Dsm9SV8nfvRxBd82tHe65SP/XSZRQOQE2zbS4SBXLPlJmB1YQRfA2HbuFyr
 cRuBtqD3TAnhbhgxA0fpwmbuL6DoNLTXTHXfw
X-Google-Smtp-Source: AGHT+IHEq3q0eA3GXmbakixtb9fQ7JyOFhb6gjZ6iiUPZ3rIYz11mKcY2jCCQO+0Wkk1n1Y9B8UOzy39OHd4D9p6r6o=
X-Received: by 2002:a05:6214:3bc6:b0:6cb:f853:9eca with SMTP id
 6a1803df08f44-6cde153ab45mr74829286d6.25.1729338674294; Sat, 19 Oct 2024
 04:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <CAC_iWjKD=05pf=gcfCPUA0mGNbAX+jjyx5D03y0MWJRgxYDPOA@mail.gmail.com>
 <CAFLszTgJW2KPbD1dogSVKbxgyYtvKGgSAcB_j5kXtWdkTGvtNA@mail.gmail.com>
 <CAC_iWjJdoFLAyaa+NBoY1Hm0Q140ExU0rq-RKEqDV_yki9jojA@mail.gmail.com>
 <CAFLszThSFuAPnsOTw_4w6raWJzOojp16ULT88s9JgwoWcpMwJQ@mail.gmail.com>
 <20241017233458.GQ4959@bill-the-cat>
In-Reply-To: <20241017233458.GQ4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:51:03 -0600
Message-ID: <CAFLszTgKLYa9RYERvAiuJ89wSKG-Ane=FxsDuvvFBpBpS0QF+w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Adjust initial EFI memory-allocation to be in the
 U-Boot region
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Artur Rojek <artur@conclusive.pl>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Tom,

On Thu, 17 Oct 2024 at 17:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 17, 2024 at 05:22:52PM -0600, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Tue, 15 Oct 2024 at 07:32, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Tue, 15 Oct 2024 at 16:26, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Mon, 14 Oct 2024 at 22:28, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Sat, 12 Oct 2024 at 00:23, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > U-Boot relocates itself to the top of memory and is supposed to avoid
> > > > > > using any memory below that region. This allows the maximum amount of
> > > > > > memory to be available for loading images.
> > > > > >
> > > > > > The lmb subsystem automatically protects U-Boot's code and data from
> > > > > > being overwritten. It relies on this region being a contiguous area of
> > > > > > memory. This setup has worked well for at least 15 years and has been
> > > > > > documented in the README for as long.
> > > > > >
> > > > > > The EFI_LOADER subsystem currently uses memory outside the U-Boot region
> > > > > > when starting up.
> > > > > >
> > > > > > Some of the downstream problems this causes are:
> > > > > >
> > > > > > 1. It can overwrite images that have been loaded
> > > > >
> > > > > So can the load command
> > > >
> > > > Can you point to where? If lmb is enabled, it should be using that, so
> > > > not overwrite anything.
> > > >
> > >
> > > If you load the initrd in memory X and make the kernel ovelap you will
> > > overwrite parts of the initrd.
> >
> > But lmb stops that. It is actually what it is for.
> >
> > > Let's try once again, the ''''problem''' that was discussed in IRC, is
> > > that the initramfs overwrites memory that was allocated by the EFI
> > > subsystem *because* we haven't merged the LMB followup patches yet.
> >
> > OK, my problem was booting Ubuntu where the bootflow was unbound by
> > exit-boot-services, resulting in freeing memory (and re-using it)
> > which was still in use. I don't actually remember what was in that
> > memory, though. This was over a year ago, when I sent my first version
> > of the test[1]
>
> This was on x86 as well, yes? I believe that's what you said on the call
> and part of where people get confused I believe.

Yes, x86

Regards,
Simon
