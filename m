Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5E606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nrt5RF9o;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=QMxIw9Df
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E08CA81657;
	Fri, 23 Oct 2026 18:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0vnnTqFhY8Av; Fri, 23 Oct 2026 18:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3382B8162E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792780613;
	b=R7oFN2BhNBeFhG/ZqyG6aow8rawQm/CjYy1ReyF7X4cuYJSx92x6xj7LZWc8Ia4aAjYr
	 Xr+yWHEIvticJ4jEZ0nCvIbmxXNDoJFgV130Gbp/hnlC0g0XgiDNY0zxXSco11pS6nwUN
	 GZmhCrOm9dH5Tz5VQT6sQ2nCIxSbzzYXTlFXs3ap3DyU0t8VcRrz1wZuLnfQbsNsaahdg
	 ZDeYbWRb85r7RVocWy/OzFUpompiI7m7JT54gcRD+j/wCYMj0/RD/j1gKMSwt/gAUHKae
	 EBzwcZ3INf2HBfEN1FERFFTAWG7Vi+k6fm4igZTCYSm8S9sR6clZcEplpO15tml2AcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792780613;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cshffJVGJE8NbchfEUsJ1DZb1sHNjOO5u0tkw8tDibA=;
	b=a3X6v7H3TisFlFct8DwSeOGCJcc+cG+xmsznSDQVNN9RO/mcFH+qJQ56rfaK7Nh5PTvr
	 o2VQ3vRvl07lHUgZPJw6Fz9++cxaPa7ErIJUXcmZqiIjUqQjKgPEE4Q1P8qA9lbYM43lj
	 +s7Gx8w61tbm7P0mHhudUv+57AOaDKc5bKSgFPoXiSMT6PzhUkHwpWrymc+doFm3fCDPm
	 g+g62nBx2dwn9UPZ5ZQoZuxn9vsqKUZuEX7Y5B8fatSfJvjBeWRVMJlHCTRkkm1ULPmGS
	 Iyr9uZLg/4jrWgly5ylNXjzCZnJxN+cIaaZY7ik7SYoyjt1G9YLlQ15XHn+skoteSsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792780613;
	bh=cshffJVGJE8NbchfEUsJ1DZb1sHNjOO5u0tkw8tDibA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nrt5RF9olp8AwKdGg3avpKmQ9p/uepmv27aIUvIOVipek8jfkBxxAa+nKE54Rw0Fq
	 FR3kcOEPdwR4/ZZjwOLjiHc+STeizGh9KuzrJURKDPNiSKm9jLcBd8H9ERzIsRIQnd
	 Hb7kFMXd0I0AnGrwamhlBnep+1sZOhehdV6I/NnaBQx9TyzRjUSsc280Y3an0pMOIz
	 R2pbZr+0HZzjGQECE8xEEP0s3ok7vCbSeWwNlcc0rmV4MeLXfyhq2oVMlTsjvZg6z0
	 BujRuWDT406PRT/rfYNp2jdxAIqlOyIPevIwtFpmt7Q1+MWhvo/y76HcpzoakNON9A
	 Bngb9M2T35vLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3382B8162E;
	Fri, 23 Oct 2026 18:36:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 69BEA388
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 18:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B6E8608E6
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 18:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OcHCJrqNinOx for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 18:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 98303606E0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792780611;
 b=DPm04j1VljwSrQtV3OjD4AckTZzivo+qdNVLU7OcQ4tjPyzSRcwJUulFx0tP4BCq31K6
 j9JevBqJQkZkUUGtITDaOwLEBJ8HyfSU35jZNQuAwHH18eD1AqCd85jyx16CrNI7gbEWn
 qHPpQeAq0v06szPKaQqGUAzg74DEQJm6CNBg1vnJwdHBGLWJnxU+Qifon4vryDdweygNa
 uRJEiqAiMFUT/jaG4Jid4aBsRtg3Je1vMTRlQC4C40n21+1bj9SzM/FZCoLa7Am91lDmk
 54NwsUaG4cIz/w8+/ki+wMrs3Z/acKWI/Hyglk7wSQ+9dz/BOxRCwrnkfHzs9kDMkuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792780611;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=cshffJVGJE8NbchfEUsJ1DZb1sHNjOO5u0tkw8tDibA=;
 b=fPS2kVcvxKNcH7RxxIH2Sd9kJrV0VTh0oEtDshC/j/Y3RXrjPxOgYn+mJYwVAZLYw8Tz
 bEZjwcjqDJfWkHtH0ZBskuthh4way/uIL46aKE0tP3UHrTwjK+G/ZHQpz2xsp2cIv9VQn
 nVJmGLRUIf9gh0wDmOvqmImD+pzM4yxQLHPS718tuCTU0ITskEWFQFuYccbqsMIaVVZK6
 jo+ZorEB0AowPFkW08knGSlge/lbZkn60uoIptzegdcHiELwIWYUIOFzjzXHln+P8lSXY
 Sy6UdDZeLdWPWUV3NExOSQ9QqxBMrMXk+Ieu1pE/E0n0Ri13mCFzAPseJphBRXa1Bww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QMxIw9Df; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QMxIw9Df
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98303606E0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 18:36:50 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4a75a5fa32dso315150fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792780610; x=1793385410;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cshffJVGJE8NbchfEUsJ1DZb1sHNjOO5u0tkw8tDibA=;
 b=QMxIw9DfL5O4nBCVDKwV+EviR0hcOYbPiSI0QF09lzGR9jim0I+4/wzm6V1bUG81oN
 /SZ4MjlBVpG3J1E9aVAJN9hckLLfHw0T34G3xvxHY1yAB+a7yV0NLnm04Oc4jlJ8s4Oh
 +yVwXdefzMS41pzvSOPz0VAKsHal7sBIkBq48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792780610; x=1793385410;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cshffJVGJE8NbchfEUsJ1DZb1sHNjOO5u0tkw8tDibA=;
 b=ktsZT5Ea0hiIgV22rMYXmTcBvmznslVaZHv1fCy6yn5uONF8LjSZZ3kinwIvweSvwR
 AmsTXJgO0WQPpCTL8YBABjJJMD3zU8VLv//OLI3LkXXpxvLJ3T62pW7KXuVOUhRQzxRi
 sIip+MEKzb99w1H7P885BuILe7RR/KueBX/RkCWGaiJV85zos5/twHkydoq5bRN0CpDu
 TH62lVBxo6AHPsawE2xGcQ+ypYV55uZsgDeIQwuLgnfC4C1e3VdfgRho3LpUBIyOhbsC
 drvOrgV7vO5nSc7Tm+gByNZR4U5noMhweqakLTFS71Z95t4P5Aw2Na+QYV+niCdcnxD4
 LGPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBztO0jO+waVfXrJBXgzsLcBk6k/PoK3VWQQbMmeBQfLbZtiLRG0Ni/YYdN47czXGWew/zL5lq8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYINaM/B15yuxRvR/xUIZ2RpZoKF7b+qgxEJHruupFCpTCT0TCVU
 eND1hPrzdwz3aC9FRnCBhxxKWwngS5oOwDtWhBebmNOd6iTzttXq3CW7iMqUiPMw65I=
X-Gm-Gg: AYBFou1Bjt3NR0YlgmLPwW6tevYNmE3HfmZ0Vktxh5OCmvOXY0kKZqXOcJ9GfH3hWte
 /+o6GaXc/RKzcEDxCLAx4h1/Akid7BbHLfg0vzO3xwQhyK9t7VTVwOUVsmIg1YCa89tgYf6uOsn
 kEcTi0g5GI1br84N8YfEbHEbZSzWHU/FEFCN2vWlYob2M2xn815Mndx0JdkYHZ9c5yXj5wEDEvb
 SgKVHChPeVIAO6Trj81vlXGMqFS+qaPvCKDTUDBKtR3Xqqg95F5y/xTbe07KvEjOMRMJisillva
 yQhOCWR6O3AAKlQLfduR6ZB6SVJkOUNIuefi7EZ7xiWYQ4mDIQ2esjchMmDXg7YwJCtOvsTfnYp
 O/nSXmFvgzwHQwFPjf0tr3AzNhlKSW7fz/oVvx3Hgbvj5nXjBHDOs3gQ9+tbqza+CLLYEqQ2yJ8
 LOQq2i/tXb7/o+KTKvkj9AgnfkKLXu+9bkKuLyXg4r7MLbp6pUBMQBYt6RFH1GrbCXJ08B+6NmJ
 T1iObePBLzxmahUbhmXRIrfKGJMmlvmXBtPUhhAMb+RCoc3ozTHlyyitdd+MniPDc12iT8IZJsF
 QTk8yc0QJcidsnD/KCrKPp81RnmcG6AA2gkbpAYAxZbS164QqbMOtqGE3G+nZhk7EL9Q7ZmA/B2
 c9BiQhSNBiMKku2VrJxWKsncN1g/AowTQEmSk30Aip5KYLF19+m9/5vlgHQ==
X-Received: by 2002:a05:6870:1b09:b0:49e:1c69:1f57 with SMTP id
 586e51a60fabf-4a83f51df2bmr172441fac.41.1792780609729; 
 Fri, 23 Oct 2026 11:36:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a838200fe4sm559341fac.3.2026.10.23.11.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:36:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:36:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] dts: monaco-evk-u-boot: add reboot-mode support via
 PON/SDAM
Message-ID: <20261023183645.GI3596691@bill-the-cat>
References: <20261021-monaco-reboot-mode-v1-1-41cd3c8f15d5@oss.qualcomm.com>
 <20261023174443.1552137-1-tyler.baker@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nX/irmNLE26C157t"
Content-Disposition: inline
In-Reply-To: <20261023174443.1552137-1-tyler.baker@oss.qualcomm.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--nX/irmNLE26C157t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 01:44:39PM -0400, Tyler Baker wrote:
> On Wed, 21 Oct 2026 at 12:25, Balaji Selvanathan wrote:
> > monaco-evk is in dts/upstream, but monaco-pmics.dtsi that it includes
> > has no PON node and no SDAM reboot-reason storage. Add them to the
>=20
> lemans-pmics.dtsi in Linux already has these. Can they go into
> monaco-pmics.dtsi there instead, and come in with the next dts/upstream
> sync?

Especially with the current backlog, can we just move qcom to being one
of the platforms where new stuff comes in first via OF_UPSTREAM and
either re-sync or cherry-pick?

--=20
Tom

--nX/irmNLE26C157t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatupOgAKCRAr4qD1Cr/k
Ctx2AQC1DD5XumMpUC8buKUOHAA21TkKbMqbz5V2aDjs2ESl5AD+Pql/5aT94gXS
rTESV36J6Prab5uo2MbjnZgjALy1Dgo=
=N8XU
-----END PGP SIGNATURE-----

--nX/irmNLE26C157t--
