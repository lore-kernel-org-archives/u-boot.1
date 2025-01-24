Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C8DC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 16:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ADDE80B9C;
	Fri, 24 Jan 2025 17:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MC7ey23B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781F180BA4; Fri, 24 Jan 2025 17:00:34 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8BC80B9A
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 17:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4FF583FB5B
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737734429;
 bh=VaRWMwRBa4UfTeDkz3F+b/TwkYaN9Jm9mtaST/bOs8I=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MC7ey23BAyTF7vs4EvXjvWjTHL1CpB8ULB8aeZaVPF7igRtN8RqJx9iWf6Z4LOdlZ
 Pi3o5Wq+38VlsHFiyaDhAsMISTnNDHrQ5miMlODo0x0N6WDBO8/SpOhyZhJvceRfF5
 P5U1Bk5cQGcCM3lG5PPi4mFJERyyElMcDP8hVPilggo+ddLlgum1+U/CsVbHc3fAqN
 PXSfdi1hQyovrsvy/FzIAwvT2rgiNtGedily4kU5J+yrLJfC+LuH5TQJfFmWq6VHjA
 U8+EYKMkfZIir4TjMnDtw94R1k8wcxdgSFX800jKEBcmMOBiEFRMN0Bro24wOUuY0A
 dVSnCUrUV1z5g==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436723db6c4so15579805e9.3
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 08:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737734428; x=1738339228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VaRWMwRBa4UfTeDkz3F+b/TwkYaN9Jm9mtaST/bOs8I=;
 b=GOYIo/Bc4E0KCYuxwMCjy3MICX24iG0HKaiMn972azAZcgc1apdZrVLFUZBLdLx58U
 iIVHJEafQ0d6XL4/ZbVSbU2sLBudzPaiiLXJUoPuV7MMEbzkCSkjf0RVzFkiYg6IUeVs
 6fjH/zrZrv058RhPT5XGqKuUmVyFHGgvHKbj68SPo4ERIg6Jno+nnflzdkASIqCCy1cj
 L4sDucTYIjvRQggA59b+Wk2u3VHqZxwpP9KgwSop8AmeJSMj3oLJ5k9fYCLXiprkYecc
 +3sJnx/tGVReYe+Dk0c3kaf7VgF1GRUyrT1pNx9XKcbih0g9d4jRNRxsPfY7Vhm6xkcp
 o6tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjhpo5bASzCbVMpZ1PHB+gU8UtZnr0x9U0p0KoO5Tays+3U3+2T1Yl97+1bb1+MV5hS9+1omw=@lists.denx.de
X-Gm-Message-State: AOJu0YxWuxBrwQR5Lx3n/ZU0oHNHsVYaGxokgPeM3K4IYInCql1zvPlj
 ppo9G76l8r6OIdPAWYLakkl2mqS8Himevg4tC3j0fbBeEASMiKz96xOuQi8mAP7vpNM+DZOpAFj
 KBHSQDj73xt5zaWQMOWTatjb08FaH6wRJ9uqCwCmmp4z8Tgei4MILbW2RsBiMzNQQTFw=
X-Gm-Gg: ASbGncvERcmdhFSd1vGjZztr3WbtXmdb/jh71NOWPthXoA5SgnuOnPutKFogdx8wBSH
 AgZ3puN+GvQWsWvy8u6k++V2XvoKOr9eIhNiiyrmYIz8u5u2XDXQ0cPKAUM0RpO69wwHv1Yrk04
 0bKQJMAXXdSKscUa0EMMI5uDDCz8+qs+H3tUFX/yT0oamGLLW9z0mROBuUNal+5LewWhkCa/A49
 iegqyddAGekQUIs7kqm4t0d8kee4qoUq3xVyCZdDCRSCHNYNN+UmfieglicOtG/7GhzlLxO0fhn
 vIHx1HuGu9+wcWU3FfH0Uvr754rfgbMYPMABNlyiF5EetweW2XwcChwR6ZDLXKrRBuElvE2C
X-Received: by 2002:a05:600c:6c06:b0:436:e8b4:36e7 with SMTP id
 5b1f17b1804b1-438913cb191mr270562705e9.8.1737734427129; 
 Fri, 24 Jan 2025 08:00:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8j87Xl8lXIcgfS/Rj9slyOuAr9UrIgExtCDvBmVK7zyJtxY5QoW94IDkUbQA+ELCI+9sftw==
X-Received: by 2002:a05:600c:6c06:b0:436:e8b4:36e7 with SMTP id
 5b1f17b1804b1-438913cb191mr270562475e9.8.1737734426763; 
 Fri, 24 Jan 2025 08:00:26 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b16ff659sm66507615e9.0.2025.01.24.08.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:00:24 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] cmd: sbi: add bhyve SBI implementation ID
Date: Fri, 24 Jan 2025 17:00:14 +0100
Message-ID: <20250124160014.158629-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Bhyve is the hypervisor used by FreeBSD.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Fix typo in subject
---
 cmd/riscv/sbi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index 5ecf56781c1..b013c8c8d4e 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -30,6 +30,7 @@ static struct sbi_imp implementations[] = {
 	{ 8, "PolarFire Hart Software Services" },
 	{ 9, "coreboot" },
 	{ 10, "oreboot" },
+	{ 11, "bhyve" },
 };
 
 static struct sbi_ext extensions[] = {
-- 
2.47.1

