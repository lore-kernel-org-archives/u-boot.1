Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68173C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 19:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770D587DCD;
	Sat, 17 Feb 2024 20:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Brzi+XmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6539087DFA; Sat, 17 Feb 2024 20:17:15 +0100 (CET)
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch
 [185.70.40.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58ECE87DBB
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 20:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=therealgraysky@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=r5n2m4hsfvepdj5cthzj2ftffm.protonmail; t=1708197429; x=1708456629;
 bh=e8ZgEHZetu36vOskrF6nDLyQ+/uPEA+EPZSpCks/3PM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Brzi+XmQXf1WCgdqQI1+MSNqZK+26mPArs//nOaIlF7Jtcx/2CdayzMqej+4FgSi9
 zP2rYNlJqx4Ufvn+e6E4GRNS2mWIvriIDcBqQ4Gdly2xrpwygUwN7JzuVeZxzU8leQ
 s4KjOo5lxnyMGWdJPdHuO/Tj5YvRStaz3tiICSd/+0btgTake0xj4R4+C6xhctyj1Y
 CzeFLbB6tEtNdAYbRDpTdhxYJunsOUZBqL4I83HPMBhYQwtpf9jx1ViqBhdwWbDaQA
 QIr6/zTjUU4WXnI7xzOa2FEjbbMKxEJ5YT/sXY8hx2/0kaJJhn8bwfZAQoUbQsPXVY
 2Fg8rAITe+cOw==
Date: Sat, 17 Feb 2024 19:16:56 +0000
To: Jojan <jjvazha@yahoo.com>
From: John <therealgraysky@proton.me>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Booting RPi5B with latest git
Message-ID: <DGgjhERuQGB1Y5hPRvHb9voUNFMnLh01k7vLy61hTmLJ95fcKvnDP_AmTzTBA0jBbmDNXRza4jl_KWr2UrSja5RLGnFveMiWGXM3Mpk8v-E=@proton.me>
In-Reply-To: <1031326949.2069496.1708196119886@mail.yahoo.com>
References: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
 <1031326949.2069496.1708196119886@mail.yahoo.com>
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


On Saturday, February 17th, 2024 at 1:55 PM, Jojan <jjvazha@yahoo.com> wrot=
e:

> For RPi 5B you need bcm2712 device tree . RPi4 uses 2711.
> So the e rpi_arm64_confi does not work for RPi5
>=20

Which config target did you build or did you modify rpi_arm64_config?  If s=
o, can you share the diff?  You mentioned modifying "the config" in your me=
ssage below.

> Also make sure that you have the changes=C2=A0 discussed here.[GIT PULL] =
rpi: updates for v2024.04 (mail-archive.com)

I built from the master branch of the github mirror.  That should have thes=
e changes incorporate, no?  https://github.com/u-boot/u-boot/commits/master=
/

> Iwas able to get the git (https://source.denx.de/u-boot/custodians/u-boot=
-raspberrypi.git=C2=A0tags/rpi-next-2024.04)
>=20
> and modify the config to get 2712 dts file, and able to get u-boot.
> [GIT PULL] rpi: updates for v2024.04
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Saturday, February 17, 2024 at 08:36:22 AM PST, John <therealgraysky@p=
roton.me> wrote:
>=20
>=20
> I am running Arch ARM on a RPi4B and also on a RPi5B. My RPi4B can boot t=
he vanilla kernel package (linux-aarch64) with the latest uboot-raspberrypi=
 (2024.04-rc2) just fine. Yet, if I take that uSD card and place it in my R=
Pi5B, it does not boot. I only see the "U-Boot" submarine logo in the upper=
 right of the screen/no debug output. Any thoughts are appreciated.
>=20
> I built u-boot like this:
>=20
> unset CFLAGS
> unset CXXFLAGS
> unset CPPFLAGS
>=20
> make rpi_arm64_config
> echo 'CONFIG_IDENT_STRING=3D" Arch Linux ARM"' >> .config
> make EXTRAVERSION=3D-2024.04rc2
