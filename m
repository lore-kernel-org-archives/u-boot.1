Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE81EC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 22:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A8CE60728;
	Mon, 20 Jul 2026 22:22:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjRFhMO688wE; Mon, 20 Jul 2026 22:22:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC5FA6070B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784586134;
	bh=xR+5Wek4cI/BS0jx0Qem2h+2mYTlfeq8RCZr4FhLcyw=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dLVq8m+t+B9ruG9/Ch2P5LXcGKJssnH3CtC2KzuwHtalrx3S8Hu0xrkn+Prk2GPxB
	 rFQ2uL6+j6S6rHyUIwJ5E8l6t3XQMtOSzk14x54I1+p28x6+IyvXexMEMy1esZz3bO
	 o7Sx4wfjttF8Ljo9U/h7fSuEeEgxRD8WX4PHm8imwRi1+G6s15PeHWcOr35OY7JoVC
	 cn4qRXwKkgPiNZ0AYLKPbYlChpqe71qQ7/5m+R7O/RKpDW9KirKfEwG6bj/pvOTjWI
	 G3HyHcU0HS4j2Ha7gh/+2AY71Q8BxQ5BFS05HMZ/HCvGzbALbMzLx75ueg8Wv3t1px
	 YtNynbla35C/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC5FA6070B;
	Mon, 20 Jul 2026 22:22:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52924DF0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 22:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38FB180D58
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 22:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ez44FBvUosqX for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 22:22:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0302180D4F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0302180D4F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0302180D4F
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 22:22:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3EC3847AF; Tue, 21 Jul 2026 00:22:08 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0069D8484A
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:22:03 +0200 (CEST)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6a377223171so5127837eaf.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784586122; x=1785190922;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xR+5Wek4cI/BS0jx0Qem2h+2mYTlfeq8RCZr4FhLcyw=;
 b=YdpvAury+QOW0PXaoyOdqOSgEvRLjvG3xQgCKE0iPZNsU8UnZ84rwG9REikwHJKoCF
 R5ofC0rfkM0CbpKQWXui/bwPPTTvmuPJWfcIsiaHYRAkFkML43+/xLAo564dkx3eFJJm
 79GkyQQHFTLgGgqNEa4ffFgRcYXfDoSexQmdCvJ3Boy+ZaevAHCeP6QHWlOd4h3G0ty3
 35hQo/+wy8ws4IUVvOLEzfV3cLyJimyUSw4WL6kDHBJfLmNFYs4ING77vvVcfrjP+8Rh
 9Jwo/vwpHYBAHHD/++0Wf4fY5vHc4azN2avFXUD1lm5ZxKssk87P7i6yZKfStIJYoKjG
 qyDw==
X-Gm-Message-State: AOJu0Ywb1t37oya50hY+NEPi7CuLBezxbgY8OcfQXoi0wPAhivGI0ZvW
 4bU/XWoP0cSECzR2V3DtO63jVPM6vSrCF3uqufuw4/WR6MCP73fiaW3w92nrKp0mojw=
X-Gm-Gg: AfdE7ck8wx49Sh13z8/12ayu98kVXXq9aAAF7tmLGzg4mrtxxsVq54yRL1iS/yRxJb5
 8+A7Ea/OkY7U/MOt1He0Wiidpy35GoocdMlExHzRSFlnsu44GQUVnxbfWE8OYGxTkV8rVHmoZvM
 oGo+tw3HlPl46OQV7ZfJhNS93xRfqw08FYOIKUIgKSKoBO97GErMqdzfNtP2y8FE6toNidikh0E
 EFiywoisHSdP6NhJ3oZcLwCWfEM1JhXOBnCY450mpQghVgls5QZjRBEJkeUGPlsox1qJzqDs3Q7
 flxctihdkmxbw9o57MUp51kly7sG/LmQRDB7dvdREsXM2PAhm88POBoRHVjrrB8xqbgsUl8Sndw
 TbOUYWC3fWLSB4+whL4+MhUKCeocTCfsSGCDc6/1TsLfElTlIkxoPXCSwjC1F/Kr4aGq3YeLd36
 nDa8Yk4EKWDIvR2Z/wzaUzGo/vE/Tz2x6LC6lwSz4WyD0RhrMtUfRx09cToZzYx4odg1GrR6iSl
 n7pbd1IEg7OlSnE0iQcHLPfVJj+pkq1qvT/VQ==
X-Received: by 2002:a05:6820:a508:10b0:6a5:fd5f:e0a6 with SMTP id
 006d021491bc7-6a5fd5fe73dmr3141085eaf.12.1784586121657; 
 Mon, 20 Jul 2026 15:22:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a516be4647sm9618205eaf.6.2026.07.20.15.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:22:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:21:58 -0600
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
Message-ID: <20260720222158.GL749385@bill-the-cat>
References: <20260715173119.GL749385@bill-the-cat>
 <87ldb5sen1.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U5zSbhrVqtDA/vdo"
Content-Disposition: inline
In-Reply-To: <87ldb5sen1.fsf@bloch.sibelius.xs4all.nl>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784586122; x=1785190922; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xR+5Wek4cI/BS0jx0Qem2h+2mYTlfeq8RCZr4FhLcyw=;
 b=Yv9M9LJ6g26NSC+eziSOHmbB64K3dAyEcDroyIUOBnnz2XdfiTIYS3/VAnySQRH9nR
 J6Oqs2kjCAAudhiWCIkYxBYV94sCCLIBKPJGNwBrkygiGv+L7+reuVVE45kY+ZasFHTF
 NAIl4QQqFA0CDfSaeByVFsmh0pVF86UcJJWAA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Yv9M9LJ6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yv9M9LJ6";
 dkim-atps=neutral
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


--U5zSbhrVqtDA/vdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 08:24:34PM +0200, Mark Kettenis wrote:
> > Date: Wed, 15 Jul 2026 11:31:19 -0600
> > From: Tom Rini <trini@konsulko.com>
>=20
> Hi Tom,
>=20
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
> > Based on feedback from the test migration, we believe we know what was
> > missing to ensure that the archive links are stable, and so that should
> > be the case when we go live again.
> >=20
> > I'll send out a reminder about this Sunday.
> >=20
> > Thanks all!
>=20
> Sadly it seems that the new list is (mis)configured to rewrite the
> From: header to something like:
>=20
>   "John Doe via U-Boot <u-boot@lists.u-boot-project.org>"
>=20
> Does it have to be that way?

So the answer is kinda. Whereas back on DENX we never "munged" emails
this is also why we likely often had big piles of unsubscribed due to
bounces (which was due to rejection from being incorrectly set as spam)
on the big providers. So now mailman is configured to munge the headers
*only* from senders which have a enforcing DMARC policy set, which
xs4all.nl has. And because we're on shared resources our lists not
following the DMARC rules would mess up all of the other lists.

--=20
Tom

--U5zSbhrVqtDA/vdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal6fhgAKCRAr4qD1Cr/k
CiB/AQDAezPw+6jqo+ohAl0q5QnQMYRmRaxopA6PnAWucS1X0AD/So5yAQXSAcOo
t2krMg1u9ZDYc36LpYEPE3/nnDrD8Q8=
=Yvb4
-----END PGP SIGNATURE-----

--U5zSbhrVqtDA/vdo--
