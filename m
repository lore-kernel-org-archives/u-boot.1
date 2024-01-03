Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2811EC46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 01:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3220C86F1E;
	Wed,  3 Jan 2024 02:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HyLLqx92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8F786F28; Wed,  3 Jan 2024 02:52:01 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20AC864F3
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 02:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7815aad83acso2600985a.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 17:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704246717; x=1704851517; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8Z5MmAackw5W27AWfuJU0stQXFm+FKKhHvAI6+9rqD0=;
 b=HyLLqx92KX/e1tPRTCJcIYY9A0CuW/12QKJTdWrS6tfSlUuolkzAJfZYVNPY8PZe1q
 V+7V0QGUagD3fTX1/hP3PN5Ca+lPhINWqfc8WdqHax774ODgtSSjsUX3qkOJftRwKvY9
 lAYF/Af8LmFMgs/JS74XRaEjOpu6eK3F7KbM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704246717; x=1704851517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Z5MmAackw5W27AWfuJU0stQXFm+FKKhHvAI6+9rqD0=;
 b=MPlQlDSkSICzumZSMKhUiJHX0ugzhF7m24u1PGIvWP+XalEcOLuo3HiuAgXN5bR356
 njHj/iY3J2cGcypxPoXm3o0GexYwNVxRwxuYECCGb17Ja4nod/n4rgdzY5bdCDpIavMN
 rh2Ev9iY9bNHq/fLVdqymLDvF0oi+LfSC0qou4er8ZcZUmJbljLZfrfEJJD4x28FVMRu
 8Iu3O77hgFy2oDkDE2CrJSYXDoMXMl45WYh5u5Gb/rfbEI2qN2XfLbHTUilrVVUTdenJ
 SLyUfcNODwbpsp0tTLifhk0H/Y5GJFpM6RIet4Or4ciDgzSSntGezostdBgYZu4B1H2p
 Ng6A==
X-Gm-Message-State: AOJu0Yw66lXSni84F/KSpvc1aV1BeSjQDLMBqUeXauIGi0XbH0LATaI9
 fTN9E9mu/2TtSj6KJDZpVELb1s+0zM3KBw==
X-Google-Smtp-Source: AGHT+IEpx4cG00VZ2XbZomGuKfMLlLh56GLZnBOhJNlH/ITXgK7GRVpzTUKIgV1WsfLc9ld8Q4xSiQ==
X-Received: by 2002:a05:620a:1a9a:b0:781:1c15:6992 with SMTP id
 bl26-20020a05620a1a9a00b007811c156992mr610764qkb.26.1704246717407; 
 Tue, 02 Jan 2024 17:51:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 i8-20020ae9ee08000000b00781995b33e7sm3405369qkg.31.2024.01.02.17.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 17:51:56 -0800 (PST)
Date: Tue, 2 Jan 2024 20:51:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>, u-boot@lists.denx.de,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] sbp1: Add support for IBM SBP1 board
Message-ID: <20240103015154.GF1610741@bill-the-cat>
References: <20231220091236.1059109-1-naresh.solanki@9elements.com>
 <20231220191211.GO2513409@bill-the-cat>
 <CABqG17h=HC=Fifze+5G2kQ7x5DTW_THzNrsua8ZM=e1uLDn+Vw@mail.gmail.com>
 <20231220223816.GF2513409@bill-the-cat>
 <CALNFmy26yQYiNb0-7pFzGa3Z1gxkCb1NpwzEwX5tDxcedg9N7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zoAX9RxxNgtVTVsH"
Content-Disposition: inline
In-Reply-To: <CALNFmy26yQYiNb0-7pFzGa3Z1gxkCb1NpwzEwX5tDxcedg9N7A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--zoAX9RxxNgtVTVsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 10:29:05AM +0100, Patrick Rudolph wrote:

> Hi Tom,
> can you please clarify or point us to some documentation that explains
> the new DT setup?
> I thought the u-boot DT is only used for u-boot internal drivers.

The DT has always supposed to have been the same one as the Linux
Kernel, to make things easier for developers as they would only need one
DT, not two. For systems that use the EFI loader we pass the same DT to
the OS which can simplify life.

> Do we need to upstream the kernel DT first?

If the DT is not upstream it really should be being submitted upstream
and not just never upstreamed. I know this is more challenging in some
cases than others.

> Do we need to provide a complete "kernel DT" to u-boot as well?

That is usually easiest, yes.

--=20
Tom

--zoAX9RxxNgtVTVsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWUvbcACgkQFHw5/5Y0
tyxcsAv9HP5DhmUcGUc2aD1v+w4ySnJrca3DhTGsdaLDZXnhYtWrHuAfDFyohgDH
VwwBsfxtFiVaWXcAbUue7+1TXwoy5Pny2dBNmo2EcT2joresRtz070obBhMa2U0d
YT0WFnvxzjnwASwV3ilknKkjjylIyFFbu7+u/+4E2wDfooUOCkV8tFH02Ouoem7e
WraDRrVn2mPaSBGPoe0ZeHuv/tniPB3S6D+Pmk2ZrBW49NeJbCg7+lCfbuaecfaV
muiVvu5hteQ1Urax3njCQA161mkc14ZIBPHWvUvxjmy7s7PpOCmTiawV1IaDo2mg
1AHnBf6ulkcYwbxnS9pf1TKviY6dfEMgbzP0MBp3b3TvI6rYGqrsf2RXqUeKcXyf
G5rFA0f+/MjonccQA6u3JXiCVwsom6RXBdvUAoVHjCMngkH1jTMLWk7R/jSiIBkJ
jL6GSfaq88pkZuXTelwZ84tb6bPdbwU/U3ZU/R/oi7kYNLCmHanV7HUqUg67f28p
eLD6Hjjr
=LlVx
-----END PGP SIGNATURE-----

--zoAX9RxxNgtVTVsH--
