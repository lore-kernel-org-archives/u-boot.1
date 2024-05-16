Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A885C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B660488479;
	Thu, 16 May 2024 23:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GX+VEroP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50FC18841A; Thu, 16 May 2024 23:12:14 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5746488485
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 23:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34db9a38755so8142998f8f.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715893931; x=1716498731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fH6wOjlXus9XRxcoUmvggSCArd/WRtoojfpukFv8ieo=;
 b=GX+VEroPcJhPbA1DIxhnOZ4eSPvtbVV+ZZvyi0VoOSVdhhL2/TgSwtJm5Yi7mm9RE/
 bwZi2lqL+9DBQm3WNONWiVVrnqj22RqesHG8KDZHD8amnS/MoB+mBy9uRWmDEqL78k5y
 XQtNSMhJKLkvzy1Nx3CA9GVwOkSyQoJb57um9GbShBCfm0AnsxbQLOxSNelpaEB3RVXq
 MY2PFdBMR89eTBW/0m3kTQS0rKvd64vaxvuQoUZTJmAe6EsbW5uSg6L7Vx0ImJ03BxhD
 siFiGAsJneRoXr3GAaCOw35CbWjaX8ufrJipbbccFmd6SA34Lf8g/TszQBy4+qVFEyyy
 qJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715893931; x=1716498731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fH6wOjlXus9XRxcoUmvggSCArd/WRtoojfpukFv8ieo=;
 b=ZMMkZ68fXto5baK3tAuBCZaBfWmNlmwSP0ZgX2x62sOKYtSc9xBiQoDgAoQamiB2Wl
 CA3j8NOJvoed6v3fGw2gNr1VpzXnXDMlmYJ+DTTFr5gTdo714pUpRSwyqND1veSKA5V8
 mA1ZpM6KBBmtWbK5Hj+djBHzZ9X2MN6m+b3beTiASEjjORm2k8j9f07akq8g6DtOAlho
 hBu2dkq25cTgBk6OF2w4lDmJfOaUFCFwDwk3UWRNA7zrM+sQv4iwGYLGI74/02uY0bxv
 fzasFFt5TLnbb3VdEC1oaCsk2xhNSAW8cgcAMba6SzSChbLlC0O7DtWRw0gDg6H4F3jT
 9PXw==
X-Gm-Message-State: AOJu0Ywxs1nBUlgkiizJyuajEVITarWLTkQih4dnzzYP+lTMo4swds0p
 4muCk9i926QYS+KlddsCJ/RcI3YE7y5dXdJ6kA+PWkUJc65Izj0yONUYLCb3utQ9XE3u55Q69fj
 l
X-Google-Smtp-Source: AGHT+IFJpoCldjyavUpBGvFjzx1EAXYga69vDk6QR4WHMTpYQ21ZTIzWYghEdrXkzgeJVNsMYbUdIg==
X-Received: by 2002:a05:6000:1042:b0:34c:54c8:3f2d with SMTP id
 ffacd0b85a97d-3504aa63858mr15432492f8f.69.1715893931094; 
 Thu, 16 May 2024 14:12:11 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d09sm1021582266b.107.2024.05.16.14.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 14:12:10 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Phil Sutter <phil@nwl.cc>,
 Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 1/4] image: remove redundant hash includes
Date: Thu, 16 May 2024 14:11:49 -0700
Message-Id: <20240516211156.1819939-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516211156.1819939-1-raymond.mao@linaro.org>
References: <20240516211156.1819939-1-raymond.mao@linaro.org>
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

Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
u-boot/sha256.h and u-boot/sha512.h

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- None.
Changes in v3
- None.

 boot/image-fit.c | 4 ----
 boot/image.c     | 2 --
 2 files changed, 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index fb03cab831b..f6464bcf620 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -37,10 +37,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
 #include <bootstage.h>
 #include <u-boot/crc.h>
-#include <u-boot/md5.h>
-#include <u-boot/sha1.h>
-#include <u-boot/sha256.h>
-#include <u-boot/sha512.h>
 
 /*****************************************************************************/
 /* New uImage format routines */
diff --git a/boot/image.c b/boot/image.c
index eb12e4be04a..bacf5146e13 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -25,8 +25,6 @@
 #endif
 
 #include <asm/global_data.h>
-#include <u-boot/md5.h>
-#include <u-boot/sha1.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 
-- 
2.25.1

