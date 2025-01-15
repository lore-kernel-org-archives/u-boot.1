Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C196EE77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 02:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276C28069A;
	Wed, 15 Jan 2025 03:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="BdnZqr3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B68806D4; Wed, 15 Jan 2025 03:22:10 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABEA80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 03:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250115022152epoutp02c06229c85a1c40e3559c81bb68a64416~avFyclZ_A2095320953epoutp02d
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:21:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250115022152epoutp02c06229c85a1c40e3559c81bb68a64416~avFyclZ_A2095320953epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1736907712;
 bh=IHSxOV0Fc8EPPZ6uwQn+56BUpEpvabDl6wXc5HjKH+o=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=BdnZqr3PFvHSpFChNvP/60W+P/DV1BhZJPLje4XKO8uSUkjwMlJShhEhSW+4N0hKu
 jU29UUfhF48yMDjulXaK2VZ79/mPKP/oxsKCjiDcJ025IJlzP4u1DaNAADVF1GDoct
 yb5+Wsw1g2BQ/EwIs03QhSJZSiPO9YyTYR9n981Y=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20250115022151epcas1p411ed8f47b92826e172406e4c9d1204a3~avFyGFF5F1170111701epcas1p4G;
 Wed, 15 Jan 2025 02:21:51 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.233]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4YXqWL6VLgz4x9Q9; Wed, 15 Jan
 2025 02:21:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 3F.8F.23425.DBB17876; Wed, 15 Jan 2025 11:21:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20250115022148epcas1p1b26c92279fefa4f53ad679890e3721aa~avFvOW4R81371913719epcas1p18;
 Wed, 15 Jan 2025 02:21:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20250115022148epsmtrp2a6e867ade5c94bb8f5f2989a2ed253a5~avFvNkUM70443304433epsmtrp2Z;
 Wed, 15 Jan 2025 02:21:48 +0000 (GMT)
X-AuditID: b6c32a39-967e870000005b81-74-67871bbd1149
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DB.02.18949.CBB17876; Wed, 15 Jan 2025 11:21:48 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20250115022148epsmtip20c37a0dc71dcf4fac64c17304c611609~avFvAB_Ad0084200842epsmtip24;
 Wed, 15 Jan 2025 02:21:48 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Tom Rini'" <trini@konsulko.com>, <u-boot@lists.denx.de>
Cc: "'Peng Fan'" <peng.fan@nxp.com>
In-Reply-To: <20250115020737.230558-1-trini@konsulko.com>
Subject: RE: [PATCH] mmc: Kconfig: Correct dependencies SDHCI ADMA options
Date: Wed, 15 Jan 2025 11:21:48 +0900
Message-ID: <024301db66f4$3af88320$b0e98960$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEsYfZJWsKashkyP9MBYkRpZOCHKAFBYuxNtGsZRNA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmvu5e6fZ0g+75UhY/Vn1htZg6aTO7
 xdu9newOzB6vDqxi9zh7Zwejx8Z3O5gCmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjPerXrPVnCCu+LapVbmBsa1nF2MnBwSAiYSD35/
 ZO5i5OIQEtjBKPH21i1GCOcTo8SW4ztZIZxvjBLH301mgWm5s+ccVMteRol7rW1sEM5LRomT
 J7eBVbEJ6En8X7SQGcQWEbCV2Df3LzuIzSygLHHgz20wm1PAUmJ61z02EFtYwEtiwftmsF4W
 AVWJWTsuMoHYvEA1F3tuQm1WkPj5dBnQSRxAM60k5jyvghgpIjG7sw3sIAmBXewSlw8eYoKo
 d5FY39TEDGELS7w6voUdwpaS+PxuLxtEQzOjxNIlB1khnB5GiX8N19kgqowl9i+dzASyjVlA
 U2L9Ln2IbXwS7772gB0hIcAr0dEmBFGtInHp9UsmmPl3n/yHKvGQOPncDBI+QNMvrT3COoFR
 fhaSu2chLFjAyLSKUSy1oDg3PbXYsMAUHpXJ+bmbGMFJTMtyB+P0tx/0DjEycTAeYpTgYFYS
 4V3C1pouxJuSWFmVWpQfX1Sak1p8iNEUGJATmaVEk/OBaTSvJN7QxNLAxMzI2MTC0MxQSZz3
 wraWdCGB9MSS1OzU1ILUIpg+Jg5OqQamDc80r1ubZx+svVa+7ebKS69OzzF5cuqK/s37RqyW
 s781pwevmvNt+4EKQzXuQ72nb3d905OfOm/ajOcfztsGc95YEi9/Q15UYbbotWnHN5utDWNp
 +cP5LTNqu5bY7H+Z72vExGxNLrInv4ub11txoSzozLOOxFNsb7Z+ebGcX6Er/aW5WZWL3pcs
 R9vigoYHGdU16g/lCyoWO/1Mr7rzZlPXhRsvJ08V/2Ib99zax2NK+/qV24T3Te6Jy7Q85X7s
 ZZjG7OdM6RueKtSVRp/eXP1f6RF38bfDl51P3rr867cv/z4viR0W04sTmxaLHG8+mB2+neO3
 8O9cj2cz/bmt7pTEZK080/zkjfiFuEwnFyWW4oxEQy3mouJEADm9oFvrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSvO4e6fZ0g1cH1S1+rPrCajF10mZ2
 i7d7O9kdmD1eHVjF7nH2zg5Gj43vdjAFMEdx2aSk5mSWpRbp2yVwZbxb9Z6t4AR3xbVLrcwN
 jGs5uxg5OSQETCTu7DnH3MXIxSEksJtR4uO852wQCSmJz0+nAtkcQLawxOHDxRA1zxklPv1s
 ZAepYRPQk/i/aCEziC0iYC9xuKsTrJdZQFniwJ/b7BANXYwSP+/fBUtwClhKTO+6B2YLC3hJ
 LHjfzAJiswioSszacZEJxOYFqrnYc5MF4ggFiZ9Pl7GCHCEiYCUx53kVxHwRidmdbcwTGAVm
 IXEXMDKuYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDkEtrR2Me1Z90DvEyMTBeIhR
 goNZSYR3CVtruhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTByc
 Ug1Mh2T0Hi4yOae91sbW6GcmS2Wat4Xn1V/720+FmJxNtvqpNqn3Bo/dnit8CXKdvS+qDmSn
 5l47+bLmyGyXg/VORgyP1mwVeL805+LetXyGFx2Kf6utjbi08BbPxjV99l02i/g7b9e1MLj9
 53Pz672f4DE1aEZdAcM5iyNTXmxjF2FYxJ+xvfp8n52mgf7a0K+KyvznVNe+SWBJPCBi9858
 0wfz1Slr29cEKkza2rLEW9bq7r777J6nktjSvAoX9nELpV668+vQhSMbmsTf9kZu+r5Zf7to
 dMipw8xXd+2f3Lr95gen6175pTHzHcWa+ve4Gs5n+7yg/fDM3RznHs5/NfMLD0t8xd8/769b
 BG9mUmIpzkg01GIuKk4EAOdsfY2wAgAA
X-CMS-MailID: 20250115022148epcas1p1b26c92279fefa4f53ad679890e3721aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250115020743epcas1p1be3492abc3a2435f603c7b2dd14be15a
References: <CGME20250115020743epcas1p1be3492abc3a2435f603c7b2dd14be15a@epcas1p1.samsung.com>
 <20250115020737.230558-1-trini@konsulko.com>
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Wednesday, January 15, 2025 11:08 AM
>
> The option MMC_SDHCI_ADMA_FORCE_32BIT is only tested or used when
> MMC_SDHCI_ADMA or SPL_MMC_SDHCI_ADMA is enabled. And for
> MMC_SDHCI_ADMA_64BIT the same is true except we also require
> MMC_SDHCI_ADMA_FORCE_32BIT to be disabled.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index f4fdf15242ce..6dc8d3bf9fe2 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -527,6 +527,7 @@ config SPL_MMC_SDHCI_ADMA
>
>  config MMC_SDHCI_ADMA_FORCE_32BIT
>  	bool "Force 32 bit mode for ADMA on 64 bit platforms"
> +	depends on MMC_SDHCI_ADMA || SPL_MMC_SDHCI_ADMA
>  	help
>  	  This forces SDHCI ADMA to be built for 32 bit descriptors, even
>  	  on a 64 bit platform where they would otherwise be assumed to
> @@ -536,6 +537,7 @@ config MMC_SDHCI_ADMA_FORCE_32BIT
>
>  config MMC_SDHCI_ADMA_64BIT
>  	bool "Use SHDCI ADMA with 64 bit descriptors"
> +	depends on MMC_SDHCI_ADMA || SPL_MMC_SDHCI_ADMA
>  	depends on !MMC_SDHCI_ADMA_FORCE_32BIT
>  	default y if DMA_ADDR_T_64BIT
>  	help
> --
> 2.43.0



