Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AB4CF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD70B88EBB;
	Thu,  3 Oct 2024 17:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KM4EyZ17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE5E588418; Thu,  3 Oct 2024 17:23:46 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF29A88418
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42e82f7f36aso9846695e9.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969024; x=1728573824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Jltn/X1Y1l7bLIIzXvV51M2plK+/RLLaLwiXUPWAo8=;
 b=KM4EyZ17CLwK5YKm0ZmBRxismDvm0DPGaERNxKQIC2bhBloMmWfk0gaN+CVZZvoUx3
 ho5i5zVBKhxE30dGK+CA1D9wj1Ex6SQXLX//g0uJ/cJzzQLWa1JwwK/dGxMJyk9JT7d7
 SHi5VN7z76Gnw3iD1OgytamufOTTLwZpiNgt9VNy99I2IGcNjAChykkUQLOK6ihwsW0m
 h/1U5nf9tYe7u8gMpPXKVJjlwZQlleoDNlqHatYODP6VV3nIxpoaR7dQ/ua92ElbU5w6
 BPf9wuuZj7hfGvAbFvXxyHKR+8xjcdfyN+SCzhBtgYfoqiTgv41semcqcKBGUZY0Jig6
 XMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969024; x=1728573824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Jltn/X1Y1l7bLIIzXvV51M2plK+/RLLaLwiXUPWAo8=;
 b=ER8v840aQtbxb3OokHOFrMa8Pgd4JFmzcL3Ht36GBTT2XTP4QDVW1gpnZXzui5x/wj
 1wlkLyo1OgeAFKKTAOumxIy4/NbeT1R7ZUEsek0du741sLjMHp2jeenf1AeUXSlEukZl
 q9tN8GlbBF5fmL4f7JwchNbcXRdhm0Pxq3EUtHPL3FSY+0BOLDrlKUYwSP4YoZVfDHoX
 l1xW26Y0MXuql23P6VMc6zxByZA1UphVzu/9254VEej5HyC6R3p6fEKOlng0nXKTkgUw
 wSmexmKJ3vo8aQG9zrCTHevaVxMFO0kK/BzciY5p7s340Lbz0CMcAUlqk80I9s35wNo4
 UTAQ==
X-Gm-Message-State: AOJu0YyYrzrzf0LEmrZkbPSfd1OCNQSerqbF3Mfr6XTJlEuZIk3Uv7Jb
 pGlgrkJkJwVLawyvThL1XGInWaSNKkfNucizK/fXvrlwSMro6wF3lWSeAIbdWazE2O9hekPI4PM
 +txqFHw==
X-Google-Smtp-Source: AGHT+IENAkl3uxp3sqhHhO3Up8/Uv3OEP43FxiIObREDt8GLdN4EFR3mZiowLUPMrlS4cNUalm5t/g==
X-Received: by 2002:a05:600c:4f4d:b0:42f:80a7:84e0 with SMTP id
 5b1f17b1804b1-42f80a787c0mr16786935e9.32.1727969024153; 
 Thu, 03 Oct 2024 08:23:44 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:23:43 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 06/29] test: boot: fix bootflow_cmd_label for when
 DSA_SANDBOX is disabled
Date: Thu,  3 Oct 2024 17:22:52 +0200
Message-Id: <2e8206d8bbd7d3140cf2734ca9b3fcd12ced4f14.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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
 test/boot/bootflow.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 6ad63afe90a..c440b8eb778 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -109,9 +109,12 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
 	 * 8   [   ]      OK  mmc       mmc2.bootdev
 	 * 9   [ + ]      OK  mmc       mmc1.bootdev
 	 * a   [   ]      OK  mmc       mmc0.bootdev
+	 *
+	 * However with CONFIG_DSA_SANDBOX=n we have two less (dsa-test@0 and
+	 * dsa-test@1).
 	 */
-	ut_assertok(run_command("bootflow scan -lH 9", 0));
-	ut_assert_nextline("Scanning for bootflows with label '9'");
+	ut_assertok(run_command("bootflow scan -lH 7", 0));
+	ut_assert_nextline("Scanning for bootflows with label '7'");
 	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
 
 	ut_assertok(run_command("bootflow scan -lH 0", 0));
-- 
2.40.1

