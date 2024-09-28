Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB54CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D3488D7E;
	Sat, 28 Sep 2024 22:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VWBrDTWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B16FD88D3C; Sat, 28 Sep 2024 22:01:02 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639D988CC1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a34802247eso11251825ab.0
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553659; x=1728158459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADIWPPZ8GgPkyDZ8olmwmQh9mflSFr8k4BPB0i2tCu8=;
 b=VWBrDTWO6adlPU8SOylEX5X3u2mxuQ+/r/kDXBCaxfM7TrxJC8XZwqOi93EGebjb8f
 B7PGy/ugwJ2Xf84d+PG9JssZAeQKv86J/0oRovA3m4f2S3yQzDtgibY0HCpTCIB5dOgg
 uDLHUmKOZ6PRV7M1/cj4NYAwLPj6ZZXJ0XEeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553659; x=1728158459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADIWPPZ8GgPkyDZ8olmwmQh9mflSFr8k4BPB0i2tCu8=;
 b=NWfUCn1zm4xZLJk/aFaQVwcwPELEybyfCp47rcbyNKCZTQeuFhjZjGPJ+/Z5+fPmIo
 ODyEOwByFGV2tH2fEM/kE0g3LW5g1vdnZKUHpdwnJ2AC050II8VeAWcIdl1Ebjy0PxlR
 z55K2q5o2A6IU8XpZ0n8hqvS063oOn3QkIh1mrR50R/CZ1op0BGAZKjGS/D/HNxR4V48
 uVaHkYrnQLzNbhlnzCsLf+8kd/iSDV6ZOJ1DBme2bC8k8ZqGQQob0U6w4HFRQ7c/GcXX
 DUuP6h7AiGMowK3ZX+oDLnKscK2zuU/Xv+dUiE6zwbD16OzuNJFenESygQX3TiD1wed7
 hiHg==
X-Gm-Message-State: AOJu0YzlgbXrFS4PKt4NxSxpviZU3HM+QWag7yiQLbBnS06FW2VPuifY
 LcfVTZKxUk5qB2vDIGFDssnxUkNEa/Eef10j/17BbhA/qpmSyyLZsaLZidt0bouDRTxpkgWWSuc
 72g==
X-Google-Smtp-Source: AGHT+IGnWSTZmbqOh+rTdSHhxBa2pXoljRh+vz6Moq5s7s13hiz78WVH7VdaxGjdvi26nNVoa24Z9A==
X-Received: by 2002:a05:6e02:1a01:b0:3a0:abec:da95 with SMTP id
 e9e14a558f8ab-3a3451c3a13mr65523945ab.22.1727553658889; 
 Sat, 28 Sep 2024 13:00:58 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v2 15/30] stdio: Make use of the SERIAL define
Date: Sat, 28 Sep 2024 14:00:15 -0600
Message-Id: <20240928200030.194546-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

This is always enabled for U-Boot proper, so simplify the condition
in the common Makefile.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/stdio.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/stdio.h b/include/stdio.h
index 56609b846ff..d42fdd2728c 100644
--- a/include/stdio.h
+++ b/include/stdio.h
@@ -9,10 +9,7 @@ int getchar(void);
 int tstc(void);
 
 /* stdout */
-#if !defined(CONFIG_XPL_BUILD) || \
-	(defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_SERIAL)) || \
-	(defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD) && \
-		defined(CONFIG_SPL_SERIAL))
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(SERIAL)
 void putc(const char c);
 void puts(const char *s);
 #ifdef CONFIG_CONSOLE_FLUSH_SUPPORT
-- 
2.34.1

