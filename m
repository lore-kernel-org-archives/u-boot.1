Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45D3C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360FB876D5;
	Wed,  8 Nov 2023 01:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UjBVvHVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61305876DA; Wed,  8 Nov 2023 01:34:56 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB80876C6
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7eef0b931so75070967b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 16:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699403692; x=1700008492; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5tBpjM0Oiu2CMv6Pk2vtYnBn07qdswsLUeou0fP+ppM=;
 b=UjBVvHVbcKLwTWHwGav0fgpr0BGoTZ//fVV/oYGFzj3SkbEd77Ktktu0LNxbe06sGn
 queJMlmke+W1BUMA2YddWdfv0zp92XJV54/D9FmvWghDVv/3DHyCYEUcf6QpxshfQcSN
 jJMdKrLHDpAbs7c+/NETfcD8Twm+jXwZnVSZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699403692; x=1700008492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tBpjM0Oiu2CMv6Pk2vtYnBn07qdswsLUeou0fP+ppM=;
 b=gNHom0PJCxT6ER9zNDrlMowBG6/KUK7zADUJPDnAYX5wMIzeqYPLbCRZI/kbeg6oW0
 a9Qcun7IX89+HNcW6rixiA76jSAoCwi6xBbGO8rvbuMyGZ0gK/N8rRfmVfZ2aWQQkGYn
 KO/K1wujWH03hvsDLs0hluPcIgxan7M/3yhhXwG+J4VgI+xDrO0mLTDgsw+TRdtYvt+/
 OzDx8gsuDtfuHWzG2voHdnWXcKk+oWZQSap+CL6k8x5znXNO6VOmIOZWTwMuhX8/ujuS
 CSuQukeJkiziwQwtHrrE2qu6AQ9OMqzvE04ge7iI1lepZO2v+9Z9ke/252q/OeqCppqE
 iYrA==
X-Gm-Message-State: AOJu0Ywc5STpSf+3g2vxA05AgAmL37RT4H8BM0CDE56F7bn9KNrtdlXs
 yeUkKyt6LCCEc9hqrPdi30VrUg==
X-Google-Smtp-Source: AGHT+IFTfNU3erQhVFtkFAiG/Vg2+0UmNQT9DcOvVpVLygBx+WXi3ESnltYEy1hvecaHOqsgBcqCrA==
X-Received: by 2002:a81:92d2:0:b0:5a8:d92b:fbf3 with SMTP id
 j201-20020a8192d2000000b005a8d92bfbf3mr312516ywg.38.1699403692516; 
 Tue, 07 Nov 2023 16:34:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 j143-20020a819295000000b0059a34cfa2a8sm6242055ywg.62.2023.11.07.16.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 16:34:51 -0800 (PST)
Date: Tue, 7 Nov 2023 19:34:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, palmer@dabbelt.com
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231108003449.GF6601@bill-the-cat>
References: <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <20231107-audible-undoing-293506af3890@spud>
 <20231107232305.GW6601@bill-the-cat>
 <20231107-sprinkled-sixtieth-6456baa2c7a3@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A6fjwMd5qxUMQAjE"
Content-Disposition: inline
In-Reply-To: <20231107-sprinkled-sixtieth-6456baa2c7a3@spud>
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


--A6fjwMd5qxUMQAjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:29:03AM +0000, Conor Dooley wrote:
> On Tue, Nov 07, 2023 at 06:23:05PM -0500, Tom Rini wrote:
[snip]
> > Thanks. Setting aside Simon's follow-up, this is what I was looking for.
> > We might have to wait for Heinrich to return from the conference to have
> > time to look at how to utilize the above and see what we can do from
> > there.
>=20
> I did read that, but I don't think most of it is relevant to the binding
> itself. His five things were:
> | - U-Boot models hardware (and other things) as devices in driver model =
[1]
>=20
> This I think should be satisfied. The Zkr CSR is a property of the CPU,
> and shouldn't have its own DT node IMO. Is it problematic for U-Boot to
> populate multiple devices for its driver model based on one DT node?
> I know in Linux that I can create devices using something like
> platform_device_register(), does U-Boot have a similar facility?
> https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L7=
67
>=20
> | - U-Boot requires devices to be in the devicetree, with very limited
> | exceptions [2]
>=20
> | - Where multiple devices exist in a uclass, it is desirable to be able
> | to number them [3]
>=20
> I'm not sure really how this one ties in. Do you need a number for each
> CPU that supports Zkr, since a system may be heterogeneous? I think that
> how you treat things like that is beyond communicating support via DT
> though, IMO the job of the DT is just to tell U-Boot on which CPUs it
> can access the seed CSR.
>=20
> | - Similarly it is useful to be able select a particular device, e.g.
> | with a phandle [4]
>=20
> I suppose a phandle to the CPU would work in this case.
>=20
> | - U-Boot uses devicetree for configuration as it has no userspace

I mean, the reason I was setting aside Simon's question is that in my
mind, we (U-Boot) need to think about what we're declaring as a MUST
because the constant feedback that we get is "No, why does that need to
get added to DT? Can't you just use ... ?". So I do find your answers
above enlightening in that regard.

--=20
Tom

--A6fjwMd5qxUMQAjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVK16YACgkQFHw5/5Y0
tyx3Awv/QtQcK1ji5/6uTWqwPNVS+ws2QiNFjgis30v+JZFRiCDJb5IaxjpHzFq8
qYVy0ldt8aUbyKC1kGtOfaEx3PPDKoYRmyR81OPRZ1nK396ev/3ydcYXgEr1hfmY
nxzY85BZAgL0BlZ70z61a8TP9xci3oSx4HEa7v9M0CasG7+7j1pffa4a0mz/OTxQ
N5yoXc0YSexRvO3NWxa1hr3TdXtSOhfqVgcO+E2x9B9R/RyUeT8NSUUTjFuRXyF4
Qm86AiObvzpVaIm8UmyON51T5CXNZoR7ENqBzzXix69p/34PralOtucpETe1a6Pp
jMTZhxzVCfnhqTF3G79z0DSeAXygT8CivClYPVK0Z0QPXH0XH4BAsdni85FD3kag
6y1NZYfsAsVikCZvLcKuFPlgRwelvsacqiUwlnrSzE3R9d+YxnJueMSPxl8zx7zC
J7RkTEx2+zcEXYjeQ43QWBdWXGq5ycLcpN/L7e5OpNqyq/B4WoQnc1VxdXzzpew3
MDzOEk26
=u61x
-----END PGP SIGNATURE-----

--A6fjwMd5qxUMQAjE--
