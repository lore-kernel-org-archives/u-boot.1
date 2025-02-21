Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7E2C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 18:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6756D80EC0;
	Fri, 21 Feb 2025 19:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JvR9UHnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B1580F5C; Fri, 21 Feb 2025 19:11:03 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD9E807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 19:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so55107965ad.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740161459; x=1740766259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eate1MzJRpPSNJ5tBe6QXsN7QnNSmPsrJAB8a4nI3ZQ=;
 b=JvR9UHnzkYt06TeN7QUpvzsgy35+yR+Wcd1flzO7EGMw/3ApiWYrz4sWRrNa6p+9hH
 MvJRf0lpM+DUc5ln2aOHemHIyZ9F4XF+az3X9GvA1pHNQ9pZ3CJet+zv4SYAfGPOHrF8
 BJzMrn7t5zqCs/XCtmslFtJMgDH/m286CHH/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740161459; x=1740766259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eate1MzJRpPSNJ5tBe6QXsN7QnNSmPsrJAB8a4nI3ZQ=;
 b=PlkVtaD51mTjercHTYaCtJ29Z0xIvECBxmyCK+M40celp+Gqn7rFNsK3ad81gAjF5Q
 SP4zpbisIMqhSi8ID+pmgl8xFlnf/j+HcYS6lyoX8dO7iCdyvDU3TEkuUjgfIHB7M5VH
 M2jj67pB80i4yEujffGtH8+pKhtyTMm2pt3PJBrphDCdGmVBTuZU/graxfVoeGfJjqA0
 gCTl/JpGPyPFSbvZFVKpLJNRpyFoHGCg8UTZnH/olytlLlhdvqLw7UKO6Wgg+XQ1/uoC
 0UfxWElsQEPmXpnUGpDeh56jSaaVEbI+30iT1aUY2Z4HSg7mMKVs7qF+HbKICOGAaFNe
 y8IQ==
X-Gm-Message-State: AOJu0YxaabfUNps4C8oaEvVBicHRYhhJaE56ScAK4oGNthiqHLbBgs1m
 ihan8/jeJwvcx2DdtojgRsdbFsIJLcAHDi3xy9xNpKsEOeBCwK6tucpjoXfnTDg=
X-Gm-Gg: ASbGnctOt9wwhkb7CecgnhPs0K3oKJwP9LVeozX+eD6p7dN/4M4/vHLXpCuf1BwxWFw
 ccZD5QmG2e7sVZWC47aCAi0wFrJrjJaUqP7/fSsNFPzpivO+I13761b+Glp46/g2xfj8HN1tjop
 47fvMPIz8fIwVRhMbtjcDoli048gW/3KS5HwjRLpIYo5+iDpCte0bEQ+0iV4nQL9t39v0ivYE/Z
 3ds2ehvl75BG1qXlPrJHVaZfjqqglVRnKAqXime8+y4MDUcUHQMeQ9mA5/raSHaXHjxq+el6BUl
 V7ZjfdkxT4CqP8h+HSU3JJtk
X-Google-Smtp-Source: AGHT+IFcwwywcgz9XH87GpNRSbZmRHvD4gQsI5gkotF/rWB4o6tfXIrTsE/YkCzMiohKqv2UMwCOYg==
X-Received: by 2002:a17:902:f601:b0:220:f87d:9d5b with SMTP id
 d9443c01a7336-2219ff5f518mr84632745ad.24.1740161458348; 
 Fri, 21 Feb 2025 10:10:58 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d55850f5sm138489635ad.208.2025.02.21.10.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 10:10:57 -0800 (PST)
Date: Fri, 21 Feb 2025 12:10:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Rate of change in the project (Was: Re: xPL Proposal)
Message-ID: <20250221181055.GO1233568@bill-the-cat>
References: <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YglQo9INF4sPbVWA"
Content-Disposition: inline
In-Reply-To: <20250221175320.GN1233568@bill-the-cat>
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


--YglQo9INF4sPbVWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> > Hi Tom,
[snip]
> > If we did one of these sorts of things at a time, we would only get
> > 2-3 things done each year!
>=20
> A project with 4 yearly releases finishing two 2-3 big changes a year
> sounds great to me. Rather than not finishing a dozen things?

As this is a huge thread already, I'm splitting this part out.

I would seriously frame slowing down and having just one big change
being in progress at a time, until it's done, as a good thing, not a bad
thing. We're a small community with limited bandwidth.

--=20
Tom

--YglQo9INF4sPbVWA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme4wasACgkQFHw5/5Y0
tyxsEwv9FUdplGRlj+GQCiViljJUP06V0BW6WaO5M48XPAmDJc1shPPrJnhbe6cr
vzH/IzJT9By61W2AgjSoAvljJS/XDKXHJNnw1SFm5p6a2rhZUGmFFzl2zynX7CFJ
oDJSGVpv5+kMSMpuYNJWn+1h30pIBIhKDGL3/Z9Ej8s9NCT9iujzTxt/OpEu+XgJ
dpEceKPzUE7M5aM8OHaDfeREZIT+gGXXve6Xa1b8Z769UwSO99AYxwP/IGLVIZwN
8KzjbMk3uuyRujr5ncPb/2OLvSxgM60wM2bKoqEj6TbWcBacRFM+B9a8syH+6oSS
45YS57BDdGE00aM7/sWnH0m6lWx+rpcEyMJIT2LrQ/IEFURpQyDWJhyqike4snAz
E460W8IUZfpq0VvCmLPK6SMrU4AG2mhHFCTyOugzbXHL1BGA5HicQdsGBO3KEcXW
GGWDWOmgDyyWSoX2BuksgGtYtrB/ig6/AQgT+mbkHJ8Y4I5Ioj65rzdrnevWpjes
2vw/dLn/
=P2Bl
-----END PGP SIGNATURE-----

--YglQo9INF4sPbVWA--
