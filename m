Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0487AC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8096884D2;
	Wed, 19 Jun 2024 23:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o8odUuUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A743884DC; Wed, 19 Jun 2024 23:28:10 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66433884BA
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7005c84e525so131762a34.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718832486; x=1719437286; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PESRWPE1/6Tjsl4yC8FCoMUonyw5OvXRn5EvjsdlUGc=;
 b=o8odUuUgExqX1KydehcwzPl+6nauVl92E7S8lLmO5v6bSHTYcDQBHqwrgTj028vwJk
 d6gGXE9f4FI8JrDoscxLyZcdF2eLjv8ln3DckHhuzKjMFCYB6ARumfsmn06mEMk/VhaI
 RfxMw2WCRDPEBJM0g8AlUhkcIG5/7kgEG86Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832486; x=1719437286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PESRWPE1/6Tjsl4yC8FCoMUonyw5OvXRn5EvjsdlUGc=;
 b=K/05H+MySg6WdTYPpxROquAvyYhorNaCWiT+qWksz2PmIHXuuJc6hDSjolNPGZRJfd
 oPSmYSDN8soaQQIcfbZLzzszGFbbDIfFUotdZAuULfvoRraxW6rgfhmeXLHYzgCzbfm3
 mfSySTjChYJEiNH114iP6Fl0ldNkB8WY/lspKc9JxqPm6RuIx1Q3p/HXy6ruPpftbpG5
 +3y3Rms+Zm0//godU+Uk0qtqWmEcrUrhq9uZIQYcNrgGNEgthowFTgczeh2hM7tYcwZw
 3OPL6f1YPSAVHb2wXei+PQypTi5dvIa14K7mAikJiTg2JoNPX72spJIlK0hFvJRfm4DP
 ebFg==
X-Gm-Message-State: AOJu0Yy1ht/DaJP7pkMt+zlscRAA3MZx1G9TuD4kPJ1HcWxFn/nCs84M
 J8X+jh33qgdhJjLwIQUQUixzKVM4jCbSeuq3QYFjpujDiKEce4PvC2htnM3p9luVm6ETPnoS4z+
 7L8UjZQ==
X-Google-Smtp-Source: AGHT+IH+ceStpVoEmmW8dOQF+3qWzeszPDgs04sEqh/YM8rGNcYica1UzwxZje60BSs+fXYJyOVaEw==
X-Received: by 2002:a05:6830:1e28:b0:6f9:de68:ab8e with SMTP id
 46e09a7af769-7007587d3a5mr4027348a34.25.1718832486117; 
 Wed, 19 Jun 2024 14:28:06 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7008a5a34c9sm338654a34.73.2024.06.19.14.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:28:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 3/7] sh: Implement a default flush_dcache_all
Date: Wed, 19 Jun 2024 15:27:55 -0600
Message-Id: <20240619212759.3456158-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619212759.3456158-1-trini@konsulko.com>
References: <20240619212759.3456158-1-trini@konsulko.com>
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

Implement a weak default version of flush_dcache_all which is based on
the ARM default, which is to flush the entire range via
flush_dcache_range(...).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/cpu/sh4/cache.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
index 8c1839935ca1..f0cb39d6a923 100644
--- a/arch/sh/cpu/sh4/cache.c
+++ b/arch/sh/cpu/sh4/cache.c
@@ -65,6 +65,15 @@ void flush_dcache_range(unsigned long start, unsigned long end)
 	}
 }
 
+/*
+ * Default implementation:
+ * do a range flush for the entire range
+ */
+void flush_dcache_all(void)
+{
+	flush_dcache_range(0, ~0);
+}
+
 void invalidate_dcache_range(unsigned long start, unsigned long end)
 {
 	u32 v;
-- 
2.34.1

