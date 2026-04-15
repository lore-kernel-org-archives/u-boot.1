Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C03F4213B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 19:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BE083C2B;
	Wed, 15 Apr 2026 21:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qGqeQmJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6258407D; Wed, 15 Apr 2026 21:33:28 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF8583B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 21:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dc51aa8926so1824375a34.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776281604; x=1776886404; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Frv+66aXbtLUBQYcNYnI9rJgeRrb0GPOX1He9elU56w=;
 b=qGqeQmJ7iqm91tHz4cvI79I3ggwZz3Revpp5Dlys3PZORKuL2f7+8skwyxwnH5GLsL
 KiB4TjSPp1dfJTzKWeOqa7fmEmSxeMK4wIbBSUzwKA215Lb706jAQD1PRrDVCJyf3Sa5
 KxHcCnSUgxcP+xoLosvICu+nhbo+C1+HRPbYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776281604; x=1776886404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Frv+66aXbtLUBQYcNYnI9rJgeRrb0GPOX1He9elU56w=;
 b=RK/f6b5mCRqqkEMVNz5BroD3yDab60HSfsHN2ox4IxIZu83KsrT2DeO3B5TS2gvbRr
 S2efB3VqGqhSpBTdDdMuNsdO8POzokvWAOElEsS0Cevrfy6haRZ2JYkaRU1Jg/Jwjmuk
 58YCUnFWym2Ng0eOJT5SnOBn+B0I+bj0SHyzHSjD2B1vfWQZ+Ep1qy5pTyCgZxaBfsmY
 UX8cB1OHVdhjwm9H6Z5nKXavUSHr+zlgSyF1M6pEV+DXDRwzjcJuA0gclR5HmQSyONNa
 D+kNIubzLXnLOcCCAewHavD10VXd7729+pKYJK3kWlzeBsQPL4Xqohq99EQ/Vsvh4gjS
 /3+Q==
X-Gm-Message-State: AOJu0Yx0kqJ6TeSgUpAdzS6ZbsUo52mcBzKBoqmHZZu9d6BMw0hZ5O2l
 HfVbi8Qd4inq57nn9w8UsAaU2nR5mFs2uYmNsnbz0VN4N4m4aJzZFTdDlvWckL0eYtY=
X-Gm-Gg: AeBDieszS5/1GAViYIDDYS1Vvbn+56JCiNv2AEO6IPvqbSWvL5vlQUi6OJA1W7fDMco
 NfcDXTUt0zFQp/pg7/acsrl3EUQ+iMQIIivYEu9nqMBOEzAkv302xJsCXbJdA1HK2pSI4BkGj+2
 Qs9ZCfToKWHSPXbEMly1ngLMkKyXCvoUI4VqDx6BIUrHB5q5rTH8EAK71EurSaPFOlbYwtsL5jo
 L1KMHAxnqOaDU4La8KschbEn0YUkVID/E+MejGI65auWkgRlQxzZWx7qeT8duzElIgU4kkmyken
 qK3kmV/HnzotGbfOv1WnK1dGEEp+iQ1cx3YLT62MpgyHZI7o5Ry5GwXG4n15xSXtzO2R5N12+ve
 Tc0PWKfHlWEUJ6qfTR/uvbIjHknCfghxh8cqSzQSqaVB9gn8r76blsFqKV1Rh/JqimvB33KK4ts
 Wd2gANhlCj6knusg2LIvferk/Jc5JNzZ3gSpxJ1jUIrBcd+kR0OSsoZ7bPc1ughSja2DbQ27x5B
 qPK7Azf4SWG6l0wRVcs4sb949NHczlOTa+lDCgLzSQQkT3LWuv6AccjgbIjTQ==
X-Received: by 2002:a05:6830:828e:b0:7d7:5113:f83a with SMTP id
 46e09a7af769-7dc27e4ed34mr13244024a34.25.1776281603705; 
 Wed, 15 Apr 2026 12:33:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc7746b5a8sm1686261a34.6.2026.04.15.12.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:33:23 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:33:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] drivers: cadence_qspi_apb: Add 1us delays in polling
 loops
Message-ID: <20260415193320.GA1906598@bill-the-cat>
References: <20260312114419.21163-1-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AIx//JifsDvBM4C7"
Content-Disposition: inline
In-Reply-To: <20260312114419.21163-1-boon.khai.ng@altera.com>
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


--AIx//JifsDvBM4C7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 07:44:19PM +0800, Boon Khai Ng wrote:

> Add 1us delays in busy-wait polling loops to reduce CPU usage, minimize
> bus traffic, and prevent watchdog timeout during QSPI operations.
>=20
> Three tight polling loops continuously check hardware status without
> any delay, consuming excessive CPU cycles and potentially triggering
> watchdog timeout on long operations. Adding small delays allows the
> hardware time to respond and reduces unnecessary register reads.
>=20
> The udelay() function includes WATCHDOG_RESET()/schedule() calls that
> service the watchdog, preventing system reset during extended QSPI
> transfers.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/spi/cadence_qspi_apb.c | 3 +++
>  1 file changed, 3 insertions(+)

This introduces a failure to build on socfpga_vining_fpga

--=20
Tom

--AIx//JifsDvBM4C7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad/n+QAKCRAr4qD1Cr/k
CsXnAQDpbEaX16YCZYW+KllBsrSlTdmWkZo84JIkTeschMkBawD/WGuT8sCRWbDG
qj1AX9m3OPL52fAf3QF0hTJaGddE7Q0=
=qfVq
-----END PGP SIGNATURE-----

--AIx//JifsDvBM4C7--
