Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B80D6B6D4
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 20:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D33C8924B;
	Wed, 30 Oct 2024 21:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DQYAVZyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5809289250; Wed, 30 Oct 2024 21:16:16 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A23C89245
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 21:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3DZQiZwcKBv4suxoz5lmuumrk.ius0-huuzroyzy.jkt3.jk@flex--moritzf.bounces.google.com
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e3c638cc27so3741037b3.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730319373; x=1730924173; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JYgVz8i3swgXv4Uox49Hg9+wEMWNZcNYPPEqLG8uH2o=;
 b=DQYAVZyocFwqbkPF3LM5WX26f1fskGDznIag84vqqMj1CsfT6PsCuoKiiqIUm+ZWvK
 n8Grq7O5FiVgj0inuO399dnSPXrOuVTD645Yh0vJ8YsM3Y/SfeUmxw815RywHPd8T8b8
 RPd/1KC2n/WsfmcGwJXjguh810lJCLxucMGNMwS2dZ41sVPhLmmnB/mV1g4p2ehhaC+F
 8DmfVlNZoMgZV5y9deC1uGrnNU9qwZW92+MVG47C9RtqxAqS5FEmGfChnDuwBuBAlrfF
 YI5rcDzuRak6xnT5x3MdiRf/QsnxrjuNz6syD/77SYc6ZwpMy9VEog8GFZ6J6Cg7luzs
 G1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730319373; x=1730924173;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JYgVz8i3swgXv4Uox49Hg9+wEMWNZcNYPPEqLG8uH2o=;
 b=CStVaaJKbAMxBk10QsxDVfB6hRCDXog3O5xu/qDZxqf5vw0dWnsEjHAsduE6uZutvN
 qeedMkcXtqCcdXPizzeGwuhNzp0+lnEIwK+BeKY2bmH9dKef+YdwnnW1FVbDMIRIn/tb
 C04pbxnM+bqJ01T+x3P6UIjTNbU0uTG+MqcOR6RecgEyhm1dWPR2FZ4uI8pw1mInd96H
 WU2v7YnTePwMVGT1qBseQgA59zrWkHupPIAr8ZT1GZQoON960KS6AC+JcmPk8R8w4Awq
 0f/s8eEWO0lcC3/LyBA8+V7lbJS/PHnKTF6WEpvlQFWZIE9aMQK+/bndJA5iruIvGxJV
 SjJA==
X-Gm-Message-State: AOJu0YzSj4rnIrIW5fRBnUARXqC2WztpsJ1aDBAkYOKWecreew0YLxNl
 X5qrxZgJ/bOGs73cT+AP+9tBCUgubB68TvGY+YYnOMJVPwlXyLS2d3eMR28NCisBdPplkrIsgoX
 MahArYGqM7jD+LpLfrZpinGbSRRL0fBvap4aYwaBSP8kKdL9yc5XFalC7+hhwFYG6qhzt+GXlfg
 rvBzUcE+qlphhy/zGFKTV9qxvenN0AaOx2RaU=
X-Google-Smtp-Source: AGHT+IEwrGVTX+6ut8DNj3KSu9ye1ceD+YDHHgkxWRRjxJzNMmvljO2zTaU5/qz+ljNACwjgg1HN1HSS/5yJ
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:13f:f0c:ac12:c151])
 (user=moritzf job=sendgmr) by 2002:a05:690c:6e13:b0:6e3:6597:2225 with SMTP
 id 00721157ae682-6e9d8c2a7b3mr10146677b3.7.1730319373031; Wed, 30 Oct 2024
 13:16:13 -0700 (PDT)
Date: Wed, 30 Oct 2024 20:16:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030201608.1247488-1-moritzf@google.com>
Subject: [PATCH] lib: efi_loader: Fix efi_dp_from_mem() call
From: Moritz Fischer <moritzf@google.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 pwildt@google.com, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The function expects an end address but is being called with
an size instead.

Fixes: 6422820ac3 ("efi_loader: split unrelated code from efi_bootmgr.c")
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 lib/efi_loader/efi_bootbin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a87006b3c0..798bcd6eee 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -137,7 +137,8 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 		 */
 		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
 					    (uintptr_t)source_buffer,
-					    source_size);
+					    (uintptr_t)source_buffer +
+					    (size_t)source_size);
 		/*
 		 * Make sure that device for device_path exist
 		 * in load_image(). Otherwise, shell and grub will fail.
-- 
2.47.0.163.g1226f6d8fa-goog

