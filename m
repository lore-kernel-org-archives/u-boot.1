Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92368C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D79C82AAF;
	Fri, 16 May 2025 01:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iosVfKue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C607982998; Fri, 16 May 2025 01:42:07 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01A480107
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c1425fbfcso1506009a34.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352524; x=1747957324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYn+Remp+yVLnFOfNRnG4VIIEUQ6SIaGgWllb6m9YK0=;
 b=iosVfKueHPemsM5+Bm0IlWLKXAQxmOlqy4LWX3507k2AprysKoefyPu96qKU5iN4It
 PbXEngEPbAK+3B/i5bkmAmFs7kFzxRJUuEt6Sr6WhG9mQiaLaTkzaRwaaKxYI9ovO2ph
 Mh4HnOeV6z5I0PoumirLigfBrc9EYYRH/83RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352524; x=1747957324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYn+Remp+yVLnFOfNRnG4VIIEUQ6SIaGgWllb6m9YK0=;
 b=mIH6s0eOtZMzgdjnbUqq/PH8tof4RADGkm9R7MJnQuH232h4MlTTAfYtX0Gv7oH9pt
 SayQ1RsHB7O8Wkxllf1C0KarNANEDuBxLR04u0cG+a+5eIkyqnOge9oRU51W5nhvyw2d
 +3zhmsfXqF9uF1xVV5XYXfncI4BwWmFR4tCXmAzLNBNTJRb2danIdkenYuZek+gK6ZwF
 3Fe+KvG3dTXOaB/Q2DDPXkgaF3fjRG0tVF6QYnXzqMPLFaltx6JfAHCKnrhjE3/sErkP
 OQAJwJIgRhEj1SOEbpm31S2b4DxO709cnJUeLqUj2IWYEbBmkPbOC74Kqura2ly3QcoB
 qomw==
X-Gm-Message-State: AOJu0YwKACPvN3vXQYCB+GS34LREO+1kPNh91pu/eGtP7ra592iRQ6tx
 1M/qTa5PW6R7cD9DnwqSA/5oVbNdISRShCo9m/BVX5hD8jKhGoJFev3SHX/eyvU3Zga/WCgGzpj
 vlAjwzYQ=
X-Gm-Gg: ASbGncsuiVq2kzv3YYQzwCIhn/LGjcmoMZ7FMStFmajcHvGkH1eR2r5IHhantlrL/z7
 Oln+VltfDmIpPKcPpUaZvDle/eMOxzfJBy0JB5VHhKwqK4jfzsPuvPCZ1sdC0ulWDmjp3GEEcoM
 rgaWPKSP9vJ3UNNO4cTF0w/Djicwk1Jk7FThrDIlsf9WLO1BakXV7dNMDpATS29F1fyxY5Zo6EB
 60C0WKuLODkhLeSAFYdi2ivzJhGLwcZgwPv8rRvxmYGqwF2iJiUF30qjn9/61GrSAqBQU8jIRO0
 oGK7D6vE/aSwrTRkgmN2sraH4leI84io7TmfoIhrXuxDkh/ymMkm33Fv39W0wMdM9mwUau+C5Iy
 J8A/k8v5uDgTbQHQ=
X-Google-Smtp-Source: AGHT+IGyTVP1wuIO32mMgrFDXlP6ZIibLH7je4VefO0aWPE8xn/FXDsuAJxyNVFEOnuxfW1IACa9jw==
X-Received: by 2002:a05:6830:3145:b0:72b:cdcd:628b with SMTP id
 46e09a7af769-734f6b68b7emr1077660a34.20.1747352524570; 
 Thu, 15 May 2025 16:42:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v3 05/22] net: Include string.h in net-legacy.h
Date: Thu, 15 May 2025 17:31:34 -0600
Message-ID: <20250515234154.1859366-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file uses memcpy() but does not include the header file. Update it.

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 include/net-legacy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net-legacy.h b/include/net-legacy.h
index 51780999a883..a7dbcec1506b 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -17,6 +17,7 @@
 #include <log.h>
 #include <time.h>
 #include <linux/if_ether.h>
+#include <linux/string.h>
 
 struct bd_info;
 struct cmd_tbl;
-- 
2.43.0

