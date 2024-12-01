Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BFAD4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01CA3896CD;
	Sun,  1 Dec 2024 16:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zo5ww4y5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A2989722; Sun,  1 Dec 2024 16:28:36 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6A48914D
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-84198253281so118748939f.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066912; x=1733671712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2cL6y3D8YkaMzUn6QTbipkUgec0rHe8xnUSjrUlUTA=;
 b=Zo5ww4y5Y4OAgMjhO/mX5B9+BFretcUUcQ9l9nmWh7bjvxsdwlpjixuWEoXrg9AEoU
 PRNXnViQQZeeQ5E5FtZOJBFX+EN9cAzvs2/W+Jz4Jr37tEZ89d43Pt0vtbDIoxsoSO4V
 z1zPlyCVTg90sRP1Cx+303EGUXdmWr/IdI/3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066912; x=1733671712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2cL6y3D8YkaMzUn6QTbipkUgec0rHe8xnUSjrUlUTA=;
 b=ddQDSH5oUfVAIoBE+auqv6nyW8JjfYbbzODqFRGZZK6dPfdPT05ohPaX/OJyE0+Ttv
 VqTSZ1f42aCYNX1MMvzBLKeE7E/Wa6MaG4QZa4Hn2xDotKXmF5xkMvGQ9coUsg0Tf0cu
 IpJ+5nXJwpE7B5QgLdSq45TCngklOZel90m7eJh7QpBYp+EMD8qXWvgaQvRoi4Bvc38d
 0SA4j3TFuTPc6T1mg0zaNcJ2j/ttA+wjr5ckQ3iMCSujYahB1W/X+/mozhaQkPKdJAnV
 XwhSsv9WGsnBlJt1zgpt3N827BSPY11w5L069KGIkdICx0aR+mLR2oN9bKoGBtSXJQhn
 YrYg==
X-Gm-Message-State: AOJu0YxDQEm8S/7ViEiMsZDxYTPw0RYTfTKn7QezTlbmRam4znAd5zh2
 TQKgCFm3xeIshl/9QMDUcBU9K5NZVpgnVn07FuqxzwpIJ5gBnZ6ulZFziv78SRSjB2QaKvyTA7E
 =
X-Gm-Gg: ASbGncsQ1gZkyGvfIwYmd/pSyJ+gPbKmMKeS/JRpFeZPbaFegzfv1IUKG+NeUisofRp
 IhSEy1gUFZrqpfMucsbw+Ky2tv7EI+6oKl9Kj39RW7QC61W0z2YrebtYJIHMpfS8QjbvLWbwtdz
 oBjhQ2saCiSe991CepAUoSEa2zmdOBaOzu55tL2duEZMolecOqMrHedTD6YvCKxYfCQ5Abl9Vjz
 /MtZvFR1hsaxqLj2cRixgebVrVYTBQZsHePQd57gtnJ
X-Google-Smtp-Source: AGHT+IFjEwKCjg6DKVCtlZhOeUZFWMw9QPtyaQmemipF3lbLm2ts9ZF7+uG9fbE7NzWHphmaM3t/pw==
X-Received: by 2002:a05:6602:1513:b0:841:8d66:8aea with SMTP id
 ca18e2360f4ac-843ece805d0mr2082222139f.2.1733066912662; 
 Sun, 01 Dec 2024 07:28:32 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v5 7/9] event: Add a generic way to reserve memory
Date: Sun,  1 Dec 2024 08:28:09 -0700
Message-ID: <20241201152815.1668093-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
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

Add an event which allows memory to be reserved, for use after
relocation. This can be used by subsystems which need their own
memory.

This could be used to clean up reserve_arch() but that is left for a
separate series.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c |  1 +
 common/event.c   |  1 +
 include/event.h  | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/common/board_f.c b/common/board_f.c
index 3532ffec46f..0f2ae570174 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -976,6 +976,7 @@ static const init_fnc_t init_sequence_f[] = {
 	reserve_bootstage,
 	reserve_bloblist,
 	reserve_arch,
+	INITCALL_EVENT(EVT_RESERVE),
 	reserve_stacks,
 	dram_init_banksize,
 	show_dram_config,
diff --git a/common/event.c b/common/event.c
index dda569d4478..b7da027094b 100644
--- a/common/event.c
+++ b/common/event.c
@@ -37,6 +37,7 @@ const char *const type_name[] = {
 	/* init hooks */
 	"misc_init_f",
 	"fsp_init_r",
+	"reserve",
 	"settings_r",
 	"last_stage_init",
 
diff --git a/include/event.h b/include/event.h
index 75141a192a4..56c05e8e7a4 100644
--- a/include/event.h
+++ b/include/event.h
@@ -104,6 +104,17 @@ enum event_t {
 	 */
 	EVT_FSP_INIT_F,
 
+	/**
+	 * @EVT_RESERVE:
+	 * This event is trigged after all other reservations are done, just
+	 * before the stack is placed. It can be used to reserve memory for any
+	 * other purpose. The memory thus reserved is available immediately and
+	 * will remain valid after relocation.
+	 *
+	 * To reserve memory, subtract the required amount of bytes from
+	 * gd->start_addr_sp
+	 */
+	EVT_RESERVE,
 	/**
 	 * @EVT_SETTINGS_R:
 	 * This event is triggered post-relocation and before console init.
-- 
2.43.0

