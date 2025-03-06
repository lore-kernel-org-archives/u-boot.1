Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA89C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E670811C1;
	Fri,  7 Mar 2025 00:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fgs9iPQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F738122F; Fri,  7 Mar 2025 00:30:27 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D585810EB
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac0b6e8d96cso179877766b.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741303824; x=1741908624; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x0jSv11dXwzlTAk4Qktwbl9pKDcPmTmmUorK1Oo3iVA=;
 b=fgs9iPQb95ON82QE2B4S4FurFHC9dPKSJbjzWsfdBoWadiD1cCa8RjiSRoKHPHdqkw
 JFWvPQQHk7pU+EfDQgKJ6Ma4ZmFpKTCZkYan3cML9AwvDaCYA61DUTxe+Fa5qgTeQSZE
 2N5tLYpnonGI3Nhlvc+mIFwkxqBNU1W9ujl1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303824; x=1741908624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x0jSv11dXwzlTAk4Qktwbl9pKDcPmTmmUorK1Oo3iVA=;
 b=BTMhstH/yRy5JdnZbpiq222eHwvSWWwvBLvRzAn7c20LjxcvXQ6Ow6AbWvRIJljklt
 X6pIL9c0uLGpRl0QvkviqSUHBRgUc2tIV7OT6zZrh1PBYPD86Cnlq3J7gkTmLaWCNAyq
 fkz20772h7X0mtnPy+klCWUJmxoKWm+qBR/Z6/JYMI9r7F0uAmdYY7nVNahnGaoMk49N
 vs5fBxtD8mB65VdG5u6NB/RNd6/V2mVhWmOS27ioOEtoCimhaWrlD3w5SN7CMo5n4Kqi
 oqf2p0c5EiZaSp2hTJToDqkSwT3NhaKpauvlb7X7DgrEbamcSJc8qYHbRFLsH6lgLTvl
 AGXw==
X-Gm-Message-State: AOJu0YxdZmI1Ziy+oxHvE2Z5llR5B4d6FxjTKkyg9GRnmC/V+/MBlGML
 /Kjxs+7F88MnrWqRHC4y0tRmhORj6qtn81Xk16FLIVhuQ7+fHnSVtgHtp0o+wQiyfgAxsLaSciV
 Bv1R4U5aKF6FgQxmQU1KUJwAoFMrF+t9zdrFb
X-Gm-Gg: ASbGncu5qpSnx3n6N2mX9bySjG/F8qaqkHo5oO6e4yIFxnncHcFjSVs7SbFGljM4GbN
 cMFxds/eTuhjLABY068wzMHiDQdRXO2qx1FWGu44RTZyRg9LxU055lu6+U0DPIyLmEDwfuq26Lr
 8txgt87JEBIl0ttXSbbFFWPYjve9w=
X-Google-Smtp-Source: AGHT+IFWCq3nLEgaTEncHDOQ2lJysFx5Kpf1CAW1VFl7a5Hxie0yEh93/fxZrKlw1lsGDMLanLQdrpv4GrKmGDckrGQ=
X-Received: by 2002:a17:907:da2:b0:abf:6d24:10c8 with SMTP id
 a640c23a62f3a-ac252f3f61fmr91160366b.53.1741303823685; Thu, 06 Mar 2025
 15:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
In-Reply-To: <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 16:30:12 -0700
X-Gm-Features: AQ5f1Jo_3rDwRfZzkhS_kuDbLJEh3attW1ayZv5TDJh0qaGicsbi7ZvbJjzjmnU
Message-ID: <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Sat, 15 Feb 2025 at 08:30, Marek Vasut <marex@denx.de> wrote:
>
> On 2/15/25 2:38 PM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Sat, 8 Feb 2025 at 14:27, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 2/7/25 1:49 AM, Simon Glass wrote:
> >>> Hi Marek,
> >>>
> >>> On Thu, 6 Feb 2025 at 13:52, Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> On 2/6/25 1:42 PM, Simon Glass wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>>>>> FAILED (errors=1)
> >>>>>>>
> >>>>>>> So where is the SRK_1_2_3_4_table.bin file?
> >>>>>> See the tool documentation:
> >>>>>>
> >>>>>> https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/blob/debian/3.4.0+dfsg-2/docs/CST_UG.pdf?ref_type=tags
> >>>>>>
> >>>>>> 3.1.2 Running the hab4_pki_tree script Example
> >>>>>> 3.1.2.1 Running the hab4_pki_tree script in interactive mode
> >>>>>>
> >>>>>> The hab4_pki_tree.sh script should generate all those files.
> >>>>>
> >>>>> But with binman we want to avoid vendor scripts, etc.
> >>>>
> >>>> I believe the script internally runs openssl to generate that file.
> >>>>
> >>>>> Could someone take a look at updating tools/binman/btool/cst.py or
> >>>>> similar to build the tool from source? There are examples of others
> >>>>> that do this, e.g. bootgen.py
> >>>> Is this relevant to finalizing this patch ?
> >>>
> >>> Well, I don't see how the tests can pass if we can't build/run the tools needed.
> >> Maybe you can try to use the shell scripts to generate the missing bin
> >> file ? I suspect the script does some openssl invocation, which can be
> >> reproduced in binman ?
> >
> > But 'binman tool -f <toolname>' is supposed to build/fetch the tool.
> > So any such building should happen in that bintool.
> >
> > One of the main goals of binman is to reduce the work needed to create
> > a working image. If people have to go spelunking around the Internet,
> > build it themselves, etc. that is not good.
> What you are asking me for is not the tool itself, but key material,
> which is generated by these scripts.

It looks like someone has done this here:

https://patchwork.ozlabs.org/project/uboot/list/?series=446218

so I think we are OK now.

I've applied that series to my tree.

Regards,
Simon
