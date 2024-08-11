Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD48C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 09:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA3F882EF;
	Sun, 11 Aug 2024 11:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GDvaa/tn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D8C18837D; Sun, 11 Aug 2024 11:51:21 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A35688247
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 11:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 68F583FE08
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723369878;
 bh=koh1s8bUP1ZYv4sDwwddatU7A641C0SSK6wC1k/DkXo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GDvaa/tnDsRuQDEhl45YmZtoNQaVzns/UxsH1NHfibCHy2tqPYkMY3VE4Ah2pWAuH
 bE9WlqIdLxHJCK5I2PwGVxVWmYnfag7QvoLnF7eaPF/yj+8BHmHpRTV+h1JYMMtFaC
 yiZqoDxfSpCkeeEjBtOl4fSbUnCyg7UABacDtBbFKC1er55ZE/YV3GxYnFCn8IHWL2
 2YFYETE/uZlAYzX6JiJh2KgBJreHdKB/anq541PiITcfJqZa8+NFSbif2QtI/GWCX5
 ewEgTzfeT+FyaOM0tuU/cxpplLryBKZi9XJnr2jr3P3a0MHLD3YDRWjue/0RECidPT
 wg+XSNRy8iPLw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-428076fef5dso25740195e9.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 02:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723369878; x=1723974678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koh1s8bUP1ZYv4sDwwddatU7A641C0SSK6wC1k/DkXo=;
 b=U2RTyaaqToszRy3y7RjLWYJZWr1DQkLioODSwejSyX3sgIhrDeY6AQTmcar8RD+2Mz
 Gi9lJc2uEjesJ2kBo30HBWXzRm6iiLVZxNKXbxxU8HVLE6as74B2eBfAWakcozs+fwjE
 9deMsxSu/ZBd19coGYkCydKQQWsPhB+LSywhhySnSXz/lUJu5cnOiFbsoxWqrOaaAV6h
 PhCXfaZYImMrO2mXGqFeN1zB71S6ROheuRU4okq6I709dq1WaePVaOlF50+9vmH6NvWf
 t9fQSS99e9XJ2hFZebuGjtUL7WzbzNLAteeQpSK5gimzcEUvg3hdjV8cWZOuWcMPbkUW
 UT4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgYup+Llmj4msndw/anlcH1iEv14HLc6sLPF0R8g9ATqY/xipAi/RDiR5saEMsonm0jsWTaQtExMbWDFDHkFjliOqesg==
X-Gm-Message-State: AOJu0Ywmhrxlk/cEImjEfeDggZfPVQxQnedbG1/XoP6m1W1/KAjsdBxm
 C6hYuIHCZlJ43D4pomSMTsoaA60EBFZscaZf3njWzD/RbMErzRXnMxukhMzpH55uTYsXFdGqot7
 mSAyRtm7qkrQ099zEQbCwS15XcCkfQpFu2ax5H+NCdMQ/il45vTssjyo59Q1jHGsmcbWAKUXzP5
 w=
X-Received: by 2002:a05:600c:1da0:b0:428:16a0:1c3f with SMTP id
 5b1f17b1804b1-429c3a5a6femr49007025e9.32.1723369877857; 
 Sun, 11 Aug 2024 02:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDfbqExInwBzuEIp3Jp8445kpV2QPJPg7oHGEEp4vN0dfshLMy1qW4EoITBdBKEusNjtGqvw==
X-Received: by 2002:a05:600c:1da0:b0:428:16a0:1c3f with SMTP id
 5b1f17b1804b1-429c3a5a6femr49006855e9.32.1723369877378; 
 Sun, 11 Aug 2024 02:51:17 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c7734595sm59455215e9.36.2024.08.11.02.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 02:51:16 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: CONFIG_SPL_FRAMEPOINTER must depend on CONFIG_SPL
Date: Sun, 11 Aug 2024 11:51:09 +0200
Message-ID: <20240811095109.59526-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The CONFIG_SPL_FRAMEPOINTER symbol is only relevant in SPL.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa3b016c527..4e228a659f2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -133,6 +133,7 @@ config FRAMEPOINTER
 
 config SPL_FRAMEPOINTER
 	bool "Build SPL with frame pointer for stack unwinding"
+	depends on SPL
 	help
 	  Choose this option to use the frame pointer so the stack can be
 	  unwound if needed. This is useful for tracing where faults came
-- 
2.45.2

