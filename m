Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4405E77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555A0801DA;
	Thu, 12 Dec 2024 16:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OKNT7Usv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E139801BE; Thu, 12 Dec 2024 16:11:49 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A46B801BE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4679ea3b13bso3056291cf.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734016306; x=1734621106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nt9+ytn5tSIDST7NxaNAj+cJUIVi9HCTGSynlwc4JQ=;
 b=OKNT7UsvWjdxPxqqL/hxPqWD16LDMuSZ21rJyQ0dOYY3FePhYPNk/2sxnR5c1dvgTX
 X7OCB4gXMXrcUNAqU2IQgvPt2nf6PtX/wakqiwtky+9yifmNcfshbaqKB21r15uFgYGA
 cCt925huz9wBlj3PiSr5M+hVngsvhOQ/GHVno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734016306; x=1734621106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nt9+ytn5tSIDST7NxaNAj+cJUIVi9HCTGSynlwc4JQ=;
 b=n4oBAA/fMdeONap00N2k6yUwH0Zqa0DVOPbIa7KBNbehPE03tgg53bR2sbMZ68x4yY
 CmMIT8B0YXNIX7uQ05V1qYq4S9jMU+a0KZGJXl51EqdWqVE7H9HJoIW3+VQF2ylYjdrp
 S6BHFnfI5wd7hewl1NLu+4b63fvIM6GFRgY4FKP7fxIULesLM2B8FM0Mes26V5YAePsh
 Q1/6szKwm612Wby8vZSspglEq8moWC169hObq/UvixRMNRZD3eCPbQyAWfKEiNIodM7n
 6sYeRg8OUImTX3V1z2rpslcK3bWFGWn5oH9jN45IQKZsEveoKbL+/OzBKQIgFjzqUpAg
 k0nA==
X-Gm-Message-State: AOJu0YxqecjpxhyzKfFnQh/Piw6jSA8a+gC2FOxQpDtJKt8SCvk0EBJO
 MQ2KWcl84jM/4Gh3+jVHyQgQew+T1Drp0R5p1HK2PYzYZBmhvY4vGriO5N9eRROhemZMFlxtnHU
 CUik=
X-Gm-Gg: ASbGncunbOpTj38lqTNhF6zvJhF8LTObphb13SxifZx960kbg3Oe9FMObLOsSacy6P9
 ffRE7+eoWufAnrUP9DuYoBa3uQ5iiFYiO07iz/RgO/2wp5D2q71CmyArudon7TD37WMIabxJf3Q
 VArxkclqMZKc4vv1+FfU9moguPuhz6e7rwMU5rl292us9hsKQBcWj6NeLEvACv/fKcHDphJzXKn
 3pMsz8afbI1xbbDUfq5Pt7nTuRgrsrcxLzCI0LECw7DxVtLgCj97vY1yHxMZZlMD0lpjtAbfc0k
 QX0=
X-Google-Smtp-Source: AGHT+IHGYlTbyX1KE4tkNwh2rp7Mn1X21eBW5jZI5Glq59p6m59Pl6AoLEBFbZ5eUQ12Q11h2+1VPg==
X-Received: by 2002:a05:622a:13:b0:466:9763:9de5 with SMTP id
 d75a77b69052e-467a14d7c18mr12537861cf.2.1734016305890; 
 Thu, 12 Dec 2024 07:11:45 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467a22008c4sm543461cf.5.2024.12.12.07.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 07:11:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] bloblist: Disable CONFIG_SPL_BLOBLIST_PRIOR_STAGE on some
 platforms
Date: Thu, 12 Dec 2024 09:11:42 -0600
Message-ID: <20241212151142.1562825-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212151142.1562825-1-trini@konsulko.com>
References: <20241212151142.1562825-1-trini@konsulko.com>
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

A few platforms, notably chromebooks bob, coral and kevin, create the
bloblist that will be used in SPL and are not provided one by a prior
stage. They also define CONFIG_BLOBLIST_ADDR to be in DRAM and so we
cannot scan the area until after DRAM init happens in SPL.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 configs/chromebook_bob_defconfig   | 1 +
 configs/chromebook_coral_defconfig | 1 +
 configs/chromebook_kevin_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index decac2e19352..e44775506682 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -38,6 +38,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
+# CONFIG_SPL_BLOBLIST_PRIOR_STAGE is not set
 CONFIG_SPL_MAX_SIZE=0x1e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 0fb730497386..a5ef4fd2675e 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -46,6 +46,7 @@ CONFIG_BLOBLIST=y
 # CONFIG_TPL_BLOBLIST is not set
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x30000
+# CONFIG_SPL_BLOBLIST_PRIOR_STAGE is not set
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_HANDOFF=y
 CONFIG_SPL_SEPARATE_BSS=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 5bbea6c42a8b..27fcfe866ee1 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -39,6 +39,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
+# CONFIG_SPL_BLOBLIST_PRIOR_STAGE is not set
 CONFIG_SPL_MAX_SIZE=0x1e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
-- 
2.43.0

