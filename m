Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFFED75E34
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A90F89922;
	Sun, 24 Nov 2024 20:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cKHkkSIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF0D89812; Sun, 24 Nov 2024 20:18:00 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76178956D
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cfaa02c716so5053662a12.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475875; x=1733080675; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XBM2x2KNEvKiAkDcaHJnKhElyqHsy4crCo5njXmLu/M=;
 b=cKHkkSIlbEcCcO5ylzRZ/DNUWKOlwhprhkosi1wfXDhAD8jdphI528I9sz2gXMFUuF
 y0dk5A+bY8+XZJJZ4zlSbTDmIyi/YcRfwcq7yxrb8B45iP3nsIl/8CE2xZJrhXTOqqoe
 V4N3VcugmiebRJ8kkBRldi0Yv4INfngegpi/h/SVSEoMqxFW8F+7Ad2yLZdvMXSO8cc3
 /JZi7TstTsqn/BSx4mPm5C6ZxJdI5A3E6FlCRQp4jtAVU3uy4cITTN2PYV37Q+51Hv7Z
 ztoIvw45awm4LPJHeI7RZ4q4B+Bw5V0XTIqq5ph3kGrpc4HIbYKQc7DA/J4jwuJ6qpwp
 iyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475875; x=1733080675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBM2x2KNEvKiAkDcaHJnKhElyqHsy4crCo5njXmLu/M=;
 b=c25GPPBLQluOqyaJ2ki8q2RNN3VUdHMb8l6uM4Ote7WwOZaDicPocoFSrndCsktyEW
 rqOLfWq8ypapxQGrely60FAZvmGajwhtlwEEVCWW7HKDkryCmRX1ZcoQDOT5D9ebfWXr
 wi3V9wccCUWA4hbWpy/X+17bx+uQGs7u84xobKWMhEz7SNmyEC/9LF8xaNnKjctwUpZM
 4RQYBHUTscw57As0oHOvnhGCbM/hkigUNrvOHeKRGDg+/6r3od3tXHEmYycxZ4JOuyEt
 sbEKmZw6iqgwR5idQ6Y4px+3ECd0U0tKquvX8u5nIiLNYLqKnXwl5mJ5JbOPntkuJgmz
 eiFQ==
X-Gm-Message-State: AOJu0YwPLdKhtY/16oLRA32TfDrs1Wjl/gZutTkH3mNELUFfXePWMqny
 +4rgcoAcfPjck0MNxGgewEUoCfxHzO7xo44o3s+6DuitHsEzc0jyoujbQo66fBM=
X-Gm-Gg: ASbGncsTIkjt6F+vF1CkbgG8z8YG+LQeg5QrKL41SC1d57+upc9WWcGIIT40sgnsotk
 gQxnmkCYzHee8NvLfEiYURQk8BUT0TTY3GKlUhfHZbb/1TlnBMWdZaNvnwfNNhbZhVgP+JBKuDT
 ah2XDNQCgsp7jSZuU9N9nBl6cqJkxvqPbrBlqegOFMoW1+5y7XsoCwHDyBofTDIEmCGpP7L3+dE
 CyLSeKX3/Ver0PdQEKOnVvXaHVdfEpvClgK2PoDecguiq4kRhs1bFPgTO5wWYT1OO2/
X-Google-Smtp-Source: AGHT+IFQYC3hSFe3b8oggB7lM4NSjTWxb2+p6NwafgFYDoSD4b9GWF4HwxB9lk1ZeltsKZ2edBF1jA==
X-Received: by 2002:a17:907:ab5:b0:a9e:b2da:b4a3 with SMTP id
 a640c23a62f3a-aa509bc13ffmr768672666b.42.1732475875492; 
 Sun, 24 Nov 2024 11:17:55 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:54 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:50 +0100
Subject: [PATCH 08/15] soc: qcom: smem: get serial number from socinfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-8-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WUGycCEx0AhKcEQDcuUT58urz11+dO8c/zjsD9E5QQw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6pt7mDgCNy40SeySYe4TMTr241JwefpMTk5Nlw3xJ
 9dsbQ3sKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABPpV2b4w8ugW6gUukenuZJr
 zhqtqIcLLt2f7ZBxqlnoOWN28zMtJUaGZfFti+7mfniyr3bm9k+5LWkstbd+uPBODPLkOfFqX9h
 CWQA=
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

Implement socinfo support to fetch the serial number if available.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/smem.c | 25 +++++++++++++++++++++++++
 include/soc/qcom/smem.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 5166f289dfb6..5570c5c907ad 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -13,8 +13,10 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/sizes.h>
 #include <soc/qcom/smem.h>
+#include <soc/qcom/socinfo.h>
+#include <env.h>
 
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
  * consists of one of more memory areas that can be accessed by the processors
@@ -982,8 +984,31 @@ static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
 
 	return 0;
 }
 
+int qcom_socinfo_init(void)
+{
+	struct socinfo *info;
+	size_t item_size;
+	char buf[32] = { 0 };
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
+			     &item_size);
+	if (IS_ERR(info)) {
+		log_err("Couldn't find socinfo: %ld\n", PTR_ERR(info));
+		return PTR_ERR(info);
+	}
+
+	if (offsetof(struct socinfo, serial_num) <= item_size) {
+		snprintf(buf, sizeof(buf), "%u", le32_to_cpu(info->serial_num));
+		env_set("serial#", buf);
+	} else {
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 int qcom_smem_init(void)
 {
 	struct smem_header *header;
 	struct qcom_smem *smem;
diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
index a955db08c0f0..755003807dba 100644
--- a/include/soc/qcom/smem.h
+++ b/include/soc/qcom/smem.h
@@ -4,8 +4,9 @@
 
 #define QCOM_SMEM_HOST_ANY -1
 
 int qcom_smem_init(void);
+int qcom_socinfo_init(void);
 
 bool qcom_smem_is_available(void);
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size);

-- 
2.47.0

