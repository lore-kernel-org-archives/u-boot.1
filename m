Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C442EE57D7
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 22:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D147088CC9;
	Thu, 12 Sep 2024 00:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="heyW+XHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D93892F2; Wed, 11 Sep 2024 19:40:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46FCB880E6
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 19:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726076398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPn9XbV7AvY8Wxa+jsaWEAibi9hmfGo1ZLdLipF/EGQ=;
 b=heyW+XHXDd9p0jUcm7HKqVZDDMRY9xwrGV9ZXb3Dn9Wdt+tubYNTOJkTxRnxscwtIoDZrq
 8Yw/VUxtQTLVVwyaPK1stAo3aFBV74jBqpsmJ3aaXNuOe19tS3FilkZQFP8MNOSUzzvPKK
 IShLMFSyUxaq5badOIzsp++hosbYGTM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-yaBrpxr6MhefqYlj2hj75g-1; Wed, 11 Sep 2024 13:39:57 -0400
X-MC-Unique: yaBrpxr6MhefqYlj2hj75g-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4581d371964so159741cf.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726076396; x=1726681196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPn9XbV7AvY8Wxa+jsaWEAibi9hmfGo1ZLdLipF/EGQ=;
 b=W5FBm0YEWba9O+CnwQc/79Ytol/FszUixkvmENemqw7sa+zwos1CUnMQHU5sGm+OWw
 u3KHBebRSKrsY7d1Zk91pI97oRM4cBioqp4VY7mNw8nbdK6DD1xwrE3ulZvKGICZLM+u
 bo68dKg1Ifnbqc9AzKxPtAfwg3Q81Rt947dX9LacvrEgK6KCq2kSAiCUQbFjpZoIMNqf
 MY16+ek2Z0EsnRIAZXFPdY/+krXxHExKR78gcY1LTD8uQqlvfEkkeNHQvrTwIscbKpwl
 BANxhjEUXAOyQg95VdhXR6fp4jLILtzWlvtTfOL9tCkWRsASqzz3qf6DwmfAbT1JmZ7c
 zvog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCTbA/em/u8VCh19+kI6fGb+EBDiveTNN6m0DPwQ6IBxJH7GuJMhOq0waSk95M63RcOJ26D8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwlLTSIk4fz2qD7C0TWivzEYeWnFyzyvnSSrnBRpwxPwXHSJQgT
 Q2soxyh0H9Nj2gPg/PoHJ7ODkfOILwMhT0zRu+CAqAIuSFy0mjmOQh+FHwvVtE4jL8llp9nGi7k
 HC5VODmJJTHb0zhvFNHx7YXl9+vpCLyFx54iHqV6i5nWjBfC1akJ/PnTXwwU=
X-Received: by 2002:ac8:588c:0:b0:458:31ae:d41 with SMTP id
 d75a77b69052e-4586031a596mr1603851cf.28.1726076396235; 
 Wed, 11 Sep 2024 10:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrztW1/hdQ4GqGACedp1x1xmS+gjLQ2aSAQ98qV4AuBXX1PQuXSprglTJQ6fSohtjWjRN/tg==
X-Received: by 2002:ac8:588c:0:b0:458:31ae:d41 with SMTP id
 d75a77b69052e-4586031a596mr1603501cf.28.1726076395780; 
 Wed, 11 Sep 2024 10:39:55 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::33])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822eb0027sm43663781cf.53.2024.09.11.10.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 10:39:54 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 11 Sep 2024 12:39:49 -0500
Subject: [PATCH RFC/RFT v2 3/4] board: ti: j784s4: Initialize the ESM &
 PMIC ESM
MIME-Version: 1.0
Message-Id: <20240911-j784s4-esm-enable-v2-3-957f56b588d9@redhat.com>
References: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
In-Reply-To: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
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
X-Mailman-Approved-At: Thu, 12 Sep 2024 00:03:14 +0200
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

From: Keerthy <j-keerthy@ti.com>

Initialize the ESM & PMIC ESM. This allows things like
the watchdog to reset the board when tripped.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Link: https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/board/ti/j784s4/evm.c?h=ti-u-boot-2024.04&id=9d8b40958ce792808bc571d828197dbc2e7978d6
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 board/ti/j784s4/evm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 548dbd5925d..0f4d383b420 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <dm.h>
 #include <efi_loader.h>
 #include <init.h>
 #include <spl.h>
@@ -72,4 +73,27 @@ int board_late_init(void)
 
 void spl_board_init(void)
 {
+	struct udevice *dev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
+		const char * const esms[] = {"esm@700000", "esm@40800000", "esm@42080000"};
+
+		for (int i = 0; i < ARRAY_SIZE(esms); ++i) {
+			ret = uclass_get_device_by_name(UCLASS_MISC, esms[i],
+							&dev);
+			if (ret) {
+				printf("MISC init for %s failed: %d\n", esms[i], ret);
+				break;
+			}
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_ESM_PMIC) && ret == 0) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(pmic_esm),
+						  &dev);
+		if (ret)
+			printf("ESM PMIC init failed: %d\n", ret);
+	}
 }

-- 
2.46.0

