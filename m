Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D46BC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEB487B9C;
	Thu, 14 Dec 2023 19:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OQ1g1C7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 577E687B74; Thu, 14 Dec 2023 19:17:13 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EA487B6A
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5b383b4184fso76461647b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577829; x=1703182629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NcseCUqtm8LOAKvqDVGfhNOC9QZVvsWz9bpfNuEN8g=;
 b=OQ1g1C7rkYGpdCpTiRPxWfzc7IzdfEVe/7WddOCMoocA/HESd/GBdwT+MQT6a+cSvY
 shM1hwQ2CA4IDarYk2t8Y7XApKZ0aYw3m+4YovR5D58qyUYtz+mULzmRdTOyTbTdx/8L
 PZ1pIKlxOkTK41AdxNRb4O42rBrDccqRibZ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577829; x=1703182629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NcseCUqtm8LOAKvqDVGfhNOC9QZVvsWz9bpfNuEN8g=;
 b=bMsb2yv+hlt6VJ9gkEARVxbbUJQeV/az2YPeMoC5t7sbneAjvJwzch7L40THjFtHbO
 LTuurqIvc29c1EbkBIxh/Qpc8xBb1oF1b74MUSlQu/KbTZH2Q1bdyyAKFaqWynxqFMMc
 IRUlGESBh/cOZpT/hjLPLokD9R1s/paeW2uF18u8wd6jR3Rd8lqMupEbk+jaXDhq33GF
 53sjnV8/B80ymoM+ezLXvrYOxmgSL3ISzYt+oNCybiTyUMTmB2mhAOXD+Ef46d/GfJHq
 lotRo8VDrysVvju+gllq3kTMgNVFdKwELZrjKjU1mf4+DN7eL5IH+uHhWalNJerekpTw
 Gshw==
X-Gm-Message-State: AOJu0YxLrPZnttCO44ZrNuJ08eiTE+7CSipkJPamS9uxlxtpU/9P0alG
 7FY73iogkr2KstZUZhYA9eyy1QZ3MmQ2OjGJfqc=
X-Google-Smtp-Source: AGHT+IFW4ZMyn/Jlasbd9hjqSwkb2ftE/LBQhum+Ry6ap2RV2gnOtOMcdNofuMXaqAjNXunph2ACtA==
X-Received: by 2002:a81:df0b:0:b0:5d7:545e:3bd3 with SMTP id
 c11-20020a81df0b000000b005d7545e3bd3mr8316085ywn.25.1702577829133; 
 Thu, 14 Dec 2023 10:17:09 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [v2 12/16] rmobile: Add <mach/rmobile.h> to cpu_info-rzg2l.c
Date: Thu, 14 Dec 2023 13:16:54 -0500
Message-Id: <20231214181658.3359902-12-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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

In order for RMOBILE_CPU_TYPE_R9A07G044L to be defined we need to
include <mach/rmobile.h> here.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/mach-rmobile/cpu_info-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
index f69649dc7eaf..bd3146fb011f 100644
--- a/arch/arm/mach-rmobile/cpu_info-rzg2l.c
+++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
@@ -4,6 +4,7 @@
  *
  */
 
+#include <mach/rmobile.h>
 #include <asm/io.h>
 #include <linux/libfdt.h>
 
-- 
2.34.1

