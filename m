Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC721C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 20:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4452C6060A;
	Fri, 11 Sep 2026 20:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkCXudG1CQvJ; Fri, 11 Sep 2026 20:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 70D4E60617
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789158205;
	b=hS9+S8Z86oVOykjxuc1BhSH8JEHzDf8Uj27Tr8c5kvD5hsttxZrILBDIMRyHtYoYFmPm
	 SHA5thnK0RWVqsMYng2zkG1V9ilRce4IYytpzgOd+6nL98RFVkj5PoBG5dYWVWJwv7jzK
	 U7DSnCRxMhBKelM45f6lz0t+g0fTSuA/ezV8mUfACliURrtdUwy+esWOPP1OlKq9ARXrB
	 w05L4/a9e6zyzpbvzYq4xHE0LShUf4E6jVhInW0hP0Kgtu2wbj0mC4EN+RDF2+RQJoA8b
	 r/z3siFRP/TFvuEpUnDsf9kSYtMU/czyW/K+BH0SiDEj9yBpfarrygRVoPwhvN4RwEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789158205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7gcywKHqRj/iAPrC4Y6a8IzOhG4FPi0/mbiFrce26DM=;
	b=TgUefxLfiGrIPIzG0sxDYmUj2TroZJfV4PWPpeFqf0VnZdAQU3LaM7eQ2jIKXgZM/jqM
	 wcmZ/z1qXa/JuP55zrOtpkwSheaa78wVNdlv5+K5bKn3BK5rUXeMNSfR0saFElIgWZq9l
	 hx9byc/2AWBYRctFzLV79PE19vh1ofvQQTqH/JZeA9THHw3EdNyiOQsG1VTKOAzebZV1w
	 Gztv2W9t66yu8v1Dzxq0kQk9d4XoeB2rlqhnvkqkRRJfiLh3IHXiBx4Wv84NhBFPYTVSm
	 EyRCV3Dk1c/8AKnTHDGI+DIAOC5V5rqLF/HPmp0o2YfiRASyvRqXdVa42iG9HAbQfXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789158205;
	bh=7gcywKHqRj/iAPrC4Y6a8IzOhG4FPi0/mbiFrce26DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zG9DGNuOMFzKd1o2BhNG7dHyLs5Dwa1ljTewtJ8T2BJr/w6k/jlamKFm0zd3NA2nU
	 ZauI+c2vRfM9pXOleGagXsdlI2mMa7jtyTPLUCM464M0Kh9cgoh4lCpzV+z9CjhNzI
	 +/RIL8tWh7azgyfPPd+T3YeYCUlSiMIy2s/JmLRK8AKlOKCMq3kcakV5CPnZQ62XLN
	 RSOeKP7I68IfRqx3ys4OuUok8PX+tfe1Plp3ajyvP2uynrcTX5tZ3PSSWgbFqobdjQ
	 o1gPU5WRR7VJeDSB/Ep2s5iSnKh+hnkgdi2wcxxbpd97ptyFGjjY1fbOVuIjOM5zF6
	 VZn/IgRfqwE3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70D4E60617;
	Fri, 11 Sep 2026 20:23:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 834AD49D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 20:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6988E400AE
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 20:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nARamjK9Y2HI for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 20:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 898F540083
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789158203;
 b=QHvMxucr83rhEbxXQwS5wGuBBWk/h2cB3WSn1IGSImCDZUM50MjvPbypad53LN4dl2cJ
 j2/O1bT04yrJokT7bzhxdVoApysHiTK8Bt+La37eyIDMbosPRwydlkpYMgTLDTJuw3WoN
 GdRKK8y7wynnnGrwQuJlgH2RKXt6G4XGP5XXZcqnt4JMr6JCxR2uQifif7MT3B3eHXKqW
 dtC87UmEbUf8pPT34dt5YS0wuHZfcc7yhZdfBWEmz/x15OyIodu+3jGE2YXKKjxJnpup3
 UAGX0QvMzSLy6LHFpWrOCzxtEI/E2Ll4t7dIAfXbd3vOGrP7UMuZnAORIW3fpPjcyPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789158203;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=7gcywKHqRj/iAPrC4Y6a8IzOhG4FPi0/mbiFrce26DM=;
 b=m/taiVJgGnSWlWfTH02HjdCKwzSJG9lowV43ULZEUJyQY4aF8Mi0it3bdcMEM6eGl3qr
 7/2DivVGrQZFsyY1F/Ye1A97qluQjOUZxfrwtRNkkHClmJYiTtQlpKBWnpnb/DHCO8YSU
 z2DMlW+o6fIdBttOebKwYeG/mvttKdVPhUs1XZQT8JGDdnKV+q3LbWkk75Q+y6sboVAlp
 SPPaHhpDpWpnESx2EfYiYaG5vT5uY9ZTbbOxxDH6idY/vZr+0BGwO+AcyPy01IcsCEe6r
 xvA61FQ0jGlnROY5nTJjZEMcjolao8wEq2VIX19Ip0ev7JVTP7yaKTgHU/gAJvslWug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RO1gnhz4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RO1gnhz4
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 898F540083
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 20:23:23 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae739df5so70043eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789158202; x=1789763002;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7gcywKHqRj/iAPrC4Y6a8IzOhG4FPi0/mbiFrce26DM=;
 b=RO1gnhz4/z56f/bSAW6GIZ8TGe41TfDjwVgFXZizoCQH20bFH9sUUInWskWHYGLQ0r
 H5Kju9GSINQBXYwAV2HHssER0hiaCqpQ7kLeUCHRf3lW/ANFyj6jRISYoqTz6AYIyT45
 CD3cxfilo2H1wOSvjBqKPYIQMEizYTyUQHxhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789158202; x=1789763002;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7gcywKHqRj/iAPrC4Y6a8IzOhG4FPi0/mbiFrce26DM=;
 b=V+ZfYAPF4RJsKj6tHTmgb+lUeM8XInsT6fmvCuOIhWP/i20nve7KBptytxz+mW0aD+
 FbWkX2FKwPzPGTqJIkIRQWCwKaovrQMSZ7VGy2DEvcPI4z0m+dgwKSd9j/Zj5He56pMc
 Ee1Q0piUgm90OtkZJfyiIvTaH0c0WcrA+nVLiGTLsR9nEqLdyXVmIFz7CYmBHLeMhvni
 RAipTWOUtM54OHKRqcgqB3t7qC6Fl6PLS90KCGAo6pnXZYCERK9PV+boN/CpLEq2zLjW
 9EnDXGXLmLsVt9LEPg17pnTr/31zQwU5EuuHVbLsHTCDdPKW0WCAXycryUmDUK9iQeG6
 6dhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzg8gZa2+hn/5j0+cbFZhCc3JFpswSTiJK6xBc/Nqt55b+x6BpC93UNfstMWOSysXUzIM/RICE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lrl+CJxCFS3+VmpGY9DsHTAbRDwMHN/mZTL0HTdmBQ8UmFNrUn
 feiDXT+U+cIUEzaRH6UrvM8v/qlQOE/4LJH8/UKtEk47V4HuFn3rgTdPxRaeX2uhHI4=
X-Gm-Gg: AYBFou18izfeb68oEUsYrVlJRJX10XNJK7qpNIOeEFUDdg8GrMgLlGpLCq3vOzvvLA4
 PwAtQAx0ujM2AM34kVuxCIfWT7i+iRBMVFUSNXVYi92wUDP3RhdmLo7IaW1EkzRbLyNEYPhS5Uv
 K76GqIHmS0AJfdqktC66cPiFDdcwarKWA0tzg3FC8Ewai+nWKlHGP4NW2rQxtwv2UEjX80zTKOR
 4hpYIQWNaQOI7CgXrcPijTa6lskBssP/us/CVdLgXlVDWIuI6dFvoiDrmx23Xj0/wEM8qt15hU0
 42GBUTn8vhpNqfHGA3UMZU7XBcttF43oi5D30PDL2iazf7UeXJIBkE6CKBls+SUfbaSFMssmjlB
 0kObg165oucG6ElTQpecrFaGkA0KUng3o3yrWTaqfXSdMm01NKGNhvucSeFr42b8uSBg1Qr/qUq
 4aZzovwIvxOfggD8ig0hy0Pg/C08jMaI8y7Tzk6T8uIlUVV3qzmm7xxoQSNpbOH9G89ntV4uJj5
 APIMJbEYEA9PgvgjZJ/5GDQIDXEpTHQMX4ewtjktc1sbzBUgU6gU0MIkKhh/Y8oqzabEqJEBaFZ
 r6ephRXvfoZH+ywGoKm6PrCq148+uw8=
X-Received: by 2002:a05:6820:3107:b0:6b5:ec3f:497b with SMTP id
 006d021491bc7-6c0a80348eamr3260831eaf.22.1789158202151; 
 Fri, 11 Sep 2026 13:23:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c2072f33fbsm935828eaf.12.2026.09.11.13.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:23:21 -0700 (PDT)
Date: Fri, 11 Sep 2026 14:23:18 -0600
From: Tom Rini <trini@konsulko.com>
To: phodina <petr.hodina@protonmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>
Subject: Re: [PATCH 1/4] common: Add command line parsing utilities
Message-ID: <20260911202318.GV1764417@bill-the-cat>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
 <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
 <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
 <U6YrT3S_BQGuySCLDPjwnTxE9bvcH4uMX9vLfz5D0b32Kumb7X-TVcYowyUHmESFKNVU8jSLlDPqYQI9Y6owcWFWAicWEhCrB7lL4J1z6JE=@protonmail.com>
 <49a1bcfe-1aec-465d-b138-52b6803ce9c0@mailbox.org>
 <20260911185345.GT1764417@bill-the-cat>
 <8aDPIwN_xcto5LeR9MPcrDr5NaNDDImT7S5mRkPmJpYhukYnX4XP52fNqlscYcXRFjQmiSi3ygivxpgY2hAILJ7xrSE0apkH123kYnXPUNo=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0xuTeXTF3tx3QSnp"
Content-Disposition: inline
In-Reply-To: <8aDPIwN_xcto5LeR9MPcrDr5NaNDDImT7S5mRkPmJpYhukYnX4XP52fNqlscYcXRFjQmiSi3ygivxpgY2hAILJ7xrSE0apkH123kYnXPUNo=@protonmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--0xuTeXTF3tx3QSnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 07:20:05PM +0000, phodina wrote:
> On Friday, September 11th, 2026 at 8:53 PM, Tom Rini <trini@konsulko.com>=
 wrote:
>=20
> > On Fri, Sep 11, 2026 at 08:46:30PM +0200, Marek Vasut wrote:
> > > On 9/11/26 8:39 PM, phodina wrote:
> > > > On Friday, September 11th, 2026 at 8:30 PM, Marek Vasut <marek.vasu=
t@mailbox.org> wrote:
> > > >=20
> > > > > On 9/11/26 8:18 PM, Petr Hodina via B4 Relay wrote:
> > > > > > From: Petr Hodina <petr.hodina@protonmail.com>
> > > > > >=20
> > > > > > Add a new utility library for parsing command line parameters in
> > > > > > key=3Dvalue format.
> > > > > Is this reinventing environment or UPL ?
> > > > >=20
> > > >=20
> > > > The target is a chainloaded environment. In this case u-boot runnin=
g on Android devices where you unfortunately don't have the possibility to =
use UPL.
> > > >=20
> > > > As stated above it's purpose is to simplify the operations on the c=
ommand line arguments from the previous stage and pass them to the next.
> > > >=20
> > > > Typical example is to remove the skip initramfs or extract the valu=
e for the panel to pick the right dtb (not part of this patch series)
> > >=20
> > > Is this something you could do in an U-Boot script using setexpr sub/=
gsub
> > > instead ?
> >=20
>=20
> Well that should be possible as the C strings are messy.
>=20
> However, the intention is to be used from SPL where
> the setexpr sub/gsub would not be available.
>=20
> > Yes, I would like to see how this gets used in implementation too, as
> > I'm wondering if we shouldn't just be also saving off something like
> > "prev_bl_bootargs" and leaving the rest to the board code to deal with.
> > Maybe we should also add the android-specific helpers in a new file
> > under an Android-related Kconfig as well.
> >=20
> > --=20
> > Tom
>=20
> Will send the example in another patch series with detailed description.
>=20
> TLDR; The boot.img contains as the main target the SPL u-boot build with =
barebone dts. Qcom has a thing called SMEM which can be used in runtime to =
detect the board and based on that we pick the correct dtb and jump to norm=
al u-boot.
>=20
> Also thanks for the good idea to place the helper under Android Kconfig.

Ah, OK. So if we're going to be jumping to full U-Boot before the OS, it
might be worth thinking about how to just parse enough of that and in
turn /chosen/bootargs to pick the right dtb to pass along to full
U-Boot, along with anything else, and save the larger modifications
until later. But, I do await your follow-up showing the real use rather
than further speculation. Thanks!

--=20
Tom

--0xuTeXTF3tx3QSnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqRjMwAKCRAr4qD1Cr/k
CvERAQCOSkyXdGGF8Eujcf91MrHhoL4gMkZaJhTHObXRh1xNdAEAtjByOKDJkklF
X9CyZylgWMSuRpyWXfGqOFnryGnuaw4=
=8IoD
-----END PGP SIGNATURE-----

--0xuTeXTF3tx3QSnp--
