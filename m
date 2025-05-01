Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F027C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAEB82836;
	Thu,  1 May 2025 03:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nCabx6UZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F32C82893; Thu,  1 May 2025 03:06:12 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32728807B1
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85ea482e3adso57452539f.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061568; x=1746666368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfiksg1l5Vqrzd4chy5Y1g+kdA41z2/b7/JQGQluGkQ=;
 b=nCabx6UZpmbFvAQaT8WpD8oot81i2wmshnw2pwRdGDQlWcPt+6ww5zlY73DXoyDF6Q
 mRAK9ZC2rX8rDzt1UTFKNqwUkpE8tYDtxj1cBTAJkDM8NVr5WNUmFlBOtQf0XHID3mag
 knScWK0XQLcHCLNSPODJP4nW9jbQsu7seq5Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061568; x=1746666368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfiksg1l5Vqrzd4chy5Y1g+kdA41z2/b7/JQGQluGkQ=;
 b=KHT19TaAESqiyU+0H1P/+9zoU9vX/1B8eCsmpAoLwwkoZZvZ+M/FGIO6N+PKmW26b6
 /Vfc/uFbHIcY+yg9vUWndrKjxtpoCCkot46wZlih/O5jaPhCn84yAfJc8MU3j78mdlZq
 0Yrr1q/E0NPRWBQtzR76lTkbQv9eX5UHxZ8sLhyo1UncDBcB+qHbgHe7MPB/3vyjUPBV
 EoG0XxmAxxr52L8AgYCmdQSG3qpT/9fYfVvzFBvF+xOKphJ1iDZ6Cia3BWSN9g1m9isY
 hHTly7o5l2Mtw6InUhOgncioTj2q4S5wRN/TAuIa2TBQh4GJcDsojed43Jxfvc5GphIm
 FTRA==
X-Gm-Message-State: AOJu0Ywfq7T9Mt9UqUXysNDFJFnKCO0oYLtuFJshPRpVw59LufS6Im3c
 ksp9ftiaeM0L+sdRx+DFyQ7I78VLvWweQ6uUMeAFOAD91W4+HldCuh8NAYCmBHkHr/XMGffRNCI
 =
X-Gm-Gg: ASbGncuboxfHhP4mvrN+v6Aw58KVL24/qgpxbrREI+H/GTQu68INxNigButqL7uKXdW
 VZ1ANaCToZ2WXwXjexcVx/3pjK5Rr2eGBG/qoJHsHGNqjheL/8pl1pKmpm0c9DDImzNAsw1cPFW
 ZXZwhwmHpQa31eJAzRaqiMO6dAk1Rr+UufrWDtl81fKAXvbsMb95O1jm087tM23IJSqqwOsSyBj
 daqhAPNASVwKOuOQL9Q6vyT5FS+PW7+Tm6+mG80pQZE2x2IrjXhOt+RIbnjNwEGNoO48xjJRhNO
 CC5XgfO3ovPCTYtZxF3UeF+u6q/ZBjut7oBltDjPPvQYi607NfvR9L9c0xvTZrVq5ryGq1zvQs0
 fLQ==
X-Google-Smtp-Source: AGHT+IEbI2/0MQTaYA70Ndg99W+feRnWlUPUlFZ595AumQmPY69CI+hP/bQQG2qSrWXeWNO1kQMbMg==
X-Received: by 2002:a05:6e02:1f82:b0:3d6:d838:8b93 with SMTP id
 e9e14a558f8ab-3d970dec1dfmr5473615ab.7.1746061568426; 
 Wed, 30 Apr 2025 18:06:08 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:06:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 19/22] net: Include string.h in net-legacy.h
Date: Wed, 30 Apr 2025 19:04:44 -0600
Message-ID: <20250501010456.3930701-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file uses memcpy() but does not include the header file. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/net-legacy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net-legacy.h b/include/net-legacy.h
index 1f62ebff51d..a43ab9db589 100644
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

