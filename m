Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFF3C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D960681EC0;
	Mon, 31 Mar 2025 19:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AYT4gt2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D889B81ECD; Mon, 31 Mar 2025 19:41:23 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8475581EBB
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72bd78e695dso1504434a34.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743442880; x=1744047680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=marjEWfINwkwL5adePAGGixKYFTbzTn1BK7ytVBW3b4=;
 b=AYT4gt2sYGxJGbARvbeLYnZyQM8xBYj8u8ZDGe4RvH7wOnDv6TYixU1yXzwOU+M8+B
 BwUFaOb8TiJe/PcRWRvhMYqugLBHaJgWkWAZPFNJUQJbiYI+SeRC5Ob16tbqig8/ARc2
 CTBzBD8K7i6ASgVD7yBNFOg43mXO9pRGfa6Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743442880; x=1744047680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=marjEWfINwkwL5adePAGGixKYFTbzTn1BK7ytVBW3b4=;
 b=KpHK0WSgaWJHyovm9ANa3VFO9HH8vRVFh4k6lg/Y5gfehtnH9CaqHS0EGfZnY24onC
 1GJTrWo5U2miQqj/p/5i516PBn99WKu2kiVtYW9mcqJkzXrpb5F1WQlF9TJ1PNT4+I8Y
 w003emfgdQsqqZcLuQS5d0jnRPVgnGJEMpd85CSeHyReQrV1dHTjzXNl1deK2fxqY0ZC
 fvbX6hK64D2pF32yAPMdN3Kz/iLCZsHVnZR8qQWHF/PGou4KlmnW27YNIGH8C3NimQMH
 mx84RrzAXNjEf+8JVa8LrCNRAAxM7zJpBVpc4P1mFCz4QDLlgzQOCB3LG2Ww1QbNLn/T
 q3oQ==
X-Gm-Message-State: AOJu0YyIJEuGIB7dPVbfi5dSGTbcUaeYCseWazZXUHx3LJIqrjhiODuB
 0dnZfRNQ1M89VjK2HaMXIQjo4gtVPyu2KfjdS18tvRQ+9tnXwxUbow3JQahnP6o=
X-Gm-Gg: ASbGncvJTmN8JEUHs22LINkrAtrToWTkNMfK+F9QDVdvmeFF5XNEj18wirg48VRaVRB
 n+qJ42OC+UGvkjqL1tFWClq/YAC6DXCOBLQxWSYf3EiJbfQVyacI7mafKBVbuAyLChkkZdNPnU2
 VzrDUr9rSsmWK1poZzj8A8yEw3tRwz8GX824x0u1QtTPH9uki6X1W6iePP17HO4a6UyJM4tD3yj
 cxVpnXGfFOnwxq75SAEJllzbrQpYLcaoz5ZfRDMzEPXlEtwM9mlVR0rfiOhL0k+wL4yET4Ntqh+
 zZPZM0SXzF2OmYvt3QlqGcz+EnXI2bgez1GQQ7xm/vHaIgiE6hjHYt97d1D5KNlM4MV+o7b8N7n
 TIeJzEg==
X-Google-Smtp-Source: AGHT+IFEZozL3XnmW4hp/6PXXAkMnkSqL0kRkri76Vsr9n2q/vdeex4MeLNWuWTHT+IwyVvGcLd3nA==
X-Received: by 2002:a05:6830:4116:b0:72a:4762:d387 with SMTP id
 46e09a7af769-72c63799351mr5023383a34.11.1743442880187; 
 Mon, 31 Mar 2025 10:41:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580cd6c5sm1549944a34.32.2025.03.31.10.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 10:41:19 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:41:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH 07/17] bootstd: Fully complete iteration of a uclass
Message-ID: <20250331174117.GH93000@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qlCcCQBdEq0x8+PM"
Content-Disposition: inline
In-Reply-To: <20250319143820.2385092-8-sjg@chromium.org>
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


--qlCcCQBdEq0x8+PM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:38:01PM +0100, Simon Glass wrote:

> When trying all bootdevs in a uclass, the method flags are not preserved
> in the iterator.
>=20
> This has no impact on the first bootdev, since that is the one which
> sets the flags. For the next one, iter_inc() is used and it finds the
> next bootdev. However it sets the method_flags to 0
>=20
> The result is that the third scan is conducted without the required
> BOOTFLOW_METHF_SINGLE_UCLASS flag, so iteration procees to the next
> label. This can miss bootdevs if there three or more USB-storage
> devices, for example.
>=20
> Fix this by keeping the method flags around in this case.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This seems like a real bugfix and a fixes tag would help make it clear
what it applies to.

--=20
Tom

--qlCcCQBdEq0x8+PM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfq070ACgkQFHw5/5Y0
tyytTQv/Q0nDZ4nG/HFWeQIBz63HGZX3dOczbhzu5eAJeoXXSLQFEqPPX0sV6H+k
Mmrg493p/qNUFjDoZJkSZ4o3Fi6kGq3Lo+ZAc5sGYmmKG0amgjksO+QmJiebPcSa
Kpnxc3qLv02mwJsBMVBHeh+V8CrxuACJ3BL0V7yjgmMo5Os+uBOdP2OIhw+CCTMn
NI/3BUAAMXFetQ/njcjGfF7DnuwtL40RnXEveHfTGwuIJP2b9iXXBlS3Em6rSeti
fLtz+cmQsLDneyhxLVdl5IZbDGWZDpAZVjYzspth35EhsQUJ1n769KKxPdBK6b7d
sVYyDRqcWexi/T+8o4TNx9Br59L3NKL6TCDoc7yqwydGeNr9opidA4pcKu4OnWEd
wiKRKwB5++IfhHpUxSiUOk3TvuItM/8KpiCMxXXfOz2GENOqh9I8xaGR5xclEUaV
I6BhVTPDhnb0a7NMzzZrKx+p3iGH4PoHwsQBOstPcEv6fJve6sw5vmE6uzsKycEX
QJcKCt3H
=IvXq
-----END PGP SIGNATURE-----

--qlCcCQBdEq0x8+PM--
