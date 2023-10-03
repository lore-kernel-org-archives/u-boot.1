Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C70E776F0
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 02:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0583386DA7;
	Tue,  3 Oct 2023 04:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VtfJLGOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F55386DBC; Tue,  3 Oct 2023 04:31:09 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A5386D94
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 04:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c67060fdfaso264748a34.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696300265; x=1696905065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IwZU4tN2gg3ctDPxgMuveMtsbUcHWw+ysYfHoZZu/DM=;
 b=VtfJLGOj1CJ6vyZENpIV/btBtzOFyh+FggZ3BQNBtepNHQL0VsDkmQPf+rj614iY+4
 ElTsqqqrHCBmqkXwVau3AFeLnwupvwEYF80H6RyhyEsC02Wl03r+FvjwB44uR+cDhPdR
 SDpPq7wqeqCg/ci+8E0P30Lu+ZsvQAEk5Zz5eZ43kSL0N7+uIXDfXig4anT45BEr5UDl
 cxw5cbDVswfUcn1h5SRZNa1vPCUxs+D7atn/BJSZNzQKuFlHa6NGweMK0c6EiORnL9nT
 i8Awsq+r9g1Fm+3mAyKfKZbxWV3z2FFKciztgf2GhA+a70hyEMTN2fFuixzEWK75n8Zm
 CH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696300265; x=1696905065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwZU4tN2gg3ctDPxgMuveMtsbUcHWw+ysYfHoZZu/DM=;
 b=urZ03VMZvWustuPFJ9mvIVbPVCDU2ZrChUShZeiBfWcPi0U/YKIOkmPaJrDrPMc6Op
 L4frIbmsjXRwK1D6FwSsp0zrF/b3lTyeWxA3S44s/O1vI55BLchx7Uk5JY6JLk7tFkJb
 XaLz++k0EakVNSQF5wKmkvJYLkxzRIkHJY8pwNzsrhWLFx/Y0oZupo7sQXICR0zCaEFU
 iiAvkmtdI1TDgxFxG5p4LAYVv7HLB5D37Y4RNIMZqw1o2WdWoUrbpvnjcDvrHtQ3ni2l
 pcVWTo88QibX3vZ8ODT1tNmALJaas67gtmABtdXuUlgPpGEHrqLA9VBB6s514tm3omW4
 guRg==
X-Gm-Message-State: AOJu0Yxc0o1i8yVktJbT3VOJ2VChy/PZeimp6/1DfhWT4SY7oTMZuz7t
 zC1SdIPNoZ/DVVHOsf8e0iZr2KGpHoYHLGHtKdc=
X-Google-Smtp-Source: AGHT+IHt8f7Sd8NESp4USOEDFklIvjiOxpoR9LF5cP9wS/kNj2S6Y5idGUGmxaT54ME2RQIUT8yykg==
X-Received: by 2002:a54:4714:0:b0:3ae:a81:55a9 with SMTP id
 k20-20020a544714000000b003ae0a8155a9mr13251153oik.24.1696300265196; 
 Mon, 02 Oct 2023 19:31:05 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 14-20020a17090a000e00b00273744e6eccsm188091pja.12.2023.10.02.19.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 19:31:04 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
 Ryosuke Saito <ryosuke.saito@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH] board: synquacer: set actual gd->ram_top and gd->ram_size
Date: Tue,  3 Oct 2023 11:29:57 +0900
Message-Id: <20231003022957.1743493-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Current gd->ram_size and gd->ram_top reflect only the
first DRAM bank even if the SynQuacer Developerbox could
have up to three DRAM banks.
With the commit 06d514d77c37 ("lmb: consider EFI memory map"),
the first DRAM bank indicates <4GB address, so whole >4GB memory
is marked as EFI_BOOT_SERVICES_DATA and it results that
U-Boot can not access >4GB memory.

Since 64-bits DRAM address is fully available on the SynQuacer
Developerbox, let's set the installed DIMM information to
gd->ram_top and gd->ram_size.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 board/socionext/developerbox/developerbox.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/board/socionext/developerbox/developerbox.c b/board/socionext/developerbox/developerbox.c
index 204e5a41a5..9585944d80 100644
--- a/board/socionext/developerbox/developerbox.c
+++ b/board/socionext/developerbox/developerbox.c
@@ -145,13 +145,27 @@ int dram_init(void)
 {
 	struct draminfo *synquacer_draminfo = (void *)SQ_DRAMINFO_BASE;
 	struct draminfo_entry *ent = synquacer_draminfo->entry;
+	unsigned long size = 0;
+	int i;
+
+	for (i = 0; i < synquacer_draminfo->nr_regions; i++)
+		size += ent[i].size;
 
-	gd->ram_size = ent[0].size;
+	gd->ram_size = size;
 	gd->ram_base = ent[0].base;
 
 	return 0;
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	struct draminfo *synquacer_draminfo = (void *)SQ_DRAMINFO_BASE;
+	struct draminfo_entry *ent = synquacer_draminfo->entry;
+
+	return ent[synquacer_draminfo->nr_regions - 1].base +
+	       ent[synquacer_draminfo->nr_regions - 1].size;
+}
+
 int dram_init_banksize(void)
 {
 	struct draminfo *synquacer_draminfo = (void *)SQ_DRAMINFO_BASE;
-- 
2.34.1

