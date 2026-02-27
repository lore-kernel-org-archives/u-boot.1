Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FEEFEFB6D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 16:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7EB083D1A;
	Fri, 27 Feb 2026 17:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="now8MCe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E25683E96; Fri, 27 Feb 2026 17:24:03 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C11083CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67a02dcc450so3403eaf.2
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772209439; x=1772814239; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L/1ZUeTu3jR0IEGyf7u3hwvjX88M8PUsfxMyHyVNF9U=;
 b=now8MCe8owI4OM/Wy0xNJ83wwZyerxw4DxmPszy3IvavRSq96TeBJ3br7lXusr2oe2
 7OggPjYtDQrTINlTv+IA40ccNqQBnU/w0b8BaPX0Jr+Prwby61Cj8jK7h52+jYI4fb7X
 /7eKSW4YlpjmijONUFnCz6lWB20RYsx0mOR68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772209439; x=1772814239;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/1ZUeTu3jR0IEGyf7u3hwvjX88M8PUsfxMyHyVNF9U=;
 b=Xs6fSIlC4yTa0nWiMf1ELrzfUZkqV/dNlKKUNET9UPF9TiFNkYk6ysp2af0Tx4+x4O
 +fz7X7LCD55tWP+l+9URCgCKYAjEjxVVrdRNBZer4pdQyZSJxuq0D0sVnhwtRgVuii5A
 fcAXA0wOLYss8+Qk2lbRrIE69Fw+TVwNp5/NmeA9/RqmTnqNY9djEhjehYSRVJSg8bur
 s3NqH0mp40t21SMI6CPZalIaJ24aQfANkw5GiXExKO/kfD9KZO2VLLgfiUaMymFsj6+O
 DNFr1NbOSD4liK8FXCe/lsyFO2KOzX3+TB39UegxmFtzr2oVZ3Qy2m/+d3JQV9UjmzDj
 aMaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ62zk4x712bBVeV7JYZIuU4Pk9RpazRmkQIKB9POIpMENNj50wg5LQkAjDtVJ8L0xwMCZW5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwDR80gNx30y/l24aYEHcJhoig9ZwIEPuJ/d/QbQX+kgl1WcIWZ
 maV1MjSZ+dnf5odmGjr+vAFsS3fDfoSU6K6Hhb3CFUNenf9pz0utSKC4RU5vByAnvWo=
X-Gm-Gg: ATEYQzxZAGHBoPWctzF2E6Nua5nPisNFoCEqSI5t2ct79FP2ApAM4tsHbTDfus35HfZ
 5wd2FGJgTbEHTPm8Kk7Rz8U8Vlbt9U8q7nqAgXnur/UWugoY7cp7OvudI5MtxIsaVci0NdgQqJJ
 ZQ3dAij7utBgPOBETT/AZWDUvGIG3WzxC59rB9iyAGDAZlJqKSMtawvWrEH6CKySzgdussMB2zG
 OKsvEphSK8QvAYqkt0GSNkvGgfYFy67fzrCXYM84LfELMjoTaJMstPi1fpd3P/sA6DhJi7zltfH
 o08tZij3JgnxSoj4HGWMg6ZjfNyavsGm9vhNSFCIHCIA5Vii26uNJJ2IEBTC1HE9Jox/z/HBupz
 v+UIYJeFWjU/gg6WnpTuABrswqCMeOOu8TTJB7KGmxQMaDZtVrYRnnRjpgLx5Wwr72wj5ZOd6Su
 zUniI2qsm8XoAGWxwlWGqUvj75qQjTRUJTi5LICaJZ/TIYiP5GHO2TSiCCq2SYyHIDZuO8UoBDL
 zifNuROUApVYCdFYwWv24EvFaOlJEPFtRfdOkeaxzPpT5R0v9Y=
X-Received: by 2002:a05:6820:4dce:b0:663:c86:e9e2 with SMTP id
 006d021491bc7-679faf3aa32mr2102825eaf.35.1772209439308; 
 Fri, 27 Feb 2026 08:23:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2db7448sm3483010eaf.16.2026.02.27.08.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 08:23:58 -0800 (PST)
Date: Fri, 27 Feb 2026 10:23:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, anshuld@ti.com, d-gole@ti.com, n-francis@ti.com,
 bb@ti.com, jm@ti.com, s-k6@ti.com, afd@ti.com, u-kumar1@ti.com,
 marek.vasut+renesas@mailbox.org, a-dutta@ti.com,
 neil.armstrong@linaro.org, semen.protsenko@linaro.org,
 peng.fan@nxp.com, george.mccollister@konsulko.com,
 u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH 0/6] 64-bit PCIe for AM64, AM69, J7200, J722S and J784S4
Message-ID: <20260227162355.GT1593142@bill-the-cat>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
 <20260227143509.GQ1593142@bill-the-cat>
 <0980b08b-ef08-4ae5-8656-4b6c211a1680@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+QEzIw4SIqrdSBYL"
Content-Disposition: inline
In-Reply-To: <0980b08b-ef08-4ae5-8656-4b6c211a1680@ti.com>
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


--+QEzIw4SIqrdSBYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 08:33:19PM +0530, Siddharth Vadapalli wrote:
> On 27/02/26 8:05 PM, Tom Rini wrote:
> > On Fri, Feb 27, 2026 at 05:28:28PM +0530, Siddharth Vadapalli wrote:
> > > Hello,
> > >=20
> > > This series is based on commit
> > > 437ea9f8be5 Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
> > > of the master branch of U-Boot.
> > >=20
> > > Since Linux device-tree has switched to 64-bit Address space for the
> > > PCIe Controllers on TI SoCs, currently, U-Boot needs to support the
> > > same. This series adds support for 64-bit addressing for PCIe along w=
ith
> > > enabling Root-Complex mode of operation for AM69 and J784S4 SoCs.
> >=20
> > At what tag did the device trees change? Thanks.
> The DT sync with Linux by the following commit dated 30th July 2025 chang=
ed
> the PCIe Controller from 32-bit Address Windows to 64-bit Address Windows:
> https://github.com/u-boot/u-boot/commit/ecec23fc9a9f0eb48b761722c492cbbd4=
bb2e546

OK, so we should add a fixed tag then? (please just reply with the
correct one, b4 will grab it). Thanks.

--=20
Tom

--+QEzIw4SIqrdSBYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaHFGAAKCRAr4qD1Cr/k
CtMOAP48lN33EiF2aBAc0+zqoAdbU0F8Qa+LSgC1vw5Jbxnz4wD/cT52rQ7/8I3V
glamOx5gzUDrnWoDSmtfC5aG2yHx4Qs=
=II7x
-----END PGP SIGNATURE-----

--+QEzIw4SIqrdSBYL--
