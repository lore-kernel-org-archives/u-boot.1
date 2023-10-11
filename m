Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F529CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2B286DFE;
	Wed, 11 Oct 2023 20:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tcw/013h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5150286E0E; Wed, 11 Oct 2023 20:38:42 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529C586D2E
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d9a6399cf78so95241276.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049423; x=1697654223; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XAZ6+VbsRHgLHkDWNLwQAg5imGErWrF7Ll4HNdeAMO0=;
 b=tcw/013h+trcbB09pERvnmFUwPF1et2y2a8Z1ggh59ET0oGfHXnDnHHjcwNVaReBlm
 UU5Sr+jBqE+ZJjMrZtHEJHciLWnOo6mn+BzzauF22EfDgpVH5z42SBkq6w4blx66oUSA
 ZwxbrH6/7zm7l83jDn/LqSMAbe3v5Lbdyqsfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049423; x=1697654223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAZ6+VbsRHgLHkDWNLwQAg5imGErWrF7Ll4HNdeAMO0=;
 b=KCUoQVWZgO2I46791ZxxyZUM+sRYI6eXdRtC9k909WUjte0QpVnNrGs0cVvv9Tvx/n
 IrwQb7zGNU6d9z5qg1aERL7omFSwCufv8qJ3yt98I+Izx/6qr9BiCpoOPCeP0CFdPSXI
 XHSHUNpzooCUFchqPZStBTkFIowlPRBt9vhyuEodqH4s2wSm6Kmfl3mcAjMbIRaLGtzz
 GgBi6hAH1Kpk87GPGdPJD3cqd9sppCcvlsVdbf768CvWVo37keOQTniuZilhFmZWqnq/
 WpsTPaffQb1lMaGqVgiC82I/OZj/Zd7k6N3v5mlhlsJ+55iACtJoYStZCIFCBMsTCuH4
 i/mQ==
X-Gm-Message-State: AOJu0Yz85cCjb/lBCgh+oYOQMCn4SAL40I3WcmlGdyw/2e/bt7uA9Ee+
 w4I2ZpNN9s2PIt1+sQ+mN+QVpQ==
X-Google-Smtp-Source: AGHT+IGz0zglAn9px9Ouwi9lnXKc/HwTHIvDfjtFw8rfp6xqEbWI7hB/pFPbHPreyuCjWTobVUo9vw==
X-Received: by 2002:a25:140b:0:b0:d99:c500:1f23 with SMTP id
 11-20020a25140b000000b00d99c5001f23mr7407409ybu.3.1697049423279; 
 Wed, 11 Oct 2023 11:37:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 c187-20020a254ec4000000b00d974c72068fsm3953576ybb.4.2023.10.11.11.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:02 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 3/5] arm64: zynqmp: rename overlay sources to .dtso
Message-ID: <20231011183700.GO3119521@bill-the-cat>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
 <20230925080909.365098-4-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QWO++pvK2uXSey27"
Content-Disposition: inline
In-Reply-To: <20230925080909.365098-4-rasmus.villemoes@prevas.dk>
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


--QWO++pvK2uXSey27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 10:09:07AM +0200, Rasmus Villemoes wrote:

> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo. No functional change, as we
> currently have rules for producing a foo.dtbo from either foo.dts or
> foo.dtso.
>=20
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Applied to u-boot/master, thanks!

--=20
Tom

--QWO++pvK2uXSey27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm60wACgkQFHw5/5Y0
tyz+1gv+OsuMTemi5/SzYF8JwfMNYGh0BSzSTUGNxJuAp+Fli0NMEdyIIW2si3b3
NGMMtdg1ScT7A2mZZsHktsXWpOXQ7nXPWHf4VYZwF8PHjyV0GNut/bG/3dLqi0pe
PU2qjX0v55jZR0H+GK6LcZMIlMhGEz+VPUnclLxaMDK2jGa+1s2P6pZMYjjLgb+z
yyCNrjA5RpErb2IfjhZc3s6UNdDtDXKL+y+c8BQl7+eiPnMYyb5ESwPUEk+ZmPWn
T+Ip1uicTqAuPXb6DmQs7opwBgdvbi9jvOVkNsfkNY7uyBNFHYf2k1I7GI7uDlPu
+lA/ETifOs/c9MhCxqjCWBuxuX3D7EDXP1M17Wnf7abQjqWBTrP2ms8yFsI0RwS2
LC2u9lxlMJFPh0Zr41rmOcQ18Td2TXzMlTfEoRe2FUlmktej1EtFwaYwp+WRcwu/
XkFXII4TUwBNwnPtEfTiKnf1c9IHKL+wmnbBdtI82+detXZVJ3XEjpF6TkHXRYRZ
0j5vMS1W
=6yAN
-----END PGP SIGNATURE-----

--QWO++pvK2uXSey27--
