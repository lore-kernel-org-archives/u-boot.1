Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F9CC282EC
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEC48164E;
	Mon, 10 Mar 2025 15:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tc1/4jRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F5581671; Mon, 10 Mar 2025 15:30:45 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EF38144F
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22355618fd9so77477795ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741617041; x=1742221841; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dQJlVOZkPv+Uj9npZiMePJtUGgUQTnZN16FGfE4jenU=;
 b=Tc1/4jRirrfXlar0GA9DHxCQFGT1u3YOreGnPVn02hFymPe1WhfiJted0rWwJQl8Ja
 5cX9tqnwFfvf98mdR68kkO2S11RS+XqlH5RnIDbQcbXRkilRLTzghzVDqoXYe6J1nHfz
 xILdlVspANT039I7ASagct1P39OvlY0596tZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741617041; x=1742221841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQJlVOZkPv+Uj9npZiMePJtUGgUQTnZN16FGfE4jenU=;
 b=rRECs8aGrAwfFu7G6coLr//TCt9LeO7GSg4rmOOxhC2dWDzdQkOuKjlgLyV4+ZQZRL
 ITkLd1+ghGPkhYZNsafARZUQV8NLIcPVvDwd/450ynA11O2j7WWMXG5x5UdD3VBTDPBd
 A/FuFO9BHu9buRo105SfBcHzUDoufHwGIpzVC7dMUktsHhgIO1zq70pwPonR0EXVMqWt
 yHrgHfSpg5xtA1QkMubw1b/fBpT8411EKRMlHxCgv6ayhfg9Gn7n4Y8qrmqoJtqMzgVX
 sbrlH5agSGSprgX5Zh9PnM9fCEG+jwl7sxtuF2krpPTBouxRhc3FTXyBgtl6Hu9Msfoc
 kwGQ==
X-Gm-Message-State: AOJu0Yzt/rMc/mflKlv/FSqaRWrs3w2zXRljdForqWKohqxc+Y8x25ZN
 4NXM6cu+sSNceAmVN2I6iYgpod+1vQ9qW/39lb4OgGTU5NCBA0ISGWSChoEbsNeAQiIqgIyiZcu
 O
X-Gm-Gg: ASbGncsQZ0MgmbCgQELdLQZg1jXJnG7ZKW1hvRNLpBKwyQ4DHjsUL1p1xW/JSnBzACW
 f4ClScubgOBC/W0sYV5mhqtkAsV7r0iEu+HibG3Fj17aAR8OLsfZ54BW/jk6knK6HRncrf8fSdv
 oTyMep/Q4pWmltW1PCT95Vk91jQuQunoCWuPHeRF+wLsX+zm8rqZS+pbklmXNFPxrMskdoYwGkb
 1KE0KyBvDCRNn1spQjoTjfy5tA/aM5FvRPAD/ykva90qF3QCG/W3zJwEaXV+9l3Txd1gCzdaayy
 8Rd+4YFffXQaEo6dqrCiBX6O3waj9hHxK2ZkfUpOE/orlg==
X-Google-Smtp-Source: AGHT+IFo1Jeao3aSUQUsRb26lVUAI4iwERowHrqTsdBDoNpMoYjeAC5bVwNPVH9d8E77eAE5g8PQag==
X-Received: by 2002:a17:902:e5cb:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-22593184dbcmr803495ad.42.1741617040799; 
 Mon, 10 Mar 2025 07:30:40 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e9403sm78671505ad.64.2025.03.10.07.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:30:40 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:30:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
Subject: Re: [RESEND PATCH 1/3] pci_auto: Downgrade prefetch if necessary
Message-ID: <20250310143037.GB2640854@bill-the-cat>
References: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="auj3zXIqABay8CDh"
Content-Disposition: inline
In-Reply-To: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
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


--auj3zXIqABay8CDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:01:32AM +0100, Patrick Rudolph wrote:

> Legacy PCI devices, like qemu's Bochs VGA device, are allowed to have
> prefetchable 32-bit BARs, while PCIe devices are not allowed to have
> 32-bit prefetchable BARs. Typically prefetchable BARs are 64-bit and
> typically the prefetch MMIO window is also 64-bit and placed above
> 4GiB, as it's the case on qemu sbsa-ref.
>=20
> Currently the U-Boot code assumes that prefetchable BARs are
> 64-bit BARs and always tries to assign them into the prefetch
> MMIO window.
>=20
> When a 32-bit BAR is marked as prefetch, but the prefetch area is
> not within the first 4GiB of the address space, then downgrade the
> BAR and place it in the non-prefetch MMIO window.
>=20
> For prefetch BARs there's no downside on being placed in non prefetch
> MMIO areas, besides the possible slower performance when a driver tries
> to map it Write-Combine.
>=20
> TEST: Fixes pci_auto on QEMU sbsa-ref fails to autoconfigure BAR0.
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Do we need this series for v2025.04 or v2025.07? Thanks!

--=20
Tom

--auj3zXIqABay8CDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO940ACgkQFHw5/5Y0
tyzrcgwAhPR73A8AUO3VMz9d6i8813vU9uTZ2Lou/pM3uGxZzxU9Cd9AP+fTLaRe
2aEk5pqMVJVRdnf/hkEXlDmrs07TrK75A2+95poGCG1GgTzQb90nMwLbCp0UeQov
hA4PfuTlvv1jw5aN7dPoqvhea/XTTo+8QQRewiz/5se/Kjo6D/y41+h20yqYa25z
EQI1OBjSnpvVqhWICCICJ37cDtvyI2uP7bebD1JdroKM/IPgYJoF+p70QYRJ/PUx
Zk1jx2SMnZ7NMjYfVVva2mpTfTYjAcSfMPcOWfNRu1yQI5E/0M8moGPrgsrJ8AOg
09d2AYgGxYX281ZgMlhym6cqAJloBCcIVFe5gngZP/tMiZzaCSO1+TWopP6iYylE
yj7c5CBvYMzCdwlOrQhwbnyp+Kh+Zcq2570AqvvPklzCRu0OdloCCoQlYBkmOBTM
7ESXcH4PKbUrNXKtjLQ4cwr5aT530tKdq8HHify40j7dc0UulEVV9h7Jrp38kHp3
2yfeyhV5
=NJ/A
-----END PGP SIGNATURE-----

--auj3zXIqABay8CDh--
