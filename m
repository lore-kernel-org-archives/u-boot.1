Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB46C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12CF94088F;
	Tue, 21 Jul 2026 15:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dm2EjqByThOJ; Tue, 21 Jul 2026 15:05:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F58F406DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784646336;
	bh=kPSLeWZiUj/CnVpmADbYU/Ad0c/cvUddKLIS/t3Dhik=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yy/GntdwJ55szIcLbWBlZF0cqb4xkzuBUcAjSIhPeWL857+K5+k3abLvdh+gataBY
	 QVjFieF5LNxutd4Vu18cCSrL2m3UyUTi9mLHWev33cQTVOInU12R8FaIMtDtyhdBTe
	 187vzscS6UIDDZjVKCOWM3vvHYxHwWkWq4ba5UnGgPB/RKQWaWafHT2VPM7nbqv/AS
	 vrdK/eNOMlFr+D4yULbC4oazreeykGP/eNAImiB4K9W+6wUIGfPas+6aKzHZvUthpX
	 2iX/jR93jIP1stc9X8Td20SDoSdi4xVkZOTL54w88DKUm1/JOcJq6brc2dRGITbmFA
	 sC0NfRWLSZRDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F58F406DB;
	Tue, 21 Jul 2026 15:05:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30225224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2226E40862
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmTfcWQQRCI6 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:05:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2CAD0406DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CAD0406DB
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CAD0406DB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:05:33 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-492046a3313so5420404b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646332; x=1785251132;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kPSLeWZiUj/CnVpmADbYU/Ad0c/cvUddKLIS/t3Dhik=;
 b=noWDazpwVgCu9M4fTnKEgUJG4NAUvArBUsAEiyMtB6SJdTjUSo9w7D95Rc35UytdzM
 nKbSQrfSfYGpuVBzL7fIBlLRSIbnSnyF/gGAIS7qa8s5/yvPoN2TtE67Zl8T8/2B96J+
 zv84Ri5JKl42g9Uy37IDMxzRvZQnrCNX5Ax7a508VjarKNfPVhqmR9KdsUUANXgvK9F7
 mxHy/0A98PjXr3RC4K3H50eW8AIMhDHK9epm06S6PUv0Ldd6JIjsNCQ71thCEds6AoBs
 /5QJw5h84EFRuRoIf0YQXQ3dzfu3qAdczZ3jtC+IudkPEDmUY/GhIhKdD9TalyJOZdFj
 xf+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNzUo0cf3oRwC1E0TFDbEzVaG3uqnXkhdMdE6pp6h+12U8BtODcJ/v46q/GnbZbUdYcC2C5AA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyJXj4V0lPmeYTMfDUPeXOz99R3AzwjAbhAkQAsUd3E7MxCyVi6
 MUhvYzqHcDUBuZBBtOyJUNsNAvCOWhIW9tRJ4ZDvIE/kyELqXUpTRin0Nn5okaq9r8c=
X-Gm-Gg: AfdE7ckEWqeeU+NihB29IU7CSHmucJ6cIa1tTsWQ9P8TGMlmxjYCjWDh/tRuOGGrXXi
 a6LATNdjRK6/qmwAdLogqrR22M4guyOX+2PuuBiTH6Z9XjQZ5+rDN9mdzQmxVY7ZP/W24k4nGU1
 nsmZ8834eawBdFodmVkvFSFqKGwPv6w20n5QPFJ5+rPWGBRI1NheQUQWv6C52Tkt2DDnxQ9Vfcq
 CpGpqXzg2uXEyPfpy8FU6dVd6HlYnkooOnYLcRa/1kyorsLYHik9w0EASEyEt3mG3s2YhetooNW
 hwsp3mewXw+APhwov2sKWuNu0ZagTfPZ1W9sBLMrwTdjSrrPqj3VeTfGv2SOjMdJqV81zLq81FP
 Jzm/mPPSzS16/RWd7P1SnP9FFaIUzOtJRax8rb3jNQoKUS3qE8xIu/imx3PZ9q8/2a7fEKxkVgH
 KG8ivJ91DrNH3yKZxG8xxYywRaOJSyWyp61BDco8FIfFvip4UmMXhnwkPeO2DHhIWY/fvjqWnJj
 8hDWDZTaz3U5afGKlwckfUl9fM=
X-Received: by 2002:a05:6808:6f8f:b0:495:f223:bcdb with SMTP id
 5614622812f47-4a4cfeb1bcdmr9174168b6e.0.1784646331603; 
 Tue, 21 Jul 2026 08:05:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3a57b0fsm9802293b6e.1.2026.07.21.08.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:05:30 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:05:28 -0600
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 u-boot-custodians@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
Message-ID: <20260721150528.GV749385@bill-the-cat>
References: <20260715173119.GL749385@bill-the-cat>
 <868f95a2-269b-4879-ad65-b7dbaf2b1b14@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1q+1bm25AKyfkNfx"
Content-Disposition: inline
In-Reply-To: <868f95a2-269b-4879-ad65-b7dbaf2b1b14@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784646332; x=1785251132;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kPSLeWZiUj/CnVpmADbYU/Ad0c/cvUddKLIS/t3Dhik=;
 b=RiquTJ3yssNGhoMZWy5Pf7QHFjrB078BmAv7kGT2Bl10FdSmGwkJh9P9GzQOjnHznL
 6IChF6tX4m8//SiLNX1tzpLy3rcw1xyzNwoaRnCfgNqC/XVb43DKnCv1bDk496CQPpqB
 1SpdYwqOLe2jc1rtrg1PIi1gL2dQzGM8//F5I=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RiquTJ3y
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--1q+1bm25AKyfkNfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 04:52:17PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 7/15/26 7:31 PM, Tom Rini wrote:
> > Hey all,
> >=20
> > As I've mentioned in previous release emails, we'll be migrating our
> > lists over to lists.u-boot-project.org. The news now is that we have a
> > date. This coming Monday the 20th of July, we'll be turning off the
> > receiving side of lists.denx.de and then importing everything over to
> > lists.u-boot-project.org.
> >=20
> > What do you need to do? Nothing much. All active subscribers and their
> > preferences will be moved. This includes how lore and patchwork are
> > linked, so all of that will work. We are going to try and ensure no new
> > emails get lost in the migration.
> >=20
>=20
> OK but does that mean that whatever mail sent to the old mailing list won=
't
> make it to the new one once that cut off date is met (that is, yesterday.=
=2E.
> yes I'm really asking at the perfect time :) ). Essentially my question i=
s:
> will we lose mails if they are *now* sent to the old mailing list. I'm
> assuming at some point in the future they will be? Is there a cut-off date
> for that?

The good news is that we were able to setup forwarding correctly, so
there's nothing being lost at the moment. A final date is something we
need to talk about off-list with the people that have access to denx.de
infrastructure still.

Nothing is being missed in *our* archives.

> > Based on feedback from the test migration, we believe we know what was
> > missing to ensure that the archive links are stable, and so that should
> > be the case when we go live again.
> >=20
>=20
> I think we're missing an update to lore.kernel.org to monitor the new
> mailing list now? b4 shazam doesn't pick the trailers reviewers provide on
> the mailing list since that date unfortunately (due to the mails not
> appearing on lore.kernel.org I'm assuming).

Yes. I've been trying to reach out to helpdesk@kernel.org for a while
and not had luck, unfortunately.

> I **think** there may be an issue with patchwork as well since I don't see
> my answers in there either, see https://patchwork.ozlabs.org/project/uboo=
t/patch/af0ac32e2bf603c39f490f15fe62319fd73c5282.1784423864.git.daniel@makr=
otopia.org/, https://lore.kernel.org/u-boot/af0ac32e2bf603c39f490f15fe62319=
fd73c5282.1784423864.git.daniel@makrotopia.org/T/#u
> and https://lists.u-boot-project.org/pipermail/u-boot/2026-July/625465.ht=
ml
> for an example.

We also had a small window where patchwork wasn't updated (and I'm
talking with Jeremy to backfill that).

--=20
Tom

--1q+1bm25AKyfkNfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal+KuAAKCRAr4qD1Cr/k
ClENAP9f/OAk2ql1+kfkZxHEQc030UavQqN5jGmvhkPb/yUc1wEAxJ7OBKU3EFvb
zcwoOiFNp3h/m0ROwGfTNCAckWNa8wc=
=D9dH
-----END PGP SIGNATURE-----

--1q+1bm25AKyfkNfx--
