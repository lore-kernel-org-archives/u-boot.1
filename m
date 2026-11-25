Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9D606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LG+iFwDL;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=k+Y02qVG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DCAB606BD;
	Wed, 25 Nov 2026 10:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xych6_K8hesw; Wed, 25 Nov 2026 10:58:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0A4460884
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604324;
	b=EA+kAlsPGoUdVbkg65hYSAoJT3JPjPZtO3hVPZp+ErCSpw1FhCbI2xTe2ZuQ/M7JirCz
	 FVf2oRUM1zzOW2mPKmJu0b3akGO2nfs/hS12/v0KQYrot52UnHgJKsESLmZGWHy554Iru
	 ZKX/LKRJyMZvqcwcJADmWKd+MoVQepJ73HzsKC6ZAG1U7rR2e9J35diCBKBLVPOUNuCtk
	 ZqqO759YMQJT5P0tOOcuMHpnEmz4idhTePY8ex0nofXooVBUyRwegydzp0q1YUNnVffP/
	 pFdY1diFpZzGv7NCtq2AbPbKMj9bjrNmOAUIlhJTliXNXdy9zyvcVOwndflln40WDSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5RIHyF4lWcSVgP4h18HJ9mPac5eK5yqidqRNxjoEc7M=;
	b=Y5ignoFADLOBzWk0K29g3I+stLSG+u3SLsdbQmJUbAkUg0F3fYPH5H9sALEnuMjCEjCo
	 iy+eYE7uzehxbIUQN1JRf81AldI56ATLAmzRp4aT7nqAGGn2JTJOmpBlCu3SQrB17WEhb
	 E8VssMGc91/k21eNKsAdcQX/9HLkakbMFmY3Zg3/LNW82IspvCcwnsbI2zzyu0ShAjPDR
	 3U4syUumxAq5SJo76CrG4cc+FvJmW1U9dCrF7XU1+k85ZNOejt3X7Ooox3sNJTYn6H0Ys
	 pRzTa7YBBX4ibpT/tBZhkiVzSS8eT9Uxmf7oma+r0HwWEwXMZl9TdGe9qorBDktagfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=k+Y02qVG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604324;
	bh=5RIHyF4lWcSVgP4h18HJ9mPac5eK5yqidqRNxjoEc7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LG+iFwDL2KHP0dYkwNy8Glmob61LcMq0Bn0SRi1fVlde6nmzJXrKnB13dOCOB4Mgh
	 11SXnc++0iCnuJs5WexBCSc7Wcb/r0paSDDHJ74xH0zQLLxjF+EzPy8hpGIxTNqxqy
	 EXKe/SHxCuXX0thHAiH83jaA2yn0OoexC98lLx2D+KGi1UJkfeu17hnBk+H41TetiQ
	 kiPYe3ggB+7qri9nBjk+LjtcGf8tnfu5b0nMOd0l1jEF7sUzu8aiZmT9o5SZkUbjcO
	 +hhvYCEjf4JjpxGQMzdQ974N4OuT2JT8TpUEpUsRmeZdIE1ztolAih/yroQPbXCZMa
	 rOyaqgJQs3JMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0A4460884;
	Wed, 25 Nov 2026 10:58:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EF8B2F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EEC86070F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J7gXeGFuA4a6 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 290FD60627
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=k+Y02qVG
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 290FD60627
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:36 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso44290375e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604315; x=1796209115;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5RIHyF4lWcSVgP4h18HJ9mPac5eK5yqidqRNxjoEc7M=;
 b=k+Y02qVGQqJd7Spj55M54sV80AoiS2spPvOjTMv/sJ8tCrD5tI4ewvKySmRgLJRDso
 JONkJVbJkDLqp2HY1umnaDgExXq6bB0dCz7ebvzd0W0fjPOAW0RfspijcVklclT0Gxjq
 wLS1NldVHcfsCraC0sWVDnh5Lks0NddD9EYDl3HgD4VImsC6lF587bPI0hdFnq7gxEQk
 rIGt3rIr/ehXihMsYS25oYx/WXBUj/cLgHFtWDZpzJhB3/q0By2QJbcnFmS+8QCOcqkn
 lc2fpoitbbJekpCy2WL3D5jeMWAbm7oEJjKMQE66lzwk+4XrABrv8GsqJ0f6QwWr2imu
 mQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604315; x=1796209115;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5RIHyF4lWcSVgP4h18HJ9mPac5eK5yqidqRNxjoEc7M=;
 b=QIJYpC+3fHEHUXiNZl6/guhy+mv/LbQGcIs+4OfX4jayTC31Bpd3x9xSHkPIfE/kx2
 /qbxmv1nFlA0RWI0EEA+BEmiiVkaqJtOWi8R933iZKsObwYQZtBA47cA9Zl80lGCAVdS
 JT7XpYVSBQAhV5uRnaL1tFytgm78dWZpKRXWIBuyukb3vVxXtrRfcYLlOkqtq0Ba6Ddp
 1AePCzUJ1o8omgpM2SXiAoVZno3BCBa35YqBq1uRpOLRQGGc1/ATy+JFrxZ7JBQ6whIs
 5ylN065Ey+2r6JMjoAuz7vssgNhK4/K/E7HN912ZSHBJepk9GmWwLFNkPabfMAZ8RMVp
 jwBw==
X-Gm-Message-State: APuU4Z9aRCA6/9RD3C3LOxEnZ1siptjBWNWawdi0dFnMkcbcM9IAqG4b
 SshyYqLMWGv0fjZK6Nak86USt9CNY6IZJ9oEz5Uhj4aT0Rvs1UxOMWljysWq7dVpJ76g/dqCi3r
 Uee2VdS+4IA==
X-Gm-Gg: AZFdTZdvnd5Z3ukP6bW4Kfpq2jEyEk/MeIltiB55X56LRcwqpz8h8nt1AblWwTe7y2a
 hK/JeCq0YcoKfv0pNfWhqCvNo0ZN/YhBjo4JewbQ4l7EP6sdLm5qq6hRAKANpMpJM3poukwZ76v
 fsjQNG+AnYGDC/Kit/fnU/evtUu/HxFbs7csQUIsRGMt4xq7yxc+/NnsVuXzCHYLaVczLS6lc12
 zYRcDKOajnpzA4pU1K3eOPwX+F4D2ax2ZV/+3W3PUtHtHTtjVUHbeVtDmFBONZSyuhV29rdtK2S
 2RILPLKqTzWM+oUJDVRYe7X9APfIDYIQSXuDmzOztVKx9GnzJ/qVXW9s3un+Ivo7Mww2mjoEwf5
 7WyU/ctTgypdnYbX7UgAF8kvTATLF/QHPlAnBNRWHJGk7ojW/U5q8i7EkAx8M1clXi883RaMofl
 CGc0sW+kFlkc5wvV23zBmHbvM05dAICbg5G2sy75J0e9GT641z1x8GjUDwfWNNw6RqpDwi9cAAl
 FqelWf2AJkak+m8qy+CMpbr/EnuHDO2ov8SHlZaaMso9w9HiA1LvIXysw+5KMu0xWEUt1x03xJv
 JPAMefBNK7eJ7Bm2EblIqsD/NxatoTxb2/GaCD7p6ngYhzva7WkY
X-Received: by 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb8881941bmr398884275e9.24.1795604314684; 
 Wed, 25 Nov 2026 02:58:34 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906cdcc1sm282002005e9.2.2026.11.25.02.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:34 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:12 +0100
Subject: [PATCH v2 03/11] env: flash: Define the redundant copy pointer in
 every build
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-3-8d31a33a54d2@baylibre.com>
References: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
In-Reply-To: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Fiona Klute <fiona.klute@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

flash_addr_new only exists with CONFIG_ENV_ADDR_REDUND, so code built
for both layouts has to test that option with #ifdef.

Also define it without a redundant copy. A static pointer with no
initializer is NULL, so such code can test the pointer instead.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 env/flash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/env/flash.c b/env/flash.c
index 0148ce2b835c..3130b35250d0 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -62,6 +62,9 @@ static env_t __maybe_unused *flash_addr_new = (env_t *)CONFIG_ENV_ADDR_REDUND;
 /* CONFIG_ENV_ADDR_REDUND is supposed to be on sector boundary */
 static ulong __maybe_unused end_addr_new =
 		CONFIG_ENV_ADDR_REDUND + CONFIG_ENV_SECT_SIZE - 1;
+#else /* ! CONFIG_ENV_ADDR_REDUND */
+
+static env_t __maybe_unused *flash_addr_new;
 #endif /* CONFIG_ENV_ADDR_REDUND */
 
 #ifdef CONFIG_ENV_ADDR_REDUND

-- 
2.56.1

