Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC86FC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B86A287C8C;
	Sun, 17 Dec 2023 17:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dS6Yef/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F6B87C8F; Sun, 17 Dec 2023 17:36:37 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBFA287C83
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7b6fc474d16so121275539f.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702830992; x=1703435792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o3BYcgyqsJn2BclnTQO2SClj4ZiLj4Xx/5QHh5BVZw4=;
 b=dS6Yef/i0duG4hwqVvb04lxyeNVr5fWC/UV+kGD3iQfG95+0sZTiOH/990wnC9hqbD
 wv5plwQ9gtMNYScrBqRRNMi3U/HRCN4L37dcNy52ooqE79k8WQ7cluayxm17xor+hwi+
 f6+oxZq3f7Xqmj5cpjxVStu9gPQ+vMtTYgW2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702830992; x=1703435792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3BYcgyqsJn2BclnTQO2SClj4ZiLj4Xx/5QHh5BVZw4=;
 b=XcGfw3pSmwwGlg1nXK0GeRWTYu11Coxqm/fjXE6wkGd6kPdk1HDLdLGeEy6sWkVs7B
 X6ff0RKxrH9W4EKBe8JZnYjkz7imYu5FpHpG97z7ZnTOXR4HK3Cr3yVddKX4cEpQLEky
 i1iak+AfXKWd0qZg94pjaeVTMGnzuSJMzgyVOEROEiWACrCg+dVSBvIvM+43Vn/tetLG
 Tm1Lw6OakqnoPNicNu2125DtePCPC7Vda9tbZDlmLgJu/5ZOcFMbCqYv60KbGBJxZhaP
 XSlljKaNcwCfm6QwsFc69UX3EMt1sIkzr3HJQaZSY8IcjIiZ76kIrHzidOf0HvII3PwG
 BZTA==
X-Gm-Message-State: AOJu0YzV1OOZ8fE6px8x2Zzciu4EkAIT9YnKBlOTmgvPuD+EberHZ/wf
 dlVkvJfg5KO2FRbsyT3xyu6f6pJD10D9xh/fA/ecnw==
X-Google-Smtp-Source: AGHT+IFEPCU/0yCxgHGFAkfrhy1bt+R2lujMuhkF7t84/F0xkPk0TUXZyJ7W984Ys2U3Y5vT7rrLmA==
X-Received: by 2002:a6b:e80e:0:b0:7b4:2957:6157 with SMTP id
 f14-20020a6be80e000000b007b429576157mr18398685ioh.17.1702830992305; 
 Sun, 17 Dec 2023 08:36:32 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 00/10] Make bootph tags transistive to parents
Date: Sun, 17 Dec 2023 09:36:13 -0700
Message-ID: <20231217163627.2339802-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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


The bootph binding[1] is defined such that if a tag is present in a
subnode then it is supposed to apply to the parent node as well.

This series aligned U-Boot with that binding.

It also includes a few clean-ups.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/
    schemas/bootph.yaml


Simon Glass (10):
  x86: coral: Align bootph SPI-flash subnodes with parent
  fdtgrep: Tidy up a few type warnings and comments
  fdtgrep: Correct ordering of flags
  fdtgrep: Correct references to fdt_find_regions()
  fdtgrep: Tidy up comment for h_include()
  fdtgrep: Simplify code to inverting the match
  fdtgrep: Move property checking into a function
  sandbox: Correct SPL condition for building devicetree
  fdtgrep: Allow propagating properties up to supernodes
  Makefile: Use the fdtgrep -u flag

 arch/x86/dts/chromebook_coral.dts |   6 +-
 scripts/Makefile.lib              |   2 +-
 scripts/Makefile.spl              |   2 +-
 tools/fdtgrep.c                   | 123 ++++++++++++++++++++----------
 4 files changed, 87 insertions(+), 46 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

