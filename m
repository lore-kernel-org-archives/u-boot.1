Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C285FC88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E921606EC;
	Mon, 14 Sep 2026 14:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGqsj-qUWM7i; Mon, 14 Sep 2026 14:45:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8CABC606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789397104;
	b=RjdeSZSeApzXI5onRs7Vu/wA0ejI7fBNOZK7NxLNDon0A6jGScvSoXBCbOhWHLsIvGoX
	 Q9VEAfkCQmvzNynFhpbvyIcGyJ1R5ukNWFu86NurTjWqhB0MiUF3uyfGTNXVetj6b7nWV
	 AGBJ47ke265VWy+29M3tTWpuYMuqLsBlz7TBGX2lBWc0vuIA21JeEYAv1EMyNuG/ZPkA8
	 Bb0ijo14O80zZ1tFtRflD+LcmvRTRwV90CyUOMYnzJqBt32KocMNbjI6TGopM3RooNYGe
	 fGJA17i2qT6+/ZAs6XUzmKFnCW5urKg/eGlQM4agQQVeycEMlDMbU8s+cFGogU2Z/CQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789397104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uqWYZz8I5hBShTiDcuCxaEeRdKDDcxIyXm3uaH2WCJc=;
	b=VFT+J6OBrESOmKrEQEL5K6bP+pYpcVmI0mzeHjAnZ2HCrQnQS+BhD8X589f6qAe1C6zH
	 YeBQifno3Gjybos6sLDyp6QKNtn+1QcXRsMGnON431ZEDxBfOYwlQVKnicRn3ig551N5a
	 HyUMEsKMJy6AiHkxqi8QOz82XCQWvm1Zhyo1jA8VIHdPJIl/kFKFdLM0iwQsx6MuR6/UX
	 0r1ZCy8h5r5iPkhT/fFAfTZ99B5D4nrevkAYEtU9YSdYl2UVlNtPRxeeXsk8A4QJKR5Xa
	 3G128aGz8Qmg/hw/3zAfmbg1iNYo02jnHgkQ4LhkmGyNwumCNCjWcwT046GE6qkVAog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789397104;
	bh=uqWYZz8I5hBShTiDcuCxaEeRdKDDcxIyXm3uaH2WCJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q7PLBnB3UQRetnf3U3bKxCj26jRjclE669HUD1QuMYVhnrkKhSC64c8OL4ciNDhzF
	 RcuqhWy+Ec5vg7HtcqJcwQOyNAOXbWacFgxrBB3bhLig8/FkzJ6oQb3Czs9arP05oC
	 WneibsTmUfreQtFUepaJZQkRRqt9qjmhOV2NneslYfMTisuCWv52R8Jo3Yo90+bGRu
	 oFvAhEPTvNUqE3AB4oejTEdPOjuyNKuXmv7AAzCTHxk3J2bC//+tq7SICJkFM6PK2+
	 EW7Tpg+hnVgHyLm8Kcci6qkSRPwaZuz8lx5FGztVffmJVxW9YtJ3UEK3v5kwJHzWyg
	 aU/oFVbF4rbjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CABC606CF;
	Mon, 14 Sep 2026 14:45:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 748F1259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 639EA40085
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E62BY01v5i9U for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 14:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4697840080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789397102;
 b=KM3PsY4zQ4+iXPsFoZkJmfZY1NHHIScRKNCfHaY8nBUDhcpsgpZt5yQ7TkKOBMaC7tSf
 MboudZSv1AgPUPUentHbq9afkIZrTD9MUJcfUi0Sb3kYbStTMHyjX6rPNrhm6ywse2FI2
 p+5bZ8aaxIVnUSf2w7vnkc8K3uIvC3wln5gqZoeqcHrvEX73GdZoLjVxkgNDzRH/8Bm37
 976O/y8P0HtociyZWo8Waa9uwuCmOM0yFvHjj77vUMWV8Fqshcx5d3no/QbnxgVOgnPee
 YoPxsI8qZzxkksZAnANvI40RtHHeSeV71FHR53Y/8gUusEMEytfiNsdTGFLfU/kGhLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789397102;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=uqWYZz8I5hBShTiDcuCxaEeRdKDDcxIyXm3uaH2WCJc=;
 b=ZBWJhr/b2Joe7IS1is+twwixp0ABL+Se9X8HIqD2KsndsCLeateAJwjat0W6oFtfH0Az
 UZnD6QW8OLFRxjsAHj6qJO1ithlbQ9q8/XC7XLvovPORzR3oT5hGAfS18jtSxbs+XgM7l
 KSnkv8QxY0dBFfkksUmD/+0osvKmWeX7KTro3K6Gf9Tu8T7uRIqxPycxOx1dSZwe7Ek5U
 Gauqr2cy8zJCyWM/+C7zZobf+JX1lsw+FRxRIN2YHVdadh8KUi66dL7XhkIGAC/kgkwLe
 zACo50Qnflm6DrC5He8DAjeexuazJ+zz/oBTqr0cTHXcGgwSz19uxiqIeJ5quEjUI6w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FUkLjpJG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::9;
 helo=mail-oa2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FUkLjpJG
Received: from mail-oa2-x09.google.com (mail-oa2-x09.google.com
 [IPv6:2607:f8b0:4864:30::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4697840080
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:45:01 +0000 (UTC)
Received: by mail-oa2-x09.google.com with SMTP id
 586e51a60fabf-47bd4bcc3e2so1270096fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789397100; x=1790001900;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uqWYZz8I5hBShTiDcuCxaEeRdKDDcxIyXm3uaH2WCJc=;
 b=FUkLjpJG6OAuUy4eFlAeb7zFBu5GYA0/2J63jZbshOfO1+DaNE41ClxCo0YJr14dYD
 WCgsuGMEVdNO9aEC40Jlr46r1+J2opRhJDcVsOelVuaE8bVSUFQJV6pY+ATiIZyPVdaj
 /5uH6o/Ew4iV9wTGr71B+euE+jCIcZ4+Vtmds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397100; x=1790001900;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uqWYZz8I5hBShTiDcuCxaEeRdKDDcxIyXm3uaH2WCJc=;
 b=JEYKmgpINmBHrJoMlOIqcBspRzjmjIvEw+2ulrheJ+6oA7omjzD11Y2nzooBUJqiqB
 wC1uJucPonqjElocp1z3ogdOruFGhNJrElmQEtDJc/LegXCgYpr5RkbgUe0x1Z7Y2ZOW
 wOe3mb5/wIuse7xwyfTNYJxiSx6HEwCCGGXqyw13wcwJJLJT3Y0sjbNM9mNSk8JcnXRs
 k5VANjOP7FkUpUCUuO1u1Dau9jd51sglL900MpuUKx60nl2aa/SbozM0aXcxUIsWcm+w
 1Ihbz+6grBzoP/M1OL+rNuEuX00zRpLUqduyp4CgULIfB4XfcZ3/mjN/i71yp6TAu7J1
 J12A==
X-Gm-Message-State: AFuF++mM+4pi6nOM0dXcXLJrs66Z7rtMR8ttvpICWkjR6EdinQEknSTe
 GeWCJaztoLzyZuA+ABVLmhYBXUH2Eaa5uKRFc/bvdvS3q+W0Brtog/GqpZQOvwyXHX1hlc1SmN7
 7R5S4mkX5RYj5oQY=
X-Gm-Gg: AYBFou2dvXu9E/guy/vqJvJnEy4g1DYj+MJ1cUnxqcxq+gcTBfDQfqwNEFOgGVPQOYn
 5/aZaKfThnOxmMWgXY36UCDPUfJDl/I88vu8LJyg30FtiDdoMouU5WVF11Y4zEbXvGKtNEQYcub
 MNG7o9/o9GOMmYzYkm5Hc2S5ubstO8TycBdY5kii9MFpuSA9pW8mSrWrq18FRA81/enkm3o9Mow
 GlC1rZqjqFzkRAlBfvbBxzr7kpEG3y6DUzeW6rk2Sw9OeES++B0fBgCfoQFr6E5ICxYGvHqPeHX
 lvr5Mv/Z9jCJYGxkJ5Uxf4NSxB1bocg7mYfYKXwF00nsEBhvgAcb95t7zk2gcGhtsUiM9uahGFw
 65QixnyRIJOjxOASo/CwzkeOyNmTZR6PcaUlnLUo46L2XewoxQJOn00LaR0mop9bu1CBbjXRaPP
 C0M8vWRMG42yEib/lyt6iQ2b05o7b1ZxVSTGkr/5uVjoRQ/GDO7q/UOssFnxG5LulRlW02c/4P9
 lhpdyQEvfXm/vzUTBShe4DvFqJ6G2S0hfADdqx8/Pf0CV0ZXUuGt6QTlZhigeUJuHkYjFAMr15O
 zOWSkVddUuSuOm0qLHU=
X-Received: by 2002:a05:6870:8913:b0:45e:23bb:7c32 with SMTP id
 586e51a60fabf-481f813f421mr1550752fac.16.1789397099938; 
 Mon, 14 Sep 2026 07:44:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df8699bc6sm10360408fac.3.2026.09.14.07.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:44:59 -0700 (PDT)
Date: Mon, 14 Sep 2026 08:44:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd <nd@arm.com>
Subject: Re: Please pull net-20260914
Message-ID: <20260914144457.GY1764417@bill-the-cat>
References: <c6dd1a5c-63c7-4e94-847e-0349b960f7dd@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5VFdHZjFXUqdEgxM"
Content-Disposition: inline
In-Reply-To: <c6dd1a5c-63c7-4e94-847e-0349b960f7dd@arm.com>
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


--5VFdHZjFXUqdEgxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:40:49AM +0200, Jerome Forissier wrote:
> Hi Tom,
>=20
> The following changes since commit a44f46af0aa17e48572e0d46c0d082886ee353=
c3:
>=20
>   MAINTAINERS: tee: update Jens Wiklander's email address (2026-09-11 10:=
22:58 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/n=
et-20260914
>=20
> for you to fetch changes up to b10cc2a58bd9a4ed174ab88bf39f64a62ecfef73:
>=20
>   test: dm: nfs: Add regression tests for the NFS reply-length checks (20=
26-09-14 09:10:43 +0200)
>=20
> There is a bit more than I would have liked for a pull request against
> the main branch at this stage in the release cycle. I mean, most commits
> are fixes, but a handful of them are new features. The reason is because
> I intended to send this PR much sooner, then got overwhelmed by other
> tasks followed by my main work machine being cut from the network for
> two weeks :-/
>=20
> I don't think there is a major risk of breakage but please let me know
> if you'd like me to postpone some changes to the next release.
>=20
> ----------------------------------------------------------------
> Pull request net-20260911.
>=20
> net
> - test: dm: nfs: Add regression tests for the NFS reply-length checks
> - net: nfs: Bound the length of an NFS readlink reply
> - net: nfs: Bound the length of an NFS read reply
> - fix error check in eth init
> - airoha: fix PCS calibration retry limit
> - netconsole: cache environment settings
> - netconsole: use unsigned port numbers
> - split netconsole transport from stdio frontend
>=20
> net-legacy
> - dhcpv6: support rapid commit dhcp6 option
> - net6: validate IPv6 payload and transport lengths on receive
> - test: dm: eth: add DHCPv6 oversized option regression tests
> - net: dhcp6: bound received DUID option lengths
>=20
> net-lwip
> - sandbox: support raw Ethernet with lwIP
> - pcap: support lwIP
> - cmd: ethsw: support lwIP
> - lwip: support syslog
> - netconsole: add an lwIP transport
> - test: dm: cover the shared lwIP runtime
> - lwip: share one network runtime between clients
> - lwip: allow DHCP to stop without releasing its lease
> - lwip: add an HTTP client abort operation
> - lwip: allow DNS callbacks to be canceled
> - lwip: return ERR_ABRT after aborting wget receive

Yes, please, split this in to just bug fixes for -main and new features,
etc, for -next. And make sure to update your email alias for the list to
the new address :)

--=20
Tom

--5VFdHZjFXUqdEgxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqgIZQAKCRAr4qD1Cr/k
CkpHAQD8l/RXsHX2aMt/bw9pyXid6Ia24M3ztNIkAAoTnhh6dAEAxqBwmlU597Wk
PJZBBZPolgk1LBTbA07p8Yzd3BukOgw=
=/O21
-----END PGP SIGNATURE-----

--5VFdHZjFXUqdEgxM--
