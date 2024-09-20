Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DFECF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B60738943E;
	Fri, 20 Sep 2024 10:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZixXD5/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4849B893C5; Fri, 20 Sep 2024 10:13:40 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D3B89432
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53654e2ed93so2115684e87.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820016; x=1727424816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTTlPOQegg+W2L1ratawWn2FyL+LYPrJ5I8rHrlN8Bw=;
 b=ZixXD5/ePW8ulc2Mr8mJRq0nVa1QuhSci/7wLdqJuJVijivmuzKRsssh2wnqTK4xui
 fNwjdbXrQiPVfr9f1pxtVVgrdy5OzQNILvHGhMnGecfzLTuUEDsynj3OVxyL1B01Eb3b
 xMT1PoalHliOeFQXsmSRNL/rQyZpBZrXiDiPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820016; x=1727424816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTTlPOQegg+W2L1ratawWn2FyL+LYPrJ5I8rHrlN8Bw=;
 b=DDGBRKjWUuRB8s3REqW6GiCYq0vViuUdXfMHsW29I+66X7g9PVqB7Y3SPLWr7yqtXQ
 5nNC8gjYrlzUjU6Fl5iioJKqI1L/w239ZAY1o8u3kdZBxCsCqAQcNYELghlamn21zaNd
 AQ28aB0aCIWq/wk1T5Pk64fqQdyYVaxTaBT8gpneptmj+dfYtDd3rk4GxKehoaZm4+RA
 8YmAwgJ64S7WGpw+tvZR+T915uiY18nLFrhDYEc2i67Y38jn4/OH2MQYj1h9wINWRsu1
 sNSjVEoCxtg450ltgHBLOlNceblP1ZpBcX1QoBbjstplBDq5PP0i9/MEC+yuX7yb7E9n
 4HYA==
X-Gm-Message-State: AOJu0YwWjMsD5//+T7W6s/2OPrgMMsfd0G6JLnnjhCZiguO3u4SkNFOW
 5jlQeegl/C/wT37B4LHQcAZtd4NkVqhfNEf0pmgoLvMwrR6XX1SUq87ZmpnQIvCxZ4utWnabCIn
 hbHvc
X-Google-Smtp-Source: AGHT+IGG5cqTGbJTME8YBj5Qdpyt3wutQGozhJW0aG3sKKdUgwWbNM9byRfcQQ3Cvm8vJcXBZ7d73g==
X-Received: by 2002:a05:6512:ba2:b0:536:554a:b9c8 with SMTP id
 2adb3069b0e04-536ad3d4ed8mr1113464e87.54.1726820015355; 
 Fri, 20 Sep 2024 01:13:35 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/18] spl: Support a relocated stack in any XPL phase
Date: Fri, 20 Sep 2024 10:12:49 +0200
Message-ID: <20240920081309.140426-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

The current check looks only at SPL, but TPL or VPL might have a
different setting. Update the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 89a972dfc84..3f432d0fa7a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -899,7 +899,7 @@ __weak void spl_relocate_stack_check(void)
  */
 ulong spl_relocate_stack_gd(void)
 {
-#ifdef CONFIG_SPL_STACK_R
+#if CONFIG_IS_ENABLED(STACK_R)
 	gd_t *new_gd;
 	ulong ptr = CONFIG_SPL_STACK_R_ADDR;
 
-- 
2.43.0

