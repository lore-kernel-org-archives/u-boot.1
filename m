Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA23C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A9288191;
	Thu, 28 Mar 2024 16:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jWlHC8aA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9929588191; Thu, 28 Mar 2024 16:09:01 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF6588010
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-690caa6438aso5636506d6.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638538; x=1712243338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dI50JMqtJg/9y6coeogZAOuid81KPo/dqPYzXpUsln4=;
 b=jWlHC8aAigZyaiESMR2CvWw/fYEo6Cz3ynoicoMyhRngarLN94RcEBBEExCbzvc3/b
 91LKLka6oYuBEOg7trWR2pWEVdPi9seSNk/dnZA1yHYrHOSJrJhdNK02LWWCNZ5xjBRA
 eJBfK8NTJ3/zKDq/5h+7XSuAWRmpXIHiD47W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638538; x=1712243338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dI50JMqtJg/9y6coeogZAOuid81KPo/dqPYzXpUsln4=;
 b=n2LO8GPxCeofbTKqj0nVEa2LdOBeegZEFZ3EjL5gi1uLlyJTiTsa1rC5JBrf13Fl3Z
 KgERt/tF3gM5RH3/QucwAmWv9bFVB4uRJxEpfm4qR/42lTT7tZKJQSF6tlDxdypXxtl5
 H/8qyt9UFSsuUmsqq28IR70S7rOhw9us25YOmbnsoHSsXuZyDMlaMbvkQc1+qvdxDdFN
 r2Z+shDVkq0GGItc1jrCTtUwFalD78bWoMhylLnmFG1xdkpFby1A3SN/bo6x1co9ynWr
 E9XOBjN7fq1KRTZ65YbpMSTECDiAZgCXWNB/1+hgbXTEocKtzu9cVxTPN3k3r6eV/fQ8
 bQyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL+zh+ZrotaR3+UpZ6r5UwXzRQ5xtjfY/0IaIh5y6QCZqIiC8Qqt+zURsxtB2RLlWonlXR+Gr36o9CyRqBhhUXSJL+5A==
X-Gm-Message-State: AOJu0YzYKlVGIYPSrAlAFpi9OVRXGE+hWX/4OS4kcykiRukFL1kaZT8N
 c7nv80+q7MoRjct+VpxqAtElWEACCUorco1br7x9WQTUZxWkayxP51KXapxNf7U=
X-Google-Smtp-Source: AGHT+IHqgEXJw+DMaq40IF1vv7s2eBs3oPo2+XwU1j/Q9OxghB97H1wRlkYNqy4JirwwbQfwf0bcLg==
X-Received: by 2002:ad4:4e0e:0:b0:696:797d:bea1 with SMTP id
 dl14-20020ad44e0e000000b00696797dbea1mr2776289qvb.23.1711638538541; 
 Thu, 28 Mar 2024 08:08:58 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 kl23-20020a056214519700b00690c77505bdsm724349qvb.37.2024.03.28.08.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:08:57 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:08:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, michal.simek@amd.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de,
 BMC-SW@aspeedtech.com
Subject: Re: [PATCH] net: phy: ncsi: reslove the unaligned access issue
Message-ID: <20240328150856.GU3442575@bill-the-cat>
References: <20240205081323.256131-1-jacky_chou@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VulA62uW+lHXq/VG"
Content-Disposition: inline
In-Reply-To: <20240205081323.256131-1-jacky_chou@aspeedtech.com>
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


--VulA62uW+lHXq/VG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 04:13:23PM +0800, Jacky Chou wrote:

> From the ethernet header is not on aligned, because the length
> of the ethernet header is 14 bytes.
> Therefore, unaligned access must be done here.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Applied to u-boot/next, thanks!

--=20
Tom

--VulA62uW+lHXq/VG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiAgACgkQFHw5/5Y0
tyxoGQv+KRKuoFr1j8n4tQ4QOFa0kz6EaqT6fqrwoHAZU01JxTyMnLi0OMyLPDc8
l+Lj2H8li9ptJM/tDV/OCHhVCXqWAYfeQ/E7T7GuY4NKJvN+ydsfkAZqxZLszlxh
CF2atzwDivrQ0EXGpcsWX21P9Ffwnlobr9d/nvd9/lafwEM7Zpec7uTpVFUY9G/3
B6JgCdOCen+qLAm3PbQ+b9i+yfh1qx485HfFITu3iL77SNA6D9PGllaitOS+TtC4
FsyYzwNB4HioLBb6cTaBiD7kg+H/p/DxSi2nAcX/FcI1w2HIeuBB3ziX82HZovOk
bT9+Rq51ChgxjvJxfosMsu6RvVoolZcMxOZy/g42qY6PNa+5Vz/zLenmSsb9AzWf
pBFyfolpvq9s0sgGQIzB+xx7xNiZAJTglvoDXLNYuLFOXkqsE0JUsDiBn9+V8vXB
Zf+a0gjktxloI9nkvv3byG+bvLBssfB/ovC2uK/pyHRtoawgik5qPDeuZBQp9eEd
Uiuswqls
=cYCf
-----END PGP SIGNATURE-----

--VulA62uW+lHXq/VG--
