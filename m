Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D47E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5542780391;
	Wed,  1 Jan 2025 23:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YnqnjSlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8313680431; Wed,  1 Jan 2025 23:16:35 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4470880040
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21634338cfdso211838115ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769790; x=1736374590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23YwHGrFKDyVT4Hy6rqqwEOLTtOqpW6k/K4epKNHBk8=;
 b=YnqnjSlZcddt0YRdw1KE7YK7cWc18lFq20EzWB7xzSDKfUpxBDgkaeAWDqtVpgTW+6
 m7FqvaStj2HY0Kd+Goze6DP88HMbyywO2HvuZ2BttQ3f0bP9zbDrv5AQ5sm5iX9Og1Xg
 eB0exA9/Pldzvhp1pKVbxGSYgNDkDWcfXPH/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769790; x=1736374590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23YwHGrFKDyVT4Hy6rqqwEOLTtOqpW6k/K4epKNHBk8=;
 b=jDIYVjlxrcqj1sDyFjK4mwCxoyGdZjAnYCptJz63nS1LPwftwFUe/2Fy6ItQAfiKLB
 Czti5qcg5kAJakAAR9uXsaNWJXAntEG5fYrcu84qD+SCh/w66xAytD6kVPpFQz/4MlKT
 ouB71Vwijl8Jh7B4RRs0tVXUsEG47poZZwHlseujtqH85UuPfa2nFpzSiaS2FA6ixuUY
 jQN/oH6nEv3DzZss1I3WIc+y77SAYWJp5FFn95WWlJkC5LdLSS0s+OmklN6TxlBwORoJ
 q3BgtA8llY4i2w8FO/DfqaVPhPfXfdBA3wZRYIRcFbagRuI4fWF6g8L4S5Un8rLCplh/
 eCnw==
X-Gm-Message-State: AOJu0YzqIGoGQTddqwjp36tX7ho2ls3nemza1CetGKEHTv3ANRBi0dNc
 WpsCQsFX8eX/khPC7Skzon3p4d25kYou5pXjXoeGFbm/1U98YMg3eNogknPZxG1V4S7TddEGhjo
 =
X-Gm-Gg: ASbGncsM28nMo3JjNHf0Q2OPhYy4tcm0sd9jggsi92wCTh+4o6AtcDwT24kJhO+TYRw
 2FpiR2gdf4roJWIXEWL6d5N5YZ883PYiF20KxjkTeVGXbuA0e4qXiCH/zcurq0k1aglrgyhKlKM
 IRb5CZQ3DH8mKBqp6aOEFVQwPGgGsUwTUEv8H4cIsUQGS7kwe1a9kjGp33wyRxmkyW6DTgf77rR
 Dl6ExiOXlhBg0EhJ9iI3wKNR7X/nePyIwVHYntOQNLtVth+eR6iJgI=
X-Google-Smtp-Source: AGHT+IFnll5rfvtjhwOWkPHNnSyKqoqCBsU/KDoKERheGLJN7RcYxs1hZoVhJIKNjTRTcHgSmIW/2w==
X-Received: by 2002:a05:6a20:d80f:b0:1e1:384e:20f1 with SMTP id
 adf61e73a8af0-1e5e0483c2emr74894758637.25.1735769790296; 
 Wed, 01 Jan 2025 14:16:30 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:16:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Matthew Garrett <mgarrett@aurora.tech>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 31/67] x86: Support jumping to a UPL image
Date: Thu,  2 Jan 2025 11:09:17 +1300
Message-ID: <20250101221003.1944600-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Add a function to allow x86 boards to jump to a UPL images. Currently
only 32-bit entry is supported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/bootm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index bbd8ee7870f..e7a98bf1590 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -283,3 +283,14 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	return boot_jump_linux(images);
 }
+
+int arch_upl_jump(ulong entry, const struct abuf *buf)
+{
+	typedef EFIAPI void (*h_func)(void *hoff);
+	h_func func;
+
+	func = (h_func)(ulong)entry;
+	func(buf->data);
+
+	return -EFAULT;
+}
-- 
2.43.0

