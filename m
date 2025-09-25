Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1955CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5160983445;
	Thu, 25 Sep 2025 22:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p8KZ4/oi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC95A809A5; Thu, 25 Sep 2025 22:50:33 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5715832AD
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-36c9859b036so115351fac.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833430; x=1759438230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rE0DCgTQzCcZS8TBnN5C74Fgbo3fAb7u7aQI5OBEP98=;
 b=p8KZ4/oiyNFeaSpogRKIM6DFi+WQGR+ITqbxlFhGcNb4C88d7h2MFWWjgisXOMwNbL
 LuUuOJsDhyi/Tuoq1Pp7AtumoRLU5FeDguQF3kc/uF80CkuACBm09dZ+JhMtamdw9Fm3
 ZFE3ev70D2zioDj+VvLP/mWM3mrTk6oriqpGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833430; x=1759438230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rE0DCgTQzCcZS8TBnN5C74Fgbo3fAb7u7aQI5OBEP98=;
 b=WxzjanQXThNc5jjasSzONg+wCOhMQTvuXvI2op1juzmrxwUx+XoWDUe7D3kmUP/e6S
 AOtT2mA3RVTIo99xH77i1y8Uu2ZRtYNHX7GlFEQXAc2f9dJV8Tp/oC5L4Hyn7Gcz7NG+
 gsiHs4RxyXBXhfF8BcXn9wpX0p0b4mU61Wjc4f/ZlCkk/96PEreTxjN7oEqsz8td1Wxy
 CSehDQFhQ8qpCci+qvVDPZwcmBBpBli30hza+6AnL08262tDet0yGlm2pJtmpxv9ddyL
 GTzyr5Ci3qqTofAzHYSzWwKkRWRDk2CQZBg7ZAs8GQeESWMCo5yX4tc9DBx2fRbFEtql
 cwQw==
X-Gm-Message-State: AOJu0YxTwZ0hCxklWxkgoXrzxXwxcXZxj5QqQJsY8HYpu9yb5gBGd+N2
 +X7G35Po4sgtvRWEeoXI3xLLcKpY1ZQYCeTH2EVnXnEOlcNSKYob8YT5+ZpiIVCHcV8OBHILOsR
 Ss7sQwNs=
X-Gm-Gg: ASbGncvtnVP/3S44HfdUeVjiZgoaNvuTCquHjcJIP2UmViri6p2gU785bI3e9Do35dk
 6bUmCIzXkTiPqzEze4b4Zo7y8MDLtWMUmBQtfjYM9NCKovcGHNSlrF33ObEx2S/FEB9stkIGGR/
 5MKH9VOFxjOruGlZxxl6rIrcpBzHx9LzvQBO4FXRxcNZbaRkP6cDZXqdpX28LLpYJNTGuUQirKW
 kZi2UR0WileBgAXkMkfuxHIscTSIwQCFr45dRDtvwkd8fkxiEPt5s11YLqpUKf//6jIZIfHQ8u7
 8QDoOv5RaSzTxRPW8ZvTHNWT3eLxwUKn2Q+nIRVzP6oLHN+sPCuPO84icQB9UQQhP0FMpZOkWOs
 Nz6dAzSPTxrsC9WcMJiIxDnWJwIRW289i/+vaLatNzXuZlgzK2F+eil7IGtfbTZ7eNDAkTA==
X-Google-Smtp-Source: AGHT+IETxHir3if6Rns4y7Gs0DIcj5fseLCWtkgXO3lqGgVQ4mMvw/Q5s+1kJACGFuvqZZxJvrMl3g==
X-Received: by 2002:a05:6871:9c1b:b0:347:f43c:635a with SMTP id
 586e51a60fabf-361c6c6fe48mr1867033fac.0.1758833430525; 
 Thu, 25 Sep 2025 13:50:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a233315ea9sm610418a34.11.2025.09.25.13.50.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:50:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] test: syslog: Add missing include of <env.h>
Date: Thu, 25 Sep 2025 14:50:26 -0600
Message-ID: <20250925205026.3561694-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925205026.3561694-1-trini@konsulko.com>
References: <20250925205026.3561694-1-trini@konsulko.com>
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

These files was making environment calls without including <env.h> and so
relying on an indirect inclusion from elsewhere. Add the missing include
directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/log/syslog_test.c        | 1 +
 test/log/syslog_test_ndebug.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/test/log/syslog_test.c b/test/log/syslog_test.c
index 98b914365804..b6c0631aaf67 100644
--- a/test/log/syslog_test.c
+++ b/test/log/syslog_test.c
@@ -10,6 +10,7 @@
 /* Override CONFIG_LOG_MAX_LEVEL */
 #define LOG_DEBUG
 
+#include <env.h>
 #include <asm/global_data.h>
 #include <dm/device.h>
 #include <hexdump.h>
diff --git a/test/log/syslog_test_ndebug.c b/test/log/syslog_test_ndebug.c
index dfd0217c1e4f..a02d207ac0b9 100644
--- a/test/log/syslog_test_ndebug.c
+++ b/test/log/syslog_test_ndebug.c
@@ -7,6 +7,7 @@
  * Invoke the test with: ./u-boot -d arch/sandbox/dts/test.dtb
  */
 
+#include <env.h>
 #include <asm/global_data.h>
 #include <dm/device.h>
 #include <hexdump.h>
-- 
2.43.0

