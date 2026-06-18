Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3513CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32336849BA;
	Thu, 18 Jun 2026 13:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R04U/PoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30935849C5; Thu, 18 Jun 2026 13:57:08 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10038849BA
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4645995069bso316671f8f.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783825; x=1782388625; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hqJn4tYLvAuzgVrz2qdpf1rIoqtz2jYQiJlMQ6hjZOk=;
 b=R04U/PoXyUKQbu5JOn9YklTVq/f4oH+48AicEs903egG6bUXHJ0wkmj1a3UOrq/Zoa
 x9TyqY2nZNJDlD2j7RiDNRGCuK01royQorntwXPLTZK7s+eETpVauTP463TQi/NzFxno
 TYXx8O10AIuF62zBz5MlJbA7LyP8upxvWeqYwJMTnASERcB8F77AEXqa7nmiU2/fCBvG
 uGce1qReVgg9K6xkA1rWpyPzqQil2v1qdd63t0mRosHHQOopVdFGCA9+ms7JE89Lmbmd
 JD0+SokBBFGmHUuC1ON89Vj4NBPdy951AUCeHYl3OGpX0kOqEOFLRjo49D2fxgJqNFzE
 NwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783825; x=1782388625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hqJn4tYLvAuzgVrz2qdpf1rIoqtz2jYQiJlMQ6hjZOk=;
 b=XaBnaAOS7FNUI7O/z9G9/FuOIa9FTwDYxGkamzPA4F8TwozGQmCdLfc68OnZEdNpDN
 xUajSb7aJJLcFBKjKW/LsrrIv7NPlvBAzmaWM4d64ftiAFNTpM4za5mv55ouPIhu2S67
 y74OR2ora1moOL1NZ0QUOj4pgzbvQZh7wIZwHV2nheRUIHLrbqwPcP9LcjnKIyqf8A7R
 UzY5wrt73RO+ctQjI6R6LTYyvppBV6OmpRCOTwnOk3KuKU03BMgv1r1PI6Qz5TZneXBH
 fJjhfG3RqQrf1MgSFRtrU8ye8qqwPND0A09KzlGM7DVL9gJ3CkV0veV0UvB2hrvsitzx
 RoQQ==
X-Gm-Message-State: AOJu0YzaHlO/MZGc9F5minOhwTGEVLixsjZSJAH5X1pUSagd5jYzIlKl
 4zG6jEUN57g2Wj4ni8Rdvnao1vpwA8M8V9uT/M4k8S6BXQD3YVDEZcmRnkIjZr05NQ4=
X-Gm-Gg: AfdE7cmTFNLq4CIwEEi2onbWkp3sCO9qVvjwG8kYJa2LJFpbIBlQI7OnCbNiFeOdqNW
 UuerVOPHiHz3kwEB2m0WyHL6088eRjJfYoJcKYgvA/PZSl+vFXXolZPRiexf8tOGuHR3sMJdgR6
 QhUW0hqR/3GtonhKUXkvwQA0U53SNVZivvPzPTMy0P8xb27M0iqPXMnVEXB2kmAAGxaDyZ4PHn3
 5q859UMjqVkQkbwC5LqVNifuCR15/wDNYtyFvcfYuTnkPadJ8uavMT5WPk5gv6wIfplYTfxqdPU
 0833XHK6/PNbNOfpclNBwtxhggNGJ7Cx7+DiTEkxzTHltfbboPWvUw4hs2Ep4YvuBjsy4Sh8isl
 00thjXZSfJ7TW2sK8gTLyUSWBnuIExFim385dGoFcCSACEHLgR476vDwu7RfBJDwnbpNzhMKqsd
 ZW279vnuE4C8AWdlCwnakirHwaHCZiBDqXyGh33x/7/JBGoW/x77WyC64=
X-Received: by 2002:a5d:5e01:0:b0:454:35b9:803 with SMTP id
 ffacd0b85a97d-463ad3e2b55mr5017342f8f.30.1781783825389; 
 Thu, 18 Jun 2026 04:57:05 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:04 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:56:53 +0200
Subject: [PATCH v3 05/15] mach-snapdragon: fix reserved memory carveout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-5-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8045;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=V0wY2sKJkB0KB6ckwYth9o3VZ12mEa2TGbI19ixmz68=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizjuyyem6sdrjRmhZ1+6nf8LPMBro2RbEXHzHdfD17no
 i/SlLGio5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEykV4fhf0nJ8vTL77cLRM8O
 aN+8bU/PPp99fj0Os6dXn5TYvlHIbTvDP4NP+3MtRI9xbnvBF3eQ600hu6xiVFXF2VvhKz/1JrG
 mJwAA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The memory carveout logic was fairly limited and had a few issues,
rework it and teach it not to unmap regions that have a compatible
property (since they may be used in U-Boot) or that don't have the
no-map property.

The carveout process adds ~5-50ms to the boot time depending on the
platform.

This prepares us for using SMEM as a source of truth and improving
support for U-boot as a first stage bootloader since SMEMs memory map
doesn't already carve out some regions like ABL does.

We take a fairly heavy approach of aligning regions to 2M granules which
drastically improves performance, this does run a strong risk that we
will impose on regions that drivers might need to use (notably smem and
cmd-db) however since those drivers already explicitly map themselves
this isn't a problem.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 95 ++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 829a0109ac78..3cffe4bc2af0 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -622,27 +622,36 @@ u64 get_page_table_size(void)
 {
 	return SZ_1M;
 }
 
+struct mem_resource_attrs {
+	fdt_addr_t start;
+	fdt_addr_t size;
+	u64 attrs;
+};
+
 static int fdt_cmp_res(const void *v1, const void *v2)
 {
-	const struct fdt_resource *res1 = v1, *res2 = v2;
+	const struct mem_resource_attrs *res1 = v1, *res2 = v2;
 
 	return res1->start - res2->start;
 }
 
-#define N_RESERVED_REGIONS 32
+#define N_RESERVED_REGIONS 64
 
-/* Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
+/* Map and unmap reserved memory regions as appropriate.
+ * Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
  * On some platforms this is enough to trigger a security violation and trap
  * to EL3.
+ * Regions that may be accessed by drivers get mapped explicitly.
  */
-static void carve_out_reserved_memory(void)
+static void configure_reserved_memory(void)
 {
-	static struct fdt_resource res[N_RESERVED_REGIONS] = { 0 };
+	static struct mem_resource_attrs res[N_RESERVED_REGIONS] = { 0 };
 	int parent, rmem, count, i = 0;
 	phys_addr_t start;
 	size_t size;
+	u64 attrs;
 
 	/* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
 	 * attempt to access them, causing a security exception.
 	 */
@@ -650,15 +659,21 @@ static void carve_out_reserved_memory(void)
 	if (parent <= 0) {
 		log_err("No reserved memory regions found\n");
 		return;
 	}
+#define GRANULE SZ_2M
 
-	/* Collect the reserved memory regions */
+	/* Collect the reserved memory regions and appropriate attrs */
 	fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
 		const fdt32_t *ptr;
-		int len;
+		attrs = PTE_TYPE_FAULT;
+		/* If the no-map property isn't set then the region is valid */
 		if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
 			continue;
+		/* If the compatible property is set then this region may be accessed by drivers and should
+		 * be marked valid too. */
+		if (fdt_getprop(gd->fdt_blob, rmem, "compatible", NULL))
+			continue;
 
 		if (i == N_RESERVED_REGIONS) {
 			log_err("Too many reserved regions!\n");
 			break;
@@ -667,50 +682,63 @@ static void carve_out_reserved_memory(void)
 		/* Read the address and size out from the reg property. Doing this "properly" with
 		 * fdt_get_resource() takes ~70ms on SDM845, but open-coding the happy path here
 		 * takes <1ms... Oh the woes of no dcache.
 		 */
-		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", &len);
+		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", NULL);
 		if (ptr) {
 			/* Qualcomm devices use #address/size-cells = <2> but all reserved regions are within
 			 * the 32-bit address space. So we can cheat here for speed.
 			 */
 			res[i].start = fdt32_to_cpu(ptr[1]);
-			res[i].end = res[i].start + fdt32_to_cpu(ptr[3]);
+			res[i].size = fdt32_to_cpu(ptr[3]);
+
+			/*
+			 * Align things to the largest PTE granule size to optimise speed at the cost
+			 * of a few extra mb of usable space.
+			 */
+			res[i].size += res[i].start - ALIGN_DOWN(res[i].start, GRANULE);
+			res[i].start = ALIGN_DOWN(res[i].start, GRANULE);
+			res[i].size = max((u64)GRANULE, ALIGN_DOWN(res[i].size, GRANULE));
+			res[i].attrs = attrs;
 			i++;
 		}
 	}
 
 	/* Sort the reserved memory regions by address */
 	count = i;
-	qsort(res, count, sizeof(struct fdt_resource), fdt_cmp_res);
+	qsort(res, count, sizeof(res[0]), fdt_cmp_res);
+	debug("Mapping %d regions!\n", count);
 
 	/* Now set the right attributes for them. Often a lot of the regions are tightly packed together
-	 * so we can optimise the number of calls to mmu_change_region_attr() by combining adjacent
+	 * so we can optimise the number of calls to mmu_change_region_attr_nobreak() by combining adjacent
 	 * regions.
 	 */
-	start = ALIGN_DOWN(res[0].start, SZ_2M);
-	size = ALIGN(res[0].end - start, SZ_2M);
+	start = res[0].start;
+	size = res[0].size;
+	attrs = res[0].attrs;
+	/* For each region after the first one, either increase the `size` to eventually be mapped or
+	 * map the region we have and start a new one, this allows us to reduce the number of calls to
+	 * mmu_map_region(). The loop is therefore "lagging" behind by one iteration. */
 	for (i = 1; i <= count; i++) {
-		/* We ideally want to 2M align everything for more efficient pagetables, but we must avoid
-		 * overwriting reserved memory regions which shouldn't be mapped as FAULT (like those with
-		 * compatible properties).
-		 * If within 2M of the previous region, bump the size to include this region. Otherwise
-		 * start a new region.
-		 */
-		if (i == count || start + size < res[i].start - SZ_2M) {
-			debug("  0x%016llx - 0x%016llx: reserved\n",
-			      start, start + size);
-			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
-			/* If this is the final region then quit here before we index
-			 * out of bounds...
-			 */
+		/* If i == count we are done, just map the last region. If the last region is
+		 * too far away or the attrs don't match then map the meta-region we have and
+		 * start a new one. */
+		if (i == count || start + size < res[i].start - SZ_2M || attrs != res[i].attrs) {
+			debug("  0x%016llx - 0x%016llx: %s\n",
+				start, start + size, attrs == PTE_TYPE_FAULT ? "FAULT" : "VALID");
+			/* No need to break-before-make since dcache is disabled */
+			mmu_change_region_attr_nobreak(start, size, attrs);
+			/* We have now mapped all the regions */
 			if (i == count)
 				break;
-			start = ALIGN_DOWN(res[i].start, SZ_2M);
-			size = ALIGN(res[i].end - start, SZ_2M);
+			/* Start a new meta-region */
+			start = res[i].start;
+			size = res[i].size;
+			attrs = res[i].attrs;
 		} else {
-			/* Bump size if this region is immediately after the previous one */
-			size = ALIGN(res[i].end - start, SZ_2M);
+			/* This region is next to (<8K) the previous one so combine them.
+			 * Accounting for any small (<8K) gap. */
+			size = (res[i].start - start) + res[i].size;
 		}
 	}
 }
 
@@ -744,13 +772,14 @@ void enable_caches(void)
 	gd->arch.tlb_emerg = gd->arch.tlb_addr;
 	gd->arch.tlb_addr = tlb_addr;
 	gd->arch.tlb_size = tlb_size;
 
-	/* We do the carveouts only for QCS404, for now. */
+	/* On some boards speculative access may trigger a NOC or XPU violation so explicitly mark reserved
+	 * regions as inacessible (PTE_TYPE_FAULT) */
 	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
 		carveout_start = get_timer(0);
 		/* Takes ~20-50ms on SDM845 */
-		carve_out_reserved_memory();
-		debug("carveout time: %lums\n", get_timer(carveout_start));
+		configure_reserved_memory();
+		printf("carveout time: %lums\n", get_timer(carveout_start));
 	}
 	dcache_enable();
 }

-- 
2.53.0

