Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E625CC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1A688BDE;
	Thu, 22 Aug 2024 15:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cT/bD8CM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBF588915; Thu, 22 Aug 2024 15:58:28 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58CE88B9F
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d31d16d39so2952895ab.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335105; x=1724939905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSmg8Jrg8O+lr/z0XY2gJXEMvm3E8y/EMLzIzK06i7c=;
 b=cT/bD8CMKcsnyrlgDJummUvM5sazXjV3mse2I2RN+Lr9zEmDHPp1lH1eAbwQfGpCms
 kRzw1d094iyCA3EyonGvOm4XHqRFgL4Nr6AaeJT5zJuX3UqV4VBFZXxy7/9ZjkLGtidd
 OPfLIbtcKKe6U0loxS4F4V/72eqs9l6S7OD/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335105; x=1724939905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSmg8Jrg8O+lr/z0XY2gJXEMvm3E8y/EMLzIzK06i7c=;
 b=allrRm5wkHP3W6wM/N5XkyWHgJVraxl/quoNV3DTu4BqkpttG1jGSLzsZd75R21Y/C
 uXDXOd+PZ5tRYQ1//8OZoZFqHhScWVGVbcvqW0wT5ghIACnC7Km+Lavln6NZGQ38le3O
 GAChuB+bQtrkhgDSj1HS/0DiTFuatUtn7op/9n+iOrJVlV74pykjTe4Jw1vksRQjlmIf
 IlfZ3v0k4IXME+ixhSkQiNz1bFzntrFudix8wKco+TZ+WYkAMS62lLergRR2iQqTmoBq
 JFRvvep7gK3Os6Z2uNwotUtVL0NuUH1QP1nQcbwG/E1kppBIeV2L4MYE3IZrz+h57/K4
 IwvQ==
X-Gm-Message-State: AOJu0YxZ7Ob2GYl/xPVe9zSGHmv9Eer59dwIkO79pjwdgrmnONxew7FH
 8cYdCnOWvSAZgBxrHFlBt+2a36BYVE/uZ4sSaqDBOPtVev+YJIycKnDRcI8G/MQurUIfRW1Efu8
 =
X-Google-Smtp-Source: AGHT+IFJupTOvilvBEO7d8RyhcgLdspaVL3WpY8txrLuKQd1kvBKY1vLup8EPYjTEST9pQP0hgLeqg==
X-Received: by 2002:a92:c26d:0:b0:374:a781:64b9 with SMTP id
 e9e14a558f8ab-39d6c38f753mr71076025ab.13.1724335105313; 
 Thu, 22 Aug 2024 06:58:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/19] test: cmd: Use UTF_CONSOLE in tests
Date: Thu, 22 Aug 2024 07:57:57 -0600
Message-Id: <20240822135804.2375959-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

Set this flag rather than doing things manually in the test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/pinmux.c | 3 ++-
 test/cmd/wget.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/cmd/pinmux.c b/test/cmd/pinmux.c
index 0b4e001fa1e..7ee92690756 100644
--- a/test/cmd/pinmux.c
+++ b/test/cmd/pinmux.c
@@ -36,4 +36,5 @@ static int dm_test_cmd_pinmux_status_pinname(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cmd_pinmux_status_pinname, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_pinmux_status_pinname, UTF_SCAN_PDATA | UTF_SCAN_FDT |
+	UTF_CONSOLE);
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 1ce167c4ab4..a91aa24722c 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -223,4 +223,4 @@ static int net_test_wget(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(net_test_wget, 0);
+LIB_TEST(net_test_wget, UTF_CONSOLE);
-- 
2.34.1

