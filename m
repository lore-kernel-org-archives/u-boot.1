Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03609606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HR3hRgOX;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PZDzu0Z/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1FAE608B4;
	Wed, 21 Oct 2026 17:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a0ZDJuzOyXak; Wed, 21 Oct 2026 17:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1644E608C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792604892;
	b=WrFLRnkJx4T1R8SrfPFBccFvlZOKu3skWUjhLIMgbJYtzvyoRGb2gf1EA7p3wN4+dTkv
	 Rwyt+wQX0JGdtF5x2MGo60F3ypcS2rfTvrhHRPqBjV/QaPygGGAufZvVQC8Sj8LSdYx/W
	 P7SvMhrxjkiTcSBeuoOR/HfMFzR2x87XxjVu704qeYjCQRLrhVDNvzfNJ3dQqzJaco3iC
	 J4L2udweX5on/G/HMfknqKLr8b7stG5gWLVXil75R0FzD79yvRg5mcw6fSrynOh6ZrK8t
	 BAisy6qELixuUJede64Dn00o76z3kUQWgmU+j5uNE3BBAK2P48OTeTXeq26W6BFZPyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792604892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+7/KnoERokdTuI/DiVrhqMjv/YKJLC+SuuwGzjEk51k=;
	b=cWbUFnucW/uUJNhVT8mOXnjgE8RfEre9HKK7jum0H9rh/9HCigL1ti7FULPeGrkVRoEf
	 V4wFOZeZsRyX6fjPTTOYdpiyJ+/Lk1RGajh5PbdsMejvybDv42xIKdDPvU+K1zwuO0qKY
	 LypB894eZgUo+ZfNEVx4cgCWcBzvSLDZyP463n9Dd3oe8H4o7Dxzg3W3yYMQgqqf3UUkO
	 oUE5O21m6XHvQLndVz1aqs4R9yvJtBVYuKP7OVUEUNtmVg1pUTylstiS3ue2P2zF+UEdB
	 HZvb+C7CkveDseuG++tJDLMUvsxEcdsrFP5isxuFEWWWqIh/jmX8zQMl1tR+M9980bg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792604892;
	bh=+7/KnoERokdTuI/DiVrhqMjv/YKJLC+SuuwGzjEk51k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HR3hRgOXeFMumJkW2wMEwb+b1LqEdn28dPoNd8zTM60udP4FZPXdXov3Sdk/rS/CQ
	 VX3kWtVokMdGfjozBaBomnvV6/Ow6m4VbEltx9hFd1vOFc/6NRpy3KiO2HzRq20Cs8
	 jOSIie6ttC2A8XwX701D0lgRBmb8dkm7e2vk1IbINgEywKYO1dlAWBwdFIgYrShCdY
	 ceGfqQ2AEh40Cn+c7SWWXssM30elbp0YUnso/sk9fkX51Gt9X+cJFHXvUq4RRRhCVP
	 Pxu2BQuGYv7nGhK7Lhi6PFOE8iM9N5XOmRpJZuptxTXyPX2Y64Pmckm/jDL6HUkoHS
	 oPiSdeyAUNHiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1644E608C2;
	Wed, 21 Oct 2026 17:48:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E241C95C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D420C4039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CkOXGjDpY-ol for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:48:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0AD454016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792604890;
 b=VrVS4IzR3DeLIltxcNvcFtGd++mcSkqXe8UKu+utN6IOtjGbjbApybD9CtEYwqdNZ8nI
 c4murcEWZAezq0MNmgCSAIoYSNaWQg5pS+zI0RkOTRHUx6X3oyR5igyBnQAbZnd1H0att
 3QTTFB3Ops3HZXHZN/2Ep1dVvr3Nk1QFfkS8VDI7YCGbCwkYAiZwvglAL4eENQ9mP7Q5K
 OcMGXBN/rujUjxTzc+RD2CFrDoyS7nighwIP1MNJHzYFrddAIXcLZkqULY11u7UkX/iTk
 uWCzZN5ZfKVSDa7HLi3HS73al/ecMHSj9vg3th4KeBEquiuytUgyXt8c360aLsPkclQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792604890;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=+7/KnoERokdTuI/DiVrhqMjv/YKJLC+SuuwGzjEk51k=;
 b=gqqKjj7Uh3wDNrfkeaebm1E49Lt2byapCkXZw2wa0tqn+o2PjRTFXgrzb7DqbNkky7Or
 3kav7F/ZPnAhUSDAXq6AVWSXsRlYstolU+Wad755Lhx7LrTVgmU/fCjE0hisfncJ+2HKQ
 /VqBAXo7NuqyXztS0oB89qeCJe8v0rnjGXbru9O1d+sSnfLgwoJJq9HOPneWsvEd+Ma5s
 ybx6Y3h859jSswighxAn120+WzZlq3h+x/l3cbt8zkjbkAR34nuWBi9Sv8r9GQ/JDb+GR
 WSYvXy9zUdn4YQvY5WI1ySvZ3jGToF1K2B7FE3J/HzIneY3mHM0VXkNUgYRNnU3Mk5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="PZDzu0Z/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PZDzu0Z/
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0AD454016D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:48:09 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-7037daaa820so391682eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792604888; x=1793209688;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+7/KnoERokdTuI/DiVrhqMjv/YKJLC+SuuwGzjEk51k=;
 b=PZDzu0Z//RbJCfGy3cIVYHUdXz7vp9vWEm4QWLPBlJxcV1wi+7Nln5mRevYQ9Yhfmt
 XE+oVpffA7Ug/dSdTZ4+AejiYAelQc8qhTWWwpQ6IXfY0MAMCT8qEcOWWvXba4jWAV3M
 ns8GQuZaD+k2Ns2yx+ay1Krrjc2C2eLM2iSPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604888; x=1793209688;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+7/KnoERokdTuI/DiVrhqMjv/YKJLC+SuuwGzjEk51k=;
 b=Xiy93CglcHWQ8e2h3ab9YwnIUUKvO9of7YmMdTy6VuQ3cKwVbg5AgIgVosdcr8dRxV
 nbgDWENTETWyS7Eh8e2S5tqlqhzh2KlzvaXBk4ASroXniBONPAgGGmHv9q01ump11EtP
 rwXEGM1HU0CZKuEwvl1LcnJSE4IbqyMVgMtl1BwoNN/2NuF4PkoxO417fCbHnzo/GjPZ
 kT31jIAIMaUnGIflujnm/UQOfm7BuuU7tdXhGwApoRRV3L8seL8/DM7MWQv/uFzBzlYf
 yliAS8Rh3QyRFHbFgK8stYuVbQ9YEQH4pdmhpanMVWdbptMBaV8oxSKUyhCF/pgsu5dG
 WbEw==
X-Gm-Message-State: AFq9FYLvOVP6SYsNISW4Ed8lQ7HoM5OVsLnf/mExU+TUKW/N2wttL2ES
 YERI7PcXVd7U02OzUh21pdA4MQRwmRoEHUCrKm3xX7Ovz4S8e/6BFizUwBNjEDumqZ0=
X-Gm-Gg: AYBFou2Al4DmYxGwVxTDnRPwhNvFPLMKnZPlL0uyY/yabpUGKtr0dYPym12/5eLBx9g
 RaYU99YRkxEb3ZJCo4jxkqJebSF4xepBT7CtvRb76pt1Ha3GvlZHmfvYUWZZUewSnk12bljdsD2
 tCcoMge9dTDdBID9m4CBMYl/X0tuSE6CtTlwHYG5kam9Si+WFYPdZonWOhvBhQE3lEyj5WryL+p
 iHj+TbxsSXi22DMHx3DpgXAVl66Wf1mNVJLjO9RQ26MmpY86Gi5PNhCHEh3JyhHB9Hb6mrCX4zp
 UH6nMxiZ7KA5PlAx6WKegI8f90JmuKTstFER9m5QmUOapY+yKJAdcUdtmbeT7jbrnsUZHRRpCK1
 EhHNodUX3cUzwAkb8SlplFAYlIpsSb1Zgr1Y5KRrTPcenjug7M9lvAwCVAeo/pBRB67Y6ujGOv3
 XZil+P84G5aRN2AgCNLh7CuYcUWuvomXu9gzVYgKS3306T1ZhUyZhOzcFLpEt5W4Y1LoKVnCUPV
 YbU+y9qwJWgULB86scSYQ0wNz+yyAHVJo6ccs4FtSEpB7IpB0ecOc4KDGFvEBCcYR04HEejLNkp
 tW2dxiu7mMaFICKpocn/xrc+anCz9odva7dM5k/MeBEQv2oyZMfPGelhDJXO+yOVub+cotj+o5N
 m
X-Received: by 2002:a05:6820:f006:b0:6e0:1599:a4b with SMTP id
 006d021491bc7-70940c44364mr1582178eaf.18.1792604888346; 
 Wed, 21 Oct 2026 10:48:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbddc7100sm2918253a34.24.2026.10.21.10.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:48:07 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:48:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
Subject: Re: [PATCH v9 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
Message-ID: <20261021174805.GD3275858@bill-the-cat>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-5-18ce3e431320@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VxZe1UBFsBFqNelP"
Content-Disposition: inline
In-Reply-To: <20261021-snagboot-v9-5-18ce3e431320@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--VxZe1UBFsBFqNelP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:48:24PM +0530, Balaji Selvanathan wrote:

> In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
> The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
> boot even when CMD DB is not strictly required.
>=20
> Use QCOM_SNAGBOOT_MODE config to allow the driver to bind
> successfully when CMD DB data is absent. When QCOM_SNAGBOOT_MODE is
> enabled and CMD DB data is present, we log a warning.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Can we just not build this driver?

--=20
Tom

--VxZe1UBFsBFqNelP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatj61QAKCRAr4qD1Cr/k
CrEjAQDt6ay/b59Z3bQo7xIzN8U+bBroOsEk1xVveW2ECNa5AQD/YU5mu+P7owG2
1fMtoO0zFnrgk6YWB0qSHVHtudyx2wg=
=oXYw
-----END PGP SIGNATURE-----

--VxZe1UBFsBFqNelP--
