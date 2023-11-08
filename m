Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCF9C4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 14:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F2F8713C;
	Wed,  8 Nov 2023 15:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QiQdzuVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D8087253; Wed,  8 Nov 2023 15:37:41 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CEB387030
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-da077db5145so6924620276.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699454258; x=1700059058; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tIbkpstP/YMXSwaLdmH+mnMfiH5LKtQQmMQdZRfXb9c=;
 b=QiQdzuVHI7FGS6m/62knYDQesnHPjI5MBfVKSQhXObgf6SqirVUFAjxOYkh6n/D9W+
 l/fN5dAi357GvQTzdLp7HT1FZNPAQjYTt0o55gER9ZEaKeRiTCz16HUMpL2h+AXwmpKc
 wF1gfQ9LL38kmf+H9TxUBKZiJHGTU0J63zGjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699454258; x=1700059058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIbkpstP/YMXSwaLdmH+mnMfiH5LKtQQmMQdZRfXb9c=;
 b=Gt8MN8j3XPmXiijnU/9y+CCE7f7K9bA3GNbd7KWFTcSiLu/w78QwZqfl8fTYV4743D
 MtgvxB6wIWlvfT6a3hB9b6U0IP76ez2l77vKHrQSE3QWg15Tt0eW4Vswp1nnFU+nnr91
 BRgkXq0x8z7k+WRE6hXo2hoc7Um8WGLOPEM6D0oWibuChGxeHo+mvETIht52SQmuWR13
 eT/7J0n0oDkxmG3SHd7tY1uZNthjHJGDRnwFMmtqABZtjH0fNOl/wl7osRiIr+Ijjp0n
 Oq6ZD0moCDO8D3WnUGoISNqlOisTrd5WH/K6kuCMLf7WsAgmCZChCs5YdgEO/7fAyydt
 uNWg==
X-Gm-Message-State: AOJu0YwZqBs08uAMFElGU7J6k26o0+4zxkWekb8pfdEf8HMx6PwTtukr
 68AQDox1z3j++MZDMvummku1Lw==
X-Google-Smtp-Source: AGHT+IH/Kq4+Koth46q0XL7km6Kz5e/sE37YSmALp2eEPo2cjPIKGE2YzFTpTYdPxDiJ9O9gCdK1bA==
X-Received: by 2002:a25:212:0:b0:da0:338f:794c with SMTP id
 18-20020a250212000000b00da0338f794cmr1810899ybc.60.1699454257843; 
 Wed, 08 Nov 2023 06:37:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 w142-20020a25c794000000b00da0c49a588asm6534873ybe.8.2023.11.08.06.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 06:37:37 -0800 (PST)
Date: Wed, 8 Nov 2023 09:37:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, palmer@dabbelt.com
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231108143735.GO6601@bill-the-cat>
References: <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <20231107-audible-undoing-293506af3890@spud>
 <20231107232305.GW6601@bill-the-cat>
 <20231107-sprinkled-sixtieth-6456baa2c7a3@spud>
 <20231108003449.GF6601@bill-the-cat>
 <91ae75c2-a0d7-4835-8306-777c4d9afdd9@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tJcvB7QdoYjwApD6"
Content-Disposition: inline
In-Reply-To: <91ae75c2-a0d7-4835-8306-777c4d9afdd9@canonical.com>
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


--tJcvB7QdoYjwApD6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 06:23:37AM -0800, Heinrich Schuchardt wrote:
> On 11/7/23 16:34, Tom Rini wrote:
> > On Wed, Nov 08, 2023 at 12:29:03AM +0000, Conor Dooley wrote:
> > > On Tue, Nov 07, 2023 at 06:23:05PM -0500, Tom Rini wrote:
> > [snip]
> > > > Thanks. Setting aside Simon's follow-up, this is what I was looking=
 for.
> > > > We might have to wait for Heinrich to return from the conference to=
 have
> > > > time to look at how to utilize the above and see what we can do from
> > > > there.
> > >=20
> > > I did read that, but I don't think most of it is relevant to the bind=
ing
> > > itself. His five things were:
> > > | - U-Boot models hardware (and other things) as devices in driver mo=
del [1]
> > >=20
> > > This I think should be satisfied. The Zkr CSR is a property of the CP=
U,
> > > and shouldn't have its own DT node IMO. Is it problematic for U-Boot =
to
> > > populate multiple devices for its driver model based on one DT node?
>=20
> Devices in U-Boot are bound on the basis of a compatible string. All RISC=
-V
> CPU nodes have a compatible string 'riscv' but that does not provide any
> information about the existence of the Zkr extension. That information is=
 in
> the 'riscv,isa-extensions' property of the cpu nodes (see
> Documentation/devicetree/bindings/riscv/cpus.yaml).
>=20
> > > I know in Linux that I can create devices using something like
> > > platform_device_register(), does U-Boot have a similar facility?
>=20
> This is what the U_BOOT_DRVINFO() macro in my driver does and which Simon
> discourages.

My current thoughts are that in this case we could use U_BOOT_DRVINFO()
like today and then have riscv_zkr_probe() be what checks the
riscv,isa-extensions property for an appropriate match? This would mean
we don't need any new nodes/compatibles/etc, and possibly not need any
bootph- properties added either? I assume we don't need the RNG so early
as for that to be an issue.

--=20
Tom

--tJcvB7QdoYjwApD6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLnS8ACgkQFHw5/5Y0
tyzRDAv/al6hN6IxVX1U/ClUy8YgjCG2+cDdTuVvnYVDgHskJziMNRBtmbktul5r
wBvmWm8ZWE9tk+8IKfchWvoNu8IcVYqSCIk3XJp4hpBANBwetHxyM+FRahjI0NGP
zXoGejWhExPgqvP9UTay2kpTFZSCyvNTQIKNNWKtFa+wjez/XY3ji5fQM9hdmfow
7YQdUDX4M1GgE4BcdpcRhOCYJd3tRzla+6O0U05XvS5nu2AdRr8KKZaG8AarIY+0
BFWWEw5/n+YnI8eSPpoIhZ6+G4G1Em+mzUQFaizthnVL+VWnFR/PVJdisEWBBZhv
XZG/C3MiuPAjUmztFlDXbaRBw86FZ4cUf/Ee9LZqn37hrvdVRLQcncmcc88XAE4s
yZfINdioJCHsYMScH7CkAr8wqtJhg/gpr/uO88pfhPwtgdTHyrghObvK3gkc+LjW
GZtQMp5ahCMkTmFM9Mf05xbWlOyuSUbqTL76kMEXMJ/5t1UNjxXnFagUuQShKM9H
PFXoqa6b
=F6r0
-----END PGP SIGNATURE-----

--tJcvB7QdoYjwApD6--
