Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F83F5A8BC
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3842B844FC;
	Tue, 21 Apr 2026 00:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="M8rnZkY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FF6844F5; Tue, 21 Apr 2026 00:08:11 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C51844EC
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9574140D87; 
 Mon, 20 Apr 2026 22:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722887;
 bh=NIsPbskXxGUJFeIhACtEH1FxS8EG9+HObYDE3fqoqBE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=M8rnZkY9qIHu2ZXCEEz2yPJt95/MhklPCzuEGnJgYb8tZdz6lHzWknB8qgQyeIPWc
 FLTFL2bSxmtPpS9c4LRUDMp6GpAN9eOjmpSYkp/+a48W7Eoar7w6NMJTW1fZ2V+bk5
 meV54557SkedXKWMLjgP7qmtsWTbp4+YGRA+WYm3LaZAFqzkGG91vudPetgFo5U/SQ
 QIPI/ZeQcY7M5Ys4cBCqFTQbpn1hRfgFz5pH1/40kTNGEP7+IrYO/FhdlNa8xXl5ph
 /b+kZGZnqhzKMrkbJuHe6p4ElXwy5ypzAUM8EjVEyMLG5gRDip9wfu/jXDaQlczdZr
 1UkDPF8IbljgB1BCUqe07iFTP7xNjFgXtFA7MLjEbc3NbGlvJWm0blyFaagSo9BIlP
 D8ygtcCTWq2LPAvlbbuEUkgPMxeBthhgzUYRbewFkqh0hEwA+2Xvk8x8SUZN3c4PRH
 jBaGjIuF35uspO8J+R2xWSRdnsNICyg38lXatirtAINVI3iJfYuZdxTARxAyKjZlhY
 li8st0KlMGDOUSZ3n7YoetP6H1hi2LvfgYfLJiF5EwrXwq3+WcBKcU668uwEQXQkCr
 sktngBpcPz1mvKemiklku/ESTM7g4hpR/OqRWeLXVN3OkEuIEk+VeDtCjrUUPU3YV8
 O/1+4yT5B6rd2Cdt0ZOdKXSE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] doc: document index parameter of `acpi dump`
Date: Tue, 21 Apr 2026 00:08:04 +0200
Message-ID: <20260420220804.71564-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
References: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
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

Describe the new index parameter.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/acpi.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/usage/cmd/acpi.rst b/doc/usage/cmd/acpi.rst
index e652968d584..bce515cff6f 100644
--- a/doc/usage/cmd/acpi.rst
+++ b/doc/usage/cmd/acpi.rst
@@ -13,7 +13,7 @@ Synopsis
 
     acpi list [-c]
     acpi items [-d]
-    acpi dump <name>
+    acpi dump <name> [<index>]
     acpi set <address>
 
 Description
@@ -125,6 +125,12 @@ acpi dump
 Dump a paticular ACPI table in binary format. This can be used to read the table
 if you have the specification handy.
 
+Name
+    Table type, up to 4 characters
+
+Index
+    Hexaecimal index starting (default 0)
+
 
 Example
 -------
-- 
2.53.0

