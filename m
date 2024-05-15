Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD72C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625EA88253;
	Wed, 15 May 2024 14:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M1De29GL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F21E988261; Wed, 15 May 2024 14:32:53 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0559588250
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34d7b0dac54so3923511f8f.0
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715776371; x=1716381171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tYY9vXgd/6FndAyjqhdV08iRoiUAwStXpih6zevSzo=;
 b=M1De29GLHlZUxBtpcHNIG1IIkpD1YJIxVb4chii4jVhFEWRnODFYNXdUaZuV1N11yI
 a64/zlzqIavnr4eVlaE7I/i06Up9wYxCBR/ixFDRiM15Wlfup6YUsPI+dAw3qzHsTu/W
 k6rAkL12HDuaNYdSA3jGH7sHQrM3gNzihw1/n0oevuxSYFA9ZwkfBDY0cfepA511ALY5
 FOxMndqVtxKw5S55BC99cpd/1vn32py/8e5/l7VeLLcTtntHUGRteAsFnONOfRoyTYBi
 TUezLrKBB1IAmemCP1NH6Q+xfch29xcoEatNrWEpy0LwYSvpLspKA+8KoglobxkiREgL
 HhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776371; x=1716381171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tYY9vXgd/6FndAyjqhdV08iRoiUAwStXpih6zevSzo=;
 b=AmOncpnK156YBqzkxuuAPTkvjOzvn/BUuzjWBwIrscLhdIMbtAKsDLAz89zfnxdcrB
 mujpwEKlhawOVuZE9gPekEIRUNvRCHMWNa3MZFaJ7gLaKEtqa5AP+DWEJrnSBIcBTU+H
 QaWqLQ6+BeXPhCmXPXnUMHF+DR0ugc9Xe68DTi93vfndZhU6cQG8lroTEbM/E/cGuBme
 hFQsuTk+co7a/XPkf5MC6qyWPMMLxgk0ZZtbbd1jFCZ7Rt5Z+8Nf0b/VjaDBDQpPm6wj
 sHMP9UlsnPN0TAtYuP+XDNnJccPI1RWy8lBKSsgS24M1oQbML4o+p5tAagtGus4p5dCP
 vBSQ==
X-Gm-Message-State: AOJu0YzDJPALas+GEg+iOlvKU9RVMUG5GqywLMlyBT3RHt9OcvWVVC67
 bfhxb75O7n8jrMw5UkNaduM9BwTB7Qqf+i0F9LwdWukkhIcFb0IqUGYw5P4lQZPYFY0TBQIV5AC
 K
X-Google-Smtp-Source: AGHT+IFzsyQJyodOZO75btRuCXEkDoqOQHLgtFgXHzfU5sFXVxnn2tDPXdE4vQrbrxNyn4QRxsm20w==
X-Received: by 2002:a5d:6952:0:b0:34d:8d11:f8c0 with SMTP id
 ffacd0b85a97d-350498a4abfmr12929332f8f.18.1715776371325; 
 Wed, 15 May 2024 05:32:51 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad042sm16406896f8f.80.2024.05.15.05.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 05:32:50 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>, Phil Sutter <phil@nwl.cc>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 1/4] image: remove redundant hash includes
Date: Wed, 15 May 2024 05:31:56 -0700
Message-Id: <20240515123213.1701691-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515123213.1701691-1-raymond.mao@linaro.org>
References: <20240515123213.1701691-1-raymond.mao@linaro.org>
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

 boot/image-fit.c | 4 ----
 boot/image.c     | 2 --
 2 files changed, 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 89e377563ce..1efc39f4408 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -38,10 +38,6 @@ DECLARE_GLOBAL_DATA_PTR;
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
index 073931cd7a3..e57d6eae52d 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -26,8 +26,6 @@
 #endif
 
 #include <asm/global_data.h>
-#include <u-boot/md5.h>
-#include <u-boot/sha1.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 
-- 
2.25.1

