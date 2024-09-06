Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0D1E6FE4C
	for <u-boot@archiver.kernel.org>; Sat,  7 Sep 2024 13:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79591889EB;
	Sat,  7 Sep 2024 15:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cZaPWx7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9344F88966; Fri,  6 Sep 2024 23:25:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43CEF88D55
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 23:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725657914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlK6hwTy3inQXYKSaZKA9qEgjMKO997UFTiONrEsYu4=;
 b=cZaPWx7fARISuP47fKFC7NiiX//ZF+PeudiPQDNm4Nn+msO4ih2Dl+jaRLe//DywjPn6gp
 wML0nJ/MNjzTQ75xhvx6WxfD1sJG+m+LGwCpBrsEg4+FLG0MW/7NX/N/JqTEk8mGCj/VBh
 4Pz+g9SFr8XLQbRzBT69zFIOn72DZoo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-pAKE4ZAuPo2r8aLY2fHpYA-1; Fri, 06 Sep 2024 17:25:13 -0400
X-MC-Unique: pAKE4ZAuPo2r8aLY2fHpYA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6c3982a0c65so105951447b3.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 14:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725657913; x=1726262713;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BlK6hwTy3inQXYKSaZKA9qEgjMKO997UFTiONrEsYu4=;
 b=pB1wsuABt1MYHpw0zsTH77WN7jo5AJ+Ptgp6Uasx1euJMz4d+oN2nUgmW+RJjD1Y73
 l2RxqQqDAGCS+Q1RuyZaQaj7gGm7fT7SAwUnD8xMowZuzKHE2tMnezurq5OnsY4JqOMW
 qXm4Ztw21+xhzRA0SKTkFgRFMRDKYOGByaWKBH1VGZ2gXcPrX/DrXHSo4EOd2vGKOkh+
 aXV4F8EPYSTTqCKjo4Cfs6Bo/d/bCiTEBVZnxryukOTsa1LYo1dbd7wU2oZepLyeRBUb
 22O7tqLfnjvVY4etH8N52RoiusstvSrlo5ghk0Hkm4J/qvUsaXGk3uFhI1S1LnWHSggH
 NREQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXdbTF3ksOtjbcW9gxqCCybr3qxLPgE9m7iFwmFPpVWyQewbEeZG0Zvg2K1T5PLb8ELW8GgNg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/e33jHBrqS04FMzeCgtoZXLxH/rB2hPtXoQERU3IUCV3Syrwd
 J6q4JPZzSadY/1dLiG4AMrEhZnhB0U28ujzgzi/ohKZsrBLonG6XTdJ+MWQvGKI7n9qznvx7mT6
 AI9zkHgslFjEOmk61Qu3aT/IxoTc6gytAA4aOrSc7m6YY4hgkkBk=
X-Received: by 2002:a05:6902:2513:b0:e1d:2f11:3eb9 with SMTP id
 3f1490d57ef6-e1d3486c386mr5082225276.2.1725657913288; 
 Fri, 06 Sep 2024 14:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf8hCdYmRBq3K+ZRlLHFS1u3UrkO6XF7CZb9aBSkwk6Z6vIk6/Yp5CDIHPzE1WqwW+PnLJeQ==
X-Received: by 2002:a05:6902:2513:b0:e1d:2f11:3eb9 with SMTP id
 3f1490d57ef6-e1d3486c386mr5082197276.2.1725657912957; 
 Fri, 06 Sep 2024 14:25:12 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5203148f8sm19967006d6.86.2024.09.06.14.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 14:25:11 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Fri, 06 Sep 2024 16:24:53 -0500
Subject: [PATCH RFC/RFT 3/3] configs: j784s4_evm_r5: Enable ESM related configs
MIME-Version: 1.0
Message-Id: <20240906-j784s4-esm-enable-v1-3-b83b17d5a744@redhat.com>
References: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
In-Reply-To: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
To: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, j-humphreys@ti.com, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 07 Sep 2024 15:02:07 +0200
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

Like other TI platforms, let's enable the ESM. This allows the ESM to be
programmed during boot, and the PMIC associated with the ESM output,
enabling blocks like the RTI watchdogs to actually cause the system to
reset.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 configs/j784s4_evm_r5_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 543b0a50d7a..4d3bc68528c 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -97,6 +97,8 @@ CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
+CONFIG_ESM_K3=y
+CONFIG_ESM_PMIC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
@@ -123,6 +125,11 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65941=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y

-- 
2.46.0

