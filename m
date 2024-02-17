Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A75C48BF6
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 19:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B857B87E74;
	Sat, 17 Feb 2024 20:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="BXcQX8F/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021C487E75; Sat, 17 Feb 2024 20:27:42 +0100 (CET)
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A0987DFA
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 20:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=therealgraysky@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=lpdppjcc3bhbxj4s26pwzmcogq.protonmail; t=1708198058; x=1708457258;
 bh=iA9LTybJWnR9qbEX/pk3bfHF4He/+wDGjgM6aMyvb6Y=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=BXcQX8F/1Duli/60wJfo/4g5dc77H4YKrggbaeyRw9FkfQJZ1F4piPjDbZnJ3dXhJ
 ItNYu76cLM6cRiojhX+wR7q8s6CTwtB+dPgGKaUwO0l4OrDHCbx6VBnjm4jJRJG9YZ
 m5WbGNv3y927Svu2E8dU1AhQM8xLI/hvGAz4sKrlfQmf0a1YOot1wgLLwcO/U9DxN1
 O29Lygjx9J6oLrQlPOG1FDfmm8Y+YreMwzK85pC3NmxaDIXbcLRHxDnJqMvx6TD4Ql
 GdAReA6E9VSJq1AjQsWAezjGrweArGNNQOS9GWJ62VOgkNv4ZYRFYUT7BtBVpS5mQD
 t1qDL+NThOXqQ==
Date: Sat, 17 Feb 2024 19:27:27 +0000
To: Jojan <jjvazha@yahoo.com>
From: John <therealgraysky@proton.me>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Booting RPi5B with latest git
Message-ID: <niR3jnQfdu37PQnzpszMB4Ljv4s1UdFZjHAzR6AUdvSo7yfooe1wUd_kkulyKFLa0A0NsYbiXn3cFQhR9BkDv4X-xhsb_l_BzT-se4BNAVk=@proton.me>
In-Reply-To: <927582348.2068714.1708197919275@mail.yahoo.com>
References: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
 <1031326949.2069496.1708196119886@mail.yahoo.com>
 <DGgjhERuQGB1Y5hPRvHb9voUNFMnLh01k7vLy61hTmLJ95fcKvnDP_AmTzTBA0jBbmDNXRza4jl_KWr2UrSja5RLGnFveMiWGXM3Mpk8v-E=@proton.me>
 <927582348.2068714.1708197919275@mail.yahoo.com>
Feedback-ID: 47473199:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Thank you for the steps.  If the NIC is non-functional, I think I will wait=
 for official RPi5B support to come to u-boot.


On Saturday, February 17th, 2024 at 2:25 PM, Jojan <jjvazha@yahoo.com> wrot=
e:

> yes , I created new config=C2=A0 by renaming ' rpi_arm64_config'=C2=A0 to=
 rpi5_arm64_config.
> and edited the device tree to bcm2712-rpi-5-b.dtb. Then get get the dts f=
iles=C2=A0 fromlinux/arch/arm/boot/dts/bcm2712-rpi-5-b.dts at rpi-6.1.y)
>=20
>=20
> It gets booted but still need more controllers( ethernet)
>=20
>=20
>=20
> On Saturday, February 17, 2024 at 11:17:12 AM PST, John <therealgraysky@p=
roton.me> wrote:
>=20
>=20
>=20
> On Saturday, February 17th, 2024 at 1:55 PM, Jojan <jjvazha@yahoo.com> wr=
ote:
>=20
> > For RPi 5B you need bcm2712 device tree . RPi4 uses 2711.
> > So the e rpi_arm64_confi does not work for RPi5
> >
>=20
> Which config target did you build or did you modify rpi_arm64_config?=
=C2=A0 If so, can you share the diff?=C2=A0 You mentioned modifying "the co=
nfig" in your message below.
>=20
> > Also make sure that you have the changes=C2=A0 discussed here.[GIT PULL=
] rpi: updates for v2024.04 (mail-archive.com)
>=20
> I built from the master branch of the github mirror.=C2=A0 That should ha=
ve these changes incorporate, no?=C2=A0 https://github.com/u-boot/u-boot/co=
mmits/master/
>=20
> > Iwas able to get the git (https://source.denx.de/u-boot/custodians/u-bo=
ot-raspberrypi.git=C2=A0tags/rpi-next-2024.04)
> >
> > and modify the config to get 2712 dts file, and able to get u-boot.
> > [GIT PULL] rpi: updates for v2024.04
> >
> >
> >
> >
> >
> >
> >
> > On Saturday, February 17, 2024 at 08:36:22 AM PST, John <therealgraysky=
@proton.me> wrote:
> >
> >
> > I am running Arch ARM on a RPi4B and also on a RPi5B. My RPi4B can boot=
 the vanilla kernel package (linux-aarch64) with the latest uboot-raspberry=
pi (2024.04-rc2) just fine. Yet, if I take that uSD card and place it in my=
 RPi5B, it does not boot. I only see the "U-Boot" submarine logo in the upp=
er right of the screen/no debug output. Any thoughts are appreciated.
> >
> > I built u-boot like this:
> >
> > unset CFLAGS
> > unset CXXFLAGS
> > unset CPPFLAGS
> >
> > make rpi_arm64_config
> > echo 'CONFIG_IDENT_STRING=3D" Arch Linux ARM"' >> .config
> > make EXTRAVERSION=3D-2024.04rc2
