Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63246E677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D8C892E5;
	Sat,  2 Nov 2024 20:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MNUj0pRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E1E89118; Sat,  2 Nov 2024 20:37:53 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CB489300
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbf0769512so20180306d6.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576269; x=1731181069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZVjYOadgDMlQrtpM8E8XuiymoyHqiXTXNGxS9t9DvI=;
 b=MNUj0pRxXGMfRA2am0NSJspyNehWePOwMYw25keDrjkHn52TZBZGN+YOW4McOHUUMB
 8A5lafn5VF3Ibx3bc7i55e1eKBni7wMWT4X2TaTFolPiEwTTp9fOT54BLVd5kWB1vi+X
 4m26B+qV2GupmGc8wRyYWobr4Oi0nrcScGL2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576269; x=1731181069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZVjYOadgDMlQrtpM8E8XuiymoyHqiXTXNGxS9t9DvI=;
 b=aIxQxggDD0RtWu8mduBPRhSElwIvDXbNdrVsklHOH4+cGC2SwaAwtxqTzWElJzUnMw
 /N2ORN8qZZkyZzEmoQrKKpG7nFERaAFjY6SLl3CtjxdtI2Ph1PToPwajAyMgQIwGwNx1
 E118+nZqC/H/Fe0SutoUe+6z505W80s/vXsApni9lDpX+H1IDGuytW/422ZB3xeqpLyM
 /pcsQIoyWBI2ICKG2Wj5Mbx/WX/1Z8TUlzf1L3yRSdPeP105eDVT9W2C35bVT51kDEn/
 /RkqzDFwOzZjfDPiWPahJRa7kDOQm4uQrH9Jb79mc+D7V2VLQg1faIzA94o47hidttsg
 2mUg==
X-Gm-Message-State: AOJu0YxFo8sB4UXMgtiwhUYCyvBLhZeRrIGzUWccU330TDMxWIkvw+mu
 05ZmCHdlCqNrg71/c88BY0D24dGSyAlzg3zrppRxaCueocBSfGC7hvCYqLlNACXSmWZ9XNJEqIG
 BmmAV
X-Google-Smtp-Source: AGHT+IGa4nvWwIRw7MaMgkQ8vcMLGwzA1d6iv/PzgBEbGEwS1ZDHShJx4WOyke+0wj3zwc9ZVO/Q+g==
X-Received: by 2002:a05:6214:5b86:b0:6cd:3a49:34e8 with SMTP id
 6a1803df08f44-6d351abad3cmr183166376d6.20.1730576269501; 
 Sat, 02 Nov 2024 12:37:49 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/20] test: Move str_ut test into lib
Date: Sat,  2 Nov 2024 13:36:57 -0600
Message-ID: <20241102193715.432529-13-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the lib/
directory, to match (most of) its implementation. Rename it to drop the
unnecessary _ut suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Makefile                | 1 -
 test/lib/Makefile            | 1 +
 test/{str_ut.c => lib/str.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{str_ut.c => lib/str.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index 9f19bfa472b..220a249c397 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,7 +14,6 @@ endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
-obj-$(CONFIG_$(XPL_)CMDLINE) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
diff --git a/test/lib/Makefile b/test/lib/Makefile
index ce22780eed8..be20bbc047f 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -17,6 +17,7 @@ obj-y += lmb.o
 obj-y += longjmp.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += str.o
 obj-y += string.o
 obj-y += strlcat.o
 obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
diff --git a/test/str_ut.c b/test/lib/str.c
similarity index 100%
rename from test/str_ut.c
rename to test/lib/str.c
-- 
2.43.0

