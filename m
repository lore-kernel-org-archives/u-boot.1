Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C03E77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 01:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1856580137;
	Fri, 13 Dec 2024 02:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h7jzk+qf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8370580192; Fri, 13 Dec 2024 02:05:34 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AAEF800D7
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 02:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so11469066d6.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 17:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734051931; x=1734656731; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ilJlvOFbFUUueINfvobbICPdZ3zMD5a7TelVdedTPog=;
 b=h7jzk+qfYPXwyIvG7oyGk2l98bmG+we8FLj9UMIy8x3HO10Ekm9ydFLTKLK78HSM2x
 Kt7s2MK+dBJJdo2e2nS1K7HySMW0+w1CCOh7xkGoyBojGBnPxnoql3AZcft+CZyfXXQq
 txYO232jQ6FHsI92HvR8VbhTaTbuTPOiILF7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734051931; x=1734656731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilJlvOFbFUUueINfvobbICPdZ3zMD5a7TelVdedTPog=;
 b=H8yBEsCPcEtUduhbbAbI9oAwKXe39mcrEobh4GKvSeqVOrJ+x8crRtNr82p4a7UdWq
 u+s3cTWY1npCs7LTFTqklFdY1WC0woGrsgM+czW3gSDeuL0Zui+eQFdZ+3T3c26RaUAt
 oxmO5ea6sYAasoBKE0BybfrdHIU2SQjEX2hFpvgxrNtkNVzxPwImRtor/8UDcrcSh3ck
 ufv87wVQRDQSm62JVUqVvkspfIv9MsAOuj1qwzFQNCcTTSCSX45FYsjHMq1cAwqZ6P5D
 Wo/0Q1PYWHOkxaZTJ/I0vKVr82HhFI7KE5ajf025B1ox069hlmNQ2FzhdnApIbTIgDQp
 lI+A==
X-Gm-Message-State: AOJu0YyQQ9YWUy0iLBp3/YwOVuDJuC4VmNut18aChyQPJ0/sUikiS8v5
 7c5q1Nqvp/OiWCPmJh0aj6VxFk24JI/pDTZFr9l+RoP0RvY+3QWBBf7MPfmpWwc=
X-Gm-Gg: ASbGncsQNPQqWXw/o1Rqb/MYi7QTOkfgrvfBYfe0eBnlHqD/0pLAXEyhUuuR8zw87J/
 HBLm48spoGN1asgYGV5frYmb1EjVbrmHbMspSNeOCyI1wdaW77oDn8a5IqavmETKe+pvEqIqkRe
 UWocRF1H4f7Tp71uyoOB5TImEO3EO+pSwmH0Mp1vO8J4EFqUDRwHezKDTPXLcDTriFd0XyuNDa6
 uc5NRIjXMXFksP3iFBAF1Ikm4a0KSHtzZFO3Q8nbovVSzkJ1Acrq8/w
X-Google-Smtp-Source: AGHT+IGlvtp3cIHxSTh/P9WixZDyCVEkqggl2foWG4/QcOMqzRjvGCOyFDV3Ji3NaAx9TRfNKerVBw==
X-Received: by 2002:a05:6214:c28:b0:6d4:215d:91b9 with SMTP id
 6a1803df08f44-6dc8ca508d7mr13907216d6.11.1734051931172; 
 Thu, 12 Dec 2024 17:05:31 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8e0e8c1dfsm83545546d6.59.2024.12.12.17.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 17:05:29 -0800 (PST)
Date: Thu, 12 Dec 2024 19:05:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH] gitlab: Add an rpi to the sjg lab
Message-ID: <20241213010525.GN1505244@bill-the-cat>
References: <20241213005903.73919-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QO8QC5U6N3ATsWE1"
Content-Disposition: inline
In-Reply-To: <20241213005903.73919-1-sjg@chromium.org>
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


--QO8QC5U6N3ATsWE1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 05:59:03PM -0700, Simon Glass wrote:

> I have an original rpi installed now, loaded with OS Lite (32-bit)
> Add an entry for it so that it can be used for testing.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--QO8QC5U6N3ATsWE1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbiE4ACgkQFHw5/5Y0
tywW3AwAoEgnav1MEMAjJrkBx2Vb0IyAO/azUFChKeXQ0fByfhFbhwn4A18yGfmp
onB/V6OV01ioc1oZ2yy5+0sevVM9q78b4EdJWuonkvjFTwORMGfmitbYaFt064oH
QKBqkhRD9LVLQAV2iKEZwL4u6m0NELqn9b9e0ea36CWKPTIAEMCSnSCbZMdNDbCn
uQCC5oQ60UqNJaySvS9Zykq/e/WspMPJKVWcfOggih2bHhGaPrGiY2m7anrXdpBI
t41XA9NzPvFhP7SfGbqCRM25IVcSFjZdi321RLU//8Ft9Nfhw2QEK4Xi5mxY981U
OI/Tk8jCvIkk2euen03Ki/560a5O1639EQ9Y3DWlZJ1F1ocdqq2XFcBhPhXvobfx
CFbD3zuRzO/iLn7TJUXRO1yWOh8qtzmxx+ElqRDUcNtuMWIzHGdmFuNolgHtqwrf
JVnDWUfQ0wAz39CjOh0UBwm5ICDdFiTY+HG+aJyjoIUgqdtxGdih8hMfBDkoco9y
pdjRDxBO
=kmiZ
-----END PGP SIGNATURE-----

--QO8QC5U6N3ATsWE1--
