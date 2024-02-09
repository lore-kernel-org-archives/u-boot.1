Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D13C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B976A87EA6;
	Fri,  9 Feb 2024 20:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="H6doLQEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7EBC87E87; Fri,  9 Feb 2024 20:21:11 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C986987EA0
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51142b5b76dso1976128e87.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 11:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707506468; x=1708111268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpu7I1pr9hNMvMl2O4jky7g7kuBrNLB8E1jUrOR5Bbo=;
 b=H6doLQEOPTojhj4bTJJGFBI7sL4XWavhk5ezu3aPiabo8V1sjnzLunJyrtrt+tMXHP
 Q5zB/NDfp7/o9eHrWahOzg44eFLlBkdqNb5L0KryR2DHkJagPljIdJ70lVnOzbjB7DrP
 9YNgU+16NtjqDmulft40mzLPuiHr/BvBfkX/NiH1JxH0UH1RlTF0Ku+sVQzdwhojCgg9
 Qlr2gix8NRVL4LoIQxRrxXLZc6Knlv4RcThK71KkeM5POVkwEYqUQYkSWRvkKgv31wrB
 dvt+HFoqhaSR8SL8r2PBmE4c0nPPgS88pMk0rn1y8QxU3sA6V5330qPWHmXttcFjBojX
 nJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707506468; x=1708111268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpu7I1pr9hNMvMl2O4jky7g7kuBrNLB8E1jUrOR5Bbo=;
 b=fy6cvrzV4bMA+Z2kHtOStC7pltqr2J1vxQdMHItFCiWr0PW2U+YAapHy6JOfk1klcd
 rNBUL45TaZ562UhhSJz1vAMrpKwht4JYua46AqFg5xTAdESPH/SJh2GU59oRSElnwDyt
 sgN3oh4Cbc5hZkvj6EVGdVmeuXfQpaNbKEQfJE8W7NSe+lVunCkOvuzmalkMNpDJ7cen
 fz4WpQcVnrFxGqZQfwm8DT9NzUiRaIEpDElGIAdrutvNr2VpcC6J2YiCfuIFMtt6aBfY
 SAmSNuSh87JpaU6nnklgNS3jwO2CXHT9ncR85TvJCHxX3vq3by/qXDrk7mWX0trV8MKI
 yMFQ==
X-Gm-Message-State: AOJu0YyA8Onja6vfgHIbS76uhJacP32rI6qvt41OB3TKA8XN/izukW4y
 +RUVwm/tz8BCBYXfhst+zr9U3OIVnpQqKJtufiHVqv16v2kfCr/Xg6ipsnNHXRloMnOvBkAPVYc
 cfHo=
X-Google-Smtp-Source: AGHT+IF3wT4UjwpYcmwyL1BsmsMqHc2NiCpK72A/B6V6BUqj6tKmGPsg+EiWIs1dylCitNEjZ44ZDg==
X-Received: by 2002:a05:6512:6c7:b0:511:7b86:6d3b with SMTP id
 u7-20020a05651206c700b005117b866d3bmr1504403lff.59.1707506468654; 
 Fri, 09 Feb 2024 11:21:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUP6QlupV6GQa1xs+XTubUNyPZBLJbc4ayN8CEgYtRXdefiKs/fDCTByog8iB2KUcbjWTFoglxxeX6hcB5Mr2Nv83Lq/10ykKqIjxIZaKM3j8syphW8+yiLhHA=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 ck22-20020a170906c45600b00a380a72e82csm1040281ejb.57.2024.02.09.11.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:21:07 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/7] doc: android: avb: sync usage details
Date: Fri,  9 Feb 2024 20:20:45 +0100
Message-Id: <20240209192045.3961832-8-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Sync usage info with the one cmd/avb.c.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Address Mattijs comment about usage info, sync with cmd/avb.c

 doc/android/avb2.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index a072119574f..4aca7a5c660 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -38,16 +38,22 @@ AVB 2.0 U-Boot shell commands
 Provides CLI interface to invoke AVB 2.0 verification + misc. commands for
 different testing purposes::
 
-    avb init <dev> - initialize avb 2.0 for <dev>
-    avb verify - run verification process using hash data from vbmeta structure
+    avb init <dev> - initialize avb 2 for <dev>
     avb read_rb <num> - read rollback index at location <num>
     avb write_rb <num> <rb> - write rollback index <rb> to <num>
     avb is_unlocked - returns unlock status of the device
-    avb get_uuid <partname> - read and print uuid of partition <partname>
+    avb get_uuid <partname> - read and print uuid of partition <part>
     avb read_part <partname> <offset> <num> <addr> - read <num> bytes from
-    partition <partname> to buffer <addr>
+        partition <partname> to buffer <addr>
+    avb read_part_hex <partname> <offset> <num> - read <num> bytes from
+        partition <partname> and print to stdout
     avb write_part <partname> <offset> <num> <addr> - write <num> bytes to
-    <partname> by <offset> using data from <addr>
+        <partname> by <offset> using data from <addr>
+    avb read_pvalue <name> <bytes> - read a persistent value <name>
+    avb write_pvalue <name> <value> - write a persistent value <name>
+    avb verify [slot_suffix] - run verification process using hash data
+        from vbmeta structure
+        [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)
 
 Partitions tampering (example)
 ------------------------------
-- 
2.34.1

