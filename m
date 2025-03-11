Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF71AC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 12:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B5B801FB;
	Tue, 11 Mar 2025 13:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QN5Pk+LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07B481671; Tue, 11 Mar 2025 13:31:36 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F54801BE
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bdf0cbb6bso31525795e9.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741696294; x=1742301094; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jfnQ9P2LHwMNctM4rL26y4jTvPfZngOhgNrgDtSP5Ww=;
 b=QN5Pk+LUK1DBoBpGfLNCtQ8fvBVIVBrpsuuE0orhfm0LzPz9yBrJq37+kGYfgENC0E
 8Ge9lELylw20wJ1lkZgV+nmffO7TF9yHvV6Fagk/lrZ2uxhhfpsMmrotTLjoAuYUmRUu
 nTttDvjGw7+A00c2RTk1nShS2byd1YKlKyl786FkPj+GnF4Tw/MZ1KjElCuO6zpvXwBV
 6ugFx2tTNkG86esxAq8kaHIPjLR4KDALKcWt6HcIgIzGYIUaC7l2cimSwTigznSAJVW7
 21ALalDu0yWQDsuvngO/0GI53TwMTqNi2dvEBHsk54feHWBwtj0ApQJrbQFE0eNh1TsI
 SxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741696294; x=1742301094;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfnQ9P2LHwMNctM4rL26y4jTvPfZngOhgNrgDtSP5Ww=;
 b=ipcrtwQjtUPCwiRU7PwmBz3EEgTNYfyGoTphaDbNCeh4hPbEcgKbWKqviYwoYeQgHV
 pfEHwqsd1/9RC3IkV95irlE4LzU7gqJOdwlqk62y6d3z9hJq/DkNBxDBGZbQHTwEHrD2
 MVi6PHSHzyM9KjmJKy8V4eMWLhqSy079+npXYTBrXbdbhX6Yi8XMEeKCLAETV4p8NPDN
 2IYFqz0Xz2QtW1YUtYMsekESMxJgmxFdE0V8QICHeIOQp8EVnakH9gboU8K5ucFZYIUn
 /Xuw2/uhUKnzC9Zj8R4YwYTXMlP8KyygyxE/yte8PcPffghYDParIj0SjJ68uptno+JX
 2Pyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzaKLMT8DUIJCRISkiLqOLy1tQUjSaR+VQjzWbdGn84e60r1xfGgUzKAxJpJKSPJ0ObWOG+4g=@lists.denx.de
X-Gm-Message-State: AOJu0YxHQFshaTpLB9l/gVVEdrszsCrNMbxVE9SQX5dPcRdGdhHFo1d2
 XLEO9lrDP43e+58R2Q97N+PG7r7lS/Xu9ZuqXy2SMSiFO0dusxUifcK9dIJWU/M=
X-Gm-Gg: ASbGnct/fbwVWlHwFjH6QL0TOPvqnsTJU34D94KQA8CQP4fCu9kvf5CCdiWYMZybPiO
 Yd0D6pAXoClDfiDmmGGX429/jNzOvqMyKTx27GnuryRQSkLarGQzFJclu+nCV5Cg+O9ocrSwee/
 lKZbRpjvraZ2PhMBnzQieP6NIGgDAKcEKzZXlRk6GEviEzkJUBWx0PDhXIDU5FBDAU4qbu1yyUD
 FxLN13xLl9G8A/pZAUhLUuDiMEAEh8GXc2pc+yr1P9d9Lr2rx7xZvSVo3gpcIbG8XZpl7DPEsYU
 pDFgB7cbqfSa9bDgeG4vdDXTeVd59T9/lJueHvagdQXrLp41/KZdgPlpIwfn52OfRBF9e2kH
X-Google-Smtp-Source: AGHT+IH5pXDaMEkYkidm8iIoLHoD2G14jXSELxnpcIIlL8lZruf5610CsT/LN/NXEnuUPk14JmzanA==
X-Received: by 2002:a05:600c:1c17:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-43d0079b0c9mr68147495e9.14.1741696294211; 
 Tue, 11 Mar 2025 05:31:34 -0700 (PDT)
Received: from toyger.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:f578:9a7d:3957:bef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f44sm17788586f8f.76.2025.03.11.05.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:31:33 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 11 Mar 2025 12:31:17 +0000
Subject: [PATCH v2 2/4] cli_hush: support running bootcmd on boot retry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-qcom-phones-v2-2-83dcd88a6a87@linaro.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
In-Reply-To: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/7P6Po9fxiPAx2TRlvKNfd+3f1Un5SDWI9b3ciDbAW8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn0C0hMAnmOjLxS6t79aLMWeLX+r6RkrP7dZURA
 lemms7K9ECJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9AtIQAKCRAFgzErGV9k
 tnAuD/0eyQcQvG2eq+yw76ClaY40xZAyoLk8i6iFcrBLxXUzkDHUsE88G2o9+D5zdtRseZPeSml
 ggo2UB4HasE4yvrvMPykuPnqawSXJQr7XTBFk4Z0J+4STV8tVb+aynE2Q0QAPMA8kXkMNDvwNWW
 0KkGtPCxC087oCmuU1VWLR4YUKTn/PAylOG5mCxDMQ/RrQzShSYV0HWo/oquhLwEZVEE4SIgY5g
 Q/njH3rNxRtQMydf19ClsW6wugngjJqEsWnrP772rFRHTgon/S/rsaBar4w404CraiRkNHd94Sw
 YitH8lMhhkejSsvCTwlj/iWGPvKUsPWw9jBfCPGHTcX4a/rIODiikk3L/HQJSUNXKnV7qCht/iR
 x3EPjaLbxlZFdcvEw1me7vpxF2koRgZk1JpF5yzQWVCZKfVGAt7E1TPE7anMkxcWOe9Jb4empSJ
 a1ryYyf8gFwOZ4WmGYdMZlOVHuLNhNlXWyxeEUMVu+gOQMsoODrTOfK0mvDbQVsskxm+7yBmdXh
 tL6pU/EAEQv85QNYj87AwVoSVPktPd8OYw5NETn8mzzC9PcYFevjHlDGSLuLr/zpSAdBnYghTRJ
 pHjXRTd7r4TDGv+RWQEcB7ZdpmtetTRFdyqUDxqfg19ABrMrPDl+ZbuMIfl8hNpQj9qyzXtltOh
 827iyElfOW+Y7FQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Introduce a new config option: RETRY_BOOTCMD. When enabled this causes
hush shell to re-run "bootcmd" when the auto-boot counter times out.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 boot/Kconfig               | 7 +++++++
 common/cli_hush.c          | 6 ++++--
 common/cli_hush_upstream.c | 6 ++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index c09a98c3233ceb1c68024a193d7dafdce6b83903..4db13dcb9a51940c358f754d9ff91e88bebd96b1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1711,8 +1711,15 @@ config RESET_TO_RETRY
 	help
 	  After the countdown timed out, the board will be reset to restart
 	  again.
 
+config RETRY_BOOTCMD
+	bool "Run bootcmd on retry"
+	depends on BOOT_RETRY && HUSH_PARSER && !RESET_TO_RETRY
+	help
+	  If this option is enabled, the "bootcmd" will be run after the
+	  countdown times out.
+
 endmenu
 
 menu "Image support"
 
diff --git a/common/cli_hush.c b/common/cli_hush.c
index a6a8edce1f43cf4f28fdfc0d8da9b6e180c23cd4..bb134cce18dad8dddb54d7b038ca105853fc3eda 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -1027,10 +1027,12 @@ static void get_user_input(struct in_str *i)
 	if (n == -2) {
 	  puts("\nTimeout waiting for command\n");
 #  ifdef CONFIG_RESET_TO_RETRY
 	  do_reset(NULL, 0, 0, NULL);
-#  else
-#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+#  elif IS_ENABLED(CONFIG_RETRY_BOOTCMD)
+	strcpy(console_buffer, "run bootcmd\n");
+# else
+#	error "This only works with CONFIG_RESET_TO_RETRY or CONFIG_BOOT_RETRY_COMMAND enabled"
 #  endif
 	}
 #endif
 	if (n == -1 ) {
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index ab5aa5f9b36a91e09f8fcfcbb8b31afa0892e6bc..748ef60ac90b8af8052631c7ad3a6aed2629140b 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -2906,10 +2906,12 @@ static void get_user_input(struct in_str *i)
 	if (n == -2) {
 		puts("\nTimeout waiting for command\n");
 #  ifdef CONFIG_RESET_TO_RETRY
 		do_reset(NULL, 0, 0, NULL);
-#  else
-#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+#  elif IS_ENABLED(CONFIG_RETRY_BOOTCMD)
+	strcpy(console_buffer, "run bootcmd\n");
+# else
+#	error "This only works with CONFIG_RESET_TO_RETRY or CONFIG_BOOT_RETRY_COMMAND enabled"
 #  endif
 	}
 # endif
 	if (n == -1 ) {

-- 
2.48.1

