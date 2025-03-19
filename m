Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9660EC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 07:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC91681101;
	Wed, 19 Mar 2025 08:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vOrYwjxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC8A8129F; Wed, 19 Mar 2025 08:22:10 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F8281026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso2626204a12.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742368927; x=1742973727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VDLH5oSAsSfusouOcZ7RD3OVPs7CvaTGRcYz6XZolqM=;
 b=vOrYwjxfilVYzCU5YGxkzfdVRnAQ127YUzeP3yfuCBAZQDfvbTLQeNpPbGwDeVYro2
 735+MgM1aIcaJcDIEYFqpZItTrQVwyrWx5E47fappXCuzRoQ8hx55QDmeGvjB7Hn5tf2
 3uXXmGK9i5lUaZoQ29+7lo/gwL7i45Og+EqhQCmwdgJLWoLfDu9sxHzYTZOVFaOwLrkq
 yhfabjxvpv9HHrL3NLfvdz+hQzJPbrCMpPsTFLMegqxnV/YD01Jj15oxPppFXtckRkbR
 WomGVDgfOUoO+j/sE/hz5d53LAcNeUggMN9rz2x2egMhrfs/48TV4TxzvJuXwhW5azd6
 KWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742368927; x=1742973727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VDLH5oSAsSfusouOcZ7RD3OVPs7CvaTGRcYz6XZolqM=;
 b=e1Pt89KDfLJLWz086JIYVCqrsdnujnA5yjOIjMSxsmQ910QiwMtE6vxlpXzkaTioY7
 L2CfjWDoI21x4wtuxFGRAJ62dJnKKUsnMWHUK98nom/3ukWEJ8J/1JTXpoKwWEA0H1p6
 9p+7T9DQwSiLy60RnKNH1NIIU8YSOfqOmkU9qZikV4DWMrMhWQA83S3x1CaYxYfOu8dr
 VX/vKrErzpkbssLVZIY7XcLM/BjKwCceErtAaMhaCot2wH3APR97PRGHqHloGYHKS8C4
 bJjmc5eZF9HFbkLlXutqD6otZRIh3ySKhzMKVvG7w7waRYK3cUTuyi25eGwjwLUxESTl
 zY5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/faq5LiC0LWqdURmFGIiwGFNSRo98flWx3Z2scypPtAa0ixwTzHlh4AOdHR6H/qjKVNhu/y4=@lists.denx.de
X-Gm-Message-State: AOJu0YymoDs0Py4gA4eJA67I1ApJuzxThy3PfyqDsKYBX+pHyGQCCNuu
 1XLT71BYGXAZuPuy8tDYhYGrtPoCS0UfAWtCEICytTOZn8HXnPLMqaKFDBgXfVc=
X-Gm-Gg: ASbGncs+t+di/w7ERumtj7UnFaffHXrspsckF6+HgKRBeKyNSOZ3L8m/qP/UdCkRLlh
 1b3BKc2CVBkadpVKXEGvktIft4D4DMTRp9EZvnp8pbiKGicPlZTZUQbB2Wo5kwZYROIM1lF0XWa
 EBNRrIDovZBhbzCN7HXXskC7TDCcD1/gBnk2m2vmwP52jgMCm75lYrMqNWie6g4ICgtu3YU77zV
 wglEO4d0IK83f1jRb6NArS/7MYTLhGhqJMrwVvFaMN0/XyVDJCvFZoBbSG7NkWmhcyBzrgtjWqP
 c2HMGTUtGHwGH9+sDd5kz3IF72fbLDhKGcYNX2BEL3qbJ2P9a7D8ADIbK9V8sE+SJPjkuBTeE19
 29HOIjdc1tF2PX27YW9Jyees=
X-Google-Smtp-Source: AGHT+IHN1Qox8OSIzgCqoyFIvpV9drfssvTEVaGzb6QRmBn8b3LYao9gDT6SjZHMrVUspsLaaYighg==
X-Received: by 2002:a05:6402:4403:b0:5e7:dcab:1df8 with SMTP id
 4fb4d7f45d1cf-5eb80fcc62fmr1275796a12.26.1742368927493; 
 Wed, 19 Mar 2025 00:22:07 -0700 (PDT)
Received: from localhost.localdomain (ppp089210242125.access.hol.gr.
 [89.210.242.125]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816afe26bsm8716137a12.72.2025.03.19.00.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 00:22:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] arm64: Fix page permissions for platforms running at EL2
Date: Wed, 19 Mar 2025 09:22:02 +0200
Message-ID: <20250319072203.327431-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We currently set both and print both PXN and UXN bits when removing
execution for pages. This happens even in the existing per platform
definitions of 'struct mm_region'.

That's not entirely correct though. For stage-1 translations, if a
platform runs on a translation regime with a single privilege level or the
the translation regime supports two privilege levels and we are not
in EL1&0 with HCR_EL2.{NV, NV1} = {1, 1} only BIT54 (XN) is needed
and BIT53(PXN) is reserved 0.

Currently we support Non-Secure EL2, Non-secure EL2&0 and Non-secure
EL1&0.

We already have get_effective_el() which returns 1 if we are
- Running in EL1 so we assume an EL1 translation regime but without
  checking HCR_EL2.{NV, NV1} != {1,1}
- Running in EL2 with HCR_EL2.E2H = 1

The only problem with the above is that if we are in EL1&0 and
HCR_EL2.{NV1, NV} == {1, 1}, then
- Bit[54] holds the PXN instead of the UXN
- The Effective value of UXN is 0
- Bit[53] is RES0

So let's re-use that function and set PXN only when we are in
and EL[2|1]&0 translation regime.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 12ae9bd06039..1c1e33bec24f 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -575,8 +575,12 @@ static void pretty_print_block_attrs(u64 pte)

 	if (perm_attrs & PTE_BLOCK_PXN)
 		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "PXN ");
-	if (perm_attrs & PTE_BLOCK_UXN)
-		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "UXN ");
+	if (perm_attrs & PTE_BLOCK_UXN) {
+		if (get_effective_el() == 1)
+			cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "UXN ");
+		else
+			cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "XN ");
+	}
 	if (perm_attrs & PTE_BLOCK_RO)
 		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "RO");
 	if (!mem_attrs[0])
@@ -1039,13 +1043,29 @@ int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)

 	switch (perm) {
 	case MMU_ATTR_RO:
-		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
+		/*
+		 * get_effective_el() will return 1 if
+		 * - Running in EL1 so we assume an EL1 translation regime
+		 *   with HCR_EL2.{NV, NV1} != {1,1}
+		 * - Running in EL2 with HCR_EL2.E2H = 1 so we assume an
+		 *   EL2&0 translation regime. Since we don't have accesses
+		 *   from EL0 we don't have to check HCR_EL2.TGE
+		 *
+		 * Both of these requires PXN to be set
+		 */
+		if (get_effective_el() == 1)
+			attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
+		else
+			attrs |= PTE_BLOCK_UXN | PTE_BLOCK_RO;
 		break;
 	case MMU_ATTR_RX:
 		attrs |= PTE_BLOCK_RO;
 		break;
 	case MMU_ATTR_RW:
-		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+		if (get_effective_el() == 1)
+			attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+		else
+			attrs |= PTE_BLOCK_UXN;
 		break;
 	default:
 		log_err("Unknown attribute %d\n", perm);
--
2.47.2

