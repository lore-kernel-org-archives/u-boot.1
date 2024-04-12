Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779CDC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C33881F6;
	Fri, 12 Apr 2024 20:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iO6t/3/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A9C881F8; Fri, 12 Apr 2024 20:52:19 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD97788020
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc6d9a8815fso1275548276.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947936; x=1713552736; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SgzZ5tCHlLtBNpe01AcWhZTIPSLzBNygAaLv6ixQKl8=;
 b=iO6t/3/UTBeh5MRCsOR8rHZSMPZ2sEYuVOIGJENed1/1n2SI3fw6e+MkkyjnrrU+fe
 hG954y/nu0usvxxldNt6S5F5YpcIdtG8ObpG9TAW1e8O8Y+zPGraXYiu03AngoSx0toa
 rPGcowgbZLGnhMNbkRy3PLut9rPmha5/1RVnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947936; x=1713552736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgzZ5tCHlLtBNpe01AcWhZTIPSLzBNygAaLv6ixQKl8=;
 b=AnjBajrkcLWt6VCxn5zQQosjjdAdFHNBK/URTp/0SCjeZpvJI57/9e8rFonTCur7SF
 d63H+gRRIxj7AGj6G85wFSDgQrcB213MB6ZO7yD9NlRjdsXGgTfuy0ECJyJDlxL+o/gG
 kKgB+fBf9OcgDaZe+2hYiGOPUvF1hMR0vOXOMZcgQxljhvwvUVzoNnoElpddqG9Q1Gp8
 J1xEuAFbawx2ChqSF4KS1VWy7nmmhfQzmjpSgajlJ7xAkT4Nr2DazK8duBSPy2oMzc+F
 VGq8n89hAvcIOj6YY4kMiLhfnPnbuExSkE5u3FM0bSlmPdYNMvuCG++/XDP66xLO53MB
 Ee5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMb3HIaIgexGwe4igDmbHUmAqSoT3mk7sou8v38Xxv+ObH5eL9w2oyV/iWmYcXSfevloGH8ZrHE4Ik6dZs6BP8086cUg==
X-Gm-Message-State: AOJu0YzmHGpNGPnorenR44Dd7Db1XsQEVwDar895caXMpb7VnycqaV/5
 QW6n9L6kPDzVFFB9wXyPd2ldOLd/J4i1ezcobsybcsBLJihkBa9LSgqYbbgCg4I=
X-Google-Smtp-Source: AGHT+IGSvxTqFMkjngk/TmVyvGnBaEOl1NRw0kZ+Tfp3lrd0OARcb/KIwInZC5KFjQQPOQDxKiWsJQ==
X-Received: by 2002:a25:9787:0:b0:dcd:5f08:3666 with SMTP id
 i7-20020a259787000000b00dcd5f083666mr3762505ybo.29.1712947935739; 
 Fri, 12 Apr 2024 11:52:15 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a0cfe92000000b0069b3e70937dsm2652967qvs.81.2024.04.12.11.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:15 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:52:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Steve Rae <steve.rae@raedomain.com>, Petr Kulhavy <brain@jikos.cz>,
 Richard Retanubun <RichardRetanubun@rugggedcom.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] part: Check all partitions in part_get_info_by_name()
Message-ID: <20240412185212.GS2493117@bill-the-cat>
References: <20240328222951.11431-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8RGRsZ+D3L7BqqzV"
Content-Disposition: inline
In-Reply-To: <20240328222951.11431-1-semen.protsenko@linaro.org>
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


--8RGRsZ+D3L7BqqzV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 05:29:50PM -0500, Sam Protsenko wrote:

> In part_get_info_by_name() the inability to get some partition info
> shouldn't be a reason for dropping out of the loop. That might happen
> e.g. if the partition is hidden or unused. An example of such case are
> Samsung devices, where they use the "unused" GUID type
> (00000000-0000-0000-0000-000000000000) to indicate that the partition
> should be hidden from the OS. Such partitions might not be seen in
> "part list" output, which creates "gaps" in numbering in between of the
> visible partitions:
>=20
>     Part    Start LBA       End LBA         Name
>       1     0x00000400      0x0000a3ff      "efs"
>       5     0x00026420      0x00026c1f      "dtbo"
>      12     0x0003f390      0x0074738f      "super"
>=20
> In that case, the loop in part_get_info_by_name() would break after
> partition #1, so any attempt to obtain "dtbo" or "super" partition will
> fail. Fix that by continuing to iterate over the remaining partitions to
> make sure none of the visible ones is missed. That makes "part" command
> (e.g. "part start", "part size") able to work with such tables.
>=20
> Fixes: 87b8530fe244 ("disk: part: implement generic function part_get_inf=
o_by_name()")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--8RGRsZ+D3L7BqqzV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZgtwACgkQFHw5/5Y0
tyw5mAwAqN6RkqPGA1oDKLPL0neSQbT+yqzEry4oaMHjYZ6NzgFE4HJ+PvLg+yJx
8GJZVOEGs6DQ11O2ZhZ5Cvmk65piYG8bLe+p85MPfHxl4HtUpegJctHxbWCqF6lP
yV7nrmIM7HVYvspxEK9iD5qyo8qUue/5hg6rDaOf4x5ALPBOEe2KgP+IxSWEnjsp
xItpI13sc2gxRE+7aQIMnv2VZ30jEkC2XSTZankjmkOe3CgOG7xipm6Q9eA5XYXy
528P8PsnQwhJT1I9AoEuLF2l2pmxtKjMB/3NzStvP3PpRo5zD323YSa/JrG73VQW
4xiqN+KKMRelZzVQbYJQtDIBWXT6dqPz9imeKqJY1qronH3cjsRyxN9l1xsZsccP
dmTVKEeD72+b4p9Jm93u5Ms1fVGeN5BGgl+szualRymCQs0BK0nOHMrPSWsZfFbB
uH8x+GaU0Vv7OcVUSE1F1+eDDh8ZhZo5l07v7dBvGYk9kISGEowHtLIM65C6UxyF
EWyMXyOb
=fsTl
-----END PGP SIGNATURE-----

--8RGRsZ+D3L7BqqzV--
