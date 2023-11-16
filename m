Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155E0C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D1F87438;
	Thu, 16 Nov 2023 05:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DTwhlz2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 746278744C; Thu, 16 Nov 2023 05:11:24 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B82C87438
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7a683bd610dso11927739f.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107881; x=1700712681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAKkDdEIGZKSWN0fyBB36EH8jyiYZcXdlgvJSlH6X3Q=;
 b=DTwhlz2+M312JrJaN4aH5GIkmfdir+3bopvs2CQjiqYlZzHDVV2M6zou6uG3w+8MDw
 OxMgzCO+8RLS5O93oR+qxl9jT2qziOr4Et/1+UR/SnZSxxzxLtv96IJpcW/OtmNnG5Hq
 gpx/8q231QMjr6GEnAzeJsj9Fb2toBhZ5WTRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107881; x=1700712681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAKkDdEIGZKSWN0fyBB36EH8jyiYZcXdlgvJSlH6X3Q=;
 b=cChM/uLxyXPEbGOeGxkpeg9WFKrkK+uRQh/IsQB7jehWqgqEJm7lc4LrboFKtHFKvS
 nkZFU840VNRx1NWSbjrOhSK0ISCYGvQI/Yj9Io42auWhpp/wDQk5ccFJT4FQ2xQfemF1
 2NdzVRPShnqwUw6dvVYNnfWVz/0rApP1moB42vbbEHphe1ZDRHDK04TXAcly3F+JCA3x
 nWUS2ZF6MaFrL2yI4Xup8ejglJ417oO4BQYdPQsNX0IRUkdwPz9QURXELDsxNeonKyrf
 g7qa9UIZ/1E6wbX/wczJHwm54Xt2TJO3LEd4eIfpfx40uzNTHR5BBN81n37C5guIvayj
 3yTA==
X-Gm-Message-State: AOJu0YzpVVFtndcWWG1E3P81bEeCHmpJtnJ1LMsmXdYSqhm7D+SWqSNc
 YpQMaWWbzjyOCvzRnRnSR69yqBS4kAZua0pZu4xK4Q==
X-Google-Smtp-Source: AGHT+IGHwcllWGP0mQu6VRJh2MzA0tY7n/NlrMsn/2r/T27qjCQPLZg2lAbWfOiN0fSDclZnEuQWUA==
X-Received: by 2002:a6b:5c04:0:b0:786:ef34:1a6 with SMTP id
 z4-20020a6b5c04000000b00786ef3401a6mr15995380ioh.7.1700107880932; 
 Wed, 15 Nov 2023 20:11:20 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 03/32] mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
Date: Wed, 15 Nov 2023 21:10:03 -0700
Message-ID: <20231116041043.362055-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

The declaration of U_BOOT_ENV_LOCATION() uses a different #ifdef
condition from the code it calls. Use the same condition to avoid a
build warning if CONFIG_CMD_SAVEENV is disabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 env/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/mmc.c b/env/mmc.c
index cb14bbb58f13..da84cddd74f0 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -495,7 +495,7 @@ U_BOOT_ENV_LOCATION(mmc) = {
 	.location	= ENVL_MMC,
 	ENV_NAME("MMC")
 	.load		= env_mmc_load,
-#ifndef CONFIG_SPL_BUILD
+#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
 	.save		= env_save_ptr(env_mmc_save),
 	.erase		= ENV_ERASE_PTR(env_mmc_erase)
 #endif
-- 
2.43.0.rc0.421.g78406f8d94-goog

