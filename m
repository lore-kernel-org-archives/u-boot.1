Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4365606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KSsOlwFv;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=t/2AlUI1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 960976075D;
	Sun, 15 Nov 2026 18:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fWq1sfHfXQ0B; Sun, 15 Nov 2026 18:06:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2A8A605E3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794765998;
	b=WostxL0QjxMVZOmcIhvajL8zbbrqpi8CGkOKppc/0pw62cv0U+EkFUegjGhbxBADZPve
	 /kpFs3UeN4V2O0F7P9I5UWpTuYiY2X7R0KfAJTOFKalbbtfdcRdwzqzO4MG2VvKBzpGjT
	 LOb2yqnYq6XsGkePlNj8T4houcVrxAM5+VFr8dRIdbGyKGjJpVYSY4dTFpMKnYuKm9sLk
	 FKK7+Il5AauGMcLwtvT4gI+pwn97olXqueUU/2rVFlmxsN1o14WF10tZzhPe7Z4nqzRlq
	 EtMSmjPNlaMnw5gqmWdxjm35gWlQJjsKGv2tUW0sdBFUZPoMYz7zP6lhOjJmb2q1JsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794765998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Gh+1R4X/z4xgk2XZsUH4Z+K8kvcNnX8UrRTFp/EGFyM=;
	b=ikezN/F92EL1kBfkWOmFOuUirP7mAFNU63lxv6M+1oH59JwJ6lu3jb0gyHg+5A52weUS
	 3bNNOnOOw1iuhKMnJ2zgKYMxC4CTqpHIzeLs7uADw18auQ8x60/OAgiksrQ5YEPMPKkux
	 Kba6UVJUHV1kaQ3R25qjKCdPqjW2BrwCDv/vrgIJMrW1Dez/qO3ktzL3Q6afE+qdnv75n
	 D1GRD/WtEpU71v+kcpFxAXLuViLdgd3ow06NjIiOoePv/48g5HF8Cd05hNJlixhm3rVPo
	 UP8Hzx6F8v5Wfk5Uw5htNj3b5ZaClBEyMAqdg1OPKeKGqIxyRxNq0AxxuJWPiACp/PQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="t/2AlUI1";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794765998;
	bh=Gh+1R4X/z4xgk2XZsUH4Z+K8kvcNnX8UrRTFp/EGFyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KSsOlwFveZLhZtsJJ6y2sqNGaO2kNXanaYFfmw3beKNHuYTgJJiThyAKJWbN9aAAY
	 RAhSo02f+7LTOL+K9dl6ieWiHwAf800jATa/6t8ioIuaSED5tEP3PyGzqB3dLYuqzH
	 BTOjMGMUcEaW2p+96bYud5WPLuVSlZMN1zw8aWN9AXS6CZdmUQ9dg9MzWPrTqpXJCt
	 8/W/HXEOX9gfUWtUMVxY09Hl89qjlmx3mKwnW+ZKWZMsMyzwqgV/8UQSmP3xx+F0GJ
	 9GzqhBkr2wqnDszvya9Uy9So1LZnBJTxzqC428eH3EUWww9els2iZiJ4rvfLbyStaP
	 6ndNLULAJeEfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2A8A605E3;
	Sun, 15 Nov 2026 18:06:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BFA822E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B13C6605B7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWmPxksP7GmZ for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:06:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F0204605E3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=t/2AlUI1
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0204605E3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:06:32 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6ddef424972so3283029eaf.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794765992; x=1795370792;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gh+1R4X/z4xgk2XZsUH4Z+K8kvcNnX8UrRTFp/EGFyM=;
 b=t/2AlUI1jWShpE4ZFYXZhNHapsOPPeXRJ74Ipx540irz3Aa0M8U4h0Q65TD4QDo0te
 3WytoQwomjabw7zAWskhbBsqhXiiHdE/9mXlkgeNmsCrtwytSWwevPkp7QY5s7XI+W1M
 0f1faJr7zz23pzSQjyUzWWl1BGhdyc3YCDfDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794765992; x=1795370792;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gh+1R4X/z4xgk2XZsUH4Z+K8kvcNnX8UrRTFp/EGFyM=;
 b=HNoj9V4gJ/I1Xfr5jd2xc+HCAc370ZitVBfEcRZMtj4EjtDUqJFjhs9ZjfrVoiV2kW
 CcCqf814Vg7euFpXjlZ2ffu1mupnBODIBcqGUSRa4aHw7/dTOa5jhu7IVVlUW+NQPg8Y
 NzwGoHv+yKN2fCT22G3speBAsOxCtykrhBH0UyNCqcNeDpXdbBXPKDXU+a1TgNuAD2KI
 lXu9QqalRO9vkXU2jhWp/km2/+Ig41UfZ1n4HQ0p0bHScqXsEfkSdybU8mymklJEhm3/
 Tio6Uoon3ZZtzbmhnXp2qSe8quL64ETmnp2+kso/QjHeNCd0FjLT9hH10/K6KYVistE/
 Owvw==
X-Gm-Message-State: APuU4Z8O6HQ8ywTQkI/6AtAIMBf09xudF49Uw3AtPLDYDKYwqc0h4hhD
 +udK5dH65ebS85PB65o2lbWEwaAXjXo9sHUyhhSk/35fZUu7N0fumDZCmRZxjZAJjriNoSSVetr
 TPdNewCIrNQ==
X-Gm-Gg: AYBFou2kBLrFhJa1oXxFaaboV1f1tND/USvouTY+XtAicZuxN6+teNl0XRkl/T+t0hS
 e5hqRnSvRmYwnYHDjuzLLXDVK2SeZKKeRUDt/Xm7Fh9TxYehe/zcWfrAzW6DHOALf5dn4CY+Qjs
 8PL7lqSzdGlaBLIsr8nH6+eRv/zphrtm0Ntc12NirMYaQC5ynjVIJ6i3ukN4rjCAijTfvQUpnVd
 v+obbjivJrDhTxtfaAHN3h0KlMtjGNwAYgr9Mi6af54uhqXOAtn83QtgimhOEaAC8LkPB7NN/pZ
 9wJ71VfsyUR8/TWgcfF3WuSM6FXqxXEircGITEGvNqUALICzk6oW4RR6am9LNOKORIcah8/6eyR
 BKy5fylU/xMcm33ysO2dFf6BAzVKyy8Z7ENv88sO5XTZWSRSSC9a2bkLoPs1SEDl19hZtKPB+VQ
 jVwAm3dDHb1JIUzQ7afLNA7wiUy1oziwIOcwP1ZYoXCcjjQCMLwwB4qOnOS8XR8ki9EER4qJ/9R
 r3b0b8BJmUZizDDOP9Sk7mW1gQjbrKVcQc7WvMxZwW6KrFCOLL2UPJmdOsaTAQnmEZU9xQw4LDR
 IGFMA9ehVvJjH4cq+IPDH8qRcmMlQKoxETJBE0rIeRKC8ZXcIhrxbxDzAinq1f+N35qC35C0u/k
 t6HhmVWSYeYJdDqxgZZVVKuN/bdiQl9iiwTLBRU2mq/aE51xRJUTacY3TZiaGnhzQZTFJC2IlGy
 mjYrMZgLcrdgVLk/AO0CWrudpfFnievOc=
X-Received: by 2002:a05:6808:10cd:b0:564:36f8:ee76 with SMTP id
 5614622812f47-56e611de2c5mr6982651b6e.7.1794765991824; 
 Sun, 15 Nov 2026 10:06:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e7094aafcsm7830226b6e.12.2026.11.15.10.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:06:31 -0800 (PST)
Date: Sun, 15 Nov 2026 12:06:28 -0600
From: Tom Rini <trini@konsulko.com>
To: George Kola <georgekola@google.com>
Cc: u-boot@lists.u-boot-project.org, Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: [PATCH] configs: netspace_mini_v2: disable default netconsole
Message-ID: <20261115180628.GV554944@bill-the-cat>
References: <CAOTQ16+AbF9iURWBrU6_NOM14KCq5-s1YFbbP9ULe0Ch0hhAZQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zISQw7kCXjn903wN"
Content-Disposition: inline
In-Reply-To: <CAOTQ16+AbF9iURWBrU6_NOM14KCq5-s1YFbbP9ULe0Ch0hhAZQ@mail.gmail.com>
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


--zISQw7kCXjn903wN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 09:12:23AM -0800, George Kola wrote:

> netspace_mini_v2_defconfig runs dhcp and activates netconsole in
> CONFIG_BOOTCOMMAND without setting ncip, exposing an unauthenticated
> UDP port 6666 console that accepts broadcast packets and drops to an
> interactive U-Boot shell over the local network.
>=20
> Remove dhcp and netconsole activation from CONFIG_BOOTCOMMAND and drop
> CONFIG_NETCONSOLE=3Dy so the board boots directly from local USB or SATA
> storage by default.
>=20
> Fixes: 970bf8603b87 ("Convert CONFIG_USE_BOOTCOMMAND et al to Kconfig")
> Signed-off-by: George Kola <georgekola@google.com>

This is feature working as intended, presumably.

--=20
Tom

--zISQw7kCXjn903wN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavn0pAAKCRAr4qD1Cr/k
CuyQAQCWeWDv6vbMH/lnqeknmFVXnbjF9nmSTyt2CQYyWySxtAEAnB32uGlrFFsP
x2QPEgRU+BOeVdjJ0FUojUdpwR7alAg=
=+XaS
-----END PGP SIGNATURE-----

--zISQw7kCXjn903wN--
