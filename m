Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D32C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD4C874A5;
	Thu, 16 Nov 2023 05:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g+gEzQKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F440871DF; Thu, 16 Nov 2023 05:11:35 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6F787251
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35aa6107e9fso1645275ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107891; x=1700712691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fj6shKhpz4/tsmBbDAobzSmzgNnhH9gfqNmbBlHOsBk=;
 b=g+gEzQKYNG+QkpNePch1YaK3+oKyYg1aMbHpPTFjWNNNgbRShe319CeLu5o1jr77XZ
 DYhDn4FqmPIWQ/vR7tLVBuKJE2t2hvclZ2AI5MErB2YIHICL6flsu/Fq7GLXdtsDwv0g
 LaQ6dyzO34yfkq+5h9zZyMMFFPfU3hqeJJHuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107891; x=1700712691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fj6shKhpz4/tsmBbDAobzSmzgNnhH9gfqNmbBlHOsBk=;
 b=WDbmguNZMat5n199QD3710H3f/Cuh5magMaauBD5j0jVGxGkvLzE0P4kJAk4JbEsbN
 jAUeqFMb6ty7PxuWI4Svb6JB4xHi4Ty8UHTRXk5ZLT1MmSWjoAuWObkBSWSIpl2oXWel
 jx3Xl36pkaALHmt20qun7c1jIIgoPQAjead6Bw8LyyFJnK6iM3FljOAOYstKBwsIHHt6
 Sw9KqPT1jiH7etEDSt8r6dSfAyV1LPKHQO9ogO4D0wXSz8Kwh1MpPjS4m50wOkBX9We1
 Ly+5kg4H/LLJeOznRfINd+YgaYoy2mlEACxANL13HAHkdPKyAYzuuKExezGN1nszxFqW
 Po9g==
X-Gm-Message-State: AOJu0Yz70rGA+EY6efspr4J/P3JRH8N8Y6S2jqgTX6BkPJbprhju6F9o
 UsU5gvxkjc4S3J8JHzoKmjGKUw0dzlq5AqEUascU/g==
X-Google-Smtp-Source: AGHT+IEzbGSYY1dWL0U/HYsot4r4jTmqP0TqSUTJdMPmtbO0LmYnAIkZhvlDS+PCY7QPKNJwzgq+RQ==
X-Received: by 2002:a05:6e02:18cf:b0:359:d24d:6274 with SMTP id
 s15-20020a056e0218cf00b00359d24d6274mr20137985ilu.0.1700107891625; 
 Wed, 15 Nov 2023 20:11:31 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 14/32] bootm: Adjust position of unmap_sysmem() in
 boot_get_kernel()
Date: Wed, 15 Nov 2023 21:10:14 -0700
Message-ID: <20231116041043.362055-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

These unmaps should happen regardless of the return value. Move them
before the 'return' statement.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to adjust position of unmap_sysmem() in boot_get_kernel()

 boot/bootm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 1f3a01994cbe..6ed60bf05084 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -222,12 +222,12 @@ static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
 		printf("## Booting Android Image at 0x%08lx ...\n", img_addr);
 		ret = android_image_get_kernel(boot_img, vendor_boot_img,
 					       images->verify, os_data, os_len);
-		if (ret)
-			return ret;
 		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
 			unmap_sysmem(vendor_boot_img);
 			unmap_sysmem(boot_img);
 		}
+		if (ret)
+			return ret;
 		break;
 	}
 #endif
-- 
2.43.0.rc0.421.g78406f8d94-goog

