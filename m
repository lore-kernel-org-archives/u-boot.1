Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F79C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 20:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C021884C6;
	Fri,  7 Jun 2024 22:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NVH+bqo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6805884C5; Fri,  7 Jun 2024 22:43:00 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFEB087F8C
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 22:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a68c5524086so297638066b.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717792978; x=1718397778; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VFG4WdYnJXL1HIRac9zQBh+jJKA5eSiwDUsq05zXZ3I=;
 b=NVH+bqo07ThD0ahpFr52lvc+LTAYVe/ykoMDVS7mwwcvn4fOLqQXdxkAtRP5SzOdDs
 Rs4x/iLfy+URz8oedVqth5wkZRSLnmrgeDwlskDSK4TWSXH0JaARmU1jLl5LEkVFjDaF
 VOm6l3t/ahICp+33Rbc5TT2Rn1Su3N8488Re80NL2OVyes7AbxG3whx3pUeGgWa2BG+z
 zvLSS+P6fICFzW3K9E2hOHKpP7I/aDFp+1pHlU+2OeFSckBweLrP0GfE0sOBP2J98hg2
 U+DcJ4rsCcxENlN67S0yykYaxQ5zYcm+9j8eXiDDBfcT0XnrI8jBj5XKtiDtCUGU+ymo
 SSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717792978; x=1718397778;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFG4WdYnJXL1HIRac9zQBh+jJKA5eSiwDUsq05zXZ3I=;
 b=JIBJLCNzmOkbhSLOeLnJJiQIYGurQjWerdcg9sKtP9k8SiHIi72pzyKbc+N5YGKgx5
 BDfT33LFAvYw4HODJpaeVwDWoRHDJZ8YzX5v+0IU2T9uihGbBD6YXg74ynyIBUCXgw4I
 PL5wr3KmmV5oovoFmr3d0Ivpcy7d9Tp2xPIQgkCrWllgGqEVdK87gcDbxIW7IRgC3uY5
 HBapTE1MCc9ncqpvUps+7NtaExrcblsSEvVdewGNwiUGpmpBgBtDA1OIioFBNGTf9YQi
 2Ts3jl1/nnDBq+8+DVW6u9wVQ/nski+k4wGi6zuaxxjDo5r/aUNMqPtOfBqM6dOrPTey
 O9Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFp1amNKVo0glhK6cFfF39RQZKg3frYqTBjrjlUAAp8e/xOlKIQNlz3/x4IvLgNzlVO05pb1Ir+DwLgG5H3xCWVHCrRA==
X-Gm-Message-State: AOJu0YwCykFIEJRd305x0Mt8/D9Ukk7iph+Z5CwsClNUwtS1H9LWg60H
 VozbdiDdskIdzhx4RvFvROAOK2hsbIeDu7UOpp7RyW2kTOYkOObzlsH4lRXmIxv/bOkrSFyVyNh
 KfBk=
X-Google-Smtp-Source: AGHT+IFneGlGr3evUPnATpClcsEcEee+MJIHpQqplkvcBG+CtKhFRP9eWaW0SeCoXj3ekz4tjgD/AA==
X-Received: by 2002:a17:906:d8bc:b0:a6e:f8d6:17e2 with SMTP id
 a640c23a62f3a-a6ef8d62328mr54442366b.40.1717792978445; 
 Fri, 07 Jun 2024 13:42:58 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80588851sm300766966b.29.2024.06.07.13.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 13:42:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 07 Jun 2024 22:42:51 +0200
Subject: [PATCH v2 3/3] doc: arch: arm64: describe pagetable debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-caleb-upstreaming-v2-3-bae407f51f22@linaro.org>
References: <20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org>
In-Reply-To: <20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=MTi4eb3QnNK3dMRRUrL76HdHjW1mfzW7AiL6LzWeZKg=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmY3DN6v4y/j4pAc7EZtiXICHxkTcTRzjmGysbG
 bov6sNmewqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZmNwzQAKCRAFgzErGV9k
 trLpD/9xSY5gwpZqszdEVW10K3btClJ5kXysUZxDvK7QBFcOsnf3DLb48vddNW6VQztjgM2P/Cd
 BSYcTHmtYyuQsFR3txlADGfwIMZezdWGfvg/CqbthdaAGIA1zFV0dQpetdBrhBWmDYNEzDYFHN6
 sB3+0J4orYsHLJkeBvR/LktAlkJbQoJf7ShoJLvH7N2Rwevhh8QPL4NnNJo2y1sto4LHT6zufbR
 o/3xfUU0jgw4Nj7BlNOqcShPvECPjc8iJY5Vu9dAYAnp0Vxko/Ld6A/RoinGs0pDcjiUu4LxO5T
 jSY0SjVDsqFZXgMBX7xD3+PfUnVjNzjzKmWqA0/6n9DtSk32IsJGfDD1zkgpBI7Ncxv3txPEVkR
 8Ris2BgrD4ChgZk+b2ZKbNECT3AuQofSqDu4Vl52LPrIMmDCzCkk2Y3WCmDkNcyWVOKrNkLIzIn
 PQVxdcFVuY3LPNrHL07Ua3cjsSE4hWJEoBNIDQewyGpjXGfQlIM5Bwu1fWhx/HLNTserM4bBDMd
 i3288IU+cmD0YUgIKJy2Ml5Tbam/N2El7bj5dkitRujEEUk49tMdeooplljG2ForPiDRdJ7vjGi
 +q3gOjS3bBWniws5Y8QrO5nAsD8NDRMyWoVOg6Q5rhMPk2WwqRfvERfMsOuN7+4BIQTBP6QVdX9
 iddAtgnAnUUlfyQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add some brief documentation on using dump_pagetables() to print out
U-Boot's pagetables during boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/arch/arm64.rst | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/doc/arch/arm64.rst b/doc/arch/arm64.rst
index 7c0713504c47..0c851304aad4 100644
--- a/doc/arch/arm64.rst
+++ b/doc/arch/arm64.rst
@@ -47,8 +47,45 @@ Notes
 
 6. CONFIG_ARM64 instead of CONFIG_ARMV8 is used to distinguish aarch64 and
    aarch32 specific codes.
 
+MMU
+---
+
+U-Boot uses a simple page table for MMU setup. It uses the smallest number of bits
+possible for the virtual address based on the maximum memory address (see the logic
+in ``get_tcr()``).
+
+As with all platforms, U-Boot on ARM64 uses a 1:1 mapping of virtual to physical addresses.
+In general, the memory map is expected to remain static once the MMU is enabled.
+
+It is possible to debug the pagetable generated by U-Boot with the built in
+``dump_pagetable()`` and ``walk_pagetable()`` functions (the former being a simple
+wrapper for the latter). For example the following can be added to ``setup_all_pgtables()``
+after the first call to ``setup_pgtables()``:
+
+.. code-block:: c
+
+    dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
+
+This will result in a print like the following:
+
+.. code-block:: text
+
+    Walking pagetable at 000000017df90000, va_bits: 36. Using 3 levels
+    [0x17df91000]                   |  Table |               |
+      [0x17df92000]                 |  Table |               |
+        [0x000001000 - 0x000200000] |  Pages | Device-nGnRnE | Non-shareable
+      [0x000200000 - 0x040000000]   |  Block | Device-nGnRnE | Non-shareable
+    [0x040000000 - 0x080000000]     |  Block | Device-nGnRnE | Non-shareable
+    [0x080000000 - 0x140000000]     |  Block | Normal        | Inner-shareable
+    [0x17df93000]                   |  Table |               |
+      [0x140000000 - 0x17de00000]   |  Block | Normal        | Inner-shareable
+      [0x17df94000]                 |  Table |               |
+        [0x17de00000 - 0x17dfa0000] |  Pages | Normal        | Inner-shareable
+
+For more information, please refer to the function documentation in
+``arch/arm/include/asm/armv8/mmu.h``.
 
 Contributors
 ------------
    * Tom Rini            <trini@ti.com>

-- 
2.45.0

