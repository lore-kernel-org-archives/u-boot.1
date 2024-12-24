Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4134E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 058F2807EC;
	Tue, 24 Dec 2024 17:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vY1lDOcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B014280817; Tue, 24 Dec 2024 17:01:59 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7123B801F5
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d91653e9d7so44487926d6.1
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056116; x=1735660916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGCrW8KsqNSI3V29FLkfK+GAwFgxRUzaq9SzhUyY8EI=;
 b=vY1lDOcqgLDrRIWDsvrgqRKSboBbbaEFtsyZ/do3lHyR8lOkIjT6XbOUtBc0hwKhCw
 gJxeZASqX9fmdpVLqk+GJWzM0r+6jDSU2ZO7APuNx0MDUy2HzAwc5ELBHyVWQl9hyIPR
 bWIhZvEn5jUSg55TCURDoP2lbT/L+GRyYISOinmZs3zoTYr4AXPtxUg8/yq4yvDutLih
 JnN4MCzMmiJzF+tN4THW/QVrio2zC2NsFpI9S8KHXrKCl47+WTseTcvjn4Tb0M5q+x1N
 lDMyrxsZ0OlPQRR4uhZLuQRrsmzozHCdRoWiP9af/Y57KAkcM1FpPvc+tHdlWkb3wnNs
 mqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056116; x=1735660916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGCrW8KsqNSI3V29FLkfK+GAwFgxRUzaq9SzhUyY8EI=;
 b=N80a04i7emp0k4YaHJmRAI3VnVeJdHFd+DcJMc+ViQbugqL9m+Q4lo0kQsSzma971i
 hixN4n5Lvj69K53pZr91ZLEGiP/N6UyNI0Y/nZB7X71ln6DuXAFfvegt4TR5Kf7DF8zl
 XLcK9i4WDmAECNrt6fDvURE/hJIjh/gFWxuWMnzsaFkzBToBuelaJqlg0kg8lMi2mDyw
 G+k4fwJ7YBQrSK4uDsiPDYqYujDG2WXjQ/vKbGXt+vKaV44Fd82l1Sd0xnlyy8F55QWH
 YWI0x8p7v0WVVH23omsIHs01+v8h/bgICCWytyspbgE1C/9/Z+CHc6OL98hLKmVNkUPg
 LQoA==
X-Gm-Message-State: AOJu0YzB+KhbwpDOwfqTTQaLUXBLVhCr2+MG/dcQoxcOH/Z5sBfG6g3/
 I/7850v0Se/RzeH6kEw6ydKmUdrls+y6IxnD3/2SwhDmJniCEQF1p1oOrElE2/IWLt3vxXDie17
 u
X-Gm-Gg: ASbGncs+oRtN75XFlx4WNXG3uEC0H0Y26ypRBGgmSKQJGAWYuAp8oru7P6WlRHJtOgU
 DtJI/ir/ZItLduPpOFhe4NsCAZgZ/QdPDZckAuO7HOvfT7BsFuIGygPR0qA6uZpSyA3cL+NgPOi
 UGUl0C5vEO1oEjJq9JAaSIIVxtQxLx0STplkP/tNMtrZ5RE+ADrQvW1kEqAei/TVwMa9vm7h6VH
 FzypYp/hfTXc9U/Jotyr6tvpAF1OVjckzFt8as3jhtHWro5cLIe/XCpOAH8jbZmDO4PaEJOFGa1
 Mq9rY1PV6D0T5xFLSWO1H8EIRTNTF1wmROch+J9RnfAEecPtq+oOBW8=
X-Google-Smtp-Source: AGHT+IFuBuzxW6vsKu6TSPgdPi3HBFotXyWyLIebPFzoh0Q8Zu33/z/4t2OisTQXT9X0+1GpSRI4fg==
X-Received: by 2002:a05:6214:2b82:b0:6d8:9002:bde2 with SMTP id
 6a1803df08f44-6dd2334dad5mr304948236d6.28.1735056115827; 
 Tue, 24 Dec 2024 08:01:55 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:01:55 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 04/11] tpm: refactor tcg2_get_pcr_info()
Date: Tue, 24 Dec 2024 08:01:06 -0800
Message-Id: <20241224160118.675977-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224160118.675977-1-raymond.mao@linaro.org>
References: <20241224160118.675977-1-raymond.mao@linaro.org>
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

Rename the arguments of tcg2_get_pcr_info() to clarify
they are bank masks, not PCR mask.
Remove the unused local variable.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Rebased to 'next'.

 include/tpm_tcg2.h | 12 ++++++------
 lib/tpm_tcg2.c     | 19 ++++++++-----------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index 6519004cc4..eb6afe49e7 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -94,17 +94,17 @@ struct tcg_pcr_event {
 } __packed;
 
 /**
- * tcg2_get_pcr_info() - get the supported, active PCRs and number of banks
+ * tcg2_get_pcr_info() - get the supported, active banks and number of banks
  *
  * @dev:		TPM device
- * @supported_pcr:	bitmask with the algorithms supported
- * @active_pcr:		bitmask with the active algorithms
- * @pcr_banks:		number of PCR banks
+ * @supported_bank:	bitmask with the algorithms supported
+ * @active_bank:	bitmask with the active algorithms
+ * @bank_num:		number of PCR banks
  *
  * @return 0 on success, code of operation or negative errno on failure
  */
-int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
-		      u32 *pcr_banks);
+int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
+		      u32 *bank_num);
 
 /**
  * Crypto Agile Log Entry Format
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index edbe5f3aaf..0e267ff0a7 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -20,19 +20,16 @@
 #include <linux/unaligned/le_byteshift.h>
 #include "tpm-utils.h"
 
-int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
-		      u32 *pcr_banks)
+int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
+		      u32 *bank_num)
 {
-	u8 response[(sizeof(struct tpms_capability_data) -
-		offsetof(struct tpms_capability_data, data))];
 	struct tpml_pcr_selection pcrs;
 	size_t i;
 	u32 ret;
 
-	*supported_pcr = 0;
-	*active_pcr = 0;
-	*pcr_banks = 0;
-	memset(response, 0, sizeof(response));
+	*supported_bank = 0;
+	*active_bank = 0;
+	*bank_num = 0;
 
 	ret = tpm2_get_pcr_info(dev, &pcrs);
 	if (ret)
@@ -42,16 +39,16 @@ int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 		u32 hash_mask = tcg2_algorithm_to_mask(pcrs.selection[i].hash);
 
 		if (hash_mask) {
-			*supported_pcr |= hash_mask;
+			*supported_bank |= hash_mask;
 			if (tpm2_is_active_bank(&pcrs.selection[i]))
-				*active_pcr |= hash_mask;
+				*active_bank |= hash_mask;
 		} else {
 			printf("%s: unknown algorithm %x\n", __func__,
 			       pcrs.selection[i].hash);
 		}
 	}
 
-	*pcr_banks = pcrs.count;
+	*bank_num = pcrs.count;
 
 	return 0;
 }
-- 
2.25.1

