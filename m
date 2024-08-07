Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E0C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77657889D2;
	Thu,  8 Aug 2024 00:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QWkgewma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38CBB889A3; Thu,  8 Aug 2024 00:48:09 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2512188440
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39b41306b4dso1511675ab.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070886; x=1723675686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2wNqzT5MB3WU3QIYPvENWUo2cQMUiJ/5H2QOdCb+t0=;
 b=QWkgewmay3j776PC8qQPtRDT3T/PZNdclaoGRY8UyuIFZUtY1DL0FA43DFnBce8RAk
 fV++MDk9XKMVTIuGGGQOu+K/cXwwVZILcBUV4iHSdwejVVeBxsHA41h+TiYDXXmBGcge
 IGk+uvXfd0/NzKhJ8GsUaSxOLkESDZvBdKDmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070886; x=1723675686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2wNqzT5MB3WU3QIYPvENWUo2cQMUiJ/5H2QOdCb+t0=;
 b=PwyJ4bfnjYZ6kGREkEO17h5wTzNmvlVySBA1RMyEFdwEwoS2SDzKl1cS5VxQ2KzrRJ
 YldKhaS4NMe1HPjImYXuy3QKJGfZioTip3i/4xY5gSFh8SgTBOpIfgGR8ZHkh0N93apu
 xSXxOd0J/PNB2OMe9AgjIfbyaLt2C04Ui8q0PFjhgbJW0/uqOyxNt80KWvBILqScmQD8
 F6NJAG75Q7fUPhrT9dvtEHJQ33jn1RU3uQv227EPILe5MbdqZz2LCijoe0HwohQtjb0q
 mGORQ56iV5JMFaVeJhyDwRJ3guZ6rdYRHMp/+wJs9MvRZpU57AVeqzeJo3M82lUbv9NF
 ESqA==
X-Gm-Message-State: AOJu0Yyd/S0Jd3Zl1H9j/maCulCITZCqOBEUmca3nWgSN21DnOMY2VQZ
 H5NfHRZshhbNwAI2mVH+ifOB66igSDxIlMePZ9HTnwzqXkABSFya17DGqccUAdCZ9D4d0xAJ2II
 =
X-Google-Smtp-Source: AGHT+IHO1f6r6IMgBxaCXiiuQh/qS8j+6MZlumFMSClXUB/+nOEOoEDUYDYD+6yT0Q7jTYcTKfLegQ==
X-Received: by 2002:a05:6e02:13aa:b0:383:5520:cc48 with SMTP id
 e9e14a558f8ab-39b5ebd5d9emr1548935ab.0.1723070885782; 
 Wed, 07 Aug 2024 15:48:05 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v4 01/21] sandbox: Use const in os_jump_to_file()
Date: Wed,  7 Aug 2024 16:47:19 -0600
Message-Id: <20240807224739.3858517-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

The argument array is not changed by the callee, so mark it const.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 arch/sandbox/cpu/os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 46ff305b536..a04eb5aa18c 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -808,7 +808,7 @@ static int make_exec(char *fname, const void *data, int size)
  * @count: Number of arguments in @add_args
  * Return: 0 if OK, -ENOMEM if out of memory
  */
-static int add_args(char ***argvp, char *add_args[], int count)
+static int add_args(char ***argvp, const char *add_args[], int count)
 {
 	char **argv, **ap;
 	int argc;
@@ -859,7 +859,7 @@ static int os_jump_to_file(const char *fname, bool delete_it)
 	struct sandbox_state *state = state_get_current();
 	char mem_fname[30];
 	int fd, err;
-	char *extra_args[5];
+	const char *extra_args[5];
 	char **argv = state->argv;
 	int argc;
 #ifdef DEBUG
-- 
2.34.1

