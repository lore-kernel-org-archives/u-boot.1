Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14054C36008
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 17:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639FE805C3;
	Mon, 24 Mar 2025 18:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e9P//lJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E22805D7; Mon, 24 Mar 2025 18:18:42 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFCDB800C1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-601c12ac8d0so2374315eaf.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742836717; x=1743441517; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v92f7VrrqN/dCTS9znnFlBBmVH8MSj0pZ/vsO5UV5Iw=;
 b=e9P//lJpzsoycINHH38526JQZH9asWEAYjgXhBT6CQOAd95Id1CfZE5nHcs/yzCNPQ
 0+TollfIBtvkF/4mJFy1hmnjdmb21/hpPt3aytlGy8E1YdyGy0i0vrvZ+9fbYqREh2B/
 2I9SrqPSVmgt6d46dc9ai86dnjpnCFfJvRTIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742836717; x=1743441517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v92f7VrrqN/dCTS9znnFlBBmVH8MSj0pZ/vsO5UV5Iw=;
 b=Zthl1z4P51LdV1gQ6XCMXwjZ38/PDs7GpBwOrWgyUnfkn2ekXWuBnYURgKlZCFY+1W
 Swm0plBc3NhqC7miRiRgg47gAxQphSaFtnhVMr0KD+XOG5emNFPKpmGVzsSIkrxZXqAs
 8Z60RPTGfYbNIMLJhFKr6IdeojtPnKUNnsLW2+8PcopHA52KvkhfUisMydQ0/Mw/1L8H
 DmLzui9ZbQcdb/PKgMFXi7FiIR6E4dowOV2PgCkN1WwSGf0oswwbu9WwB8nv63hRLCTj
 UV+FoMSThI6szzC0UGuiOPCHxppMn4wFO2NFSnquvMgd1UAAP5IQfL1IaudgbdaTCxfv
 rpHg==
X-Gm-Message-State: AOJu0YyElAUbXtRaY4TTtJt3cchuNcFfOUHRCeUgmW1w9zitXKdlIrYO
 rJqiZ0fcUM9pIlnkufc57AYBBLn+77PjDJGm2Sw2x/dajyqeYjzjMfvmZGytXs0=
X-Gm-Gg: ASbGncsi0Xa8kfY+BmHnys+GBKfuLha0pFWxTeeucMSn2dJZ8kEViSlO8h7Vf08NIXv
 +MnTIgnVs540OJevNh4PZaA1ma4AmUQpknX6L3DapdJ1f27PBX43BTapwa2CY7DXL2iJUPwFe9u
 9/9SJiOxg/QV6Bmmxbd3e/GVFLSVgkVOP78PpozL51QSpIk1Bg4PHUBGy890WyqzTz5wZbY8ImN
 F+oqdfzYcAuqJnnLbSeq3VFsfRPifacA1BZh/I4zHrDePXY+vvsRaHL36rkERNHBj56MlQWhzB7
 IAguG8/qCmpM+A9HuCXDJuw2D+dAsm+Rp8FS7vPOXZ4=
X-Google-Smtp-Source: AGHT+IHyeW6HgYkpoeEvXrpeKw/KlKNki7iOM2rCnVAh+f61tlizuUL5uu5lzy0BovtjOo5nYYsdew==
X-Received: by 2002:a05:6820:760c:b0:5fd:50d:49e4 with SMTP id
 006d021491bc7-6023461f2camr7044224eaf.7.1742836717408; 
 Mon, 24 Mar 2025 10:18:37 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60259f6fe72sm187724eaf.36.2025.03.24.10.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 10:18:36 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:18:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: pmic: add fall through comment
Message-ID: <20250324171834.GA93000@bill-the-cat>
References: <20250324171243.576862-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8afqkkScJWbwmdfL"
Content-Disposition: inline
In-Reply-To: <20250324171243.576862-1-heinrich.schuchardt@canonical.com>
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


--8afqkkScJWbwmdfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 06:12:43PM +0100, Heinrich Schuchardt wrote:

> Make fall through explicit via comment to allow building with
> -Wimplicit-fallthrough.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

We should say "statement" not "comment" because it's not=20
'/* fallthrough */' and looking at the linux kernel now, using
'fallthrough;' is the way to go as it will use the attribute when
possible.

--=20
Tom

--8afqkkScJWbwmdfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfhk+IACgkQFHw5/5Y0
tyyoJgwAugFjtA/0wLlcdcTly6f+4Ht+izP7Nc3gfT+KjtfBzA1OCESadD77EcH5
Z6KyMlrStvZKcYq1l192LLuRavIjtJdnUv6TNMIAVGG5F2rZKJgEeXpZtBp8mvtY
0vA0hTiyhcKe/FGbTwjYDRmgs5l9gke0IDi4uPiMFK2fkoxcv36QiUt7ByJJucVw
XDd2mZ/l2LnRJ743V1WgkQwp0/RZY92woz1OwZnV2/PyY3WZmbRWeVUZAsIFW8oK
wIySr7WBdu4NK8nE0NNptwkJU/VrQ7EQb6yLJ+OoyVM+U59h6LSZbv5gPC0BN60Z
cMRdwdNigpQi2ANGLTZ4SZ5Poirt0YxtiYyxtQ1wEX/emsJcHqqFeNVOXooVg0rk
/DvgbQb7xZe9GwzVjaXtyLzudrsjKN0TdDKUaXZmV4oFlvHYkxgFSb23RX2VrT1S
pk1kFOBo70OgXcWDLy0bSR/IqSn8PGF3eaAVnl1delW6YWCbKDc2O2/yRdbNxin5
mKL6hOSS
=oA3D
-----END PGP SIGNATURE-----

--8afqkkScJWbwmdfL--
