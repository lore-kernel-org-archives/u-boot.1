Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104A5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB44989191;
	Fri, 26 Apr 2024 16:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tHR2vagO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14BD8915E; Fri, 26 Apr 2024 16:19:48 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F06128916C
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a51f9ad7684so148452766b.2
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714141186; x=1714745986; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Y8/39cJ/XbEfKQUYQpKfPZueeODoQuUVuK6ghcCumU=;
 b=tHR2vagO2RiEqEKvabBsdDe5WhjFRONxfaDuszmaZWo4Fn0EBVBZ9Zay+DAKrsVE8n
 PTey7xalGKiz6oS4quyhlqs9nzgc3IxlCWm83k0fFNn0XJTPmKPqw9A5keWbXGH2W1Sv
 xHQxseJv7ZikRRJjeZoAO+UsFZpk2pDyhJaQkN3QeynlhqBUWTheqPWYWMUhskapKE+N
 yzyYfaPyjN4b+joQ1LXpNv7OXObobNWC4sPJAGEjPCckMcZcmPb+1zesRUA5Dj1Z3V/F
 fEjSbcXiOLa3VZxQnTr6/rPA+Ip6eSnw+qk/q1C1ltFLy3z0ry6c4ZuWhApmlzNqSO09
 nwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714141186; x=1714745986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Y8/39cJ/XbEfKQUYQpKfPZueeODoQuUVuK6ghcCumU=;
 b=nuJa4M778fQ8TTxC46F0rcWt7A3JTn1BMKgGdzU4mk1XtLNpEqHaPIiIlKXAECvgws
 4iUjuEru6vqk9koxbUDIA63m/QxwiUn9AEN01jBpH8w/irxwVtA6TIJD1D80swe6HVBe
 Ybpymf9OsFpg7dBQuh45/yU98MD5iMRQhbM0b/He4isvSleK6ObQEoichCRj0efyfVpM
 QYRmQs3eW6E9uDp8/zWtKVXMu51+kO3cvhYlbn2gr/bZ/UKsUsRLJjqL7Zosn8UqwV4Y
 zrRDvrSOOROkmDbHWjKVZE4hu3urtW2DRLIikxnw/HwHjnCYXW/9597dgwYVJfLaB/kU
 H4jQ==
X-Gm-Message-State: AOJu0YxLOsSFD8H7Wk8q8siauttBhyI6omdBxTai2hRUHmAXl5Oxq3iT
 dEzeT68ZMFQNcDuM72P6jWCx0iEz5ursw43MDkyIdH/5/afsN2OvkYI3LOpT0Dl9k6IYa7McRcb
 /VlRdJg==
X-Google-Smtp-Source: AGHT+IFEIAky7p1NWqpzRK6Z9bty+lXmyCO8hT5F8vKosxkWw+PVLvOTiBACczfr9VJSncC5pqvkOQ==
X-Received: by 2002:a50:ba88:0:b0:570:3bb:e099 with SMTP id
 x8-20020a50ba88000000b0057003bbe099mr2755189ede.1.1714141186485; 
 Fri, 26 Apr 2024 07:19:46 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::9b06])
 by smtp.gmail.com with ESMTPSA id
 ds2-20020a0564021cc200b0057059d26756sm10041182edb.76.2024.04.26.07.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:19:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 26 Apr 2024 16:19:38 +0200
Subject: [PATCH RFC 4/4] sandbox: switch to dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-b4-dynamic-uuid-v1-4-e8154e00ec44@linaro.org>
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Hughes <hughsient@gmail.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=E29aV3hWmEHhJMw6u12fMNE/7DMvKk2T1uEAZEN8hmQ=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmK7f9/WvzgTExC96OZ6YMZwevx7rRdWSIRFLbL
 nA/E6V4oHSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZiu3/QAKCRAFgzErGV9k
 tm+vEAChI75+4mOd76OnwamKWAUljhRgq5sA8I720VtLs1Avsa7mEwwKVZXd1NUTH5FqyOKQfzi
 vb44NmYVJsV1SVH9dbqxknAIyJsRkj9Y8od7q9zK9Mj4fZwmV4LtZ4GI8CWufTu6NQAcB8KXkVU
 OUKg4eaR1HHWuxTsHr/6TocZnQd4dNI0aIYPjDMz9Zipo4N54DXjWTmgeqcLcyzfhY6DqTYaKoo
 E/y1q8qI8XVIQVglRyJWL8vovCCW21/cCHx0XfVQ5LMSVnJboxgJGUkfS7HXBbG6KzF09wqVpEq
 I3NWrjPc6I2Ud0PEJ8mfuWLRWMIUb9oFloIEXRuxUU71ySsOAgy1MyEplTyHzmGRkx8zE15JGkD
 qWh/XNqEqMPXmxLB297E2lYDQML4kO2CoysCl+plZqGXqB2ORIaWpEC2GocJdMi9plpXziMKuWK
 R/d5+gUnMCqk4nE1uHKpw0y5bKKzlQWSKvXRZsbnS2q7idFt8yOMlJxoZ74C3kS8ETEXlTyqj8Q
 ELfIscsvN8ctkTPLSF6JLkEDUXlsTNn04rLJCuRQy90LUhGW0yIEg8QHXEWXaaMSOImLiXGXS6f
 hFT4nCim1fbT+/MlqngkzTiCJu2RPweM0Oc8m7UUID/lHp/C4+wHNQNN8qXnRWOFaCpvg4JTnqC
 IHyajdku7/DVADQ==
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

Migrate sandbox over to generating it's capsule update image GUIDs
dynamically rather than using a set of hardcoded ones.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/Kconfig            |  1 +
 board/sandbox/sandbox.c | 28 +++++++++++++++-------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index abd406d48841..0558c90540b6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -164,8 +164,9 @@ config SANDBOX
 	select SYS_CACHE_SHIFT_4
 	select IRQ
 	select SUPPORT_EXTENSION_SCAN if CMDLINE
 	select SUPPORT_ACPI
+	select EFI_CAPSULE_DYNAMIC_UUIDS if EFI_HAVE_CAPSULE_SUPPORT
 	imply BITREVERSE
 	select BLOBLIST
 	imply LTO
 	imply CMD_DM
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 802596569c64..68a99ce1fc07 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -31,36 +31,24 @@
  */
 gd_t *gd;
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
-/* GUIDs for capsule updatable firmware images */
-#define SANDBOX_UBOOT_IMAGE_GUID \
+#define SANDBOX_CAPSULE_UPDATE_SALT \
 	EFI_GUID(0x09d7cf52, 0x0720, 0x4710, 0x91, 0xd1, \
 		 0x08, 0x46, 0x9b, 0x7f, 0xe9, 0xc8)
 
-#define SANDBOX_UBOOT_ENV_IMAGE_GUID \
-	EFI_GUID(0x5a7021f5, 0xfef2, 0x48b4, 0xaa, 0xba, \
-		 0x83, 0x2e, 0x77, 0x74, 0x18, 0xc0)
-
-#define SANDBOX_FIT_IMAGE_GUID \
-	EFI_GUID(0x3673b45d, 0x6a7c, 0x46f3, 0x9e, 0x60, \
-		 0xad, 0xab, 0xb0, 0x3f, 0x79, 0x37)
-
 struct efi_fw_image fw_images[] = {
 #if defined(CONFIG_EFI_CAPSULE_FIRMWARE_RAW)
 	{
-		.image_type_id = SANDBOX_UBOOT_IMAGE_GUID,
 		.fw_name = u"SANDBOX-UBOOT",
 		.image_index = 1,
 	},
 	{
-		.image_type_id = SANDBOX_UBOOT_ENV_IMAGE_GUID,
 		.fw_name = u"SANDBOX-UBOOT-ENV",
 		.image_index = 2,
 	},
 #elif defined(CONFIG_EFI_CAPSULE_FIRMWARE_FIT)
 	{
-		.image_type_id = SANDBOX_FIT_IMAGE_GUID,
 		.fw_name = u"SANDBOX-FIT",
 		.image_index = 1,
 	},
 #endif
@@ -122,8 +110,22 @@ int dram_init(void)
 }
 
 int board_init(void)
 {
+	int ret;
+
+	if (CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)) {
+		efi_guid_t salt_guid = SANDBOX_CAPSULE_UPDATE_SALT;
+
+		ret = efi_capsule_update_info_gen_ids(&salt_guid,
+					      "sandbox",
+					      ofnode_read_string(ofnode_root(), "model"),
+					      ofnode_read_string(ofnode_root(), "compatible"));
+		if (ret) {
+			printf("Failed to generate GUIDs: %d\n", ret);
+			return ret;
+		}
+	}
 	return 0;
 }
 
 int ft_board_setup(void *fdt, struct bd_info *bd)

-- 
2.44.0

