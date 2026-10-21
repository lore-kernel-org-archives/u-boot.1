Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h5uFy10h;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lXScnwR9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DD4160892;
	Wed, 21 Oct 2026 18:10:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWf3S7wUAXfg; Wed, 21 Oct 2026 18:10:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B81D6079B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792606243;
	b=Afw+MenbOjc6zt1DCqOVK6FqT6zvfvtC/H392eqXtbck9vVkPj3IAoZVBUP/8D6MN3Zx
	 twDAvuM7wXluRfzrvfnU0KQSOz5QBy4/fTgHm8lUu6Y5HUvetUqh6IuMU5gQE85hT+Wcl
	 a4CWHdAdT5mXIYC8q1JnBRF6lGK6pTGTRT1M0rNOHIyXuoE3eIqy/7AEldGwK2s8b4DJy
	 4APlHhtLtByXAHv+JPjrp6AvwK95miuKTfQ8pyXPPpbU/6HqvER7xCITo+RJjBAMug8AW
	 +SQFEH6KAjs5pveG4unKuivmowYBbf8mMT425Dlw/W0ltLUXFDpwBYqHwmySys8G/Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792606243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Hrmvc+c4tXSLBaZK97L3k7b/S7LdRa2ZDwpOTuxTF3M=;
	b=j1Ewu04XKVVxVIQgFSQjW6qUAjjnJTAjyN0tLFJVrqsezD6pC5vSuV3b9+ALBD15EAr3
	 BeUKagApsk6Y4iSwiAq5CPIEtWjbVdlPzT0PIZQtdkROeVio4Hgqdy5d5Zxf757nAVD9l
	 Z3P5uW/e9YJB/CIKpPICxTygUkl9OP1BeNZYz3ejAlHaTSkKzxZxdMcukZDa4p94mHppL
	 OwwvJYQZmRClKnNkTCJqPlGRQd1cLy3FJ2NU/sfGlFMwsEMIr9jY0/WdY9M9QmBQEbiJF
	 XlapE8BKgtks2NOQTXcHcBYJExbyGKB0d2Rb6bTPzVKn5OxGTmVtfrcMu70dWZ51zfw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792606243;
	bh=Hrmvc+c4tXSLBaZK97L3k7b/S7LdRa2ZDwpOTuxTF3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h5uFy10hunR8aZQNyLWbpPTeuWdRe+DaIn1OG9ZAnlatNrCUkcwIumrYt2MOpx4he
	 SXlrdTUE/fJ7ehsRORlEAe+DXqtXmHpHK9RO2D3GJAg2xq+m+XG8PzQR8SDTorpK4K
	 w14tuHFtkK5G6JsvZEZEndNC3Q+Lpm1UKcvMA5u8qtiJggvwjY3j1xvu4+NRq6YBgU
	 MT3l98VyZYZJUaAgmvveoT7gi5szWxd36jClctX7SNx3ENH4ZYqPHmfK4ughFBNa7T
	 xVhE6jh/pwH1Y8vHmcXd5/RhZ0TowRpTOlI6VsHewn19gm89DOopIfKV3i7q5D5wYI
	 zVYbVW8rsd5aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B81D6079B;
	Wed, 21 Oct 2026 18:10:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BE0F3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D33E80AB5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a3v8iMxe7Sdu for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 18:10:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0ED3D80A56
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792606240;
 b=ZtzP8YjqIP7wzGNkZLgP2BixDvxs0g5+P20TWKNCaYZSFqGc1UaROLFhpD/u2zfHaJIY
 s2o/JX9Qk9tVDvQ4hVW7nPrpKKAAh1ajazXevx9tTgQ5KAJLk2I8HpQTeWBWVtdCwafrY
 YfQGEP7pd74u50LOZkEGJIX7X29bPWXKuddbbHGT05THeeDMC84vRr2CNT8H5HPnTEiyY
 alg2Cth+mQ2hDhehrlJynbO9m5EdTOmF6Onksf5ObpyC1PB1z++PUaFehDCaCj5JmHuVE
 xNSIDBJz/mZoUjBrviCG+N/iteo3Fp5SNV0tQneF2Whk2831tOwipM35/YLjJwRoWPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792606240;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Hrmvc+c4tXSLBaZK97L3k7b/S7LdRa2ZDwpOTuxTF3M=;
 b=lYEGTGrtOcMVssr/JzzLY2Vv9lAv7OzJ3jzpaS+ZidZWkHfRSY83/OwPfRoYFvXeEFOu
 NvxDQGZ5P327+G4SAHBq1lMlb0A6SKY47E2Hr2kDTE7xcshP1k+Ig7q4W8A3wyGB8g8Pn
 nRxhOt9tOXYIWUrUPGqoG9y+kDh0cpIgq+m2hRBnKU+LgtIOzgbHh6d3Khgxn0TgW2Ig1
 P6kcG2vmAAxcuR+Wls1HUmJ8cNQvrGimvK2UisJDyQfmXbdyPucfCybAMlHKiUQkY2lQv
 8bIUqcrvkOAQVm073sacUm+VVrmeiSQ5ojKiAWc4ybfAXelQ5cYn+z9IkD/y5qXGq1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lXScnwR9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lXScnwR9
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0ED3D80A56
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:10:39 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-828c0b569f6so343554a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792606238; x=1793211038;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hrmvc+c4tXSLBaZK97L3k7b/S7LdRa2ZDwpOTuxTF3M=;
 b=lXScnwR9fv/4CCWmr2CV0xdqqU2CPSqU6hpdxWQlYX5Zctv+bu/1KGgbo9nT4v9Rec
 d2BF18aZ3ck5Ix2dXdlw/fS8oNWybbnTS99shxi7XPK3+y7Lp9Y5Xk5JcJOkaBPxqu45
 ws3wF8pE4CeVuvc0kAyXAilF/hsLf0NH0giT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606238; x=1793211038;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hrmvc+c4tXSLBaZK97L3k7b/S7LdRa2ZDwpOTuxTF3M=;
 b=var7xbovkaYv3PkevTLkJjQHmJejL2K++1xEMrbQjd7s2R60AuBvjJppK98UinUzFd
 xcsi5fwf1Gr5P75ScqAyFn1eq65vzR+cQvOQl3KzWl2TWgb1YkO3JcPeqiUfcM8zLLoe
 d8++knPDl4tQN0uHZ+MJMW2Ba2VsK1FBDVfmI/QZROgzs6nkZLXKsVBXuF9d3LVchVrT
 MK2u0LjNZk4NAhu/m5Cp3hCzQeHTZ1GtquLyUhjrMxG4MlgD40M32vLb8RlTaKO0dtFw
 hwkyuSeQiUx1I59fhV/kNJdObWT6VdVuWS4NorEA1+ENKJ9U9temb2j7yJOvm3SorUPG
 nkdg==
X-Forwarded-Encrypted: i=1;
 AKwUvByQeOqC10bV23qc0egIlxHeKLeDAq0HV5YWPr7/OSg+Bi7PfA98/zeq8lL/jqDZ0OG11G09xeU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJLfivbsq004kLuw5nmlQ6n2XKhSOJbHeeKZz8oj3j75FwrbT3x
 ehjUql+ZhvbQW0rOmO+pmx7Xp4cmp3aDpbovpaMeLiq5Np0NTyV3bWbP8afYkl+sUvc=
X-Gm-Gg: AYBFou1PvRnBtBYoY44RRPaEI3S1wwgQL/G5MMiNvBnyrKzpwDTv2iJYg8rOHmkD+cZ
 71wN2BDB+epYTFlPUcLWbVEDvmKACNmv4JlIySr3FytAG+f1gQydUZP0nWDGCsRD/SHQd6KSAxj
 T/XFrkxDl+8hz9k4aYYOi0L/3TUcj+0+Fi52JX4CZyKJ2kB7L76cb8oIOY591/FLsiphnO8G/fC
 jGtFXx8jsWssAZscnF/ivVJRzv+NyMHzP+LSZeJvSvMNUCzNjgG/jPEf2YndlZaxDb76TvMIDNY
 Jj3Nn7Lk25ZhljCURAls9nXDlo9E53I/PCpTmD8vG1AKRJa1loIkT4ZfsrlJkW6SN4iLgq43CvD
 PRDkdZIfEanQgMXq0zL8fNv+eQVUW642PwWg4s0qR7eRrl+AGE6seaabJ5Ym5eBgDpCr25JTEY6
 2g1KOAdIBY2jH4SbUmkMmjz4ej/3DCEJhG7uCOsu1oqLI/NbZ/zXetZEd/thDtL7dqfp6zQfvGt
 DN8NkdHLeWrt+jDlRJisEeI7PqpEbyfAhG/RrFIPmU3ZwJMLMftexmvsRAO7fKZ+wCBzRfoyY+1
 SmYrZgRXw2bmVXrWZ+z3zJ9FVUlYNefNUsGQF2KZ+vfWvQPts/rnXdAVElvvMdb11Cq1BZyIxwI
 Q
X-Received: by 2002:a05:6830:698a:b0:844:d1b5:df47 with SMTP id
 46e09a7af769-84d09115c8emr2432552a34.19.1792606238215; 
 Wed, 21 Oct 2026 11:10:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd8cb051sm2966837a34.22.2026.10.21.11.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:10:37 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:10:33 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>
Cc: Bradley Morgan <brads@mainlining.org>, u-boot@lists.u-boot-project.org,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Pengpeng Hou <hppiscas@163.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>, Vincent Jardin <vjardin@free.fr>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH 01/26] board: powerpc: Remove MPC8548CDS support
Message-ID: <20261021181033.GH3275858@bill-the-cat>
References: <20261009193704.13061-1-brads@mainlining.org>
 <20261009193704.13061-2-brads@mainlining.org>
 <20261009215538.GG769217@bill-the-cat>
 <20261010125149.5b2ec50b@wsk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/urj0D8sji+lCE8H"
Content-Disposition: inline
In-Reply-To: <20261010125149.5b2ec50b@wsk>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--/urj0D8sji+lCE8H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 12:51:49PM +0200, =C5=81ukasz Majewski wrote:

> Hi Tom, Bradley,
>=20
> > On Fri, Oct 09, 2026 at 07:36:39PM +0000, Bradley Morgan wrote:
> >=20
> > > MPC8548 silicon is no longer manufactured, and the MPC8548CDS board
> > > is obsolete. Remove the board and its SoC support.
> > >=20
> > > Signed-off-by: Bradley Morgan <brads@mainlining.org> =20
> >=20
> > So, globally. As has been discussed on IRC already, please take a more
> > neutral removal message in v2. The problem isn't that the boards
> > aren't manufactured, it's that (likely) they aren't being actively
> > tested and maintained in the community. We're fine with "obsolete"
> > hardware if someone is maintaining it. Also, please rework the CC
> > list (outside the cover letter) to include the listed board
> > maintainers, and then only people that have touched the relevant code
> > recently, perhaps with a manual audit or exclude some global or
> > common files, when looking for who else to CC. Thanks.
> >=20
>=20
> Maybe I would add my 2 cents...
>=20
> There are a lot of MPC85xx systems out there - and probably (my guess)
> is that at some point some customers would be "forced" to refurbish
> them.
>=20
> Some companies need very long time to realize that their crucial legacy
> products may be removed from u-boot. I would opt for longer and more
> "broadcast" obsolence process.
>=20
>=20
> I had similar situation in the past when some Samsung SoCs were removed
> from u-boot - nobody was willing to pay for re-adding them upstrem -
> this means that they were kept out of tree.

Thanks for the feedback here. Let me make this a message to the future,
when someone is needing to bring back an old platform we've removed.

As a project we are happy to bring back removed platforms. You can see
https://git.u-boot-project.org/u-boot/u-boot/-/commit/93d204f7175c as an
example where we've done that, even, for the exact reasons of "someone
has a long term support need". There's not a demand to fix all of the
code problems of the SoC support, etc, itself. There is a need to bring
things up to modern standards. This is something that even if you keep
the board(s) out of tree are likely needing to be done anyways as we'll
have dropped other legacy APIs too. The time and effort needed to bring
something back *and* upstream it is not going to be much more than to
bring it back to start with.

And to anyone who finds this helpful now, to pass along to people who
control budgets, a little bit of time now to keep a reference platform
supported and tested will save money down the road when you need to
bring support back and fix things that had already broken before they
were removed.

There's a cost the project has to always pay for a given platform. We
currently support building for 1541 different platforms (and even more
physical devices). We're always happy to add more. The cost is simply
someone saying "I will test this device sometimes to make sure it still
runs". We already make sure it still builds. The project makes 4
releases a year, on a regular schedule. 4 days a year should not be a
hard amount of time for a company to dedicate.

And with that, thank you so very much to all of the people doing this as
a hobby or otherwise just for fun in their free time. And thank you too,
to the people doing this as part of their job (and their company for
supporting them).

--=20
Tom

--/urj0D8sji+lCE8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatkAGQAKCRAr4qD1Cr/k
CoQXAQDS9X7BELsGeK2WAeWATZ1AgIvujrWBG90XD26NbmwcMQEAyOMZZC6cO/XG
nOqT2a3sI12TYFVTevb3NNeZPTOItgU=
=yrmD
-----END PGP SIGNATURE-----

--/urj0D8sji+lCE8H--
