Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1E1C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 01:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D70D488536;
	Thu, 18 Apr 2024 03:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sxjeqsve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887CA8854A; Thu, 18 Apr 2024 03:44:48 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC2688536
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 03:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-434c3d21450so1412881cf.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713404685; x=1714009485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fJ7b+7SEwpZ/aSjTUINJoRCsbSjEygJiPxAuUG1/73c=;
 b=sxjeqsveeaWJbXNCDd13oFItgevEvnxcpCZ9da5jRc3TqH+l1K6q/xRTTDTymqxfsu
 yr1jSjC7OEI8+q344njNPgrnjmE70h7j+SUK5v99IYitJ4WuU8IBgOc6o/+Dr8uGj3Rw
 j1Vy2z1ZbS7hbipHE9N0oayTV8HmBDGO4hf6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713404685; x=1714009485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJ7b+7SEwpZ/aSjTUINJoRCsbSjEygJiPxAuUG1/73c=;
 b=TkzWFyv15WdK0+oNUhLEs6POP597KCcqmEo7nrmv1Bs6A85X5ZbmbJoYcpDu7CyEQO
 er5AhnQtyVolpvJ3IsIGCRQVjw784W7YfFv1VpDY1Gix5fVZLG15x4BeNRGSRfWckzFV
 bBrqRfLfnopYTaJ/48983GL+vyo5Xo2MwOLAC68sWzjZgg2W6bHTNkzPru2BHc8Igcp4
 LSGxrWs8YwwGsGljuB5Dv9cvwj3JhVpSobkDRG+6bZGrkIkg8d+zgikpVAbuDqI+Bf81
 3rFUcHFGaWJFIcZD8Qyuf7IObfGbyzkkF/tuv8k8wEgKyKIb8S03O4LFUgO1umgZKCJh
 S2SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs9YGtO1j8A/nyt2v0d30a0QeuuVygCzFbDdqtz2eD/oSl36kZCKScTksUWG6iLYEuIOMVQXRo6n12/5eCPiGGSNVpGw==
X-Gm-Message-State: AOJu0YxqU9oQQo4OSZVFZOFBzQsl74xDGa/dGOSsFvySVjz/aFOPO7Y4
 cMlhdIt8fP5KGL3633ALaMGxaTBX33kPieH+6wxChtrLqsnV+DxsuvY6GJ5SN5E=
X-Google-Smtp-Source: AGHT+IFQV96AEQhCcJEpy6mfse05OjmQz+o5yHcsKQzKhPwyYa/1qB9x4KtI1qNoXnSA62ENu0wQQA==
X-Received: by 2002:a05:622a:15ce:b0:437:9c6c:aa4e with SMTP id
 d14-20020a05622a15ce00b004379c6caa4emr673104qty.31.1713404684991; 
 Wed, 17 Apr 2024 18:44:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 e16-20020ac845d0000000b00436e0261c86sm197912qto.45.2024.04.17.18.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 18:44:44 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:44:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/2] upstream DT compatibility
Message-ID: <20240418014441.GA1245703@bill-the-cat>
References: <20240409-b4-of-upstream-build-vendor-v3-0-f096de0c513b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0WfgigJlTYljEy2i"
Content-Disposition: inline
In-Reply-To: <20240409-b4-of-upstream-build-vendor-v3-0-f096de0c513b@linaro.org>
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


--0WfgigJlTYljEy2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 04:49:23PM +0200, Caleb Connolly wrote:

> This is a subset of [1]. With more platform maintainers switching to
> OF_UPSTREAM I didn't want to get in the way (it has also proven more
> difficult than I hoped to remove only the fully compatible header
> files).
>=20
> This series removes only the dt-bindings headers which contain generic
> data like GPIO flags, input event codes, etc.
>=20
> It then implements support for building all DTBs for a vendor with
> OF_UPSTREAM_BUILD_VENDOR. This removes the need to maintain a set list
> of DTBs that can be built by U-Boot and opens up the possibility of new
> boards becoming supported "by default" just by landing their DT
> upstream.
>=20
> [1]: https://lore.kernel.org/u-boot/20240321-b4-upstream-dt-headers-v2-0-=
1eac0df875fe@linaro.org

Currently this breaks a number of imx6 platforms starting with
aristainetos2c.

--=20
Tom

--0WfgigJlTYljEy2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYgewYACgkQFHw5/5Y0
tywM1Av8C/Z8cW0LpUgbUG/DYHEwKpT7f0Rc8LeNFCGJsx2WDKhsBQvvP1Njq9fi
Wony396V5fZ2SV35gEP1pKWQRYBMYofwW71gdENCTId+kbFr6IGpNT3NRFdpk9j6
O/CacujBadN41Kh5hgp6ocWoAGu8/IHvjjZGFQZsJHlhISY3FhrBMdD35nWScEnn
49rfUCCR5l1prgy9EF1GszQHo/DQMfLSgt8g8h9gXjtq1UtcGWkGdLUCamshWXMc
mT2hwimQ5DJ1Sf98Vs1r69DtGjGcHDnQapRcEIBvioBbspYlRSAS5760X47IqSSp
P0HGNNYH9n4cooHD21Yg+4MosTCeAbS4ATauJRfvpy58U3GYloj5U5HXuZHX/f8Y
6uMOThEfkCJuKB/lZ4gnCzIrRizmblGepz/4Ftd/kL/+Hp5HA4S42Q9M3c4OA51F
0xAa7k8FTRygiYU/EDqRZRvu1OQF/i449T5m7Dzu3Wl7ISz2/ANpu+oDmmXeIDfj
fEYeF2by
=KojQ
-----END PGP SIGNATURE-----

--0WfgigJlTYljEy2i--
