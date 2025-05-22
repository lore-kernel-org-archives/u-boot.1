Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24578C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 20:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9AE831A4;
	Thu, 22 May 2025 22:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mTNiq7SI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCC183164; Thu, 22 May 2025 22:39:57 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC4483189
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 22:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso66165415e9.2
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747946395; x=1748551195; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i9s+/evysz1Ub94emgYQfa7DVjJUom3N2vCMc62NJ7w=;
 b=mTNiq7SI92l18JPwJ0qKI7R8YtXopA88HWyu/1gnr9uRfTQQkveuTcF4Fl1/6CSB1k
 zKvLw2F1/97BzHxbt0qScVMARTfLNm8T0ftP8FDQqo5H5Q6buHgzP70PUpr5U8fuqCqs
 RwZttsSr5CjWmuNMH9WblCxwrHcb/nTRKN4Iiy5AsOGjfMA4TUkb5uQxKxJlDvkXImcU
 0wCc6xJ9Z7Vrx9VtMv3tHSYZZkSZCP4XsHYOxNLBRVyq9ID1aniGACILFMdffLEWFt3C
 kU6v7pzf/e9ZOFBAP4YCFbvYcSqPhwa+4JlMda8mrhsfW9iMqZLqa58tqhKgVjDQS4GW
 kWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747946395; x=1748551195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9s+/evysz1Ub94emgYQfa7DVjJUom3N2vCMc62NJ7w=;
 b=P8sl9CHqgdsG1Ls3OZNvjOwQ6XjjCloLHIjNfsE8t14Ci8FE0TKB8mCGBjM9ZBzS0Y
 UUSJazAbGB6TJ0ZEMJKA7GLSMHAkajKadZnA8VKfsuy8X/rMsYMr4zksGefhpoS79zMf
 QmjD2uAbNhzMy0tbSXGH95tGBZTRuWUbrZpQttJbRRhZb9Ep/QhOYUBKkO/pf4QsQ3pt
 FNKA0qAmEUG0AqxDLRjdO3qYdOUwT5tmoGjo8m3zD8u2o9nemReHrUGAfm/SiDsbG12N
 F/lG1GBB2dIASbMPT/SpZQ44WXhbY2k/pIRDjmnl+QxbL2M+Mr1As/aVjCYTroiFDNAH
 F7iw==
X-Gm-Message-State: AOJu0YxmgedreQCgbMDZdm98ZBJH55azc/4Ce9dwhWEMtcyoYPukKb4c
 Uny+MzeF7BEyGMUM/hq3yFUYMvtCwbSR4CdhPh7CN4hSLFlNjjxiyMmccKjRsBvH/RM=
X-Gm-Gg: ASbGnctWLrerxHIxlBW/B2tH3yiHVGUl2bBxFoyC2Wrxy9rEfql/wLhMmt63fhcQ2WT
 TkUG+i4+prmbM1Sr0ij6I0sg4RFnRPiR+PMW8s/GwQ+/PSbZhn8sILG8H3NF6oIohQviMMn/Se2
 hKXVStndoyqihkjQNeTRNg7euZB8KHUzwPkGrNYshBr2c049K4W1ifjWu6AoLFc36Mj8iArxjpK
 Xe1p5O97+pPa0kPg3FH2ZgGEydvpQbDZdwWOT3VOlkopgVDWk+boVWhIMB8cASyhlDmGO0pANTQ
 BI/PCPymQfTvSpoRqPCGgMQDFksa/etfwYjG4QorxcMhs/0BtYJc9WuIK545vndgrvVLTOi1g5y
 uDBQ8UBQvokow64PuaQ==
X-Google-Smtp-Source: AGHT+IHaLGu0hxvWzidCScSuxsWcF0YYpVTodUmpLjHhQQP127aLYzqTeb2L9IDzfLwIaxlw2wid/Q==
X-Received: by 2002:a05:600c:1d82:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-442ff03c2d7mr230373085e9.29.1747946395003; 
 Thu, 22 May 2025 13:39:55 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863A39.versanet.de. [94.134.58.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f05581sm117304575e9.13.2025.05.22.13.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 13:39:54 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 22 May 2025 22:39:40 +0200
Subject: [PATCH 2/5] Makefile: add u-boot.mbn target for mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-b4-qcom-tooling-improvements-v1-2-8141b8955cfb@linaro.org>
References: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
In-Reply-To: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=T0qoWnkb9kQCdhEkxZdYY3jAaGrV52eNDI1h7oPvp2w=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoL4uW5Jua2SJiLF4Isvenr/EQO6GUNxm76SZv3
 448pbRilVaJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaC+LlgAKCRAFgzErGV9k
 tgndD/0dVC406f5I+mXUl7OMfxY8RdSPk77WNvn7u3Zv6XLERGdUkKvoIg9IGxuK5xK84+onb/d
 TLKmoDAqBrYMoAFwDtkqX/7DWma868SAmiozraLN0i9lLX2Te/I/8WMsyXGEknrrrRlwEra7AuK
 go4fwDgyr3h4azkHwwzW2EwwZ2RrsFjJ9wz5Q4Q3A3u4Kz57hnlaJBj7u2KkYAbCBc9VQlN8IVQ
 GiR0Tnd5jQQ79pdU9To6iagYjn0wzBE3+0fprac+7Xy53U1awVepBXYbeum0yGjcWYjCRzlSeVm
 hCjxkoi2O5pyxRyUO+U3rrmmqeQZG9IvUImoVRIzOVnwMMm6cVscXob8LebXugxQhqFu08xkIi6
 sJqcCZaDToA+oqgPX9B8kujfawpsyQtd9DNbLMd4yZHnRT0vH+FxbQTFI3Y3oB7p5wYrAA4ePkP
 vXcrv6u6WOyukWGCUC3YMjPxgFoBdfKu+I2w7KizCwGHQlFqBTyVY4Sgp5r6Sgv7b0Oz9C93AU4
 tVgk+C+s7QVmn0hCH20lkTe8TfwCoWX97yzBEXPeKw8xkJGYBRuo6rlOfcMQCHPpa1NO1H5yrhO
 Q/HqFHiA0OX00UtKEJffwV6u2HosE9aqVgGpIenENYIRjh9JXUq1/aqOsvBudtrdqng3v+/w906
 dSvegsTEKwfDNSw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Wrap the new mkmbn tool so that the signed U-Boot MBN file is a
standard build target.

$ make DEVICE_TREE=qcom/qcs6490-rb3gen2 u-boot.mbn

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 Makefile                          | 3 +++
 arch/arm/mach-snapdragon/Makefile | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index f3278e3b01387a26060b9431303ed0b384310dc7..ed3d5d5381bc51473a024d4e68121b7aeea8a759 100644
--- a/Makefile
+++ b/Makefile
@@ -1270,8 +1270,11 @@ endif
 
 %.vyb: %.imx
 	$(Q)$(MAKE) $(build)=arch/arm/cpu/armv7/vf610 $@
 
+%.mbn: %.bin
+	$(Q)$(MAKE) $(build)=arch/arm/mach-snapdragon $@
+
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
 u-boot.dtb: dts/dt.dtb
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 343e825c6fdd05f36e210b138e741b7b7dd606ac..87d6c130a4d6ab6444f30c57fa0ebf484a6a1b33 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -4,4 +4,12 @@
 
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
+
+# Create Qualcomm signed elf images
+CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
+quiet_cmd_mkmbn = MBN     $@
+      cmd_mkmbn = $(CMD_MKMBN) $<
+
+u-boot.mbn: u-boot.bin
+	$(call if_changed,mkmbn)

-- 
2.49.0

