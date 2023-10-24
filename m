Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0F2C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 22:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5DD4879B8;
	Wed, 25 Oct 2023 00:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AxjMUaKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C68E8724A; Wed, 25 Oct 2023 00:34:11 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08225871BB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 00:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a90d6ab962so38860547b3.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698186848; x=1698791648; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rVofJTcoov5BCeids9h9QQsjCPcNna+tCivjPSSPTHU=;
 b=AxjMUaKSf4xRt8+bku42DUymbV/YlitpetrqZFVzV0/xxXGyIhaUJ0rXRx+w6c/Kwi
 uG6XmEubmZbjrPzgEN9nTg54W6wnP7hwyNa/x8m3rKCTMiqYMtQJgQ//B2jZ4T65Tpjd
 ycPKOdBJJdR2L6c13q3B1/TaLjXQYggYOT60k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698186848; x=1698791648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVofJTcoov5BCeids9h9QQsjCPcNna+tCivjPSSPTHU=;
 b=By0VYf1qIpguavrzmFcrBK42iegSxgimIaIW25AtBhHGnBmizEeOF/Pfu3BZnmDuJX
 97oYtZR5ECknFnPIX79IcKTbuhb6vU38pT8nR6xcus6erzC4qaUcRc6HrbRl3UvJWTMx
 4FQxrCYO/D3/91pRRoWjBja5W75V0Bd8+UBTx0zp5W4R7wMM17pIA6SxwWE/KesXHswE
 byCTepndWo+ps8mWQN3OY9Ji+uUpomAk4dd5aTMpiAxygaF/TcDdti8tCm5m1IgSajaz
 5XIt9oQwwVgqBhczAVL+d43jm573X/63ExQTtjjxT/+NsWclGH9XX6WuRaveV1XWUQb9
 6z1A==
X-Gm-Message-State: AOJu0Yyl9jK4QkJ4QApbWAVTzAeKi3NXvXSShcH2xUx6CuXxm4xTbNAb
 cj4eTy9uZgkInc7CrG7zm2IahQ==
X-Google-Smtp-Source: AGHT+IEv3EvsyeFuRzmxtuzOEjj2oZH5Nn6qmaQPXuWFzlFK8u4SOuMrpQjBpY8PQS939o//AI8Apw==
X-Received: by 2002:a0d:e8cc:0:b0:5a7:ba09:52c7 with SMTP id
 r195-20020a0de8cc000000b005a7ba0952c7mr16246756ywe.11.1698186847765; 
 Tue, 24 Oct 2023 15:34:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a81a553000000b00576c727498dsm4453044ywg.92.2023.10.24.15.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 15:34:07 -0700 (PDT)
Date: Tue, 24 Oct 2023 18:34:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Cc: caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, bmeng.cn@gmail.com,
 brandon.maier@collins.com, kconsul@ventanamicro.com,
 oleksandr.suvorov@foundries.io, patrick.delaunay@foss.st.com,
 sughosh.ganu@linaro.org
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Message-ID: <20231024223405.GM496310@bill-the-cat>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZhcYXyBty9HAtzVk"
Content-Disposition: inline
In-Reply-To: <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
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


--ZhcYXyBty9HAtzVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> > From: Simon Glass <sjg@chromium.org>
> > Date: Mon, 23 Oct 2023 00:04:14 -0700
> >=20
> > Hi Caleb,
> >=20
> > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro.org=
> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 21/10/2023 01:45, Simon Glass wrote:
> > > > U-Boot typically sets up its malloc() pool near the top of memory. =
On
> > > > ARM64 systems this can result in an SMBIOS table above 4GB which is
> > > > not supported by SMBIOSv2.
[snip]
> There is absolutely no guarantee that arm64 machines have memory below
> 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Opteron
> A1100 SoC and all the recent Apple SoCs.

So one thing to resolve here is where does that requirement about the
SMBIOS table needing to be below 4GB come from (standards wise), and in
turn is that obeyed by consumers like say Linux or OpenBSD? Answering my
own question, maybe in part, https://www.dmtf.org/standards/smbios reads
to me like there's a v3 and maybe we should be doing what we need to
support / identify as that, if it doesn't have that restriction?

--=20
Tom

--ZhcYXyBty9HAtzVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4Rl0ACgkQFHw5/5Y0
tyxrVQwArLvN+wQs05vP2iaw0rPac9dLUldBlxYMrsZ1HViYrfuzdVfThl3BGm3c
uK5U9brfX/RiU2+QTPP0dJOEgq7no5dTLS7+J6Iufo2oFls9cL9TzruqSCWTwrke
3cjVay8ZlDeZ04olRrbSxfUn/gjhlyXLUgSIAPWrRJotjsGe+e3CZ+ZVkNfIV1xr
reuMk6XEenegm2HVO2S2HN/F1okVMdzfv63wFzox6MKPtxcHqgiaCKun1wCpbpwA
0IF0uIV3qQ1sGQdxh1wmQO8LV8tnf8xOc/LZYnWHtFst5nIyVTz91yKVZtnX8/86
oiK3Qi7uOpbIn99BMAUxFBGE35eGlLxfd7zDgBGQ6+DX7+OKz6CbU6oiE5eOJqln
n40r12l9SSaiAhb1ev91TDP3znDQAxZz/wNczoDekIFGZfJ7qMcErPsD5xMuFy85
37J50Ws/V7iIZXhIJjVMwXqKJPV989T5wl8BWmgeoLvE8YEPer59mxBgBxOHCiuo
Q73veDr/
=w/7S
-----END PGP SIGNATURE-----

--ZhcYXyBty9HAtzVk--
