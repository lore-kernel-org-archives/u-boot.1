Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE754C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 12:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FB187DF4;
	Mon, 18 Mar 2024 13:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HLedocrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D0E87DF4; Mon, 18 Mar 2024 13:27:19 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 913C887D83
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 13:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6dc8b280155so2771029a34.0
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710764835; x=1711369635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LCTxGxhl+pm09vZa+017b7SLdsj0G97cTPv0psdA+yk=;
 b=HLedocrPtKtR3rrtIx8uTXDHSWp3cizQSM0d8AErWbSjCTuL1C32B7UCSaHhyYx3c+
 4YGpRXJWyHk+6/7W7qWN7K9MrZF9TK26ndmbeX4SoILw5VszohrU3BDxHiUHEobVyNiE
 ICjnEhwMipw/HyuvIt3n43m3UaBpkTMpY69LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710764835; x=1711369635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCTxGxhl+pm09vZa+017b7SLdsj0G97cTPv0psdA+yk=;
 b=WdwKNulfKHkaDeAZPkz1jTaloEeWhgEt2ZGwLw7pLnH9rVPMNbi3CN7ufykLvuRbxm
 bCgIgUqiMBPnLMz8llfyF1ZvnKsJW5BqHyAR8RNg4vQF4SoEzz0gpbc3xg7mPLXjhpNo
 nN7jSWWuQ55RgipbODsMmkMRRndif3n8ORC44FWlFjah70YasQiJ1o3H882IP6W4kLgZ
 eUOjUGz9I5KEHth6TS7GD5ZEVYKaS8NIvrCp+SnFixBibUJC29hVXkVV+gLgJ9rFCOxx
 PJlpTXDzqSMb4/psGn06xn/hCoWE8AB1E028f1ipplfQk7XFkBBT9nJvbY7zIFz3FPc+
 zTCg==
X-Gm-Message-State: AOJu0YzJw0nIO3OWs1yn7Yb9iE0zl9sVHS9IrBx2PWKl7hqct6RWtYsH
 vcqy6FvbmRLOSnarssNabBrciP0osi/oCkRR0PoTyfNhivkDftHzm7WDf52+lOY=
X-Google-Smtp-Source: AGHT+IFAv4eMUtkkf4VTbUO5q6bkuC/zWBQOHjVcP+oCYL8pzle+6Pu587j56EQko2/AjvdwhuhDNw==
X-Received: by 2002:a9d:63cd:0:b0:6e6:66c5:5af1 with SMTP id
 e13-20020a9d63cd000000b006e666c55af1mr10867896otl.26.1710764834835; 
 Mon, 18 Mar 2024 05:27:14 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a0cf585000000b006915b8b37a0sm5287772qvm.55.2024.03.18.05.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 05:27:14 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:27:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240317
Message-ID: <20240318122712.GZ3442575@bill-the-cat>
References: <20240317233420.330902-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yL9tplALfAt1xTsf"
Content-Disposition: inline
In-Reply-To: <20240317233420.330902-1-festevam@gmail.com>
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


--yL9tplALfAt1xTsf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 08:34:20PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull these fixes from u-boot-imx, thanks.
>=20
> The following changes since commit 86fd291a7990af84e96808f48eff2219dd4ef4=
96:
>=20
>   Merge tag 'efi-2024-04-rc5' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-03-13 20:39:46 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240317
>=20
> for you to fetch changes up to e648c4a3455a4d1880efe121602ed90a0bc9b53f:
>=20
>   arm: imx: imx8m: soc: Fix NPU/VPU fdt disable fixup (2024-03-17 18:00:0=
4 -0300)
>=20
> u-boot-imx-master-20240317

Applied to u-boot/master, thanks!

--=20
Tom

--yL9tplALfAt1xTsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX4MxgACgkQFHw5/5Y0
tyzqQAwAuDe9Fi2GpSALaXytXGbQHi5lKERfN+uiMbvsR6+8ZpFO6P51pdggoKMG
XC6DXmPKCmca++ZJGAJhs/cyyQ7C9UgLaXI1NkIHnr+yIOsRb3SohDUk54Xqr7Nz
bfB+WGDWjCYSA4cNk80WHjk1QwQ1DWtHgpblcXPkp+WH8H39PewvGPBgr7rkQcCx
4Sf/OAe4YZT5jrsw/i++AZX22OHT2veuOs0+Ly1w1oENhbyUBrzl700bgvb1CRWo
rs4RNThCCNRLgt1Hk5/mO09e8KXd1OTytaunvokDNWFk/et5yGa/gZ5yKB9AKYK8
m+32CkrCsgJFzna6em9oAmGNHuIusezvlP00AAXbEQrvi0hdAGT8Sp8cgd+v3M7M
MgrB9yV6JsZxxhFxZ+LL61Gltt7AIw/KDR1A4ig05KYqBEaipypgPF3vKfFqU0hW
0zFVsIp7RixHhdjaiMd9HwPyWiBzE5ICfF2PCNFARDEsBY2fZIKq20geO2PEz+Ez
sqkD4NKR
=kawc
-----END PGP SIGNATURE-----

--yL9tplALfAt1xTsf--
