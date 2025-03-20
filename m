Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2589C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 12:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5D9807AE;
	Thu, 20 Mar 2025 13:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="JdbGS+Ta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7A18070C; Thu, 20 Mar 2025 13:52:07 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C5808003E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 13:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so123847366b.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1742475125; x=1743079925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/nAkvvTJghKFKBAr++jRFEChSA/57yZsVMAmpN41EXw=;
 b=JdbGS+TaMSHcebULxwju8bauuNDQF/wfN971Fb4cNqEFnpj8mwGptpdem8F44gNMay
 YGHQ29J3tzhev9aXBq6TC1lXN9fLLM3VD3cRyrMChlone9oEUM9hkk9e3NskafUTClYf
 G/6R4N1qtQHanTNWCCCwoXCgTZ66z6IhAOVVsKLss/LhEroEO6Wg1iVmzQ96jH9iauwd
 PT7xAay48m+Ra12Jhbqe5WYDQbDPKhKBDhUEao5bF/QGxv07cckPcny/rzsoHqx/C7Sf
 rR3zzRnTCYZeBFbguoymfW1GWxt8K146MIf5rM50FxlUt5daUNwynx+XO2++Q0Kglfa4
 s/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742475125; x=1743079925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/nAkvvTJghKFKBAr++jRFEChSA/57yZsVMAmpN41EXw=;
 b=Zo3J7BGqZZs0417k0aJ16Q37c/9UjiTpLcPejNOgUwYEi9USqEnwqViEeHAn/mPamd
 57iNWThvXYcxFFLzrIGFm4ubkF2VBuUZORyqAHRuA6IvbXBpP86SF3L46VobysZk9+VV
 GuXwb8GNtBFFVwBFLTPEMjCxwk4hEcVfwS5WXX8FSMuyaHr+kO5jw4lIfJcukyL/kz3b
 N9rPMH/ZtyaVcLdyLIcQk2gTfK/IVlKFmu9iKv6plrCz0c5Pe1jaHXhK514URaKZ91PF
 aQu+VqcVH6WV6CqDs7Pd7TN2171Lxsa3N44P/RytM48ksez1iL2nQldhTw/pwCRwqpNZ
 uSVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVEwZaooFZt58Y/CY8QdAGqoN959cjWFXFkByLAx5xOjrd01KkI1Scmcv0ZBV/Gs6AmjmIiI4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+XmXxe6kqQK3fb9rJFtWufEenpacNo91MK/5tL6F/iH2qOJXz
 xw5m/qMVSOWxv9uCFLGEwqOJp3mHhlfAoWezkqomNZJ2CH3Ivzjx7IEWszV51+4Y6B+ufFu1hN7
 McZQ=
X-Gm-Gg: ASbGnctkRNc4Yf7c39MihIBWgDNOn9CcvUN7QYonXLf/VLqkCJt5lehoM9TDKHTejUq
 sgbGwu2IOwJUiu9X29Jr5ka1plDfP1XX12BTmCPeFDQibRHApx5HImRhBdqN780QU/QEBIgf1oh
 91JcFs90wzHTZdxho9006obarC4UsuUlniUljhVwrcqJmd5qkTXzZ1nrBBUO11eWmNiO23OfP2f
 TQ+nX+RY/4aGZV8rixL5wLRysqB9UuVPjllCna5xFABFFphZT2MFvOl42L6KLN8msV1z/SPEmkt
 0TQuHmMI3k5WImieKr0ALAMsV051V824ACoznygNc62KZDU2++qEmcDcs+R285Al0HZJPUgwKZk
 2GSpamKjXoyFT+yFxh3tMi86YziZp7sbzm7VpRqxBM0pPwZMa9zNkUg==
X-Google-Smtp-Source: AGHT+IGPS05kWacAZJryaKrDMwzjo3X6tQ8Q9jIz0aOvreptrcup2ZTxuuHOh+jFP9S1+dPChB/Qjw==
X-Received: by 2002:a17:906:c144:b0:ac2:b9c8:b7ba with SMTP id
 a640c23a62f3a-ac3cdf76c1emr357020166b.10.1742475124547; 
 Thu, 20 Mar 2025 05:52:04 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a462basm1162284666b.133.2025.03.20.05.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 05:52:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/3] arm: gic-v3: Scan for subnodes
Date: Thu, 20 Mar 2025 13:51:56 +0100
Message-ID: <20250320125201.27459-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
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

According to the binding [1] the ITS node should be a subnode of the
GICv3 node. Since the ITS node has it's own driver, manually probe for
possible subnodes after binding since dm_scan_fdt() is not recursive.

1: https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/arm%2Cgic-v3.txt

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/arm/lib/gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 51cc2397768..34f05e94672 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -232,6 +232,9 @@ U_BOOT_DRIVER(arm_gic_v3) = {
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
 	.ops		= &arm_gic_v3_ops,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind		= dm_scan_fdt_dev,
+#endif
 	ACPI_OPS_PTR(&gic_v3_acpi_ops)
 };
 
-- 
2.48.1

