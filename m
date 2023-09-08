Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2915EE8004
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2628B86A97;
	Fri,  8 Sep 2023 15:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JBhezNbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B281486A8F; Fri,  8 Sep 2023 15:56:00 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA0D86A9E
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso34855281fa.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181356; x=1694786156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=JBhezNbwc8edQp3q/dG01K5fwSmdwdIEd8roVLwwMGVgnX2p/BpRE8d9/9hbCEzAUa
 /X5cBKzo0GmA0zVAZLTwv/XFzy8szAjH7xmpQLXSd9tS8KP0E6ZrDhIyngQ0WTIMj1A5
 fltL+PHP1lhGDj3iEbQoxxVMmRitgLmRR2NtGW1TVmFqeWerLKQkbM4utuis3+3E0tnF
 aZSlO+/OidUcXhe2b6g+jGG55PdeM0faPfgionMRaXN24ZHT6tNi4kF69vzVgLSEggqf
 BUQiAt0PuQ9c01v+bUB9OYIH/bTJjOIZ8IX8BC43rcdXsXiFNEg5obWxdQxW83X7hMFZ
 BK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181356; x=1694786156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=f8h6zjDijCOKIvqVFJd3XpkxuXTDm5zq5jhTs+0UZdtZH5SqbDWyRu1FgYxiQ8t6Ue
 wrV7gzGaknbGiOI7lJaXTsJ5yn15aOYjLm3Nan8cipfo5msu4FBu0sFYR31SdF+CVFbJ
 LwrzaLJ5XAlDrk1TeIQVJZUqPMdhAFq9t/gpyJnu/1ENk0UF6AAgXncP/PP5PCs48feU
 YPBA6JgOoxFDU1jYH7VzACW0y8SqSs8JWYacSq5jpp8YHPbgl8KfzONFC5nm2RlsKLxZ
 nN9fZ2rIvMZWPlo/KX2z/CUDR+3K6LzeQywBs6BFLtjvUS9IQUp8VHGcJ7+KwVA4DaOS
 7wuQ==
X-Gm-Message-State: AOJu0Yymr0UO9l/yNn7KjtVZEh2AebKV4+eMsL9NPcXhcJbmvHGk/Y5I
 00KQyhYzk+QizLpKs0f2SaQv/8iMZIr/Pm6pz+PFJg==
X-Google-Smtp-Source: AGHT+IGXXoEPl/XZDfWMz3XhLCsYYK+PR3QehfBxlXO/kG0AxExv/iLsZ8w13E8nR3onm7yAExe35w==
X-Received: by 2002:a05:651c:2044:b0:2bc:dd96:147c with SMTP id
 t4-20020a05651c204400b002bcdd96147cmr1826408ljo.34.1694181356765; 
 Fri, 08 Sep 2023 06:55:56 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:55:56 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 10/15] net/lwip: update .gitignore with lwIP
Date: Fri,  8 Sep 2023 19:53:15 +0600
Message-Id: <20230908135320.7066-11-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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

ignore lwIP library code and reused files from the lwIP.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 net/lwip/.gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 net/lwip/.gitignore

diff --git a/net/lwip/.gitignore b/net/lwip/.gitignore
new file mode 100644
index 0000000000..7b5dacce90
--- /dev/null
+++ b/net/lwip/.gitignore
@@ -0,0 +1,8 @@
+lwip-external
+apps/ping/ping.c
+apps/http/http_client.c
+apps/http/http_client.h
+apps/tftp/tftp.c
+apps/tftp/tftp_client.h
+apps/tftp/tftp_common.h
+apps/tftp/tftp_example.h
-- 
2.30.2

