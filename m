Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56373C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE65866D4;
	Thu, 31 Aug 2023 18:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HMtM4B8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115E68666B; Thu, 31 Aug 2023 18:26:29 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF81286689
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-58c92a2c52dso11878137b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499184; x=1694103984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nk5w6ZqIE5YFfRhJ11Mb2idqGvCsfSvv28vbttiaPzU=;
 b=HMtM4B8rgLh7pL3/lwVIAnpOlIssQkVW+WKtzixLJsWb30N6Urg2OD+A/i1Lx8oEn6
 p7P0aaw/FN6ST7rzk+r++rLBxDer1yqpPNIIYttnJp7LNvN4FyZ3ln2Vsc9YRaiGlSze
 Oya4SiUGi4EruxMi3gCr7w5XApsMmSkOQECKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499184; x=1694103984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nk5w6ZqIE5YFfRhJ11Mb2idqGvCsfSvv28vbttiaPzU=;
 b=I/BXHM+XNCTeUqGVgCMwU5yvVzmixMY15jqox1/9eps1gNkwmS7C0gLWbAos9Zqifn
 xThrcH5BqnizpuqYyfLRkJBC8K2zH2om8XvuMYSQ8KL8VuBsAD5HiO6kd5p3Cg5GQDvZ
 KNhXNaE4LXRlYoA9OVbIryAL/mirZRjp7zAKexwWwUlJ6lJFHpBk2QCD3cH088nz9r6A
 hPB/XHMuaAMDeiyY7l7es9j23wxp/F0aaia6x9JraZeE2ckIvaQ3QSthT5zuyjEdn51u
 QwLNuqslluJ4sgAoxaNc+jCSQyUb758Puxjg/JqBXPIkSlgQHmZ1koOYhVsbM+/DMEcG
 BCMA==
X-Gm-Message-State: AOJu0YxKVxZRujYF0N2TDHXkgMC4E/FI7uqfNDIw8i2/lUYrYJBzxv9p
 ccMsJTxLqrmQvYYPzdxUx4jBqCgoNMulHE9IG9MuRQ==
X-Google-Smtp-Source: AGHT+IG892/evQbG08zQMys7oFkyKBqiX6riaISAaQ3ZkBr3i3IV+Z3JktOSiw5FiKMUuOBBd+vSaA==
X-Received: by 2002:a0d:d406:0:b0:58f:bbc2:f6d4 with SMTP id
 w6-20020a0dd406000000b0058fbbc2f6d4mr5364312ywd.8.1693499184640; 
 Thu, 31 Aug 2023 09:26:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 v66-20020a814845000000b0058cd7816bcbsm510628ywa.17.2023.08.31.09.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:24 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH] pci: pcie-brcmstb: do not rely on CLKREQ# signal
Message-ID: <20230831162622.GC3101304@bill-the-cat>
References: <20230816222753.104882-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LBQCXbTFFoPVCgC1"
Content-Disposition: inline
In-Reply-To: <20230816222753.104882-1-CFSworks@gmail.com>
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


--LBQCXbTFFoPVCgC1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 03:27:53PM -0700, Sam Edwards wrote:

> When the Broadcom STB PCIe controller is initialized, it must be set
> into one of three CLKREQ# modes: "none"/"aspm"/"l1ss". The Linux driver,
> through today, hard-codes "aspm" since the vast majority of boards using
> this driver have a fixed PCIe bus with the CLKREQ# signal wired up.
>=20
> The Raspberry Pi CM4, however, can be connected to a plethora of PCIe
> devices, some of which do not connect the CLKREQ# line (they just leave
> it floating). So "aspm" mode is no longer appropriate in all cases. In
> Linux, there is a proposed patchset [1] to determine the proper mode.
> This doesn't really make sense in U-Boot's case, so we just change the
> assumption from "aspm" to "none" (which is always safe).
>=20
> This patch DOES resolve a real-world crash that occurs when U-Boot is
> running on a Raspberry Pi CM4 installed in slot 3 of a Turing Pi 2
> cluster board.
>=20
> [1]: https://lore.kernel.org/all/20230428223500.23337-1-jim2101024@gmail.=
com/
>=20
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--LBQCXbTFFoPVCgC1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwvy4ACgkQFHw5/5Y0
tyx90wv/QVMYhfc7MAbUWRkCGIPQKO0ptT2+BnFr4yHuZMSG/pgJe1WoiTeBGLrS
9zFMK76iaV+4lCjetf73DqYrVPJWb0czJEMCqXzIM18dJpr/Tgra1YR4dhmi8BKu
AVrEXESN0229jDQ3thGcR7SLwkKvdmdKBQ8qFPJRrabmHU466+pqy/1L3lpGyWRp
MN/xawfln0qxDTxFsgOKqRX8AgQqH8VzO9pk7uPg1+tklqj1YLvjnnfBDpxCliNz
sN9haeVPZrNmdcYh7RoinpP5lrCERhBB0tfoYk0Ns1SEaeBlVsWv4vDK7pcb/jtu
WfVJFcCPqu67VRzhkkJgYPGC3NIotPjxIjRd1KmF17b2SsRPSUURHeCyV1iWpNOZ
OjiN6SMnQJZFs8xDdY0NTThEMZvWMbAmPlfudYqoHVhqPe2H0KO8AqkGALXTeNKI
DMd9m9uOCFf/UFV/32XE0XzHFlPKdFhRRX2fyT3VJgMX0J6hHOJUJCeQVrbOH2PY
9GOMYEjG
=8dV3
-----END PGP SIGNATURE-----

--LBQCXbTFFoPVCgC1--
