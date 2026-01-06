Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D5C47BF5
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A3183F8F;
	Tue,  6 Jan 2026 15:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TnbBALPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B3B83F98; Tue,  6 Jan 2026 15:20:42 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209DF83F86
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 15:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7cdd651c884so632731a34.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 06:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767709231; x=1768314031; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lqvsbTGMWt+wifGMFIWR8t1nxorhAhfUXvJunlG6AcU=;
 b=TnbBALPwNZtOe95PeGp0xm4K3EmHaH+GhNRP75pfRZZmLcYnkkyXY0mhB2jMF2Fenh
 hoDXb+NQWooI2SL2bc0nIYv0nHr+6f+OmxuS+/69mw1/wbNs08kf/EaxOwNXvTWpmh97
 zEs8JwH1f2WA05qqSkbEg5F4m9peO1MRAnrsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767709231; x=1768314031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqvsbTGMWt+wifGMFIWR8t1nxorhAhfUXvJunlG6AcU=;
 b=E9l3cqtDsNFOeAoUrn5i/xWrBIvSgWHCEkJ51FIdmyEx77bJAqJFVdEg04/U73cg/9
 JqcFj6wqjdX4KKjAw91bFdkS/xJDHYDKmPP+lTlPppbEU16UFRaJJhv4sDtJ3xz6xEjw
 HEQmff8+6p/64pyxIEhDKe032z46kXGmsIAe2LtXfRJTK0mb9Y+juQEle+s8alOZGzSo
 bcha0xwXiQxakz75ClLBOO0zO+mM5MJpAISvV2HiW6gPdYYD0QyRS7w3Nah2v31FAkvE
 TjD0Mqqh5H8PVGGyg9LLFjvifuEKom8IiKdOJbYlyOhNiYMRvSNiQ1KhVsWGqo5L8siY
 fiQw==
X-Gm-Message-State: AOJu0YyZBEhftDu+BJ7X05lVE6saLhKcL1Kp/jy1GqM1B2ZU3hzDFyE/
 S8r8knVO2JxuyRUM84QhXW/gPWMoRMYAWvvEi7TUuqSgNBfQuo/j9Wjrq3qVNqf4fFQ=
X-Gm-Gg: AY/fxX4kAFTyTFtnR7PqFu7bCKh88v5udLe23AffoyKemuVunVV10W2aQjyfKNsetSM
 osyLfUNtjTsxSiMxtwuKaB2MB6LtLRKpzvMt4rHBY2xeg7KkC7GRV176xknR7DAWNOvlRCKOY2B
 YPMbmH4x96TP5qxmBNhG/I7+uWuoBVGQ4fVYOdc/SAin+wxHWittW01qqDkGmFgDJDFEtSeYUUM
 1R/hgyR1I/n+V19VITPJquZDown95lLh0idW3IMP4qD45UKpwR7e5oS1VLPR6uJTDHj1dDkR82/
 So0JE2hIgPuSgZpkoO9dcJavzBxFKYX5aE9NG79IdYR6F9mRVIV7pzjfGhe2joAY1IdbuVcR2Iq
 +rbLTVT7V0dJ0/K8WF1YKZzJvRjA4e3bfZm/XE6zJJCEg2UmP5EDJi/XRpZ2TF0w9+gq1wuQV+k
 EvlSWR96JcpAH877hkJtzoA/xS95Z3O+RqrK3wUcKL3JFBKLGfMHw9QUtpzMQTXTzuQhy1vXSXK
 jGAVkj1AVfTBzsCwFjFhw0zMudV34zzbEPbV9M=
X-Google-Smtp-Source: AGHT+IERgrbAQMvtBNR+G/THuh5t7Ar3/fHb4thlsc6e/DVNHyTSu8CAS27vbfSL0rjrQPgjsnIFhA==
X-Received: by 2002:a9d:5787:0:b0:7c7:6300:f78 with SMTP id
 46e09a7af769-7ce46cb0bd1mr1384553a34.9.1767709230702; 
 Tue, 06 Jan 2026 06:20:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af813sm1504507a34.19.2026.01.06.06.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 06:20:30 -0800 (PST)
Date: Tue, 6 Jan 2026 08:20:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Jun Chang <jun.chang@metanoia-comm.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Subject: Re: [PATCH 1/1] board: mt5824: Add initial support for Metanoia
 MT5824 EVB
Message-ID: <20260106142028.GF3416603@bill-the-cat>
References: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
 <20251230030328.215240-2-jun.chang@metanoia-comm.com>
 <20251230153115.GR710860@bill-the-cat>
 <e4a70eae-37fd-4648-bb17-66975c6d09af@metanoia-comm.com>
 <20251231143404.GX710860@bill-the-cat>
 <c3d448db-54ce-482a-9d34-47395e415881@metanoia-comm.com>
 <20260105141546.GJ6124@bill-the-cat>
 <1da0a28e-1d25-4424-92d7-f032cc0aec8f@metanoia-comm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EQysaEpnusACR7+2"
Content-Disposition: inline
In-Reply-To: <1da0a28e-1d25-4424-92d7-f032cc0aec8f@metanoia-comm.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--EQysaEpnusACR7+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 01:17:56PM +0800, Jun Chang wrote:
> On 1/5/2026 10:15 PM, Tom Rini wrote:
> > On Mon, Jan 05, 2026 at 07:39:44PM +0800, Jun Chang wrote:
> >> On 12/31/2025 10:34 PM, Tom Rini wrote:
> >>> On Wed, Dec 31, 2025 at 02:32:45PM +0800, Jun Chang wrote:
> >>>> On 12/30/2025 11:31 PM, Tom Rini wrote:
> >>>>> On Tue, Dec 30, 2025 at 11:03:28AM +0800, Jun Chang wrote:
> >>>>>
> >>>>>> - Add RISC-V target for MT5824
> >>>>>> - Add board defconfig and DTS for MT5824 EVB
> >>>>>> - Add SPL and U-Boot board support for MT5824 EVB
> >>>>>> - Add DDR init for MT5824 EVB
> >>>>>>
> >>>>>> Signed-off-by: Jun Chang <jun.chang@metanoia-comm.com>
> >>>>>> ---
> >>>>>>  arch/riscv/Kconfig                    |   4 +
> >>>>>>  arch/riscv/dts/mt5824-evb.dts         | 232 +++++++++++++++++
> >>>>>
> >>>>> What is the status on upstreaming this device tree?
> >>>>
> >>>> The device tree is able to boot to U-Boot with shell prompt by the J=
TAG.
> >>>
> >>> Since I wasn't clear enough, I meant the status on getting this in the
> >>> linux kernel tree so that OF_UPSTREAM can be enabled and we use the c=
opy
> >>> found under dts/upstream/src/riscv instead.
> >>>
> >>
> >> Thanks for the clarification.
> >>
> >> The device tree for Linux kernel is not yet submitted to the upstream.
> >> We would like to go with the U-Boot first.
> >=20
> > It will need to be migrated over to OF_UPSTREAM and really should not
> > just say in U-Boot only. Have you at least started the process
> > internally and for example run "make CHECK_DTBS=3D1" in the kernel on t=
his
> > to catch obvious problems?
> >=20
>=20
> We will send a full functional and verified device tree to the U-Boot in =
the next patch.
> When our device tree patch be accepted by Linux kernel, it will be migrat=
ed over to OF_UPSTREAM.

Sounds good, thanks!

--=20
Tom

--EQysaEpnusACR7+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV0aKAAKCRAr4qD1Cr/k
ChtGAQDekhmiHuakHQLozaq/up84lGfNlcgoB3bAPNEoZz7r4QD/VzprDwDtIU77
6QUel7+3tGMFGiCHluNTYSllkwzhfwM=
=p9Go
-----END PGP SIGNATURE-----

--EQysaEpnusACR7+2--
