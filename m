Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41283E95A66
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D32B086F72;
	Sun,  8 Oct 2023 01:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BQ92U7lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9018986F04; Sun,  8 Oct 2023 01:14:46 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A085C86EFC
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7a2bfd584f0so151499839f.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720393; x=1697325193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJV+FYEHkmbf62O1TZ5OiIeWFGG0TVWeChGBLylg4r0=;
 b=BQ92U7lOf8McwqkYJ0+41hpTbNLMqC5++w7hxGsV684uNP3lnoDRMcqlwW4bgEYi/g
 WLNKrq1XeyokutHGqpjEhrd8fQD3yA/wYzVC3t1j8XULOasMxlEJI6ERddv0K2l/jbKD
 C/ThtTGL1Rp3YoJ8QQBXHkz3Ju6aNhCqL5WMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720393; x=1697325193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJV+FYEHkmbf62O1TZ5OiIeWFGG0TVWeChGBLylg4r0=;
 b=ZlXLt4BPnQfrZDGLrCExI8ZycUB+v66UfiAB36Z06ZIvMwNe0VPX6MO+5yZNrIpF7C
 KqJGKxbvoHh3bqSwAruuhVG/wqPrknb5z2ZwhIj/m3Rqm/Bh4FRSc1wSEmdz3Cb3qEnt
 HkqsNjtXO53AsyhUoKbreO5RXdDXc8p2kEcKocjr6mtXdXTb63ZnGOJTLBDULs3rscvJ
 12kUIspQdsSUJh7iEEyEbPByJOQ3itW10dZDbL0PU382Xpuch9uzmIi1foqEEXvONLlr
 /GFSrGDCDRST+TS1F70zDmn+ifVB1X3Mzhj3qrHR/gDr55axQjttiMpKI+ZmqSbX4HNb
 oTkg==
X-Gm-Message-State: AOJu0Ywo75vp+43n/6SUxuD4HPlSFnppnRau4Vhl3rUQm/NddYPO9/nO
 4w9TrCOmWm1AFRCCcU6ce6fMJDHWX5vwImHZjo0=
X-Google-Smtp-Source: AGHT+IHrX3PqMsqtKpm1X9FT8Xt+RQV0Ht/UzHK4O/idT3LGi0SZewIjP9BZKgNUK5aCy7+cSj86PA==
X-Received: by 2002:a05:6e02:1561:b0:351:5cdb:225c with SMTP id
 k1-20020a056e02156100b003515cdb225cmr15332143ilu.17.1696720392856; 
 Sat, 07 Oct 2023 16:13:12 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/27] cmd: Use an #ifdef around run_commandf()
Date: Sat,  7 Oct 2023 17:12:30 -0600
Message-ID: <20231007231255.277623-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

This is not available if CMDLINE is disabled, so add an #ifdef to correct
this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/cli.c b/common/cli.c
index 3916a7b10a7d..4d0fea4387f2 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -129,6 +129,7 @@ int run_command_list(const char *cmd, int len, int flag)
 	return rcode;
 }
 
+#ifdef CONFIG_CMDLINE
 int run_commandf(const char *fmt, ...)
 {
 	va_list args;
@@ -153,6 +154,7 @@ int run_commandf(const char *fmt, ...)
 	}
 	return run_command(console_buffer, 0);
 }
+#endif /* CMDLINE */
 
 /****************************************************************************/
 
-- 
2.42.0.609.gbb76f46606-goog

