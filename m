Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B32CC6B1D
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 17:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F25C9405A3;
	Tue, 13 Oct 2026 17:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UrMqNEy0JFgL; Tue, 13 Oct 2026 17:51:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F91540656
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791913913;
	b=b+uyrQIlGw8wnaumhdmNbBjdqv7qAmOpZR9s/TkzO54J7f+99Z/uCRDUHrEVRBWS96OP
	 +N79E74/w/3OVBA/bIKrNp7IDYKV1ZBzCFxsSkAFR0fTbsjFcVGzskYDU9eNNpr0QtR+E
	 2QeM+mJH8Csa70N6zltngrMzbugRtkneZselV4mU0g2RZUNZpsjNicxi7IwonBPhlVFrS
	 t1tnC4zq72INDquoZFFuWm5JZGWBB53HmYRoigg9Gqg+AjzXqznI/NjfCrcXbc/tdrRuS
	 gzKu+SuTmTIVCc/Lv9ht4FFsL8b2dcrBkWfBrrpaRiyOEBHs1xuhysU2bv5UDrtWdCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791913913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sj1UUkj1/kwKquNaf+dGNbHPPImZ4gk4bQJSnKWC2YI=;
	b=s8Pen9/I4f4vsCo1sUz3uay6e3avbtMHr7p9IF0bW26DhSEewWdpNrsmOyGJ87Th5bcu
	 QyKrjnpPxoAhmUvXi3Jsv6VErPv9El97mnn6Q48h2wGKyDuRviTMJMwyE8Zjx0AtM2p0s
	 XpJsBd1habrzM0WoZvqKHZJaqr1C68P+FHPym8E2bKEDjIPBsTme7Lt2Etxm0LN8a7rYa
	 hLtQWUoMM1Zjgc0uSGNufGDb7AhWwNSh4sX2e04RCIUgeWdgyyQfz/4QQTEYLVWbmsiau
	 wQNS7VOcwOVojDhI9aA93/GSZ7pjrICrN1RVV57iEhmt5/2YaL4m4n+QeQlzpQLhxsw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=dUpqziIM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791913913;
	bh=Sj1UUkj1/kwKquNaf+dGNbHPPImZ4gk4bQJSnKWC2YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NI+XzU7kMj+SgZAFAzx4J4Fk8KSg+Xi1A0Jt6G2rCLzqWT5S3r55MmiNnP9CPWbNQ
	 56zLg0C6JeaihIUUh3WvQ/x1odcSczdLEx6ivcjEyN6qoEOZRUrB+vfaqgRVONiz92
	 qoPLGGku6VWAAQz8CIrE8inBCxYb11ArFt/ji2umoqzbhK9lxsh12ioLXTMVNDJsCf
	 o2dcU2jED8g9wUuDScnpSkAGX/1aG1kXsKLOcWPHXqR7OMwNDVd44SPDnZZLydFjIp
	 3TWp60nQKtGizQ+OhACUxAXGIVNVeEt79aZsSXwSRfZ/LPWsdSl+50AuHY7gsaV//Y
	 Mh9ivHW1Mgh0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F91540656;
	Tue, 13 Oct 2026 17:51:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F3ACD788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5149A40640
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I4BTxD_W9A_B for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 17:51:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51AE24062C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791913908;
 b=q3JIF2TGGaJn0ZJO8Swaf0GEHhCD9gd9oCQRfD6BucSuKFZp03/uRcSEOEIgjB9FSomC
 6c8qjhDJx8yHtJqRiq1KEi3n8GIOzkOM5pBcXfX6NeM8pZdOUhPWsdcD/iPDESLa6susK
 YrWe+5iEL1eor9uWWx1vSb2wUcoE/gcTj6tBN2/i0mxpPiHlHuUM5Abvl+GIUCNM988jB
 KgIhcIwT++lggd0lmblZwrHkq4BVU8/hlfE7iOZmTTkNbYiHsQNNulUzC7LZbkU9cH+kF
 7CGAVq3lV37eHjkhQtZYdJJbtIpnPlE4Gfflr5TREwz48KSb1k3aWUELXMBGnNGG3sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791913908;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Sj1UUkj1/kwKquNaf+dGNbHPPImZ4gk4bQJSnKWC2YI=;
 b=MjK2To5pZi+oApkc5h1tG8Y2lpc+M/r4BtuGS96QI4ZEEcFVNM4Z0jj82Er+q2JhCuCj
 ErwDsn1XpDrf1YvVfdfhlchxD2ZT2f3ys+eJc8JFYVMGGCeSQiLMiHwF06Ka+UzwEF3Zc
 +DdnMBsJhAlzyNctgUMNBthdcYRKgUGaGymAYIHD3W726iWKrZQ9/x4KP8zbPzTu8chIZ
 uHLC5U++VJSQ0kVzErsN74ZozzIfTiu/+XyhZkt7Dt/Y8QWybyi4Lbe9A24/FLpMZUYAi
 UTT+HWGuVWx9zppxkMOj6UXY0rl8OCi1/2pHHsPwBinMfAhCYy6IRK4TBsp9L47pFNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dUpqziIM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dUpqziIM
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51AE24062C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:51:47 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-8241a56cd70so2124028a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791913907; x=1792518707;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sj1UUkj1/kwKquNaf+dGNbHPPImZ4gk4bQJSnKWC2YI=;
 b=dUpqziIMriU810GZBnoPpk8yU2vBk0K9ynqh0HR8IHLCxLWkYW2rtsVACZXMU0CihU
 q0TuLAscKxbC3VswF3BOdY+qCSWY7SN/kPNTnVBs8rGuhqYgNW/bEImZ6jWl9OJDVacN
 ncfyq80Nv/TgXZ6vpDHCmx2HssukGhMTpFil8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791913907; x=1792518707;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sj1UUkj1/kwKquNaf+dGNbHPPImZ4gk4bQJSnKWC2YI=;
 b=VAPW2wk4wqhjZcU3j7mtgkgsDoeIHsls6fBv5mbz2gRoXAeZi/Ugraghg90/L0UWxt
 pJ+p4lMare+sL0FBvVvOOQ+mmoU9cTmljh0M8ASQeolbGNiT4ui7xeeDpVoIxHFstQUl
 E0VhfrRo8Utm7sA3MeajGLI6R1O9hkIZCkc0qmlsMDUfshli9hw552vqtqCOmrrJKh7x
 ss9vg5fi/2exicsG23t8vH4TXCOnAHJam/9zgPSzQOOheWVK26JRu41rcMIW1bdWx0z6
 9oEi5vJMg0ehu0F64tnScF55d9aQ8XzSsqCGrhiFF2acMivzdlZMQIj0rhNjJxPFib/8
 tpCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu4bJK7VEMHb9/Uto5XEmo1xeP7iJRpcwLdn+nImnErlfSr9Rr1EmEwxTQCaUd2rlOvyIExmM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI+QPo/zJo3xEflwEuWAlugXFljZ6L92bDP+ajRnVwmu5sqaJm4
 0jqsqpH7VOFoGOtaB9MhuBte9mvCP1kVcK2Hcg0xU4iij6Yo41y+U3r719UtFVjMCFg=
X-Gm-Gg: AYBFou0lcJv4L/ZbwJW9Ft3dKtwYd38tJSkbnjbswtEW3jE5GRWcHjjlzH8xQPOoqL3
 m/ZnV2kCA8y/1LdwAavr6Kt5BtKb5hQPy8DMRC2vUDW1y+4XOeJ/vm1nIjWQIOyhqSuQEYGvw3N
 FI60Yu39ck7QTdADcWXjDUmX0SiIhMMO8akWNaERb5hJi28U8fcHuNsnuaZAgo7y1e3dyU+3YpZ
 d945Uai/MH2qWL54xI16HKhnz8CH8gEKiOQw9H69lTouC4iiXBiXvxrDikXD4AnqDS1tHvNALhr
 pGHQqKY2zB62UF/44YsaBJw1bBqv4ILfkIBMQhoZ7+1Jq6zvLV6DcHxNaGIRAibyl1mCviziabM
 VwaqAp3Fjvbtdc5JTKPB+gALMDwFTohXO1VCZJgF7rlpFNgMYcOFQ8pDEmKpYoJpJ9tzU0ZrBAI
 ulMzCv64DEdwlTwzHsl4hUkJ8SrzLy2CI6+LD3pyo98tL+18yvvSzCjTAXFIj8KjIblkC//2wBP
 E4T71cLD7atxmJBpn3xn7+xKDjFJSrMUamV4UpswIhmg3Go4ouzsVIpTy2fZf9+Qxj7vFyHNq9B
 p5SbXrf6A0szlpFTOCw=
X-Received: by 2002:a05:6830:6d11:b0:81d:54f9:d6a3 with SMTP id
 46e09a7af769-83090c28e88mr12191199a34.4.1791913906925; 
 Tue, 13 Oct 2026 10:51:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83038f82468sm13302177a34.11.2026.10.13.10.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:51:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:51:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, dlechner@baylibre.com,
 jens.wiklander@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, neil.armstrong@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, xypron.glpk@gmx.de,
 s-vadapalli@ti.com, michal.simek@amd.com, jbx6244@gmail.com,
 marek.vasut+renesas@mailbox.org, sumit.garg@oss.qualcomm.com,
 jens.wiklander@oss.qualcomm.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v5 2/6] ufs: surface sense data from ufs_scsi_exec()
Message-ID: <20261013175143.GD4042005@bill-the-cat>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-3-jorge.ramirez@oss.qualcomm.com>
 <CAC_iWj+MuqZ1LnPCD0SmK5ATgegWZVix3Uj99NwcqkRsWSVoDg@mail.gmail.com>
 <as5u0mYRzhi63SoR@trux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MJuaH2/PTCILiTpz"
Content-Disposition: inline
In-Reply-To: <as5u0mYRzhi63SoR@trux>
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


--MJuaH2/PTCILiTpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 07:48:02PM +0200, Jorge Ramirez wrote:
> On 02/10/26 14:16:54, Ilias Apalodimas wrote:
> > Any chance we can get an ACK from UFS maintainers?
> >
> > Thanks
> > /Ilias
>=20
>=20
> Ilias is it possible that the maintainers have silently quit?

Neil was at all the conferences last week, and I think another
conference the week before.

--=20
Tom

--MJuaH2/PTCILiTpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas5vqwAKCRAr4qD1Cr/k
CiVXAQCEVb3iJIcvcvhmLHadT74/BxV0ESUZdXItZWhzCjEGBAD+Jw9e3M/g7Cjc
PL5tmVlgeiSIWf9i48AVvpKHhkDAhQA=
=Fer7
-----END PGP SIGNATURE-----

--MJuaH2/PTCILiTpz--
