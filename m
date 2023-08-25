Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E1C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 12:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66AC686A5A;
	Fri, 25 Aug 2023 14:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3EE86961; Fri, 25 Aug 2023 09:21:09 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7428650F
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wens213@gmail.com
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso5091915ad.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 00:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692948063; x=1693552863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zkrgdFyWhCPa0hX6ixyHueHhKsAL+l2RFA8/kdDjrrs=;
 b=MLztkw4cxHNHU9IuPwVUAi7MnPTAm0J9yoXVS2FEbykDZISq+JZYEkXJCQAGAOb90h
 cb02o0AdH32pQkhcJwTZa1AgSgizQpRvtZETPxKOEu4UZrb4WGaSttpQhZ6HXIFewzcE
 LqTvuallcmBgZpTAMcUSEpylotX6q4ii4EGurNKpXNJTD9m8VfYS/+cqZ+9gEMdj3J47
 a085mzJg2cXt//LV5I5GHqNtY6CDbO50jZKnPq1aEWbh/0y5o/kS3gMZF71OrQEpXwjP
 9b+hOZC79ptHkF8ks9Ok9D6NMCTWoE7rCZ7kp3poOSrgV8Vnu1A9n3P+EZJ9DqwhSdSH
 QPrQ==
X-Gm-Message-State: AOJu0YzOiSKI2RN7HrSnZQCCTillDHoMlVMJAWOCXxaVWQuoHim/Je5d
 OT3RWdPxkWqPasUvghu4dm72CGAikOU=
X-Google-Smtp-Source: AGHT+IHfT+q599eqmiZ+FibT4D2s1+YRtMvAgiYq5vobKhAz7nHrNQb50Rwfq4eNsJB3Cepbq3oegA==
X-Received: by 2002:a17:903:1c4:b0:1b8:4ec2:5200 with SMTP id
 e4-20020a17090301c400b001b84ec25200mr16598224plh.2.1692948063278; 
 Fri, 25 Aug 2023 00:21:03 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com.
 [209.85.216.47]) by smtp.gmail.com with ESMTPSA id
 c13-20020a170902d48d00b001bd28b9c3ddsm899851plg.299.2023.08.25.00.21.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:21:02 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-26d5970cd28so382560a91.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 00:21:02 -0700 (PDT)
X-Received: by 2002:a17:90b:791:b0:267:f5d1:1dd3 with SMTP id
 l17-20020a17090b079100b00267f5d11dd3mr14089582pjz.11.1692948062664; Fri, 25
 Aug 2023 00:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531201520.15479-1-CFSworks@gmail.com>
 <20230814213854.408962d5@slackpad.lan>
In-Reply-To: <20230814213854.408962d5@slackpad.lan>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Aug 2023 15:20:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v645V85s49DRrKw8-TcR5e697D4nVp3QnPGDET46H49dZQ@mail.gmail.com>
Message-ID: <CAGb2v645V85s49DRrKw8-TcR5e697D4nVp3QnPGDET46H49dZQ@mail.gmail.com>
Subject: Re: [PATCH] sunxi: psci: remove redundant initialization from
 psci_arch_init
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de, 
 Jagan Teki <jagan@amarulasolutions.com>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 25 Aug 2023 14:39:25 +0200
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
Reply-To: wens@csie.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, Aug 15, 2023 at 4:40=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Wed, 31 May 2023 14:15:20 -0600
> Sam Edwards <cfsworks@gmail.com> wrote:
>
> Hi,
>
> (CC:ing Marc and Chen-Yu as the original authors)
>
> sorry for the delay, found that mouldering in my Drafts folder.
>
> > The nonsec code overrides/handles these:
> > - Setting PMR to 0xFF happens earlier, in _nonsec_init, so this is
> >   redundant.
> > - The NS bit is not yet set: it gets set later in _secure_monitor.
> >   Trying to clear it here is pointless and misleading.
>
> So superficially this looks alright, but I am still somewhat reluctant
> to apply this, see below ...
>
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  arch/arm/cpu/armv7/sunxi/psci.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi=
/psci.c
> > index e1d3638b5c..f866025c37 100644
> > --- a/arch/arm/cpu/armv7/sunxi/psci.c
> > +++ b/arch/arm/cpu/armv7/sunxi/psci.c
> > @@ -300,14 +300,10 @@ void __secure psci_arch_init(void)
> >       /* Set SGI15 priority to 0 */
> >       writeb(0, GICD_BASE + GICD_IPRIORITYRn + 15);
> >
> > -     /* Be cool with non-secure */
> > -     writel(0xff, GICC_BASE + GICC_PMR);
> > -
> >       /* Switch FIQEn on */
> >       setbits_le32(GICC_BASE + GICC_CTLR, BIT(3));
> >
> >       reg =3D cp15_read_scr();
> >       reg |=3D BIT(2);  /* Enable FIQ in monitor mode */
> > -     reg &=3D ~BIT(0); /* Secure mode */
>
> I am scratching my head on this one: I see it deliberately being done in
> the original patch by Marc[1], and wonder why. If I read the code and
> the architecture correctly, this routine is called only(?) from the SMC
> handler, which means we are in monitor mode, that only exists in secure
> state. So the NS bit is irrelevant until we switch to another mode. And
> we indeed set the bit later, before dropping back to non-secure. So I
> agree that clearing the bit is pointless. Was it put in to be more
> robust, for other potential callers of this function, for instance in
> the boot path?

IIRC the GIC manual says that the secure bit is set or cleared to select
which bank of registers is accessed.

And I suppose it is here to be more robust.

ChenYu

> Does anyone remember?
>
> Cheers,
> Andre
>
> [1]
> https://source.denx.de/u-boot/u-boot/-/commit/d5db7024aafc5ea603f3a34f83b=
b29a1eaa3cbe7#f377950449a5dba076796d9e48fbd21f5d6ac545_0_65
>
> >       cp15_write_scr(reg);
> >  }
>
