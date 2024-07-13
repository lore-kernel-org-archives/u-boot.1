Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F870C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 405CC88818;
	Sat, 13 Jul 2024 09:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kzUwmDvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA1F887FA; Sat, 13 Jul 2024 09:03:49 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2230188789
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso21887945e9.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854226; x=1721459026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mf8LHbfAwmTlOiqkjp4Gl5KAcNGC9bhgAknwIJm7wRE=;
 b=kzUwmDvuvCHS1U+1+IdGfzilLssGO4PxxKppzZXqwOvJMgNKx636WXF3KatqrQPuQA
 9s+Bl6f36B9+J0LkJv5ua1PYwSFuENarRg3Lcvf6WKjS/Uf1ap+k+gv4SF5v6ZXLy4w9
 SWQsnmHMHWBXH2JA+a404NxeMfQw0ZnPSBF7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854226; x=1721459026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mf8LHbfAwmTlOiqkjp4Gl5KAcNGC9bhgAknwIJm7wRE=;
 b=L+5TA8EN+yxR2OB2kVlsFnRXJq1XaZfAbqV9xePBv4/t/yEFZmtReBI8giFMYELfsn
 G8JcnKpFv0680ZId8cfGHQ+ZZdzN/tZeZJ72gxTFdVyN9/+q+Tz8PUmiRRh3CUMOnfY7
 sJim/4mgiV+bkquryulZe/WegZfvKy2i5iF5Qh4mr75kLc9CkBuZwVrBKtz7FGIe63hA
 PYRTBbaIT2SlJ8EQHVPkcnkxYk2cvFbcG2O+FAIPpc/8dHjMXRaKsTsdvNUOFW/+EBzO
 dqgv8tZUHlmCC6gDK5K4DTx0DnnG4JFazV2CeC5m/kIrPf1snOd0gT5IHFqXTgGBVx+W
 Eb3g==
X-Gm-Message-State: AOJu0Yzc3JoKW2j4TBSee+cW3kJsVf8ocdh3KN/ldULH9VXBPrjrjT95
 7fNB9COMziE4YH5VlcN1hUp1icPqQxLceFVHObBMs6H/mZqyU2EPAYHcBYnqt+T8xH8jAoLGKek
 =
X-Google-Smtp-Source: AGHT+IGdqFrO4bPV9Z+qtc4B+N5cTRFf0OQLx4GAIb8oZApL7O8XzkL4XTgd4svbw76DsrulJe4oyg==
X-Received: by 2002:a05:600c:19cc:b0:426:706c:a55a with SMTP id
 5b1f17b1804b1-4279d9f287amr45985425e9.2.1720854226437; 
 Sat, 13 Jul 2024 00:03:46 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/21] sandbox: fdt: Avoid overwriting an existing fdt
Date: Sat, 13 Jul 2024 08:00:40 +0100
Message-Id: <20240713070055.2172883-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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
logic for obtaining the DT is handed in the OF_BOARD option. If a
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

(no changes since v1)

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

