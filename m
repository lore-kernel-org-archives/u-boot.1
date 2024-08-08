Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA1FC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 23:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A24C8883D;
	Fri,  9 Aug 2024 01:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CZ6sLMuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE1388A2F; Fri,  9 Aug 2024 01:59:40 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DAE87A09
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7aa4bf4d1eso187870566b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161578; x=1723766378; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pj2j22ZFRUzC2Ii2PQHsVioWDBYEijJ0Q5tSejxkErg=;
 b=CZ6sLMuHrus3v+EGhk7lf+6EWFf00c6wuTN7nmbRHRW+DOw3rxcy4EkuPXmwrDmjlf
 CGMc4fiyTekBtb7Z5mL0HSHHeaTgH+hRLQJxstTgCDqjTJP8Qj+b6f/eziBbpX+FbSxB
 3C+mXBgRgV6einIcKEZ9xXsvEZq4BbtiaXTFZoj53qQ2uXJzsdxgBGW5vrPJa+lbvUI9
 lwOHcHBD85DpMvqPM53GsjdfHK9M8HcQ7q6yAZgYZk+Sbx8qYNtOZwfxIkBlIR9UWaNc
 5raoTN6sQbqIGG15/SHy7zWbsqVk7iArhtbDoOWqhWMvYHxq+NVvlfXG2Gfrom2sWNv9
 V/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161578; x=1723766378;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pj2j22ZFRUzC2Ii2PQHsVioWDBYEijJ0Q5tSejxkErg=;
 b=A5ZVjAMmWNWGc0w6Zg7tOt3gK0fPUiyiZoldb29w5vrfZt/6y1tyFbirmCDrVF/IUT
 rWy0SGhZBonvbCEnMr79dMQ4ErY1iRxA3RcnERM/vm1uII6mVxgoUVaexvK5Yz9Rw3TD
 b17HhkD33RyjCTqsh/8hcNwFpAgICThbD+cz51s9Sso9h9p3MXsmsabgX/iQ1xYpEPoA
 FaxYTWyYaV8E4Vh6/xqECQaX7Q9MECxir38TfZm+zc2FhxkRpKSnApBAOiaGm6RZQ//2
 PYVKq5w2VvvdvCt0sFJVCP5anFQveUi16xyras2GWbbE2rJsdxLHKV2G3LMOFzvWoCs1
 igTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuOQbK8IRrW4UK+U9n5aHNUfqPBNrJjISuTtdijH6D9l11pfxeMDrwa4Y85eGcEeb9J+ZQrp1QH8zsK5OWH9q7WAtiNw==
X-Gm-Message-State: AOJu0Yw+x/o++bab9iYvYa4/xi0kX0NL1o5HJPbnVex7D3xVSSECrRJc
 ptfTJ8aFHVfg9Qfl7iktXXLRLtyHaUNROkqnRdPuTzfNmN69bpyOi170RKFXwzc=
X-Google-Smtp-Source: AGHT+IETTA+XrcVwI5bLn3El4/xULeBFDTOud4cRZkj+Jmbx5C9+fz56eSK0yNllGyj/pZhcV0Yz5Q==
X-Received: by 2002:a17:907:94cf:b0:a7a:b9dd:7757 with SMTP id
 a640c23a62f3a-a8090c25606mr292640366b.12.1723161577609; 
 Thu, 08 Aug 2024 16:59:37 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:37 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 00/11] mach-snapdragon: various improvements for newer boards
Date: Fri, 09 Aug 2024 01:59:23 +0200
Message-Id: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANtbtWYC/x3MwQqDMAwA0F+RnBeoUnTbr4wd6pJqDqYlGSKI/
 76y47u8E5xN2OHZnWC8i0vRhv7WwWdNujAKNcMQhhju4YFzRNdUydJSFGWrVnbeWL+OmUaa+pi
 mPBO0oBpnOf75631dP2MMX1VsAAAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=JTofdLWA9UG4ydo1jb75sAt+e516o13DL1EV1WBUgvk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvnQcQR4BGkVrczVh4/BmEGrvl/Uw9l/ihEI
 8YD1orX5GWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb5wAKCRAFgzErGV9k
 tmB4D/wNhjnXxjOlaHp4unH7gEqeXIvJgPs8EK+CvjrbDvpb06AUJ9enO5OQ0csn9K2zsJpDuNS
 brda3KKad2Od6X/EWxtDoyhs8LPSgOzNk1n5J/OXmQqGzmab4JULWTBASqt+nyC2bBk3WTbxEcZ
 KX8u0QvEMZ1pWPyz+TJZB++Th0AlQoMayuY385xE6jP2c76eswtFCCv3OVvZ/vZxYGx8rZ39Xtl
 ZSOwoG8/tk/1c4bmWx5HHlBvFP/7IOStn2FdSVeRT0cfEWJaEd4k+FRVWPo6lAgDogqBb3ggL15
 crROL8vAEyOWzkh61igSFsFbTLae77g+cP/CLIIAQEo5DvhZfAD4FO03tAS4d2OCMvG0T5FVsZw
 kl/IJIJ786+MdllsOaLnOxVzgiGt94luWcNo8O75gb0jeVqyoHRg9X3IjZR+0zGxNuUEVpe5Cl9
 GbPvJ2XyCT/b0bdJSeWmq9Bln6m5/PZMNSv96+KyRlwcD16IF83L8O0mUYsmxMRLlxPBNblKrZX
 7chhHoLEUfTToapkRYaGW7nWEhgNOELjEo1PF307b9kAFqccrSr6+jdInZI9YEW67rVP61Q/O0c
 ikCKR6FBcmnbr8pdkZyo3yLLpWTsOdZplmRWqzKsmD9JuB55GBU2KgbEteDD8+k3UHE+93UbjSy
 sbRW7iExu0AXrcQ==
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

Supporting the newer SM8550 and SM8650 SoCs unfortunately requires a
bump in complexity for us. Qualcomm changed a lot about how the memory
map is handed over to the "kernel", adding many holes, not mapping
certain regions, and adding regions with 0 size. The SM8650 HDK has a
whopping 14 memory regions, some as small as 44k.

Supporting this properly has proven to be a bit of a headache, but I
think this implementation is "pretty good".

In addition, we set a valid fallback fdt_addr_r in the U-Boot
environment, allocate a buffer for fastboot, and set the loadaddr
variable too.

board_fdt_blob_setup() is refactored for readability and potential
future expansion (e.g. if supporting multi-dtb FIT becomes desirable).

Finally, a function is proposed to allow for mapping new memory regions
at runtime, and the cmd-db driver makes use of it to map itself, since
SM8650 boards don't seem to include it in their memory map.

Tested on SM8650 HDK, SDM845 OnePlus 6, SM6115 RB2, SM8250 RB5.

---
Caleb Connolly (10):
      mach-snapdragon: refactor board_fdt_blob_setup()
      mach-snapdragon: parse memory ourselves
      mach-snapdragon: set serial number
      mach-snapdragon: allocate fastboot buffer dynamically
      mach-snapdragon: populate fallback FDT
      mach-snapdragon: set loadaddr
      armv8: mmu: add a way to map additional regions
      soc: qcom: cmd-db: use strncmp() instead of memcmp()
      soc: qcom: cmd-db: map cmd-db region
      qcom_defconfig: bump CONFIG_NR_DRAM_BANKS

Neil Armstrong (1):
      mach-snapdragon: use 1MiB for get_page_table_size()

 arch/arm/cpu/armv8/cache_v8.c    |  25 +++++
 arch/arm/include/asm/system.h    |  10 ++
 arch/arm/mach-snapdragon/board.c | 203 ++++++++++++++++++++++++++++++++++-----
 configs/qcom_defconfig           |   1 +
 drivers/soc/qcom/cmd-db.c        |  11 ++-
 5 files changed, 221 insertions(+), 29 deletions(-)
---
change-id: 20240809-b4-snapdragon-improvements-fd6d714a7fbd
base-commit: a2ce853383b18a2cf920268ee341f2585a11adef

// Caleb (they/them)

