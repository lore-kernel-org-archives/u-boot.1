Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C11EEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D21D87062;
	Thu, 14 Sep 2023 18:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CR00zkeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED770870CD; Thu, 14 Sep 2023 18:56:47 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8E986F58
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7955636f500so44474139f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710604; x=1695315404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twEmnkSvOGKcHa46LW3zF/AL1KER6GhCJutrK9JJLXg=;
 b=CR00zkeLB8Xl5E4eMbVXszuSjb/yLYGj6iQG0Kv4jXy1ylzX5/LgJgM4VKJsyJf7b9
 +CCJ80bRLCcb+9xuJ+IN1l0TIUQ3X+UoW/aI6Q0eduxKngeKaVwkujqjod7FgIBV91e0
 xZcOcIGNepuyriAe4PxLqQ+HpH4+OkR2Ddf0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710604; x=1695315404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twEmnkSvOGKcHa46LW3zF/AL1KER6GhCJutrK9JJLXg=;
 b=iKpTgeArQ4oNAf/8YsD8nRUhljy0mxlxOao1ewAm24th0RW/9K7r0U6okJXr3O5Sqx
 qqe8X+Wba6NM2pEWhZOUfn4Ca5nv3ow9r3k02Jtkh1z9OoBW5pdLk+W4ZOH4DFlgOUWg
 OEHL/LzKrC3vr4ekLeP9DlIerZJFWujeW92GVJFqT5Jw8CACsQ+fNk6MVSh2UAepc3Bq
 J4qZdIuzCWyrf7SJDgrH65iHOC0y+BNPiEHYPErYA32Li5vmGw3cYV7uzEYb/1gTo5xk
 su2uUX+egTggiDqLEfaOzesM4i5MZjh9ckxcShFvPvwaOlIpfZ8OrUjveRRtWQ1dg8lf
 +7nA==
X-Gm-Message-State: AOJu0YxqsgNFA+A55573MIjanV9KUjtm/3Cr8lC46WaPotW6PobeJ2DI
 /w3+eJPDAMdSXyNUNtDPUfAeURcYy6YEL8JIqCw=
X-Google-Smtp-Source: AGHT+IEJ18MLtCe7Wtj9+6DThtp8Cm96V2Z951WfrgHLQNJlAs//hllE7lFsp47LVCFfryx5dNkHug==
X-Received: by 2002:a6b:700d:0:b0:794:c29c:193 with SMTP id
 l13-20020a6b700d000000b00794c29c0193mr6458665ioc.10.1694710604593; 
 Thu, 14 Sep 2023 09:56:44 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 13/21] spl: Drop SPL/TPL_RAM_SUPPORT option for
 SPL_LOAD_FIT_ADDRESS
Date: Thu, 14 Sep 2023 10:55:51 -0600
Message-ID: <20230914165615.1058529-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

All boards which actually define this address enable SPL_LOAD_FIT, or at
least just rely on the default value of 0. So drop the dependency.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Add new patch to drop SPL/TPL_RAM_SUPPORT option for SPL_LOAD_FIT_ADDRESS

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 99a2ffca2fc..f564cb8dd84 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -217,7 +217,7 @@ config SPL_LOAD_FIT
 
 config SPL_LOAD_FIT_ADDRESS
 	hex "load address of fit image"
-	depends on SPL_LOAD_FIT || SPL_RAM_SUPPORT || TPL_RAM_SUPPORT
+	depends on SPL_LOAD_FIT
 	default 0x0
 	help
 	  Specify the load address of the fit image that will be loaded
-- 
2.42.0.459.ge4e396fd5e-goog

