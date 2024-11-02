Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB10BE677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4640388B0B;
	Sat,  2 Nov 2024 20:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fLWppMkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD465890B9; Sat,  2 Nov 2024 20:37:27 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 980C48860B
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4608e389407so41142801cf.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576244; x=1731181044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nto+z4VOcrYqFngNag1Q3amN/Ydj1T91aaYdUUGZUHE=;
 b=fLWppMkVLoiRbszYUiQNl18qR6KxZmvwosBxBwrA6F64Mw9Gp8lAne54hlOshJxLzP
 1g0EMevEzom74dXESV19RbGl19Di2Q+1AhLl0odu4vL11DT/erhp9bb3fNmRgD5OMtDD
 74a5U/eznxTLuXVPftcuhbsI+L9GWjThH23b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576244; x=1731181044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nto+z4VOcrYqFngNag1Q3amN/Ydj1T91aaYdUUGZUHE=;
 b=hHxeIt7nfOG1lQGnNjjVsGC8p7CfbxpensrsXk6WlUlyaCSt1o0rDB5mGuu6NSZG4f
 dgek8p9mDLNFsIGBkt/qOZqDvUwKFfuJJHRzmZaFG20UbNgmKYhls2WaEV9U0I6Zb/pH
 hUt0ZM6mUKHYA2rzVb8ieHvQiVXUs3RWg4T7Dx+I+FM3VTkjqNRr0nsNVuVX8lB2dq1A
 3C1EcQCrUoZmwv1xNTugfPIIA5rIHjU4OUe0Gk1sdPQ2TXrr4bIH+vkmPuEqjkXyVqV9
 J6R1ZPT0xQ//u7eBuMr5maatT2O7JYmt0NyHHnHBKRIpeEOpTSr3pgSXHpwq2hbzIafq
 kfhw==
X-Gm-Message-State: AOJu0YxFPHBqDPf9y1Xw2OpjSqr9ZN2JdFk+sKbb2c8NjvGR4KC8H9QL
 RzYw7RSgWcCg6btDk9lxSmocN8/sCC7D9HhmRe/+69ifeyApFBhhRm/BQe7aSGwMaQ2Y34WgvUW
 MPs7q
X-Google-Smtp-Source: AGHT+IHMax/aJ71ILy8j8vC17cUpae7dBl1m1HTj5JxvLWVuWLXSammtZ62Cym1KDM0/WsXoOI0mDQ==
X-Received: by 2002:a05:6214:4305:b0:6cb:ff04:655f with SMTP id
 6a1803df08f44-6d1856eea23mr313129956d6.22.1730576243926; 
 Sat, 02 Nov 2024 12:37:23 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/20] bloblist: test: Move test into common
Date: Sat,  2 Nov 2024 13:36:46 -0600
Message-ID: <20241102193715.432529-2-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the common/
directory, to match its implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>

---

Changes in v2:
- Leave the bootm rule alone, as the bootm test only runs on sandbox

 test/Makefile                | 1 -
 test/common/Makefile         | 3 +++
 test/{ => common}/bloblist.c | 0
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename test/{ => common}/bloblist.c (100%)

diff --git a/test/Makefile b/test/Makefile
index 145c952d2c3..5d62b5c3357 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -5,7 +5,6 @@
 obj-y += test-main.o
 
 ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
-obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
 endif
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
diff --git a/test/common/Makefile b/test/common/Makefile
index 12c65f8c951..b6bff9201ec 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-y += cmd_ut_common.o
 obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
+ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
+obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
+endif
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
diff --git a/test/bloblist.c b/test/common/bloblist.c
similarity index 100%
rename from test/bloblist.c
rename to test/common/bloblist.c
-- 
2.43.0

