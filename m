Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C306EC61D88
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59ED87574;
	Tue, 21 Nov 2023 02:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cQADARlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FD287574; Tue, 21 Nov 2023 02:31:19 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B630C875B5
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ca85ff26afso8802255ad.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530240; x=1701135040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jV5l8YImZIXIFIXxc6opG4nNMwJSYg+WrFO678oFI8I=;
 b=cQADARlpUZOGpJp3Z9gdtnr8dMRTunOLtO/j+mbdeJXG3U6o9OFtfb9NZ9ZAF2yg5d
 C/t9/mttCbOFQQNj3T5a1Lnd5KzTUqhMHsQqVxGY0Yc036gFJjB5A1JKXXJ/ZbW0uVk6
 +gS300EYkHlPmseKBiHBrmrGKI3hMSZukAPEUmLc1G5SuQLwv90P0wA2mTtV7IUNMIa1
 bYdSna+S2EP3AIPNXwXast5Hm6B6zY/3eAKAG2lbfjJ6m8u0Qx1kaTWwL0gIeL/OHESJ
 sYOnMXvSN2CKEErSOCDBk3GEMrq0rCJ9c2WhqZObxJgX/NsI0viqKcyVNxSAVzBYUBEb
 I/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530240; x=1701135040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jV5l8YImZIXIFIXxc6opG4nNMwJSYg+WrFO678oFI8I=;
 b=nKLMjMp7fNoXojicH6+4eTGcTjNhdeiWHxSvrYhVU2+/yOqUXDq9K+O/fYyuK14y3b
 pV8INO8RNGjvtZF4LRDKhwCIjjGopDhybKTkBsS3/Ckb6UQXKxY5V3dN8+vLGbybRdd7
 +F+1U0QSABHMuWG+579ZoedJg6N5YJsvmdjmQ7Jd9RzACakcz2tUC+M+HoSLhCJA9ZW/
 bt1BaMcEnGeKYGKm/3W1OPo/vty3h3pN5K1D/aoMTnYm5vSxx7WofaX+eBLjXwRiWor+
 m9q0NEcOmAq1Rp88z0lqVhtztRzRl2aZj6XxspqWiiBQcZxibFf4jlOuud+AzcxNqf3K
 4AGQ==
X-Gm-Message-State: AOJu0Yz7uU3mt93ZT9sD5HiMLAVROud3coODXfZ5Vcv2LJOHPlLPvzfK
 3JgapDMtW+Zf7ifI6C8LVT949A==
X-Google-Smtp-Source: AGHT+IG75S+3upkXkEaDr7vr57M6oabmkhSnHbvA+XSTDCbD45Pr1MID7lxdqSBDytJJTptLmT0bOA==
X-Received: by 2002:a17:902:e749:b0:1ce:63bf:e4c9 with SMTP id
 p9-20020a170902e74900b001ce63bfe4c9mr11605260plf.0.1700530240157; 
 Mon, 20 Nov 2023 17:30:40 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:39 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 04/12] cmd: bootefi: carve out binary execution interface
Date: Tue, 21 Nov 2023 10:29:42 +0900
Message-Id: <20231121012950.156539-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

Carve binary execution code out of do_bootefi_image() in order to move
binary-execution specific code into library directory in the later
commit.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 87910c42333a..957e2618aca2 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -515,6 +515,36 @@ out:
 	return (ret != EFI_SUCCESS) ? ret : ret2;
 }
 
+/**
+ * efi_binary_run() - run loaded UEFI image
+ *
+ * @image:	memory address of the UEFI image
+ * @size:	size of the UEFI image
+ *
+ * Execute an EFI binary image loaded at @image.
+ * @size may be zero if the binary is loaded with U-Boot load command.
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+{
+	efi_status_t ret;
+
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
+	if (ret != EFI_SUCCESS) {
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		return ret;
+	}
+
+	ret = efi_install_fdt(fdt);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	return efi_run_image(image, size);
+}
+
 static efi_status_t bootefi_run_prepare(const char *load_options_path,
 		struct efi_device_path *device_path,
 		struct efi_device_path *image_path,
@@ -696,23 +726,11 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 	}
 
-	/* Initialize EFI drivers */
-	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
-		return CMD_RET_FAILURE;
-	}
+	ret = efi_binary_run(image_buf, size, fdt);
 
-	ret = efi_install_fdt(fdt);
 	if (ret == EFI_INVALID_PARAMETER)
 		return CMD_RET_USAGE;
-	else if (ret != EFI_SUCCESS)
-		return CMD_RET_FAILURE;
-
-	ret = efi_run_image(image_buf, size);
-
-	if (ret != EFI_SUCCESS)
+	else if (ret)
 		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
-- 
2.34.1

