Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC641C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 445D64059A;
	Fri, 31 Jul 2026 16:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLwQV1xDw-im; Fri, 31 Jul 2026 16:36:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E688410AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515762;
	bh=pBky9y6kgDi8Uo9d21MfUAypMnE2okqYNCVlrWyYba8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Os1anh8+u+/xBRKBlqCyhxAJIHCfP3a0zC/vPb0F6WvENAKVMJ0NOoTJxDIhq2Cjd
	 zOCAWVL6eXSnZky6/sA1bPHeivs2gqZyZx8nZOI8hru+ch6YsrIYj3JZRCDOOlIamf
	 pP+XgbvuLg+hVMJHjXttKBYOlbIBH8M/mh+UlADf7gt1fbKkXGT2qbxqVFqqID5u8Z
	 LJwrmKocpquNwFxPCn2WGd3SDWZAhbu336fm7cz4LfYourldHvIpfBdUtRxYYdhAIp
	 oMrbYANHUudmXYK0sKSMW8/hCSW+sGpEKjoK+P+KpjSYyY2vOdbMtu8mVl6o8dCu3o
	 64rBM+WCbRXnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E688410AE;
	Fri, 31 Jul 2026 16:36:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 83A0336E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 760BC60658
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5S7QqGBM_Ra for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7512860657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7512860657
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7512860657
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:15 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-74ace427b29so336256137.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515654; x=1786120454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pBky9y6kgDi8Uo9d21MfUAypMnE2okqYNCVlrWyYba8=;
 b=BVapsglD3sh0Uje2QSffUDzVQEW3v+LUyFknEPkJJuAVoWiIvwrI2AzgabWbLgYHhP
 H1f7eDb9ZPvyUnP1Ymn4xHzgbnoQ/0bA10/NBHfjiHwq6ZgYJWNEHXMCQu6CbTU0Nwh2
 PZxQ0hle/iJIopwHI3jrdzcF7gdcHgLBykFFtrSPnNE20UWmCa3efGb3mFqmr0n+hJVQ
 F9AbTMl64bHC6PLrm7LVa7rKs2NMHAt8y73MnRdUVNFTkW+/vtRqYTBOUOyQYkgtbTTJ
 YsjbckXXMBu3W0jf9foomM8AWM6lXXzKPAKcVTXkVjNFN/qa48Ruayjw0choc3YT1lRi
 Ru0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKcV0/R562qpqjAD4LMrLXcUN3B4vJ8kamsvf7Tl7zJlCgfIc/93bM5ozakukfHfwJtRCPzAA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz3zfFJux8zrb5ZC7wKi4/CvUYHOgXwttUPuL7Z3Xzig91nVVAH
 GXXMz0e9Z4aHdNynmfpFqDhNxX8Ii/RkMZSb0fex96dSeTFIpKanITIMDQj/umYgGtg=
X-Gm-Gg: AR+sD12vOVtJEXEXIsG6PUiRPeIjKK6DwkmRpEUFNhSK8tUHFM+i2qE9dfRtQSjXv+9
 gXqKbHaanB/CLQiGR994oeyQcttRv8DKTZncYlp9A1azAaGdbA/z2SmK75DK2296WxpdXZieqOx
 NRzvGzj8LpFzf9UCyjdLSNvLDdkmnc5uvCTae4OOv3l9VL+Cl0Quo19yap29/qzyC6NSC6BnY/M
 Wln22Tfnk/CD9IxWJHGUfRHTr1oHSQmojZMuCiuXHOWh7SWQ3Xx0TwBIVO+8xG9Me8oFW8tzXC0
 07HHiHLBy3fAJw7/jXJZ6y/8WflA9v74xskFWbgLI7GOFoPlSuT0SgId5HDzqY9Nl6/ddM7An2A
 hXs+pa62lckMXmOGydK8KPFVoBj/wkETYk8C8S93m1USkPRqV4feAWms4T3kF5DQGvK9MfIZQs7
 qo3JRzukQkQn9pmKT1fUUnMBE/rHnZBU+3ZlS+5VLbKzQIXall+arsYu55390R1DfHM2KSKM4y7
 5S0TxoHuwEL/eKrS3rPu33S+MsJR76d12o72RMNMrg+PRb9VWVJTfMBnj/S
X-Received: by 2002:a05:6102:4b19:b0:739:626d:4473 with SMTP id
 ada2fe7eead31-75b1e83aae8mr897675137.0.1785515653901; 
 Fri, 31 Jul 2026 09:34:13 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:13 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:39 -0400
Subject: [PATCH 10/17] board: schneider: rzn1-snarc: set serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-10-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515626; l=2104;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=fz58ptxIlUkdQ2f1BBRqrmL+AEYSD6tWE6Ik9W6Pbew=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDlhpIHNIwMlmo+jsbl7j2bUYe5WILFhcpc+Jjs/mnKG7tGPqM7vvfT7XmHwPIUlCv0KB+h3dGU
 2F9AnUr0Vvgc=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515654; x=1786120454;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBky9y6kgDi8Uo9d21MfUAypMnE2okqYNCVlrWyYba8=;
 b=v87pHbJ1/H4e8wydr8helF+4+WUwTcD4GyIjSvbYGhOkDekBSoRFdj9DOmmOvjnlCL
 lh/gtsUP0FZiu1dbF93ID7LgyGeeD4As+hkkckS8MQfCbbLARP+7rDTwVwiZuotbOD0T
 HK+hGq1fEvu6WdaehGNxVZWwmMyvxEpldKaJEsptqGFuzXsaHgBF3euufQLxMnv0XXlI
 pdyEg4PdxbP20rKIspj2hUol22T2du26AktpgzUgqYlwZdl3cKK60xuRLhatChWnF58I
 1whpWMpFh2g+aVONmKkZDJVS9W8GT/4O17KRgWxHodrMSh1/CUm+qJZBH6xFzwg6d6yP
 2qJg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=v87pHbJ1
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

