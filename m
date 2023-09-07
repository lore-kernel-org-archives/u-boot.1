Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4764EC8743
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 17:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010A086863;
	Thu,  7 Sep 2023 19:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LFM78giY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54417869AC; Thu,  7 Sep 2023 19:08:52 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467C48620C
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 19:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d80199061fdso65417276.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694106528; x=1694711328; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mnv5rTIp33PtAFc1DjAwid/uoML9tDThU+5tzsXmfvA=;
 b=LFM78giYbLMRrAuozSZsfQ6kEk/mLE2qhsWjmk6yK/+vKJFgOJmEORMBiECbpJT7os
 kEqlgjz2br3t/ApOKJHNzxqN5TuqSkvwQAvSd0fA10CsoKFv+G9hFgQmNZYBVmK4kml7
 jJxW5Ee5qEOHwWqqDeWKQlFHwfiYdb4w/anbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694106528; x=1694711328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnv5rTIp33PtAFc1DjAwid/uoML9tDThU+5tzsXmfvA=;
 b=qKLsbidaAUvAOXpVSlG0v2W91P5rjWX314x+oRJB8kcvXHYpmK9Xlaart+KsNsj8Iu
 +FCCnh23LDyZVp9FRET3Px7aka+UurDv4vmaRReHEthewvXiVHOI0aHQrQS7wiAMdwFl
 hPTVRz9mntR2KoktmxeKnBg80Zi3J3AOOyiGly4wCTkkIWHWreGCRvUemia0GB5uKE04
 WqxyWRi2aKJh1n9Lqcs0+lCWI5nRtgXUWz6ZMqwmXtjks2l4xs0KXbah4rDap52VbfEY
 QJU1iXqcXLfC/DKP0cmewamwMCmTf9/rrgzCosFQZtpjyf9GtxHq+TobClUG1z/ZM2Jc
 NiKA==
X-Gm-Message-State: AOJu0YwWRmN51rZIbhH97DBdHr4TbDLYJHR5P8+OQkBJDq+RycCqtFXO
 EN7AISmJnkMZewTUbhUYtsHD1g==
X-Google-Smtp-Source: AGHT+IEoO2Id+FOqBl0POqWM76x3aATMlgy+FOzhBY20zetCKdOM6qJt8vLZrvDifI/6ycpV/LzWzA==
X-Received: by 2002:a05:6902:50a:b0:d7e:c920:9818 with SMTP id
 x10-20020a056902050a00b00d7ec9209818mr14489425ybs.8.1694106527894; 
 Thu, 07 Sep 2023 10:08:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25bfcb000000b00babcd913630sm3719002ybm.3.2023.09.07.10.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 10:08:47 -0700 (PDT)
Date: Thu, 7 Sep 2023 13:08:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/4] buildman: Keep all common output files
Message-ID: <20230907170844.GW305624@bill-the-cat>
References: <20230907160023.49339-1-sjg@chromium.org>
 <20230907160023.49339-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rrk9jp9j/0dUg3R+"
Content-Disposition: inline
In-Reply-To: <20230907160023.49339-2-sjg@chromium.org>
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


--Rrk9jp9j/0dUg3R+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 10:00:17AM -0600, Simon Glass wrote:

> Make a list of common output extensions and use it to ensure that the -k
> option preserves all of these.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Rrk9jp9j/0dUg3R+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT6A5YACgkQFHw5/5Y0
tywJNwwAr0ZBRSjPGtMahPBbO8Xl1LnhMf1TIuBFWPWN16B1xYnVDhpYI4I6z0fH
vJMuw1mwktRpGNLTr13plFRD4L/hdKaFvKdohlOgvKWUJQNRe/FN1ucqsDxDTcM6
SK8jnpLjpEeH7n+Gl+crFq/hpzRGfU6N4eB6eA2gAorrdvcH7L77lSy3ojerwRGe
Wt7ODKxmNwo81IHj37lcRw1qGFfCUtKeJ4v0Aun+w8U0jnEDlPQPYKK4GQ1TaiwH
36LDON4tOT3oXIvRBiAHvCRi92DnOMt0wYalfPQOfd7XPOuyfNMXUa51z68I04To
6AiLWPJ0XsNn37nRIttYecwh2MGKPPcNW0YQwWtDqCJ9ZYEYAB2i3EOqEZjwEVhG
VS8Hgl3DDj1+1gFEjEXtIzu8OhXdNjh+/QQJ3VHRUBfFjGiaI5yvn0fJ8hIf0KCI
0N1s0DaNIveXKtumoZdVSWvKDcw2OwcHcP8GKGlQFXDoysHr2DnIgmxmqQUA3MqX
RWomAuZ4
=9Ndd
-----END PGP SIGNATURE-----

--Rrk9jp9j/0dUg3R+--
