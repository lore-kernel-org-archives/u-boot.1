Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E172EC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C66287FFB;
	Mon,  4 Mar 2024 16:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LOQYK2V5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C3E87FEE; Mon,  4 Mar 2024 16:26:52 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367C587FEC
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5a11dea5bbaso1385690eaf.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566009; x=1710170809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RdSsVqnWDe231kC7q/gIJ7xEY13C2KATihQlI4KetHw=;
 b=LOQYK2V5ZD8Va8bZaHeWrBNWQkStstKgus6Cl2Ty6kxSida5VVIRfUu2Yp8xXeHQZF
 GXbLOoG8oC90yaklqSf0T5jhJ9JpsmcV4/ZUO7XY2EhjTvxef7apqgHT8vGcMZdngB1M
 aS99r315xqVqS7lg/JYE6eaQjnwvRRTfBHvhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566009; x=1710170809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdSsVqnWDe231kC7q/gIJ7xEY13C2KATihQlI4KetHw=;
 b=kfvsYWpCVLvW7jTmxMOPeUaazx5Pvx4xa89oZTOsfNDetAjsCbxCsjbopfD/d05Uvj
 sbkuyO5Acq5muQVde4tnNT0upyFO+OSsW7T/gS2UAK4RhlqJ3uqb8k8ssdEkxl3/qdkj
 yNBnw0JAqsFG0wL34tPHi4HOgvP1sqmlX4p6SkfPTYgbYp3WFsSHWrpgEkFg17cf6pEB
 H6La1CAvZvPBUulxuRJCYwcG7UJ6Cg48B+XzeTITqTHnznCpKlHZqn3DvUc/hLWwseOy
 1tn/sMPBK7m9FV0RGVziCMXSLT+K/2cEKR/AeT1UpcWBDjoYwiW79wT0OUZa29a5BmbU
 Taig==
X-Gm-Message-State: AOJu0YwUN4DCTwlTV/vHSEZLSzFwwCAoOrQdc2KYK1X9XDov4RZc+ZAn
 Q10mbWlT2uCNLVgm3DAqV/oFuMzlmCkLk8xkgXvBIzxoRqAV8FC/fxr8/Cyujpc=
X-Google-Smtp-Source: AGHT+IGyND1IlX1JnEgIa6JAmUMaCZO03p/pEflH2Ii4UzMFcPMMFrtqZVPILkSSVhpSNVbWGFR4FQ==
X-Received: by 2002:a05:6359:4c14:b0:17b:f23a:2548 with SMTP id
 kj20-20020a0563594c1400b0017bf23a2548mr12361982rwc.15.1709566008871; 
 Mon, 04 Mar 2024 07:26:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 md18-20020a056214589200b0069054377816sm4207754qvb.124.2024.03.04.07.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:26:48 -0800 (PST)
Date: Mon, 4 Mar 2024 10:26:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <linux@fw-web.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Subject: Re: [PATCH 03/60] net: mediatek: add support for XGMII interface
Message-ID: <20240304152646.GK1523872@bill-the-cat>
References: <20240122020816.143402-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tdhD6ZAzP2nhg7dn"
Content-Disposition: inline
In-Reply-To: <20240122020816.143402-1-weijie.gao@mediatek.com>
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


--tdhD6ZAzP2nhg7dn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:08:16AM +0800, Weijie Gao wrote:

> This patch add XGMII support for connecting 2.5G PHY.
>=20
> Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Applied to u-boot/next, thanks!

--=20
Tom

--tdhD6ZAzP2nhg7dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6DYACgkQFHw5/5Y0
tyzQwQv+N5/LvZurgczE7Z4tZ/7zMkP+h11op1LzNKSMhovRo5DEXbXd2px98nHm
2FDT0ukkm/mkUD5nLbg3PjUVpX+Y4a8W/XaFINv4xkLIPUpn/vg5NVSeLCyEYYkW
mEEjN0x+jn6/IRXwVxoSIP9ejg6X8mmiCtCFiguh9zaD1rvMHpqYw4HdrbF3pljk
ILKmMp7WlAienTT6RZ+q7i1ij0xxDHwjxg+s/1J6xm7X6iMvbW9uxkiMbKz/lAEq
sRKyrbaJrmabOxqgIfGnsKGPaVxtVHDkaO4X/cay2T6tEYUno5ebf06HibsJHOjJ
o/Z3FDaUDN8TpEC9EttIRQJdvw645XP2nIz14UgbTvNjhuQjNU2SM73lBRElMdUA
inTZDyReTtShCNio3n5/kKtYAsJD5qeE9c22BjCpK9ITWhkwL7KbrGTITr4QdHvp
WbEzuEsQ64Arl3MoUngIPcYZCVniP1Y8KUAXkbKHWc9BbeaxTvzsxMP6/FqaLLJ/
x77pzR8+
=zfaC
-----END PGP SIGNATURE-----

--tdhD6ZAzP2nhg7dn--
