Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8BFD185F9
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C728416C;
	Thu,  8 Jan 2026 14:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ojYSXxSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800C28412A; Thu,  8 Jan 2026 12:17:28 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EFF584113
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so4576109a12.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767871046; x=1768475846;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3hjcuUE2eY964b/JbkwPq2RBzV4/MB1STxFKRJNv5gE=;
 b=ojYSXxSDUkrZhGdLyj/yG7K9l77o5T1vCQqje4N3fzQcndR6NOLyqWa7dr5FZWJ317
 +k40qQE9yZn4utynxyzCKJ1UsVEo4Q2AwN8x/k7Iw/LVDr7Iwk/5cNAa/oICtwoMYyFi
 zzFDFuij1SU0AOq057K/5YOGcOBVFGwt57n/El9+AR0qxG1F9gvE168DDi2VCuyf7FTb
 +CPCvUj2nG57vEjs//PxeiwQ4QBwh10RStAM2vxgOA6WKmMICYmP9IFJ4cikEDXHuePD
 YjoJN7fLpLTAjrKwOP5+V+cMw655lyGTnxZnWkXhjM6Hej6F5N+Dh23K+o0txL53wBwz
 PG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871046; x=1768475846;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3hjcuUE2eY964b/JbkwPq2RBzV4/MB1STxFKRJNv5gE=;
 b=Gs1IxYlbzCgn44cXKv7obzBr/SpHBvukq7FxGr1yJjLfs/+1j8MLdVdYzgiby9w7bO
 vORtR6dCwXtAJhPE27dEMzKtiQvOqKDmyVahHIO+60ADS7L8/Uz2iLlK2SUoa0B383vn
 Pd8tm+hDFXd2aEaoIs+6j+VRyGYuBt8khd1Jrm3jdX6CyHReQ2sBoLcC1VH0fHVgE6/r
 YnGATHeQvBLgPxMq51rO6r/yht9Bme3OMiaxZ4qXJPc//wYr6KUoT72IHD1wkoO8Gvxv
 cEEFdSHANRcwvLMpz5nNNWz892sd1mUb0gTmkxEJHvHyJzAh23UyfNcs98ZbfAwbgB1W
 UzbA==
X-Gm-Message-State: AOJu0YwYtDOiPmIRGbftYM/j/9R0OMUiPGW/jMCUe8WD5adHAfymo4b+
 fLaZLlsy+fVF/gEmM8poI90XE9o1Z+XoMl6AnALv4jh+zEw1BosS/t455BLw+UI1fZE=
X-Gm-Gg: AY/fxX6YwUV1cZBXI3gojv0cxeNDIYbuvE9+RN/4bw3RcvCaWkDRsVlUAn+EKO5E0G7
 l5GDQTBiYUtCO4s3fc/7cd3s/Th0e2ODJU707f0zTX2rm88JTV/zpWLCTCj86uY8I3KpnNL2A/x
 lEK8A21A8KZ8GfozFxPwVy7pjNkEf99Tu80iERnGYgPPscsw99YMJR3laAbSMGVPfqQKMJFaYC5
 Kd+FJOxNTplEtazhKc0ZaNV3syFb4KVEeWISxqkvMTCsw5HwNaqPcjLUmH7JG/NzAlslh2f+LL9
 0MkLl7I6OtmeBDUFWdfPQ9GZQC7lM40d7zIvU/hT6/4fbaEX5ltITbpVVF/+9gDaWH7Ni2Ejfwo
 Txqjc+DzyZw1VyajeO6JFIQQxUBRJrJVUE0DmvO1McygwhdCsRfOT3p+WzJ9QTuZuDbBqLYdTYf
 qK1IarOdag
X-Google-Smtp-Source: AGHT+IE/8bQq9HMPTIQUWEe/zRxhsCfJ1T7xy6Grr8DkmEnEKfOcq4GecqhDwx6f7nDnqVvYxF9ZbA==
X-Received: by 2002:a17:907:97d3:b0:b76:4c16:6afa with SMTP id
 a640c23a62f3a-b844520d854mr590228866b.28.1767871045981; 
 Thu, 08 Jan 2026 03:17:25 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a51543fsm762275166b.55.2026.01.08.03.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 03:17:25 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 08 Jan 2026 12:16:27 +0100
Subject: [PATCH v2 1/6] dm: core: lists_bind_fdt: Remove unused variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-topic-musb-probing-v2026-01-v2-1-2a47c6e0e73a@baylibre.com>
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=msp@baylibre.com;
 h=from:subject:message-id; bh=m5L271K+rG5NtvPkKXyPBHbcYnHxy8trJ+jVdgCU1sI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz4SRKujklv/S9r3uzTXzrJcvLeLdGTczjO2wVJf1/g7
 /3OUndrRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEYAvDb1a1s59t1v36uzex
 U6xHq+kJH29mo8G5LZsLWRUUDnvMnsbI8O7yqlSbg7vWfbw1I0nrx65r0/TEdcy3sql0fdWS54/
 K5AEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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

'result' is unused in this function, remove it.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index c7be504b6fc69ec2870a6766eed35cb9eba46a97..52ba6c7bfa007b660b854de62c97ad3c1761f1a5 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -207,7 +207,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 	bool found = false;
 	const char *name, *compat_list, *compat;
 	int compat_length, i;
-	int result = 0;
 	int ret = 0;
 
 	if (devp)
@@ -283,9 +282,9 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 		break;
 	}
 
-	if (!found && !result && ret != -ENODEV)
+	if (!found && ret != -ENODEV)
 		log_debug("No match for node '%s'\n", name);
 
-	return result;
+	return 0;
 }
 #endif

-- 
2.51.0

