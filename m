Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43256C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 759A18144F;
	Mon, 10 Mar 2025 15:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eyVC7X8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE47814B6; Mon, 10 Mar 2025 15:27:36 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA5781417
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso7506683a91.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741616851; x=1742221651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o1MJ2AScNB71admQOWAFtAi8+Y0eWfUs/WjD7r1xVGk=;
 b=eyVC7X8AD6eGhuAVPiu8kMQHU+SnpYHXGI5j2U8QBmcavFqDbIMFCUdLDaXycOQmdg
 1uXqki0Wp8wfQM0CBzSaFPTkFfrlYz6SK0zfTksDIDM6SakEYy1a41i+oeGJJip5v/Fd
 l7Ez2HVMjTCQhVk1urN8yA6QPqqgzW5eNZilg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741616851; x=1742221651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1MJ2AScNB71admQOWAFtAi8+Y0eWfUs/WjD7r1xVGk=;
 b=Dzi+C9K8ICaEYEhOUvcKbeIzJxz3QfCrehya8mLiXZytMPAvdPIUrCVDfwyicCHzEb
 ocxEMtbCvtM1Wc+w29oT5xwDPAwnHREsfIgfE+UzxxFUDx3Rbhe5XxHQLU91H/a4+C5u
 bVqTwMO4txGocqekiQg2zm9PoM6SLAg5en8YnUJlblWIS/zsotX2/t++FGA9yEgOv1Vt
 Fp2nAt4Or+bwzoqWpVSXASGy9Q6ZuJB7j2ZVMxhSQNLf6NjvW5TfMueR1bbTa2WoLl+t
 vUA3nHKkwreHlKFStRUOn1fANiIur2x2ZGz45/lRAhetMkDGkDR1r67G3/zVBCkRCZDk
 0W9g==
X-Gm-Message-State: AOJu0YzSKwHwOQItGJzRSSy3ejyWPbDsjIVT4FsIDclAncZVw3wQYtw7
 FGVIxt54/qMOQmYKONNDLFowYYhZrVKd2uXsi4buGC+mCxSV4uG9b/+0aINAkeAEA2XOV14knPt
 G
X-Gm-Gg: ASbGncv6ggKlpsuYl8p+WBMtbglQT9xOrVaVP6brrxo79sLZbSMFwDYUEcOYgKV1Rh2
 GaPKKga98NdF/aFE7cPc6Ztf3VHg96d78upZ58F98NqBoAJVz4U9XQd6IdmnI2ouNosEKaH8KHc
 M/pFRDYp2GEmCksmfGEFtKirf0sCVB//GHhZqq++k0+z9b1mWXRIa0z5nX8Q0AiA4rXPOEaFVti
 CS/kuydd/se9t85F6wkXAOxRuCG0uod4XOm/pTO/HdkbMfErBhYFALXk9SHblpt71KgGXksv71+
 u/fbzsy1DFqny15TRYDi6Ugf1STuzsaVAiBGguZ5q+j0ojAfkZ0T0BG0
X-Google-Smtp-Source: AGHT+IHEnAwyvwJCpOmHObRXaefGT2yI3KKSWng5VgdTOZbM7g8yqN+jKpOeP1YpCO9MnMr0twOD/Q==
X-Received: by 2002:a05:6a21:3286:b0:1ee:5fae:8f6a with SMTP id
 adf61e73a8af0-1f55608220fmr19062522637.1.1741616851098; 
 Mon, 10 Mar 2025 07:27:31 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126e2ccsm6476303a12.59.2025.03.10.07.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:27:30 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:27:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v1] config: falcon: move CFG_SYS_SPI_* to Kconfig
Message-ID: <20250310142728.GA2640854@bill-the-cat>
References: <20250310133647.2712374-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7MebTbcskWtPxpco"
Content-Disposition: inline
In-Reply-To: <20250310133647.2712374-1-anshuld@ti.com>
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


--7MebTbcskWtPxpco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 07:06:46PM +0530, Anshul Dalal wrote:

> CFG_SYS_SPI_* are used in falcon boot to specify the offsets and size of
> the repsective payloads. This patch moves them to Kconfig keeping the
> values consistent for each of the effected boards.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Tested:
> * U-boot CI: https://github.com/u-boot/u-boot/pull/750

Thanks for doing the move. Once Fabio's comments are included:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--7MebTbcskWtPxpco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO9s8ACgkQFHw5/5Y0
tyx+dwv/cPbyHQ1gnINOERwb1YwmY2YWS5AawpmPMGbGV5GlOP69W15e7pqTZo6S
s3r/rpXM7klvBPuNlAYl9f1/ZSZQlnYmTvTdHd81juy5CBIgxTxVMVXnQG2BbXks
a9dnTFJrhrpFs7EeY7r8BWnZaQc9lGanP1CAB7JQ0fOLr5OtlcbomP6jL/VfF7D3
RLK495rFHArReTl5dGa3MTrvsS7D5/gjm0o4hdOj2mgGlZ2dhBhsQT11v3n7qEfO
w4geE4jvbP8iQgF5YoutJ5nr2EdBKYfJ4kf9VaaSp3WySYeICoK5G6FTnJ3do7OE
7CP+588jliqI8RbE+p7imrxJq7F1gMhlh2m6vSeYRVIlvhq2SxksAq8iCMLIDbzU
rBBJDFYS1YpKIoQ6v+yHDFUkhvyW/43T6Z25MXLFps6vQ7w1bjrmuBSmJsRRDHme
kveSTP5eZ8BRoZWfbYwyqXyIqQhazcoddpN+fIAlwyhkghzL6Oe41RHRxJiefaq/
tAFZc5DF
=7VSJ
-----END PGP SIGNATURE-----

--7MebTbcskWtPxpco--
