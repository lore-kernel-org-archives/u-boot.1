Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E6ECDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57F786958;
	Mon, 16 Oct 2023 14:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bv+eVImm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31EA085423; Mon, 16 Oct 2023 14:24:06 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2387885423
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c50ec238aeso30811711fa.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 05:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697459041; x=1698063841; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RSB6Eov0bh9yboIWU60Xlk3MvdAjlOJ75BPPk8VCexc=;
 b=bv+eVImmOeT3U+JMZeeDeVqnrnTSuXMH3aH4Bvf2+HkNjAeJW1oR6b6h/qH2LmKLcK
 5AFU5XMmPH5xiTc0nJfNJkDrgU6ZlbKo6gEqMvbACondU9DhbHg9QVv+meD81G4o0nSd
 jObCVpYwRsi/GqDHcYQ/UFPOr7QQf8Quc+Mrb5fhSxpOtpqdKl8o25Q7dKvagS46u+nH
 U5bb/CiM3ElYItZ32fUrJn48+CgebcPCyiI6SLV5F2cswZBN7Bpt80W/CPIuC5g1a7dz
 XGBJg7b2hNR+AlFeSMIU3B00W5i1mi0KoBKeydJsBuRAV+5vbSesOpsrelfEjesU8pE4
 NN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697459041; x=1698063841;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RSB6Eov0bh9yboIWU60Xlk3MvdAjlOJ75BPPk8VCexc=;
 b=wdyUNwCDUDkVL95e9BXkwD4ccVceEtPrXRscYsg9UbWHkeUlZq9mCYOJ2yVgqHT0KZ
 UiyYn9v0d/3K6k0HYpP/bcd20YFmRZrNHu+X8a4xAEmRmGMgoTa4bobhauhPzBGobT2h
 WAVFEFHPo1bk985f12Qj62mr0twA6+SG4iZ3k96DLu352WHG8VaYidT2N02GUm0dJp58
 Zay+GZxWDvOpqk1Go1ywOLc9S10yPLnwg4H6FPRah/GWppTHoacGHzgtybnCab4Z1hIc
 hmpFEklH2e289QEG26GzB4GeawltK5tmwuwf2nVTaV/QNYCPbj/YBR6JCVG/pvYIxmye
 qbMw==
X-Gm-Message-State: AOJu0Yxx49rp9hzMNxoS44OkzHZjSd0k/t8vRusBBqv3wesQOWqq5JGq
 0CtRQowmr3MB1eW3CIOBU1s=
X-Google-Smtp-Source: AGHT+IHUjjRegAYtdZUS3s/vX61Hfc5KGpZSfqx5ukNpUT22rSLElfycOdTeO0MbJ25FEOOQ9eB7AQ==
X-Received: by 2002:a2e:9d58:0:b0:2c1:3d9f:1f4d with SMTP id
 y24-20020a2e9d58000000b002c13d9f1f4dmr30903767ljj.9.1697459040861; 
 Mon, 16 Oct 2023 05:24:00 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05651c205100b002c50ba4a047sm1295185ljo.80.2023.10.16.05.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 05:23:59 -0700 (PDT)
Date: Mon, 16 Oct 2023 15:23:58 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pavel Machek <pavel@ucw.cz>, u-boot@lists.denx.de,
 Detlev Casanova <detlev.casanova@collabora.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Danis <frederic.danis@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] pstore: Use root address-cells/size-cells as defaults
 for reserved-memory
Message-ID: <ZS0rXlNfPjP5dLEa@skv.local>
Mail-Followup-To: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Jarrah Gosbell <kernel@undef.tools>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pavel Machek <pavel@ucw.cz>, u-boot@lists.denx.de,
 Detlev Casanova <detlev.casanova@collabora.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Danis <frederic.danis@collabora.com>,
 Tom Rini <trini@konsulko.com>
References: <20230826121652.2487643-1-andrej.skvortzov@gmail.com>
 <f9fc81a5-1505-4cb3-8b65-798ddf16e1aa@gmx.de>
 <20230826194127.30117656@slackpad.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230826194127.30117656@slackpad.lan>
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

Hi,

On 23-08-26 19:41, Andre Przywara wrote:
> On Sat, 26 Aug 2023 15:10:10 +0200
> Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> 
> Hi,
> 
> > On 8/26/23 14:16, Andrey Skvortsov wrote:
> > > u-boot adds reserve-memory node, if it's missing, with following
> > > properties:
> > >
> > > ```
> > >      reserved-memory {
> > >           #address-cells = <2>;
> > >           #size-cells = <2>;  
> > 
> > This defines the size of cells for the children of reserved-memory and
> > and for the ranges property. If you set the cell sizes to 1 you can no
> > longer encode 64 bit addresses.
> 
> Yes, this is expected in this case, the Allwinner A64 SoC has its memory
> map (including DRAM) completely below 4GB, hence the root node can go
> with 1/1.
> 
> > 
> > >           ranges;
> > >      }
> > > ```
> > >
> > > But with these default address-cells and size-cells values, pstore
> > > isn't working on A64. Root node for A64 defines 'address-cells' and
> > > 'size-cells' as 1.
> > >
> > > dtc complains if reserved-memory has different address-cells and
> > > size-cells.
> > >
> > > ```
> > >       Warning (ranges_format): /reserved-memory:ranges: empty "ranges"
> > >       property but its #address-cells (2) differs from / (1)  
> > 
> > I cannot find any such requirement in the Devicetree Specification 1.4.
> > Is this a dtc bug?
> 
> I think the culprit here is the *empty* ranges property:
> "If the property is deﬁned with an <empty> value, it speciﬁes that the
> parent and child address space is identical, and no address translation
> is required."
> As this is contradicted by the differing #a-c/#s-z properties, it looks
> like dtc has good reasons to warn.
> 
> > 
> > > ```
> > >
> > > This patch takes into account address-cells and size-cells of the root
> > > node and uses them as values for new reserved-memory node.  
> > 
> > Reservations may be above 4 GiB. How does your patch consider this?
> 
> If the root #a-c/#s-c don't allow for more than 4GB, then it's for a
> reason (in this case, the A64 being 32-bit only, even with AArch64
> capable cores), and keeping it isn't restricting it further. So I think
> copying the root properties is the right thing to do. I think almost
> every other 64-bit core uses 2/2 anyway, so it's just the odd outlier
> here.
> 
> Cheers,
> Andre

Are there any comments I should fix to get this change merged or maybe
another way of solving this problem?

I see, that patch requires review from Tom Rini currently on patchwork [1].

1. https://patchwork.ozlabs.org/project/uboot/patch/20230826121652.2487643-1-andrej.skvortzov@gmail.com/

-- 
Best regards,
Andrey Skvortsov
