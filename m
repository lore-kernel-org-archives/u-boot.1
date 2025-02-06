Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B36C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 08:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9344807B3;
	Thu,  6 Feb 2025 09:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LChkFx5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4245807D9; Thu,  6 Feb 2025 09:49:16 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85169801BE
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 09:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436249df846so3673875e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738831754; x=1739436554; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bHPLXvZy6q4oh1CNJHkVs17mGnTKlWI3HTinOcbySRA=;
 b=LChkFx5X4XHUk37huQ49UwwfRRCJupgm2OPNGFAGVf6v40D08jxwvEJXGOQlS2K8vo
 TEzEvMnulXly5X8EKMC55NzQLs3p8oeXPJw5FRjctVJjwNBzuswq4eQvsX87ztceQqpZ
 KJ1QkZfRPewarggvzIYhzTrfs518OPZcFFM4zYLkNtz+Ya/bd3hQPsuH2asDElIxbJgf
 b2c+Lu6dkJWQkiNgbHU/ZEDjS+qNdAlv/q3X7dwLDkBVR3aHYev/L2f+ZTDQi/qV8Vs7
 H7SbFG1JGbnsE4grdJF3vVdFQX9wAsbTKfbzcUoBWS2k0fwbhhhdtGQTpXbUuaqaEyYH
 QfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738831754; x=1739436554;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bHPLXvZy6q4oh1CNJHkVs17mGnTKlWI3HTinOcbySRA=;
 b=OZbgEtOY9K3rPL0QSy2wvJIU1U8B5d87Edhbcv9+pNks0rOP6+rZ5MK80JuHbuGBfx
 AfWISuHAGUAa6UEcMs+AAfy2mTLpCs+UYyt8YdhcPD1BERn6bpll2jrAis4Asst4+IOG
 uG0D8c495/sOST7DPkH2L7wcRMMsNX36ff3lm5tBN1vaWyAQ+g/VK3MfrFcKx1RhDgHc
 WXDXvZx9/SfAIYpmEamNMS0yl0vuEG3QHzmV3lZgS4g7EAsa4ovP7yN7VVcMRKeCGwLY
 avUtEQOuB6p+j3fabGZNE2Y6Rb7Vkmug3MtPwmJjSpxNnqpy8VV+Xs9C8YKRn+ElaZcU
 kDEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTmOfqQZLjICzgH6e7Q/Sp/O44AsMn4i9+S3nnNGdLBXlsLIx038MoVxUfJJtJuYftwuLbruc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7e1LGSlNT+wgs6MgJFSQRzQKF5iQ+qv5nT91/UX6pjiZpjCum
 LRZP7z6xaWCZd3TcJrQpCIiUDwnHvjvhvuVkxUgd2vT0SCaXp1e7BrG/03XUOko=
X-Gm-Gg: ASbGncuxCznslGHGS3IN9aSIZr7W9UU4byEbClv8fL5Lymh0GW72IqPoJ7tQDn3ICq4
 KBeALeY3I0GOfpLMN7E+lhQHNWXg9aWjCVO27Jsr6cbnFXY31BJhOl2ONSnVnCYMviKN9qhJLTt
 zmaz1mbm9SuWbgFgfpI0+5lKU0NPTxKrEYQrPiEYSiVREcABj9lG5OB9z0Cg4MskkpfsGhTQq6N
 8evmoZwyCZWlYet3nKEwQ2ksVUYbh/eoJOCo4HGCxLCneZPFoH+G7MoCq7m2MpWfM0no2QkYqKD
 /JL4SbJfjO0k6RzHPIIpzG+yFr9bFBZnUq6i
X-Google-Smtp-Source: AGHT+IFf7HbLpw5HUYWAnGo+C8M//NcwtFXtu0ikZ5kyGAKKh1PcTE8DCOVhZ7Lp7arQfpa99KwQqQ==
X-Received: by 2002:a5d:64a3:0:b0:38c:5c1d:2875 with SMTP id
 ffacd0b85a97d-38db48a44dcmr3871552f8f.9.1738831753896; 
 Thu, 06 Feb 2025 00:49:13 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf451fsm49264815e9.28.2025.02.06.00.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 00:49:13 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Feb 2025 09:49:12 +0100
Subject: [PATCH] pci: dw_common: Set INCREASE_REGION_SIZE flag based on
 limit address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-v1-1-33088c62600c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAId3pGcC/x3NMQ7CMAxA0atUnrEU0jpEXAUxRK4pHkijuEDVq
 ncnYvzL+zuYVBWDa7dDlY+azrnF+dQBP1OeBHVsDd55ct4FXOaijPaKKzksrILjF9PyRs1cJZl
 glakhaLoJxkscAvUUmAZoZqny0PX/u92P4weELL9ufwAAAA==
X-Change-ID: 20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-878465356c54
To: Tom Rini <trini@konsulko.com>
Cc: caleb.connolly@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9Cggg490/0KfF6Lc5aYaz2DP5PFsXcKpbSHNs9wtWrE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnpHeIoMtCN7HSR9zgBG21JmAhvePtxxGSy/iCxR96
 5FrWuSuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ6R3iAAKCRB33NvayMhJ0U9+D/
 9nQHbIS+Cwh2OEookez0aOgtqpAIIg+j5M7K8nm6ymw+HOlQk4f32KiThjlWDZaAVDUsPX+e91GgFO
 iSmwzJL5o8CKnHWUM14Q8v5s3fJoPEImzOf2pnlevtlwkDYXmPKxtzOAyhlxZiBeKF2N7J6tmi8KgX
 ggOUQQAspNsYaZuTj9Z0ooB/tkYMDZVQQeKKdW72VGQH8VqIEHWvOworxs8Hvb8e3R55FU69YfjZAT
 hyubkBVSJCAGOGESgrO0XGW3CxpXUIfdHPLHsWrKh0eI3nQjtGqbLRHqU5t16PN6tKY73BEfDtoSQR
 4WvHozV7vY44TEV0mholm10LPrp8VyQJ2HD2Lepk4ThCkv+KNkrDuTI0KpFleY2r6B5PsG7PuqAcqu
 MMJHDlXaEDYTDDQzo5aGKS6Mg3ZmWniWZ0jWrN9QXlm9e1HmCPKtpTLqR1NaamtjtY6HJnddwa33yI
 b9cEIuH0+xS8PldfoOmkB/rXhzxfiG2de5KnHOVW69eDhNzjWUq1UexNKdPkPmqqdvQRywui6WqRNO
 ZVyuQQCrvI/hwYidkbDyB/zH8SUDwklXakvBwVxxfQezOes+H+RJ8/t/nkhmdRViUN3DFnljhGfbPv
 yA2AcQSPHbzObwAcjdsBXYgRretr2w1kuo3ZvXTF1whuu0UKPrruh/v7tLpA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Set the INCREASE_REGION_SIZE for the outbound iATU entry if it
causes the 4GB range overflow in order to activate the extended
limit address by means of an additional iATU CSR (upper limit
address register).

This is required to make PCIe host controller work on Qualcomm SoCs,
namely the SM8550 and SM8650.

Based on the Linux commit 777e7c3ab7303 that can be found at [1].

[1] https://lore.kernel.org/all/20220624143428.8334-5-Sergey.Semin@baikalelectronics.ru/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pcie_dw_common.c | 8 ++++++--
 drivers/pci/pcie_dw_common.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
index 78961271a8eef8e4b6991675ee9de2bb1968b8da..5322f6bdaee450470d7f706bb4b4097a368ec455 100644
--- a/drivers/pci/pcie_dw_common.c
+++ b/drivers/pci/pcie_dw_common.c
@@ -78,8 +78,12 @@ int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index,
 				 lower_32_bits(pci_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
-				 type);
+	if (upper_32_bits(cpu_addr + size - 1) > upper_32_bits(cpu_addr))
+		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
+					 type | PCIE_ATU_INCREASE_REGION_SIZE);
+	else
+		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
+					 type);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
 				 PCIE_ATU_ENABLE);
 
diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
index 8cb99a12ea1a5fd3687f980cc1ff99839d06dbc2..748945f95975e8251cdb92a670e8d5bc575d2847 100644
--- a/drivers/pci/pcie_dw_common.h
+++ b/drivers/pci/pcie_dw_common.h
@@ -46,6 +46,8 @@
 #define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 
+#define PCIE_ATU_INCREASE_REGION_SIZE    BIT(13)
+
 /* Register address builder */
 #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	((region) << 9)
 

---
base-commit: b3c09eb36529fbb277bec17b35e638f42cb33683
change-id: 20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-878465356c54

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

