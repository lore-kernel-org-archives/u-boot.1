Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DBBD1AD39
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E74CB88E02;
	Wed, 16 Oct 2024 11:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rw+Yn9J0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6FCD88EE0; Wed, 16 Oct 2024 11:57:16 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF74988F92
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4314311959aso12611735e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729072634; x=1729677434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDutgpxnTxwKCYIiIQtKGwPjtjM6oNAFy+W630CdG0w=;
 b=Rw+Yn9J0XifmOoF64muDMMZsCgi8HXi88WkSZ5+BZweWMMqNa1scevJThnfPjkyiBt
 yPwKlvEsOJC7p2I6if5kE83KBBW/6T0GUT50v97eIzIJi+72n9+oCCaA/CCDrUnKa9SA
 aHpvrPrcL/62NgeMGYjgRp0GqXnf1DTI3sQSoG5KNDLmwd31UN6geWz7UCZVKqNHRKgQ
 CLuEVBzAlZK/ZmyHiifcfH2f9Ga5SGh8dwEk+MRWfNLJGMUAAhPVsqqs9r9ejnLrsoSF
 zZQXfGxgZq50v+4pXE2CPsz7nB1hnPKaKzRYAeJ5VnMZXZD4+WC4xADFFc2R2orI++Nn
 WwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729072634; x=1729677434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDutgpxnTxwKCYIiIQtKGwPjtjM6oNAFy+W630CdG0w=;
 b=nACaX3TYtIHgaPA7kde1WbYk4eOK/Gm8/U6UVNt/QkApYRF/dU8xNENIdyU4SfVY9m
 IsecpS6VKq/7sV7hN7rRkDwHXEJppD8Z4k6iZFnTt70JhchRVvdd/Ce2oTUbt1NSjFs9
 RkYQ/MP/hAYx6r5floI/b2k2eUET/Qd0jDg+rsMdT3V9nMqMmkuDj+MwJlrx8Nn4naXP
 JFM6tmSO5RDAJoe+YKeF6H0kPI7FuMTctrm5oEn+G6wOyMywYjGU4kN90XqUUakHRkKX
 YuK8kzwSjpj//pLa/WiAyQX5VQ6VwsLRAGYi45R8bsMQ8r+WQVzky+Qg3xtMbluUcUwN
 3jCA==
X-Gm-Message-State: AOJu0YwhDk92Yn5v/gayx/nHigmbwQ8L5WLdgNt9pbBxpufI30RMykum
 ofvoxkvqcYoEKwP44XhjahyO0yIhiI8zJTn51OZbhomWi5rZ7tnVfZebS7xECMTszIizQLrbsu0
 86wEREQ==
X-Google-Smtp-Source: AGHT+IHMTlMYZ75Gnbk1czpvpfYdQs47gfUARBtPoavM0aFTwmnBXVFWyRvpSUYSgmdk6UtVIp0HRg==
X-Received: by 2002:a05:600c:468b:b0:42f:823d:dddd with SMTP id
 5b1f17b1804b1-431256099e0mr106376265e9.27.1729072633991; 
 Wed, 16 Oct 2024 02:57:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b1ebfsm45236335e9.34.2024.10.16.02.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 02:57:13 -0700 (PDT)
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
Subject: [PATCH v13 04/21] test: boot: fix bootflow_cmd_label for when
 DSA_SANDBOX is disabled
Date: Wed, 16 Oct 2024 11:56:26 +0200
Message-Id: <3baafbab154d05c19ce882ee0b23e426daaa231e.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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

