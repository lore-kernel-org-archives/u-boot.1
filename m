Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E49C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F4E888E7;
	Mon, 15 Jul 2024 12:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cOuEVGJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3174B887EE; Mon, 15 Jul 2024 12:14:12 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CB4888CC
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52ea5765e75so4945673e87.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038449; x=1721643249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMREJ4UfVwwHBER3SYYypC0Wb5V9G+3yc8lpfLLnzn8=;
 b=cOuEVGJTITy3VuElUzfsFEigFv1JbTcfd2gDHksmub670p3mPy1LTSsDl1WzxeHIZ7
 1CcC4eFCTnGUxzccGH6WJSRO15ViroYrco2zWMoIcK9VeXmLBf4TXnBBAfg+1JPib9Ss
 4bHU1pqcjC9C5tv91g7Axu7xcPFUTgikrd0uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038449; x=1721643249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMREJ4UfVwwHBER3SYYypC0Wb5V9G+3yc8lpfLLnzn8=;
 b=xEpBKm47iT9BTDaP8Onf2GqKh5YoUeQCKznmQ2e+SVQZeiGrpFcfzF3WIIegntimfe
 gOT79M5qjuj2K+F/xEnDvVAG6usCGiiADkKkHt6RFMnAeeEq1KWsoLlqhbMVDZoBAHlG
 aQV7qkiMSq6ZwqK3rNOK8SoV1zbUStKae1ncfn1pcnBA8XiZtanUMk6oUvv7jGH/wr/Z
 DiF4sG7XgUyMe4robklf6lEUSHHL24BXux8HosZDyEEGcmoBx1mdHNUVjND65khMOE8R
 gV0zvYUReKj0rEyDJHBb1nuU0GlEje8jCfWy/KO71wAMAJzVXLzTGnmWBPLFLYfvsoJd
 HSZw==
X-Gm-Message-State: AOJu0Yz1M4XJy7RE7LGwRkiwLLTtEFLhT2ZZKyIj+OvrGys2PO+bINR6
 +XEuEm3yDGKgHPeVZFPV/Te5/8JUTYwyCo8kuqu5P4bbjZa2wEEaJkRIPUSR9HUq9jmsf28nUhc
 =
X-Google-Smtp-Source: AGHT+IFGmFfb88+qJ3LKu6EI4kFO8TMK4qD8Cjki/UfWZc1annTCc+bQwRbEMi/97wdXC5E+6H6vvQ==
X-Received: by 2002:a05:6512:e97:b0:52e:99fd:d386 with SMTP id
 2adb3069b0e04-52eb99d20a8mr13942894e87.50.1721038449080; 
 Mon, 15 Jul 2024 03:14:09 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH 12/13] boot: Correct indentation in efi bootmeth
Date: Mon, 15 Jul 2024 11:13:53 +0100
Message-Id: <20240715101354.97895-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715101354.97895-1-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
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

Fix a minor indentation / whitespace problem in a comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 56a6e47f5b2..39232eb2e25 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -265,7 +265,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
 
-    /* bootfile should be setup by dhcp*/
+	/* bootfile should be setup by dhcp */
 	bootfile_name = env_get("bootfile");
 	if (!bootfile_name)
 		return log_msg_ret("bootfile_name", ret);
-- 
2.34.1

