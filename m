Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D15C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14CE688AE4;
	Thu,  1 Aug 2024 16:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V0HRi2hR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B51088ADF; Thu,  1 Aug 2024 16:43:51 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C1D88B17
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7093b53f315so2602478a34.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722523427; x=1723128227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dl2xrcUHVQwTOmv8LkbxCa+ZVcqtj8eXYnjkETgcdTg=;
 b=V0HRi2hRZUl4r2KK0EwZbpHhE+ww/lGZcjyTlo2qg+cSQ7ApR5sYgyMM9JYq3uk15X
 WONgJkmiTLSwPz7jfIyhDDL69yjdu2a3rxVmO1cnp2Uztf/eVeWD2opejdFM3ze8b0rA
 QzkxyyQsgLJA3MFInCGe00Xt1XxWibQvffLYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523427; x=1723128227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dl2xrcUHVQwTOmv8LkbxCa+ZVcqtj8eXYnjkETgcdTg=;
 b=c59wRsxv5+p8kHyPU0rTukx/03DY1Xi1TNFvAY+mooINUNP79OEYaMa7liZabdI66t
 s2qX3+/foWH8YJNCZzMP445uwI/4Pf/IljWjY73ABygGFM4nAUy//Bkijcfn42BBPlSI
 IEgLCqFWft5J45N3UAQyiFFilCX1RQSashVRYSTvhzxuEMr44LvYMGscgR0d4fRHl/f+
 u0sj0bjd736GxZvakMvhPW5dqOJK0jsn6hgV7ZMNNOqGJcvkP+6OCNAYCKz15ykZq9Tc
 KNMsNYLY36cVb1fxjDIyIMGoVvGPRFjdNAhIhCNoPzeLUXnAdp+4KUCqaHvsvkPHbxMu
 Ev4Q==
X-Gm-Message-State: AOJu0YzwDmReWIT1rAVjgA6fe42L+GTjHoW78Ha4LmGHrEiALWVNDqt1
 gzgsACv3QUOXNPvwru+Q6xhUtv+h5qODVfzwO5beu0eDe0RSwM2ycfzpc3VSf0s=
X-Google-Smtp-Source: AGHT+IHwk3XaYvdqBxz8xrToYo3AIhZ1Rm4Sr8wVHIBBgJFQuk+jW9la0o3Vs1iAsviFL0aBWGSiaQ==
X-Received: by 2002:a05:6830:7107:b0:709:40d5:44f2 with SMTP id
 46e09a7af769-709b32015e1mr404599a34.3.1722523427552; 
 Thu, 01 Aug 2024 07:43:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7095aea641bsm1401681a34.58.2024.08.01.07.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:43:47 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:43:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
Message-ID: <20240801144344.GH3794063@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat>
 <20240725223401.GD989285@bill-the-cat>
 <ebc992d6-93e8-4e7e-99dc-834cc981f5a3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="80rdvzUvNhg5JRum"
Content-Disposition: inline
In-Reply-To: <ebc992d6-93e8-4e7e-99dc-834cc981f5a3@linaro.org>
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


--80rdvzUvNhg5JRum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 04:40:03PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 7/26/24 00:34, Tom Rini wrote:
> > On Thu, Jul 25, 2024 at 11:22:20AM -0600, Tom Rini wrote:
> >> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
> >>
> >>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lw=
ip
> >>> library for the network stack" [1]. The goal is to introduce the lwIP=
 TCP/IP
> >>> stack [2] [3] as an alternative to the current implementation in net/,
> >>> selectable with Kconfig, and ultimately keep only lwIP if possible. S=
ome
> >>> reasons for doing so are:
> >>> - Make the support of HTTPS in the wget command easier. Javier T. and
> >>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> >>> so. With that it becomes possible to fetch and launch a distro instal=
ler
> >>> such as Debian etc. using a secure, authenticated connection directly
> >>> from the U-Boot shell. Several use cases:
> >>>   * Authentication: prevent MITM attack (third party replacing the
> >>> binary with a different one)
> >>>   * Confidentiality: prevent third parties from grabbing a copy of the
> >>> image as it is being downloaded
> >>>   * Allow connection to servers that do not support plain HTTP anymore
> >>> (this is becoming more and more common on the Internet these days)
> >>> - Possibly benefit from additional features implemented in lwIP
> >>> - Less code to maintain in U-Boot
> >>>
> >>> Prior to applying this series, the lwIP stack needs to be added as a
> >>> Git subtree with the following command:
> >>>
> >>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savan=
nah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >>
> >> This is better than v4, and on the hardware platforms I could build and
> >> boot on (which was most of mine except the am62x_beagleplay), the tests
> >> ran and completed, including the tftp+boot a Linux kernel.
> >>
> >> The bad news is CI blows up, a lot:
> >> https://source.denx.de/u-boot/u-boot/-/pipelines/21764
> >> And:
> >> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_api=
s/build/builds/9014/logs/106
> >> which is another Kconfig dependency problem. I don't _think_ I
> >> introduced that, but since this wasn't against top of tree, I had to
> >> apply the cmd/Kconfig patch manually.
> >>
> >> I have my world build running still and may have more comments based on
> >> that.
> >=20
> > First, with NET_LWIP being default rather than NET, there's a lot of
> > other Kconfig dependency issues. Unfortunately I don't see an easy tool
> > for making sure this is all clean aside from a shell loop like:
> > for C in `(cd configs;ls)`;do make -s $C;done
>=20
> I have run this loop successfully with the upcoming v6 version. Some
> configs do print some warnings but there is no error.

Those warnings are the problem, I wasn't clear, sorry. If I could make
it error, I would since then CI would catch it.

--=20
Tom

--80rdvzUvNhg5JRum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmarnxkACgkQFHw5/5Y0
tyz7bAv/Q1TqmsFtwSR4nUPIH126OBSG39wQCPNOCv2YwJm3WKb5MXxo247Ra6q5
qxS4WuZb3koRZwQJDQye1HFvBnlj3oCkdIJySaYO6+8KP+u03RTeSg1U8Btnv5by
+OBtU0R/494CIFBrKLMIPP2k0C6FOY83jRRGAJ1Yj4WxjRP486bagLmt8KW5TB4m
SqV58HNbIbjGY5xD881JQejft73K8VmVANgu/HBmM1zpFHSmCbEPJwGjB8M1iMfh
4b+X61NSoNLSjudbas//GPt6P+mc3n6hbTPV2oSTKomfN2ztus/e2LCTryCRdkvk
k0WoGskuHdt/Yj4/PrFQQIxfZMUZl0l5nNQBCBM0l9M6paU8yZQ+zk9Lidmc3Ysy
pym1c1f9jUgCcBHdDD4zwWCMWbEaRRg3Vy6xpUDZPYAMy14/xzYWxdKflUAGSlso
zZt/qeG5yscyEH0INBV5Y/8iNrCiS6bGyuo1ovOE+l1JcesfOLDj8mlPRFIJsL6t
J7Gj0p4l
=tP2+
-----END PGP SIGNATURE-----

--80rdvzUvNhg5JRum--
