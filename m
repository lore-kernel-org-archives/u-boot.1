Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A225DCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F6C8725A;
	Thu, 19 Oct 2023 16:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VDHWY+Su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEE387258; Thu, 19 Oct 2023 16:57:26 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5D986FFD
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7db1f864bso96423027b3.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727443; x=1698332243; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i4HpwL3BQCm0RwzEK4f32u1UJmg+zwJUYhbslq43odM=;
 b=VDHWY+SuM/ovVc8bA/zVPgnKqWyJ+RMqgyWRjVp86cbVYToyGCutYu28mapUC2pg3p
 UpA2UlZ2o4E6w8zhiNWQP2EFnAfNM4efRA5Zk6WEwKeYJMDxQ9mPv8OVfLfpMXV9HjDw
 3DKLUdrIvHVXONYuHK23jiic2uZQxv3iZAc48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727443; x=1698332243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4HpwL3BQCm0RwzEK4f32u1UJmg+zwJUYhbslq43odM=;
 b=r8pIiSlCYFDTKkNRHv3160eXc09+C+QIdQyC8dBfVBBvxXpYpGVyV9zi4GCrB2iG1o
 yeAeiCQ/fVBy7kAMAM2o58anrnq+r8SOuHrm9UxUaLal3AhB/92a0vTnr323RWj85h2l
 RjeEwpgXhQwQXhBkWk3ykFdQsEn5yNeO8jDtvlsNC4fktOkFzTLOVx/HKOCl7QrTOd9j
 TyGmg5zsLiH7pDLz6T1LjbJU0WpUnadJNRztViBPd0vFFB46x96VMHRCcKEZa1USgs53
 kV/OaOoX1Rq43bI6nQLAdGDSTCqKbJdg26oUnB7DBnvBVPebPbPwKbcgbDFwIiMHgQ+J
 841A==
X-Gm-Message-State: AOJu0YxMnVzL0Horz4m+meUtvK9N0AAFEhCHq2ubAM7t2rQ0Cwf28O/R
 l8MHxIF2v8tp9V8UELjsiW1RHI9j+gVx16CPysbeBA==
X-Google-Smtp-Source: AGHT+IF1rSMrL5BYJQ2ENvCxQOzr1gvmXNwZGkiZiTm0lDCoDao0KnCZM4rChrh0L11v+ow8Y2emaQ==
X-Received: by 2002:a0d:d1c5:0:b0:59c:b61:898b with SMTP id
 t188-20020a0dd1c5000000b0059c0b61898bmr2366762ywd.52.1697727442993; 
 Thu, 19 Oct 2023 07:57:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u133-20020a81848b000000b005a7a92a62besm2466437ywf.8.2023.10.19.07.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:57:22 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:57:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/master
Message-ID: <20231019145720.GA3119521@bill-the-cat>
References: <12efec73-ed5b-44f7-8398-a85c3b80ad17@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vTtjS/od9ew/QEWG"
Content-Disposition: inline
In-Reply-To: <12efec73-ed5b-44f7-8398-a85c3b80ad17@denx.de>
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


--vTtjS/od9ew/QEWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:35:54PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following watchdog related commits:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--vTtjS/od9ew/QEWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxQ9AACgkQFHw5/5Y0
tyzQDAv8C8G2rrZSkdZC4UZA13/VWy4uqhz9nVXQXAuuzM/obteZfpaoiKNwQd8j
Mt6dW9384EcoT60C+pEwj8TWF7yZmqK2yvTFyKdDlidgb49CfW4VvGtfjCQCLhp5
91n4VTbLTDWrFHlJYYo9ENim7Lbc2DVClG8wkuJ89xDpRF1GT1SP6cA04coC00jK
7/xNpzRhZ6wJL6q+AOGv7MOZZKYU1XUaSwwZatG8bxHeeIa7BYKYE82dkBAxbtYZ
wYcAYMQhoqXU43iZNXSflGs8sEVidMcWT3UQcJV8qsPoURKfDNnfZMVHP9vcSRGW
mIK43TaChyX7IWXeJqQondzEYuZ7l+aj5+ef2OM8PctVc/pgekYcyUEu/pbgeayy
7WenUbXxv0Switd+/Go6Re2MRa1fVzz3y+8SnUVI/7ubHduy74LYGM5h1LcmPaOc
w1nCZDSyYQDQuZQzRNUHEZtjwZkIQHBPMpkXFMmf3rsIfRdAORae+5+hOFVteky6
ldauyofj
=9y3e
-----END PGP SIGNATURE-----

--vTtjS/od9ew/QEWG--
