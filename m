Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5AEC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28CB081951;
	Fri, 28 Mar 2025 16:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OBD4MTAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E376481A0C; Fri, 28 Mar 2025 16:57:18 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2738144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2c873231e7bso535158fac.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743177434; x=1743782234; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6EVTH8eZaj21gUo8EXqMxp+4uLuPfmYQhVZJJ+gUius=;
 b=OBD4MTAaJYLC16b1MTIl/Q2HfZcWDl4+mm9fu9JtwozmxWcrUdX63xYdWRoGRJr0hT
 U27lqw5bxoI3nMOMK/ebS8jqvoacU50sUdxIFePzUl7YsVa1UQ+lh4O95c/yvEjx6f41
 JTp7pTDPywBMm4PnLpeCJbU08JgaWU+PNPQco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743177434; x=1743782234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EVTH8eZaj21gUo8EXqMxp+4uLuPfmYQhVZJJ+gUius=;
 b=w6CAYPtEZeCOv/6z2J+jwN/d8AvdqL4vchNFnjR85LDEetR3190WzSQBsw6qNvKD30
 kgwOd0T2soKc40TlJ1f+Ox5GzG6dfrp6OfywBtuCja6EPSoTPjQBw27nuw8leCOe+0Fx
 Z9GE/YmW6OGOF5i/mMX3jvzqQPsk4k4Iv2vKpKd1+Ow8OrFQFjjAI/RdOinYHYIfPs+k
 QzMp/4eqJMIqpMr1tTGoUOxNzF5iq4FEkWu++arL7RW0rGnx2na6LKMjdytii/MC41kl
 IopDyh62/G27Y7dO3sPYgnFlKja800YNXbe/FkGgHwjhKS1KrTDB5udH9KowV9f4xiA+
 o9yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnBHckZHUat7KzRyuM1w8+rUE/A9APEOwhNzYpco9jx40lr4vdfmo3sT33Za74cXddrqDJuhM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/YL0zouLIFV5aWPglzBupe+XMcdwKvDHtVxc7yUdjhOd7d2WG
 aU/tEBePgjf4KDAimwBiogmiuq/arnpNMuT+vALKqCN1XNxVla7SfDUr+HI47GY=
X-Gm-Gg: ASbGncsSDo8XgVL7d5KAJ9rGuguLt3c2eDHxiStjrkpp6h0OJqs5rn6mCtzOweheRC0
 4bhD8C3lFIDPAQDARLYzYOu8gCfKXhmmdtOBJsaVTqvjpCP7LLDOkB4WLNM/YuoPB49GDXKPX+V
 dDTC/iny2fv+rIkhyw09pRJpU8sotLczPW6r882rWFuwDQ+Wkk/TOcT7cnhK02T/F/q8pM+Esxm
 T1MhhslwqY3R4FXpd2bFE7EJz4AdQ9qP7aNNOBhkW5EZQLpRVAo6CDBcV1PgarJ9K73jKRkZtnh
 nS06VrX+NYMcXxInyzeqeN7Zv+9L//CiHjWLQlulbul2EC7oiE4E+4vRnw3cylY/vs1NuIC4YsC
 NTtEoHQ==
X-Google-Smtp-Source: AGHT+IECmzZXJmqUY5iKHIChyRjESHlnlD79cC1RVyRftQRODuo8oozrZ2MmUx7Df1b5YPO1JQ6ALA==
X-Received: by 2002:a05:6870:798c:b0:2c1:b58c:c0c with SMTP id
 586e51a60fabf-2c848228571mr5823171fac.34.1743177434517; 
 Fri, 28 Mar 2025 08:57:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a856de7sm476599fac.39.2025.03.28.08.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:57:13 -0700 (PDT)
Date: Fri, 28 Mar 2025 09:57:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Fabio Estevam <festevam@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
Message-ID: <20250328155711.GV93000@bill-the-cat>
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
 <CAOMZO5BMZi3adJCcxVq3-04YY8yAAVqkdcy8Q1tMzMsK+W0rEA@mail.gmail.com>
 <87pli3q1j9.fsf@bootlin.com>
 <CAOMZO5DnfOSGg0wCZpoqw9EsyLWL-ezDshGZT1s8WuBu-K_CrQ@mail.gmail.com>
 <20250327141442.GO93000@bill-the-cat> <87r02hlfb8.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9be4kxZZn0lPjDMQ"
Content-Disposition: inline
In-Reply-To: <87r02hlfb8.fsf@bootlin.com>
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


--9be4kxZZn0lPjDMQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 09:39:23AM +0100, Miquel Raynal wrote:
> On 27/03/2025 at 08:14:42 -06, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, Mar 27, 2025 at 10:31:18AM -0300, Fabio Estevam wrote:
> >> Hi Miquel,
> >>=20
> >> On Wed, Mar 26, 2025 at 12:01=E2=80=AFPM Miquel Raynal
> >> <miquel.raynal@bootlin.com> wrote:
> >>=20
> >> > I rebased this work on the latest next, fixed the conflicts, adapted=
 my
> >> > changes to use Svyatoslav's work, fixed the CI.
> >>=20
> >> v5 still fails in CI:
> >>=20
> >> https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25364
> >
> > And the exact failure is:
> > https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1078073#L259
> >
> > Which looks like a series conflict or test needing to be updated, rather
> > than a "what the heck???" kind of failure like before.
> >
> >> > Then I pushed a PR to trigger azure tests and figured out you applie=
d more
> >> > patches (imx8 clock related) which conflicted. So I rebased again and
> >> > fixed the conflicts.
> >> >
> >> > Azure testing is failing though. I just pushed an empty branch with =
just
> >> > today's 'next' and it is already failing, my series does not produce
> >> > additional warnings as far as I can see.
> >> >
> >> > So I am sending a series that has been tested locally. dm unit tests
> >> > pass, v5 is on its way.
> >>=20
> >> If I remove your series, I don't see any test failure:
> >>=20
> >> https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25365
> >>=20
> >> I don't know about the Azure failure. Please work with the team and
> >> make sure v6 passes in CI.
> >
> > I see that the Azure failure is:
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10824&view=
=3Dresults
> > which was the unfortunate "next is broken because master has a fix and
> > next has a test that needed updating now" that happened this week with
> > -rc5 being merged. Sorry about that, it's fixed now.
>=20
> Yes, my question got lost somewhere else, so let me ask here as well.
>=20
> I need the tests to run on the test.dts and not the default sandbox.dts.
> The documentation states to use -T for that when doing the checks
> locally. Unfortunately, the Azure pipelines do use the default sandbox
> DT. I can add few mostly useless nodes to the default DTS for the tests
> to pass, but I feel like this is not the correct approach.
>=20
> Is there a way to tell Azure to run some of the unit tests (especially
> the DM ones) only with the test DT?

I saw the older email first, sorry. But I think the docs have become
disconnected from how things have been done practically.

--=20
Tom

--9be4kxZZn0lPjDMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmxtMACgkQFHw5/5Y0
tyyoUwwAjWRSj3MncSihfOO3UOuRmi9CSpFi7IvnAgzdSN2U/r4xWY7xnt6gVPvR
SqKCo7sLb6sNCWv3YN7jGYBMtiNV14rv1aXQ0z6PZFEna5sFqoRw4yyGHE5krh6Y
ScnqpXCDygu/aIO1ZOoWwA3/oDgGfaH4Yh3dFFEiFgLQr4KcAldFC73SkUKBss+V
I1TU8aIIXrPDhalnxyOacFzXlR1VL0z9plouIXeB2qVLmYXQdyB0+srWtqHgqur5
fNlWFLsWXaBhIr8sMGtrRqER6fZSszwCCCtQVPmWBylD8m68oRLcThtjf99sWLZT
IT9M5N6cenIlseELq3yttgXY7hMyyzHOnh93RN/5ZFQVVYQ/dPc8BDJBkgOPys9F
nHKP4wqX6tsQ+wwYbhwN1IP8Ub9hMS+ooeTTv5VYitrhP4heVBdy5Milrud9dneb
GjRtF/+CZcMvF97hSNeEp10wVQ6rfJDXCZzapiVpwmsIDSdBSYnhFsWQq8Fvp5jp
1KyvEGbk
=Xbvg
-----END PGP SIGNATURE-----

--9be4kxZZn0lPjDMQ--
