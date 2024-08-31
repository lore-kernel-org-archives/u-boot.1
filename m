Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5DDCD13DD
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 16:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD6E8871A;
	Sat, 31 Aug 2024 18:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K/Glk+2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96AF987DC7; Sat, 31 Aug 2024 18:46:47 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D5CC8873C
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 18:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3719f0758c6so1971760f8f.1
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725122805; x=1725727605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LGENyTu3GbLotOQBDDoEgGY32Ki7v8t9jiJTyclBTec=;
 b=K/Glk+2+YBXbuU6mdVsRILqybXp1saeujV/tAA33o1T3E6wiuiY1y60gbhN8eeOoyZ
 X0i2S85Xhfsy+gfYHqrHjTu1hjPCHT1ICVRcjEGyBxTE24bYtaETBRB0AqRxsjNjmn1j
 4xh5ydp/a9IxgGYMUYZcgA8b//b/DNjtDnBApm79zFejP1oi/0ZLKzoIjv4g5HEJVu4H
 FgObsgbfhAT4W6UX4yXxvfNesQB8qefgG1OPMGhtYdGhh/sNEpIYYSArXpHBofK1akkG
 /5wEY0hJZpuQDCzeGdXA1hB6cnV1IG8veKSqwyXiBJEicu+naKUB/cQplkS/tOhqIRQi
 FYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725122805; x=1725727605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGENyTu3GbLotOQBDDoEgGY32Ki7v8t9jiJTyclBTec=;
 b=Ss6exzQSrrY+Y76IXbpPH7sqQyljanxTFc+Nmp8RI/Gre7NqCIB/R68IXq4++utilv
 1cpZlB4QyrOI9ODC/qhIiWsdIawPUTaSx7wqZX3mRkUGqhL9aIEV8E1bzBfBZ4c3HYLt
 S5S/gfP67YsEw0T1WL7uxAYTAfHbK7i6qwDFjVXb9NHZDRjE/Ij/PiG+NRkNJ4Z4fLLk
 uEaXLcALsGkzgeb580dyvWIWdli6coPWGylQu/pt368f3XS+1Hlp8ttQqGXvZAFxm3xI
 OjqELUzZryz5MpNgbfy35IWG9/rCf/15kA0ARnsFnQh7werGBTC5dL8VHIrGN4BuNQAO
 I/Tg==
X-Gm-Message-State: AOJu0YwjOZSs4o3lOyM/TTedwI9wdHtVqS8mB2hJdgXhySdmF6xh2iBO
 FBm7GHI9KRBqOGEchcyc5jLuitl3yJuGDs1VeNnsKT2luBI3tkcKc1zDz3JOVyc=
X-Google-Smtp-Source: AGHT+IGJp1VGQH2tJkh/3cf7VbyqLpfw9k5inBgrjwAMONu3YFo9F/aacrj1fJM3zwssfBa/glj9hw==
X-Received: by 2002:a5d:5d86:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-374b35eed0bmr3348912f8f.40.1725122804747; 
 Sat, 31 Aug 2024 09:46:44 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech
 (ip-185-104-138-67.ptr.icomera.net. [185.104.138.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b61494bcsm3965234f8f.95.2024.08.31.09.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2024 09:46:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: fdt: use U-Boot's FDT by default
Date: Sat, 31 Aug 2024 17:46:19 +0100
Message-ID: <20240831164639.2298097-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.46.0
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

When using the FDT command to inspect an arbitrary FDT in memory, it
will always be necessary to explicitly set the FDT address. However it
is also quite likely that the command is being used to inspect U-Boot's
own FDT. Simplify that common workflow of running "fdt addr -c" to get
the control address and set it by just making $fdtcontroladdr the
default FDT if there isn't one.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 cmd/fdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/cmd/fdt.c b/cmd/fdt.c
index d16b141ce32d..8909706e2483 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 		return CMD_RET_SUCCESS;
 	}
 
+	/* Try using U-Boot's FDT by default */
+	if (!working_fdt) {
+		struct fdt_header *addr;
+
+		addr = (void *)env_get_hex("fdtcontroladdr", 0);
+		if (addr && fdt_check_header(&addr))
+			set_working_fdt_addr((phys_addr_t)addr);
+	}
+
 	if (!working_fdt) {
 		puts("No FDT memory address configured. Please configure\n"
 		     "the FDT address via \"fdt addr <address>\" command.\n"
 		     "Aborting!\n");
-- 
2.46.0

