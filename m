Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84197C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 15:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F9D88ADF;
	Thu,  1 Aug 2024 17:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U9XilVpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 457E588B23; Thu,  1 Aug 2024 17:22:06 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A97B78863E
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 17:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3db1bc36bc2so1096405b6e.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722525722; x=1723130522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2GVcLIkyino26jPBjOfSKibJ+1+2VVLmlsROdLtwaWA=;
 b=U9XilVpg2SE+UFqd3SAMySXafRKXYTqXdtY5MF3KVUaxC4IK8MhhJmt4kY/W77E6/f
 2APMSsRBX9daJAReVzQ9k90SQQqb3Xhn53f3wPxM2I4UZtw0YC/g24BAfM5OujtcCe2d
 8jCkxtXeTmQEUa8/QNBENVSlHDCsGXGbYTWIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722525722; x=1723130522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GVcLIkyino26jPBjOfSKibJ+1+2VVLmlsROdLtwaWA=;
 b=nlaiMH5oX5oi9H78A9V2KO7P9xg7znnxWETpGK/5yssiHHD9I2iyoQ3IbjRcpDiu2a
 X1HgQaOf2Evj0nm9DkgeTBFKL1QTd1z9sft8dSDaOpySBlOrhk7n3/K8KThrPOR2p5ra
 Y6zOrGkZgebQQyh29R0Itqy2u4V4R4QOcju/Rk3PVAZ4KOUh/ryH1WQggVEa2pifrXp3
 Ursu5ozEQ0v3xZ3Wp+WprmDT2DaZAcEjX357u3xQIKc9AqkOy/0zyA4lTw20Ay356LtZ
 yUoy2KSrOpO2KtuzFsEaDaadfz5OfyzdFecGTyKY+TcJ95ShjCQ4nB6LbbShPQ6fhE0N
 b1xw==
X-Gm-Message-State: AOJu0YzgJYzuMq4gUqVt0YsdttKIdBgkGG5q5y8P+hkyFgaA0H7F1Bvg
 9XFbqdgrVKFDPOS4mAKS/KoNWdAnki5llgKYFYlcpmLb8PmB3V0Jx371MUYzdZo=
X-Google-Smtp-Source: AGHT+IHB+kybkcDu9Kiqcy6qmWQvRnbuieuuhw6bXdTVIQlrw4YdGN4aeCYBrzPob3XKrbRH+pru0w==
X-Received: by 2002:a05:6808:179f:b0:3d6:2bab:16ca with SMTP id
 5614622812f47-3db559af5cemr181222b6e.13.1722525722283; 
 Thu, 01 Aug 2024 08:22:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a3a76908asm6638a34.66.2024.08.01.08.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:22:01 -0700 (PDT)
Date: Thu, 1 Aug 2024 09:21:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
Message-ID: <20240801152158.GI3794063@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat>
 <20240725223401.GD989285@bill-the-cat>
 <ebc992d6-93e8-4e7e-99dc-834cc981f5a3@linaro.org>
 <20240801144344.GH3794063@bill-the-cat>
 <36497602-1fc9-4044-800f-cb1d5fd789f9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NircC9MmUBMo1Fos"
Content-Disposition: inline
In-Reply-To: <36497602-1fc9-4044-800f-cb1d5fd789f9@linaro.org>
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


--NircC9MmUBMo1Fos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 05:15:34PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/1/24 16:43, Tom Rini wrote:
> > On Thu, Aug 01, 2024 at 04:40:03PM +0200, Jerome Forissier wrote:
> >>
> >>
> >> On 7/26/24 00:34, Tom Rini wrote:
> >>> On Thu, Jul 25, 2024 at 11:22:20AM -0600, Tom Rini wrote:
> >>>> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
> >>>>
> >>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add =
lwip
> >>>>> library for the network stack" [1]. The goal is to introduce the lw=
IP TCP/IP
> >>>>> stack [2] [3] as an alternative to the current implementation in ne=
t/,
> >>>>> selectable with Kconfig, and ultimately keep only lwIP if possible.=
 Some
> >>>>> reasons for doing so are:
> >>>>> - Make the support of HTTPS in the wget command easier. Javier T. a=
nd
> >>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to=
 do
> >>>>> so. With that it becomes possible to fetch and launch a distro inst=
aller
> >>>>> such as Debian etc. using a secure, authenticated connection direct=
ly
> >>>>> from the U-Boot shell. Several use cases:
> >>>>>   * Authentication: prevent MITM attack (third party replacing the
> >>>>> binary with a different one)
> >>>>>   * Confidentiality: prevent third parties from grabbing a copy of =
the
> >>>>> image as it is being downloaded
> >>>>>   * Allow connection to servers that do not support plain HTTP anym=
ore
> >>>>> (this is becoming more and more common on the Internet these days)
> >>>>> - Possibly benefit from additional features implemented in lwIP
> >>>>> - Less code to maintain in U-Boot
> >>>>>
> >>>>> Prior to applying this series, the lwIP stack needs to be added as a
> >>>>> Git subtree with the following command:
> >>>>>
> >>>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.sav=
annah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >>>>
> >>>> This is better than v4, and on the hardware platforms I could build =
and
> >>>> boot on (which was most of mine except the am62x_beagleplay), the te=
sts
> >>>> ran and completed, including the tftp+boot a Linux kernel.
> >>>>
> >>>> The bad news is CI blows up, a lot:
> >>>> https://source.denx.de/u-boot/u-boot/-/pipelines/21764
> >>>> And:
> >>>> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_a=
pis/build/builds/9014/logs/106
> >>>> which is another Kconfig dependency problem. I don't _think_ I
> >>>> introduced that, but since this wasn't against top of tree, I had to
> >>>> apply the cmd/Kconfig patch manually.
> >>>>
> >>>> I have my world build running still and may have more comments based=
 on
> >>>> that.
> >>>
> >>> First, with NET_LWIP being default rather than NET, there's a lot of
> >>> other Kconfig dependency issues. Unfortunately I don't see an easy to=
ol
> >>> for making sure this is all clean aside from a shell loop like:
> >>> for C in `(cd configs;ls)`;do make -s $C;done
> >>
> >> I have run this loop successfully with the upcoming v6 version. Some
> >> configs do print some warnings but there is no error.
> >=20
> > Those warnings are the problem, I wasn't clear, sorry. If I could make
> > it error, I would since then CI would catch it.
>=20
> v6 won't add any warning besides the ones in the new
> qemu_arm64_lwip_defconfig file that you said were OK:
>=20
> $ git co origin/next
> $ for C in `(cd configs;ls)`;do echo $C...; make -s $C || break;done 2>&1=
 | tee configs_next.log
> $ git checkout to-upstream/v6-wip
> $ for C in `(cd configs;ls)`;do echo $C...; make -s $C || break;done 2>&1=
 | tee configs.log
> $ diff -u configs_next.log configs.log
> --- configs_next.log    2024-08-01 17:10:50.903533652 +0200
> +++ configs.log 2024-08-01 17:03:55.497799493 +0200
> @@ -2016,6 +2016,11 @@
>  q8_a33_tablet_800x480_defconfig...
>  qcom_defconfig...
>  qemu_arm64_defconfig...
> +qemu_arm64_lwip_defconfig...
> +generated_defconfig:71:warning: override: reassigning to symbol ARM
> +generated_defconfig:71:warning: override: ARM changes choice state
> +generated_defconfig:72:warning: override: reassigning to symbol ARCH_QEMU
> +generated_defconfig:72:warning: override: ARCH_QEMU changes choice state
>  qemu_arm_defconfig...
>  qemu-ppce500_defconfig...
>  qemu-riscv32_defconfig...

Ah, ok, thanks.

--=20
Tom

--NircC9MmUBMo1Fos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmarqA8ACgkQFHw5/5Y0
tyz/Egv/bSsugLMfhJZOOtmKVOJjgIJs3pXckd3NTB/KUMfzgLr1AYGD2ws5Wj2b
ZP4Xn/L9J+3XkueCyRlatgBAwKIRg//WhrRvcbUS4Ut5wNwhIgA44aaTCtK6bIF0
nHjwOhapcbaCTo+iTkn/eNuE8OeXDCnVO/lFUZecb07r91H63G6xJDHPY3D99EMm
qe+SBeL0tnTTyn/YG/Sly+BP78oMzXJXyNbnbpeph+BhceeepLWdsy7wre4YfEI7
/QphggS980Zgkz7LerPlLM1c4jwxZgYVRz3haf4caOll2C/o9LAtdNfGAks75FPk
GKtM2ospQXK8KcK8Y6D2J7nzacrRJPCtTY7Aww2R6b9vzmO6ZDvnrIkJc0W7mBVC
qbHFuJ0RZZbQGwaRN0H21MIhBX+z7RhsjFYlICYCnx7IZEN6PifNUmFU5VbsBshe
qY3D2J4z0Wj8qikfiYvRqON6ADFt20wgZvVUWMTHsTdnyCUAhibYpjBS6L7ItSqn
wSCLNWAb
=xaaz
-----END PGP SIGNATURE-----

--NircC9MmUBMo1Fos--
