Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD17C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4161987BBB;
	Thu, 26 Oct 2023 20:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EU8+PV0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF18C87B77; Thu, 26 Oct 2023 20:32:02 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D84C87B79
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-41cd6e1d4fbso9044221cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345119; x=1698949919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mt3ZpnjRNZW37GgkDuYfBmQyv5NUf+wmGjucbYRybnQ=;
 b=EU8+PV0l61A5Ql9wIwu7UYRRHj+V7ixpHsg4QK0HaDEOH+G7997a7P3OHhqWZsXn4x
 gHqHJeLZAQt3dI/Aox3sZB9IRIhDIK377ugcVXZbRaG5NfmXxRWhZZ9NthcaSVI7zNjd
 VPEBtVwT/JvtxRmzyzlfMSDP1xfOUdqdnfrs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345119; x=1698949919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mt3ZpnjRNZW37GgkDuYfBmQyv5NUf+wmGjucbYRybnQ=;
 b=vgxzXkpAvjz4dpUakc4+XtFWR5geKeAijNSKnh+3instwtrmTNnerVZL3mfZeg5aQw
 N04DpkB9xGVr2QSnH1iBpihq3lIW0n2VOkKmbXodb/zo3vXuwIvyYOGadcNJ7Vl0OK2j
 4tTZU5VWktaGS7u6IGjjqaMyR0Uq1OeC0LWagHhwHXOLOfYEVW4l6GKirf0tVDgWae02
 ejjujYMKWj8p+ahoLefYAtHBxJrlifnq3wmZwzitEHvXOzchjdLzmGGJz1L0pj8V9L+E
 rtWFOstgeeY/PQLoLXXcar5wDiLf+ET1BF8b06RFzMepuPBVpljuW+6dqKh0U6FFf4Vx
 pxHg==
X-Gm-Message-State: AOJu0YzrMdoNTuaVrLbGIFpjySd2/BxW/0yXJ+woO8B3duuwAq+n+gOj
 wVUbpscHwTIg8C84VrhUWx/3vKdUvwvqY/nbIuOkcg==
X-Google-Smtp-Source: AGHT+IG6De1qaFJEU74ZmgGUIPPX97CZNHG8JW43YMrCjp+Sn/lygNTAdRD6MjXltJbr15CJcJUegw==
X-Received: by 2002:ad4:5c46:0:b0:66d:28fa:f4 with SMTP id
 a6-20020ad45c46000000b0066d28fa00f4mr601371qva.2.1698345118908; 
 Thu, 26 Oct 2023 11:31:58 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [v5 23/30] lib: uuid: move CONFIG_RANDOM_UUID
Date: Thu, 26 Oct 2023 14:31:31 -0400
Message-Id: <20231026183138.636948-23-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This option is independent from any commands and should be managed
under lib. For instance, drivers/block/rkmtd.c is a user.

It would be better to remove this configuration.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v5:
- Take AKASHI Takahiro's RFC and add my RB tag
---
 cmd/Kconfig | 7 -------
 lib/Kconfig | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 0eb739203ade..dcf1e54c5ddc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1132,13 +1132,6 @@ config CMD_GPT
 	  Enable the 'gpt' command to ready and write GPT style partition
 	  tables.
 
-config RANDOM_UUID
-	bool "GPT Random UUID generation"
-	select LIB_UUID
-	help
-	  Enable the generation of partitions with random UUIDs if none
-	  are provided.
-
 config CMD_GPT_RENAME
 	bool "GPT partition renaming commands"
 	depends on CMD_GPT
diff --git a/lib/Kconfig b/lib/Kconfig
index f6ca559897e7..b6d580c30615 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -74,6 +74,13 @@ config HAVE_PRIVATE_LIBGCC
 config LIB_UUID
 	bool
 
+config RANDOM_UUID
+	bool "GPT Random UUID generation"
+	select LIB_UUID
+	help
+	  Enable the generation of partitions with random UUIDs if none
+	  are provided.
+
 config SPL_LIB_UUID
 	depends on SPL
 	bool
-- 
2.34.1

