Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5771CC6B2D
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 04:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9C8B40946;
	Fri, 16 Oct 2026 04:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RKUTl64REkPx; Fri, 16 Oct 2026 04:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F175440935
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792123357;
	b=Qz/wMXYWGP77CNem8OsEdeAJHKRIZ89bxO9tssXL/AmZ/OADStzlGpHmamAOSG5pLC0e
	 zoGl4rWZnxvmEGCWTRB712ve8A0RhT+PQRd00CtqeTiRTUzj8+T8jw8//yxyebblDQcOu
	 hsZtZli/5jqbYdASuE/yDhsyNo189isFuHwMMBf03Q3FwFMye034PlCCw36a8wTnBCKOH
	 +TdKgUh9bed+apl8DyuORrSnm3xwrzukT3hc7Owg3n9IO/b82MWfj6DRBNUddR6JgCy5B
	 qSKpndOv6tH7zpWflP+jQLcdSOM3EbjB2TQpNjtGPMu9GoA8J0aUyu1UdmeIhspwNAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792123357;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C2EBD5vzQ0lby01HLTJcAFcl56hSJNh9qpAt2xCsJNU=;
	b=o7Zc6/WM9D3UygdNL7Nlwkan4+trejfV2l/3XkO/eHzRL57QeW8t21VJDqXSFnofyfGZ
	 2PDIJKeFTU55odOSUXn0gEmfLoS3iaXSD7Ma1+TLCazir6WhaeE5I810u2UUFMbEKX2Ij
	 QgG9ZMN2qk2tKYq3g/TVTPWEgRlryjh4Fss/pUeSwQDwuzT4tJjUVxnTOpxQZFOTy2ebY
	 SbyHhsHGMbqz7/ozwBaE0Psfz4AZaHB9N51GQIAyJ1Z7ixE71NO/Z2mfI80R8mCMJRqlx
	 u0y9C3gxz/x8hboyUe2vvTcZrDd/xxms1aWc/7KnzB0IjgnOfGfKfaLvB1MhypQtiMw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792123357;
	bh=C2EBD5vzQ0lby01HLTJcAFcl56hSJNh9qpAt2xCsJNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tMZG7y9ECrbsS875ZClKjhJVIGyzVK1s3wtTqdeF4yKPEObeDIY4RLZqAtlTO1/Wf
	 Yh3BcJ56dc9IgmhOItPwAD0krBxzicVRi4zVoz1wusm9xDu0cUGm67Om18F86K2H5G
	 RSKGgryBmIF4XZrp1gaVqE26PITS4pCZsbs5E21TEzTqOx/qhYVAgnRFsmPwc7PQ4m
	 /cd04BCBBuRMdAWH9m5DzKKHQ04CFbbWSXYjr2ytLwbt6VSnvViOG9EuAj1uIUBnDI
	 RceJwXjrJKj2fK8YQ6cuVxE7hcGoKg4dsTjj/FET6xbxcm1xtlwX6rRdJitmzrXRky
	 2aN1gIrWdhxvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F175440935;
	Fri, 16 Oct 2026 04:02:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1025105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4A5A60686
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kixRMBrgOK1y for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 04:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE3FC60ACA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792123354;
 b=Fyjby4yF+SQIYywYZW/cT+yQmEDeWoLumqCP2nNgvbulWUzqmkcDy44wJX0NJuUmoad0
 /SoEMM8f09tq68zVMexgaHiooFfYZsk1Tu0n/hBu9xq7soAYNPpVWciQT0WwRS8N7jc9m
 3flIMPJ+Oj8dmFEUwKBofWSQYkTzFRZA23oADB2VSAmGzLG24PCB+3dh7PgJim76xwxuI
 XyJDQ0HEtt67vbz0/0K49UixRu7GQd7pOUEK+6I1V/V+SD+tbkymXMmHoxi4hRx42Dx4L
 QuKofYJxepuYuxFjxR5r+TVsVl9e+3jXGbCiyh6F/VaUGI+JYMNRTriuWzyudlHbV4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792123354;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=C2EBD5vzQ0lby01HLTJcAFcl56hSJNh9qpAt2xCsJNU=;
 b=TguEt4YVMUYPcPSI40UWMc2SLtL9QpgZQ5gfN4E8/8yCtS+I8o2o5HjCKBrB+vhbGgWr
 k8VY757KIpM7AT6hSjkuwOYF/GTtaidMtQz9WQs9bMIFFwunh8RRMq67TRwPXo2N0nUcx
 FM0mkFBqftDI48nySJDp1msXxL6+c9O9Ve9d+vJjt11+pnSFtaOmfW5Hb/pO5SUYZaO9s
 0eMXIALDG1hIViwG5H0gympyXCWhS6r+G+bXm2igQfaRdQ3+p+mlaCbYHcRJO7Z+gnXcJ
 7sRlqD3+C+WhDomXxTs+wab3csFgjsnIWETflERbAagO5QKrNtRaAwfsgg9B2i26t6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=M+hDxwJ3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=M+hDxwJ3
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE3FC60ACA
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:33 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so1531290a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 21:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792123353; x=1792728153;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C2EBD5vzQ0lby01HLTJcAFcl56hSJNh9qpAt2xCsJNU=;
 b=M+hDxwJ3VVg+LXD3/cINHtia7Wx6UWT6Mn2jBhx22dA0I9VDHW1B91oM1/SAbPTD6m
 6Wp9nW0FbpyEBOj9c4Cu8KOSKCfrpjCcYLe6NmjpAT5QZyiPmRN+aProx77myWB7ANl1
 rJoaxU8QNUaz5PgPldMc6cfsMWWJp2kUfq3SBM1DU8AGwP46QHWg2Ck8rhVmMfyHT9rW
 aYtFJcgKxyfUmDRj6NsjOZzYGZ21gf8ykuYbJwgZ0s3hs4NN+VniDAc/DuTEFXlOhtak
 0zmlPUvgXrnGXWzn8C/Ku/8/Od9mpQbRaiA5HMsQGakZt4LICHywsR3xfGS5uy86sI7W
 c9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792123353; x=1792728153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C2EBD5vzQ0lby01HLTJcAFcl56hSJNh9qpAt2xCsJNU=;
 b=Fm7qW7lQeuvew5AKi8hpgn7oLJhWcrKKvYSKrvGniE/g59wSi9zYVukB0hTRG9GT12
 P+3Wkgjr72zY/NWG5N5ckadpa5wKG3rrgT1LF/nUqWSy7DJt7xDJeHbfbOsimUHBKPv4
 G6tJsnwF5iE48GMjl3YqdcsMWTSkfaD6yhcBSBevhBFHa/w0PlvyNLsYiDjAtKiI+eF6
 qo4brVA8CyL870MpPmeGVFlsdDffG1Sw08unXn91aJu5MjfiziE1yw1NyVUz2xokZqQi
 lirIGxTnTfwHJzm4GKmTfPY2rK7M/2I5OX452t/k+uRD7TnF2+ffAe3YJlGh6d4qP0ke
 mosg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe1rHY/bmPxp/TGAL5cMgEysWhvwJo2Xd4KIe9VnxYmEziyENLeqkho8sKlc3YZ51ipu4l1vE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIrgJDQoaeDA6+Iilipwe177waTdI+9TrQ5mm2tqTLpl1n804oc
 0/HN9vfVTQV+xFlxqpfELs8EZFbmtHFj1zrFLtorZctRXH2WBjgRJamc
X-Gm-Gg: AYBFou09NGVHA9m1JrM0vc02ebAya94HgKP3yS1L0hRjVZvzftphGtfj8LcX0RlukjF
 g5y9fqZdk4YgpACxX9DoGQPJm66onpvUbmhTevyK/ZzwZhpfbL/9krnONU9in8F5z3Y7/WRv6N/
 MmauJhjb8d36QidLUmxoeOC5JiaVn7voMDu8Nf0F3YJjhwsasJxoqbfJIM2u9h50VMU365vbUTE
 90RhH3CfWwD6WLR4AOPIsxYSaQRIKpm5RrszYy9+jqiUc8UKnxq7ro11CrdCRnc7yM9b6vzqsbm
 UI67uNFvBWGBqRieD3E3H5d4POIpE5H7z+MpZJdVErV6pHT7SfvfmAQ4qct5eLCiK72KIbRJGEV
 hc/VKiJwG/RVZ32fpO98I7vkH8yb7pYCiFATFu9r300Q8fTtjCLK/kiD1tiUsaJzdfOZwU+KBwn
 ikBoo+gdbfM7kc6LgSqC/efnFZ7fSWU6TAflEw3o7koJshoSVcb8mF+xLX0WCvvvHQEkHYKjjok
 /s28fB56d90XbeodaYef9n+nH1tclTp4hn0UbEfU6z0//OEL6IcZ1Yu7LtX0P9TN802RFiw+AHg
 2q5++SjOErYPOF/wF4cWlv3oszMlY4OA/OSJcMuDUNWF2xenr/KLJxk=
X-Received: by 2002:a05:6a21:6004:b0:3e1:558d:e369 with SMTP id
 adf61e73a8af0-3e16bfbf84bmr19087491637.27.1792123352812; 
 Thu, 15 Oct 2026 21:02:32 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd654a249f3sm437294a12.27.2026.10.15.21.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 21:02:32 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: marscheng@google.com, eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/4] board: google: Add Google Tensor G5 board support
Date: Fri, 16 Oct 2026 04:02:14 +0000
Message-ID: <20261016040216.3636305-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261016040216.3636305-1-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
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

Add initial board support for Google Tensor G5 SoC boards. U-Boot
runs as BL33 loaded at 0xbe000000. Configure the MMU map, DRAM
bounds, and disable the APC watchdog left running by earlier
bootloader stages.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  |  2 ++
 arch/arm/mach-google/Kconfig | 11 ++++++
 board/google/lga/Kconfig     | 14 ++++++++
 board/google/lga/MAINTAINERS |  5 +++
 board/google/lga/Makefile    |  3 ++
 board/google/lga/lga.c       | 65 ++++++++++++++++++++++++++++++++++++
 include/configs/lga.h        |  9 +++++
 7 files changed, 109 insertions(+)
 create mode 100644 board/google/lga/Kconfig
 create mode 100644 board/google/lga/MAINTAINERS
 create mode 100644 board/google/lga/Makefile
 create mode 100644 board/google/lga/lga.c
 create mode 100644 include/configs/lga.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 36b4c7f0246..2d8ffe7887a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -360,6 +360,8 @@ ARM GOOGLE TENSOR SOC SUPPORT
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
 F:	arch/arm/mach-google/
+F:	board/google/lga/
+F:	include/configs/lga.h
 K:	[gG]oogle.?[tT]ensor
 
 ARM HISILICON
diff --git a/arch/arm/mach-google/Kconfig b/arch/arm/mach-google/Kconfig
index a9e605ebb82..f6a5c9c43f2 100644
--- a/arch/arm/mach-google/Kconfig
+++ b/arch/arm/mach-google/Kconfig
@@ -1,7 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 if ARCH_GOOGLE
 
 config SYS_VENDOR
 	default "google"
 
+config TARGET_GOOGLE_LGA
+	bool "Google Tensor G5 (LGA)"
+	default y
+	help
+	  Support for Google Tensor G5 (Laguna) SoC and boards based on it,
+	  including Frankel (Pixel 10), Blazer (Pixel 10 Pro), and Mustang
+	  (Pixel 10 Pro XL).
+
+source "board/google/lga/Kconfig"
+
 endif
diff --git a/board/google/lga/Kconfig b/board/google/lga/Kconfig
new file mode 100644
index 00000000000..22bb233f140
--- /dev/null
+++ b/board/google/lga/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+if TARGET_GOOGLE_LGA
+
+config SYS_BOARD
+	default "lga"
+
+config SYS_SOC
+	default "lga"
+
+config SYS_CONFIG_NAME
+	default "lga"
+
+endif
diff --git a/board/google/lga/MAINTAINERS b/board/google/lga/MAINTAINERS
new file mode 100644
index 00000000000..1dd03afab42
--- /dev/null
+++ b/board/google/lga/MAINTAINERS
@@ -0,0 +1,5 @@
+GOOGLE TENSOR G5 (LGA) BOARD
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	board/google/lga/
+F:	include/configs/lga.h
diff --git a/board/google/lga/Makefile b/board/google/lga/Makefile
new file mode 100644
index 00000000000..4343e05c78f
--- /dev/null
+++ b/board/google/lga/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-y += lga.o
diff --git a/board/google/lga/lga.c b/board/google/lga/lga.c
new file mode 100644
index 00000000000..e495d34ce0b
--- /dev/null
+++ b/board/google/lga/lga.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Google LLC
+ */
+
+#include <init.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define LGA_WDT1_BASE		0x200c5000
+#define LGA_WDT_CONTROL		0x08
+#define LGA_WDT_CONTROL_ENABLE	BIT(0)
+#define LGA_WDT_KEY		0x10
+#define LGA_WDT_KEY_UNLOCK	0x00c0ffee
+
+#define LGA_SDRAM_BASE		0x80000000UL
+#define LGA_SDRAM_SIZE		0x80000000UL
+#define LGA_BL33_RAM_TOP	0xc0000000UL
+
+static struct mm_region lga_mem_map[] = {
+	{
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x80000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN,
+	}, {
+		.virt = LGA_SDRAM_BASE,
+		.phys = LGA_SDRAM_BASE,
+		.size = LGA_SDRAM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		0,
+	}
+};
+
+struct mm_region *mem_map = lga_mem_map;
+
+int dram_init(void)
+{
+	gd->ram_base = LGA_SDRAM_BASE;
+	gd->ram_size = LGA_SDRAM_SIZE;
+
+	return 0;
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return LGA_BL33_RAM_TOP;
+}
+
+int board_init(void)
+{
+	writel(LGA_WDT_KEY_UNLOCK, LGA_WDT1_BASE + LGA_WDT_KEY);
+	clrbits_le32(LGA_WDT1_BASE + LGA_WDT_CONTROL, LGA_WDT_CONTROL_ENABLE);
+	writel(0, LGA_WDT1_BASE + LGA_WDT_KEY);
+
+	return 0;
+}
diff --git a/include/configs/lga.h b/include/configs/lga.h
new file mode 100644
index 00000000000..c770c5837f4
--- /dev/null
+++ b/include/configs/lga.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2026 Google LLC
+ */
+
+#ifndef __CONFIG_LGA_H
+#define __CONFIG_LGA_H
+
+#endif /* __CONFIG_LGA_H */
-- 
2.56.0.212.g129ede20d9-goog

