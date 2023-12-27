Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F45C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB92C879C0;
	Wed, 27 Dec 2023 22:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="My425mGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86269879A3; Wed, 27 Dec 2023 22:07:51 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED94879CB
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7815547f2c5so105632185a.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711267; x=1704316067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bFD1uCKXcHp/9GmadkAM7oizaVZRSfINAOE6FPzJD8=;
 b=My425mGynbBF77lzvPY7m0+mQMwAFs9lEkLyG/jKPFIZxN1mVPLtmGU9fnsyL8GYtS
 dv43KgX6Ne0o0wJHOB6xXrFQcU8nH8eK8ri3X8mdhdodeK2VgxAwlrOs0+z49tCRjBWd
 2V1GbraLsyigYzdP5KmpJX/7tlRD87pvA9+n0gy+Ygqjtp5VQMAPRrbxSd4ctVBLirGO
 QqxeMvdsUWNM6k9oZi1htutqg21u6J/sjQtNexyhxdjfpRDav6MrSQPwyt8IDXt6nRl+
 BF70LhGTkouQsbVtDyUkjMvWUOYR7/qRmShFi1PxEaLg7YR+CPOqT0sgAQ4pPnVd7a55
 JyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711267; x=1704316067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bFD1uCKXcHp/9GmadkAM7oizaVZRSfINAOE6FPzJD8=;
 b=myUCqSK3snV19IQvofkq9YFIwge5QUOsLc2ZWtQJy6Z5IMYSawXzWfcT9RsyMfCSRc
 8Ia3k7i9VUzzr2QqBqhIc1gp90boeVsDTG4+iSa06ADb70/bLK9RhFGqdP4h5fG0JA2O
 keC+0Z2xnJIE1yaPDMoyxJtqKjjDRy96WMHPwBxwkyT46abHKPZcEQ4N3Rs+J3ZXN9ME
 r8eoc+MXdjfJL/Ory0KVcB5W3vqmrTL3UD5RHKLPwXtydYxsUNyb1bBHfz0uq/+vrQfU
 Rh6OM4np8CPavY1Q8vUCa17FTzlfwFVBb64JH9sw8O3yxJwY38SQNxays1hQ9tANV/IE
 Effg==
X-Gm-Message-State: AOJu0YwzPgjHSLXkhEOGuVzlj1APkDMGCysR78xPtJYi2S1JCLJFrVce
 1FYshLMMPsU3DtP0pkFz5Gta7wNlTrTvLoLeYbvWUjF8bNs=
X-Google-Smtp-Source: AGHT+IFeLg39YrUMJRjjTLIfLfxWlWnf3pwD/JZgAMwr2E5vLG25x5B8AcNvMSN1TxKwUUcxy6HrSQ==
X-Received: by 2002:a05:620a:12ec:b0:781:72ff:bc82 with SMTP id
 f12-20020a05620a12ec00b0078172ffbc82mr102443qkl.54.1703711267115; 
 Wed, 27 Dec 2023 13:07:47 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:07:46 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 03/12] bloblist: Change the magic value
Date: Wed, 27 Dec 2023 13:07:01 -0800
Message-Id: <20231227210712.712937-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227210712.712937-1-raymond.mao@linaro.org>
References: <20231227210712.712937-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

This uses a new value with spec v0.9 so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2
- Update the bloblist magic to align to FW handoff spec v0.9.
Changes in v3
- Update the bloblist magic to align to FW handoff spec up to commit 3592349.

 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 5ad1337d1f..72c785411d 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -75,7 +75,7 @@
 
 enum {
 	BLOBLIST_VERSION	= 0,
-	BLOBLIST_MAGIC		= 0xb00757a3,
+	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
 	BLOBLIST_ALIGN_LOG2	= 3,
 	BLOBLIST_ALIGN		= 1 << BLOBLIST_ALIGN_LOG2,
-- 
2.25.1

