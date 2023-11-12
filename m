Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1CAC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7345871DE;
	Sun, 12 Nov 2023 21:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fNyYeePy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A33587134; Sun, 12 Nov 2023 21:55:28 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82F186FBF
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7b006f7c473so85282539f.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699822521; x=1700427321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q31TH1vnw2SRBF4s0oSTFUg/hthtPoEBxtS6TzrBBEo=;
 b=fNyYeePyVaiROrAcs7Bg13j6x46p9xywnNXyG4LDzKL3jgP5Wbj/KLH4wTo/xYPcxm
 vKbZ/i9x7bMwmW8LXLyL2c57U0G9HLOXmQAuIFLGwR6E+ZU+knB9RLn++mMfVUCBHhB2
 tOYwoqwt3BST3nZbF5fk4j20Krwus7y0ZR6JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699822521; x=1700427321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q31TH1vnw2SRBF4s0oSTFUg/hthtPoEBxtS6TzrBBEo=;
 b=f1oKGxNe5CgeSruwYM9Sa5KaBThBoerD1cIjNMtGkQc3tbc+mHdtYKICBdYl6LCuTq
 ZtPlYw8CvlnufiXnN95hjsziZF+qOX+DMeH0hOH9VrdqlUpvdJi3j2AziaEq4ORajl4U
 RIVt/K5aec6B5MFHj7bfwVq9nalpBkakAxKrEqNULYey2TEaYqEf9/ygSMIsQwQtlrLT
 j7FPhE+KHRaMYCgbXOXIH7vyNts6TPasYUX08rKID1SyYaSJkChUumZdl6jPEZ3MiGKp
 w+As4LSYYN61OTvf5/mxYnX6ulHyHZOjbvvzK3NPyMOEaL9mBIWUahF6SbhDy9DbHJL9
 jr1w==
X-Gm-Message-State: AOJu0YzLxayxw/baX9S/6GYpRIi1QUBs5y+7VHJbspe8oGtR/RoyprEg
 QXvAewaVVgHkZoi0WVkR4+w10s8Tvntyk2vRbyKLFg==
X-Google-Smtp-Source: AGHT+IEgrGkxod9LAhWZaQY48TsHJ0MifGKbrLhn8rvv4ANxFS0cjqfm+dO+Cktn4QjdiXhjoq1FDA==
X-Received: by 2002:a05:6602:13c1:b0:794:c9a2:5fe3 with SMTP id
 o1-20020a05660213c100b00794c9a25fe3mr8086277iov.4.1699822521424; 
 Sun, 12 Nov 2023 12:55:21 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a056602210c00b007b01c6a57d5sm1079641iox.15.2023.11.12.12.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:55:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/3] efi: Correct display of table GUIDs
Date: Sun, 12 Nov 2023 13:55:10 -0700
Message-ID: <20231112205516.183410-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112205516.183410-1-sjg@chromium.org>
References: <20231112205516.183410-1-sjg@chromium.org>
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

The printf() %pU option decodes GUIDs so it is not necessary to do this
first. Drop the incorrect code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/efi_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/cmd/efi_common.c b/cmd/efi_common.c
index f4056096cd3f..1aa2351fcdfd 100644
--- a/cmd/efi_common.c
+++ b/cmd/efi_common.c
@@ -17,10 +17,8 @@ void efi_show_tables(struct efi_system_table *systab)
 
 	for (i = 0; i < systab->nr_tables; i++) {
 		struct efi_configuration_table *tab = &systab->tables[i];
-		char guid_str[37];
 
-		uuid_bin_to_str(tab->guid.b, guid_str, 1);
-		printf("%p  %pUl  %s\n", tab->table, guid_str,
+		printf("%p  %pUl  %s\n", tab->table, tab->guid.b,
 		       uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
 	}
 }
-- 
2.42.0.869.gea05f2083d-goog

