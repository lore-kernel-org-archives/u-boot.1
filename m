Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B53CC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B4F81B4B;
	Fri, 18 Apr 2025 16:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XXuRnMAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EBA81F45; Fri, 18 Apr 2025 16:18:13 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509F880584
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3A88E3F322
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744985888;
 bh=IvcjvN1BtaEPCUc08ejwcmYoph/cqW4wzkwzUjt3s/M=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=XXuRnMATWRe6d7CxsH++6W2hjd0dX5ysCB3Vpawp9isxgcgPZZ2EKURk/EU+qIVl0
 6uog7E8GtrC/KpMm0uqFbEZ1/85mZBwJ2Xe1H4x5kF2eTwHxq5S6l8ph5doT9DKddT
 I4p9NILKVlKSYIrNiDywHv076F981aGpt1eikgPfeCCRdjmVpn6FEaBp95oCHFt4uS
 5wLESALVkXwayVdSRtFBIk6fpdAguR0QAcxsf1iFexgUFlskagHdr42e7kItChIJO4
 aK5QPKYv9Sb6dN10lfyS/MqfChvjDTGILOp1dfFMnQkco5Im+xLXrvDn9uW/PanWcu
 Of/gsLGzvTw7Q==
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-afd3f1adff7so2104008a12.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985886; x=1745590686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IvcjvN1BtaEPCUc08ejwcmYoph/cqW4wzkwzUjt3s/M=;
 b=YpCkxnl0zwLSyJKWmL0D1GlqPSl3oR6ldl1gxPTIKGOVmfTiXqCmV31JLFdOBLBmWI
 6wvZ82Zodp0mpy4dYzblKxDBUmFo4r2Ce/NbN2go9lx8smz2boDxhL7/ILQ1f3SIBcgb
 QA/BWwYjfifKTH8mrf5qhFWvxf7G9KkjsObVdHFFRBnzbJ36jYWBXAzlrFVfe98gnwFJ
 gPiRad+Y4fcRCP+HPahWOsEs/8at5hOdgZK5Xi82h/UQ2nxcPxzYb5YFSFagoMlZVnY9
 T6spz6wPB+JIV8mO2caTjjycVPWD+E+EdbrVH1Uj5m7GEC/ldTDD1r1CV8Nkj6/oARC2
 hamQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmSTW4Qsv8uC4AZluudz55XAywDuH9zAeaAmJFj4VdNU9BQMSePH+yyDuM1taRbCSIOpUbuEw=@lists.denx.de
X-Gm-Message-State: AOJu0YxFAhHSuEmaPQUQYv6jpf/Qm5z/J56tS9OPFFir07MZf4TExc85
 w51cud9wWebtZW8DY3J4D+NS1Lc9ZQGYIXzxofChKeicp2RiOdFx5FJly7gs16KLReYl0E4Nm3t
 HuuoT3n+sqFFCaaMgz014efFWFLUsSOY/yid6HZ9PdsUEOz5NwVKeji6ZJwI7DBiFWP3+pIUBR/
 7+1+BG5jGHLEbQx1jH8TCYb29YRXP1FRWerkRVvZ5NbA==
X-Gm-Gg: ASbGncsJkplsyb96CsVPm/+t/c8qxV5OG0/eqZludPFn6aI+IedOfknGFeairjAEJ/P
 PpsJ1iKMSM8ldbbP73k2IxC/5v97VHf9+zIgvO1SBcvMvVK0p+1KwH2J1VhKbxs/xOw==
X-Received: by 2002:a17:90b:280e:b0:2fa:6793:e860 with SMTP id
 98e67ed59e1d1-30879a25026mr6003813a91.0.1744985886393; 
 Fri, 18 Apr 2025 07:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOxmo38dkKZ7IxZ2FMJ0ve2Gbbgjnv/PPF8fyFxgX2LGCLBmjWL/LWcGTB/SnKmSYgEtrweeRO+O5RQ9QXF5w=
X-Received: by 2002:a17:90b:280e:b0:2fa:6793:e860 with SMTP id
 98e67ed59e1d1-30879a25026mr6003770a91.0.1744985885966; Fri, 18 Apr 2025
 07:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
 <3148f171-8bf5-4412-97d4-684c6c456499@cherry.de>
In-Reply-To: <3148f171-8bf5-4412-97d4-684c6c456499@cherry.de>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Fri, 18 Apr 2025 16:17:56 +0200
X-Gm-Features: ATxdqUHyWD-iOARvIDXuqz6GBCDxZtrHQjtRdPOOP1nHsWjMn-_dXkHJiVFdjNc
Message-ID: <CAM=mAOm1SC_SjkC6AYr4T4ThjAMCTF89wz4SVuwOYaN5vj2H5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, 
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

Quentin Schulz <quentin.schulz@cherry.de> schrieb am Fr., 18. Apr. 2025,
15:52:

> Hi Simon,
>
> On 4/18/25 1:39 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de>
> wrote:
> >>
> >> Hi Heinrich,
> >>
> >> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
> >>> Currently we are no able to build with configuration fragments in our
> CI.
> >>> With this patch buildman gets a new argument --fragments for passing a
> >>> comma separated list of configuration fragments to add to the board
> >>> defconfigs, e.g.
> >>>
> >>>       tools/buildman/buildman \
> >>>       -o build \
> >>>       -k qemu-riscv64_smode \
> >>>       --fragments acpi.config
> >>>
> >>
> >> What about using:
> >>
> >> --fragment acpi.config --fragment fragment2.config
>

Why should we type so much?

--fragments fragment1.config,fragment2.config is shorter.


>>
> >> ?
> >
> > Yes that could be useful. It would also allow wildcards, although the
>

Wildcards would be matter of the Makefile.

> code would need to drop the config/ directory prefix. Also, I see that
> > -z is available so perhaps that could be a (bad) short option?
> >
>
> I really dislike short options, but whatever floats your boat :)
>
> > Another idea would be to also allow specifying the fragment name
> > without the '.config' suffix. Less to type.
> >


We can follow all those ideas in future patches. But first let us see the
first test running in CI with acpi.config. ACPI is what we have broken
again and again due to missing test builds.

Best regards

Heinrich


>
> It's actually a fair point, we do already strip the _defconfig suffix,
> and it seems config fragments are necessarily suffixed by .config, so I
> believe this is fair.


> Cheers,
> Quentin
>
