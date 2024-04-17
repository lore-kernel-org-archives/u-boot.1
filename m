Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DFCC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 16:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAAF8841D;
	Wed, 17 Apr 2024 18:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oW8SDAcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98B988456; Wed, 17 Apr 2024 18:01:39 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0268828C
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 18:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6BD84412F8
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713369695;
 bh=NychibhtYgs6jaijfvz4MGH9KET+Lm4BjWHNN4mh0ZA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=oW8SDAcEmWgqoE3iKBZL2ko0UZoCVPSMprDLwnklMywYh7ksWvttlMnFxM3YnXpKD
 1nIedhtHdnW61SG4KjqvlvYvu6qz+3OES6knD9epiOY99RO1QJFoUr9+9H68Zngacl
 bcPKsRF0lhF8cW3bBjW96isA8h5AS6K0lj6pWY7E+A/d6OI+xNhvrLAI8PfFvY1D55
 ttlbcu3nXY+nXZOXKiughZHKMxPolRUZuvMJ7vis5JyKgsRui7ugQBxN6Xcf/kvBhI
 VynRtMiTJLJk+/h67YT4IiBkG82VFY+4Z+eDgnRA8rw5uvYCcguvdufZvSEykYc8iq
 cn4LUGRo8opPw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4187fb76386so11009615e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 09:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713369694; x=1713974494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NychibhtYgs6jaijfvz4MGH9KET+Lm4BjWHNN4mh0ZA=;
 b=XHv4/ilhB6OZDEkvS135X+SwkAZ+9DMk0QOYqvS4ESVWc0gn+bouYUFTQJxCrNvXJF
 w+gx+2XxpMYwxJvc11tSiSGSdERZxwb24frKcED6BzI5CWthYA5x1QpPe9KtY8v4/TQk
 Y841Lq13H5Pr3P6L3Mt03LTD1AiQUiUTGgtt9MW8+aeSP1iHl3f8yBp4GpzPZ4a9t4Tw
 pNGGEjOZiFewa4KjNZbCbCdFO49ijUc/1gYDHQyd4S4giboUz+qTxw2E0v/nRCcdUXHQ
 /nospHE4mQh0E7XgO8Gd3QC3J4RC799ucF/REfah6smqGTIbjqFgD9oB/+SJJJNHn0Q+
 7wIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnF/HmfK0N54OFTJxMdNK+tto+wCYEKJ7oYsHM9bRGwwGRAk/qvZKcPfY77/ExDIW592mU7ZHj9nCBESNbERe9wnfs2Q==
X-Gm-Message-State: AOJu0YwlfKrBWw09n/XnhOLKsrK+UNogrPv0LEAjuIAFZNhsCM+KsfL/
 iZJtYjuDQ95UEjhRNbwwkF60NsjlQJB8QTUfGqzJ64ARelEFhPUBJATpPpLBJDI8VgB/CQkUq3Z
 9AFBkfrx9G7mjkuVWp/J27VzlLnTveQS1glU41FRZDRzZOMeJRxFT+M+wC4RE/U+/YtI=
X-Received: by 2002:a05:600c:3486:b0:417:caa8:c3f4 with SMTP id
 a6-20020a05600c348600b00417caa8c3f4mr22485wmq.34.1713369694516; 
 Wed, 17 Apr 2024 09:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp9ayy7eECciAO9jvjO/zcuuP5uOJvS5P7523mLgjWe82t0Ilu1nRWZOxsZRGTWY+Itttgww==
X-Received: by 2002:a05:600c:3486:b0:417:caa8:c3f4 with SMTP id
 a6-20020a05600c348600b00417caa8c3f4mr22461wmq.34.1713369694103; 
 Wed, 17 Apr 2024 09:01:34 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004169836bf9asm3301359wmq.23.2024.04.17.09.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 09:01:33 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: eficonfig: check initrd path allocation
Date: Wed, 17 Apr 2024 18:01:25 +0200
Message-ID: <20240417160125.117405-1-heinrich.schuchardt@canonical.com>
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

After allocating memory for the initrd file path we need to check the
initrd buffer pointer is not NULL.

Fixes: 87d791423ac6 ("eficonfig: menu-driven addition of UEFI boot option")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/eficonfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 8234e602b8f..0ba92c60e03 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -1419,7 +1419,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	}
 
 	bo->initrd_info.current_path = calloc(1, EFICONFIG_FILE_PATH_BUF_SIZE);
-	if (!bo->file_info.current_path) {
+	if (!bo->initrd_info.current_path) {
 		ret =  EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
-- 
2.43.0

