Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4C7CFA773
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F3988D16;
	Fri,  4 Oct 2024 14:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="clCquY+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA8588D06; Fri,  4 Oct 2024 14:47:02 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C19FE88CD9
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37cd8a5aac9so1236160f8f.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728046020; x=1728650820; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u9KLP5FOx6Bo0jaIjsv0hlcKIHeF9LooYOlxMGvfKw0=;
 b=clCquY+ajcj1+mO5koSZZcOd8R8IM1PQzcb1QOZ24TnmKddYWwE0aaVR1X5hSRntJh
 GRS81f+AnfaM0kaTLx6ThYLxMVyfIW1iSnQVKH6m52mqaOc01YuNyfBf3MOrUf7iIQUD
 6UaaFG9CI7flG4oGeZactlUFKN+vRCofBlfyHbLwFMnTVtxjmm1HMCQP/MtE9v904hBZ
 w/lxUd+X+90dw8uwqytAg9lckB+4k3wMhULr7vMHVP2X0DIVvfhGUzRKCHOAzBlLXgZt
 uePBCZzEuI9tD9AlFGdbRQ0TAAPdb03/BAoDSEKYAgDVG5YFQqd+BOnzPBiXz7j6IFY+
 7wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046020; x=1728650820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9KLP5FOx6Bo0jaIjsv0hlcKIHeF9LooYOlxMGvfKw0=;
 b=orL3IYbeJpDuE6+Wov7cTYLJdffbkeE1QU9zJWcz2wULBbyLVsqvIHf8thnxYFhbc3
 P1286KiSR9dbParcIu0lWKUdXJHBrhuMWUeNc3qUCl4YhYBz1xdx/xrQ5MpQ9of9kg9y
 NGz51l6g0DbTy9u8bx1dwtXuZ5XtfzIP7hsodVx0HH2f4enRbfxCGkKJN5KDNgZoiFr5
 ejtWUUV4jWraQGi2eiSv3+JDarp0oRdWagfw085qOUeq9dos6HTYq6PLjriR/nmmzwol
 KneVHEMGsqbI5AK1eM4JUhOXwL9qlmfs/ob6xgG2i+5809s3URq11dAhWihNPbAFnugW
 JpXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZmI8R4Ao2ajQzPeIUKfhzdV8LPm/7Ws324TMbB9vi8TPOVQRs/dMIG7IsI2sno5V9s8ppp1U=@lists.denx.de
X-Gm-Message-State: AOJu0YwTY/aigW9//1fKgDjfm+HKz3BTw1rqpyvApDJY5fwrgH/+12M7
 BENhrei/ru/oA/Cl36fz0ZeyAKLoHqVo5RZejcJewrdMr3ZZcUWjwbnDowLNuMg=
X-Google-Smtp-Source: AGHT+IGU2uJ1uGDk/LcVu9thSRLkUu34k9qs4miX/wUHSvrZYnDXFvOcQHCHjq0+Vgio3peO5fWQFw==
X-Received: by 2002:adf:a18e:0:b0:37c:d54c:a41 with SMTP id
 ffacd0b85a97d-37d0e7d53f9mr1316725f8f.54.1728046020246; 
 Fri, 04 Oct 2024 05:47:00 -0700 (PDT)
Received: from [192.168.2.2] ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082d116asm3177348f8f.90.2024.10.04.05.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 05:46:59 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 04 Oct 2024 14:46:51 +0200
Subject: [PATCH v2 2/4] cli_hush: run bootmenu on retry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-qcom-phones-v2-2-c7ab67ac3043@linaro.org>
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
In-Reply-To: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kaYQI0zyLNvzBPqx8uuUc47F/KfM0yjRzhQDdSMXTC8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm/+O9k7bID+/pHr1nyRwpnzZ6oHBudXIIQ8371
 Kfa+gmrxpGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZv/jvQAKCRAFgzErGV9k
 tpGPD/wNYklsuf0HENyk/cYeQv8CJjIOOtg0dyMrZqiF5swpBvYXdgNtO+SLGkHeTGy2Rsuzp+m
 +kY/SSxbTPbcaBoJYLvD21d2RIYmgXuY4Ht4C2I/7N7wjRCKIKen++4BBCaVc5P678uIRTd3zrQ
 RuhaNrJ+UP7pV/HdbcloWb1eYwTFU5YOmYAZuWRVX4jNn4rWoETvu9WCO2d4WkC4p2hM4wNI8wW
 zXQ+OLmRDxGWGjJP1TYhDzqU17x55rR9Rmp1dX1JiwaLFGQ/hOT8LKxg16igQReLDPk3oGTZEls
 fjKX6RFDAKsXFdNaGLzonKcwtNBLUDWdMNjjh3MVC+Kb6wc2cTn/U4OYmN8ge/CJpXwmjLYsVRu
 Qd96xEwE7gvDtIpRTceFWODW3Khgfqt4JHn+WArS4nVF5fVR8qvgJzHZfPgOUR7XJLLwUvCW3Dc
 sI/am6E0gnTbIyP+TFx3q9o1QdBeh93glOOx6TgZgAE7oCfR1M+ZXS5m0JQ7B1kHZttRTLXkfz7
 qXxseSu/RtAc+4QhfJZzZsIIN6SaPkqh3ox4ScSPf8Mj2g+Q6DNB7GPEU5UQIP3u1Gtn3iAw82b
 YEyWyicQP1fn8w86zldt/3ffr4DYaXic268EI4ti+kn5a52L3XiuaJkckOvzPzv7fVmTxDc3p1V
 XQMeQSbQM85oQ7Q==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

When CONFIG_BOOT_RETRY is enabled, make hush shell always run the
bootcmd. This is an improvement over failing to build.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 common/cli_hush.c          | 2 +-
 common/cli_hush_upstream.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index a6a8edce1f43..3c6fd6f00a1d 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -1028,9 +1028,9 @@ static void get_user_input(struct in_str *i)
 	  puts("\nTimeout waiting for command\n");
 #  ifdef CONFIG_RESET_TO_RETRY
 	  do_reset(NULL, 0, 0, NULL);
 #  else
-#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+	strcpy(console_buffer, "run bootcmd\n");
 #  endif
 	}
 #endif
 	if (n == -1 ) {
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index ab5aa5f9b36a..93eb0d85a95a 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -2907,9 +2907,9 @@ static void get_user_input(struct in_str *i)
 		puts("\nTimeout waiting for command\n");
 #  ifdef CONFIG_RESET_TO_RETRY
 		do_reset(NULL, 0, 0, NULL);
 #  else
-#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
+	strcpy(console_buffer, "run bootcmd\n");
 #  endif
 	}
 # endif
 	if (n == -1 ) {

-- 
2.46.2

