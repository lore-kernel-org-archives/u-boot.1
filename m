Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3627CEDD99
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4F28924F;
	Wed,  9 Oct 2024 16:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="htWuWAQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85358924E; Wed,  9 Oct 2024 16:03:48 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D2989249
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37ccd50faafso4457596f8f.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728482625; x=1729087425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDutgpxnTxwKCYIiIQtKGwPjtjM6oNAFy+W630CdG0w=;
 b=htWuWAQ+F3ZenDoTfaCz1N0X5k6QOQS86SO8sGL4CtHaDOWjpcTy4l/S0uV8jTeWCn
 KI2qlFzdL2eKQcjm/Rvxxvh5wR2x9nXNN+28aKdo3nDCIXkFfKLGsKx/a9nuTj0+hqmX
 yfTXtNi7JfmMI9jxGOtq+HQBSl5x8MfBBxVJMiEKgqJvUbYONsyjKaZ+C3BmOV8DO8Ai
 0DcxhVKX6v6TDRZuwpfiKhPoo+FUL0/1h+TTGVkOWOBio4X+PvlHd5T3l6rNgLgUdRyd
 x1AEW1WbROLQVKD1ghgITEpZN6DRl9xU4yiCy6Zje6E5je+5xOwN132U9aeBWP/BaNmr
 bvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728482625; x=1729087425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDutgpxnTxwKCYIiIQtKGwPjtjM6oNAFy+W630CdG0w=;
 b=OKqeiIPXIgZ545NV0YDP/dyHK9CsiQi8UvKsSIt2bib3/j8pUbfiWXk5GUK4cM/6fV
 joc2uTEj+2NMg5Z8QWc+/X/QeQA8niWHO85NwDmon9n31tfapM+znJXaK35Wb+SJtlZz
 oom+ISAlGrU/rfs+mXn+u19Gjud5elsG1pfYOElS3ymV8SMgGMk/p9nECZrLCZdOF/fY
 +wTstcbb2S8/j9sDmiwMD5ExHeG/jBLzQjtafYqNEIijwY7hWP7kGBCe9CIk/6/h8zF0
 Z8UrfwhHOBs7Reu0UVUEIsaVR9yQnlvPKicQb9lpDJQX2WX+p62U+kuAUOtj+bZS50fC
 mhKA==
X-Gm-Message-State: AOJu0Yy748fKucWEsK4vDCrYDwqmNn1wdKngb6lendL82B5y6f0n2c79
 2qQA026XDmw96rmzG2CQwFxFWJeC0VIyiJRkZ/F5ARak5zp2Hyn70chf0OWLuN8EsZyPCGTsCdv
 dRHVA0A==
X-Google-Smtp-Source: AGHT+IGb4cK960dl0XzMoKbW9lgwB/qoS7yNvn8HL3uAUDu6CzaWqjkONeuaO3EAVvBLVrbaPwcilQ==
X-Received: by 2002:a5d:650e:0:b0:37d:3a76:be9f with SMTP id
 ffacd0b85a97d-37d3a9f8712mr1620277f8f.25.1728482624573; 
 Wed, 09 Oct 2024 07:03:44 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f0b2sm10581728f8f.9.2024.10.09.07.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:03:43 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 04/21] test: boot: fix bootflow_cmd_label for when
 DSA_SANDBOX is disabled
Date: Wed,  9 Oct 2024 16:02:54 +0200
Message-Id: <efb9f4894e0715b0b7619d699b4a288a37d4bc15.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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

When DSA_SANDBOX is not set, the sandbox tests fail as follows:

 $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
 [...]
 Scanning for bootflows with label '9'
 [...]
 Cannot find '9' (err=-19)

This is due to the device list containing two less entries than
expected. Therefore, look for label '7' when DSA_SANDBOX is disabled.

The actual use case is NET_LWIP=y (to be introduced in later patches)
which implies DSA_SANDBOX=n for the time being.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/boot/bootflow.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 6ad63afe90a..154dea70a59 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -109,9 +109,17 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
 	 * 8   [   ]      OK  mmc       mmc2.bootdev
 	 * 9   [ + ]      OK  mmc       mmc1.bootdev
 	 * a   [   ]      OK  mmc       mmc0.bootdev
+	 *
+	 * However with CONFIG_DSA_SANDBOX=n we have two fewer (dsa-test@0 and
+	 * dsa-test@1).
 	 */
-	ut_assertok(run_command("bootflow scan -lH 9", 0));
-	ut_assert_nextline("Scanning for bootflows with label '9'");
+	if (CONFIG_IS_ENABLED(DSA_SANDBOX)) {
+		ut_assertok(run_command("bootflow scan -lH 9", 0));
+		ut_assert_nextline("Scanning for bootflows with label '9'");
+	} else {
+		ut_assertok(run_command("bootflow scan -lH 7", 0));
+		ut_assert_nextline("Scanning for bootflows with label '7'");
+	}
 	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
 
 	ut_assertok(run_command("bootflow scan -lH 0", 0));
-- 
2.40.1

