Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283D2FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 14:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AA784374;
	Mon,  4 May 2026 16:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHYUkA4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 383FC8460C; Mon,  4 May 2026 16:58:32 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0524684255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 16:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso2410545a34.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777906708; x=1778511508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=knPKQjlL3i6tUdNtluwbGtNg7snT7hoq+Fa1mC4fqPY=;
 b=YHYUkA4/BvaLe3G6m0Wm8gddCDHUv0+XBN7dg1t19eqmaCClhEihX+BzCP6c5ruH1C
 GYokxRKZxbo4QlG4i47NGV8v3fHS8d2jDzue+dhqgZCAYKQZB0dFHxaga8+Bc5Lbg+Xw
 GAJ6XV+tzDg0OcZ6dICXTKQ1kob0AB36lbuh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777906708; x=1778511508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knPKQjlL3i6tUdNtluwbGtNg7snT7hoq+Fa1mC4fqPY=;
 b=BNYawc/rVlrwfgxkdAMXQXmi5T3B9rrCUKA2XE4rwNfrIAKYG2Pg543qnqb7mjfiEq
 aPN4iRV23XpzlfbLRjfEtkrAv29mzSdIxFXjgrkQ9LHmvA9ftIb4dZpxf4QfPlj8yzPG
 McTBwZPhSYoI1wYEcHK5IU7J7hjfLuT04l0Jr4YgotMlZF3pAHXdi40+86Jq0L8kgjIR
 q6uQPaAwhf4h2N0MAggKrtVGmsQaVy/YuwuVYeZy/tN/oQOFQn3mROg7E/VQ4HzAKrXV
 veRY4tQB4RNbsil2GWaW8bqfi4XqlvELCjbELjjrkMJ50fqgIHALhQp7O9wo/xVtARfJ
 CRKg==
X-Gm-Message-State: AOJu0YwltCbw/o4HVEjV4yyqIgFHmW0u4RXuBqaaLc1U49uz2GZCOGbo
 BXY4shccww+iAy5dfvR5UpvtJTYbcb1/ttmqsXWG89Dn9/6ZNej/VhIrmGs2cQxEqHcR2ERE4SC
 l4gnffw==
X-Gm-Gg: AeBDieuN/s7Nh/gMNyd5/p7wcBtZgTWmbqL4fDt9zMGk5HtqOXZA8SXCoQbSorpKqd5
 W6jhFtgb60Y1LkNSD/D+dstWwWM2hlnkt8ECapSX01xShT6aiLwq8y4aid2SDz1gRkEccKNMM0y
 8CJg9jpDT43ROY9319K6I9cO9ZpWY/4sPd1pUZufKERpKk2pt2XHlD8ZgY1MMqdzm78ekN0U5Oj
 Phgk6EBgNeZEhNMtZNeKhqZujfgbiy4mB/VBsBVd80jbptqA44fNR9tolp+jDoeD9z6iOlp8xi1
 6yMJBDGrY8ATeWgMAVBmOhzCMSZew6QLFMVq0WmP6Ts5I+UrRt85JoQNGMM6ibJW+JzAfgeW5/D
 CXKRetvlvrwCTwBNcO/m7dnPYutXVtQxv3ECT16Vanttnp/nRFU7dgkCHgjtvuMizk6ClaOFZCe
 Z2YMGqzq1XT51YkIgczxZKshv3tQIe
X-Received: by 2002:a05:6830:3c08:b0:7de:44a5:51ea with SMTP id
 46e09a7af769-7dee121de03mr4800842a34.6.1777906708127; 
 Mon, 04 May 2026 07:58:28 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca7a9036sm7854594a34.4.2026.05.04.07.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 07:58:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] .mailmap: Update my email address
Date: Mon,  4 May 2026 08:58:16 -0600
Message-ID: <20260504145820.1727552-1-sjg@chromium.org>
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

Add a .mailmap entry so my sjg@chromium.org address is used for all
email.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 0c2e96219f8..7aef23fd7cf 100644
--- a/.mailmap
+++ b/.mailmap
@@ -137,6 +137,7 @@ Sean Anderson <sean.anderson@linux.dev> <sean.anderson@seco.com>
 Shaohui Xie <Shaohui.Xie@freescale.com>
 Shravya Kumbham <shravya.kumbham@amd.com> <shravya.kumbham@xilinx.com>
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com> <shubhrajyoti.datta@xilinx.com>
+Simon Glass <sjg@chromium.org> <simon.glass@canonical.com>
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <siva.durga.paladugu@xilinx.com>
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <sivadur@xilinx.com>
 Srinivas Goud <srinivas.goud@amd.com> <srinivas.goud@xilinx.com>
---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
branch: mailmap

-- 
2.43.0

