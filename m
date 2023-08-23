Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E01EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D71888645E;
	Wed, 23 Aug 2023 16:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="Qqn/C+K7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F15C864BD; Wed, 23 Aug 2023 16:56:39 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D379863F9
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50078eba7afso6030416e87.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692802596; x=1693407396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zxtLaFIuzuk+vtngI36WCDKTHvt7f/PzZ+Fnkd3jhmM=;
 b=Qqn/C+K7OyjRApQShd5KEs0a/099uL/n9CaqmxSW5pavDeb6T9mGPx4UT8hG4N+6iW
 dh+5EwHwKe+zC2ctcpOqS5CVsTwWR+zAJFY6/X3BzfbxpJ1rIVZ10GfVi82uvEXnzNMN
 TxioNnXwuCRPDHvWAfWt49Te28gvbjzV/ytDsbci8CTzT5+7sgtgxWLZ8WIl1ItAROec
 Jp4inE2zS+Lnt1Pd7PTgCGdP1P1pIfYANz6OyLRgJGNSTFwpDDJaJzg4kBM0X7Q8TXjd
 Pe708rSysjdBI0so4PvT/OqcWrM7X9H/L0yA/Izcb2tSqD8Ms9E6lje9pD6Se1JqfVqo
 HeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802596; x=1693407396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zxtLaFIuzuk+vtngI36WCDKTHvt7f/PzZ+Fnkd3jhmM=;
 b=Qi1dP/JrxL2XIEjJhjOl+M38pj0dEpJSakcIV5NB8JrxphVm5MVAX5oDRgrXieqQpH
 KtPgUamsY9PecP4U0s7arBtQJfhNs9Zai6SJHkuwufIa28gxvYck/Zlw1lOKhJDZMJuv
 5vjT2dKO8xgpQubmos7f6/9/0fdz6I/IHWtg4OpAqGhRQy4E2ls49913du4QdcduBSKf
 Dzss3mYw4zHdCHyA+Ausry+xQj9WaIFJiERHZCvS3ADc1xBnMvsElAJo7tT1ryDyhMi0
 yizrC8JuTDorLkwDagEUHyxyIrVajFFMMFHAnGZmS8aZQh+VoONfjXLMGmky9pwBPv9c
 USow==
X-Gm-Message-State: AOJu0YyHufBoQtk55ZR+BQJicVwewZZXCuOydaZjFSF5DoNisSY5yQqE
 C2MfuJasTJNV99RkQfMjEqpgJzZLl/qEDJEubSw=
X-Google-Smtp-Source: AGHT+IFf9qdNTMeXaCBlB+A5sCQY4mF8AHGcs30pdjYHJBzdxE4tu+101Ffj2mLGlwqzleNy0xdfBw==
X-Received: by 2002:a05:6512:130c:b0:500:9969:60bf with SMTP id
 x12-20020a056512130c00b00500996960bfmr1315016lfu.68.1692802596112; 
 Wed, 23 Aug 2023 07:56:36 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 w8-20020ac24428000000b004fbc0c7218bsm2714787lfl.118.2023.08.23.07.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:56:35 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] spl: crypto: fix including SHA* object files in SPL
Date: Wed, 23 Aug 2023 17:56:27 +0300
Message-ID: <20230823145633.10948-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

If one of SHA* algorithms is disabled in u-boot, its code is not
included in SPL even if a given SHA* option is enabled in SPL. Fix
this.

Fixes: 603d15a572d ("spl: cypto: Bring back SPL_ versions of SHA")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 lib/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 8d8ccc8bbc3..9fa573525b8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -72,9 +72,9 @@ obj-$(CONFIG_ECDSA) += ecdsa/
 obj-$(CONFIG_$(SPL_)RSA) += rsa/
 obj-$(CONFIG_HASH) += hash-checksum.o
 obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
-obj-$(CONFIG_SHA1) += sha1.o
-obj-$(CONFIG_SHA256) += sha256.o
-obj-$(CONFIG_SHA512) += sha512.o
+obj-$(CONFIG_$(SPL_)SHA1) += sha1.o
+obj-$(CONFIG_$(SPL_)SHA256) += sha256.o
+obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
 
-- 
2.41.0

