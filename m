Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42ACC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B04C82B00;
	Tue, 15 Apr 2025 14:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m2VDMv38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E21598214D; Tue, 15 Apr 2025 14:54:04 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21F182AC4
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so46512185e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744721642; x=1745326442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Slx5BgjoDoBX4JF/Wgw46oIdQr3egLbsyEFQeg8zqHM=;
 b=m2VDMv38teryhW8aqwHTE2tP/2ehxxPthRen5L684QHBm3xdkW98HfUDhNR7ebMqBv
 fCcB528OKP3ZLh6/6rD42GlZkOUj/zbzhkbcdZRtkcY4zZxoI8q4dYSG3t75EJfK70Hd
 pvJgylkqmcM4NUNNRdEy5TsXenESkf6HQWE3BF2HVkCrCWcb9ESyTW/TAm2SuubP+y1q
 3djVaLWmYcmgn5+T5ewPnLnkHfQWwARU4KM3sL9LZZ2LD9FJiC1sYODJrNDHu8NTQeDB
 naLLImQX/Ff0I0jdjI3CAzvmvSwuNE22f2MHQ79z9NGCghpFQAdUHQ4D2JwHQHTYakZF
 rz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744721642; x=1745326442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Slx5BgjoDoBX4JF/Wgw46oIdQr3egLbsyEFQeg8zqHM=;
 b=G3qh73/HMhruPXPXC/qRLabxZWL+4FEMEpGU8tD2p24u9nNXCXSwrxtNbR7oQVc5QP
 qHFQ8nAKQuhWe8AY/poQ1/s1qNT5BCdljfpDZueIgWnZ3sJXo6Z90zRjCsUATomzvyUC
 LW3Bx4jz37G1kS9IaEp5U+jHijtDbGiNPzA6OMWKkRyLfaSJLOibsqcsBiE9DjEke7dB
 Og5am0MVD1TgZ2CwOkC+yh8EkVhl5b+wjldLl4wrWGeWJ1KInHv4pKFi6fFYPqI6zEJM
 FI1v9OuK7uFJCdnSBl1yMJaloDIDQ5IDJBOgV8GANTddtFyn+0c9/1CTkcCFVGun5b0r
 yijQ==
X-Gm-Message-State: AOJu0YzYtSX8Sd0doDDdkl8W1Yv9aFG/FD7YNQpp9jqBYr6XNzFdwJHS
 pynsZs+2bhvv8DsZPmya5m5QVP+50mEHfYFe97gnfcylMHZEupcEnJ5TjGNKUMiYlhLFSCpd2XP
 RswU=
X-Gm-Gg: ASbGncu+FwoNvIA1u7VxOju7XMDnEYks+mpfpRYit0UhjjcwP0lraTHTkO8Qi80f2NE
 6fqvU/5hSbRPODWKCRGxVje0/WeDWLYNLiY7A6YCa854Kw7/XxlgZ8tEC1fLccAxaasMG8WbkLJ
 jYNl5qD3c65FMz0w92d1af3TiGZsmU5vwAtBh6iiIj9zh8S9wdEN0ZHntF34wx96ej0BBzW0cFp
 ApdObFSQxOZ5Zg5dCBo9FtdUlKfJxoDdi3e6AUdz8J56utbK6JXJfwsaR8VBpJ6+9yp4/CxtxKR
 hU6gxwSuLGuGbHXoIZMWEcFk9vyfukYGtS+xy3qwUGBf6Bid
X-Google-Smtp-Source: AGHT+IH2RhxykxUQdwhHhWrz8UyKM0oCdqzSRz0cGJ0xfGaCJMaEQqmz2bGp19CrS27Q9jvaUfYO1A==
X-Received: by 2002:a05:600c:698c:b0:43d:49eb:963f with SMTP id
 5b1f17b1804b1-43f3a9a70aemr142613455e9.24.1744721642233; 
 Tue, 15 Apr 2025 05:54:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8224sm205921315e9.22.2025.04.15.05.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 05:54:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] test: fix print_guid()
Date: Tue, 15 Apr 2025 14:53:31 +0200
Message-ID: <20250415125345.427420-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415125345.427420-1-jerome.forissier@linaro.org>
References: <20250415125345.427420-1-jerome.forissier@linaro.org>
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

The %pUs format specifier prints the system partition GUID as "System
Partition" if PARTITION_TYPE_GUID is disabled but either CMD_EFIDEBUG
or EFI are enabled. See list_guid[] in lib/uuid.c. Fix the print_guid()
unit test accordingly.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 test/common/print.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/common/print.c b/test/common/print.c
index e3711b10809..574c84b2eee 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -47,6 +47,8 @@ static int print_guid(struct unit_test_state *uts)
 	sprintf(str, "%pUs", guid_esp);
 	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */
 		ut_asserteq_str("system", str);
+	} else if (IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI)) {
+		ut_asserteq_str("System Partition", str);
 	} else {
 		ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
 	}
-- 
2.43.0

