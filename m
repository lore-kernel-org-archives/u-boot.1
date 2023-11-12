Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93013C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA01886F80;
	Sun, 12 Nov 2023 16:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M/hBt7fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B7186CB1; Sun, 12 Nov 2023 16:58:25 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07D686DE0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7a66b5f7ea7so128467739f.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699804700; x=1700409500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfmxvUUnbv3Y1IzzLyigKO+ikMcUQF77bzKVAqOekho=;
 b=M/hBt7fkSap9nkXdZF1VlEXEKZvlEMl76DPMHE84zBslJV5aBBeivgqyPlvSxKTQCt
 C7h805ZwxzB/JCbipuG7m8/7/yx2zZk31d9gzKwptTPWgICWoDerlfwvyZhMYc0rsUce
 0bl9yQObV9N4ZApXNWGuwAL/xynDQoiqvkYko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699804700; x=1700409500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfmxvUUnbv3Y1IzzLyigKO+ikMcUQF77bzKVAqOekho=;
 b=L1ZFyxQ+p+LRwi7omk7vG65yydHHltMXjZc4MWKpod9ZuxqFsXdqWKIxZ8Wo0gaXXW
 pQLgD3ycs+yqwVcTSfvJLFXjmujnwoFKfYG0cl8gzG6NelRAs7U2fuC96rZi+YvMCxjp
 gloBu8OfgDIhZd3V2JR/Jf6xD4+RrZKkBqYKbRCLAtm8RY73bp8eEWyUHvS5PL72m/o7
 rTyOi0C/8wds5h6ObHbgZ0yeIRl+UNoCBO6WKylqFB6zdKbxlWzRXyLVUH+utKcI/JJg
 m5ahX7A+wFyyj/v2Oj5T8yi1MWC3msByInuSd8OX4xD3Evgjp+L8wqF6OeLUXB3yGXrg
 vIeA==
X-Gm-Message-State: AOJu0YwhdAIIEonXkUIF04Ox6CCEJntNpeAsCKKcE5HnsDWhTRWdgpSf
 mMDpldOFaHwn1JM49jotDA8jsI03leAS/Ni4XUW8QA==
X-Google-Smtp-Source: AGHT+IEavaFeLn/ZNp78P85MNPx6qxJjB8qzCuZ5wlfK6AJYMJbrg+COsmW12B39rZwqBq5Xehrgtg==
X-Received: by 2002:a6b:d013:0:b0:7a6:83da:6dfa with SMTP id
 x19-20020a6bd013000000b007a683da6dfamr4427035ioa.0.1699804700491; 
 Sun, 12 Nov 2023 07:58:20 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a056638348b00b0042b37dda71asm1065843jal.136.2023.11.12.07.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:58:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 1/4] acpi: Use __packed with struct acpi_xsdt
Date: Sun, 12 Nov 2023 08:58:02 -0700
Message-ID: <20231112155808.135585-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112155808.135585-1-sjg@chromium.org>
References: <20231112155808.135585-1-sjg@chromium.org>
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

Since struct acpi_table_header is not a multiple of 64 bits, use the
__packed option for struct acpi_xsdt

This ensures that the entry[] array starts on the correct boundary.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/acpi/acpi_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 1f85de091d39..59ab79ed17c2 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -80,7 +80,7 @@ struct acpi_rsdt {
 };
 
 /* XSDT (Extended System Description Table) */
-struct acpi_xsdt {
+struct __packed acpi_xsdt {
 	struct acpi_table_header header;
 	u64 entry[MAX_ACPI_TABLES];
 };
-- 
2.42.0.869.gea05f2083d-goog

