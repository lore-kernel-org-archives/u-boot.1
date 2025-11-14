Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391FCCE7A9B
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A588402F;
	Fri, 14 Nov 2025 10:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LZuQiSnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4952D84013; Fri, 14 Nov 2025 10:33:08 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E348400F
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B822F3FE2B
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763112780;
 bh=MF7a8fk98XdXH9ana3u1mEFm7OmP3ztGzKINUQkTsxo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LZuQiSnt3cEqAqY0X0tYKkjhof7K7kj/B/ICWqniUfPtUFNFs4rHv1EYNI+yKCsKV
 298Bj/1SIwZY9/u6BNuQKKrcKT+Bdo6EXgbg/OxjBTJZhmjQzFr5SIYP6hzkR/eWU7
 5bB4mIeakmcrEQq2JhjSqRmya4BckfXBmm7rocG9fsK06C4m8ykDSvHqokj9GVbXsy
 RcBGL/SFVNapmbS9ABVJGzgEgZ+FwRCMcRjZ+QMdhuG6g96Wt0jspf9Eh+2tnr4ef+
 Rf7EI7rsBqvOKVVgTOFgFWVm2NjNdqNIYDRM55xuFkkoZnUKRWTR+C80PquNneeke6
 /+WTBSC7De8A+aXoy5cgWT26zjyhASxqxUpWiUrj+3u8ZFHthvCZhwEmX9ICTCUvez
 A0as0B8/x/D6L4qcABpf0wN045V4iELeoDAEUNuDwFcxYFwwOZROlBoPp+YfmcHIv5
 0SmUK4/IWq0tY6krfxCah4Df7Qf+ajK0SNajwJQABTULpyxAm+IKrjx6x8NIBCcLrZ
 UL7cQqEfbAMnDiBHdWo3qZ8SKEwkI+1rZRXzPLRB9NfW7YlwZXcoFKmtTCw0UDFXth
 aPx5NNUgp9L9yxem/8Zyy8RxYDJa5zmdX9GlaNRlkEd3varrd9CIGoUsSSbdj5hfPU
 bnG3FKIxhe3P0vMZEKelt1lQ=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47778daa4d2so14348145e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 01:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763112776; x=1763717576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MF7a8fk98XdXH9ana3u1mEFm7OmP3ztGzKINUQkTsxo=;
 b=K9uGfqGW+9GTx11nCFv+MZpHCJuQxWtXdyLKN98BkotApMXxlGunNSPCEcgdesGng9
 7inrlPHWeDw02Xm+0HTZjcvlceeJoEzIlEWDnNpKsdR2KOjnSRcPBnzhNi0G8seM5+yD
 Hf009txsKHiPmPchhNnjJkjG8pxGLtyxuNDS7VoRBJ3KueFOha8yyMMYJOlpYspGWuC7
 k1gd1Ap2+0+DaTj2Rw+s5AvJWrBGFMvBcSIunntqUvnkYuDU6ZKSn1UR40eQ++hPNPb6
 o6CFq6JeGjpzl522N1xSKFH9komZfRlk/wwt1ccZ+dmjqFalr4YGn+yIzylaivQZT7S+
 iUeA==
X-Gm-Message-State: AOJu0YyphrjSaJGRgNZCq44TAUcNEkm2hjDy/9lcteIwR84t+I4Sxbyy
 IvAUUVOXj0VMCcyJqjNMREHHeXJ1JANzDrm2tHbBlUM7m7wBhhdEKYQxHf8bh7ZijDZD/LyjX5F
 s5iHLQ8LB4vmqHVRPXQm0Z1sr11LiQmV6CqvZgf/XXWQqUExhln/owq3ajM338EMh0UGPXy4=
X-Gm-Gg: ASbGncv6pN5EFXhbU4W7jVuilMruTtSNOR9V/tZfuFbEfDyQ8XWYshGUI1QeqvLJ49m
 Ifs6U06X67QR0+5GQdzfGfCTOwePcosr3gCK+rrPvy2Ih7o0awtzRcISCKLI0UR9BnJBC0aNpEa
 03Ga2rDcd7eYy0hxmwEdB3i2LnkhQ2QQ2Kicpj0R+xghOzZNoJAoirEokYtG/XmyKP1qwGoI8VQ
 S02G81aotGSCGVeQtENhyG2TAYKeJbMsPAkj6tL3EHlf9zcPSgSeSrb1W2yODyesoVLEKO8IHVN
 vwfY8dXo16Md2JyFQGRlfCmha5KJzjo++b+AVLeALCrbK7u3l5hen+NRs85c4WKNV0MMtzunR6a
 pSUh7lHYuIb9fNHj/bUrPkWhFmvsQvk14evEn/q9GVlU3rrxezEaDE6iAXPWDZ6dT7g==
X-Received: by 2002:a05:600c:1910:b0:477:7d94:5d28 with SMTP id
 5b1f17b1804b1-4778fe4ea78mr21204095e9.7.1763112776144; 
 Fri, 14 Nov 2025 01:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJAZPbRkudgdBdyuaT3WaXXWrWyn7qC5YdGruvtTrZfJcV7fD8AmojGuHwwf+lQV2TOP8e8w==
X-Received: by 2002:a05:600c:1910:b0:477:7d94:5d28 with SMTP id
 5b1f17b1804b1-4778fe4ea78mr21203835e9.7.1763112775709; 
 Fri, 14 Nov 2025 01:32:55 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c857311sm85462825e9.8.2025.11.14.01.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:32:55 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/7] efi_selftest: simplify efi_selftest_variables
Date: Fri, 14 Nov 2025 10:32:45 +0100
Message-ID: <20251114093246.56422-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
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

Use global st_boottime and st_runtime.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_variables.c | 118 +++++++++-------------
 1 file changed, 50 insertions(+), 68 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
index b92c3276b61..976eee8dcef 100644
--- a/lib/efi_selftest/efi_selftest_variables.c
+++ b/lib/efi_selftest/efi_selftest_variables.c
@@ -13,8 +13,6 @@
 #define EFI_ST_MAX_DATA_SIZE 16
 #define EFI_ST_MAX_VARNAME_SIZE 80
 
-static struct efi_boot_services *boottime;
-static struct efi_runtime_services *runtime;
 static const efi_guid_t guid_vendor0 =
 	EFI_GUID(0x67029eb5, 0x0af2, 0xf6b1,
 		 0xda, 0x53, 0xfc, 0xb5, 0x66, 0xdd, 0x1c, 0xe6);
@@ -22,21 +20,6 @@ static const efi_guid_t guid_vendor1 =
 	EFI_GUID(0xff629290, 0x1fc1, 0xd73f,
 		 0x8f, 0xb1, 0x32, 0xf9, 0x0c, 0xa0, 0x42, 0xea);
 
-/*
- * Setup unit test.
- *
- * @handle	handle of the loaded image
- * @systable	system table
- */
-static int setup(const efi_handle_t img_handle,
-		 const struct efi_system_table *systable)
-{
-	boottime = systable->boottime;
-	runtime = systable->runtime;
-
-	return EFI_ST_SUCCESS;
-}
-
 /*
  * Execute unit test.
  */
@@ -59,17 +42,17 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 	/* Set variable 0 */
-	ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-				    EFI_VARIABLE_BOOTSERVICE_ACCESS,
-				    3, v + 4);
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS, 3,
+				       v + 4);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("SetVariable failed\n");
 		return EFI_ST_FAILURE;
 	}
 	data[3] = 0xff;
 	len = 3;
-	ret = runtime->get_variable(u"efi_st_var0", &guid_vendor0,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0, &attr,
+				       &len, data);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("GetVariable failed\n");
 		return EFI_ST_FAILURE;
@@ -83,16 +66,15 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 	/* Set variable 1 */
-	ret = runtime->set_variable(u"efi_st_var1", &guid_vendor1,
-				    EFI_VARIABLE_BOOTSERVICE_ACCESS,
-				    8, v);
+	ret = st_runtime->set_variable(u"efi_st_var1", &guid_vendor1,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS, 8, v);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("SetVariable failed\n");
 		return EFI_ST_FAILURE;
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
-	ret = runtime->get_variable(u"efi_st_var1", &guid_vendor1,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"efi_st_var1", &guid_vendor1, &attr,
+				       &len, data);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("GetVariable failed\n");
 		return EFI_ST_FAILURE;
@@ -107,17 +89,17 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 	/* Append variable 1 */
-	ret = runtime->set_variable(u"efi_st_var1", &guid_vendor1,
-				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				    EFI_VARIABLE_APPEND_WRITE,
-				    7, v + 8);
+	ret = st_runtime->set_variable(u"efi_st_var1", &guid_vendor1,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_APPEND_WRITE,
+				       7, v + 8);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("SetVariable(APPEND_WRITE) failed\n");
 		return EFI_ST_FAILURE;
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
-	ret = runtime->get_variable(u"efi_st_var1", &guid_vendor1,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"efi_st_var1", &guid_vendor1, &attr,
+				       &len, data);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("GetVariable failed\n");
 		return EFI_ST_FAILURE;
@@ -129,34 +111,35 @@ static int execute(void)
 		efi_st_todo("GetVariable returned wrong value\n");
 
 	/* Append variable 2, write to non-existent variable with datasize=0 */
-	ret = runtime->set_variable(u"efi_none", &guid_vendor1,
-				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				    EFI_VARIABLE_APPEND_WRITE,
-				    0, v);
+	ret = st_runtime->set_variable(u"efi_none", &guid_vendor1,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_APPEND_WRITE,
+				       0, v);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error(
 			"SetVariable(APPEND_WRITE) with size 0 to non-existent variable returns wrong code\n");
 		return EFI_ST_FAILURE;
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
-	ret = runtime->get_variable(u"efi_none", &guid_vendor1,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"efi_none", &guid_vendor1, &attr, &len,
+				       data);
 	if (ret != EFI_NOT_FOUND) {
 		efi_st_error("Variable must not be created\n");
 		return EFI_ST_FAILURE;
 	}
 	/* Append variable 2, write to non-existent variable with valid data size*/
-	ret = runtime->set_variable(u"efi_none", &guid_vendor1,
-				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				    EFI_VARIABLE_APPEND_WRITE,
-				    15, v);
+	ret = st_runtime->set_variable(u"efi_none", &guid_vendor1,
+				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					       EFI_VARIABLE_APPEND_WRITE,
+				       15, v);
 	if (ret != EFI_SUCCESS) {
-		efi_st_error("SetVariable(APPEND_WRITE) with valid size and data to non-existent variable must be succcessful\n");
+		efi_st_error(
+			"SetVariable(APPEND_WRITE) with valid size and data to non-existent variable must be succcessful\n");
 		return EFI_ST_FAILURE;
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
-	ret = runtime->get_variable(u"efi_none", &guid_vendor1,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"efi_none", &guid_vendor1, &attr, &len,
+				       data);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("GetVariable failed\n");
 		return EFI_ST_FAILURE;
@@ -167,61 +150,60 @@ static int execute(void)
 	if (memcmp(data, v, len))
 		efi_st_todo("GetVariable returned wrong value\n");
 	/* Delete variable efi_none */
-	ret = runtime->set_variable(u"efi_none", &guid_vendor1,
-				    0, 0, NULL);
+	ret = st_runtime->set_variable(u"efi_none", &guid_vendor1, 0, 0, NULL);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("SetVariable failed\n");
 		return EFI_ST_FAILURE;
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
-	ret = runtime->get_variable(u"efi_none", &guid_vendor1,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"efi_none", &guid_vendor1, &attr, &len,
+				       data);
 	if (ret != EFI_NOT_FOUND) {
 		efi_st_error("Variable was not deleted\n");
 		return EFI_ST_FAILURE;
 	}
 	/* Enumerate variables */
 
-	ret = runtime->get_next_variable_name(NULL, u"efi_st_var1", &guid);
+	ret = st_runtime->get_next_variable_name(NULL, u"efi_st_var1", &guid);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("GetNextVariableName missing parameter check\n");
 		return EFI_ST_FAILURE;
 	}
 
 	len = 24;
-	ret = runtime->get_next_variable_name(&len, NULL, &guid);
+	ret = st_runtime->get_next_variable_name(&len, NULL, &guid);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("GetNextVariableName missing parameter check\n");
 		return EFI_ST_FAILURE;
 	}
 
 	len = 24;
-	ret = runtime->get_next_variable_name(&len, u"efi_st_var1", NULL);
+	ret = st_runtime->get_next_variable_name(&len, u"efi_st_var1", NULL);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("GetNextVariableName missing parameter check\n");
 		return EFI_ST_FAILURE;
 	}
 
 	len = 1;
-	ret = runtime->get_next_variable_name(&len, u"", &guid);
+	ret = st_runtime->get_next_variable_name(&len, u"", &guid);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("GetNextVariableName missing parameter check\n");
 		return EFI_ST_FAILURE;
 	}
 
 	len = 16;
-	ret = runtime->get_next_variable_name(&len, u"efi_st_var1", &guid);
+	ret = st_runtime->get_next_variable_name(&len, u"efi_st_var1", &guid);
 	if (ret != EFI_INVALID_PARAMETER) {
 		efi_st_error("GetNextVariableName missing parameter check\n");
 		return EFI_ST_FAILURE;
 	}
 
-	boottime->set_mem(&guid, 16, 0);
+	st_boottime->set_mem(&guid, 16, 0);
 	*varname = 0;
 	flag = 0;
 	for (;;) {
 		len = EFI_ST_MAX_VARNAME_SIZE;
-		ret = runtime->get_next_variable_name(&len, varname, &guid);
+		ret = st_runtime->get_next_variable_name(&len, varname, &guid);
 		if (ret == EFI_NOT_FOUND)
 			break;
 		if (ret != EFI_SUCCESS) {
@@ -233,8 +215,9 @@ static int execute(void)
 		    !efi_st_strcmp_16_8(varname, "efi_st_var0")) {
 			flag |= 1;
 			if (len != 24) {
-				efi_st_error("GetNextVariableName report wrong length %u, expected 24\n",
-					     (unsigned int)len);
+				efi_st_error(
+					"GetNextVariableName report wrong length %u, expected 24\n",
+					(unsigned int)len);
 				return EFI_ST_FAILURE;
 			}
 		}
@@ -248,29 +231,29 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 	/* Delete variable 1 */
-	ret = runtime->set_variable(u"efi_st_var1", &guid_vendor1,
-				    0, 0, NULL);
+	ret = st_runtime->set_variable(u"efi_st_var1", &guid_vendor1, 0, 0,
+				       NULL);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("SetVariable failed\n");
 		return EFI_ST_FAILURE;
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
-	ret = runtime->get_variable(u"efi_st_var1", &guid_vendor1,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"efi_st_var1", &guid_vendor1, &attr,
+				       &len, data);
 	if (ret != EFI_NOT_FOUND) {
 		efi_st_error("Variable was not deleted\n");
 		return EFI_ST_FAILURE;
 	}
 	/* Delete variable 0 */
-	ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
-				    0, 0, NULL);
+	ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0, 0, 0,
+				       NULL);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("SetVariable failed\n");
 		return EFI_ST_FAILURE;
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
-	ret = runtime->get_variable(u"efi_st_var0", &guid_vendor0,
-				    &attr, &len, data);
+	ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0, &attr,
+				       &len, data);
 	if (ret != EFI_NOT_FOUND) {
 		efi_st_error("Variable was not deleted\n");
 		return EFI_ST_FAILURE;
@@ -282,6 +265,5 @@ static int execute(void)
 EFI_UNIT_TEST(variables) = {
 	.name = "variables",
 	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
-	.setup = setup,
 	.execute = execute,
 };
-- 
2.51.0

