Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF408C71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C38D82C79;
	Wed, 11 Jun 2025 22:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MS0+srtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 553B382CA8; Wed, 11 Jun 2025 22:25:10 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF8082B63
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453066fad06so1416085e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673508; x=1750278308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kbjBj6U3/9n4e8o7nYGpRJlvNKq/iy5+qlJp5kuMjw=;
 b=MS0+srtEPkaTKQH7Sj7GTGIOIBBmNgCaX78nkNgV7+/zdScsHwMpkpSBy4Yk6l6DJe
 i1lPIo5dn4W8RB6lwbBO/8N0OMcAAmOb1NlPybuamk+8JkkraQNk3Rw4scTi+wJjfYm5
 CSgjo0jNF602F/fSDaF0wbNz38dfw0omtz6lL0cHCUsfQWLFToMGjaZW8fG43J25TGV/
 IrUwVCcXdvDV+8DyhxJeEjrd7UYQ8GNx9sorj0zslWuUQkx9ZbBaQNpmS5lLszV44rRu
 fbMxWMIEGhFOV19uXiQk4DjNm9Su7OKEfOB7ZzK4DV5C437Q17r8v49WnMpXZeaS/mDB
 UlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673508; x=1750278308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kbjBj6U3/9n4e8o7nYGpRJlvNKq/iy5+qlJp5kuMjw=;
 b=G6Fv7+DGTBYJ7vebk+qBUz2xWTKKdcdjx+pMle7YL2GZfN5G05p5VgPrZ5+JZV0hqi
 ZF+pZu+10isRUn6e0t5/Ju9NQP9+3V0IuUoPrigKrDtPRXu5mN4mr7RMGWUM57hV/HR+
 vh8LNY6j//I4yzYhwKUmJz55lhs+uBDeEGM49JkzS5ve0WNx6p8L4hc8LAx5/H0f160z
 yctcuvhpNt05w1bRkLbrg9XBD/cM03Whj2V3t3k/oYfbQaM3U481FRXB7pg3nC/lHycC
 hDJO85l80W/NUsAbBo+kkLhCsZ2/VEpKZIdT4pkYqiS/1IYmr2k3rWVyo2V3N4/12IjU
 5rRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/R4YHsm44w5sRS8KpH+5Xhkyh9NuGiUDAipDqbZtHShgq/wmR6tlDsH4m9GdfBUuauEWu1DM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxfs80ioGKKcXvkdHBUheLzD0ueftP82bmL2UIf1QNuoSekUxWp
 KctBr3hRILWRVBJZyzSlcCYSYZsq3xaalbxPTP1A5A+ZNhNUPj2aIgDnU81XU2Laj6c=
X-Gm-Gg: ASbGncvorBCIk4NMaYJxBulXDhWlqTuJorpEKgeDJyCqcCJYEgr6u4YE6JABj7pLTRv
 +y2qV/IMFztpZywSvxALmL4KJATm0882KEQqDgjzz9R9zpSBEblDnenYa5Rb23qLNicF2Awvdqq
 Q1NSRfH3FnsfbTmHUG7BeyLlbFdHy7kq5I/RanUCak1+yx2cAuL2+mZl6LWFF6oToRs6wI8/N4w
 4qtT9Mpw/iEqMb+8TjPLrBYEdsDHTQ9cw9R5P4nHK4iNLntlRjWOvlPuS1q2NfFFMNTlUForkpn
 OaQJ9ZRpPJttZ+FovbM/a+9I2V7kXL31PgDjiB7frenWOrgrTPdxRlmv/9KacT7zizbUBqNEzd3
 cZ64GJ8bPKO/AC5SDG8fwmv1+NxuOdMbsSVkZGOY01vPNgznqNyo=
X-Google-Smtp-Source: AGHT+IHbVtt2MnzxYxxVebxTsGSAsqamdPWYUD8nUDqjmg5nKyh8pCjeJx5DqRwngQOj66XzBh6pfw==
X-Received: by 2002:a05:6000:2507:b0:3a4:ea1f:3534 with SMTP id
 ffacd0b85a97d-3a558691657mr3825823f8f.5.1749673507877; 
 Wed, 11 Jun 2025 13:25:07 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 06/13] kbuild: gitignore output directory
Date: Wed, 11 Jun 2025 23:24:33 +0300
Message-ID: <20250611202449.2317279-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 3a51ff344204 ("kbuild: gitignore output directory"

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 00c0d76e1954..2b9516bf4ff7 100644
--- a/Makefile
+++ b/Makefile
@@ -513,10 +513,13 @@ PHONY += outputmakefile
 # outputmakefile generates a Makefile in the output directory, if using a
 # separate output directory. This allows convenient use of make in the
 # output directory.
+# At the same time when output Makefile generated, generate .gitignore to
+# ignore whole output directory
 outputmakefile:
 ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree) source
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
+	$(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif
 
 # To make sure we do not include .config for any of the *config targets
-- 
2.49.0

