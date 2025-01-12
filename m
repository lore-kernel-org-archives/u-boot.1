Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37D9E7719C
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 03:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C66805E9;
	Sun, 12 Jan 2025 04:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nfEoPwoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22210801F5; Sun, 12 Jan 2025 04:42:19 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6658801F5
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 04:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71e2bb84fe3so1768596a34.1
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 19:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736653335; x=1737258135; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GqWMM7WOX8rE18EQNu5ubLw9ojN7anB4FsnTFrS9L8=;
 b=nfEoPwoqSVeIKRnL+Vlg2jb3cSreZPFQG5OSlMMyBUnJfjpuM3YXgoqf0DSsp7gNMZ
 0p8ulNqXhnPeXGx7vG5uHLzt3+NuExAHaLgGC9jsHbGVTPPu5IuU/GVeWSS2MaQLXwMN
 iQldvREHix5mSGYsK1xTWBRct3geIyHWboqyVXO9jTQqgAWZM4Psc6r9lBaDeWwhHGqN
 B77ge0Qfts35a4oEMVcXI49vnoSFxeBfNbBASfv7VlLj5bXQX6nOiarZHhjFwt3BXOP1
 CGKNEIszykJPbBOxuRej3mkMTURf4SAE//DaWkzgGMjpOhysCMdrAxK8A1HeEuZY/2/Q
 25xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736653335; x=1737258135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GqWMM7WOX8rE18EQNu5ubLw9ojN7anB4FsnTFrS9L8=;
 b=hmw6EJticyardGeIxChE+FNXj9ni7I+AXxezA/iq+VdALLzkSOVmEAjswM7SV0U+gv
 47oxx8esCMkehRMcyDLWet8gMKGvFoUzkbgdEW0lLXTrXbm8ZbEam5ceFcq0cReWthHK
 hQQrDbJ9juGq20ZdKeDoMs4iYJaIaCwGUNoNDyWdrX4wTYHI/qahgmFbz+O8/7thNIKz
 vSAaA2lc3/ILctzNbXRLkus+3XiWhkoC1e4QTGjTpveWJUx2/YZlvnRR235GBqv/FRyq
 oARmcxc3S/QxuWerhx3p92gj1mihy6TNN8G4CPZ/WEurlMBehjOxTTxYOWHNbW9TPHYp
 BQJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfrzdM9VXd3Kb7jXTbwKjyjYGnS0bc7NjxzyCbhcX0yKMrnWvm8dt2I/h2EzfkkDdQ4L91DME=@lists.denx.de
X-Gm-Message-State: AOJu0YwpQjyOwiMT8HCnmK/tKBkMMCqsGcQeA4nh4IH9N8xQK0vCrJ7a
 +aJPGHPeznvWvbXsVceZM1TvK44x/uj4r+KIFKgk8655ZNjSAIKe3DTEayZKUPc=
X-Gm-Gg: ASbGnct6eMkh6SUxR8SWMONeHUv9pgeFYCRoIGnA6js/WcZd90JZZ9ls0W22mSIUyjg
 /sa4MxCpd7LXnRsQF8b861H4GbGi52ABbgV2VWhOUOz0yDQZBX1eoH3oyUutUMMo5Cdu2l6AyBG
 CrB0bzLzKij0Au/kWXR+P57baQtppRxRI+vCq2IvzG3t/jI4UkslbcDKDgjh88C+oRfBwxGGw92
 fn6gSoQGZO3fRwPM/KfwoFUs4TfBTbIKlaCP4P12yTXOIPgb14uKNBtHn/ZoC4tzmE=
X-Google-Smtp-Source: AGHT+IEaJ3pxnzi5CVzt4AWZ8AI0lZew3CKmCUp7x2VpAJVCKypP2SgU9z3OPP/bibwHah7CSnf5yw==
X-Received: by 2002:a05:6830:90b:b0:71d:ffa1:6b0a with SMTP id
 46e09a7af769-721e2f00d87mr8782251a34.23.1736653335643; 
 Sat, 11 Jan 2025 19:42:15 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231861c020sm2313928a34.49.2025.01.11.19.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 19:42:15 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
Date: Sat, 11 Jan 2025 21:42:11 -0600
Message-Id: <20250112034213.13153-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250112034213.13153-1-semen.protsenko@linaro.org>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
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

Free memory allocated for 'order' (array of bootmeths) on error paths in
bootmeth_setup_iter_order() function.

Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths separately")
Fixes: 10d16faa436c ("bootstd: Detect empty bootmeth")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 boot/bootmeth-uclass.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 5b5fea39b3b3..ff36da78d5a1 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -133,8 +133,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 		 * We don't support skipping global bootmeths. Instead, the user
 		 * should omit them from the ordering
 		 */
-		if (!include_global)
-			return log_msg_ret("glob", -EPERM);
+		if (!include_global) {
+			ret = log_msg_ret("glob", -EPERM);
+			goto err_order;
+		}
 		memcpy(order, std->bootmeth_order,
 		       count * sizeof(struct bootmeth *));
 
@@ -188,8 +190,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 		}
 		count = upto;
 	}
-	if (!count)
-		return log_msg_ret("count2", -ENOENT);
+	if (!count) {
+		ret = log_msg_ret("count2", -ENOENT);
+		goto err_order;
+	}
 
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && include_global &&
 	    iter->first_glob_method != -1 && iter->first_glob_method != count) {
@@ -200,6 +204,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 	iter->num_methods = count;
 
 	return 0;
+
+err_order:
+	free(order);
+	return ret;
 }
 
 int bootmeth_set_order(const char *order_str)
-- 
2.39.5

