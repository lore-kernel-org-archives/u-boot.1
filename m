Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1D5C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4340A876C9;
	Mon, 27 Nov 2023 14:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iXVAjwOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE5C876C5; Mon, 27 Nov 2023 14:00:56 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8208887634
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5094cb3a036so5639393e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090053; x=1701694853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFl5q83Dz7tD9zISSdke30i9kRO2ANQbPUYPT5Iezkk=;
 b=iXVAjwOjVcECfGkD47OMTwK+ywbfyioKS7QEgBxoOfGmzXGWl0l4u06iCmsGvSqNxk
 NkBoMaDJGQNk2fzT6PE36c0+Xpe/hMmQWsty8kFeS2ErEJG72uyW9fsRNYrSo9eH4wXp
 TFYOnZ6SPQ5nv9OhFO0YQT7/lFzbekHF34KaOsquJseb9DPwgNnql4L39IVa11csmIBz
 oQvP/G/ep9Y+A1EgXzpJl2pf/oAtlMIjJGNKpwqOnynbPJ/bAyXSFphlbZy3Sa+e+CLj
 vl6KseqqrFVff9COa0V4y8laTaugD/sMdx29u0GRAMlutxBYpKFyoy1gOBb5xCheZy/j
 R/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090053; x=1701694853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFl5q83Dz7tD9zISSdke30i9kRO2ANQbPUYPT5Iezkk=;
 b=P+SytdAwl9trw9kH8TTLZAHFe+9iEOpD/J6GDWk2QH0ZGdkfkMwjjAeAFN3Hrtzgpm
 NdjAdX541ZunD2wunBuHZJ2YJmp56VPKOr2UI4E0sxMcI8NNrJwzfHrXNuSPN0E2uahD
 nkSEBq4ordKcraiKaLCBVEogBeqSOq395Yl/CmI2oYrykOndlquGgK455K1pq/elVk7R
 ASIPXIr1pbLFDgt7dZGr94gYGMNBuXNR1UMXqpvUAlzdK7id2OqBL85yQ1hp1kkNiUWN
 ShkD8QLnM2NnnLH9HCl70mVKmagsYdHge8xhNE6M7r0R2PGZx12+q90TpE7qI6IDJ+vq
 61ug==
X-Gm-Message-State: AOJu0YwCnJq3E/EWENSFQWwoB8WPyg+WoZmcGct+RJ0UoKtkuSnHlYfm
 V48eBilw0KWm+STuWoM3kwlpE1rBrc3X8LVIDKNmAg==
X-Google-Smtp-Source: AGHT+IEZVdvY7D2kFhl9jr29TbLnCoxnas4SP6wA/gyOrpBo9daCCLpjxNa+vOJlDyiNyz3oDzbGSQ==
X-Received: by 2002:a19:f505:0:b0:507:9a49:3f23 with SMTP id
 j5-20020a19f505000000b005079a493f23mr7289889lfb.18.1701090053330; 
 Mon, 27 Nov 2023 05:00:53 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:52 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 19/43] sandbox: eth-raw-os: successful return code is 0
Date: Mon, 27 Nov 2023 18:57:02 +0600
Message-Id: <20231127125726.3735-20-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

all network drivers return 0 on the successful
transmission.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 arch/sandbox/cpu/eth-raw-os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
index e59b96be5f..92c35aed95 100644
--- a/arch/sandbox/cpu/eth-raw-os.c
+++ b/arch/sandbox/cpu/eth-raw-os.c
@@ -256,7 +256,7 @@ int sandbox_eth_raw_os_send(void *packet, int length,
 		       strerror(errno));
 		return -errno;
 	}
-	return retval;
+	return 0;
 }
 
 int sandbox_eth_raw_os_recv(void *packet, int *length,
-- 
2.30.2

