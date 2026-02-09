Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15582E94605
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7524F805D7;
	Mon,  9 Feb 2026 21:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EAh53+Hs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF72B805D7; Mon,  9 Feb 2026 21:51:32 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C7380325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d18d9503eeso150848a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 12:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770670289; x=1771275089; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9Wx5X3fpZhZuiqLTXyNIw8xlEnoDKpva7uB5Wvk2LY=;
 b=EAh53+HsA7RASUiJ2FunRCDXTwfIyLcdWgOlCac72QGzMh0krLRyCu5jrUQWb0vjpc
 hZHD6AiEKrOgrVprDEUnBoMed1vVpMPKGpzz2+3bM6cP4d4G+6gIptTkMZl5Dbfw96fa
 w3eVlQOJJlbFfl571yrXs68r1Zxci10ZfybNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770670289; x=1771275089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9Wx5X3fpZhZuiqLTXyNIw8xlEnoDKpva7uB5Wvk2LY=;
 b=vFfdw/dhyGv2vvmABNDsnsJeiv4oy3sCJ0emQE9wIfon1tXQ44njrIedGZNzDBh+dp
 co9649rw56gTB7zmrtDo4OB1IqyaypskmlthKWKISvng0cgwPzGREBU9+2sJnTVnWZJq
 l4FyQ55KWb0PxT+8NT644+JK6fVhLC17Etx6GLliikPIbQpTKCQh3DhcXvXbfW02QwJD
 +TbiQiNobCH9hLUc1EcRH30Vl3Sg98m3mKy6MHjsFGupUiZ5V+Ua1HKDDoVRpBxabfXI
 totF18W6o3qv4o2u6wLLaEckSeKZd5jqP6MfBuqjNHWf0zN/C+m0WTJJORWekFStrSj6
 +lWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqQYDClMKCZFVBTzkGIvWwAN9EHbEaUD6uY4qJGByD3836nPCPUU6Ym83O4CnxDQN04mv6iO4=@lists.denx.de
X-Gm-Message-State: AOJu0YxcZ3JawFAsjYFnYRwqU9KGv+MRhkXJnvXzg3yocOzpZm4ZFJ2d
 bZvhyBNBYWTQXYy2B87gIvwzlx3aUvkQk/8AFAJSU3m1Bj44+o9jLegC9jLd/bAACwvLGmv0LzH
 iqmv0FWk=
X-Gm-Gg: AZuq6aJi+UXOddfWfYYLYYeMA39zKrOfrJRA588Skqnk65kV8+1DCxcX0K7/YzlLapJ
 6UjvSsvZevh6GbW/2PER5d/XDSgG0P2UMK/gw4i3bCvhyYAHB1BR9zjmA8fRt1QszBOJe2E07TY
 nyKYXga497lzjdxQfudXM0Cuipa61MwkSyczAJQn2sl1lcuVIJGLvDEPtO2SLMWSoqAMmNJbihE
 f5zmWX/UvliT97A/co7epH0vfghJ1xh6DMfmYzO5mxh8fsly1IgrsIWSQ+MckZsuk1wqH1kACA7
 oy8v9/aZBiaVV9ZY8bXZwZfygFCyJiOnzIC2emFmnZ0dfCmZLA1sd8nGIuT7kSV0qMW6neD2e60
 JKqY2P/gDpyBCLgkElCT1lmJvlyf/jLCHNElCR/SbvqQycBpL+EAJfe65GlTmG3CjKoo5IJV2Lp
 MVe2aZJFSEgDdwRkpsH/yDs+QSrSPUHrFm8T0p9zEQQjhnqpa0RXhtXUXXow3SJnNBoAR5lt7zF
 sqzrs3X812k+jD2tKq8vRR1kYaVmN+AXU/TMm4=
X-Received: by 2002:a05:6830:6517:b0:7cf:e4e6:2cb7 with SMTP id
 46e09a7af769-7d464695e26mr7418208a34.34.1770670289399; 
 Mon, 09 Feb 2026 12:51:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785fcasm7936653a34.17.2026.02.09.12.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 12:51:28 -0800 (PST)
Date: Mon, 9 Feb 2026 14:51:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: core: Use IS_ERR_VALUE() for ref_clk rate check
Message-ID: <20260209205126.GK2603314@bill-the-cat>
References: <20260209201415.303190-1-jonas@kwiboo.se>
 <9a23daec-39bf-4b2d-85af-820e015ec4dd@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nPivvGD0oWg1gAX6"
Content-Disposition: inline
In-Reply-To: <9a23daec-39bf-4b2d-85af-820e015ec4dd@mailbox.org>
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


--nPivvGD0oWg1gAX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 09:35:54PM +0100, Marek Vasut wrote:
> On 2/9/26 9:14 PM, Jonas Karlman wrote:
> > clk_get_rate() in U-Boot is documented to return clock rate on success,
> > 0 for invalid clock and -ve error code for other errors. This differ
> > slightly from Linux where only >=3D 0 is returned from clk_get_rate().
> >=20
> > Some clock drivers take advantage of this difference and may return -ve
> > error code for clocks not fully supported in U-Boot.
> >=20
> > Use IS_ERR_VALUE() to check for an error code in addition to current
> > invalid clock check to fix broken and unpredicted behavior when clock
> > driver returns a -ve error code for the ref_clk.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> I wonder if it would be better to fix the API discrepancy . Could you try
> that instead ?

Which API discrepancy? clk_get_rate behaves the way it behaves
intentionally and there's some fairly long and recent threads about that
resulting from attepmts to change that.

--=20
Tom

--nPivvGD0oWg1gAX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYpIywAKCRAr4qD1Cr/k
Clj3AQCjbhcKloHH5VfTdF5xBRVcSvEsd0n2oYOhB0b7CuT99gD+OfOJOcawhChM
Ots+hMNDIu9OonJYkycUvhHQWd78Ywo=
=4yKH
-----END PGP SIGNATURE-----

--nPivvGD0oWg1gAX6--
