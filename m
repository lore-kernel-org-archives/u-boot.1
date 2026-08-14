Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F0FC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 128E360A6D;
	Fri, 14 Aug 2026 18:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OU4DIDScGzoA; Fri, 14 Aug 2026 18:39:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C5006080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732747;
	bh=pBky9y6kgDi8Uo9d21MfUAypMnE2okqYNCVlrWyYba8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KzL00xdtNDAMfJhwpfS+fadpFAJrZyE1pIRR0uhMyWm6OrJfgpfPRNo4zVj+X9DNo
	 kJtssGlqFd7V2tBUAgpOI9iOhr+zOcADVrwLsjGCQBg5rdN534xQIJswhmiZ/ID058
	 /BfJ7LfzOh7+GcaDfpMnAEOlz37l1Wy/scF5mb/wAG83fh613Eg/MeTnSr4smuZOCg
	 G9T9SakNo63kt39N22Hs6KjawNi73n/YOfxQebfKZdXtQHNMcTPtM1sdaiqegzyp7a
	 SvLI2Jwsyz5k0qMbl/Z9UllaD9Thg1XTlmwH9I8tel2SwsHLBbeFiUJQ5qUYVQNLJz
	 qOBnI3FzXmdRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C5006080C;
	Fri, 14 Aug 2026 18:39:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FAC2194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9FCB6080C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QBHHeGLAX-ks for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D2FFE605F4
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2FFE605F4
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dehygOnE
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2FFE605F4
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:02 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-51c928bf172so9245011cf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732741; x=1787337541;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBky9y6kgDi8Uo9d21MfUAypMnE2okqYNCVlrWyYba8=;
 b=dehygOnEMrh48C2V0pLoF0bbzliBS8pdPWKxyjTN1wg/fb+d2cyKaI17NXE5VWyCA7
 9MhRW3KlN9CkT+SCrtBVU3MKiJ5Ok1BIm13jksCvKpbrH7CqMRX1sZaR3OwAsVBm85gq
 bDA/WcxUwllCWyAkz0MOuvffhgDneQrgIW8WAadCnptlDDH9f77j6INyWkGQjZFB10+S
 Fte6nybqLdskelWtyWVFqkk72iaNH8tyqvFAjy3SwwXxjRTZJNuDItd0H9ZFrgImuAwo
 V1KVf0duzd0LwKvKtnfLCqTTMT/QOVU83vyo7rYPVeO575s61gaaNTCGU1MSKmjc0tJU
 YZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732741; x=1787337541;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pBky9y6kgDi8Uo9d21MfUAypMnE2okqYNCVlrWyYba8=;
 b=Kxe/AsFInL0MU8k0VDaixLTBkHArj3K5VOmB5XsT7DKvdxWkO5828fn6EsldxzdVfv
 v1Y2KVEjbMzsi5hhSHk40UpERgtRNTsfIsMg37ury5ommWrVlfFjvn3RhQyiGPGCnywD
 nVJsUkpceIg85Ww3P7TpXfdcC24F712m6NXE2llGajSA4QZ6xPG+ggRqdD+b8x7N5XsY
 LoWtMDWfmnRU5Y47Tjmve5FFE3CCBH0ibg3MNFhAV5l/RqUIXFryK/jpRVhSOlYOFpxp
 vQ2RhJXYViNR3ddhnL8+hUCtPN9rmWpgfB3eYgDhVcWT2D87HpJ3/P9QfwpBPPB8Xdtx
 Ph1A==
X-Gm-Message-State: AOJu0Yy8xs27fWzgEiozoh9E8V7eKP22BBZvWOrMyotIxoxUdf9TOjJD
 TK4ScJshcKvg1TtlNmHNQJzTcT2QAK3UdKmZBQc6qH/0ExtFZMgPRXsqwJWBOLMJwCoWWvYGa5v
 EH04e/Yo=
X-Gm-Gg: AR+sD101OUO7jmeVBIhpbYDUfl3Dwr/cKqqWKSVzSS5NKHYBiUxHlwMBHn4CUipyrnV
 fQGDDdAOun+b7pLYZoH5W7mz4MzaGDadcJuY0NfpxtBv/ZKDlMST2FtOm7/3y5l5XqJZJeQrBZ9
 KlbFSFfIMOlQnNZFfOnlA8AMMLm/WVQr03OZN5CgxKeHltDiAZoJV4Fu98ymDBrjyprIQeJX9EM
 q1OMa0mtWKe4csSqKg1TEUuzW/Z39GkEhHMcfUF24CruM/00PWLInnmHMsBHPYujRJHWut/2US2
 7Dt3qGHkqVJ4KySL2nKXqS7+l3ShfKL/v7gftifufats/puCnNdAxQR3VaTZF6v3bxzgEEv8Nli
 ReBC5MFUn71w8BT3OMapDlv/s7S9TekEjP732F5gEEfHFO4SR2yUPaXZYDfnRq1ZIC7fUJaE+4M
 VKNnwXLehLiTVYjnHBjjzusQKSTQRfufvOZBQv0ESYOdLqXwn1SHga4s8oAcuLnXIYcrJKL0/CT
 Ac4KIgYBgcIyzho9hqZeOrjg9N7QbmzDdyxK7YiXz66xRFXgIWc7NPY
X-Received: by 2002:ac8:5cd1:0:b0:517:87bc:9b47 with SMTP id
 d75a77b69052e-52d854d682fmr92592271cf.39.1786732741369; 
 Fri, 14 Aug 2026 11:39:01 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:00 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:38:53 -0400
Subject: [PATCH v2 1/8] board: schneider: rzn1-snarc: set serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-v2-1-56b6acef0439@linaro.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=2104;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=fz58ptxIlUkdQ2f1BBRqrmL+AEYSD6tWE6Ik9W6Pbew=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGJlvpe1Fsq0btHozHGO5YXjD2ABmRYMC3yP6qETOQXDIc6LJz2aPVEvNIXBcMF8Ok353zwaqFN
 nxhJkx3urbw0=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Obtain the board serial number from OTP. Make it visible in the
'serial#' environment variable, and also in DFU/fastboot/UMS mode.

This helps to distinguish multiple boards connected to the same LAVA
controller.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 board/schneider/rzn1-snarc/rzn1.c | 25 +++++++++++++++++++++++++
 include/configs/rzn1-snarc.h      |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/board/schneider/rzn1-snarc/rzn1.c b/board/schneider/rzn1-snarc/rzn1.c
index e1d5b5b0497..38aa2ed9d4e 100644
--- a/board/schneider/rzn1-snarc/rzn1.c
+++ b/board/schneider/rzn1-snarc/rzn1.c
@@ -1,11 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <asm/io.h>
+#include <configs/rzn1-snarc.h>
 #include <dm.h>
+#include <env.h>
+#include <g_dnl.h>
 #include <ram.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static inline uint32_t hosted_readl(uint32_t addr)
+{
+	/* No hypervisor yet, just do a direct read */
+	return readl(addr);
+}
+
 int board_init(void)
 {
 	gd->bd->bi_boot_params = gd->ram_base + 0x100;
@@ -13,6 +23,21 @@ int board_init(void)
 	return 0;
 }
 
+int board_late_init(void)
+{
+	char serial_string[32];
+
+	/* Obtain serial number from OTP */
+	snprintf(serial_string, sizeof(serial_string),
+		 "LCES2-0x%08x%08x",
+		 hosted_readl(RZN1_SERIAL_LOW),
+		 hosted_readl(RZN1_SERIAL_HIGH));
+	env_set("serial#", serial_string);
+	g_dnl_set_serialnumber((char *)serial_string);
+
+	return 0;
+}
+
 int dram_init(void)
 {
 	struct udevice *dev;
diff --git a/include/configs/rzn1-snarc.h b/include/configs/rzn1-snarc.h
index 9fee2ece54a..75fada671af 100644
--- a/include/configs/rzn1-snarc.h
+++ b/include/configs/rzn1-snarc.h
@@ -10,4 +10,9 @@
 #define CFG_SYS_INIT_RAM_ADDR	0x20000000
 #define CFG_SYS_INIT_RAM_SIZE	(1 * 1024 * 1024)
 
+/* One-time programmable OTP */
+#define RZN1_OTP_BASE		0x40007000
+#define   RZN1_SERIAL_LOW	(RZN1_OTP_BASE + 0x08)
+#define   RZN1_SERIAL_HIGH	(RZN1_OTP_BASE + 0x0c)
+
 #endif	/* __RZN1_SNARC_H */

-- 
2.55.0

