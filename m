Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48575CD6E42
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 08:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 999F186C6B;
	Wed, 11 Oct 2023 10:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJCA39Yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E4C82BBF; Wed, 11 Oct 2023 10:48:19 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B688C86C5A
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 10:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c7ce16ddfaso3284398a34.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697014095; x=1697618895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/bf5+SbFN6jomIPlNiguOoATaUBUguN5C5gRQCM9YU=;
 b=PJCA39YuSRcKo/VaMm8OW1bUCkcoOdnhZUvL1THqGHMTxqTgJLAx7xy8c/9IKqYilO
 38LQr9aQiJeJf/4oEQxIqp4FPESM3/sYnRQF47014JF9MUIOjxuJ02n16obzidTnbi6f
 an8/uzKN9CI8FTsJBZ1xLvjOHtOa9JywfxBvry1f0HukcQdj21zMKwZ005YHXVocLVVl
 E923vphfBMZal/U/dDFX6nV8eEWgwLF2lHOA4Dt99y6KeZMU4CaHizahLJml7Myz5FOy
 hrunr0wVkOXk9qqDsybQvsaPgy9xMSlslEqai12OnHsQPgDY3bIB2XHF98TmRPamoTwW
 dhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697014095; x=1697618895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/bf5+SbFN6jomIPlNiguOoATaUBUguN5C5gRQCM9YU=;
 b=S58QPsFUmFcTaqDahnpLa5mxKoXnnNSZgA21Y/pZtv0tWL7CEBom/Ivd+OOu0joUFf
 ImAA+IBk6B1+HR237021Ht4VwJzDHVodMS8JU6Z3ya+khBCa00UVPgsugJVjFCsd1U8R
 Vze+riVNj1Cc4rB89NjKN7SU5J0ZdyRXijYhZ9UsZP9S9kRsnojPjx6yvLKaPqZAftHn
 oiGrJDC5a3kucJra4P4ahVvnJ3EBy+0Gitfo3LzRxbvErbXRGqBvqG+CYoqS31Gr3qNH
 gdv9yKhmJkY0NpPhuHSXYdaHGvWzDkqUEvGiMbYjW3DGOUR15G8R9XbPOb7N1HERdekP
 MAmw==
X-Gm-Message-State: AOJu0YyhJTsOzjrQ02IMVhdpukS9gIhQP5T+sYZL0oByFOar5zB0aLQz
 VOxhsxjDSeNHXsjKqcjw/CM=
X-Google-Smtp-Source: AGHT+IEpYMS2ip4BGshK/pbE3BF1tsLWoCkHVedtGDlkxnnSZgwXoJNxai5pCxFaNxDJYusX8SaIzQ==
X-Received: by 2002:a05:6871:e46:b0:1e9:90ec:140 with SMTP id
 vk6-20020a0568710e4600b001e990ec0140mr851502oab.58.1697014095206; 
 Wed, 11 Oct 2023 01:48:15 -0700 (PDT)
Received: from localhost.localdomain ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a638c1c000000b0059c8fa8f917sm2307940pgd.12.2023.10.11.01.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:48:14 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
 YSCHU@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/5] pinctrl: npcm8xx: add name for gpio function
Date: Wed, 11 Oct 2023 16:45:29 +0800
Message-Id: <20231011084533.2325296-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
References: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
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

gpio function name is needed in the debug log

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 7976e3b3ed..ff49819b58 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -329,6 +329,7 @@ struct group_info {
 
 static const struct group_info npcm8xx_groups[] = {
 	FUNC_LIST
+	{FN_gpio, "GPIO", NULL, 0, 0, 0}
 };
 
 /* Pin flags */
-- 
2.34.1

