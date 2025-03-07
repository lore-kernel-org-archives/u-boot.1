Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A7DC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 14:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13A180F4C;
	Fri,  7 Mar 2025 15:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F9mcpAh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F02C1803CC; Fri,  7 Mar 2025 15:22:56 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67E1812C8
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 15:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f768e9be1aso33483367b3.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741357373; x=1741962173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=maR4v0ZwLC+w1Kkio4nrZIv14069jf0Vl83ie9k86tk=;
 b=F9mcpAh4rZW8Yd4U0q8eyqXna2Ot91+yKDr+++25YFnFOMTcu94EzsHnm500IbNKed
 gOUSIEKoVDf9kmi1o57CMvKpGATaQzSx4W0Cm6gNNtKo2OmC1TqZa5zTa7asFZ2Py0aP
 VfKSNxH2AR7QahkjMRPw56LWKWmXa/Yoehz4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741357373; x=1741962173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maR4v0ZwLC+w1Kkio4nrZIv14069jf0Vl83ie9k86tk=;
 b=MBQX9hi3DEbKZGscSZm0gGD2Sgq9inxxby8lsXBTusVKMBYBXSYJNEOls1hbll7ig2
 xELacA19/bYQmQfcmFNnyr18aaiUx1n8yjk2Av0USUkUmYbcXAZ+Yln+F5TGCmzi5yNE
 St/8+HYetsbRIurdWuAA+D2TNYfkr1B1zSeSRmEt6u5/CC6rZKqGO9ZIcrumeUupiqQw
 p34S08cG5msQkKFAE6nP1BcrDoe06MWAju0pqY9J9yWZK3IEvBO6oEY30LD62d6UqPX/
 VoGMVoon7ZUomPea3mQpeukLLLWYUkfmLh3Qy3Jmto82hfzZi0xh0pzzV0l+XFw+lBw7
 +MPg==
X-Gm-Message-State: AOJu0YxRY4OtWKGO03mRUvSYTveDOnNFzI1uqHdYdBAgkp4z/6YS6x69
 Rj3cvZOkdy1vr1GXtvGaPIM49qGFvLCoIkJ4eOzoOha7qnm/uUJWeUw7qUXRHxoiWxrwhxYHug9
 p
X-Gm-Gg: ASbGncvOBV5P0N1olQOXPnkNaHT2iGoj7tN6AzgF2oOYdQu23yZV4scagMDfs9K9x6p
 twdQN9GtqFbTVuQQyql2V+8yXJ+SqjZLmGlsMjO+GFw/iiyB7QOzsQYabbSiwofWXH3jCfLQ9JS
 5Yx3aFZJ7y/nlyPsOVar+JwBNWyiP9Da8PD76VR+v1SZgH3HGEorKVDbUjeapoS1T8TzzadmgsG
 yx0Dkw10get0xcpnPmqxRu97BO3mKNXQVcmYzAcAKu6XL52SVOS7sz80wDULMwWADF4ys8gKp4N
 z+0GEUCKiATwEE0QheusSKBStQehwL1YTQXK5OvevWjffQ==
X-Google-Smtp-Source: AGHT+IHgLl3QYPa4wzPlrjHMBeBUElAnj3GqJIF0gv6c/5kJaKZCrXi4xjnd9MK1uWqdVGDQC1yFJA==
X-Received: by 2002:a05:690c:8e09:b0:6fe:c2b4:f099 with SMTP id
 00721157ae682-6fec2b4ff57mr29676107b3.7.1741357372153; 
 Fri, 07 Mar 2025 06:22:52 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a68101sm7547427b3.45.2025.03.07.06.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:22:51 -0800 (PST)
Date: Fri, 7 Mar 2025 08:22:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v4 01/47] boot: Correct ramdisk address
Message-ID: <20250307142249.GK2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250306160428.3041057-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1ocKeERv7tjl1f1Q"
Content-Disposition: inline
In-Reply-To: <20250306160428.3041057-2-sjg@chromium.org>
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


--1ocKeERv7tjl1f1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:03:28AM -0700, Simon Glass wrote:

> We must use the ramdisk address for the initrd_addr field, not the kernel
> address. Fix this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: e05cda3004f ("boot: pxe: Refactor label_run_boot() to avoid")

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1ocKeERv7tjl1f1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLATgACgkQFHw5/5Y0
tyw73Qv9HcQuWN24+xVhWvE7MAG7RvmiIwozaPe95qAHcRpUm6UJhZzzJhmf9t+k
/+RT5572pMr//Y0Y4bTJsgpTaeJtffmAV/V0QSuLWbk6Yy8Wo6E9cpOSWW62m3Mv
Dslej8euS0T4auW0Wz+f1VI048sgmnUbeS7R+HNFYLJqTspucNNAQZI1o8iuPb+v
FG43V47/FxLfOjPHBq/b5W+OCoQzbJ+fzfDzIFkf8GZWXnUiWRob5VkhChsRtIh5
gLprVKHpDZGqvZw6/cZaOfeJTdOYmg9a+PVnR34hlNSZpPF05WBfqtW7X9hsYg8X
46hWinAosWj5ebxZ7ocvExLohS7Q8oEhEKN74EiQXFmWrubVQ7nL2U9upvUYL4hx
vcMHrPm5/jkZNW5VnhDVvpw60XosiDxvnRrnK4FEQXae+UL4TjzIcw1c+91XM9Ec
qrYkWYxCQTiIhbb9B9BGh9fsR8HChMNyMYqa5W2YxrXIKilXE35P+cjSJDIeT5ed
HcpHOzUw
=I1xF
-----END PGP SIGNATURE-----

--1ocKeERv7tjl1f1Q--
