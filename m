Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13725CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D0D86F47;
	Tue, 17 Oct 2023 00:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jGCbt2w+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9C186F0B; Tue, 17 Oct 2023 00:31:43 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA50186EE3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7741c2e76a3so331171085a.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495478; x=1698100278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igc0MjeaFEqfKXvw44tmzZrS222b/nE4xNlJFGf09Lo=;
 b=jGCbt2w+v/JuyPPUxN+5RVQ/CA/kVA16Y7OUTHMvQRX6wGjJOj4nYwMQKxllC0Y0f7
 n27sqz4S0uA1/UTBTAn+jhw4/UEC7g7VNgfrFhYRv+4ii0mqssPqlT5349XElJ7cHI9i
 JA1qEHjd+bFO+dgXTyt2rzSlZHg/pAptg6TvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495478; x=1698100278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igc0MjeaFEqfKXvw44tmzZrS222b/nE4xNlJFGf09Lo=;
 b=juTLcTZjfEgbs2VCBxalQH9QJHgwlEU5jzsD/dIukSDwemeoXm4SbYW/PHp2S/2g7f
 xGOLQkz1YEgbHun4QnWq0KFtckvdKXLEZGpynCx9r+BsabAO/O3rnwOegrJApCYynfwk
 C2bZN3iqmPgTdZbY+DMcX+3PcgVdrqdzdOcFprBzlopafQBwHs0c1wGxP9XCF8D75vlb
 uwq4BwBkq2VSWyqU/J1RrVhC3EtrUaE+oC2Yztc5jkw0UNZBd5BKj31kCNc6MQ0phZIE
 KZKMvWwmDMFQGiOAxHcjDQhGsJGxaCxgls9i3bvLWKQJ/E0nyC41nKW9a8Yj0Z0KKTcA
 WBrg==
X-Gm-Message-State: AOJu0Ywk3fMrm156NikC9AjYQ5+3euZURhzKNfuZFgpPeDbedx7G+cE6
 V7IPA0bRCWEfiEVE4qfuxdk+enQplHIybLkpzdRNBQ==
X-Google-Smtp-Source: AGHT+IFArxF8cczfxOcyVj9wqWlOv5xWe9jl1U3Ul+RzIbHOLV9dYcofzomwYZJOyi+W4Q2jKvLytw==
X-Received: by 2002:a05:6214:b6d:b0:66d:a40:13a7 with SMTP id
 ey13-20020a0562140b6d00b0066d0a4013a7mr817773qvb.47.1697495478358; 
 Mon, 16 Oct 2023 15:31:18 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:31:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/32] log: Allow use without CONFIG_CMDLINE
Date: Mon, 16 Oct 2023 16:28:08 -0600
Message-ID: <20231016222835.596572-18-sjg@chromium.org>
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

When CONFIG_SYS_CBSIZE is not used we need an alternative. For logging
it seems that CONFIG_SYS_PBSIZE is a better choice anyway, so update
this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/log.c b/common/log.c
index b2de57fcb3b8..72a4de3274c7 100644
--- a/common/log.c
+++ b/common/log.c
@@ -206,7 +206,7 @@ static bool log_passes_filters(struct log_device *ldev, struct log_rec *rec)
 static int log_dispatch(struct log_rec *rec, const char *fmt, va_list args)
 {
 	struct log_device *ldev;
-	char buf[CONFIG_SYS_CBSIZE];
+	char buf[CONFIG_SYS_PBSIZE];
 
 	/*
 	 * When a log driver writes messages (e.g. via the network stack) this
@@ -268,7 +268,7 @@ int _log(enum log_category_t cat, enum log_level_t level, const char *file,
 		/* display dropped traces with console puts and DEBUG_UART */
 		if (rec.level <= CONFIG_LOG_DEFAULT_LEVEL ||
 		    rec.flags & LOGRECF_FORCE_DEBUG) {
-			char buf[CONFIG_SYS_CBSIZE];
+			char buf[CONFIG_SYS_PBSIZE];
 
 			va_start(args, fmt);
 			vsnprintf(buf, sizeof(buf), fmt, args);
-- 
2.42.0.655.g421f12c284-goog

