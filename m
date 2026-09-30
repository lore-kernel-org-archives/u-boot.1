Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC1FCA5FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 16:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B23E40A72;
	Wed, 30 Sep 2026 16:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o3rd7QGyV0b5; Wed, 30 Sep 2026 16:12:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 527BE40A7E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790784724;
	b=J2B0A0bn36rDdkmdL8IsYWwSnBhQ5kpXDGYYHkId5FkTaKboZxPU6IzJ5ZXAcspxxNFd
	 jQfslICTno+Luwx+iFtUrmQw+DAiWX+D2VLkdzaQ68zce0bt71xutIawDfVJ0ZijaGTui
	 GHTTYLMour1fjmsBHyKHbsNBO3cYeKfNrkTRJGXxMW8Hlfzcm82WxeqPgCd+KEzcU0RKt
	 gqHNFAv5vfP+wJdhiqK1ihaUwHFi/d5z+u6GnZHHDxyiLEDsx0QwHYuD+9OR5bfO9I3JJ
	 W7laFOd8oKCpgPIfgXJ88RWwnqPoBYXmM+j78mZ2mGzryV2+1+vRexXgiY20G4ZxDnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790784724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Qg9Ysn9iEKNJjnqRs3+EzL8+250w4Zz72upplssIOMU=;
	b=RAW7rMAj4i3HQ6xgBFwbbr449f6AmpQS8s78HjjXipY0kxcJRqyKSlaMckZKaao7lVNH
	 CrXyYNasXAuweEyS7irVZvytbG1/66ynr+K4xpGQe1wDFSnfx/ye+zAg5oRT4Rrc5gynC
	 SiHngQ1L8IvV9h2BMlnKTdwACQkDrSFuCTpV5CiiRiclGQFIBzUk7st78P9V5lj4JnY6q
	 DAlzxvDxyGCYDPjXI2HWJrCGrXF2b8Bdn5PaI8nyHNNsoXvpW80oFX57UcHr5yF5p54zg
	 gD/yftGXVJi28fmwTMuk1reIq7yet1mG/6QzQOaGd3kRuYNbBCviuPmC5dk76wUM0iQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790784724;
	bh=Qg9Ysn9iEKNJjnqRs3+EzL8+250w4Zz72upplssIOMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=igqi/gKreWNlHZ2fLQCC/uXEuhgfZ2j9Fc9zpJs5cGjpyrIuxt7XWwc77oZQGp3/A
	 b7CdUzUKdutaoHTZ+THxU3R3kfuoYJjDW78mH0mRGD3trZPeAy7xMUY1P/G2JQy4TZ
	 Z4s9h19VAWzFQobMSWctVf32LZrhDCCr2dKMb1G83J4XnoB6miH+SeRyx99lTe77GO
	 tplxN08mQ+N/nvJNWfODrDZTVOPImz776S2Mh3rTOMdv8pvxh31h1RuKfeeVDv/oUS
	 b3bmaJnQ/ZbIuc/0O9hN03mQqlzj14uiG6KsbSYRNh6huulo1U2yN1qG4D5MZ0hTVS
	 AZ81Mk+54LBzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 527BE40A7E;
	Wed, 30 Sep 2026 16:12:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B58834E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 16:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D0C94024D
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 16:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xs896B6BOKYe for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 16:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B4CD440042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790784722;
 b=eLaScUoR4HWU3AQOUHviTxAdRUL0f4clbqMTDSkme21qKlPP8yZqtr/l17YxsSPSuVwr
 01cnVgH4kEkSnOx3jgE5Tk8b9RAvu7WG6VS4Yp2NqHKQmf3RHinmpOeWfbV9hhm0QbvGh
 ZM+5Ieqez6nqNV9c+Cshql5xn3paFTJycrB6DWCGe7JsP4slgTco6NVOjpa458mq0dSjR
 jT/4uDtaHVuJEKoCc/FbRBymu94ppmJgElmHeB7JM2kL8TPgP4xp7Dscefc/yWkHytFNw
 Fudf5ZcTC1miIsug2xPRPkPTqhMnXKzYY/NYx2K8e1VJnhlEJWd4GQ/iftG1eaHbfgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790784722;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Qg9Ysn9iEKNJjnqRs3+EzL8+250w4Zz72upplssIOMU=;
 b=mcsbI35TnY7J3qwMp25qvatlnuDwIBI7H2utjlKAccGenzEtc3epnA9BJJDS5lPayuAE
 USeoZAwM+XmXLKs2814tWJv/yffBLq8H2l6MaNHdEpYV/lve9dNrAj9tZj4/yZbbHYRo8
 f+tBrSXFnoIyHs3lE+6nHKMEdwgS5n4m8Kk5nZ56E+F7hdW1dIPRjyyo1rM8sqS7Wub1T
 TUzvk3iHsyQTYp96wYLhLvg9pKxdKLqTElqSzWUuA6kwk+13bc+0AhwoAMj1ClY9O4wLi
 ZecM9SFPlBalQLvI2klzjiUZZRn7Ip1NO9AxMYiuf4XguO/qw+5shxHt0yRhqnZEFSg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=i1VQRuqm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=i1VQRuqm
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4CD440042
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 16:12:01 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-491c13d63d9so3983966fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790784720; x=1791389520;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qg9Ysn9iEKNJjnqRs3+EzL8+250w4Zz72upplssIOMU=;
 b=i1VQRuqmuqo2gAcM7Q3LXEeiGf8ZWNncJw5anXf9ZDrCKWcgoqQb6K3ZdWM9BzNeC8
 RsafNWOCkA+/7mqPEeBtp0gUlnTyIDMlvD7IE7zE/ozMStOMIVJ8DDuXHZwmfHy+gWJJ
 ToyBZZKam7hBmb7KRVZF4tYzD2TgD21gPIrzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784720; x=1791389520;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qg9Ysn9iEKNJjnqRs3+EzL8+250w4Zz72upplssIOMU=;
 b=ZcRw633K1j6uPHd9rjPlG25I4kyhdHquD71ChnH6CsFqPTmI762l0Mj3zU5jCvgA81
 Cz71uyHdJW5OjPlfb7Qt/Mco/P+FPpCp95+GrQuJc7zRVVNU3tEIh70+VQNx3CBZG7cA
 HmbXxAJerDqGeybE+tQXdsDfxNypNEi37dG/cXh1u0pgotfBY5H8WH0D3bDJUKzUVb4d
 2LIKkwELneEEZ3UKbx9SG2oIZRk4HdeH4/D3wulVfST07AAtgaFEJXJkOurfm+2cRsVI
 TJzhPnSwkrpRoU0IfOWFi6XuC65OFtdQ7Q/tOEPq+zABPpmDD2YQ4iyNWHr2HjAheAT1
 Hn1g==
X-Gm-Message-State: AFuF++nbUNlDfYT+dfIv+3aM567zHRT5R3zK1pRodPJK3SfELq+H/sRh
 0gXllpkUhfekZEObkEDmpjKs9TjbZXQEPjYhp5ix1k6HdFZj3W0ay2t8RmI4S/GgwcFQeVcJKdi
 ECO/3XKQiD9J2
X-Gm-Gg: AYBFou06m9rj5ixIjsz00szGS3tGIjRa2hRP5jrQ0IrJnpFdsC72NOBTn0V3/4YtA9s
 QSMZ1054ZZdlcX7gcoTkF0Gy8GWzRdDx2xe+1aI8jEB2lTyUZqXz29WN5aWhe/wlJRlHglCmQ0k
 XzQPnP965nxrUIg4rfElHO8Rzt3OPbBCV75yHx/DMKThf0HAkD+yd1/TYdLDWvlCr8SxXr8hm8P
 C7cP4+qYmdX0bkQZw7aiivLnr4SQ8M46/eJGsAGOVIedF6uEh1ndfmNZ0Rb1ZvN4HOTPspJxJlG
 aUedJOVe6Nj8uvbOYfDO4HkpYjNIgautZquX/bF1AFaRIHHmJI24N6leKp2qd01RdVrOTHcc+Oz
 hg4flS47YVej3gjah2yQVh6sECE3MqbIb09AaRYIlDTN/cutyXLzRZLG/kKQDeDT9c8jTL9ax1L
 v38neSRZEnHhzFsUEvvWZyr16wR8gq+Ws17zb4RJszDqt9wxGnuO4pqO9gI3cSDn153qkXXxNt6
 vaO/YuNaMqCcGrOMLaRzDFoX7tMZEPCRqlov+nXrmOnlZY2RBUOjt9hXlyNLoVr7OqRcthqbDhs
 2Usbxc0axOdjJ7ZTBFIO
X-Received: by 2002:a05:6808:14c7:b0:4d5:295c:a82c with SMTP id
 5614622812f47-4f1ba7e802amr1844228b6e.57.1790784720235; 
 Wed, 30 Sep 2026 09:12:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f1b5808faesm1180473b6e.13.2026.09.30.09.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:11:59 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:11:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] cmd: config: Add additional embedded text option
Message-ID: <20260930161157.GH858934@bill-the-cat>
References: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
 <20260929225108.GD858934@bill-the-cat>
 <71a56a26-67a6-43eb-a90c-71231ec2cc0a@mailbox.org>
 <20260930001840.GE858934@bill-the-cat>
 <26150591-3420-475b-9cbc-fcd2729495c9@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lNO5kIue9Khnv/RP"
Content-Disposition: inline
In-Reply-To: <26150591-3420-475b-9cbc-fcd2729495c9@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
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
Errors-To: u-boot-bounces@lists.u-boot-project.org


--lNO5kIue9Khnv/RP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 02:59:58AM +0200, Marek Vasut wrote:
> On 9/30/26 2:18 AM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > > > Please note that this does increase the U-Boot binary size, and
> > > > > therefore use with caution.
>=20
> [...]
>=20
> > > > > +config CMD_CONFIG_EXTRA_TEXT
> > > > > +	string "Additional text embedded in .config variable"
> > > > > +	depends on CMD_CONFIG
> > > > > +	default ""
> > > > > +	help
> > > > > +	  This option can include additional text embedded in U-Boot .c=
onfig,
> > > > > +	  which is printed as part of the .config by the "config" comma=
nd.
> > > > > +	  This is useful for example for embedding build information in=
to
> > > > > +	  the U-Boot binary, e.g. content of OE /etc/buildinfo, but ple=
ase
> > > > > +	  do keep in mind that this does also increase the U-Boot binar=
y size.
> > > > > +
> > > > >    config CMD_CONSOLE
> > > > >    	bool "coninfo"
> > > > >    	default y
> > > >=20
> > > > Is this just intended as a do-not-apply?
> > >=20
> > > No, but if there is a better way to bake /etc/buildinfo into U-Boot b=
inary
> > > and then print it, I am open to suggestions. I am looking for some wa=
y to
> > > finally replace .scmversion with something more flexible.
> > >=20
> > > > Otherwise, it needs a gating
> > > > option as well.
> > > What kind of gating option ? This is gated by CMD_CONFIG already.
> >=20
> > Yes, and there's platforms enabling it today. So yes I'd prefer an
> > option asking if you want to add this string which depends on CMD_CONFIG
> > and then this option depends on that new one.
>=20
> That kind of option would actually make this patch worse, see the quoted
> part of commit message above.
>=20
> If we add a gating option, we would end up with this in .config (which is
> included in the U-Boot binary and increases its size) for enabled:
> CONFIG_CMD_CONFIG=3Dy
> CONFIG_CMD_CONFIG_EXTRA=3Dy
> CONFIG_CMD_CONFIG_EXTRA_TEXT=3D"blah"
> or disabled:
> CONFIG_CMD_CONFIG=3Dy
> # CONFIG_CMD_CONFIG_EXTRA is not set
>=20
> Without gating option, we end up with enabled and used case:
> CONFIG_CMD_CONFIG=3Dy
> CONFIG_CMD_CONFIG_EXTRA_TEXT=3D"blah"
> or disabled case:
> CONFIG_CMD_CONFIG=3Dy
> CONFIG_CMD_CONFIG_EXTRA_TEXT=3D""
>=20
> Notice, that in the disabled case, '# CONFIG_CMD_CONFIG_EXTRA is not set'=
 is
> actually longer than 'CONFIG_CMD_CONFIG_EXTRA_TEXT=3D""' and grows the U-=
Boot
> binary more, hence, worse.
>=20
> (In case of the enabled case, it is obviously worse with gating option)
>=20
> But in either case, this will grow the size of the embedded .config, and =
the
> only alternative I can come up with is to turn CONFIG_CMD_CONFIG into str=
ing
> itself, but that is awful.

Oh you're right of course.

Reviewed-by; Tom Rini <trini@konsulko.com>

--=20
Tom

--lNO5kIue9Khnv/RP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar00yQAKCRAr4qD1Cr/k
Cp/xAP9ZCyxUzx8s9DNbb9NeasJuKbAb8h5DUT28paYVcxcJ+gEAxg5QPxSSqlvR
eQ7EoasqVWBXoQWz5g5zTi/8zloDVwE=
=M8yB
-----END PGP SIGNATURE-----

--lNO5kIue9Khnv/RP--
