Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3D0FCB60B
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 15:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 465B883F00;
	Fri,  6 Mar 2026 16:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FV8Al4SS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEE583F00; Fri,  6 Mar 2026 16:12:21 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFD0839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 16:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso10335415a34.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772809938; x=1773414738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h+c9Typ0vqKGLlb3U5C0jjUzEs213H1LrgPC+TD8GBg=;
 b=FV8Al4SSOKw5c76vsVFEGRhsI4Ja32u51tTCevjt9kbVT0vSM173CgbwHPAVfXCqg2
 R187ti0Jc2aUpVYUdxOLQ1SkBTz8PVwXsVU6meUXUEZRMCpQ7ZnevoR6vpA4dN60Zr1O
 bhECHxgDt4+NwudR280Pl2j9H80Me6XrwcuHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809938; x=1773414738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+c9Typ0vqKGLlb3U5C0jjUzEs213H1LrgPC+TD8GBg=;
 b=DP/1vUlByj2x7pHYLUIDpiS0tm1KIHMfUbdQqQWw/V8c9gvKknYHSXIMn9vZ81mWxO
 plKG8QWg4KJWllPZYrr+QYEKI+e8wPtgdV4cmV/AAdOnX+R3OoKlu33viPvtqf/0iHT2
 MoZ/7TE2ejT/CExKxCUk3drSvrL0x4UXNApBGV1y2YVqoVBkKOMcV0/5rVo3H7dSp+Oc
 70itSepmOrPNROyNTnIFkp3vTXF4qc27OVVNRfYbhoyXbpi8RvgVmZoAHRCRmXy8BhZo
 TGRvycCKqSL6sPTN2JuojhN3E+rLbxzaS3Qn/6dcoar/YHYi+yWqTe61eBbozqOk+1bY
 9TYg==
X-Gm-Message-State: AOJu0YyfuBODGF+JI/L/4sFve6RgmWnxfreFm2/Esu/BgOh9MJHeYQz2
 fLChSWjG09cmO8hyxdXWITRz++DnmGn4FhILpEpRCdQyKdqvatp8A9BdvEqe3TxFhpo=
X-Gm-Gg: ATEYQzyDiTSLes96XgtdcUbB1eIQaV5bV1VfwPzfhdnJRx3HVzxKytC/hQRpzTBB4NM
 8P+uqhN2k825ZLEYh2or0CeN4cxrPrlektrDS3kMCbmdpI5RfKS8c5u1C39R784/P8N0/I9Kv/D
 5tEaJrElCl5+GNqUrXLiyU/wjI7YDtw3BkwXZhSQgbE4sCiHSlNL0Iq1AKDHV8tFdD7OZZ1sC7M
 UfLZDcfHCy5bzRdy8yes0vGy6BkTJARC58jiZRE3mQs19xIxUx1WFUJ6vWCCSNRwVr7E9r7TqAC
 ciQCrAVb92onk32EcXi392S/54Yt6llfsp1DTKyn9FrbbZ6MQq8T9yhNU0FXQz7l66++YUYji1/
 nKKt5VybBOqL4vdL0eRz7zxOgo5kmy7xFbnFtM+1wvCDd4+lsvD5AS64BMWZJwe6BsqhrS2F/aP
 VQcc/gHuXt+sDGpCSR9eXw4UbJGVSb9FtQBAnjAeNH8iRwwN7g7Hd/MD6wT+ha1zFxr5MfRMz/G
 4bguclRh7xtobyv4XjTRl8J0sU8kfZHFNo6QrF79+TKJxlmgCE=
X-Received: by 2002:a05:6830:2784:b0:7d4:7053:9840 with SMTP id
 46e09a7af769-7d726fd31e4mr1728697a34.17.1772809937729; 
 Fri, 06 Mar 2026 07:12:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c757cdsm1032862a34.11.2026.03.06.07.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:12:17 -0800 (PST)
Date: Fri, 6 Mar 2026 09:12:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ludwig <ludwig.nussel@siemens.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Simon Glass <simon.glass@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
Message-ID: <20260306151215.GM1388590@bill-the-cat>
References: <20260306012019.800588-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="odRJOykPtLeBRnbr"
Content-Disposition: inline
In-Reply-To: <20260306012019.800588-1-sjg@chromium.org>
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


--odRJOykPtLeBRnbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 06:20:09PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> The hashed-nodes property in a FIT signature node lists which FDT paths
> are included in the signature hash. It is intended as a hint so should
> not be used for verification.
>=20
> Add a function to build the node list from scratch by iterating the
> configuration's image references. Skip properties known not to be image
> references. For each image, collect the path plus all hash and cipher
> subnodes.
>=20
> Use the new function in fit_config_check_sig() instead of reading
> 'hashed-nodes'.
>=20
> Update the test_vboot kernel@ test case: fit_check_sign now catches the
> attack at signature-verification time (the @-suffixed node is hashed
> instead of the real one, causing a mismatch) rather than at
> fit_check_format() time.
>=20
> Update the docs to cover this. The FIT spec can be updated separately.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

Thanks again for looking in to this!

Closes: https://lore.kernel.org/u-boot/20260302220937.3682128-1-trini@konsu=
lko.com/
Reported-by: Apple Security Engineering and Architecture (SEAR)
Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--odRJOykPtLeBRnbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaruzgAKCRAr4qD1Cr/k
CrQIAP9dhwFOJMalXTrJfmHzKCnWIAdYCeQGCUFQruXruKOshwEAnN+MC353e7DW
ty4345X8kWMcKfTkw6g3oQjiEzibSgM=
=3jYQ
-----END PGP SIGNATURE-----

--odRJOykPtLeBRnbr--
