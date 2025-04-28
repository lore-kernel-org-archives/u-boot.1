Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C28C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 22:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563F180FDA;
	Tue, 29 Apr 2025 00:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hsb0mnHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9221880FDE; Tue, 29 Apr 2025 00:48:49 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B32980F03
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 00:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c27166ab3so4076762a34.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745880526; x=1746485326; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l1EOcz2RLYAwVwtFq/ePu3TlpSHbJQO2EIP5Xwba500=;
 b=hsb0mnHhjDQS3Mu7rKRzWhFeVR7oVJPRxCzreNmO2+WrfASWWu61GChpQtjLHBZ7ls
 MPsQq68i8rvRd0FbWUNpI55vDqhoBVfTtcm2BFxvFdfXYrYZ/d9aoplh/vIed7WoRKx5
 061Y4iKRVT/6Lc+B6y2U6B1aJZL16Az9Cm7SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745880526; x=1746485326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1EOcz2RLYAwVwtFq/ePu3TlpSHbJQO2EIP5Xwba500=;
 b=upArVlqYPMyRp40ptGCdBwMAiz/nXaH2bvniFVgghWXhm7bDMTWul4nLeK9EJEWl8U
 IY8ODA+Nosn9wJOZFNdkat0hcPEcV57V8Aocb/7pomTTtx69efPrivtyCrou3ZjSpe5f
 0YlbEgx+Qk7kWj6NP5RPmO5DuOE+bjuHbGHEL0BRbB9FBmBrNlna13SZ9Vg6zgz+hb1W
 Rqvd0A5Hqni9dtu8epocWO6Qj1MEu73iE7yg985wY4Zx77beb8T3tN5qGKeemVWL+7kE
 Tj2Rfjsl34+f+iCYF4m6WyupcVInXhD/M7Zg/9CtBoyDp8B2HB4XLbnBp0cTtlEbKWIk
 m3Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaZCoaonpD261/h1qpQHX4PU+yPHFZSvfLjtdOD1QXXwUuFICdRHxrG44RHBampPeN5hpChBI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxkoo7YIuWDQi9hVUbFWvu1NZPCjQseB08z6mCknyX2+PP1b5NH
 qFDBfhkNotEjQo80Sz9lod2Huq4/CvFkWy09VHByaORcx89ZY3jyi848qHjch8vh3mJEWKIuPMN
 a
X-Gm-Gg: ASbGncvb9kvDc+TqeHfmZCo3vhFxCTRjtzvfpc6scFsqjuMQNU624yPZVgDNneRfSY4
 EC/XWOKlYG6CufbKMB46Q2PrpVZbb/BdKTawYvvj9BqaBfXJDAf9AOrA1h0dKIULnkQKJAesD75
 mbxdcBKjexoGpMBHf0US1lQt4fqvfMjEzto4V+5lu/IEe+9bEyDeA7Cv4QJQizDTWdMvEP0upHh
 g7kI5n5o0SWTjd09eNw0cxY4FxKum2WYorbfPoJ9gz4lYSECiUnhKj0ZosdLhgj/vGrThyapr6K
 jua3zAIpUC7K3kPcxJy+AMOo0HTaaVjXwLLJK8xOksMs/RzAKdotLSDU6VYziT1FkKOkZcXqpa3
 c3Q==
X-Google-Smtp-Source: AGHT+IHeCSzV4xVVPU9T7icR3s+rRSqYPUmxGa9fY2cE/Gvi2wyO3KcCtMJVAA83JSDmjkMElvLKYQ==
X-Received: by 2002:a05:6830:3983:b0:727:3664:ca30 with SMTP id
 46e09a7af769-730651b3abdmr6953644a34.16.1745880525931; 
 Mon, 28 Apr 2025 15:48:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b11a1b9sm32689a34.20.2025.04.28.15.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 15:48:44 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:48:42 -0600
From: Tom Rini <trini@konsulko.com>
To: "Verdun, Jean-Marie" <verdun@hpe.com>
Cc: "jmverdun3@gmail.com" <jmverdun3@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/1] Initial support for Wiznet W5500
Message-ID: <20250428224842.GN5495@bill-the-cat>
References: <20250424214335.57230-1-verdun@hpe.com>
 <20250424214335.57230-2-verdun@hpe.com>
 <20250424235518.GQ5495@bill-the-cat>
 <DM4PR84MB1976B25BCB895B1235186328D6842@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K+vB32+6ccoibiAK"
Content-Disposition: inline
In-Reply-To: <DM4PR84MB1976B25BCB895B1235186328D6842@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
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


--K+vB32+6ccoibiAK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 01:12:13AM +0000, Verdun, Jean-Marie wrote:
> Hi Tom,
>=20
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #51:
> new file mode 100644
>=20
> CHECK: Avoid CamelCase: <W5500_Sn_RXMEM_SIZE>
> #530: FILE: drivers/net/w5500.c:475:
> +       w5500_spi_write(dev, W5500_Sn_RXMEM_SIZE(0), 0x10);
>=20
> CHECK: Avoid CamelCase: <W5500_Sn_TXMEM_SIZE>
> #531: FILE: drivers/net/w5500.c:476:
> +       w5500_spi_write(dev, W5500_Sn_TXMEM_SIZE(0), 0x10);
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_MR>
> #592: FILE: drivers/net/w5500.h:23:
> +#define W5100_Sn_MR             0x0000 /* Sn Mode Register */
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_CR>
> #593: FILE: drivers/net/w5500.h:24:
> +#define W5100_Sn_CR             0x0001 /* Sn Command Register */
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_IR>
> #594: FILE: drivers/net/w5500.h:25:
> +#define W5100_Sn_IR             0x0002 /* Sn Interrupt Register */
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_SR>
> #595: FILE: drivers/net/w5500.h:26:
> +#define W5100_Sn_SR             0x0003 /* Sn Status Register */
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_TX_FSR>
> #596: FILE: drivers/net/w5500.h:27:
> +#define W5100_Sn_TX_FSR         0x0020 /* Sn Transmit free memory size */
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_TX_RD>
> #597: FILE: drivers/net/w5500.h:28:
> +#define W5100_Sn_TX_RD          0x0022 /* Sn Transmit memory read pointe=
r */
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_TX_WR>
> #598: FILE: drivers/net/w5500.h:29:
> +#define W5100_Sn_TX_WR          0x0024 /* Sn Transmit memory write point=
er */
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_RX_RSR>
> #599: FILE: drivers/net/w5500.h:30:
> +#define W5100_Sn_RX_RSR         0x0026 /* Sn Receive free memory size */
>=20
> CHECK: Avoid CamelCase: <W5100_Sn_RX_RD>
> #600: FILE: drivers/net/w5500.h:31:
> +#define W5100_Sn_RX_RD          0x0028 /* Sn Receive memory read pointer=
 */
>=20
> This is the errors message I am getting with checkpatch.pl from uboot rep=
o.
> All of these Macros/define are defined that way inside the linux kernel. =
Do you want me to adapt for uboot or is that something acceptable ?

This part is fine then, thanks for explaining.

> I didn=E2=80=99t added myself into the net MAINTAINER section as others d=
ev
> didn=E2=80=99t did it. Is that something I need to fix ?

It would be good to list yourself somewhere for this, yes. Thanks!

--=20
Tom

--K+vB32+6ccoibiAK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQBcYACgkQFHw5/5Y0
tyxayQv9HxJGKN/X+sYuTewOnuz6aiKs1ZJfxpgbnbYwu8FBUFeNCGbB6MEtjAvi
MNMUXFfUuvmrfsmelzTM/2ILX0a3vU/KTiRTOtLdnpQa26Zh8E8LPky4iqGCalEw
mm1hfwi057nqqiunBuJfbinVR197hSfx9sM17qg2fXPK8Ou0+mA0z8sRWQXPns8N
I388ymC9RpSpVGXeRswpND9tIWh7crAX6GyewAxkgAjdM2KJuTf1AvcHLTraiQ4z
gmZRzW9uz4OF/sZX6XnRFIeRQxZkaS99L8HfN2LIvWHWCpQOzbTsHZSr9n+yFvKc
pWC8/fScehDnreWjMPzICpYhiX7x1aUXT4y1YbBL0BBLaMiNx6/etODopzMbDFTu
N+pLp/z1Q60jkkaW0f2d4sCAQ4cDvmno5Z4nchRwhuKEK+A4QnlWka/3FCBSk1ML
GRdMjiIkkpNtcUnkIsZnTYdhvLu6CJ32bk6Oc+Wg0PSnETNKon0aTZ2u2HRMzhU0
luXP+skt
=edwy
-----END PGP SIGNATURE-----

--K+vB32+6ccoibiAK--
