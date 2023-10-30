Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7DFC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 21:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D970887AB9;
	Mon, 30 Oct 2023 22:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nVSnEuX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A5E879FD; Mon, 30 Oct 2023 22:36:07 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222A187AB9
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cb76f3cf0so31947521cf.2
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698701763; x=1699306563; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yzjPwUKQTa5W3JGgTOXEalzspRZK4tz7KDuEO6oi6CQ=;
 b=nVSnEuX124W1LJIYjzYhT9F1RGggZT5ErIgwqXwXgRADkfN57wRrTZwSrmOjLmpO1D
 uQhLJV98jvODkMDNL+gEVtv+hdCR/VYJXBifuDs9YCZ1qOhSIkUiwpPT3yAaELUW+dV+
 7GfpdlHnCYqoMmRpcA8+KA+b+EHAtT/BA1+Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698701763; x=1699306563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzjPwUKQTa5W3JGgTOXEalzspRZK4tz7KDuEO6oi6CQ=;
 b=J4mPcgBXUtoJ8yTvHdAqfKVPsnJ3qaBhWC5VDPOx7IT3c8g1Ch4MlIR+8dIWlEcreN
 fo5S3+ywa5eW3h5QRFP+RrKG0STScQKihgGtQ8z0lEALP26WoDUtGXp7gPDwsM98yTh2
 Afp86niLfGHZPgqML8UWqBSB7CyNVxTVC4O1Y6hV2GzunU2cXNa4IJKl9JpnObZsTnGY
 GNPW62IN4uLa5dQJjgfZuG7DxYku5/EZpTG881xcI9p5V/AiYQ5YO05fGPhfLIY4EqJg
 LeTwusKpNA4p08/InGtb8RraQHEjMJm9Gbr8mcSbSjGoyVTo3B+G6sHAKfUYO4xYh0lC
 R2Sg==
X-Gm-Message-State: AOJu0YwbCq4rlMiinxz17fpekZFswiktGQjaEab0ohdJOOb5tNhDG3/b
 GhW+B1IGGNhcr6mKIz/PHuvZfQUEw2VcYz+vN87+5A==
X-Google-Smtp-Source: AGHT+IGYDNzxBX1thzD2wxFF0kqGk3NsC2Xc7ZzFKZ6VHa8X29yRh5F3k7Fz7sc/RPcJabLWBTVqCg==
X-Received: by 2002:ac8:5a45:0:b0:41e:37f0:8b66 with SMTP id
 o5-20020ac85a45000000b0041e37f08b66mr12614924qta.35.1698701763551; 
 Mon, 30 Oct 2023 14:36:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 kd13-20020a05622a268d00b0041cb8732d57sm3729654qtb.38.2023.10.30.14.36.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:36:03 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:36:01 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] get_maintainer.pl: update from Linux kernel v6.5
Message-ID: <20231030213601.GD496310@bill-the-cat>
References: <20231028165827.3305310-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mSV0PdKLBn42EAFf"
Content-Disposition: inline
In-Reply-To: <20231028165827.3305310-1-trini@konsulko.com>
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


--mSV0PdKLBn42EAFf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 12:58:27PM -0400, Tom Rini wrote:

> Update U-Boot's version of scripts/get_maintainer.pl to sync it up with
> the latest changes to the Linux kernel's version of the same script.
>=20
> The last sync was with Linux kernel version v5.13-rc6. The commits to
> the kernel's get_maintainer.pl since then (starting with the most
> recent) are:
>         11fb48961e52 get_maintainer: Honor mailmap for in file emails
>         26d98e9f78da get_maintainer: don't remind about no git repo when =
--nogit is used
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--mSV0PdKLBn42EAFf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVAIcEACgkQFHw5/5Y0
tywrvgwAtnPrFHct18OjdMjEKszpMSikmfGtaEkr+GBm2Jq5aWxAZmDy7wS04RoD
spEYAXjBz9HFg/sUl9CK0EwQvrWxXMQYzK87m6NDgFEFA/IPCxKKsQkHcoqmyiW+
kQXZ6FFZBYVyE61+SUIuT8UzY3O3dkriZTUhO7kSRUFqqrOB/QD/tN9iX6KtjMbo
NUmeRNdbpY4Xoyxjl7+nI5fZWr+0qKd8P4HkcZawwKb1JAYlinfVNUTsc+a1wTos
9+7dJcDvvg4l7xjKSIZk7tjBWID8DaWtZApBH0x1jKjYdyxtVBxuztPPh0wLTjxj
D3Q4yDxbMo07LOFOoN8JrpV7VVSByBx2Q1/tmRQR4lj+FNpU2F0TkFomrUhQMF7/
ScdhuoQbHX15JXAYIqwTWaoCSk8qALtsUOEN1t9LAEnA+0gC+pY6OguiMzzcahDN
4xXBPLgqH0NYPUHZqp1QelvhJtnXtI+SIEzfvevEiQZ85t/GFo8rZgtRG2FO2/8d
9+nnJyGv
=eWuX
-----END PGP SIGNATURE-----

--mSV0PdKLBn42EAFf--
