Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C04C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0916580AD6;
	Tue,  4 Aug 2026 18:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnI009x5aVje; Tue,  4 Aug 2026 18:13:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FBB980AAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867199;
	bh=Fd0w7cCtAliGj6dblx+PPaEXeHPzjHcLr5lBqFpnOKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ABuegH3eTcjY4o2hs2V+gZOIbObi13S1/rwHaXBA95Oq+gjugy+sYoLHaiAfML1at
	 RBG4pzZKrbYIcPFrF6Uq/Sf3EHKJGk++V7hqrd5Mcjguv/rSHzV9wGwpCfA9zh5896
	 /sffgj9TeZ6KUTcZNN07Fa3+LtFwBSS/QxeiaIrvgcIae2f3nJ8OAiHxGNFtk/HBgM
	 K3NNW+JRu31GLbJi6CTZ8JToTld6NU8/S5xM/BQ4CWYIo4q7lty/VXhHBmcUga66b8
	 xkPPmAMJZ33vIjDkAmDQ/QRaomq/W4tFm8YRUYoeXit9+16yghsjSOB5gBDIAu4ixb
	 dyNpb+wHX8VRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FBB980AAD;
	Tue,  4 Aug 2026 18:13:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09BA22AA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF990406D5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNMzHtQzh7Tk for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:29:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 02901406B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02901406B9
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02901406B9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:29:20 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a18180so5801998a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850159; cv=none;
 d=google.com; s=arc-20260327;
 b=nTyQFZhLBRHpsPr1A6wQsixZO5+fp5gT94Q63kioP8dIIif38RJSPDiI79bhHjGYmh
 ORXRuNlEESSa9sllJnOsEm93p5PBZwcVf7RCdijaJeeRIIiPZTniccb6qxRobOz4pwIq
 PHFf83FazX2ASSlVLLmrWYDcFrTkZ3Tob0fmoNWo+eb5uz7pgF0VXjgivqFxvYTu0FjW
 whD16PpjU9bv6Mry/WTPwVRz2MyjIVKx9rLK/i7K6clj+ggzfk6xIFlyfdzkGZ8G+VAR
 9Z31YIG4JQ/kj0LPEb0ToadgkcYZ7qagJvDHnR4XTzLC9sWi2jbiraq0Jg0mMWMbg6Ty
 ZB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Fd0w7cCtAliGj6dblx+PPaEXeHPzjHcLr5lBqFpnOKA=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=GmABBthED8rkJc5gVGhDeQAioZgL0/iDfcEkxmGeT2nQPmlGthpytlMfQk4KipFR15
 98Idep9k1Sa/uDlQPyDFMZuIThHu9/AKX/vHhoEGteqSRtt217qCUuE8mNGgXrhfU//y
 1fIH6PF2lmZBa9f0wxVG33r3rqNwi9UI0mFOQc4nyAFLK47R1KW3Xg5Kks1TuEVnh/mu
 AP5cpUz+igzHjawshAgZvlzZYpqi9k+eWtUAJ8pQB28R27ciolh3btt+PKsROGvlq2dw
 nR81lDkHwY8VzL6Zqgi5cxX+ImHt2rCJcgboTEVNMX7FEUHMRPtp6CN2RpQQrTVSiKXE
 z2CA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785850159; x=1786454959;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fd0w7cCtAliGj6dblx+PPaEXeHPzjHcLr5lBqFpnOKA=;
 b=ECUWPQAXC8wJ1hMtDtcZtpO3pquVV1Rdat78c6Qj9cKoZxYEWIRoklfg6BprlZ47Lj
 bAy7p8zfiOxNqMpUHHIH26QCH4SxF829RZNXQRnwpuJOHkNwucaMg5eDjB/A84oCR5D7
 j6SMBLD7NADRS54oRYYd8FsrNfwey8wpvqMaRTuHrwcQK26fxAekyzASy3oYx0PcRX7F
 DfeILDdH/k3bbbpHwEM5VICLuA7Sah5Is3mtkuwyCazUt8COQUAfzz5smnkdytDSXp3m
 9PARFLgGf0iqHT9xbeHwHiUbRABIWy0bLISGj70kG5UJEAhoyutLZiSHVSIFh3+6SOWV
 3tOw==
X-Gm-Message-State: AOJu0YyZVStKg5BRtUELWXfO6sZgdN+Uo+LxTJxXm75A+x7J5jKbAWlD
 Z0xKBZXyHFHYWdPT5r2/vZ0hO9UtS6bKqcrmpvkr1VMbLi33clSZkLPVWU60E5fBjFNyaPG6DpE
 DzhWruYFOhfPuX9KqfmVgAE4BOsaWrLslD1UAQDKFwQ==
X-Gm-Gg: AR+sD100tfjGeqrp/iPCikJ6OyixN8jOKYJvOcgRTRMy4P0Ve7Um9dixSNAerSfcCsT
 SWim8gVrYX8fzBzvrnHKBx+Ocf8lQJPnFyZMrob2688MVYzm3FgWGKKXTvRkLRe8MRVJwhls8d7
 +omLb5i+v9/NlrNZhwknPuP4qZJX0gXVDYtJOC4bzTP/yPTtIB0A1/9Ab4KlSQlww9qE4PYvUSm
 7hd4RTFwVuzgLGE8mWzRZAv7+yKAMn4HowMM1LOH6nZHtbiydrKxUayKroSbQckHl5VXfpwqi3f
 0qE0UkT7mhtPFuigB8C8ofQk4EMBPJjQRNzsukNBGw/DmWBT+l9aUMea/XzUzHpfJnVTsPKQGqd
 JXzOar15k8au8
X-Received: by 2002:a17:907:7248:b0:c12:695b:8876 with SMTP id
 a640c23a62f3a-c1fe8167532mr1160671766b.5.1785850158812; Tue, 04 Aug 2026
 06:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-1-acb97c172993@flipper.net>
 <CAFLszTiAP1Bib=Xpg-OK=x=pJCuG=N8f_bnxE7dv=YdM4x2ZOQ@mail.gmail.com>
In-Reply-To: <CAFLszTiAP1Bib=Xpg-OK=x=pJCuG=N8f_bnxE7dv=YdM4x2ZOQ@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 17:29:11 +0400
X-Gm-Features: AUfX_mzQYB-E6kVXyLFypLHdge0_lMkqvIKaXRaQXH2kQ0jw1cAdVqg3xZ3ffTA
Message-ID: <CAKTNdwHaxhnCy22VPMNnGo9Z=p3DF6zmQ8ixR-EsOpb9crO=Dw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] spl: Decide about Falcon mode boot only once
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785850159; x=1786454959;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fd0w7cCtAliGj6dblx+PPaEXeHPzjHcLr5lBqFpnOKA=;
 b=N2+eSp2pdbw20dFN4LZRQg7BUFHmZu6KbD9+9ph8NySdL6xb5IuJp7TgfxK31pvWqv
 HNHlwznD5/Bpga8LoNcl20Fgv+GQy0H/JP02gHFaCwIPf/UTrbQUx1P6Ct+APjzzU/11
 qAXJiqxmXsbOEH0iIWiIcm4VdscL2YyOM6eegbX+9qa6GdJ5MSujQiBP20CKjEXRo1sv
 TM2JdrrGoORsgQ+tVBlZJE5EyIdWEZ5qNkj95mlFgckd7kBavvYtQVkTQeLTH+lSC0Qi
 nplvRuEhkk0l3886MmgfGgpJjoNVt/LmHFo0O6V/U4+E26oq8mG2DWd82G2LzW5dVkR5
 vX2w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=N2+eSp2p
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On Tue, Aug 4, 2026 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > spl: Decide about Falcon mode boot only once
> >
> > Board implementations of spl_start_uboot() are not required to be
> > idempotent - the documented examples sample a GPIO or read a character
> > from the SPL console - so calling it more than once can yield different
> > answers.
> >
> > Add spl_falcon_boot(), which calls spl_start_uboot() at most once and
> > caches the result.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > common/spl/spl.c | 18 ++++++++++++++++++
> >  include/spl.h    | 11 +++++++++++
> >  2 files changed, 29 insertions(+)
>
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > @@ -105,6 +105,24 @@ __weak int spl_start_uboot(void)
> > +bool spl_falcon_boot(void)
> > +{
> > +     static int falcon =3D -1;
> > +
> > +     if (falcon < 0)
> > +             falcon =3D !spl_start_uboot();
> > +
> > +     return falcon;
> > +}
>
> Every existing loader (spl_mmc.c, spl_nand.c, etc.) still calls
> spl_start_uboot() directly, so the mismatch you describe is still
> possible on any of those paths when combined with spl_invoke_atf() - a
> button released between the loader's call and spl_falcon_boot() in
> spl_atf.c will produce exactly the disagreement this helper is meant
> to prevent. Please convert the existing call sites as part of this
> patch (or at least the ones on the ATF path), so the caching actually
> delivers the guarantee.

Alright, will do. I only personally tested the UFS and Maskrom
boot-from-RAM, but happy to convert other callers as it doesn't seem
to have downsides.

> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > @@ -105,6 +105,24 @@ __weak int spl_start_uboot(void)
> > +bool spl_falcon_boot(void)
> > +{
> > +     static int falcon =3D -1;
>
> Minor - since the return type is bool, I'd find it cleaner to use two
> bools (result and 'decided'), or an enum, rather than overloading an
> int with a -1 sentinel. It also keeps the value out of .data, which
> matters a little in SPL.

Sounds good, will adjust in the next version.

Thanks a lot!

Best regards,
Alexey
