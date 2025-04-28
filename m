Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F9C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35185829B2;
	Mon, 28 Apr 2025 21:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N6zMKgw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD439820FE; Mon, 28 Apr 2025 21:24:49 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FEFA8210E
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736c277331eso5905652b3a.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868286; x=1746473086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6ZGLNfrm2E44Awrp1tQSTiBNj+s+vejgx0gvQ+/lDA=;
 b=N6zMKgw7YYt0+rLJSU9m3KcG4nhY2f0WlSR0OycekLW+F0J8y41nrkCp7xPCZG7cMk
 0v9p8HInSDNhdWlp3X0veI66RZr1fz20SAQKlfq0z+GAjuxqEAq14f+moMPaAwuDwJTj
 B+0oLnXYjhB4m2YKnkqJ2sK8CF3I8o6GJ6tvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868286; x=1746473086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6ZGLNfrm2E44Awrp1tQSTiBNj+s+vejgx0gvQ+/lDA=;
 b=ILz/hUJepVVMk9sxYcazWV1sEjRAnkk3nbhANbSuCeWBha3+fKqpY8Ov9x8mPpF28j
 UqNnQ6WbasqGfeE6GjkC4yvxoxWo2iu8Rx63YkWrcWes5DDk44Y3eVtNH9A1WuLnGq6B
 mlQ1OMnil/pZ2LRhHf1OlNnjK/q8DXFQluyiFeazldFbrgb0ay0NBLA2lQsKPwDeFzXz
 B13bozTwlzApWdM9UVyzDQ0kUOX42eXKQy0qL6hXCwld6JBD4RkJQcoBsWX5zLtFw/Pz
 RxAXVhipc/DfifEvvk/MFJ48sGTL0a0jMUAmAoYj+jrEHhOrSLRWqcxo4AI2VCtlhGJe
 8GgQ==
X-Gm-Message-State: AOJu0YyixiIb1KM/mYtiEYUowiDEACMEmK/MnAyF7z3NCoMquO138c0t
 1PTIPiJjhe7P1qpVnAAX02+13AVhM59vxunGA+/ttKN49dv6brBVnxu/SqspC3B8eo0Rte9rqEc
 =
X-Gm-Gg: ASbGncuWBQmv68tsihJN+hi8gAQ1NbJQNqQPowVF3qBdEjfXrELuXgpmM3aq370x3/g
 XW44cTDz1zP6nO2QznVASMxVC7TS6rCmrfMQEPVeIwKf/BizxkUO6OCVFUxAEuy7KMTJTdTEj0y
 vKZ0Tm+8Dim0kvLPXKzVcwKkuk36xi0miCqSQ0WCqsUkyss2sycfVXx2mBvqgQyJF8VYG0/vx5E
 NF8CSxNcplH0qEZoAmG4JrB5tJ+Ht3hI236ZMOtY9rJnBsGdsUvaTm4FNnLepSylN4gnhK4R6zY
 ESPi6Ts8pk3eY2zMsJKOGsmfip86RutXl0RcBYJFiViFFBKbMXEgih6ZJD76vnDXP1povg5KVaL
 u1T//3fu5g8Us
X-Google-Smtp-Source: AGHT+IEvUngl63y9fsFyGPw7r876Ojy0xsF76x0iaVJsgpWsZ5ZIAilD5jn18aFG7YCBE5JXxuYBmA==
X-Received: by 2002:a05:6a21:318b:b0:201:85f4:a885 with SMTP id
 adf61e73a8af0-20951631e24mr442332637.13.1745868285760; 
 Mon, 28 Apr 2025 12:24:45 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b15f7702f70sm7664933a12.10.2025.04.28.12.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:45 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 10/17] cmd/cbsysinfo: Allow on ARM as well
Date: Mon, 28 Apr 2025 12:24:17 -0700
Message-ID: <20250428192427.3877612-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

This command isn't x86 specific. Move it up one level so that it can be
used on a platform that can find the coreboot table, i.e. x86 or ARM.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/Kconfig               | 4 ++--
 cmd/Makefile              | 1 +
 cmd/{x86 => }/cbsysinfo.c | 0
 cmd/x86/Makefile          | 1 -
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename cmd/{x86 => }/cbsysinfo.c (100%)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 2d31abcef730..5a35dba8681a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2929,8 +2929,8 @@ menu "Debug commands"
 
 config CMD_CBSYSINFO
 	bool "cbsysinfo"
-	depends on X86
-	default y if SYS_COREBOOT
+	depends on SYS_COREBOOT
+	default y
 	help
 	  This provides information about the coreboot sysinfo table stored in
 	  memory by coreboot before jumping to U-Boot. It can be useful for
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8c..7587b258409c 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_CMD_BUTTON) += button.o
 obj-$(CONFIG_CMD_CAT) += cat.o
 obj-$(CONFIG_CMD_CACHE) += cache.o
 obj-$(CONFIG_CMD_CBFS) += cbfs.o
+obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
 obj-$(CONFIG_CMD_CEDIT) += cedit.o
 obj-$(CONFIG_CMD_CLK) += clk.o
 obj-$(CONFIG_CMD_CLS) += cls.o
diff --git a/cmd/x86/cbsysinfo.c b/cmd/cbsysinfo.c
similarity index 100%
rename from cmd/x86/cbsysinfo.c
rename to cmd/cbsysinfo.c
diff --git a/cmd/x86/Makefile b/cmd/x86/Makefile
index 5f3f5be2882f..870e941dcf00 100644
--- a/cmd/x86/Makefile
+++ b/cmd/x86/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
 obj-y += cpuid.o msr.o mtrr.o
 obj-$(CONFIG_CMD_CBCMOS) += cbcmos.o
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
-- 
Sent by a computer, using git, on the internet

