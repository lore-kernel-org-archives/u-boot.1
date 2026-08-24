Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7881C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8664B40611;
	Mon, 24 Aug 2026 19:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q6kAEVSX05YK; Mon, 24 Aug 2026 19:53:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787601195;
	bh=8I+RwIoxwoZlXLkzMb777mM1fQUeYDfh1S6OEyz4RPw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TaMcJghKHoADgqzfT3mvIlUKGNs3BhYsKxOKiwCGAsodR1+nTcv1SkKwHJyHnT2uB
	 22SsjAEnLr9/TcOJYAqtveahnnX2SiSe/J8t+1l7Nb7xl+Gt2oOSXWxLnP5935imyP
	 cQ6ebz+EfDxu+Qr+7GaQxStMPCUYCFk5CfxG49NGT9I2/+PL8uFevzRO+T8zTpBIs/
	 B+iPM/MqToYeor5GtnZcwCqyiLlUVaw6d2qRs38cZrBWp5utpcGlPtSVB2P4m/K53O
	 OQCHi4KcQUo/nHIrIcLaTu4WOCTRTyoXuPemGVUQH/P8baRoUP0oqaD1U/kC8t1hCd
	 ojKbs6aRGFynA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3D5B40586;
	Mon, 24 Aug 2026 19:53:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D53029B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 337DB80D2C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RqdYDwCzBAaB for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=mdakAzz0
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A13880BD3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so4126159a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787601186; x=1788205986;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8I+RwIoxwoZlXLkzMb777mM1fQUeYDfh1S6OEyz4RPw=;
 b=mdakAzz0vp72zZ7xwy1wNFW92U+94iZyVrmagZNvbQ02QQTniH2WINPUHn8L6uaE4G
 RmkqKAZZTezy8VcGkVbe2eBML83cKynS14uOv92LLZ88KqXTKBkmbd4HXUzuq5D7xNNM
 wh9PrAnNO5Y9UeXOkoZoVtjxcIjAGWdjGPE8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601186; x=1788205986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8I+RwIoxwoZlXLkzMb777mM1fQUeYDfh1S6OEyz4RPw=;
 b=iX3bVsHs3M8Xeq1cJeHRxAwWh/LWvh9Su8ufQ1yec91e8YfMYryBO2UiIDZhCzNZa5
 29uUBWaHmiANAS1aKIeOCKLpWiYKlLQ7zUtZIbt66rGRusFAjWZF6aueuKZnbL6uLO9I
 NKWFq6HkBamPMZGuZ/tp9fmG9K1MRYXu5yL8D8tnnDsrY7/bu+GY0eo+wnj1XOmAoUdz
 lBMMwgb+hrMXEaFcl98O+SMfwuw9/ValRlY59TRY3UZ5O6FR7Dffw/cor5ozXBFYZVnQ
 SbbzDkHx/3BrtylLTXMI0asC/3qIPYg4hUYe+Cvfazgs6QIKO38RDO4IR7ewF78kRbo1
 APCA==
X-Gm-Message-State: AFuF++kFuOtBAC6z/EgHUzIAhXpYJ+Tjut1bx3Mt7xuSR46jQbnPihd3
 rHOiXkKEfYReFR6l3LiZtiSYicQ41PYmP0eu1odZOj/Lzz3Uoz3fpqLKmnKnIEF7XSD9Nn75945
 hazz1ZiTeQJwx
X-Gm-Gg: AR+sD11XXln/ZxLbtmZ2WzmMKDLcpWoFKlpccAFPq+Q6HHNOjLvBFBFgw8U2MAvJIXX
 GidTzGksl4wbGZOb+ElLHi4b+40QZfJGhQXiLFEtREq/rrZ85iSoBBkb7Ixlmuz6lSBklHDSU/G
 vEAHkFB4vHiWLgQK+OkqOtSLBtlPw4+CP0Ak9A4ofV5hTJkpp2urDtu7xpCvv5p6vxzBDH6ViwU
 zn1Oh11zDAfqrZHP11snFXbpymN2twMsmhqDaiTColmPX7lF6rK1J9sN8idu1VdhBGzNy79tyQT
 xZCWHWzY6yUsFJmRlgWm6YusCxfa5yZEiH5a/iwb/XjoTkeEhuNsBZ10MtwQ/mr115Kw+AiABCq
 nUWkaK2ojpUhHeotr9UTYstwKbK+bUexEuZZwzur9d/7hZcqiwJgpQrbGPn1p2206F3At5mGgeP
 ZcTF6r6zbDaeiE6Yi3t3rItLl1t/+SY6fusUvVAbbpos06u0jF8MXqAXkYnpQ72jGUmrqQEx9a4
 fL5jS/x8b0SUZXXXwfg41uyrKzMSGXbz6e+Sk/3QKhZy3UTwa4GFNjh4p8FVVDLd0gb4iiTO/Fh
 yzg0KFr3BU29/NbFqTxZJ4Tp80Us7GQMWQ==
X-Received: by 2002:a05:6830:4885:b0:7e6:ef1d:4aeb with SMTP id
 46e09a7af769-7f461a1edb7mr32909992a34.15.1787601186061; 
 Mon, 24 Aug 2026 12:53:06 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc8623esm4975162a34.22.2026.08.24.12.53.05
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:53:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 4/5] powerpc: drop qemu-ppce500 dts
Date: Mon, 24 Aug 2026 13:48:48 -0600
Message-ID: <20260824195224.556419-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824195224.556419-2-trini@konsulko.com>
References: <20260824195224.556419-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Now that we are not building this device tree, we can drop it from the
tree.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/dts/Makefile         |  1 -
 arch/powerpc/dts/qemu-ppce500.dts | 10 ----------
 2 files changed, 11 deletions(-)
 delete mode 100644 arch/powerpc/dts/qemu-ppce500.dts

diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 4fd3478ac2fa..a9075c16fefc 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -17,7 +17,6 @@ dtb-$(CONFIG_TARGET_P2020RDB) += p2020rdb-pc.dtb p2020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P3041DS) += p3041ds.dtb
 dtb-$(CONFIG_TARGET_P4080DS) += p4080ds.dtb
 dtb-$(CONFIG_TARGET_P5040DS) += p5040ds.dtb
-dtb-$(CONFIG_TARGET_QEMU_PPCE500) += qemu-ppce500.dtb
 dtb-$(CONFIG_TARGET_SOCRATES) += socrates.dtb
 dtb-$(CONFIG_TARGET_T1024RDB) += t1024rdb.dtb
 dtb-$(CONFIG_TARGET_T1042D4RDB) += t1042d4rdb.dtb
diff --git a/arch/powerpc/dts/qemu-ppce500.dts b/arch/powerpc/dts/qemu-ppce500.dts
deleted file mode 100644
index e88e09e17961..000000000000
--- a/arch/powerpc/dts/qemu-ppce500.dts
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
-/*
- * Empty device tree for qemu-ppce400
- *
- * Copyright 2021 Google LLC
- */
-/dts-v1/;
-
-/ {
-};
-- 
2.43.0

