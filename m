Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351B9CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 10:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9B383F69;
	Fri, 10 Oct 2025 12:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HBdBSbAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D0783F6A; Fri, 10 Oct 2025 12:59:54 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 434B283F59
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so18287085e9.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760093992; x=1760698792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SJg5d2gXAWMCE3jzrT/fEVfy4yFR4IjB/qFKV2UOVj0=;
 b=HBdBSbAPxTDEnNXYKmlwglTvkS6wTUFfl0tBAI03z5FQGrdGDV/knHII48l9fkI2s8
 e7VgJ0jXudZyBnbMU82pWMYmtB3ZlQl5b03vRKzA83RW04lgbCw2XdMdSuRPXdARvd9E
 8AhdP/mr5hMQwmrvqJsZHWKRERQOh81/hHWvAR5Cd5MhodiF8BrrAeo0KYrPcQY0xS7d
 SYDNc50Sic4fVtskEb4dSlPKCI96vXqBpcKgDoH7gcrEQ9RWizIZ4uHpgjWhtsRoRxba
 dUJqROucJdO4O+DWZNmXhAjLyG38RwS+syNyfBLquLvHMq9lqqba8rp00tJ0kbRd6len
 +Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760093992; x=1760698792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJg5d2gXAWMCE3jzrT/fEVfy4yFR4IjB/qFKV2UOVj0=;
 b=WWRt2zxGjOhMsQ5ijzFwhb4qj+gzvn1794oVj4ZR3fT5gdtgcQfp364PJGHt0mlIYF
 L15NYuNmexPRxwDB1CSkZqbNTwbsGFayzQCizYJnzTrx8QbFwTyC/qe46+m/uTQJ728E
 58Rn1rDU3McVt6sCvpbVhJXTx7CHtOe6a2z9VXZ4k/IKu2nnf1YsN4fuBqlZ+f/gwYiW
 +MAi7d2egC5rPb77Mvz6qjFMnoTf3Om2/uFvnU0sC5J4pwFvJAgDr3mliOYi7yDVQewG
 09Gcz22WTb2lKlXe51COCoTzAV9cxRb6hHhN0qW7PoZlGnqe/xbOCruvIgSaacbzHIGj
 al4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk3QPEgEEXmrXOaW7rQCUzlaAx6r5OG1ccbRavIdux5boKF8uoqU4K7sqvf0vjvLvbQ04YDIg=@lists.denx.de
X-Gm-Message-State: AOJu0YyAeLQRIK4HRQRWm/XqtlCE+de/dZJbAqX6DsSb9Fw530ZWyb2j
 oIBRnM3qPDqWt3rXvI9HK5DbGOzzP4oxxsBAAxcGx7424NdO0NHbMN/xWoTeOlxseDI=
X-Gm-Gg: ASbGncuBRyFRoJqaOaf+82CZ3E0X/FZOHLGeOIBdeM2Nl1vFMed2MNHCjvfGgOS30wm
 NuYVP+CI6ZHGCull4EQe6vdxiekmqUN25qsaQIkrx6hQXgKXnvYPdUMOCtiakubRjgnw72PcFqZ
 sY1FDt6mjKCEuikhjVJdkhD8aqM+KL9oKQmIxS0rQ5dItscCKhFNpGgZOwWHZ4tVi9Qx1RjS9y5
 av+P5HeE1PqtwOSW8D4F6ovS8387snCheVxCtS2LmTOxXG9kKtUQteJQAhqSPVeUI64sQoSK0p0
 FRVrXJaUxNKY8IzeM1sAq9BpYS+EUgIxCu+22eIuVl0HPGJd+r4QaWkKo44IQZ7/Ut9AVkRxJIN
 liV0nMWDknOGmBpnDOjUkMz2OcZfkpRIwOL3xtwt43V1lmBiQIrLuLEzP
X-Google-Smtp-Source: AGHT+IHp/1vSqtWeLvOwmIOECgk+MuNFeduBFvDB+iSdcARGVnoBFsl01SMixouwklR8+bo3LVMq+w==
X-Received: by 2002:a05:600d:42c2:b0:46f:aaa3:a6cb with SMTP id
 5b1f17b1804b1-46faaa3a789mr50813375e9.14.1760093991696; 
 Fri, 10 Oct 2025 03:59:51 -0700 (PDT)
Received: from hera ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489197dsm44222375e9.10.2025.10.10.03.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 03:59:51 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Use ESRT_FW_TYPE_SYSTEMFIRMWARE instead of
 ESRT_FW_TYPE_UNKNOWN
Date: Fri, 10 Oct 2025 13:59:31 +0300
Message-ID: <20251010105933.25581-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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

We currently set the firmware image type to ESRT_FW_TYPE_UNKNOWN.

The spec defines the following:
ESRT_FW_TYPE_UNKNOWN 0x00000000
ESRT_FW_TYPE_SYSTEMFIRMWARE 0x00000001
ESRT_FW_TYPE_DEVICEFIRMWARE 0x00000002
ESRT_FW_TYPE_UEFIDRIVER 0x00000003

Since we don't support updating DEVICEFIRMWARE or UEFIDRIVER types,
let's switch over to SYSTEMFIRMWARE which seems more appropriate.

Suggested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_esrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
index e235c8fe91c6..3cc389eb11cd 100644
--- a/lib/efi_loader/efi_esrt.c
+++ b/lib/efi_loader/efi_esrt.c
@@ -236,7 +236,7 @@ efi_status_t efi_esrt_add_from_fmp(struct efi_firmware_management_protocol *fmp)
 	 * TODO: set the field image_type depending on the FW image type
 	 * defined in a platform basis.
 	 */
-	u32 image_type = ESRT_FW_TYPE_UNKNOWN;
+	u32 image_type = ESRT_FW_TYPE_SYSTEMFIRMWARE;
 
 	/* TODO: set the capsule flags as a function of the FW image type. */
 	u32 flags = 0;
-- 
2.51.0

