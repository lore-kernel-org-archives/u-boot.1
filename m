Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42865CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E78A286F16;
	Tue, 17 Oct 2023 00:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JHGKyDk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73DEF803AE; Tue, 17 Oct 2023 00:30:39 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A78E86EE7
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66d060aa2a4so33752006d6.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495413; x=1698100213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IluBC/gf4pqcLMTvf5FT7kXwZ5ROxrWa6KpqjAPwOU=;
 b=JHGKyDk7J75syvh+tOET31aUoVLs29Oj7mPWRgme+x8ar+djjpwq1fBA2fcsZJfKqn
 d2DZk9FkOBgIQK4F6fG5SxaDfU/dwisPGprrmSC60dvNO03daYiFxfiQu43PyYDwKyp9
 EiCv98CeeZgao5GqqbVfF3xIfmqthz7iLmGCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495413; x=1698100213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IluBC/gf4pqcLMTvf5FT7kXwZ5ROxrWa6KpqjAPwOU=;
 b=gLor6EcU6LTPY39piy5YY6EaIuFFLi9aNP3MC8fJadgNjcLm8ZdmGkXN5/50Q0SbP3
 19iB9WPvDfluzHMpTvrYx4tJ1BaYXNwHioNjS+20SmtTMwhtCRCUy/1fByvW2k/xTXYA
 K1IJrHeFm/gl0y05G8/Q3JFXWfcL6bkAkZHgXXPLJxXhSX8fa6ldThPKt80gJ30s8a2f
 H8ImiOqXU9RXPwR1YTNdpYpRd4ra1XaWP0fZOF2tMXmoD042d2dkQm/Y8+XKavBPmA0N
 wy980fjtnwf9i6obbkuAU79OLAz6I4Fkikb4vl1xIsbQzUOmsqtISVz2ViBOgs6HLDvZ
 t6wQ==
X-Gm-Message-State: AOJu0YyiK2eihtdNGzM3KaGUjae0elfAsEUU5Qlz1FH0hl8ZNWPbI0Mk
 kJJ6H6Lrhao2lO/LKRVgeroJu/+Gxfsalo5HFgmxTQ==
X-Google-Smtp-Source: AGHT+IFojJDc79FgF/AvILCK0YovMWOiRikBUi2ILTUbWUhlDUcAfdZYBLbR4zpYkXQpf2z5tMkG7g==
X-Received: by 2002:a05:6214:230d:b0:66d:6a68:4aea with SMTP id
 gc13-20020a056214230d00b0066d6a684aeamr966327qvb.48.1697495412824; 
 Mon, 16 Oct 2023 15:30:12 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:30:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 09/32] cmd: Use an #ifdef around run_commandf()
Date: Mon, 16 Oct 2023 16:28:00 -0600
Message-ID: <20231016222835.596572-10-sjg@chromium.org>
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
2.42.0.655.g421f12c284-goog

