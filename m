Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7F5EE49B1
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 20:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70143864AD;
	Tue, 22 Aug 2023 22:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LT5Eqx/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1598648D; Tue, 22 Aug 2023 22:35:02 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31F6864AC
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 22:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7909307ecd1so167943839f.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692736498; x=1693341298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAoCNyZqfvnfH/0/0Sp/bNbHBZV5FWrs/u1Wpi/L2lY=;
 b=LT5Eqx/qlnBPzXAqQIgggqVZHv+YCKJ+0iWbylurX1QFNVV18FyFBIyuIoD9FU/0eg
 0JUuimV6sFdex20VLm+bcsgHJ+a542gNwqwX/Kwr6lWylmlmK92K8pIIXEi6OlaEv7au
 a/wps5s1f+rdlw80rXaimfr2ZjQyq39JTggvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692736498; x=1693341298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAoCNyZqfvnfH/0/0Sp/bNbHBZV5FWrs/u1Wpi/L2lY=;
 b=Qn+nM0QcOJ8jmrKY8Ag3T1xZin5vemyQOAX7x5GyQFymySOvaL+Ix7lRd8ApT1i8Jb
 ambGHyCsiinNAqIRJgHCKl3hgGX7CZraPz+BFr61AzMfbOiqDqHOvyE1KuBl65zYO4Ne
 j29sJKnwminL3v5BqzMIakYnZ/HUnBlm7mrFwK/zExbpJ26j6V6vEtfO7vhYtbQKK02s
 Q72lSlWxm3lMydUcQ52I93v98iFD3jNWWjK6Wq32VE6/xAy9GSEpdgjnGz0HLiFB2nyk
 jT4r2MexuYi5sg2fk5IQQSH4m1oObaXrd2Uh/g6aR0sRsdYIkH6a3wmD0NQqriNgRIe1
 5Umg==
X-Gm-Message-State: AOJu0YwBbmMGyuTgRL5ZEv8Aq32lmm6hwdsErubBSClgbLFfTxt06pxH
 Sib0YzLtlqRP2uaGnllqC6R+gA==
X-Google-Smtp-Source: AGHT+IGrtcKkLUDbfM2/xR8cobFWMcEKBMWgBL9b5Nhq1+ovWu1dKbVkA9ITN/X9uDBnaMJz55KHKg==
X-Received: by 2002:a6b:dd08:0:b0:783:3899:e1d0 with SMTP id
 f8-20020a6bdd08000000b007833899e1d0mr1007976ioc.6.1692736498725; 
 Tue, 22 Aug 2023 13:34:58 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b7f:10f7:eb5:da54])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a5eaa14000000b0078754bed499sm3500745ioe.37.2023.08.22.13.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 13:34:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Chiu Chasel <chasel.chiu@intel.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Gua Guo <gua.guo@intel.com>,
 linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Yunhui Cui <cuiyunhui@bytedance.com>, ron minnich <rminnich@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lean Sheng Tan <sheng.tan@9elements.com>,
 Mark Rutland <mark.rutland@arm.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/2] memory: Add ECC property
Date: Tue, 22 Aug 2023 14:34:43 -0600
Message-ID: <20230822203446.4111742-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822203446.4111742-1-sjg@chromium.org>
References: <20230822203446.4111742-1-sjg@chromium.org>
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

Some memories provides ECC correction. For software which wants to check
memory, it is helpful to see which regions provide this feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..981af04 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -34,7 +34,14 @@ patternProperties:
         description:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
-
+      attr:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description: |
+          Attributes possessed by this memory region:
+
+            "single-bit-ecc" - supports single-bit ECC
+            "multi-bit-ecc" - supports multiple-bit ECC
+            "no-ecc" - non-ECC memory
 
     required:
       - device_type
-- 
2.42.0.rc1.204.g551eb34607-goog

