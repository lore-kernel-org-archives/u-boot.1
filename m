Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FB7C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE6683600;
	Sat, 24 May 2025 01:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IR6ioGDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC6183416; Sat, 24 May 2025 00:59:20 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F377F8340C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-742c2ed0fe1so410823b3a.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041156; x=1748645956; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNxVwB0fJT/2GFuQNhOT8idHB1ulK8Any2hO22Y5gt8=;
 b=IR6ioGDJaasRQNG0XbLWTHiVLmqZFwKu8Q8R02g+10TXHJCGbLDiIgg7G+rz4nOzLf
 qnTIcnOx9Z646vtQyBMpxhTJJIu8kPQkXy1y9poZHGXifXCrGeIH1J4ZmGElv96MlB6i
 duPCzSKQ9X8RjIs+RisUdQzD8MJTnHEp7KSm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041156; x=1748645956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNxVwB0fJT/2GFuQNhOT8idHB1ulK8Any2hO22Y5gt8=;
 b=Cs6r1/p6WWClc1OQDzcESBLvlGi1jleUCuywLZxvEUU8v6lkYOEcC7QHdqUGj4ViwU
 ErLgIld3Kp8DGdeuuUER0Ep+/Hyb46eM4dMYCurJ5ezTOjnc0VWwT1BGU3f6D1mXWZhn
 M45/WGqsVMl/wMdagLW6WCohzNz5ZO4hJE1odukRs5irNgjhySzRT2ljadKlTP3Rdp/9
 fFq3B0VN4C5Q66UWAZxXMfTqbu9Cmtvk4Na5F+seKPKGU4TJzvGQ5PVtuhu6bKJ2ltql
 bN+qmpwKAtP/5c4dpcDfyZwHrBX8imiZWNur8XwMBysP5Ze0ZXA2TzCdHngYegEIpvmb
 7BWw==
X-Gm-Message-State: AOJu0YxSvvAPklPOJAuLszjLF1XO14YnkVoyfHFBQEPOhrRVXDJsffmt
 280P/7Rkv3/s3bsMTQTvOhpH3Rr/7LVbvwunHuAR2GfOfeks1Fe+X2IJXbaksnwnKzxCUdHViNl
 9drw=
X-Gm-Gg: ASbGncuu/GvMG1DE+qfSRM7GVmc/KXtMrKcq2g0pfIuVSnhw/lbrN7bTWmseL+1mF5V
 1TjUUHd+tOLyGN2ffrXcgoqOWDkXfkvZFbc8PsaCLmShFrR3HVi8MzXDx/a46LVKrKfY+05KKnk
 X8C1B+4eChyyoT5EMNaSioKBMVW2rSffKN6I1v0qXfV2YmI+5tU55/bgYhvpv9DpbXav7E7pCGJ
 TpcNZAW5dknqtl3vxR5GdPn3x75H7CGSF/0clOrQgit9vMy9MjyrobWpcCqqUUPCyKXqMXSC6iM
 VKxjHjlr5yHYWtSXcv85j0ZVh6yGBjpgujx0eE3jxGXLGCTwPdqlSPsLrIW9QcCi7lW9lILOMYG
 34Xlcimvh3uxZaHc=
X-Google-Smtp-Source: AGHT+IHU+EOMD0JBf+FlujA74zhzlJtHWBnmMrhajZ+w7rMs9lecX+sSfyTdfXGYE17lQeMO9m6Jrw==
X-Received: by 2002:a05:6a21:6d87:b0:1f5:6e71:e55 with SMTP id
 adf61e73a8af0-2188c1e8722mr1735139637.6.1748041156395; 
 Fri, 23 May 2025 15:59:16 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a98770cdsm13328691b3a.151.2025.05.23.15.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:16 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 19/28] coreboot: Set serial# from VPD
Date: Fri, 23 May 2025 15:58:34 -0700
Message-ID: <20250523225845.2311989-20-swboyd@chromium.org>
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

Set the serial number environment variable based on the value in VPD.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/coreboot/cb_sysinfo.c | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index d2e5e6d9bb6e..92e4f9ca0c0c 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -674,3 +674,65 @@ unsigned int vpd_cbmem_parse_key_value(const u8 *blob, unsigned int offset,
 
 	return vpd_cbmem_parse_len(blob, offset, val_offset, val_len);
 }
+
+static unsigned int coreboot_set_one(const u8 *blob, unsigned int i)
+{
+	unsigned int vpd_type = blob[i++];
+	unsigned int key_offset;
+	unsigned int key_len;
+	unsigned int val_offset;
+	unsigned int val_len;
+	const u8 *key;
+	const u8 *val;
+
+	if (vpd_type != VPD_TYPE_INFO && vpd_type != VPD_TYPE_STRING)
+		return i;
+
+	i = vpd_cbmem_parse_key_value(blob, i, &key_offset, &key_len, &val_offset, &val_len);
+	if (vpd_type != VPD_TYPE_STRING)
+		return i;
+
+	key = blob + key_offset;
+	val = blob + val_offset;
+
+	if (!strncmp(key, "serial_number", key_len)) {
+		unsigned char serialno[64];
+
+		if (val_len > ARRAY_SIZE(serialno))
+			val_len = ARRAY_SIZE(serialno);
+
+		strncpy(serialno, val, val_len);
+		env_set("serial#", serialno);
+	}
+
+	return i;
+}
+
+/*
+ * Set environment variables based on the contents of VPD.
+ */
+static int coreboot_settings_r(void)
+{
+	const struct sysinfo_t *sysinfo;
+	const struct vpd_cbmem *vpd;
+	unsigned int i = 0;
+	unsigned int len;
+	const u8 *blob;
+
+	sysinfo = cb_get_sysinfo();
+	if (!sysinfo)
+		return 0;
+
+	vpd = sysinfo->chromeos_vpd;
+	if (!vpd)
+		return 0;
+
+	len = vpd->ro_size;
+	blob = vpd->blob;
+
+	while (i < len)
+		i = coreboot_set_one(blob, i);
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_SETTINGS_R, coreboot_settings_r);
-- 
Sent by a computer, using git, on the internet

