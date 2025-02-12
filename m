Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0A6C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 553D980C8F;
	Wed, 12 Feb 2025 23:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cfHpVQK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D3480C8F; Wed, 12 Feb 2025 23:23:38 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2F21801DE
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4719141e711so1943011cf.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399016; x=1740003816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pRAtD0DHEaZ6Re/3cUcryapF6sdXaxWs4Po07/4e3dE=;
 b=cfHpVQK3OhWSh6iQfci0La8iuWYTmMioJe/ZmhBbJvzyTFiq9pnzIL85kZ1jRMN8gr
 KHubMTA2XHp4rjYDqKYYIcgr6vQPZui0kUUPgAezQgHYy/EQq7+90YRG3D16ysFtz074
 bHamTo/qEPGq4aemjJPr7SaqUtWlfuNNA1Ufs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399016; x=1740003816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pRAtD0DHEaZ6Re/3cUcryapF6sdXaxWs4Po07/4e3dE=;
 b=wAkb+X6Zz3Zb0sDJ6B9w5G63/0RlOgKuWdTYpUJ+Vtzl5YlXa0BMiwNV1WSMeto/4c
 muX85iT9hThy2SrdfyZsKLk2cv0JJS+6Z01fNuqxj/WBhjUywUTrV4IWn56S1UFxeOfC
 578KnMlhseCVwxXgL1UM1ZBNG5GBBwcTts+q8O1C2mkpQrALYNwJmp/Jqv5FVrh8ZM2W
 nAaxiQFvRUSeVQpOGE8bteKbcZN62oK6+sdGk7ajvXc04ynXNO6IdfIr9PGPMkReCLCC
 r5EOxN0Es7pU8T3My4K2UkqwxmjhicNhaxlDdUgTMXbrIGvHkeYhg5zeEr5Dj4Ghx16S
 bC1A==
X-Gm-Message-State: AOJu0Yw3zp1EIPC/kmqlyq/Qa4zEC0OEB85WXX7FAvSCwdwIsGwvviMc
 956gSKCrDs2d1Z7l9Es0r8gLCPYivpKFeOIdJhDn3nud/53yJfEOXoB6UJYdLbtC37B792xXmKb
 f
X-Gm-Gg: ASbGncu7Ju2JgwW4Pki86BLe+BolEGjL2QEk+PnQHrptUWh1Mm/noufFCRg4AhrN/li
 dfimvJ/YRcOSElezP0rQmyBlOm9GYJsNMJYjttH6NN7Uy5nWGTDdcrsbWM4gDWEvIOcRIcyzqjE
 huVJjemjD76Yzwl9aO32aKjPWSO6n4Du9i9qnMASMHGIh2NtEf3+miYHtWkVWDOUi5Y6XQnt6Bd
 loCwNaKuafyEMo7XEEapGe93eFOpaqmtvgPkDvrRtmGcRMq/lpLKf8CdRACtl8+2hYIlMtRSwPD
 5ufLbp088c8UIdsnhQ==
X-Google-Smtp-Source: AGHT+IFG+MhWB1ikCiaLqK71dV4MuJvLx9Ym3l9YtoBIChCliWJiSkbVLFUSoXqYEl3pQalkxFn6tA==
X-Received: by 2002:a05:622a:4188:b0:462:ea22:33bb with SMTP id
 d75a77b69052e-471beda703dmr24574921cf.38.1739399015706; 
 Wed, 12 Feb 2025 14:23:35 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471a13c190fsm31879101cf.60.2025.02.12.14.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:23:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] tools: binman: ti_board_cfg: Fix pylint error over 'br'
Date: Wed, 12 Feb 2025 16:23:33 -0600
Message-ID: <20250212222333.684437-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With a newer pylint, we get a warning that 'br' could be used before
assignment. Fix this by declaring br first as an empty bytearray.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 tools/binman/etype/ti_board_config.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index c10d66edcb15..cc7075eeebec 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -119,6 +119,7 @@ class Entry_ti_board_config(Entry_section):
             array of bytes representing value
         """
         size = 0
+        br = bytearray()
         if (data_type == '#/definitions/u8'):
             size = 1
         elif (data_type == '#/definitions/u16'):
-- 
2.43.0

