Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EEAC624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 14:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D0CD605FF;
	Sat,  5 Sep 2026 14:28:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dh6L-YWIpmxy; Sat,  5 Sep 2026 14:28:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 801496060B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788618507;
	b=OpI+O9DS3nZK2mwThXkx4wnbYjI16qG/D3pFQqdtFSDekD3kfnwc/WUV/+nSOQp21Ymx
	 Ew8vslYSDMF8Jnf+FV8kBTsd4F39cbmXaCsj/GM2DoJ7P3gDUPFcvmY3aq4S27RFoZuBV
	 phUezS+99a27sQHwPaTNiSnt56+yF0hx7D2HSG1WyGFW4r95yXV0jXvlUDy9Ow/428xtr
	 cfurfH/Oap3yrdr53DXcAvlY0fuzU6TXhaBt4G8AJSBellhqT+obkscHuupa6PRkhsVdv
	 Q5W+3H+18QX0Zb/iLUry8R5TKVrLOhaQNqpAFaVeUWYWf6UxRaDMvBtjOE07U4h91mA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788618507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NbxxKvDK1rMbwS5RoY7G1L6yr3iQjEkYOiOHeOx6zNU=;
	b=DiuogT+AQ6tYCyyhzA50KlssB8I4CAsuCnbVwljyQOVdPiJhKfvBy2HkPfpZKV/38TEy
	 lNr/nQTo7FNWtND4P7LA7hOvahx0HkURdTIUntL1j/UFGAYvkYS0D/Dg9SCC9KCDHelxK
	 SZryh1RfYh643qyr1nuXeUxW5oq57RBKNE8YZlvx5vGCRn7Y9agBmOX2CCheqdkKOmltY
	 5CrlGIPyLu/UXPghImAVl0P17WwA+y0dhklOBOB87VXR0Tl5Fwizn3hQ4BohxBk4CDTOM
	 6MOCKHu3jkSDAf3rUuUqKiFUeHzK3XQFaipmlcpTGAGOhUeHuAtVztWR5t2u2LPFUlg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788618507;
	bh=NbxxKvDK1rMbwS5RoY7G1L6yr3iQjEkYOiOHeOx6zNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jY1J5eI1IJCZkBOO4xyoy7nN7xjEfNjbvI4rXujZmKhRvAT+0si0xp7/LHRrERP2y
	 Fl8BRIC0Io3BaT6HJz1aaNpPepAanMu3ZbfOfbf1uXN8cStJJ3mwqi4uXwoUA6dn1O
	 7UMG/sX6iYcsPuv2nJzp/7HpK3bG1XsU1L1ukBrxuIaPNd+rQiZaeyNFqnnJhc6Ybv
	 vBjZ8B208xU5StMuRFUiWQ90rVVca6sCFS5DvEw5YQfp7fgweAS6tUH5qHl1nktDfe
	 mAmqPtePv0/XT1CF4NCE76N1oNMPCAm9opksi+sf9Ez7z4RUycluarIwRfTyOu7vE8
	 5Y3vqTa5PWBZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 801496060B;
	Sat,  5 Sep 2026 14:28:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A1F8970
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 14:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BDD040B27
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 14:28:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SrZpkrkShW-N for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 14:28:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A5E7440B20
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788618505;
 b=Z5mx6XZ/h/dS2Benu+HlYHeF9k2FyuH2hgIxPsMHxbuaB27I04vRlOJrgYaOmCJ0TJHZ
 dL5CfoFchw27h8Q4pMw/5Jhmv+qJb+ZWL7hh2dwKfFq7iQbk8+P1THU5Y3AdlQBYcn8jU
 zbHC9NclBcZo2WQK+s7xngkhplW+T1AMqaOk/QDVDv0Sqw3uK/reU/C/OOvSN9YfABH2G
 gvYWNxet4j3PvvvoY6j2tW069oBGipXtfIuEb1T+EodfYs6ZTOVh6M/5DaLDufHRKkB/F
 S34RckSXan489JG/OQN/ZPmYj0n2np0XNg7gw6IB7QHmYEAZOJi+rO3Dg8qvQ8UfxXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788618505;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=NbxxKvDK1rMbwS5RoY7G1L6yr3iQjEkYOiOHeOx6zNU=;
 b=fVXhnhVVnmlolQkg8VkrEnQrkCtSqq/8CGHu1i7mEN7PT4oPR9BtNgwz63D+3G4vt7PE
 DqRNWzLZEBPaxX7zgp/jXmx/QEEpv3zCYD9VFYcIt+0RXdMaUp9eCSG+8BHdzMo+HFLVI
 6zOWlS7gYJxmDkZ/tSWg2fLCVIEeSjYW6TcL5Q+Z8x3paF1L0qv7UM+HBjAr9HTuLR51c
 2JORuLRt1CSCtipL3PrQ6VInXK0LT2FEuau82bfXYPoGEI+N4c69h2pPghXy9eKtxm2qM
 IRiY464J8RavCyMSg0gyHIrpnIc3jxeW+NQ/O6XYRxgktTuCqxg3UcFofBCP9lj5JtA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="A5r/cifL"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=A5r/cifL
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5E7440B20
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 14:28:25 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4b333de9451so2234562b6e.3
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788618504; x=1789223304;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NbxxKvDK1rMbwS5RoY7G1L6yr3iQjEkYOiOHeOx6zNU=;
 b=A5r/cifLzAEAw/GFK0wm6AOjtAepDafdUWlzEWFGPdAsWdiu9fn+jtA4ifOZFkIX4/
 p2lFVZKJCuB5NDOgpklMFl4j3hy2O10G1lUPTkNO8ihjYZiligLfetjBVMMhk3EmmqnY
 iSbnVBA1RKZIf9p47UO3ox8dp+MbIx5lnCYX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788618504; x=1789223304;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NbxxKvDK1rMbwS5RoY7G1L6yr3iQjEkYOiOHeOx6zNU=;
 b=ZoBO5BOq2R/Rxh2jhU8Lu81fHAnDTFOjZNuQDmNaplueI5rUz5qLJtNi6gl35nJcut
 Wv2otJYV3FiX+qMERGJlU648ACxtxEJe8sStAf9EZ6A/2+2nZuEGYXUqPiETcogT/MMd
 u1gu5XjtTI31dsPgtTfrWTvjSoAoy6rtRJB27uS3wd+yTWmEQrNX4fb6UvYyClWl7MGq
 HNM2QWhlpzeXXN7my9Gl/p9Dc0HNJHLM75il2jPzHsK3Yrsj0NxUdIqN1tGZniarZ/CO
 QWVwTCjrenXYvb7KNR3DRgDXUYgO4A1pgrxpjkeMFkXkHZtelESkDOT83IqLBYHVe9Lw
 VlfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8t1ndjpm3FqClpt0Yokj3shKwqTt6wIEnhxWhZQFYywaZltkbeWckT/UVUOhe7KupXnMZXGc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lkrvR0RPUV8aferSj8lf4iC24arvfAOgyxJt32Mk2s/1Zh4ofq
 Gn9BU73P+++Iy3rNkJfiQ+/9rBp3DJEHoaCNr2Y8JaVY0w8fkf7I5WwlgeDOVTpep1c=
X-Gm-Gg: AYBFou3suGobB7loaudzLsF3rMvlLpE3ifokn10zTiehRpEcgk9z+tkmXKMSI7kWd4a
 wJ9oPVv0coMxhNK1DJcV0L7JLNt8CB1Ag1foVeu1rtaKZUM/wF8EH8FQsUGZvQtCOn3W+gRe8C8
 MTmUsS6UZoyvXDK+GtBDcPJx4iSNpyOiCh2E8l6Evo0qqLDRW5wrfDdeI6UYcFkVcnEBdNurNV+
 smH7VagulrMlLSlE6lfMjKX6+iFakGUBEHpteCfKbLlRYCUGJebrQ73HeDiM93T9PWTSpspu1KP
 LSDQTR+pD2T7WmzAyP753swXnCXt6uoZ5vua5us1qfGNoTC1aBnDTtCxG/AOJlhnS0Q+QtxObM1
 vJKB7YG7kfmiF81yXZXVhddz7O9cdQ/3O8wDKGH/c3Gs8KwoO1wEUEIn4RroxfrJdsYnmCWra17
 HzkdQQZ/Mud9vJa9O61M9u/JBVM8cP8urvCN0jyi18Dv023yRYoY7jcsZPfZu6822UXuOp4hpQz
 308R0n7HI1ItvwEzRtVA1xBJlK/tB9Ku8JH+QVfu95Ig4PDEFk0sMbW1EEYdEGw22+ZoFQYbsdq
 UVawZAQFVA==
X-Received: by 2002:a05:6808:3510:b0:497:8ca:a8fc with SMTP id
 5614622812f47-4b962858698mr7564599b6e.19.1788618504263; 
 Sat, 05 Sep 2026 07:28:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b96babc2c3sm5990311b6e.0.2026.09.05.07.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 07:28:23 -0700 (PDT)
Date: Sat, 5 Sep 2026 08:28:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuxiao Zhang <yuxiaozhang@google.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] u-boot: fix error check in eth init
Message-ID: <20260905142821.GU1764417@bill-the-cat>
References: <CAOOoKeR5oAcouuG1EO2fQNubKsfVB=O5qf0aj-FhSSGJeOH-LQ@mail.gmail.com>
 <20260901175210.482943-1-yuxiaozhang@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xd+KXnvfbaG0lPqE"
Content-Disposition: inline
In-Reply-To: <20260901175210.482943-1-yuxiaozhang@google.com>
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


--xd+KXnvfbaG0lPqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 10:51:42AM -0700, Yuxiao Zhang wrote:

> eth_start_udev can fail but errno could still be zero which causes the
> function ignores the error silently. This fix catches the error
> properly.
>=20
> Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>

Thanks.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--xd+KXnvfbaG0lPqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapwnAgAKCRAr4qD1Cr/k
Ci8FAP9ZTdRQgQ84lUp95cNFJgjJ4pSnqtMQLtjU8bgt9Bnw6QD/Y7AV4u9X4l2V
JAaJDIinHgMwEu70kg1+dAnY44nZjwI=
=oZrJ
-----END PGP SIGNATURE-----

--xd+KXnvfbaG0lPqE--
