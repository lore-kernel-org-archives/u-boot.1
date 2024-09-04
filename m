Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08779CD4857
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 16:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB93088B13;
	Wed,  4 Sep 2024 18:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e2C8Y87x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D42C88B13; Wed,  4 Sep 2024 18:09:36 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A9B88B1A
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 18:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-45677452159so38182561cf.3
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725466172; x=1726070972; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eIpVueaNfzlJSiebnYAqjJgd3fp/AIyV3uNZ7BetCFs=;
 b=e2C8Y87x1DrumnpjI6NbpQUo1i9yflg8M6vw5ihaXIJF+4dTbRkDPktZLepTDWv7p7
 L8am3e04PeJ04CVqTOM3BqneHn+pJhMOwys67zKhSnThKm0H8RK6qsgVUGrJCYKdGdjz
 YHQDZznp9osf0CHutlqordXKldD9Vu/3elYBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466172; x=1726070972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIpVueaNfzlJSiebnYAqjJgd3fp/AIyV3uNZ7BetCFs=;
 b=BIrY6IXdQqbAmgukApeeJJRyujh7mM/Xo4qtxWx4/IOIbdslhtoHbz9YJbYPAj2xs5
 dcLxlGQLEexxqC7kwdzzpnIyztlkas9LaO+sj+8/vaqF1Svm+LARnSzuqD7sGhA1qfW/
 YBd0BqLwYcKIV5OIZ72UHYYfLAbz0f0L4U8swser3J65QsXPOHY2sbPGHskjBQ04f3q5
 b+RFPTwDQNVwwFadR0jv4FhK6sGFoqTsa6OOdBrtIC4ht978t8jNgztXWLWK6koBRf9V
 6i3q4vfCi0UJZAaHiUlz5CDH+Gj2aBfzQU15lV9OFo+9TjuxvEUC8IPmw5zLsk+x2eLD
 peAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJzeCIMo+cn4ieoKzB3450MhfnYMDI33jAkStiy5rV2U7BT7HF/cKRfb3pumvwEtHhBo9GaZ0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywm4egpi/n9q8CMO/D8hgLySVxgvm+bVwJxYHYuWNqrTsHo79Y7
 enjwynZXpJ4lHjQk5fuNnhT8cPEc2Sch6GhuJYGvCUGvFYtWPQawHJjNeGStDh0=
X-Google-Smtp-Source: AGHT+IE7OhtmXlC90QUIVeXRbm/64RY8JT8rospUPGdy3fuIo5Wrqhf7qhiwsJRlnrhIpvoNulKxCQ==
X-Received: by 2002:ac8:67c2:0:b0:457:ca1c:fcc3 with SMTP id
 d75a77b69052e-457ca1cfe75mr108763081cf.50.1725466172304; 
 Wed, 04 Sep 2024 09:09:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682cb02casm59932671cf.42.2024.09.04.09.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:09:31 -0700 (PDT)
Date: Wed, 4 Sep 2024 10:09:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Gilles Talis <gilles.talis@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Petr Zejdl <petr.zejdl@cern.ch>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Artur Rojek <artur@conclusive.pl>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Yang Xiwen <forbidden405@outlook.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Boon Khai Ng <boon.khai.ng@intel.com>,
 Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v9 20/37] net-lwip: add DHCP support and dhcp commmand
Message-ID: <20240904152011.GP2479150@bill-the-cat>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <36a13357261f734187444b48b74dec2540e73b86.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszTi3YRpf4krkAYE1u7Sex0=Dn_YscSKxE8mQEh9Mxcgjow@mail.gmail.com>
 <a946cdb4-648c-46a7-83c5-302ab0d666d3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YGGV4SLWaOgUzVDu"
Content-Disposition: inline
In-Reply-To: <a946cdb4-648c-46a7-83c5-302ab0d666d3@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 04 Sep 2024 18:36:01 +0200
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


--YGGV4SLWaOgUzVDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 09:54:15AM +0200, Jerome Forissier wrote:
> Hi Simon,
>=20
> On 8/29/24 16:05, Simon Glass wrote:
> > Hi Jerome,
> >=20
> > On Fri, 23 Aug 2024 at 07:49, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP as
> >> well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI due
> >> to this code having an implicit dependency on do_tftpb().
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
> >>  .../imx8mp_debix_model_a.c                    |   2 +-
> >>  board/ti/am335x/board.c                       |   3 +-
> >>  board/xilinx/common/board.c                   |   3 +-
> >>  boot/Kconfig                                  |   3 +-
> >>  cmd/Kconfig                                   |  91 +++---
> >>  cmd/Makefile                                  |   6 +-
> >>  cmd/elf.c                                     |   2 +-
> >>  cmd/net-lwip.c                                |  13 +
> >>  common/board_r.c                              |   4 +-
> >>  common/usb_kbd.c                              |   2 +-
> >>  drivers/net/Kconfig                           |   2 +-
> >>  include/net-lwip.h                            |   3 +
> >>  lib/tiny-printf.c                             |   3 +-
> >>  net/Makefile                                  |  14 +-
> >>  net/lwip/Makefile                             |   5 +
> >>  net/lwip/dhcp.c                               | 125 ++++++++
> >>  net/lwip/eth_internal.h                       |  35 +++
> >>  net/lwip/net-lwip.c                           | 286 ++++++++++++++++++
> >>  net/lwip/tftp.c                               |  11 +
> >>  20 files changed, 560 insertions(+), 55 deletions(-)
> >>  create mode 100644 cmd/net-lwip.c
> >>  create mode 100644 net/lwip/Makefile
> >>  create mode 100644 net/lwip/dhcp.c
> >>  create mode 100644 net/lwip/eth_internal.h
> >>  create mode 100644 net/lwip/net-lwip.c
> >>  create mode 100644 net/lwip/tftp.c
> >>
> >> diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp=
/icore_mx8mp.c
> >> index e2ed70caa43..bfdc447c478 100644
> >> --- a/board/engicam/imx8mp/icore_mx8mp.c
> >> +++ b/board/engicam/imx8mp/icore_mx8mp.c
> >> @@ -33,7 +33,7 @@ static void setup_fec(void)
> >>         setbits_le32(&gpr->gpr[1], BIT(22));
> >>  }
> >>
> >> -#if CONFIG_IS_ENABLED(NET)
> >> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
> >=20
> > How about making NET mean 'net', rather than having two options?
> >=20
> > Perhaps the existing NET needs to be renamed to NET_INTERNAL or
> > something like that?
>=20
> The problem with that is it will make it a bit harder to remove
> the legacy NET implementation, because every occurrence of
> "if NET" would need to be questioned if it is applicable to
> NET_INTERNAL only or to NET_LWIP too. IOW, some of the thinking
> already done here would need to be done again.

Would a new symbol instead help? Make both NET and NEW_LWIP select
HAS_NETWORKING or something along those lines.

--=20
Tom

--YGGV4SLWaOgUzVDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYhjEACgkQFHw5/5Y0
tyxCYQv6A8H87MrvInOF/+7jokK/aFCTnn08YT/n9d4IW5P5oM+5lpLp57AHLVhg
MsxMJOVk015ZD2CSrk7oY2ZPOJfKva55/d2ngPQbpxD81ZtHF1zbMlVc/ZMIZ7nI
E/ukU7WBDZB0vpOfS+E4mHCSYNBCCp1N+aVr3cAi4hU6MqZ1/RY8Lqd5N4fO8TY0
8eCMTxZqfgKbWL2eBeZmt1pOknmSzDhfpEcXD6Qs5lt1Ak0yfULsU0t9ywXo8Res
lRmLXDMjSqO7OWXfNy6ohy4nCt3ZLsved+ID3z5RiRxqXON6a10INJyFZG7p/5Li
a6cdz3opROpCzL/FUW/n/s6etAGSC626rQcBbX0ApSIRTPyEfMEL+ji0dOao3v65
JTDDqzhh4z4gjUmR4HBm5+8YCrxM4njYN4KxlOQv+mtHdt0a+1U0MbuBbzes0BEY
hPw1eOoVk9ER8bdgKn/6gO3toItd6oLd2PoDttV8wvhfpzZvGPmbbenGek5OlmMF
9EwkqpDQ
=xjKC
-----END PGP SIGNATURE-----

--YGGV4SLWaOgUzVDu--
