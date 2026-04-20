Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910A4F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB85D84445;
	Mon, 20 Apr 2026 22:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sYHtGR8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58D384258; Mon, 20 Apr 2026 16:56:05 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDC38421A
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A0E263F613
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776696963;
 bh=ZV0l3BE7atFmKCJWc5gdn0l1eWhxGU7N0i9ZzuDfbwA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sYHtGR8zc9j+oYlKV5A2LMCF4pbV0x4qDUliyCNuarCGMhaA6+hPUjgSjbvay+/T7
 zpD482GgDeJxxI3WXjqDnugTF8k4hi8CGIoj40YNzv8VSyJzxW6MSl/DRLRU7ocp9W
 3qsTUAYgs980E8TY4DS7wMxe9UomrkerBdXnSFkNrBOpP+7jmTNU3e5QJfB+nU+CTF
 9hog1ZIeqn4Usf6I4xzi1IwHXLBJKDh0AufXp9G6MqPL+hca7QCY6G77CWfMxCiRsG
 joiYLiEZMcY4Ff1gGezpvgmxJLpqiBtgf4ZLlND9W7JMKPfGMUIEPrCq/Z6cFYSNwe
 8xltcPVm/1IuC81v+7p/rt1zOkE0euU2O4T1f9a9G29e0DvgnceNoxzqbVzZiinqXa
 qIu4ScZdlNznablyS3Vq18PhGVxPr7Tzoqyfes9mGQE1tHi7LHhYWZrCteu05JbozM
 0t10y3zsmU/n0rogHvPjomC/2tQN30FHT/22w8JdAidCgybosrYp9lhW2OIF/n2gkJ
 1vl1mC1ieZXvJ8nRSbNWYKfSfsQHHb9M5c0XKylvro38pFYY5Z2zq53Nfh+i9VMbB8
 5JLxNJFFR15u3/d8MsS6E0B+8wo7gQUs3oMR2me2dyRMa3cE8eazdKBmHQ1S6k0XPO
 uUHPKVZo+f6RQhx22bLbiBBo=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fbb5779e8so3661062a91.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776696961; x=1777301761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZV0l3BE7atFmKCJWc5gdn0l1eWhxGU7N0i9ZzuDfbwA=;
 b=Mbph9Xn4Pjcm4Y6pbApuEVPz//4Pn1r9v5HywRbK5gx+S54hdjLj9AOJN9t6x2r1mP
 JfEy9Pxyqc2yLV/FMFpZvNS0lqPFHZ225EtHwBjCROQ+ROp/yj8MW2N+ql4mUsQLu+/e
 q+SZe99OWvCHYPCuh7NA3hcl+wDj6T0ujIEnJbc8rW1woBZFg6sg8FrNaj0FAjcrHGaR
 i3brlpcOcF6NjPACO3VU6HCGHEJuzTm/8dQ9mG4H8ej+PjbOYJvs6m0O0t4UhjdPfkfE
 l2PSwFI99Q/NSHCnRAhFv764kj27h+kzhuaCeF9E0kuJRd0p0sA+Ql9AxH2U1tB+Ai9r
 sbVA==
X-Gm-Message-State: AOJu0YxXQ3u9Hp0ooqLNtIHl+Z1V4K8tgeCLy6Ko7Y3/zY9W9x3QaPJo
 KjCrDkLeq5eIDCfx/S0diI5lbQz964HGroFd3LFUrE6YFGDf04OdA1A5KkuDo2eSjDnkZtAqKyD
 knaAOWFfuwzsHo9YdDyFTx1Cuf+XHA1HV/Q8Ol3rDbAQHGwjFlnmjHAxBTYrf8/kVH1/lj92K+D
 sXEE1J3Q==
X-Gm-Gg: AeBDiesqU4sx9slCsjcSy9suVKaNKrlh5f9P/52dOZazS866UmE5N9NyGC1LYdjjcKP
 inr4NAAUkNA1ozUBji+KunQYW6xXXeF19M6pG09sB9nsSMZ3jV3K2b0ZesN9NZUUYFqrNBbigxK
 zs4srWvvx9ZwV9/MGOolyop2CsReyaJAfqucolA2Rg9XqI4xcQzBKrnIt6CNV2qeEBUHlxXmmJQ
 ggPHwXcG6G05BoPV6TDWee6yJre3rFQCoJqa5sMr6i424oWjdRtu0cGTU7NZOh/8JBM8iGDKtZ+
 HeSfDJsQNv6HULpcUKbzgk8BpxveuFq+RR6QWY8uEeVd5UI8lUFNOovN1CDQjMQuRgFITV2fSys
 rmFbGvB8M4vd3eHe6bD5CRny7Yaern+gRO+y1StwekfpWY5vyjtaRk4r9XfgzOBoLkdrdQdTLLM
 KcscfAON8=
X-Received: by 2002:a17:90b:4cca:b0:35d:93ff:2854 with SMTP id
 98e67ed59e1d1-361403f1311mr13765084a91.8.1776696961271; 
 Mon, 20 Apr 2026 07:56:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4cca:b0:35d:93ff:2854 with SMTP id
 98e67ed59e1d1-361403f1311mr13765041a91.8.1776696960799; 
 Mon, 20 Apr 2026 07:56:00 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff918sm113118845ad.13.2026.04.20.07.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 07:56:00 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: ggiordano@phytec.com, w.egorov@phytec.de, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 3/3] configs: phycore_am62x_r5_ethboot: Drop duplicate
 CONFIG entries
Date: Mon, 20 Apr 2026 14:53:40 +0000
Message-ID: <20260420145353.3923395-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420145353.3923395-1-aristo.chen@canonical.com>
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 22:33:40 +0200
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

CONFIG_SPL_MMC=n and CONFIG_SPL_DM_SPI=n are each listed twice in the
defconfig. Remove the redundant occurrences so each option appears only
once.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 configs/phycore_am62x_r5_ethboot_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/phycore_am62x_r5_ethboot_defconfig b/configs/phycore_am62x_r5_ethboot_defconfig
index a4434388ff8..b8a686afd39 100644
--- a/configs/phycore_am62x_r5_ethboot_defconfig
+++ b/configs/phycore_am62x_r5_ethboot_defconfig
@@ -23,7 +23,6 @@ CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_SPL_MMC=n
 CONFIG_SPL_DM_SPI=n
-CONFIG_SPL_MMC=n
 CONFIG_SPL_SPI_FLASH_SUPPORT=n
 CONFIG_SPL_SPI=n
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n
@@ -38,4 +37,3 @@ CONFIG_SPI_FLASH_MT35XU=n
 CONFIG_SPI=n
 CONFIG_DM_SPI=n
 CONFIG_CADENCE_QSPI=n
-CONFIG_SPL_DM_SPI=n
-- 
2.43.0

