Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D3DD12D65
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EC483FA2;
	Wed,  3 Dec 2025 15:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AXagnY+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB83B83FA6; Wed,  3 Dec 2025 15:04:26 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D25883F24
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 15:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b553412a19bso5740251a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764770663; x=1765375463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c8vUoNexwUBmYqghquSfu7pj9PKwrNU1xD9xiyVZZ3U=;
 b=AXagnY+y0prMSbpb9S4Kqg8jhymRsWWtTunz25dxccO0hsxtiUU5+qys+YDGbYuy4r
 viLHnc0rWdar7X1S1pQCYiLFkypu/LKqHWSAJSJKM3CvfTka1YMSWb2SRPMpr/SW+RXi
 M7aKP8nGmNwBK4q16wZAgx1baYDTReMbiGg/9Nevi+FjSebY2n+WTOVt1AGJK3lPCo9H
 nDdWhas5nFxUqLNFq/WoRgPNZWp+n5DgvPQTfKnShnENp2uMelDvAb52UVw6uHupX++a
 ZP6oSaV7CD6MJNqpetMIzt2Aohj0FwD6RXHnIeUyngEK/x26ZorfUyluHCt+paoxhVPT
 0M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764770663; x=1765375463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8vUoNexwUBmYqghquSfu7pj9PKwrNU1xD9xiyVZZ3U=;
 b=DeDWkMyxl2ANXqeeKSTOGMAanUSCyMaw4y6RKrA/MAHOmWjcOW1ZLYhcfaN5RoN7Yy
 QuNq+tfpoHlDKTmYPMGYbY8lOL8YQbkZ368awRd9ryn1ImeUSkVVLqnaCSV8iKRVdfsl
 FrKRR+i6mOeefb6pnfbY8tMwqDIsopN3O8aePbiSI45hlZrYDqO/xX+JGKppeerAC4u/
 xoxfZICHFqN8IK/KsJVcDx8DJEXePOnyE2D989QPnqye9GOh8DC1ePpPxRIOR8XPeXjK
 pTfhatfwZL/AgbHutqHJDpt11xSH9GH4/4lQo7oNHNKUYvFqIQsXRnIFwykzisBvC/gA
 VAXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV2DKxq9ZoBPkoA3kKI7yk9dRiCNw7TwEquJl7vhKmO4+Yd5/Iu5/vjJYvfq0MsK+BdY229PM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7FOOOXdWUIB/SFgxVlQB7/HuUK/HvA3Zo0G3hyxWRUOHOvarJ
 9A14gm9Nw+JRVW87eMEnS5hIs43A+Okq4pZJZLcOBRMpk7DNnpAD3A/mtCAy74r7HgJY3Je7buI
 6XdaZegXzTxEY3HDXdAQ/JnaRaYXU2qw=
X-Gm-Gg: ASbGncsNXLiou5JAAyVDFUZEja487v8V4hgP7+Hcvs90pqmUqFFu0CY8H2A2UNL30yl
 EPf42oKEKYJTWOmdve4jYEIEcvdY9C4bMZpQC3cOPjYSjvXYhfV0XIlk6k03u3oTWhFtCG/As9A
 p+BKiljFuYnWd9Ov+a1UQmXrMODpIlTNW1tTaYvdKHbmY9MKyAjyvlkt59mexquWGQSaY/89PPy
 tU8e4Nvr11MkPO/TX84j055M0C1jJvoEYIohihU5UqtlH+F1z3SXuBcMX8o4r33NjIdsQ==
X-Google-Smtp-Source: AGHT+IF7SQoY/JwPkMiylyvuCoHber0hMzZjhlF/mYLQ/VK+1WTT+MTenIM3Krxb9XL6hCgrCqhRP0rJw8X4Fbk+TWo=
X-Received: by 2002:a05:7300:cc9c:b0:2a4:3593:6472 with SMTP id
 5a478bee46e88-2ab92ec938dmr1421668eec.34.1764770662837; Wed, 03 Dec 2025
 06:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
 <20251203110108.1d93975d@kmaincent-XPS-13-7390>
 <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
From: Patryk <pbiel7@gmail.com>
Date: Wed, 3 Dec 2025 15:04:10 +0100
X-Gm-Features: AWmQ_bknBHvLB-P6Leiycjo2QVsxoVWwcaSAg7dyAsr3mfznyMCKkmFAbHhm9xA
Message-ID: <CA+DkFDbecwtJkX-7wHzQjhVbi-tpjzZVzc7N3kvhr5OtKivgWA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for fwumdata
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>
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

Hi Ilias,

> > > Add a new fwumdata tool to allows users to read, display, and modify FWU
> > > (Firmware Update) metadata from Linux userspace. It provides functionality
> > > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > > metadata, change active/previous bank indices, modify bank states, and set
> > > image acceptance flags. Configuration is done via fwumdata.config file.
> > >
> > > Made a few change to mkfwumdata tool along the way.
> >
> > Still wondering about the choice of putting this fwumdata tool in U-Boot
> > instead of TF-A. TF-A is the boot part that manages the update process and
> > rollback through the FWU metadata,
> > therefore, this is where it should belong.
> > Why, in the first place, mkfwumdata was accepted into U-boot instead of TF-A?
>
> The actual update happens via capsule updates only, which runs in
> BL33. TF-A needs to be aware in case it's involved in the boot process
> and fails to boot. In that case BL2 is responsible for booting via the
> other bank.
> But generally speaking it's U-Boot that processes and usually updates that file

If I may add something - actually for me this is not that obvious,
e.g. on our platform we update the metadata directly from Linux, not
from the u-boot capsule. As far as I'm aware, the ST, in their
OpenstLinux does the same. I'm also not sure why it would be the bad
idea to do this from Linux. Ofc the BL2 handles bank selection as well
as rollback in case of boot failure on a newly selected bank.

Best regards
Patryk
