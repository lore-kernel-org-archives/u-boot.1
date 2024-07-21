Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3033BC3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89DD87FC8;
	Sun, 21 Jul 2024 12:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mm+Y432U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D315F88360; Sun, 21 Jul 2024 12:09:57 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 607858827D
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so22471575e9.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556593; x=1722161393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWCa069s8ON7sws6TPowvg06JyytQhPwJ8EZvZ3ixFM=;
 b=Mm+Y432UakII2XZr1IY/nQmt3+FZS5IyFW03+9JtUjWKPha5p3otEyuZAAVRV8elPg
 rlrCNwTTuVkmPc7TZosEUZv9SEJY8r4KZcAoWKcLlgX8KxK9ImDh35GlIPue9M8aiy7A
 qyqDoraaBG3guGBLd86PLktwTdjuGT998CAmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556593; x=1722161393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWCa069s8ON7sws6TPowvg06JyytQhPwJ8EZvZ3ixFM=;
 b=wjdFxoFTj5zwdnntKky+jSeEj29t4ZQj3piGklQflTvs+n1hB+xht3pw6FnimDOvVi
 hyzv7PIcaJzhcGnByI8FYfEFfnZRUoyL6YGy/yOyej9p2RHlAkPatNRps3ITI91V6Qw2
 /5BkVq7IXhHgBz72aJzQytVnTV5yfOv8JwFOoOi1hvq6Pp+AkGGnwZUZjI2z40YoW7EW
 f0v5p1rOue+nw7Rvn2LxEa9eUWcUitMljnB+GCE1+MLH5JF0/aV83B3goXCxisWIgytk
 HhYJ3ZNDi+8PhfYWqrLEOVE6CkEGIjVZAmKEHiEjCHJYjOTJ3L23wGsPMAilSDg28iBM
 ibug==
X-Gm-Message-State: AOJu0YzItomZ0bugj2e0TPYnA4hGex/dje3rKQEyyMfpbCAYfZNuR9t7
 D/wMCOGnRRakjmQoFAj7rNsPKi16w1PCtc8EEpVPKAJtIu9ZPQWltSLx6ghtUCiU6NWGX138RXo
 =
X-Google-Smtp-Source: AGHT+IFKGPAi8L8+mgU7Iw/nBMpwRbCWnzhBU40VCa99BVWSHeuA69Zw/BtXwtynbN1h8GjBTqm3Fw==
X-Received: by 2002:a05:600c:4750:b0:426:689b:65c4 with SMTP id
 5b1f17b1804b1-427dc56a0bdmr24504185e9.31.1721556593457; 
 Sun, 21 Jul 2024 03:09:53 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:09:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v3 05/21] sandbox: fdt: Avoid overwriting an existing fdt
Date: Sun, 21 Jul 2024 11:09:23 +0100
Message-Id: <20240721100940.3202027-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

Since the removal of OF_HOSTFILE logic in board_fdt_blob_setup(), the
logic for obtaining the DT is handled in the OF_BOARD option. If a
devicetree comes from a bloblist it is immediately overwritten by this
function.

Fix this by skipping the function if a devicetree is already present.

This is sort-of a fix for e7fb7896 ("sandbox: Remove OF_HOSTFILE") but
it has only come to light since bloblist was added, so I have not added
a Fixes tag.

Unfortunately it is not possible to report the correct FDT source with
the current code. It might be best to use an error-return code for
board_fdt_blob_setup() so that an error can be reported if the board
does not provide the DT.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Fix 'handed' typo

 arch/sandbox/cpu/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 0ed85b354cf..4f15a560902 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -340,6 +340,8 @@ void *board_fdt_blob_setup(int *ret)
 	int err;
 	int fd;
 
+	if (gd->fdt_blob)
+		return (void *)gd->fdt_blob;
 	blob = map_sysmem(CONFIG_SYS_FDT_LOAD_ADDR, 0);
 	*ret = 0;
 	if (!state->fdt_fname) {
-- 
2.34.1

