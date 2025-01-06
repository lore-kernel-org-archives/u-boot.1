Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE605E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F85805F7;
	Mon,  6 Jan 2025 15:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KG90DKKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F957801E8; Mon,  6 Jan 2025 15:32:48 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9278058A
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so451821039f.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173964; x=1736778764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXA0GDusC3w4WNhhcWizp+PIXaTq12ZMMU5iFmbKlU0=;
 b=KG90DKKvGkPBd3nDnu+3wbuV4A9fUg6EwvcOGblbxRbncmdncZxaaJvll3zKyhjgko
 ZNtQE9PA9dSb0N7m9nf0i7k2jLFgohkDMdHaHyRdzYD6MG2xmjPsDkf5sWKwtHiYAut0
 xvp1ZZJcl1gb1+tuD5FxfJT2UzvIya8CRBsiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173964; x=1736778764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXA0GDusC3w4WNhhcWizp+PIXaTq12ZMMU5iFmbKlU0=;
 b=Rye/CsMHckgb5KjUF+7uS8qaIqByM+i7/azvCjZIRCf2UcvqhYqlIXrQWzXX3Q9C7I
 x6qIrJnJMFAZ+LeNML0H9J/b4pVeLou3Y8XjC9EVPWpJbYqkY0VWR5w1x+ItMs6EYsQr
 mO2mlTF2Wb5LJJrGgPRKVVVHLQxrvxICffoAV3q69uVrpepUm5bHYCXIgGOp3rC+i/aT
 mE1f0uqhSpkIiAw2ASwhliYRDO1FDr3IDdZlG5CEDH/Aq8tx2I0m2yGehFm9M2AxgnMA
 MmPwktXtbS5KBzANXjGI9vsd0EfFt3BCyxW/M9an2cGY180byJ5nUkALgBcXkiWOL0eh
 QDqA==
X-Gm-Message-State: AOJu0YyI2ThtdkU87Ibj7tyV/jA//RhDhNw/X6R8yDUAUwmcEog/HAiM
 Dl/aH7J7r5rSq/abRzj/GORPsA5U0lCeQaQu8nJ5NEpagnwjOwLaPCI1sokhQiwWT5F7oCKYeXo
 =
X-Gm-Gg: ASbGnct7r3TsjqbSoaBiI6HMm8feZkXlkMkdXYqGymOXMWUhFICNwkQOHD3rowQZQEV
 BxgI/Ywi7cm92YB4WiCBub6MTGnYsWeZ0rZPvL+u9msK9pPfOteKgfffROSgn/YvS3Uu27fzRii
 1T9fVHGG1hPLHYUVgy+MnETnPQ9CT1abhU3XRi+sSeTL82xbmbLlYC7cZeUdgP+N3wSKXUeOR0F
 WR8e2varpDGM1poIIS8f6i4JW9f6tDmH5Dq0raphkZ2vRAFdNQzTsm7voEORtXtLBdFjbrEM4Tg
 8fUVzs1AwbqWABz0MA==
X-Google-Smtp-Source: AGHT+IHHSjIQYLeixJdlbPW9/O8EC9By9XgwJ4ZBvSlPwddrxpDRz0Nn9l0a7KkcQMkNz/NlcLS8+g==
X-Received: by 2002:a05:6e02:219c:b0:3a7:98c4:86a9 with SMTP id
 e9e14a558f8ab-3c2d5915ea4mr507019565ab.20.1736173964094; 
 Mon, 06 Jan 2025 06:32:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/33] bloblist: Drop BSD license
Date: Mon,  6 Jan 2025 07:31:58 -0700
Message-Id: <20250106143229.3023771-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Linaro has decided to write their own version of bloblist from scratch,
so there is no point in having a non-GPL license on this file. Change
it, to better fit with the U-Boot project.

Signed-off-by: Simon Glass <sjg@chromium.org>
Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215

---

(no changes since v1)

 common/bloblist.c  | 2 +-
 include/bloblist.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index ecce3da9331..c441498ec56 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2018 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
diff --git a/include/bloblist.h b/include/bloblist.h
index 7d462e71914..be7303e1504 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * This provides a standard way of passing information between boot phases
  * (TPL -> SPL -> U-Boot proper.)
-- 
2.34.1

