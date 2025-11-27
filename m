Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3912CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 15:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A7C8438A;
	Thu, 27 Nov 2025 16:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HhwQ+wcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E55884405; Thu, 27 Nov 2025 16:26:53 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF268437F
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 16:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-65745a436e6so320795eaf.0
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764257209; x=1764862009; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a1aF8Clddl3jlijcs3WO7IEe2bJTxfwDkZcBKDQzkm0=;
 b=HhwQ+wcD+fOgKj0Vs6Ux4LTssUwGW4i4YoZvITYXsG3WFyq1NX8yTpNapIvefZytpA
 kiNWwFj+nNSA4GQWyyIlw3e15ZecaHba9Nqy6sFhtqviLGsH2O/WRp/t506ISJ8mCrB1
 c4ny5C+jkMAFdbewj32e1VvoCUBnXFnLIzJaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764257209; x=1764862009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1aF8Clddl3jlijcs3WO7IEe2bJTxfwDkZcBKDQzkm0=;
 b=huuGKwcr+rGRcv47fbkl1VgHxTEhKUKI1kVujwrfY7W+03XoykgOxyLufqsgBAjeHS
 FoGW3ZPDc6/g6K8SOmyt5DGATknvbiypRSSa5Onu78rnKs2GR9pmPCFZAKPqqtXKhPiq
 U1QBYtzN8Uag3GacDNsXCgt+D22yhZmIzy+9iyxJTM7FJAZTLDFJDt5kcxXaoq/5Lrzu
 i0ztLC4q2aymBCvsqD76IK2jO2K4iUrQfmqEBNTRIZN/sO1FCpLJo1iaJ14KS4IfrClM
 wrfWTx/bIvvA5rZDsdZSEh6PsYlmrlP4swoHR6Ay3qSUaMg8B+AJW6M05OVg+fePzQDa
 CWKw==
X-Gm-Message-State: AOJu0YzBLodPMtFLzwBTIbhZwBR0I7L/BvjRPGxM4By7IFnxwAbhfcTw
 kbZ4dz/uUVxbFgivf+MmrL6RXPmOzg1l+yKj8/mYHAj4I2rGM+errHiKE7nPCghDjvs=
X-Gm-Gg: ASbGncv8wk37RD3K+EiPIWuMQb70WZLHGv1PAfsXvVx/gdIk5FCyK4ujEaypcXymoTb
 l3lk1ygwl7XS5sEzih9s9tVgBtN6l56rnxFlPMDifePjjaM1LB1TDKaRA+eSiSxURiv30oOGUOV
 HP6Ztq1CDUV67UoEV/mc2gfpoIDberwRD6DKpqlnMVHMMriXHoOFsbDBfsnTZaSy8V1Qykgox13
 hEKNpMcPBfX6J+fLt5s1akiGq32GiTg03NmzXSVDoI3ecxVd1S7sAhrM3SuwnZ0KLxhs5Kn0xz5
 KRZD9lAPdVtl8St6alSz+idIcQPczuDCEFn3aoClQ9hWlM4hUpg9LLcNzFjLH8T5RoEOfJDErRu
 BZtWZIvWO9X50kMuKNsByioTDl/hWU2/+QTw1e1ILRxin97983SZuX6uyKw+SCVr0QLfCut3MgX
 BrC5cPRmbgN7Lq+bs9V6P+1zbNFnaouRRBr/0uluEBpt6+3C1rl/nUBc1l6BBM
X-Google-Smtp-Source: AGHT+IFiAoCOF3LA833begbgYHzS8UzuVhupmqRxQ14ruuj3MepXmR5vbslCujq6N68ae8ETg51Xjw==
X-Received: by 2002:a05:6808:1917:b0:450:bab2:4ae9 with SMTP id
 5614622812f47-4514e79d652mr4390424b6e.36.1764257209433; 
 Thu, 27 Nov 2025 07:26:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170ce788sm456493b6e.16.2025.11.27.07.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 07:26:48 -0800 (PST)
Date: Thu, 27 Nov 2025 09:26:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriana Nicolae <adriana@arista.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de,
 xypron.glpk@gmx.de, kojima.masahisa@socionext.com, richard@nod.at,
 semen.protsenko@linaro.org, joao.goncalves@toradex.com
Subject: Re: [PATCH v5] boot/bootfdt: Add smbios3-entrypoint to FDT for
 non-EFI boots
Message-ID: <20251127152646.GA4101527@bill-the-cat>
References: <20251120085057.549221-1-adriana@arista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nsr4a2CF2Dbfr1S8"
Content-Disposition: inline
In-Reply-To: <20251120085057.549221-1-adriana@arista.com>
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


--Nsr4a2CF2Dbfr1S8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 12:50:57AM -0800, Adriana Nicolae wrote:

> From: adriana <adriana@arista.com>
>=20
> The Linux kernel can discover SMBIOS tables through two primary methods:
> 1. Via EFI tables, when using EFI boot;
> 2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> device tree.
>=20
> When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
> "bootz", or "booti"), the kernel relies on the device tree to detect
> the hardware. If SMBIOS tables are available in U-Boot, they should
> be passed to the kernel via this device tree property.
>=20
> This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
> address into the device tree if there is a table generated by U-boot.
> The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
> for specific boards to select custom SMBIOS addresses.
>=20
> The changes in this patch are added in the context of supporting this
> device tree property in linux kernel:
> https://lkml.org/lkml/2025/10/24/1393
>=20
> Device tree schema was updated to include the "smbios3-entrypoint" node
> in pull request: https://github.com/devicetree-org/dt-schema/pull/177
>=20
> Signed-off-by: Adriana Nicolae <adriana@arista.com>

A small thing I had fixed up, please reset the patch author to your full
name as well. A bigger problem is that this breaks the expected output
of fdt_test_chosen:
https://source.denx.de/u-boot/u-boot/-/jobs/1313270#L255 for example.

--=20
Tom

--Nsr4a2CF2Dbfr1S8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaShtsgAKCRAr4qD1Cr/k
CkOIAQCelMOtp2Wkgj7Fietdyjfz2KWX0WD/m7+UxoGmfS6bBAD/Xqglvpd8rtIv
cq/k3V8oAwEsPiAbShXxZK7V/PEFaQQ=
=60cv
-----END PGP SIGNATURE-----

--Nsr4a2CF2Dbfr1S8--
