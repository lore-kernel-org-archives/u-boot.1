Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FA9C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0DC835D4;
	Sat, 24 May 2025 01:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C+HxEagS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18BDB83420; Sat, 24 May 2025 00:59:19 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA9DA83340
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c277331eso1102347b3a.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041155; x=1748645955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UxWJUFtXfZNlyKAzK4hh4hRBek2Cl7SQm6jmirM28I=;
 b=C+HxEagS9rgC6l8adDXkx/W5YPL6wj3cjOvi5S80RJawAv9X4eIyJUp0RiuyFr5tLU
 AmQokzGdT9+5CD+F72U7PRHWse5CHZr1nV1C8zazfqoi7I/eSJyKCDNm01EJAK8CJO/1
 ygyPmLkwtuVISMJ3/eaTTosutcCaO7uJY4YYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041155; x=1748645955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UxWJUFtXfZNlyKAzK4hh4hRBek2Cl7SQm6jmirM28I=;
 b=DOIbhpoK+33Q9MTHH/IFpgFZPOU8tL9lXGRTPbNWHlFNwmk5C+3g0Zqrsty5+RtNkL
 vSa2UQszoh+c+reXsi8j6nqpB+akKnzJ8kN/vNBqAfG1TTwIZvzRqBNDFLxq7W17i9/U
 72K+mdtY8KVfkXmYkz5pBSzp6LroZrWls2M5bJEsvBrhO+dNRtnp7WxW3T5V+3BfACFQ
 qU9fxwCTBYn+WngSsN/3jWrCFAfju2AEDLxYDXCBQUr3t42BBS6rL6dV+PD5BngmsTtH
 043WUo3+Biz8DrFWJ3xPIvAXLPTXV/IOTAXrNmEr2Z37MB3J9FlZ9tAgjeyo4ceIhAOD
 bQiw==
X-Gm-Message-State: AOJu0YzWYU7Cxx3s2YDBW+5rmm4xz4I5JlX4pOnBkgxjBiIX+du2HKpz
 0oPstL6uZ9FdQ40vgYGxEs/rnMH52PSsrmiozxJ1Uu25k6zAGdjFMCNlzoWg6uHZgIwka4Hnfth
 a8d0=
X-Gm-Gg: ASbGncvqDI9zI9ixXtYu0m2XqDnVlIrmGqVv3Nt+WebBkQRUPhLdfRtQ1R+COZhzn/y
 SoaWdHbPxxVPUHM0cJSTaziTyZdbtM/TdSPZ+pwV2BivfnE2FNsooLmjXxZGCfHan4UMtLI61Ba
 lPkx383dKsgICNN5dBXEQ1NEn2vbalwZzu3HMfQ5by55PKJBtOuMhtjEHcd0rFkDbl32VNW+AOt
 VPVEURNxdkD8dh8p5/xFVB65W6msoBKOnNN7DgSp3bt0DaUIolzvw6B4ySuMVELjEocLEYAQVMi
 G6mPJxdOjQHh+mpTRp76OCXkjKZ2ANO6WrVNMA11y+GMzWG1nbOcqNedBvML5iuia4P9QjQhLbW
 pmt2Q1bNncgNydTg=
X-Google-Smtp-Source: AGHT+IHewRR3vDFF7/aSowMje59HNl30TowBLmRUFkGc93xR2desx6yhuVB4Gck5jL/kd7jqd1p0Fg==
X-Received: by 2002:a05:6a21:4002:b0:1f0:e2d0:fb65 with SMTP id
 adf61e73a8af0-2188b52236emr1789642637.2.1748041154987; 
 Fri, 23 May 2025 15:59:14 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a970b9basm13223492b3a.49.2025.05.23.15.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:14 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 18/28] coreboot: Dump VPD information in cbsysinfo command
Date: Fri, 23 May 2025 15:58:33 -0700
Message-ID: <20250523225845.2311989-19-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Coreboot populates a memory copy of the vital product data (VPD) during
boot. Read this data structure and print out the contents in the
cbsysinfo command.

Example: (redacted some things)

 Chrome OS VPD: 00000000ffffd000
 RO size     : 24e
 RW size     : 122
  "region" = "us"
  "bluetooth_mac0" = "8C:FD:F0:40:15:28"
  "wifi_mac0" = "8C:FD:F0:40:15:22"
  "in_accel_x_lid_calibbias" = "38"
  "in_accel_y_lid_calibbias" = "11"
  ...

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/cbsysinfo.c           | 34 +++++++++++++++++++++++++++++++++
 include/cb_sysinfo.h      |  4 ++++
 include/coreboot_tables.h | 13 +++++++++++++
 lib/coreboot/cb_sysinfo.c | 40 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)

diff --git a/cmd/cbsysinfo.c b/cmd/cbsysinfo.c
index d6ab71a3db8d..74a66f8c1b9c 100644
--- a/cmd/cbsysinfo.c
+++ b/cmd/cbsysinfo.c
@@ -436,6 +436,40 @@ static void show_table(struct sysinfo_t *info, bool verbose)
 	print_hex("MTC size", info->mtc_size);
 
 	print_ptr("Chrome OS VPD", info->chromeos_vpd);
+	if (info->chromeos_vpd) {
+		struct vpd_cbmem *vpd = info->chromeos_vpd;
+
+		print_hex("RO size", vpd->ro_size);
+		print_hex("RW size", vpd->rw_size);
+
+		unsigned int i = 0;
+		unsigned int len = vpd->ro_size;
+		const u8 *blob = vpd->blob;
+
+		while (i < len) {
+			unsigned int vpd_type = blob[i];
+
+			switch (vpd_type) {
+			case VPD_TYPE_INFO:
+			case VPD_TYPE_STRING:
+				i++;
+				unsigned int key_offset;
+				unsigned int key_len;
+				unsigned int val_offset;
+				unsigned int val_len;
+
+				i = vpd_cbmem_parse_key_value(blob, i, &key_offset, &key_len, &val_offset, &val_len);
+				if (vpd_type == VPD_TYPE_STRING)
+					printf("  \"%.*s\" = \"%.*s\"\n", key_len, blob + key_offset, val_len, blob + val_offset);
+
+				break;
+			default:
+				i++;
+				break;
+			}
+		}
+	}
+
 	print_ptr("RSDP", info->rsdp);
 	printf("%-12s: ", "Unimpl.");
 	if (info->unimpl_count) {
diff --git a/include/cb_sysinfo.h b/include/cb_sysinfo.h
index b2128bb20a19..f6c4f3a5edea 100644
--- a/include/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -264,6 +264,10 @@ int coreboot_early_init(void);
  */
 const struct sysinfo_t *cb_get_sysinfo(void);
 
+unsigned int vpd_cbmem_parse_key_value(const u8 *blob, unsigned int offset,
+		unsigned int *key_offset, unsigned int *key_len,
+		unsigned int *val_offset, unsigned int *val_len);
+
 /**
  * fdt_fixup_coreboot() - Add the /firmware/coreboot node to the FDT
  *
diff --git a/include/coreboot_tables.h b/include/coreboot_tables.h
index 6e7686e360c5..7d54ff94cf93 100644
--- a/include/coreboot_tables.h
+++ b/include/coreboot_tables.h
@@ -551,6 +551,19 @@ struct cbmem_entry {
 #define CBMEM_ID_CONSOLE		0x434f4e53
 #define CBMEM_ID_NONE			0x00000000
 
+struct vpd_cbmem {
+	u32 magic;
+	u32 version;
+	u32 ro_size;
+	u32 rw_size;
+	u8 blob[];
+};
+
+#define VPD_TYPE_TERMINATOR		0x00
+#define VPD_TYPE_STRING			0x01
+#define VPD_TYPE_INFO			0xfe
+#define VPD_TYPE_IMPLICIT_TERMINATOR	0xff
+
 /**
  * high_table_reserve() - reserve configuration table in high memory
  *
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index ec9a47242e34..d2e5e6d9bb6e 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -634,3 +634,43 @@ clean_coreboot:
 	fdt_del_node_and_alias(blob, node);
 }
 #endif
+
+/*
+ * Parse the length header that is 7 bits of length and a top bit indicating
+ * "more" to the length.
+ *
+ * |  7   | 6   5   4  3  2  1   0 |
+ * |------+------------------------|
+ * | more |        length          |
+ *
+ * The "more" bit indicates the next byte after this one has more lower
+ * significant 7 bits. This can be repeated multiple times to make long keys or
+ * values.
+ */
+static unsigned int vpd_cbmem_parse_len(const u8 *blob, unsigned int i,
+					unsigned int *start, unsigned int *_len)
+{
+	u8 more;
+	unsigned int len = 0;
+
+	do {
+		more = blob[i] & 0x80;
+		len <<= 7;
+		len |= blob[i] & 0x7f;
+		i++;
+	} while (more);
+
+	*_len = len;
+	*start = i;
+
+	return i + len;
+}
+
+unsigned int vpd_cbmem_parse_key_value(const u8 *blob, unsigned int offset,
+		unsigned int *key_offset, unsigned int *key_len,
+		unsigned int *val_offset, unsigned int *val_len)
+{
+	offset = vpd_cbmem_parse_len(blob, offset, key_offset, key_len);
+
+	return vpd_cbmem_parse_len(blob, offset, val_offset, val_len);
+}
-- 
Sent by a computer, using git, on the internet

