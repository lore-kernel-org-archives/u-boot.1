Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD62CF364B5
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 19:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435FF840D8;
	Thu,  9 Apr 2026 21:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WFmDRrKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF92A84105; Thu,  9 Apr 2026 21:22:18 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6FB84099
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 21:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775762529; x=1776367329; i=xypron.glpk@gmx.de;
 bh=ecIk1IafBuRzaN6PsL0LRxgKxkJeNNqQcitYOKO/Yz4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WFmDRrKj+tVOq9G2NKM7Fr4ugY3P1tjMeVVY+IKFe5SAhxyMppX4qTYMtI84FGRV
 t1AKKCnTmgAif//sN5JIP2uUvGJ4zMUdoc54NtV+RWf0QGenU3UqPS6v8ssyxCx/r
 n/UB9H2CY662Iz1RCK+ch73CFIi0tUXHPr2z483mWra+PSarcK/pv5Iej09q4t4VT
 4v9ESK/iZ77zLy9VH9eYBXPEeLc521IweMTb8H47eYt8+YZ60hVlNYxHtZl9rfLJG
 NNMgMq2LYbp+0+/eXNEjZyBSiPHsRtrpFGd7fLTxY1gi9LdLdlKx+GEi1wpytv04L
 aB3t2DeXWP6XAhH+4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1vJ5qU1WPz-00zFsx; Thu, 09
 Apr 2026 21:22:09 +0200
Date: Thu, 09 Apr 2026 21:22:05 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: rs@ti.com, robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com,
 afd@ti.com, ilias.apalodimas@linaro.org
CC: u-boot@lists.denx.de
Subject: Re: [PATCHv2 2/5] efi_dt_fixup: use fdtdec_get_bool
User-Agent: Thunderbird for Android
In-Reply-To: <20260402205038.4005350-3-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
 <20260402205038.4005350-3-rs@ti.com>
Message-ID: <562280B5-5E46-40E4-85F9-8FBDF6B336EF@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xm0QfwadpIVk44EjsSwaEkp8QIjJGnV9DEDi/1OIbJLUSP2j/IZ
 y/y16qr3d8w+eh5fuC7sbSWS5pG5wHGfXHOwvOtKhEUFPgQCGN50fGTHMWjT9UeXIRDYckZ
 VgHfqxT6daG42Fih7+T4OAPibqDS0pRhLw0xXFpRyCfzwEF7UOBW4sZ+SrpmqV6DUyX46f+
 nySkXG4PupAtGESIfYhEw==
UI-OutboundReport: notjunk:1;M01:P0:VcmTjiW2tNE=;F94g0xvjxDn0TBFVRbJpbZqinDh
 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
 8a
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

Am 2=2E April 2026 22:50:35 MESZ schrieb rs@ti=2Ecom:
>From: Randolph Sapp <rs@ti=2Ecom>
>
>Use the more straightforward fdtdec_get_bool instead of fdt_getprop and
>a return code check=2E
>
>Signed-off-by: Randolph Sapp <rs@ti=2Ecom>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
> lib/efi_loader/efi_dt_fixup=2Ec | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/lib/efi_loader/efi_dt_fixup=2Ec b/lib/efi_loader/efi_dt_fixu=
p=2Ec
>index 544e1aa9808=2E=2E333711b9957 100644
>--- a/lib/efi_loader/efi_dt_fixup=2Ec
>+++ b/lib/efi_loader/efi_dt_fixup=2Ec
>@@ -123,8 +123,7 @@ void efi_carve_out_dt_rsv(void *fdt)
> 			    fdtdec_get_is_enabled(fdt, subnode)) {
> 				bool nomap;
>=20
>-				nomap =3D !!fdt_getprop(fdt, subnode, "no-map",
>-						      NULL);
>+				nomap =3D fdtdec_get_bool(fdt, subnode, "no-map");
> 				efi_reserve_memory(fdt_addr, fdt_size, nomap);
> 			}
> 			subnode =3D fdt_next_subnode(fdt, subnode);

