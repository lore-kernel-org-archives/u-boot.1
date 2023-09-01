Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24255CA0FF6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B9C866CF;
	Fri,  1 Sep 2023 22:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xrsa1hW9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C01B8675B; Fri,  1 Sep 2023 22:04:20 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64F5867C3
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso2039562f8f.3
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693598657; x=1694203457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/rN6hpA6RUR8xcynsTbN4wgdal1KH5zv5tVJu4j/8A=;
 b=Xrsa1hW9QDylK58UM3Kq5h9R2e0+KmMUHuN4+X8kcPf9i+28tGpZOZ9vhtXFPmAbSt
 rIHbWDa+N9fioVonRSu0jW/X+BrQ09lIyLUb1pxBcGfyqsSOI1Q+eglFnGe6H2UbCLuH
 slnMF4aGNf5PIBv/NokigRs3K3w8SMP70t9y6heXgXrT+RSJjtmSx2BX4bQILEzs0xtO
 +0RBArOotCcZ4OvbpjIhNeEPZWxOKD1SlA0wbXe9DFgmnlioyf3xOLgatcTK296c4VCR
 O8mm4oe08eyl0DwIA8KRF5Jv5oWcr99kiMZe3DJcfQ/9OgXSq6rOi/gfx8TccQSeOMzq
 3zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693598657; x=1694203457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/rN6hpA6RUR8xcynsTbN4wgdal1KH5zv5tVJu4j/8A=;
 b=O4ywYQMAM85YXOuDw1ArT0KHc1m5oTBXpvFAxUgIbzyGsM1GiSNK/tedhBB/5iJg+g
 DnJwdunhlfwBPBTBsH8fI02barOzYfQQ/eSuL1k00zaAs2XiqT57kN1rSCsG2YgijL+9
 zR261AL2/EUu2BpsPWw1HhK8yafFqGjhlw3yWVDsjgWV5mUtaCtjlrYmLgYFlnYLcD8N
 g/dqHL3KhHifc+sAzLxVeAVV2bIJxWoomWsWDLlwN6zvPzxyf2E1+OnfApb9Mn1Zri0v
 ca12zCFEK18L35pSSfve8CVvXQIVY+6LfZQejMo9brSgNT40uyOJls1vOpDXPOMo9hDB
 9I3A==
X-Gm-Message-State: AOJu0Yx788S6Esu4c8TKUYBRYPWtjnH6YRbD8qb+u0qbNQIvZwdu7ryS
 oTr9o3KXnPf97Xm0LLTImDgNcElWuWk3CRN6
X-Google-Smtp-Source: AGHT+IHHYaK+2olip5ZQujXX6CV+4Wry2TEBU6rSnexf8msxHGfAuemJ9h2P5s67ZRRBoxHn31fXQA==
X-Received: by 2002:adf:e50e:0:b0:319:6e3f:d5f0 with SMTP id
 j14-20020adfe50e000000b003196e3fd5f0mr2599476wrm.44.1693598656960; 
 Fri, 01 Sep 2023 13:04:16 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm6207849wrr.82.2023.09.01.13.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:04:16 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v2 5/6] .gitignore: add compile_commands.json
Date: Fri,  1 Sep 2023 22:03:52 +0200
Message-ID: <20230901200353.90290-6-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901200353.90290-1-jmcosta944@gmail.com>
References: <20230901200353.90290-1-jmcosta944@gmail.com>
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

Add Clang's compilation database file (i.e. compile_commands.json) to
.gitignore, at the root of the repository.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 002f95de4f..261a1d6754 100644
--- a/.gitignore
+++ b/.gitignore
@@ -109,3 +109,6 @@ __pycache__
 
 # moveconfig database
 /moveconfig.db
+
+# Clang's compilation database file
+/compile_commands.json
-- 
2.41.0

