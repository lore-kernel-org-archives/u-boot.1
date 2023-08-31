Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005D5C83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E696286776;
	Thu, 31 Aug 2023 18:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+VdNyPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727D4866BB; Thu, 31 Aug 2023 18:51:55 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B368666B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bc9811558cso850271a34.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693500711; x=1694105511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIQ5n7QyEQYuO19LmAEVZ3exfAr5qQGtqyEh3+jjv/E=;
 b=W+VdNyPGEjxgoNMg3/pUp/LvXlWZaqyuRQt/Lvb+lmeWteCW1lQpAlN3MSSZUphK5e
 UhEYejf8QW541s4nqneyz0Dks8kesMHRjhBlwaCEILuRVVloFWlKWxPhEnEBtzddxoSV
 egCA5LVxy7wMJkwzplAneCBXBnOS0w6S3/7g6at0XigaFxhd3KXVUri1Ps7l4mNcrI52
 /7Y+9P6HeBVDnJGiL2bbJLhDEYwqtzHq17OihszZLnhvZMAt3IdpjjJz3U3T+S2jBYUq
 bXOWpcWJ4HD620IE/CxQmtCXKz3Es37DfpXH6jGqSn+QVZRApWWTzwUotslRfzhDS6mx
 tEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693500711; x=1694105511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIQ5n7QyEQYuO19LmAEVZ3exfAr5qQGtqyEh3+jjv/E=;
 b=fR6wLuqsXShtIHTCqIbdSjgVSYpYhEO6YoT7HOx6DekHXXxLL6lS7s1UUvpDe7WmZi
 cand0FFsnjW6CfzE/x0fIchViMNfd/MHNkie/eTxi6T5Ooy5jQy9V4m7EWCssx9veJQu
 6L22SxgiEOeEVDJsDpE2OFN8DUxB3skHiU0gkbF9BNcAMEJWFJwMJ8cPYTUmJqCyacSG
 CcdTwJkxu6F+wLXGPu8+XspQBvwgmxxpcJK0spHiDVpEFkB1BAs6uuiA/S1SWpjA0/H8
 dXMwAGfUND4OPS6n6vaPHJ7NgzQIkZQH9aI25KrQvI7x8m6jI4ABIqzT1lS1hAXj4c4l
 Yv0g==
X-Gm-Message-State: AOJu0Yyy4qoPwoKfY4rALAIQkHslvR1bGC5eyKgDyzn8KciaXECRTobW
 o8+DSc5/fnCjCirt4XZiLRtnSRtXpws=
X-Google-Smtp-Source: AGHT+IHBJLDg3grvxKQvi9T60QlTrbXNpcPZtpc6k57XT4KOcKtzQqxAL6JYkD6J8Vlch7E0B9Pt4A==
X-Received: by 2002:a05:6830:1e7a:b0:6b8:807b:b50 with SMTP id
 m26-20020a0568301e7a00b006b8807b0b50mr5922142otr.22.1693500710820; 
 Thu, 31 Aug 2023 09:51:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b66b])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a9d6b8f000000b006bb334880d8sm867020otq.81.2023.08.31.09.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:51:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v5 1/8] cmd: gpt: Remove confusing help text
Date: Thu, 31 Aug 2023 10:51:34 -0600
Message-Id: <20230831165144.592820-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831165144.592820-1-JPEWhacker@gmail.com>
References: <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230831165144.592820-1-JPEWhacker@gmail.com>
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

This help text appears to be a fragment of the text shown when
CONFIG_CMD_GPT_RENAME is enabled, but is confusing so remove it.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 964056bd28..fe9e06681c 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -1060,8 +1060,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	"      gpt_partition_name, gpt_partition_entry\n"
 	" gpt enumerate mmc 0\n"
 	"    - store list of partitions to gpt_partition_list environment variable\n"
-	" read <interface> <dev>\n"
-	"    - read GPT into a data structure for manipulation\n"
 	" gpt guid <interface> <dev>\n"
 	"    - print disk GUID\n"
 	" gpt guid <interface> <dev> <varname>\n"
-- 
2.34.1

