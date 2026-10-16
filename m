Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB557CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 00:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E4F38125F;
	Fri, 16 Oct 2026 00:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tn6jF-e-I5dz; Fri, 16 Oct 2026 00:04:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ACA5B81266
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792109088;
	b=m53BRwuyu3OiVC9ex0ey1ODEH3gbG3p7/zquPHm8PNKVcW6q5y3PV2571BIq2jthzZNh
	 bHBEyWgmKhNWAQ3sr2ai1bbuM/t5CsP01f7BZ/mWRm7cxfokYKHqJ7jWEWVG0s5Q4KxTC
	 zM8AKBULJv5MhRh6wyK08zXK9hOhxrsnp1p2hi2AbIadCPMCiYaON83oDP1+3xbTHmhKO
	 YTstELn90fAGhBWR3es+6cAAt62IXgbGNjoRUtZbZgsr8zw4EIFCdRt+7UKTTrbgB4fNC
	 MQLwn7z3gpqN/rMImZdq8Sw9T9hmNyWBMld1iewMKI8srDiBHp+v3qvUMuGDh/XYpQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792109088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cchszqD+fMXIMchewJ+xK1sLH08vdhaZW90OvXM58fk=;
	b=UHl8pTPh/RvB+Hp1vFkbMifWbdUgVZImhegeSZvKjtiKjL9A+6MamcoL60MizN6FVMpj
	 qXgW6DpfBWGvZNSxQtO0tZ7H1J+9IN0p+e0zfsIouNdmU1Wdnabvp3ABlIWUUFP6khMVR
	 wrn+jOcN9WgxogEw1hsD1j5J0N9pCAKGJs0/B5sIeRFWwX7UMKQ5ntMK0p+x4+gW6S23J
	 1r3qbH7Ue/wgJcLtPqAKB8EQxnI45gFFuj40KwuTA0p2VauhlbqnCNHW+bu/DKVUr2KmF
	 gF/CqYrZV41N3Es0wLVf/3XK9r0Ezfk9GF/iklPmv91a5Q2Q78g428zIKpLVk0c4IQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=a0pZFA0S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792109088;
	bh=cchszqD+fMXIMchewJ+xK1sLH08vdhaZW90OvXM58fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VVlgdlE7dylAHktVoGl+OVV3VX7+UlTgd1ahOn4FsFLyqEGTKRdiaweQ7LbhLG1TJ
	 NCLdm8zinPmvgE4iYpBtwtSZBewCchSDXubpoLrCUcoYdjgZHOoWZ4j4kBQqnFMTF2
	 8o7wsisNhMjbJKXz9p8KkZuEz8shcS+oaRqH/d5rAxfRXjqz2Wl1lbipDeao+VvkgN
	 kGqZuUNGniJQoxRIyx1p4EApaVS6o1r2wjvNQI3ihT36aOcFu+WbrzYTKk6Nk6T6Cz
	 X8XLRGT38clEjH4Qnta7pin+i+3t7KOJRcKks1RQpwtjtzcSwNqFudZ//Q2jDUUUj0
	 zTToVpYn3HxIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACA5B81266;
	Fri, 16 Oct 2026 00:04:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 95CCA109
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 00:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91F6981266
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 00:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OOoZVLWlpApa for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 00:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CAAA68125F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792109087;
 b=pQGVrN6czG7iapzOJ9KNREOWDEiFvjQYL7/rdoyu4g3lmSaIhVnigUQUNz+UwGsDdMu1
 8bIXwylVNU3n3syRAiSDAkAGf/rW1RRttVINER77QFJZVrmkHSFgAX5BQJ7dHRMPv/wxp
 mQ9HMa5henXuQ4x+w2EE5+p0WZKmVPRG3dP9PIC47jD//GcPg6QgIEcj+s8DTf23Y5j4U
 1yDyggcO2Wdwt9/gnFhEXbEGsjczzPPOWhdumcU7XrOOD6C9u1yl+GqmVYGUlDL151CXc
 V92ltPnVX9GpPhvIWmuCi66bs0GYbnfpkGBPmp0j6NTn33Y7woyZ/QtZp2IBOR9d4MQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792109087;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=cchszqD+fMXIMchewJ+xK1sLH08vdhaZW90OvXM58fk=;
 b=C/T4LLd4lpzKWVtawjsUDrCDoeyytJR2nIGsIDejmvyFXajpexhPXtkqe/Ts3UM/Boc9
 dcDYcgU+AFZ03dTBqI+u3T3BJqyTfUGSbkFPz0tEOKgQTl1iuG9F0EXR+hT5KQnHuNwKz
 lHO795TAo4VLZxwdRhN36N4CW9X5VyRrpi+Njp1m2HZIBvSCBiH7v4ycuW8j8ocyH2DCN
 D8L6fpasuX06leoZRu6pBqjo0dhRvEvyvLxn2Eaj0yDeL7lfzkwgkKSmKi/MEGx1/Z4Va
 mpeippNBQK7SabgntzUnxetpJ4BdgjZkmBqfNxNazxn13MYM64AiEBXJDH6all5FCTA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a0pZFA0S; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a0pZFA0S
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAAA68125F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 00:04:46 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-81ba09a5d23so1863366a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792109085; x=1792713885;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cchszqD+fMXIMchewJ+xK1sLH08vdhaZW90OvXM58fk=;
 b=a0pZFA0SCeMoT7ToMBFB/Mh3HdJbBTHtJPFDXkyLfOZvaitNwKqjwAGxc0m7LCFZt2
 9VozPV69zTrec7kA2XOA2XE+snrtgaGFA/BKlVxfXlPP8nuEvDk3V8SDd83zzoeXJObj
 kdLrSgcaxl6McmnIVN96PkSqAI9UFYosH9fW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792109085; x=1792713885;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cchszqD+fMXIMchewJ+xK1sLH08vdhaZW90OvXM58fk=;
 b=AWACdXgsvJgtdVI+fvbR9VBy/q+I9TKpRoN2iJd064neisFWrGHMuYxM7hVUtNn4HR
 wBiCjRdPzbN2NEehoxSOGDn/BiDa4CNjtMqnqf/Y5QetIt//G3gHXM/ZvJJPrUXe1xi3
 mehUoOwW4n7V4Wf8/TZwxByFCpWDPxNkTLBrGvkXBdCt5RGnO7YVBc+DU1ZB9CbJ4uSn
 Qt0OijV2uTunACz/nRvJnS99BOUfPAisCIyHsxvz8mnecZUYcsuqzOWDeTpn7sX1LZSW
 U3YkfFOrDd/4acQ/Il3PAbZQ+0W/1sXt0p5c0OVRtxVVKocyBBhee6XZTIvZPcg/HFkq
 ZpSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzu/5Ctb5EuuGVlmd1sw3kgrZh8h02Yqwum81QKRBnT9jg+QO7DSxH7VWYyo560N1rDEasW4qE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKH4bVJmf8kQYZsJTNZfLuo/+FFe0LRUHT6iu0Zz5Eo18JJU1iI
 L9IcP3QuRKqXDiGCw3JS1CP2KsWM9E986iR/iQzLGMCALTQpgKZp/7rBemrFfltOdt4=
X-Gm-Gg: AYBFou1qABRsFnWdGZYkZeRJVlO7S/BgybBhrrx5FMpLGwgUMJXZ58O5PM2fSk9efIr
 3U3V+X6cBxbke8Oy7vTh/Ix1+xG1YMXMid5oy/1GzeGbqcpsjY4end8kkMryJ3KURTRS8jr0i9H
 vZIQbaJwnWyahctmqjylsWrUHqPPQ7PFsuTUbvzMZAxOXyDqkLmbUR6D2jNYd79Ce8c4GzLenqf
 4M8bbe4HYtMtwCcYaQP6Q+RoLSFle3tU/gBsFB16AYP784mVg8FOBbEzoYEsVK6hPi7s381y8Or
 wAbOZpoisMowaxIIYi8/ykymMZzYCOoyYmmopo7c/sxAFhF5owVLzx8ug5D/MbQuZZcXcm0mhPm
 kLnOnTWdSURqKt6I7TswVdUSi9tgCG2qi6BoAFfPWkd0uSbprkI+O9kDforBagz7pJg2bzLJksl
 Mi1V1U6sEjIX+Y9BwjPGR+5KmnFMtLVOWBQsIA93BzcTgLkqieqTU50KLMFlgNxFPrQsNMTppcZ
 tu+E6c5ly607iAfzZBOg4q300HK9eWhqgRwG8V0eh7KFKSUZ2jN+YzvwssI8Yk1JFwrBOfs3Tya
 neEBF41zt/2OHt7m5bA=
X-Received: by 2002:a05:6830:258a:b0:811:a535:60 with SMTP id
 46e09a7af769-83094a8b66cmr20945473a34.9.1792109085438; 
 Thu, 15 Oct 2026 17:04:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-842a635ed98sm493309a34.21.2026.10.15.17.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 17:04:44 -0700 (PDT)
Date: Thu, 15 Oct 2026 18:04:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>
Cc: khaliforce <kforce@gmail.com>, Romain Beauxis <romain.beauxis@gmail.com>,
 u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Message-ID: <20261016000442.GG259661@bill-the-cat>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
 <489e6811-cb25-4085-8077-427100154182@nabladev.com>
 <20261011223137.GK769217@bill-the-cat>
 <c532672f-8ff7-4e80-8f78-0140bdcbd434@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YgClFk93GAoQFpkA"
Content-Disposition: inline
In-Reply-To: <c532672f-8ff7-4e80-8f78-0140bdcbd434@nabladev.com>
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


--YgClFk93GAoQFpkA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 11:17:28PM +0200, Marek Vasut wrote:
> On 10/12/26 12:31 AM, Tom Rini wrote:
>=20
> [...]
>=20
> > > > I believe the answer there is that we have flags to handle this pro=
blem
> > > > generically rather than hard-coding a call in every arch's
> > > > boot_prep_linux or similar like we had to with the old USB gadget s=
tack.
> > > This is shutting down host, not gadget. And I believe usb_stop() is
> > > necessary to correctly shut down the devices on the USB bus, while the
> > > DM_FLAG_ACTIVE_DMA flag is necessary to shut down the controller, so =
both
> > > are needed.
> >=20
> > Host or gadget isn't the point here, it's that we used to hard-code the
> > stop function call for the non-DM driver and now we have driver model
> > and flags. Everything should be able to properly unwind with flags being
> > set.
> So what needs to be tested is whether the flags are enough to properly st=
op
> devices downstream of the controller, or whether we need something more,
> possibly equivalent of "usb stop" in the USB uclass pre_remove callback or
> some such thing.

What more testing do we need at this point to see what
DM-related-unwinding that usb_stop does that isn't also covered by
adding this flag to the controllers that are missing it?

--=20
Tom

--YgClFk93GAoQFpkA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatFqFwAKCRAr4qD1Cr/k
Cu8HAQCHE4lab5ARKrMs1VraAu6nrsU1ti4v0T+AzPYA1u6gBAEA+f1M+TxnHrZ7
USS1J4ttUsiuXZFAIq/LERanRomy/Q4=
=DVc4
-----END PGP SIGNATURE-----

--YgClFk93GAoQFpkA--
