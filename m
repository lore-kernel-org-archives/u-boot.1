Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6B6C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 17:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A26877FA;
	Wed,  3 Jan 2024 18:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gNDZVyTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B3F8775A; Wed,  3 Jan 2024 18:57:58 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50BCA877FA
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 18:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4283ad9e7cfso2777781cf.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704304675; x=1704909475; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UmOwZgkAsKV1ex8l6cUP9enhXnSgPuoUcT4Hw5Gx62k=;
 b=gNDZVyTHlaipENq1QCCIQt+DMkAs0VGgibyOvV/sgLwlXwOp+gILmM4euDfBKVCfr+
 u46/zOysunZRhaRMR8lxvfcsRZK3IQTS3xLIVKLLt6f0lkKXpULryWg2zspjmO3EroEl
 IFMRT1yvTDx+I4aVu6rQMN8jL9A/LpACeGv58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704304675; x=1704909475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmOwZgkAsKV1ex8l6cUP9enhXnSgPuoUcT4Hw5Gx62k=;
 b=uHE3kLaLAqjQnzstWPNgAS4W0X3FDdAbQLm8JKvekeQOW0WwqpvfHky4JRmV+O4e2a
 boVAiOrSbXef8vAiQ0tK5Ey55T4JvqNPs7R/HUP/poI3BfXtEspkV1PH28FuMaumW0Ao
 lGexpY+BrnDHQXxg4zr0hrDYFpjDAzq/iEn6jMZtcM0LdgjHdqpfZQR6gjFEUzbwWcEQ
 e/s/AuJ0rDOC01rZnpsbrl8Ot5r8QHbxb/3Kui0A46EsRRJ0/776W65ZeoRqjvP3+pjL
 kzPUrNuJOU3WruKRWzqws/sF9CcifcasBTHGN9eFSErVfx7TEXcETgt658bE//CwzeZH
 8g6Q==
X-Gm-Message-State: AOJu0YxLnZmD3P+YtEc65ZCI0PcOqzAf60u45ludVPt08MiCTzUR2nOU
 UwlD8et2E8BGgB9bC2e5vSLKGLBDKZie0Q==
X-Google-Smtp-Source: AGHT+IHwl0bK8ZGjysiQwQ2J834l+1YIVzaG8OwfqJjz71n6QQVt1uTTmO3p3KukCJJzr6iVMIc+Cw==
X-Received: by 2002:ac8:7f94:0:b0:428:205d:d2df with SMTP id
 z20-20020ac87f94000000b00428205dd2dfmr6921439qtj.134.1704304675100; 
 Wed, 03 Jan 2024 09:57:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 cb17-20020a05622a1f9100b00427f358116csm7213984qtb.10.2024.01.03.09.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:57:54 -0800 (PST)
Date: Wed, 3 Jan 2024 12:57:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v3] test/py: i2c: Add tests for i2c command
Message-ID: <20240103175751.GM1610741@bill-the-cat>
References: <f7ff13475bbd3f0471bee709dc6a805d3da5915d.1704176360.git.love.kumar@amd.com>
 <CAFLszTgFS5CPZAioNLRFQCispoHKLS8V8Mc0B1YYqRcJ15WmYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0WSVJZftAYZI10dw"
Content-Disposition: inline
In-Reply-To: <CAFLszTgFS5CPZAioNLRFQCispoHKLS8V8Mc0B1YYqRcJ15WmYg@mail.gmail.com>
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


--0WSVJZftAYZI10dw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 07:06:29AM -0700, Simon Glass wrote:
> Hi Love,
>=20
> On Mon, Jan 1, 2024 at 11:47=E2=80=AFPM Love Kumar <love.kumar@amd.com> w=
rote:
> >
> > Add below test cases for i2c commands:
> > i2c_bus - To show i2c bus info,
> > i2c_dev - To set or show the current bus,
> > i2c_probe - To probe the i2c device,
> > i2c_eeprom - To test i2c eeprom device,
> > i2c_probe_all_buses - To list down all the buses and probes it
> >
> > Signed-off-by: Love Kumar <love.kumar@amd.com>
> > ---
> > Changes in v2:
> > - Take the configured eeprom value from env to read back and compare
> > Changes in v3:
> > - Add test env dependency to run it for provided i2c bus list
> > ---
> >  test/py/tests/test_i2c.py | 116 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 116 insertions(+)
> >  create mode 100644 test/py/tests/test_i2c.py
>=20
> It is OK to write these in Python, but you might also consider some C
> tests for the commands. See test/dm/i2c.c for some examples which use
> an eeprom.

But part of the problem is that test/dm/ is only run on sandbox, and
these tests are being run on real hardware.

--=20
Tom

--0WSVJZftAYZI10dw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVoBkACgkQFHw5/5Y0
tyytlQwAuY8L8mjiXq6igzXKo2W2iFyDx0R2MJAlvDUqY1SemYVyOUUWcE8pjCbu
dyngGwjW8x4ZL8VkrV5yJanayG1Z8Oyq9WcNiDbJQxTIlfuqM6mxbiZN8uf+S31C
ubs18mA9LxTNd9M9MUikE9q0MnEXo3XuPsiUeBjM/pCbML2Lkp1lvsObkUK5KZXD
76FJ5FndJ3JGHdyD32hR5gqbIeGghVhYfE8zA5S4Kk9ITqpS8pvycLQmzzQiSeOR
je1/H2SxDnP9olZNGjWUdL0NXNkmzJeO9RpJ4fEN/hOgo3m/FRhnAF6KCRC+vl1H
wJPGY72vNEDY6im+yIHJ7oXMYWhPs2+7vHzy4rBBbU8gZ1CXvkyYNLCUvAEukfml
JGdzAmOjfq4/KEumyENbCYqXhGErBg4CsdFqtE87WJtYi31jxcBVcoMEHFEAANQA
2/izOvDCvYQkbdDVQjVO4yK5YL674VaE6qpV98bGfk1zsGth3jBT9TUn4A3hN/mQ
1vW6j2LP
=F+rw
-----END PGP SIGNATURE-----

--0WSVJZftAYZI10dw--
