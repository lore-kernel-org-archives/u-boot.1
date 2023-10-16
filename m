Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0271FCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD97086F54;
	Tue, 17 Oct 2023 00:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A+Ajrh/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD580803AE; Tue, 17 Oct 2023 00:31:49 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0E186F21
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7742be66bd3so360946785a.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495484; x=1698100284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wx62cH5xw4FgQ7Qa/7Jj0068w6llXj128pvqNTVIOsU=;
 b=A+Ajrh/mc5X7A/ZE/1aLZOhO3G5Nwo+f7tNy2+U9vqQqy4G/kXQpk2cR0YgFqB/YDG
 2kLWzUzJlKYuTxIXzKzpD9QcxNNf3zatp3y3sYqp3vSD3yPRt/EwvRzbz4fXAm+AzoIv
 oNZ3mD3wkzTPqEwsYw2KssbUB5Dqwj4W4vfm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495484; x=1698100284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wx62cH5xw4FgQ7Qa/7Jj0068w6llXj128pvqNTVIOsU=;
 b=k8hsVCEbXkFs/L5OXyPVteHQi6jNeVBQ9sHqTeMFQEbw9C2CpSBYzscaa8cJXh/lYw
 J4TkERSzo85VpSHtcVwjuean94lPSi02HPbxEZNIZPj12rcwEhqrTKhG3tvYwvyV3t+X
 LYFSiJPV5Uaq2YuUZQXTBdgmbUUTY/iKFG/JOpKGYegpso9s3Z7F0Jey97eob25erOzH
 C5KRxwUsfXTpB/ccRKiaLc1NddfQuB0WtpKvJH93gsM8jkh1k+LTa7rnEFBY8tk1HHHC
 ZVEFsaep+rgX8RNN1blkDeopKXURKZqIUgfCo474QUF58kLtrjOkh8q+/QGiOFvHZ5n7
 ct5g==
X-Gm-Message-State: AOJu0Yz9ZBWC8dIt2sezz+B1C73Xb3oVFhAMkvwBQ/Qjw4rChhl9hb6l
 JTizmNCxON04Ld3qWhT/KKgaH7Jt65rSEiSJOFXDpQ==
X-Google-Smtp-Source: AGHT+IEKYxyBiUUtnASXj32FdGv2hRQ8nGK6IUolhJkuPMk8muE9YV0csHaRz+79lyHJnGf8h5MROA==
X-Received: by 2002:a05:620a:1331:b0:76f:11d5:6532 with SMTP id
 p17-20020a05620a133100b0076f11d56532mr503862qkj.76.1697495484119; 
 Mon, 16 Oct 2023 15:31:24 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:31:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 18/32] video: Allow use without CONFIG_CMDLINE
Date: Mon, 16 Oct 2023 16:28:09 -0600
Message-ID: <20231016222835.596572-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

Provide a fallback for when CONFIG_SYS_CBSIZE is not provided, so that
the console can still be used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/console_truetype.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 14fb81e9563c..e4dad3f9a191 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -125,7 +125,11 @@ struct pos_info {
  * Allow one for each character on the command line plus one for each newline.
  * This is just an estimate, but it should not be exceeded.
  */
+#ifdef CONFIG_SYS_CBSIZE
 #define POS_HISTORY_SIZE	(CONFIG_SYS_CBSIZE * 11 / 10)
+#else
+#define POS_HISTORY_SIZE	(250 * 11 / 10)
+#endif
 
 /**
  * struct console_tt_metrics - Information about a font / size combination
-- 
2.42.0.655.g421f12c284-goog

