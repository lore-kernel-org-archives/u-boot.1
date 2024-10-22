Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FB7D3C939
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABE688F6C;
	Tue, 22 Oct 2024 14:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DPnF71al";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1663488FD9; Tue, 22 Oct 2024 14:00:44 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2B988F31
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso6046283a12.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729598439; x=1730203239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PArxYUr4DF6xXohBaBZwVlmXu0h9YpEZfuQLCXw2Qlw=;
 b=DPnF71alcxbHLi9/epv+LWJlHB0YEIqP2mu8uuSDiuuxNx36Pu0g1wCvoevat8Ila+
 +5Ec7IoVhvWfV2kW4qXxfRJtkQ6mhNuLG2rFj0qzfS9/I0Wn7UGJcAiHBcwj/2UM+Ver
 0+vZW8KAGlENAe9hW0meMs0wc23QjA73viFeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598439; x=1730203239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PArxYUr4DF6xXohBaBZwVlmXu0h9YpEZfuQLCXw2Qlw=;
 b=RqryohV46u6byUbBo4LW5dGm9iwnMksndY+UTpyvX8IkOFWaf1WHQ0V51AS3Zxh+BE
 DMlEREmDGT+eopvCqnfTPUefnDCt45EoYy8vL9nTTOWyF5AVOlonIVOrrKAqJysoz83/
 drTWtdPztVVJAnId6lB84h1akfYmLnWAuY+R5m/nc05tZZCZbyfnbjP/grfYYnlBf9Dl
 Bgk6D010mBepxmfFP8yNoj7CbqyWKwTd9vEHXM+oY7CZ9K9yhZ+ZA9F2B1Uja86g8nsJ
 CCSlQochgUSM1a8LO1R0LzD6TB4e/7w1iD7/m1H1zoe6Rx4XdcU9dEbFYTKrQKDAjfcb
 WqbA==
X-Gm-Message-State: AOJu0YwzVNdzXYkuJ9DZMkIWaq0IwcU8X6LgRp+iorKfO8s5qhSxWBny
 0UlZnQHcfZqua3shOK5sarOUpp7XCx0VlvvT5UNvNQo6MZ/D/bpzjmOawnfH704aEc8AKiNm1oT
 yCnUZ
X-Google-Smtp-Source: AGHT+IF0lK+wmGrH8O2SiZgINYYtsS5n7MJpTwDtyouONwMcQYKCemMmWjebUvGNtD6kCY7QWaS4/A==
X-Received: by 2002:a05:6402:51c7:b0:5c9:6623:a11a with SMTP id
 4fb4d7f45d1cf-5ca0ae81c14mr12563339a12.25.1729598437597; 
 Tue, 22 Oct 2024 05:00:37 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d0besm3083100a12.57.2024.10.22.05.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:00:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v8 1/8] test: boot: Update bootflow_iter() for console checking
Date: Tue, 22 Oct 2024 14:00:22 +0200
Message-ID: <20241022120032.196311-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022120032.196311-1-sjg@chromium.org>
References: <20241022120032.196311-1-sjg@chromium.org>
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

This test checks console output so should have the UTF_CONSOLE flag. Add
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 154dea70a59..cc894e804a4 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -370,7 +370,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
 /* Check using the system bootdev */
-- 
2.43.0

