Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B08C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 19:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35419884DC;
	Thu, 20 Jun 2024 21:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JLBv1AKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD7288540; Thu, 20 Jun 2024 21:16:41 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C67B884DC
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 21:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6efacd25ecso69128366b.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718910999; x=1719515799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5PkW08WBuMQykPjUWpPxx8HLYDMJAfcp6bEzzIfQhg=;
 b=JLBv1AKpFAOP4DbGFZ+/GQ0zhy059jkhNR6phOOeChOetlcAWKPhmlRLwqzy0zhPEt
 kPYdN5Qwn5EPpv9Je0Osqk7/DuK/oeyZWGJy66zapR+Vex7PDzZkJAisdqAlMcxEz0of
 dj62/FRNTFPPwjc9VrBDdy+ss6biMVYJRGGFM96pCmwJ3kUCvcXQB3jt5ROiMLpu5WKd
 10q2chbfKwf/hCfl9dUirA/r7k4qYOWsJYZeIKdWnsvFfRPl3G1oMI5OEzpWKySEfQui
 jpnH2xmQ97jFFCd3co966uQcM0r0YkiS+wROktxMb6V48y2CsuRkAniyP6z4hwa5uJGM
 64Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718910999; x=1719515799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q5PkW08WBuMQykPjUWpPxx8HLYDMJAfcp6bEzzIfQhg=;
 b=PZ4ebOqrUoMxSDDBCfyvXRbAHszi9DGko9fojcgL0iAG5LJ0pBp4qq2yQStpafons+
 xVEQyH+4tonoMj0elMUdh4NdZBt34kKA7IDGpDhV5kbh6ueUkJRpOq0NMKxMwFmuYUwh
 z7Hf64tPoUGV3QN0YvfR5ZVq1BKW15+K/7YtoDU9WQD9ZubPUjVpPpNPv//WopKlGrWD
 j5nZhSNoZjd1bRu7tfJC1d15AANkpAStxlttrU0QJKTVeuf+xcT0DjhmUb3iA5nCkLpp
 qDegBFc6cRzyQ8QcdyPj/o0cRLtR6G49fDhiBxDDI5uefOPK7rBfqnWez8x74paY4vaD
 CeXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgKbhzG04L8seiHIOBTeLeEMUnSTucRatdK6WGxbGhaAw7H9k4O558PF1O1r7iseiDdQAyEQmeJW8iuMFikeu/J/UpcA==
X-Gm-Message-State: AOJu0Yziha3MYG246Wwb0Fy+dCs6gYS/T91vk5UCEstin+cFQEBuVmUt
 3RsDTl74QIZlEGT7L0dwYOVM9NW2AJQSnW+1fUN4sz+YCyKYqMVxEO3Ls1+7izU=
X-Google-Smtp-Source: AGHT+IFcXPc0KWuK5YRTGEjZnVWhqoZz5eNEXKBGZh1dLuTzcD+Rz3ZGrcoXvEPQUgPG23PD9bGTGg==
X-Received: by 2002:a50:cc9d:0:b0:57c:6d89:eaef with SMTP id
 4fb4d7f45d1cf-57d07e5224bmr5109882a12.18.1718910997982; 
 Thu, 20 Jun 2024 12:16:37 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da790sm10015660a12.35.2024.06.20.12.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 12:16:37 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] tpm: Fix return code, if the eventlog buffer is full
Date: Thu, 20 Jun 2024 22:16:29 +0300
Message-ID: <20240620191631.28811-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We currently return 'No space left on device' if the eventlong buffer
we allocated is not enough. On a similar check later on that function
during the call to tcg2_log_init() we return 'No buffer space
available'. So switch both error codes to -ENOBUFS since we are always
checking a buffer and not a device.

Fixes: 97707f12fdab ("tpm: Support boot measurements")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/tpm-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index a67daed2f3c1..91526af33acb 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -554,7 +554,7 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 		if (elog->log_size) {
 			if (log.found) {
 				if (elog->log_size < log.log_position)
-					return -ENOSPC;
+					return -ENOBUFS;
 
 				/*
 				 * Copy the discovered log into the user buffer
-- 
2.45.2

