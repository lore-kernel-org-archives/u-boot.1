Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEE3C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1B387141;
	Tue, 24 Oct 2023 09:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="egh/4HUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF5087136; Tue, 24 Oct 2023 09:41:39 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502C9870F1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5079f9675c6so6547778e87.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133296; x=1698738096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3wAw5LDOglxf9VQBepswseXzI3AUpshqMI4S0gYa5Y=;
 b=egh/4HUKXxdc9aR1wIBKrWUhRZI4Md3FYc67O0rWuay5DBePzhbA/pfgdSsHE6FJ1X
 PZK5iqCEgTaxg1G7coNGGRiqgS8HLfGUieO/8AoxiLTHuFtW8JU4bLoMt+rKeiOfdt1k
 QWs+yTCfImf0UX1Cwslyjw+BbS4crvEfpVczWJQobhzcQBxGvRALP/JgxDfbvJ2weIqx
 BhgIZu7BmZjUEOKBzBlAHRwEhc6UXrkJ364vhoulZyRjcfrrWgPxD0DCaCKk39XCVbwL
 d9Mo0HTPmid5do/8L3ZvdLkADVAXOVYc60llKdtTmxhp6VpCAHcg0YS2TEJydq6x81vv
 7cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133296; x=1698738096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3wAw5LDOglxf9VQBepswseXzI3AUpshqMI4S0gYa5Y=;
 b=lLg+JdfFNnNyNXEeTMJYmbbBE6OWRayj04pAwZ0NyeTrVHqwJnAFfKDG9B3EKGAbLy
 9AX3TVTSrb+1eu1QKVTpwk+tIA74yHqszTU2vV6cOCgpsWOpglHjBENuB4oiE0M5SROm
 UeCN9IJyalq+axglI8tpBDyi+s+GLa6Lib4hmgp7Z4OZaq1T03BtWvaSRFGPWacckFZq
 cVCDsiFsauO458R4yPxym6gmDnSdVXwlVwDmEQABxYc6shWBpjzJb1SDsPK2MFf3f5lX
 EBGhgKO2Fy84wIHVA7+0vrQE6218LJPyfnyPQcHyMApUK/R86vyHDi0tn4I+itbUNAZD
 p7Gw==
X-Gm-Message-State: AOJu0Yx29qWmMxaT8fVonPC4Jll/L9jV2mgJWRrCSzsioZlxkEjD5Ath
 RYEOj5KbHuI/5VgOM0wW6KM=
X-Google-Smtp-Source: AGHT+IF/C5+YgvuHfePzNPRReLReD1SHMVvOXUfjgD2I/FiJ94tuouN7Yylho91KbeZpU2hzD8iUmg==
X-Received: by 2002:ac2:593b:0:b0:4fe:7e7f:1328 with SMTP id
 v27-20020ac2593b000000b004fe7e7f1328mr7848683lfi.16.1698133296282; 
 Tue, 24 Oct 2023 00:41:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac25e6a000000b00507a089caf6sm2017580lfr.219.2023.10.24.00.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:41:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v8 1/8] power: pmic: palmas: support TI TPS65913 PMIC
Date: Tue, 24 Oct 2023 10:41:03 +0300
Message-Id: <20231024074110.199623-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024074110.199623-1-clamor95@gmail.com>
References: <20231024074110.199623-1-clamor95@gmail.com>
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

Existing PALMAS PMIC driver is fully compatible with TI TPS65913
PMIC found in many Tegra 4 devices, like Tegra Note 7 and ASUS
TF701T. TPS65913 shares same structure of regulators like TPS659038
so data can be reused.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # NVIDIA Tegratab
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/power/pmic/palmas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index eb83c88d56..b2e8a2930c 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -88,6 +88,7 @@ static struct dm_pmic_ops palmas_ops = {
 
 static const struct udevice_id palmas_ids[] = {
 	{ .compatible = "ti,tps659038", .data = TPS659038 },
+	{ .compatible = "ti,tps65913" , .data = TPS659038 },
 	{ .compatible = "ti,tps65917" , .data = TPS65917 },
 	{ }
 };
-- 
2.39.2

