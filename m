Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D38CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7AFD40D48;
	Fri,  2 Oct 2026 14:55:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-cp86A4t8CX; Fri,  2 Oct 2026 14:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F085540D7A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790952921;
	b=ZkyQRX60+ppz9fo1WmVmrhXHKHaiy2ZzIBaWgwrCp7/kM3pdfBDVJ3+shorBA0nF4fzv
	 usZzJ4/YLYyd657jXByCTuD/bKfm98wYf8DSRqso75E7I0/IqPdvnehikxdiP3DnEANyj
	 Tk1/SOswGE9FcNYHRL02uCkANfht+/irw13+TICkPMbY/vXmuTPaiuidc5X7vZ/epecTD
	 lnao2HwENCjnzdKJqWcNlfuuY5KIjsl1FEdSsDIw85dWglT4C+y8Uc100xe3OUXw4zJre
	 YSvPRk592iv3Xvqe73pJLczCB6Bq1O7DVOuo9nnpp9LyYmUw4krnAy2+YcpWO99NWlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790952921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/6I2NaQ3N5ouHwC4XQeFF6NcLp42ZOxAO1NbwY57USY=;
	b=TrEaiGYTbbaYuGt/R9paC1B7iNKqRLxQptVrYHYFL0kobeWLn5QtyJ0K1dSe6mf81Jgw
	 rHCiS9cF1JZO4J5/aTjROp/NzyiBeZrQzFlPbQrwZ8/k5g+J45zYmBb0V/NOc7LWxe/Uh
	 PPlgMxwmtLr5uOSyDCb4QCBypvpx9McChhxCDMCYDin0cGdw3fkIZbrwjwTRJo0vaOANX
	 3JCePMKezFL3gxcGQaodE2gYQOe4HklTVzEtTdd+T+9T9oUb0ky52BuLwXUQoED/taVHz
	 FP3XU3CsHVyeo/aqMc9dJMZw3ASci/VwqD7ux0sMo6ZW4lRn9wTrhO6R0MSCqr44p4g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790952921;
	bh=/6I2NaQ3N5ouHwC4XQeFF6NcLp42ZOxAO1NbwY57USY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bJNt3JIdoBqh1krWYa79JZat+d+fPDdm//86VKA7uJQXSlNYdoEZGHSXUE7BP8WR2
	 Ay9mQpY4kgB/hCFOk6fGlCVrAXacUx3FUm0mM/OGaOtYomTNMZIIJ8U3CDa/ARSFDl
	 9ZI8xPF81UlJAw8u06ssZQUfSin18lorRnSQOoBGzbFou9psN6q94bHB8YFdFJqi0K
	 HXSfrrN3C95MudZnygjqHa0M1knnppZk1YTl75LEP/moaHxdijTV0D/G/rjGl1Qhcu
	 PUu1veQJ1/x94k8MMoS+T08ZVM6WWmFLTKBZ8YzH9CnvtAqnZeL7gvMri8Y8dTogTv
	 RHJzqw69SYtTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F085540D7A;
	Fri,  2 Oct 2026 14:55:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 176EC34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08E0981196
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id To58cOOSfk5j for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:55:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA30181155
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790952919;
 b=PXAE5VVBEFfcR2gvPRXlD97mZ/dBmRaqP8VmxeTcGxVjU/XdyzMbhytw52j/S4dtW46L
 bb/dec7QSDaUruknKGQahiQikt3dXtYCbw5w4nfWGOkVBxDdckpl1kthQ9pgACY7P4v8p
 PXqPabau9OeED5jiMmvGqic6FbvtfEb7jB5ttSh9USAVqJKTadv7Q/hOdogipHEJ2NWHf
 l5Svdh+vVJGUQBCp0vC8c+WN3XOZY56WPz2c0dtlTVZ6stajBhrS/RPXfMQRmKrkMob6p
 ig1HxiCru8cHa7LIaWdAtRhUSs2QAt307mJZ+Nes+f3AKulUkzaHzmIRSTp17qK6YmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790952919;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=/6I2NaQ3N5ouHwC4XQeFF6NcLp42ZOxAO1NbwY57USY=;
 b=RwqBcjHi6rJ0ETINCYEeX09ZA8zICOgsGWvz/O4wFZ6RNUCc0h9EHqQr4Om1Cb83mNxh
 VE0S7libBW0oOZN+6Di0vQwujsEpiQypEMdZWugKAgfxFMfW3XF9gEqM3sOth5AHnN9vD
 S64I87eOlK2Q1pBpGr5lz0f/MqP/QCabXK4e1X9u4WBOox7Lm7dmAsjjmEzI8L0VgbeBG
 X3J1RkprwhvfA3W8xkuWcM967N9EI6BhV3/GCzj+pd+4FLxsHIl4IJKb0sUwvZ8HGpzW7
 W2O+wAWfg+gfNy3ChvGwwQ1BaAwAUw79IJ74lY3CPYH7SvFcrQJol518TkkFk38a6ag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FGSWappD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FGSWappD
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA30181155
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:55:18 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81ee168df06so198a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790952917; x=1791557717;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/6I2NaQ3N5ouHwC4XQeFF6NcLp42ZOxAO1NbwY57USY=;
 b=FGSWappDC7IXFLScEZLEGcTKMG6zLgQTUb2MhZwZEh0094DjhDO6uB4a9k+j8auEaM
 y2JRgroTomOPDh44Tz/43g4wQxeTiAYDlvBuB7Asuss9p/6Wte7cIKjrFGXAY1Gyii7b
 qlUipOLEHcoHkpfEcefP0ZTHYoEiHCVO9Qy0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790952917; x=1791557717;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/6I2NaQ3N5ouHwC4XQeFF6NcLp42ZOxAO1NbwY57USY=;
 b=ynpL9cVpKXF9dFKQpCMCfTEp6B15gKz/DO7oa96f4EDkpp/nYabEA5KNwMX4u5na/7
 HvMhVD43jkvDKztvZGBTibYTaooc8b23SaxRBKAwzM2V1VYElVpZm5G1Uot9Zsamc6c+
 bMQ3E9ys+kWTrtD1zq7Db0UkVHtfZAsIz3jQlGo021agCHNugq2zQgNZb4lW1OMTPZ2m
 aOP5/rgu/5+d2rbvBlKNPknC7J+rBkpezAIvfddffiGOo0Uqy4PqWpLtnWOW1dZST+gn
 b0ORxR/7sluvNWg2FmXJLmKQvH9TVJMngfDB07HAT4FbEudRIOb7IxeA/MrDcDjICteD
 TkHg==
X-Gm-Message-State: AFuF++nrgTmAtu5iTwwRIN6+G5i1fqmYRTjeEIGfjzBdOBNzU5+F6NHF
 zQnBRG3lCW2BrAxuTB1wyZi52HTmwngv+9DTi/G+pdbQ/aMT9Kov1edXEowIN2GxipA=
X-Gm-Gg: AYBFou2dH+UggPcB3uriYLAzJ0oYyLdmbkh8cJ/PBRAJ9ENeYaRXzQRcW1KBM+MX23y
 z9xzZGku/PvXvDzcJf1cVFVNPm0P05A2xtgj+qy2AKEkKXVDHBVMxWUPg+WTaDq8uiKr3KfP4aZ
 qFwpnjwUP8kVVuxG0Vl2hw7wzemXDfAJ53iTXQap9SpQaILL7qXqgQbCC3rt93ZF6PA2Pb5ydk8
 gvrYAbldkXRt4C/5gVUZ6pKaqyszffzW8ZLxTAzBqFCVk8RhHDQB3eSePqKObJhTqL7E75K7TA3
 XTEf/5afcx8q/lIFWE3uQRBtuZmaLdDqXl0k3w11QtChxtI3R3RCbhlov3zNXAhyiwRUuLgfiIk
 ZhfR5K/chChZtxX0WwHifv5mPKFtNPgxnSH51g5He9AFYwejGvfQoBE9S0NBUq+knjI8igeYPFF
 l6vb0q/mEo0vEhjLvk3wRLoArjkRy+MKcATbu3Jpgr7iIbJWoVaVapvYrCbqSoPnp8dryMgcrDn
 QZkQbISyxtffyivGTiqjesBlNmxiG8VaVWGJ3XIbE4qetBpx8+utu3UGoJcUJVUz1n4o1Tfy3x6
 OI9EUwE1VW8IJoGpU3qENGqMxs65hQ==
X-Received: by 2002:a05:6820:824:b0:6cd:3fdc:2663 with SMTP id
 006d021491bc7-6df3505d0damr1686191eaf.36.1790952917250; 
 Fri, 02 Oct 2026 07:55:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6df3b498a0csm2026605eaf.12.2026.10.02.07.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:55:16 -0700 (PDT)
Date: Fri, 2 Oct 2026 08:55:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Qing Li <lqing2013@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 5/9] pstore: make the ramoops device tree node optional
Message-ID: <20261002145514.GP858934@bill-the-cat>
References: <cover.1790887323.git.lqing2013@gmail.com>
 <3b407c008dafc5ebed1830c1e1e1b62d89d1aa2a.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="esGkzLQZXzo44tuw"
Content-Disposition: inline
In-Reply-To: <3b407c008dafc5ebed1830c1e1e1b62d89d1aa2a.1790887323.git.lqing2013@gmail.com>
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


--esGkzLQZXzo44tuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 04:44:48AM +0800, Qing Li wrote:
> U-Boot adds a ramoops reserved-memory node to the OS device tree when
> CONFIG_CMD_PSTORE is enabled. Some kernels register the same region
> themselves, for example Qualcomm downstream kernels through the
> ramoops_memreserve=3D4M command line parameter; a second ramoops device
> in the device tree then makes the kernel hang while populating
> platform devices.
>=20
> Add CONFIG_CMD_PSTORE_FDT, defaulting to y to keep the existing
> behaviour, and return early from fdt_fixup_pstore() when it is
> disabled. The pstore command remains available to display or save
> records.

This is not a NAK. But, I don't like doing something just to work-around
downstream (in other words, not to be upstreamed) modifications in the
kernel. Is there a really compelling reason to not just fix the
downstream tree here instead?

--=20
Tom

--esGkzLQZXzo44tuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar/FywAKCRAr4qD1Cr/k
CjvNAP0ZHafgaBU2xgUiVVqUEPSOXh0pR8lclgQDm4ohWDsS/AD+OSSFndgKQnJM
Gc42bknO9sq+YEC4PHDh+eqeSNakXwc=
=9l5F
-----END PGP SIGNATURE-----

--esGkzLQZXzo44tuw--
