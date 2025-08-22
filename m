Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B381CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D1582BA7;
	Fri, 22 Aug 2025 20:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="ALodr1ti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C3F682AC4; Fri, 22 Aug 2025 20:56:34 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D8182C84
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755888990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MV5aBVFbLSzGZH6b/q9uLLZdtcSAWFECOPTBZaTzeN0=;
 b=ALodr1ti3zpQ6uENVy6UinlXUnJz4fcmM4gT9EPK01EAOXLugXeSLvyRl4LAmmGDoOpNgs
 xo3T4tLlwZvul4K96zdo1/dS2l5FAKxzohpL3XLcK6mD6GEDATWstY2uFvNMPT39abUzVS
 LDNBm6ZGX7TNOd+kbwniApqP3gnjH4c=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:54:39 +0200
Subject: [PATCH 2/3] ARM: exynos: pinmux: fix parentheses alignments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-exynos-origen-and-pinmux-debug-msg-v1-2-e6384177b42b@grimler.se>
References: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
In-Reply-To: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
To: Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=henrik@grimler.se;
 h=from:subject:message-id; bh=SDIHR48DtNjbuwIefZmn0hrEraAY+g5TehsqLgNuCqY=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqL1U/TDixSHG8pZvgZkNZtrKZyj8fXWTWdU5H
 I/RSBiWGyqJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi9VAAKCRCwB25JC3Fh
 a+gNB/9prZ2IIK5lJqUFoV/q7ivMG8XQVaEpY18MGh0pj/RsayaeiccFkI4lcPjye/PzT1XJ7ei
 t++69Gavuf6JeimwG2Jyxvcsow+SY/k+ph1ORtxIJ6yTk82oPLXFsnSuy21L3NefjVT/SsPYwJz
 eve32T4MSoLcOvPEXnKWlFD/zFWniD9ZKEcsGQGu1/aXeYUDBd0ssY1spiwJEB2qIf2ri8B2VsN
 hxAS8a0pyTfu/ohJpcF97fiCveyP0YCmpAessByMjqhpiyiWpCL35r5LERnAh4DKvx1IQ+gH82l
 96qb+lrCsGqQ+kk7LZ40R9WCTkFwoEm7uuYJ6/k1CD9xBcTC
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

For multi-line commands the lines should preferably be aligned with
the opening parenthesis.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/mach-exynos/pinmux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/pinmux.c b/arch/arm/mach-exynos/pinmux.c
index 48c325190d5e69f4b385b32b66ddc3886d4c3767..bd82e1ac750d8b5b7dc1e2e02324ded3009f93d4 100644
--- a/arch/arm/mach-exynos/pinmux.c
+++ b/arch/arm/mach-exynos/pinmux.c
@@ -102,7 +102,7 @@ static int exynos5_mmc_config(int peripheral, int flags)
 	}
 	if ((flags & PINMUX_FLAG_8BIT_MODE) && !start_ext) {
 		debug("SDMMC device %d does not support 8bit mode",
-				peripheral);
+		      peripheral);
 		return -1;
 	}
 	if (flags & PINMUX_FLAG_8BIT_MODE) {
@@ -902,7 +902,7 @@ static int exynos4_pinmux_decode_periph_id(const void *blob, int node)
 	u32 cell[3];
 
 	err = fdtdec_get_int_array(blob, node, "interrupts", cell,
-					ARRAY_SIZE(cell));
+				   ARRAY_SIZE(cell));
 	if (err) {
 		debug(" invalid peripheral id\n");
 		return PERIPH_ID_NONE;
@@ -917,7 +917,7 @@ static int exynos5_pinmux_decode_periph_id(const void *blob, int node)
 	u32 cell[3];
 
 	err = fdtdec_get_int_array(blob, node, "interrupts", cell,
-					ARRAY_SIZE(cell));
+				   ARRAY_SIZE(cell));
 	if (err)
 		return PERIPH_ID_NONE;
 

-- 
2.50.1

