Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94163F364B2
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 19:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A57B840D8;
	Thu,  9 Apr 2026 21:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ippA9PaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F25D284105; Thu,  9 Apr 2026 21:15:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC4A84099
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 21:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775762124; x=1776366924; i=xypron.glpk@gmx.de;
 bh=nXQpj15PK4RBNbj0s8doGxbODSmTAwuizDX6H7aNQh8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ippA9PaAMCC/IdxcCNHBPd99tFcD4QHlTfEHDOEd/Lszg0DETWTip9fiE/AyY/tg
 dQkjK3BbhEoiZniG2xD5YU1pH/BClviFF/LbJ7NA+wMMVHKZs9SJKJ3SE/mKZXKFj
 /0DnY+f6avDII2n8/2r4Z9MUZ60+yljO/aByKUSoHUzSzao3ZAmZK+u3N2NtWjIS1
 kQGuGQmXdFFUd/iA5L43AcBBVU0yJiPHy1tpdMdJpqKNvEhyNtAGzgNhb8LIoCSB4
 czQqvFNfFtEgysw0ilh6sbMzuYEc+8pQ38YK1TOayAhxDErk2sC0RGU+PRfYZZ1jR
 PAXpk+EzpMasBnUFMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1vmGLS3Pcf-00it5L; Thu, 09
 Apr 2026 21:15:24 +0200
Date: Thu, 09 Apr 2026 21:15:20 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: rs@ti.com, robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com,
 afd@ti.com, ilias.apalodimas@linaro.org
CC: u-boot@lists.denx.de
Subject: Re: [PATCHv2 1/5] lmb: add LMB_FDT for fdt reserved regions
User-Agent: Thunderbird for Android
In-Reply-To: <20260402205038.4005350-2-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
 <20260402205038.4005350-2-rs@ti.com>
Message-ID: <1708BDA8-C314-4359-B02A-9544FDB984F5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1INf7rZzzL+nAIcNLm4pCDgNuFJyTDPjye+VTyEQMJ4ypWKfsLs
 6hyrCXy67x0Gkjj21ybC3AOW0JuCXu+WltrjWN1eBsVkoL8ci7LXHiiYEuTY6Re0rn3nUkN
 vLLHyjH0V9LwQ7mqvw8z/dDqGT8p3uJcPtrqKgHPawQmnM0g0JLFLeZ2M7enpLBbpHYvTGS
 ldC3nraCEb+sNaXHiKkrw==
UI-OutboundReport: notjunk:1;M01:P0:UyDEmJZOjZU=;6mlrwzYzxf0fS1uny/pWBnyh5B9
 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
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

Am 2=2E April 2026 22:50:34 MESZ schrieb rs@ti=2Ecom:
>From: Randolph Sapp <rs@ti=2Ecom>
>
>Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
>parsing a new device tree and properly warn people when a reservation
>overlaps with an existing allocation=2E
>
>If we don't at least warn the user of these reservation failures,
>there's a chance that this region could be freed and reallocated for
>something important later=2E
>
>This useful warning mechanism was broken in:
>5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reser=
ve_region()")
>
>Signed-off-by: Randolph Sapp <rs@ti=2Ecom>
>---
> boot/image-fdt=2Ec |  5 ++++-
> include/lmb=2Eh    |  7 +++++++
> lib/lmb=2Ec        | 25 +++++++++++++++++++++++++
> 3 files changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/boot/image-fdt=2Ec b/boot/image-fdt=2Ec
>index a3a4fb8b558=2E=2E0f5857f24d2 100644
>--- a/boot/image-fdt=2Ec
>+++ b/boot/image-fdt=2Ec
>@@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size,=
 u32 flags)
> {
> 	long ret;
> 	phys_addr_t rsv_addr;
>+	flags |=3D LMB_FDT;
>=20
> 	rsv_addr =3D (phys_addr_t)addr;
> 	ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
>@@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size,=
 u32 flags)
> 		debug("   reserving fdt memory region: addr=3D%llx size=3D%llx flags=
=3D%x\n",
> 		      (unsigned long long)addr,
> 		      (unsigned long long)size, flags);
>-	} else if (ret !=3D -EEXIST && ret !=3D -EINVAL) {
>+	} else if (ret !=3D -EINVAL) {
> 		puts("ERROR: reserving fdt memory region failed ");
> 		printf("(addr=3D%llx size=3D%llx flags=3D%x)\n",
> 		       (unsigned long long)addr,
>@@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> 	if (fdt_check_header(fdt_blob) !=3D 0)
> 		return;
>=20
>+	lmb_free_fdt_regions();
>+
> 	/* process memreserve sections */
> 	total =3D fdt_num_mem_rsv(fdt_blob);
> 	for (i =3D 0; i < total; i++) {
>diff --git a/include/lmb=2Eh b/include/lmb=2Eh
>index 5d5f037ccb9=2E=2E1b59a63f61d 100644
>--- a/include/lmb=2Eh
>+++ b/include/lmb=2Eh
>@@ -25,11 +25,13 @@
>  * %LMB_NOMAP: Don't add to MMU configuration
>  * %LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
>  * %LMB_NONOTIFY: Do not notify other modules of changes to this memory =
region
>+ * %LMB_FDT: A FDT reserved region that can be reclaimed if the FDT chan=
ges
>  */
> #define LMB_NONE 0
> #define LMB_NOMAP BIT(1)
> #define LMB_NOOVERWRITE BIT(2)
> #define LMB_NONOTIFY BIT(3)
>+#define LMB_FDT BIT(4)

Please, document the constants according to https://docs=2Ekernel=2Eorg/do=
c-guide/kernel-doc=2Ehtml#object-like-macro-documentation =2E  This allows =
Sphinx to generate the API documentation=2E

Best regards

Heinrich

>=20
> /**
>  * enum lmb_mem_type - type of memory allocation request
>@@ -215,6 +217,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_si=
ze_t size, ulong align);
>  */
> long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)=
;
>=20
>+/**
>+ * lmb_free_fdt_regions() - Reclaim all LMB_FDT tagged reserved regions
>+ */
>+void lmb_free_fdt_regions(void);
>+
> #endif /* __KERNEL__ */
>=20
> #endif /* _LINUX_LMB_H */
>diff --git a/lib/lmb=2Ec b/lib/lmb=2Ec
>index e2d9fe86c14=2E=2E18703212afb 100644
>--- a/lib/lmb=2Ec
>+++ b/lib/lmb=2Ec
>@@ -669,6 +669,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u3=
2 flags)
> 	return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
> }
>=20
>+void lmb_free_fdt_regions(void)
>+{
>+	struct alist *lmb_rgn_lst =3D &lmb=2Eused_mem;
>+	struct lmb_region *rgn =3D lmb_rgn_lst->data;
>+	long ret;
>+	int i =3D 0;
>+
>+	while (i < lmb_rgn_lst->count) {
>+		phys_addr_t base =3D rgn[i]=2Ebase;
>+		phys_size_t size =3D rgn[i]=2Esize;
>+		u32 flags =3D rgn[i]=2Eflags;
>+
>+		if (flags & LMB_FDT) {
>+			ret =3D lmb_free(base, size, flags);
>+			if (ret < 0) {
>+				printf("Unable to free FDT memory at 0x%08lx",
>+				       (ulong)base);
>+				i++;
>+			}
>+		} else {
>+			i++;
>+		}
>+	}
>+}
>+
> static int _lmb_alloc_base(phys_size_t size, ulong align,
> 			   phys_addr_t *addr, u32 flags)
> {

