Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB5BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5E188607;
	Tue, 30 Jul 2024 16:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MZxngHks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2D488800; Tue, 30 Jul 2024 16:03:04 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46DB488271
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70943713472so1168669a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722348180; x=1722952980; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EWhamAWc591vzGdFLYxx00/BomzhvFque6AvPIFt1+o=;
 b=MZxngHkshWu/3b3i07h78Hs7e0mMJVJPo2CRizdfONPraI2wajx2mMK/S0kwaW4Nk2
 sV+QzvBJ6gCKo+R3oZVd4UCmDedPG/exP5jWwqY4KDRcnyWBA6Fr70vFDRAl/2NlspDY
 5eNTYEo/T7q+kkKroS63BqYFWb2CzIFOgyDDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722348180; x=1722952980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWhamAWc591vzGdFLYxx00/BomzhvFque6AvPIFt1+o=;
 b=qq6UN0BzuWhPbQHMvJhr6lWxYT8+4iOcrybvRqHPTiQQgJGyaW0a8vzSdDlzpfc5Ft
 LkztFNVnyVtKNR8TEXwrbuxGLMpOvcsCmHwLck9ewSihyqaBCQQ8q5jBRXIi8S6H11BY
 bFIYn1J8+ZIK8wSPqxsW26KRJpA8pvq4vTVBnz2UlJgAGRU6AoAba3ojkoPeh4vVy1dV
 /fwKqfkxGY8FOna9M4ZWFoNVW1kMEXyNTJU6K4lK+bdMYOnYmOpucietvoS/dB+QQVNZ
 vJKYvggJup7s/FJ36Yu2USvEr8YUsG9PbUsw3Kv6zd4TjMQHcTnRP6gbBgrH/mguyU8m
 ByGQ==
X-Gm-Message-State: AOJu0YxnL0/eOZHD5jMLzcYI9PYKbdS1hnTZMCigGnPZRCbh6Mh8VEoe
 aWrOlLLhdqaBk/H0ApLFfE6QnPIcQt2PzkafpvoZm3T43FcsR7o1+1ULx6d2XwM=
X-Google-Smtp-Source: AGHT+IG1EsF6YXFxbk+7v5yGYSM7Y4uAKTxQr6b3aFPh3cew9U54KpwS9s9VLWO4WzjusrV4aFV4Zg==
X-Received: by 2002:a05:6830:63ce:b0:703:77bd:9522 with SMTP id
 46e09a7af769-70940c1d6b9mr17899758a34.17.1722348180511; 
 Tue, 30 Jul 2024 07:03:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b3677464sm1354696eaf.35.2024.07.30.07.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:03:00 -0700 (PDT)
Date: Tue, 30 Jul 2024 08:02:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
Message-ID: <20240730140256.GT989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat>
 <db1d3c5c-918b-4aa5-b68a-020c168cf05c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p9SV50ga3jfMJaYY"
Content-Disposition: inline
In-Reply-To: <db1d3c5c-918b-4aa5-b68a-020c168cf05c@linaro.org>
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


--p9SV50ga3jfMJaYY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:48:06AM +0200, Jerome Forissier wrote:
>=20
>=20
> On 7/25/24 19:22, Tom Rini wrote:
> > On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
> >=20
> >> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> >> library for the network stack" [1]. The goal is to introduce the lwIP =
TCP/IP
> >> stack [2] [3] as an alternative to the current implementation in net/,
> >> selectable with Kconfig, and ultimately keep only lwIP if possible. So=
me
> >> reasons for doing so are:
> >> - Make the support of HTTPS in the wget command easier. Javier T. and
> >> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> >> so. With that it becomes possible to fetch and launch a distro install=
er
> >> such as Debian etc. using a secure, authenticated connection directly
> >> from the U-Boot shell. Several use cases:
> >>   * Authentication: prevent MITM attack (third party replacing the
> >> binary with a different one)
> >>   * Confidentiality: prevent third parties from grabbing a copy of the
> >> image as it is being downloaded
> >>   * Allow connection to servers that do not support plain HTTP anymore
> >> (this is becoming more and more common on the Internet these days)
> >> - Possibly benefit from additional features implemented in lwIP
> >> - Less code to maintain in U-Boot
> >>
> >> Prior to applying this series, the lwIP stack needs to be added as a
> >> Git subtree with the following command:
> >>
> >>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savann=
ah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >=20
> > This is better than v4, and on the hardware platforms I could build and
> > boot on (which was most of mine except the am62x_beagleplay), the tests
> > ran and completed, including the tftp+boot a Linux kernel.
> >=20
> > The bad news is CI blows up, a lot:
> > https://source.denx.de/u-boot/u-boot/-/pipelines/21764
>=20
> They're all failing with: undefined reference to `tftp_start'
> The reason is I inadvertently removed the 'default y' on CMD_TFTPBOOT :/
> Fixed in v6.
>=20
> > And:
> > https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis=
/build/builds/9014/logs/106
> > which is another Kconfig dependency problem. I don't _think_ I
> > introduced that, but since this wasn't against top of tree, I had to
> > apply the cmd/Kconfig patch manually.
>=20
> What's the build command? I can see:
>=20
> /bin/bash --noprofile --norc /Users/runner/work/_temp/9710a6d2-6670-4f76-=
81bc-990cc45b1898.sh
>=20
> ...but that's not super helpful ;)

make tools-only_defconfig or so, sorry.

--=20
Tom

--p9SV50ga3jfMJaYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmao8okACgkQFHw5/5Y0
tyz3eQv+OVlkOa54tHBTJ4qXUOl/3Sum1qY5xjVovb2ap6G1cElPv0OSn1knRovF
ex+wYqq++K7S9psoiRtCVxwAix2ipi0/42sWUeOeCrdrsBFMxFDrzupD7mQ/yD6/
DbIP6ebPkXZsOY2By6lNRzFfuGUQRfCnuaSybGAIUh+ejMSHkqTHHsD/dVA0m/Dg
0PcI/7ap5wthsloH6VtJLLwJQcU/YdTFSRRfmTDIjtQj+o/AXriJNKhZpxMUZixv
mj9HxTfr9u9R0w2Tokv+8k1tj0SxHPH2304mc6LiADfBBaf+OJFIPllubSODRz81
6xd7+74Qy0+8znj84hPtDYs8fZ/1BnKhxszyAxxjBKdGZ4oC946naAZkVZISEf1y
MN+AOAfBdzNbbbWnkhjWGxF+6to6mG2XAQ0bfjo8BPFquK2LRSMNUB5u+C5MPsji
RrQmKtk6Sbenpchd9SMyw7e0x+KmkfOs8jAsY3icgMhGx/suJ7Ugej+17y1cY/Tb
UDM69GrY
=3OfZ
-----END PGP SIGNATURE-----

--p9SV50ga3jfMJaYY--
