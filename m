Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89546E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AC2A807EA;
	Tue, 24 Dec 2024 17:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CmJ292WD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 630E9807E4; Tue, 24 Dec 2024 17:01:40 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39708801F5
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d8edad9932so35055776d6.0
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056097; x=1735660897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBkE5FBBkp1ejnZqi2Ryy2HwJLGOAxz8NcBPmAsmVzs=;
 b=CmJ292WDOBTI1p7rcR1cXsdFHzNK3iGap4tgGH2VrSWbfXyMW4Gr9gaZkzgy9N1a3h
 F8vpuOldpyhsE1rQcUQw/2fSMtMua/MCKnF6kzdUYFPicYKdQiokluUu3HXj0riOVth8
 yCXRrlwK3AoxiI+XNNzdNhs+I43c0c3ljKrn5DfrNvGrcZyXcxh3dx3YZfqmIKgXXuiU
 9qem6EfXjQrmzLzj0tbJ0NZxqTx0n+l7+FJ5Efm29Korm7vuzFhdcmIYSvirzN27QpfB
 YcdAXo7rI14zNMS1+vYCU1mASv8GozTeCKRFYvZYf85+F67YTSQ/noOUW5GfsYcJ1w0I
 Gujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056097; x=1735660897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBkE5FBBkp1ejnZqi2Ryy2HwJLGOAxz8NcBPmAsmVzs=;
 b=ELabxTW/H3vDS0BhIloa3LJMGYpL10yx9ORL3xekMQsyDDXn35iug7ctovvK/7hy/K
 lWFJOt9GaQg8kiKBd9I1rfFBRcxxzVY26XxTWWV7a0WRe0nc+R6GRjyRY84qe61TiLxV
 uWNvHmUGX6lDVEl8nL0xmejyd2HNGCFQx7l8TU5KSVb6Je4Zvi1UYCTTCuAqfRYSNXJR
 U6zZt04JNM8z0++sWQNBhrsaJuB3n4NaTcmtUOm33uDUiwmnTqydpHPRrppZvQA9DTgf
 7g2QEsSwSHjJJevq0joifQFcUBHSTRwQtONT9b7OYHHuTs+d3aAbKWKJpKASeCxjtZv5
 0ppQ==
X-Gm-Message-State: AOJu0YxmUfqvrDLOR4PMSi1q13t37cnROpU1TA94oWAXPLdKa6zKi/t3
 s0F/WqZq0RXhL4g0wl54svlGSHpWDagzCas13mtvJxPl9H129mDMFHuXDo2oTnR336aVNXjK4OU
 J
X-Gm-Gg: ASbGncuwMjJfOFmpJVVYRExo0xmmQapSexKZcdQtpcbuiZQWyEhJtUDbSNen8UjArnr
 Uqkrq/gHJniA27SmC2AMo+hRnWWW5BupMSxDatzA6wtJ4Rkr6zk/drDMMtR3Rj/6D86HGex9Rts
 nVpAmJm/7A2HvJEWRICjOFPorhPM3HTKyi3YDN4Bq/3p7ghF7QpHvxHhNVA9cqdkVCyzk4r7usw
 O24iNQsz5H60Cj8fcJiwiGq2LyoX931KL1tCwNIVOw7fS3Y+h7fl8H6+J2UYMoy29y/YGu5PkyP
 G6dkSsf6Th4fx8/eRjKheaM+45nXwa7veAHUSR8Mh36r8KEz3aBzUtY=
X-Google-Smtp-Source: AGHT+IHBJCrZzP8AMjn4Q7EWaV9wJK6ylvtt/kGz7GYTtI0Td7PRmbJFG+LI4nsgIQJlYIoT1YLS8w==
X-Received: by 2002:ad4:5ce9:0:b0:6d8:9c92:654a with SMTP id
 6a1803df08f44-6dd2331e946mr290512796d6.10.1735056095176; 
 Tue, 24 Dec 2024 08:01:35 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:01:34 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 01/11] efi_loader: Don't warn if the TCG2 FinalEvents table
 is not installed
Date: Tue, 24 Dec 2024 08:01:03 -0800
Message-Id: <20241224160118.675977-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224160118.675977-1-raymond.mao@linaro.org>
References: <20241224160118.675977-1-raymond.mao@linaro.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

When the TCG2 protocol installation fails, we are trying to remove
all the objects we created in tcg2_uninit().

However, there are cases when this function runs before the config
table was installed. So instead of printing an error unconditionally
check against EFI_NOT_FOUND and don't print anything if the table wasn't
installed to begin with.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 lib/efi_loader/efi_tcg2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 572c6b5bf6..a15c73162e 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -791,7 +791,7 @@ static void tcg2_uninit(void)
 	efi_status_t ret;
 
 	ret = efi_install_configuration_table(&efi_guid_final_events, NULL);
-	if (ret != EFI_SUCCESS)
+	if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
 		log_err("Failed to delete final events config table\n");
 
 	efi_free_pool(event_log.buffer);
-- 
2.25.1

