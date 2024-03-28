Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD55C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B8988169;
	Thu, 28 Mar 2024 13:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GTgLvgnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6694C8811D; Thu, 28 Mar 2024 13:58:47 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8331D88170
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4316101ed5eso1313981cf.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711630722; x=1712235522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1J2Ag8wxnnK+Qexx8v/oxl40ZQ6xSp7ysj5AvUrBDYM=;
 b=GTgLvgnWo75TocoNyuvBonUd6lac45J7wSog9IfXTQJgq28xcIpEdy9Fu7qBphEezC
 E53K3Y9SlzrNKyZ21TXFqaUXgnM2KXhAcFkf6yRGrYrk/9cPampfLGN1enqwhHrY+EJ+
 vdy8K+zPZtTVAySKrzSke/2jPEQAed+ybdOoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711630722; x=1712235522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1J2Ag8wxnnK+Qexx8v/oxl40ZQ6xSp7ysj5AvUrBDYM=;
 b=B167ngjkSPce4kW5blNiJOp9J5AQQ9FsOYOT3rmMIiHImO0SYzRsu24du23Iv+axDI
 i4mzF7HbXkSCpuqXE2eTxlrX+B77YiL4lo1Dg1HLVN3pE+AJYBcrIiZlZyXTFa/xbnBo
 oo9Qc77I1JMZzZw+plviwKXCkVrYqmMJe4oifQ2qSwyPWG5IqfWaAGUVbh4Oa1N3eBS5
 VlftISdCpRCClZB5wEeNlg0hcdRBHt3f9sLLMDahbj5hz9FZX/TTx2B7CQKnHKEJi6NO
 A1IYmjOEWPRMHCb6bwZ7aDg+fAUQ0hpaRAJOTGTJIuh2KcmdwbPJ9pBtrH8lYiDhMMRe
 ikvA==
X-Gm-Message-State: AOJu0YyPgNrsw+6pm5OvP746nH4CaY1NiIgaUtUPuPSiwUQvqW/cpVw+
 kBUASHoMlmMRaSN3QCPHHBB+/De4xQaB1qWJxZBpj0TdxbpLGlwnacv/Rh6AmIE=
X-Google-Smtp-Source: AGHT+IFvwIriIjxXHYrS+Dip/lW4UHr/ELG+GSDs7egjeEC2+hXE2Nsw/7XQVsHTMDPHLvbmONiP4g==
X-Received: by 2002:a05:622a:1206:b0:431:6071:dfa1 with SMTP id
 y6-20020a05622a120600b004316071dfa1mr2676453qtx.35.1711630722361; 
 Thu, 28 Mar 2024 05:58:42 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 f2-20020ac84702000000b0042f14f31cd9sm583039qtp.92.2024.03.28.05.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 05:58:41 -0700 (PDT)
Date: Thu, 28 Mar 2024 08:58:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: Thoughts about U-boot binary size increase
Message-ID: <20240328125840.GN3442575@bill-the-cat>
References: <20240328102049.10108d5b@wsk>
 <20240328121832.GL3442575@bill-the-cat>
 <20240328135522.4a07002d@wsk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0n9nA26hg+kBmCa4"
Content-Disposition: inline
In-Reply-To: <20240328135522.4a07002d@wsk>
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


--0n9nA26hg+kBmCa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 01:55:22PM +0100, Lukasz Majewski wrote:
> Hi Tom,
>=20
> > On Thu, Mar 28, 2024 at 10:20:49AM +0100, Lukasz Majewski wrote:
> > > Dear Community,
> > >=20
> > > I'd like to share with you some thoughts about growth of u-boot's
> > > binary size for SPL and u-boot proper.
> > >=20
> > > Board: XEA
> > > SoC  : imx287 (still in active production)
> > > Problem: SPL size constrained to ~55 KiB (This cannot be exceeded).=
=20
> > > 	 Board design constraints u-boot proper size to less than
> > > ~448 KiB
> > >=20
> > >=20
> > > When XEA was added (2019.07):
> > > 	- u-boot.sb (SPL): 37 KiB
> > > 	- u-boot.img 	 : 401 KiB
> > >=20
> > > Now (2024.04):
> > > 	- u-boot.sb (SPL): 40 KiB
> > > 	- u-boot.img 	 : 427 KiB
> > >=20
> > > (With a _lot_ of effort put to reduce the size)
> > >=20
> > > Hence, the question - would it be possible to take more concern
> > > about the binary size growth?
> > >=20
> > > Maybe CI could catch patches, which enable by default some features
> > > and the size is unintentionally increased?
> > >=20
> > > I'm open for any feedback and thoughts on "stopping" the binary size
> > > increase. =20
> >=20
> > I think that's pretty amazingly small growth for nearly 5 years of bug
> > fixes and feature enhancements that it's likely minor to make
> > granular.
>=20
> Those results are after using OF_PLATDATA in SPL and other tricks - like
> compression of DTB in u-boot proper, so this caused some extra effort
> to keep small.

Yes, and I'm still pretty happy with that. I would encourage you to do
what I suggested, before turning on LTO (as that makes it hard to see
symbol size changes due to the nature of LTO) as what you asked for in
your original email is what I do, and have done for a very long time
now, with 99% of every pull request / branch merge. I'm not saying I
didn't miss anything, but I am saying it's a matter of specific changes
and not a general problem. And if you hadn't previously set the options
to enforce failure to build if hard size constraints are missed, please
do so.

--=20
Tom

--0n9nA26hg+kBmCa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFaXwACgkQFHw5/5Y0
tyzw0gv/XOtRF65HwE+ZCA1J+JGOoVb4T1XdfpzW0cvDiIu1DqAbM2/GcJ6r6rTD
kAjLbF8+8t4+S/p4yquWVdJMeDcImd+TjNA3O/rsxLUFfxquPH827wMS4k6X8Rfv
BCZsA21jMkQpdxq/EkpKx53r6gZug3KXUsHjU15DxypK12UMs0CmLWuzBzbl4Y2B
n5zUm+p9Q2LF7Hf+LOy2qJST9ZZ1vym10Lwq+mmfsG14DZO9OqJv9oPo/LtBote7
CMX+b6s1rrIBaQe/yMJEVBLkqIs1J7MqK3zAaCf6VasZXwsph9UZlkN4BwKFABcT
sFu8nVCJmUqvNj/lXpPNPeTMMZbkYnMf6HiTMrYB6lnZO6Ue+ro7XlUu4pH6D1qM
5aXdul0JdIObTUnf5BHldnbENULZAFzaEaSFNR6gpiqb/g1kyjbwaO74XIpEuP9D
NWnXcG3lgOB06vuPj9shK48GZ56VJPv/mW1W/4IapT+JuzijYB50ivQt9Hw4V1S5
E3QYDSp5
=Hsqa
-----END PGP SIGNATURE-----

--0n9nA26hg+kBmCa4--
