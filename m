Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785AAD0EE38
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F698893E7;
	Fri, 11 Oct 2024 23:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="det39l6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C25893F0; Fri, 11 Oct 2024 23:23:44 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40EB0893DA
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a3b3f4a48bso5674905ab.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728681820; x=1729286620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+IgbiOe01M1sHijI+E/AWDtwpwD5jHm8OxDialWjhs=;
 b=det39l6seaZmMCCjpVU8DIsenfn7Aa02UGEvJt641W2NGRR3gmR7Yj8/Z3gMzGmaKq
 owJ/A6kT9VgtuxC9eQz/G/aKoXDzHq2qqFvHKrpCKaPI0bFgVHcdS1M/TWSPowhGBz6E
 98B2uEd7aLrKgyUlCeyHlg9W/W5ls315+A2tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728681820; x=1729286620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+IgbiOe01M1sHijI+E/AWDtwpwD5jHm8OxDialWjhs=;
 b=ZpezyWUJkLwvaEl61zRgje88CEZJNbmSwG6SFzJ1kAtfkqPPbAfwmX+fH89C3RM+3l
 01M5hJFqxxIvtwkInR0xn6JTdbqglUyxWrV6roN1M4ikpr8FaIBJdCRnxEa3VhVyVAnv
 M2KBa0JvRYLbY3OG2OvxpPMYxlO+EZ0WIpEhfz+xicO5NptyJocE+aVFJyTqWdNjbqAG
 S5mS2Fh0JVjrkzRcLTt71m4k1FokwZPDQNpoj1EkIidydik3KfoOgDQe9BU1o2lCMd2q
 7h6GkisBVyBfVEfTPghj5QFgxVi6pSTHNgcbJu4GOB8FCXhlWX8YE93dpiM67Fm4rndv
 honw==
X-Gm-Message-State: AOJu0YxuZXo6geNCUD1qYYf7n/+im6lln/6jnl8jUu0S2dDlkU7dTqac
 q4dlqOwicl0xxiTBCuhSNdaJPJobXHalQB0mdWej1PnYWrkDGBJNwJQpG5/vBtsL/04HL91JplT
 fOQ==
X-Google-Smtp-Source: AGHT+IEL8jKAbSBX/ree+PVNtt/9jpJzTiu+rTsdenOwgDgPggbfJQI+d182F182fe1cg+1C3p0NbA==
X-Received: by 2002:a05:6e02:178e:b0:39f:4e36:4b93 with SMTP id
 e9e14a558f8ab-3a3a70a4905mr61148775ab.6.1728681820350; 
 Fri, 11 Oct 2024 14:23:40 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbad9b13e5sm784789173.1.2024.10.11.14.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:23:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Artur Rojek <artur@conclusive.pl>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v4 3/5] event: Add a generic way to reserve memory
Date: Fri, 11 Oct 2024 15:21:24 -0600
Message-Id: <20241011212126.747741-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011212126.747741-1-sjg@chromium.org>
References: <20241011212126.747741-1-sjg@chromium.org>
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
index 154675d0e40..9f13bc9c374 100644
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
2.34.1

