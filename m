Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4440E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79208932A;
	Sat,  2 Nov 2024 20:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g/gWvk2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F7589326; Sat,  2 Nov 2024 20:38:09 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7318860B
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so27137366d6.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576285; x=1731181085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Wq45GDXvn8eH9w2cEW2D7xASC/YVd+8cG8NC8P5QkE=;
 b=g/gWvk2qf3lDvpr7uozTgGcTlaBC95pVW3zPz14G3vf02imfC7vD1IFSmRZu15wPD4
 1kswvYNXhjahBmNT3gHOqzv6/SeGUDIQ03Xrvu+CwtTIGug3JEhp8qA2ddvMX4wW4Tsu
 jkkgV7Gesb7x58hXgUoa9YxEceTRm3LG/sOsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576285; x=1731181085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Wq45GDXvn8eH9w2cEW2D7xASC/YVd+8cG8NC8P5QkE=;
 b=mVRC9Yeadl3J3xJtozQjnBAnOo8XJjuB1VUf8tvBXhJExTONYabpIC2A5xj6iFEgqD
 4EEW/7Ge0nDXPteSrqsEJdM8192dRIvdjXgk1+VKjCWxAhsXzZxynXnq7+tjoEmicpb0
 NPyovesRJjJKeP6t5ItPwwFu+p2OJ3z8sSdoreKrhFjEhBstvrBywf3gFTepPquO5MdN
 z2Die5HR7YYUbZ+ZJNnZutuxbz5keppbm34U+CRSD6cZiSJfABeO6QkkuXYwZstInsuZ
 Zq6Y2lrBJdSp6oU/NvXlujaocMgwYKscGar34isBaCB2U8cfoK9b/uUsM82w/1dEH9Jt
 zv/A==
X-Gm-Message-State: AOJu0YxCXILlkavMNfAPcCplrpJxXC1usJ2hM0gZMxxgcVrRrSmu9UfW
 04UXQge0oi8OU1dLvrE1iUzsaUvHvQ2k0H5e8VAqKOb9j2peqXZajd7xA/+HaPvSx9jbOwzjx6V
 gb1/w
X-Google-Smtp-Source: AGHT+IERMB5Gm8Pr9VUKHFrv5YGgqvPzb4Je+rAFh8CUe/9Fg8I53x82I4bW+SzulYoG0/HEAc6jrQ==
X-Received: by 2002:a05:6214:acb:b0:6cb:6468:7eb9 with SMTP id
 6a1803df08f44-6d35b964338mr136720426d6.21.1730576285367; 
 Sat, 02 Nov 2024 12:38:05 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:38:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/20] test: Correct display of failing test
Date: Sat,  2 Nov 2024 13:37:04 -0600
Message-ID: <20241102193715.432529-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

This should show the test name, not the selected name, since the user
may be running all tests, in which case 'select_name' is NULL

Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/test-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/test-main.c b/test/test-main.c
index da5b07ce00b..e4f42689da4 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -622,7 +622,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		for (i = 0; i < uts->runs_per_test; i++)
 			ret = ut_run_test_live_flat(uts, test);
 		if (uts->fail_count != old_fail_count) {
-			printf("Test %s failed %d times\n", select_name,
+			printf("Test %s failed %d times\n", test_name,
 			       uts->fail_count - old_fail_count);
 		}
 		found++;
-- 
2.43.0

