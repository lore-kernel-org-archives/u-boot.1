Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD6AE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6665580431;
	Wed,  1 Jan 2025 23:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ITQR3cyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69FDB80600; Wed,  1 Jan 2025 23:13:11 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E13B803F6
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so154416555ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769586; x=1736374386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AS81SLHzgXToSdhsJG0npUuvatc5Zm5nr85nFCNKw4g=;
 b=ITQR3cyXKDhGTlFE3jMDPkQfPjATS/HQ64D+tesFTJ4OdM8zKHjqwNSskTnOpnCCia
 e5bgHgEB3NIZSTHO1rvXw9P2QcYYUEN1aahnQKjNwBGR2EO+55Vr9lwEsLMicZB8cRjC
 TI2I6PEPWOVrVaDyxOnqS/8YfmfMfV3fFRwaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769586; x=1736374386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AS81SLHzgXToSdhsJG0npUuvatc5Zm5nr85nFCNKw4g=;
 b=ivz/Hc5I1+F7xtqtmyBYKphCy1jlX5aKW0cI9F1bV9cw1pvEroDMWyD3hWaaGglX0G
 /xMB0YoG1QIgNtBS/8bkc+Pa8HCfm+NsjnWhUnLvqYB/X84D7KrY9gVFdlAb2w6fIdzy
 0o827oNANlTTyYyisqztNeoBZraV06zrhbXb+56gxPMEYChjHBYm9ZO9lzdKIqfMj3nY
 rsHE8DY2WOW+ZX3wAdH4STb5vz/28/i/+3Rxm04iySnMePpbGxi9bLtCNjrFNNb3IkSP
 +kHJnw5BRm5m9lcOmhOahmr/dA2EjdalcE3yYZKaagZD5pRhxarb9mjtHwZ0ZMU3KRbJ
 OKIg==
X-Gm-Message-State: AOJu0YxEg/0xZBhNJj3PjcPMxfJDfddvhMNlOjXokdvaGwNcZID5pqMu
 zxlKVjWGpbEUGEEGFwrfoAJJW86QKSz7DeBoau3yG61V1oxhKDygnGRaJn+qrk1dd7chA82ZvPE
 =
X-Gm-Gg: ASbGncvhiVyl3WdhQ2nQmDmjUOXoOOzZfeabYazpldbwO6U8ArSZwBuEb9lLQNy7F3d
 /VK/NZge5OOwwVxpuVWk57H/3HlKolyJiBD3CA94Qo41dM+qupSuAqFAk/ShldDqASrk35yuo83
 7T5YC/67+gccWwNZhrJf+ZXMVmwJ2F5HmU4azKpBB82J+voJj2xxMBjy0ieksEoikW4zF6K2dN2
 FohojQk5cQQqrwX+yPMXyv0d737CAZVUUIZtAPfoA6NoOLJ3zuWP5s=
X-Google-Smtp-Source: AGHT+IGd9xV4g4yQoP37Yw8Bu0B35WJwWjJaxRz5O3U8NAy7dt1t14pMNZnkncfQRQZYo79u7orexw==
X-Received: by 2002:a05:6a20:1593:b0:1e1:ad90:dda6 with SMTP id
 adf61e73a8af0-1e5e1fa249amr66917959637.20.1735769586661; 
 Wed, 01 Jan 2025 14:13:06 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:13:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/67] upl: Support writing a UPL only for testing
Date: Thu,  2 Jan 2025 11:09:11 +1300
Message-ID: <20250101221003.1944600-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The existing code works only on sandbox, generating test data rather
than a real payload. Add a check for this.

Eventually a real writer will be in place.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/upl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cmd/upl.c b/cmd/upl.c
index c9a823bbc06..d8d46cdf34f 100644
--- a/cmd/upl.c
+++ b/cmd/upl.c
@@ -56,6 +56,11 @@ static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
 	ulong addr;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_UNIT_TEST)) {
+		printf("Not yet implemented\n");
+		return CMD_RET_FAILURE;
+	}
+
 	upl_get_test_data(&uts, upl);
 
 	log_debug("Writing UPL\n");
-- 
2.43.0

