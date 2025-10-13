Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269A5CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 14:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F5B838C1;
	Mon, 13 Oct 2025 16:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yzeefi3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9E18391C; Mon, 13 Oct 2025 16:24:21 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D157836D2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7bcfafec537so3400832a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760365458; x=1760970258; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R6voPQ9P0v7b+yLUEFe1pQpfurJW7dqjUHHKKBUWjcI=;
 b=Yzeefi3lSxDb0MfI+fOtxSYBj2XI7PpDXg9uKkYjTEeVaHPxaYTDo4nKEoREPbUqKN
 ne3cP18NCzlPCQqcvyXBvfiU9Co3tUMrpHnU9Cn7/ql6i+4+v+plRYOq2ChdDue5bWWb
 PqZDfVqPo/r4AYtJwtA1tIMYqsCiTw0IZS3t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760365458; x=1760970258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6voPQ9P0v7b+yLUEFe1pQpfurJW7dqjUHHKKBUWjcI=;
 b=u00Cn0vRTUZqh6i2x1YbANxpH7dBucI1/Nn1QR7CB1j24agyIKaaZlbszfkGrDBSQt
 wF0UxI4ZB/7XZFI5Hx/xeglRyC2azt3UU+P5T8Uk4Z2nZjfWNTDhflFj4JfkvdVQ0RDL
 AoOL/U2m3/KRwcYCK3k7iGl7dlfMwWPV9aJqUA+YsfeqqB3dBWwZc+nA+BhD2Xn/Mey8
 ZYRyLSJE3mluVJqESJIfNJ7iNuqk09fTfe78eyBo1ya+R8oXGs01wVtjB8ZnNUNp9kBs
 Yx+G7Hv8TYf//Kwyh70Z/IW1IWvQCA41iC0XxCIv3mnjt16fLOWmA7xM/jrpWA/0reNg
 12fQ==
X-Gm-Message-State: AOJu0YyTMh5CVFakFJc1M+UBsuu5A8/jWBWpHmC7xg8nrZAXuxgR7rFq
 gphOyJrcCCnCfhjVisZpfhF3nM+u+izIbAucmxucqxN/Tx1Tq9cpx3LW+120X7hVXWtdtFhNaIp
 Jy3yrLzM=
X-Gm-Gg: ASbGncselsyf2NTPAjQizb51WzHvBQI7Pk2+97BLRujwFFeqNH6TEtbqg3ykOBRH9VT
 Ahy7pCldzsvlyHtVEcevi4yMiFTSHkmJAzj3k15syxAhIOLNMHGee428moCYC/1rpI/u0O2vzYB
 EraznFDGvYw5QQE6OmyEOmyGiYl/bdZdDyzIvXl3gxOLJEWYftOSyfX3InwdBDXsWaYtqdYge7D
 vMii2yqPwZalA6m67Q5Oj2KbGRAeL165BfFmTvDg94yDVWMXSBI5neGRUsHHKLhe+17MfqpPrR6
 7XwttN9hxc+OH4Jottc9arP+XpvsI63O2icvw1WGOKmeKO95picXaw68mZzvbxaGmQ7F1vNEpe3
 6V5/N/b++vLTytdXlejli2BF9MFSY1uHhEFGgkpHEC6EO0xe/FmU/aEmsXiGg6gVQ4NL9xWwUej
 YigHe5SgGtEWZKOteaLjIIbZ1+jw==
X-Google-Smtp-Source: AGHT+IGd4w6xyFyri1Cy7CUTpu3JR5cnmXocgWbGSxzhLXL+aV+rZBwiL3hDZgcYDco/czEHnJPIFQ==
X-Received: by 2002:a05:6830:380e:b0:799:bdea:347b with SMTP id
 46e09a7af769-7c0df6e4040mr14530265a34.10.1760365458079; 
 Mon, 13 Oct 2025 07:24:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f915efddsm3472924a34.34.2025.10.13.07.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:24:17 -0700 (PDT)
Date: Mon, 13 Oct 2025 08:24:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v5 1/4] boot: Improve comments related to global bootmeths
Message-ID: <20251013142415.GF6113@bill-the-cat>
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qlBLsex4H1GtIZ7Q"
Content-Disposition: inline
In-Reply-To: <20251012064412.2892979-2-sjg@chromium.org>
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


--qlBLsex4H1GtIZ7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 12:43:53AM -0600, Simon Glass wrote:

> Add a few comments about global bootmeths and first_glob_method
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

You don't need to resend since b4 should pick it up, but you missed
several reviewed-by tags.

--=20
Tom

--qlBLsex4H1GtIZ7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0LjgAKCRAr4qD1Cr/k
Ck05AP9VLm9pkZNNvEeMXbrW6RTLqTw3EoTF57oRgEqYPDvDpAD/dTINEkjJnK7E
mE2j9tznEAFtdZpND4zL5gaTw3M7oAg=
=wf6a
-----END PGP SIGNATURE-----

--qlBLsex4H1GtIZ7Q--
