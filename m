Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5238CC02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2E1807F1;
	Fri,  7 Feb 2025 19:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kTwzuPLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF0B0807F1; Fri,  7 Feb 2025 19:31:31 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 985A280141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-844e394395aso60932539f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953088; x=1739557888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6m3sgz1sCihBb0/HIe972wAyjcEKbp3WIWm8AwZFMHc=;
 b=kTwzuPLxohlGtISbecvdzARj9b0nvanc5jZ82El59oJs/5HHkfBCJV6qr7w0eC8Wwf
 29N9TqAPRfrRxlOP0SYHRfsULOl5ER9hSmS+pEQS9FyLs5mzZjBSEvUx4f8KTU02XUEr
 1wPDtAuO91irtqXpE9uraekHa+mreZRo6plPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953088; x=1739557888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6m3sgz1sCihBb0/HIe972wAyjcEKbp3WIWm8AwZFMHc=;
 b=dDXahSWf85OQ1Mo3PfmMDkdUhwpK5vY3hnYX+ZaXlDIsvmTNtEZh3tRGYHKEgj5E33
 OqbMyksFDnwk4tn+FIb0V0QbYL+fUuc/7fe96O6ZaeZ+GCgkSe+4nDFHzsNZkNG9RcHx
 bbFkwm/Vte2dWZ4bMO5ox9+rThUxi9ui56KBE04uPNrLo2g81RAjCV5M7GeusAIG/7W1
 6FwukK7bi7FneywN6T2jBysc0OBJZef6dCvpuuJyut9NUbgKLI7QqrjFBhGjDxvudNsZ
 3lPlyx+KEjEac+8osTNoK6gKhuPKn/shX7wP8sKw7LOVUDbwurxE8yTNsk/MbDfYMe/k
 oAXw==
X-Gm-Message-State: AOJu0Yzr3SK3vuRU8eNTf1wHv+J1Xr/RcntoC1jMxoIqAzMuyAAJIxYw
 BrjaiwWVelPpD4h8Ng/cEUXuja/1uxpux7G2FOiaNcwhj2ZtCbcEQUPRcNxItQV9NIkl+iuO4Jw
 =
X-Gm-Gg: ASbGncu6KcYGoZaqrSPW81WShgwa/5Wp4yIB2rS0LSE+D+eIcUbmUKOUDAYWRbp+scF
 QNqs0w8D0azf0rCjg9OF/29NVSahsp/r8vCKWmlAJ+wwPsJzYBG4ygD+jS/t83W5n6Qmm5tmeZU
 3TGnNitQRt9Lbu3WDy8CbnD5SOSk0gDvsJC0PifkmQCS3goxlhvD93lfXxyboFPa7IXNVe5YjRq
 tesyeXzFkKN7+l4sAo5TN+XbpQZqIbtIkKBGB1y4XZC0KGgYHUD2QKXOS55YI/yRAuOE6qXLr+7
 xTr1/p/vqKgoqM3g5L1VrrmdV9oB++bO58UiYVWsfdfkOOqXKfih
X-Google-Smtp-Source: AGHT+IHtQEuzUSaLUgYJ2xbAp0FjZ0UxDo3X3qcJuCZBZpfJHpQCN4JROV9LNUq0W4WCDFQA9qY7tQ==
X-Received: by 2002:a05:6602:298b:b0:841:a652:b0c8 with SMTP id
 ca18e2360f4ac-854fd87ff28mr480847139f.3.1738953087735; 
 Fri, 07 Feb 2025 10:31:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/29] test: Drop sandbox_set_enable_memio() from mux-cmd
 test
Date: Fri,  7 Feb 2025 11:30:32 -0700
Message-ID: <20250207183121.117663-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

This test does not appear to use sandbox's memory-mapped I/O so there is
no need to enable it.

Even if there were a need, it should be disabled at the end of the test,
so as not to affect other tests.

Drop these lines from the test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to drop sandbox_set_enable_memio() from mux-cmd test

 test/dm/mux-cmd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/test/dm/mux-cmd.c b/test/dm/mux-cmd.c
index 6eb3b283161..bd02cda84db 100644
--- a/test/dm/mux-cmd.c
+++ b/test/dm/mux-cmd.c
@@ -26,8 +26,6 @@ static int dm_test_cmd_mux_list(struct unit_test_state *uts)
 	int i;
 	unsigned long val;
 
-	sandbox_set_enable_memio(true);
-
 	ut_assertok(uclass_get_device_by_name(UCLASS_MUX, "a-mux-controller",
 					      &dev));
 	chip = dev_get_uclass_priv(dev);
@@ -119,8 +117,6 @@ static int dm_test_cmd_mux_select(struct unit_test_state *uts)
 	char cmd[BUF_SIZE];
 	unsigned int i, state;
 
-	sandbox_set_enable_memio(true);
-
 	ut_assertok(uclass_get_device_by_name(UCLASS_MUX, "a-mux-controller",
 					      &dev));
 	chip = dev_get_uclass_priv(dev);
@@ -153,8 +149,6 @@ static int dm_test_cmd_mux_deselect(struct unit_test_state *uts)
 	char cmd[BUF_SIZE];
 	unsigned int i, state;
 
-	sandbox_set_enable_memio(true);
-
 	ut_assertok(uclass_get_device_by_name(UCLASS_MUX, "a-mux-controller",
 					      &dev));
 	chip = dev_get_uclass_priv(dev);
-- 
2.43.0

