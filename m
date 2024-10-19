Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A737ED3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E76208924B;
	Sat, 19 Oct 2024 17:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YzGx5NRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316BC892B9; Sat, 19 Oct 2024 17:25:05 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B3D88F8E
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83ac05206f6so44641139f.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351502; x=1729956302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qlBj8cBvBW8HaBiWf3OnOBMsBLuXqzrYxgYFi1KlxQ=;
 b=YzGx5NRLlzaOHj+p3MRv6XlCE9SW78EPqip3EuJD+7ocZim3g598ikuXf6Vg1eiYLv
 omsZuymEOaw5UyMa2w1lYgkMWNWGnx0dig2iUjEJwLYu4a/wDCYy/SQv01AhGTLzH0C0
 ly0NxMHXOFAFwrjkND1bDT1oeZlXPt+a394GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351502; x=1729956302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qlBj8cBvBW8HaBiWf3OnOBMsBLuXqzrYxgYFi1KlxQ=;
 b=fh44LAqfTgf8SoyWtqGKW9nerfDkGDKo2LnOeTjpmgnRacePXcFhXOVBnXm/oXxaov
 qIxK6LxgAWsJ1Fl1TSWVYFqhAi8M/wBgfjJQgx/8iuL8OPVWloZruxIKl51ljQ25qEuh
 3Z7kVUwmD3EuD/ILqOyY66lsHdgn5RdTdKztwGFCmTJtMywkCTCqfDUAAJzd+0nFtklB
 Ed9wEecTCIZe6jwvSp7b0iUhQ4T/U6KxNXH8Wo1cZX323vWtQtWXju9NMbvAU1M0lZYr
 F/XslMevbUqjsEyn9JnBSGCh7Y3Czj7WGoLC8hhOrH9cNxRgS5rIOdMTuOsJ6VYbQcYU
 xSaw==
X-Gm-Message-State: AOJu0YzaUrjDYqrEuv5H/JH1NMIam6qGoxkkTxSYahZCMkfeSJbhiphj
 9AY0tYalZ4eERhWhLEqYZW+m4mhCQu7u7KmsQoQEqPGd6pFWJM3jvT4sIyl7q4Z0NQBXiwNgdsI
 =
X-Google-Smtp-Source: AGHT+IEubYRkSHgrPQ5B4H+3hBLuSWQki42ahv1X2SWQM3gacNY/li4/vNRS4IRPK1x8PRtvqbHVIQ==
X-Received: by 2002:a05:6602:158f:b0:83a:b71f:1b16 with SMTP id
 ca18e2360f4ac-83aba66a877mr586984039f.13.1729351501653; 
 Sat, 19 Oct 2024 08:25:01 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ada8sm1036833173.23.2024.10.19.08.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:25:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v7 1/7] test: boot: Update bootflow_iter() for console checking
Date: Sat, 19 Oct 2024 09:24:28 -0600
Message-Id: <20241019152434.1017394-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152434.1017394-1-sjg@chromium.org>
References: <20241019152434.1017394-1-sjg@chromium.org>
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
2.34.1

