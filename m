Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B8DCCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F7683631;
	Wed, 15 Oct 2025 17:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HHHKtQSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65F483693; Wed, 15 Oct 2025 17:45:10 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BBD83631
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-57e36125e8aso2880386e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543106; x=1761147906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1t/wjuT9T3FmCe0WEb6xCNvYEdLZ6G8bB0Zd1Sk8ws=;
 b=HHHKtQSCbGqJJ+x8N+HrbkZd9VLqF0CWtFYTSDjbF+vk0aLajEfEeAX1vVJl+JE6Io
 ZU+fZhDcGLrRXpp4JvtS1VVA3axXj3bKLyLif77Xz4RQuCVdIbTAWW1qgbnNtknEYPUu
 brclOVa4BDrbLHUWOkifHP5n9ogSJ6Z4Xj3Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543106; x=1761147906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1t/wjuT9T3FmCe0WEb6xCNvYEdLZ6G8bB0Zd1Sk8ws=;
 b=WDExShybXyK/KhZsqQ1jZ9kFeB5ejQ5+qQBmKo7OZ5LUwgxiwwyQTgYe8UDD5psorn
 M4zazUQB17Irc+soUa2gIqlTsChV86EwOotGV+Jz3fk2dG/Ad6Sc/c2vJnRuzcvhUSJ5
 Jq51Og0V34AwScJ2BOTvCCQzPzfdYBDxtGKa/RzqNglkDha28TDPSt/+ZfTl/aurMX7a
 Pjp2xb4n7ywR2VRt00MUADMZkIx7D+vPeIxupNqWtBTA0M+k9xNbDzDUXxYULYSpIepj
 LtKm93hVNuOuSGoFE82Ul21MlFKGbUKokHvvF0kV0c8e4xJezChr3iST2KnZpDFGYs4Y
 P/bA==
X-Gm-Message-State: AOJu0Yx006iEvnyBuNmoi7+WUNcMzDGX+aWSgbL0j8Pc/npdJnGkAOX4
 gMkXXms0pdyBt0J3rcX77SwZnNR73iEqlU68hr/TMmbP8GkdPpSBPOoFxO93ZVmurn9yl4lOBqt
 szCmKutlgLAw=
X-Gm-Gg: ASbGnctfhWGwDxBjyyGuE+NFu153/ZRmtlp51rktuBJ33JsBbjPPPJWYa0XqvlNLk6w
 mjps8XMCvc1T104p5Y9IY/aNZbt3/kVlnl+HVbNwcZTGSm3ng5CkeoL/xaqwnnYjiZSyuwwjfWV
 NMmA7alIKnZXOSSTnJdleUqb0pdup2TUAd4SKkpS98Qlz/vWHbkxzUxxr89C7l+fqEPmiEET2/U
 98CA+mPhWTOIC72xb6o3yHvQ58DPrQDd+MH/AfpaVzD3QJvlLk62qT9lkC7rUUzFSrs1rJiM3mY
 cbJ/wjQu4KZj9BHIhs5JPplRRtx3LdOmxoULaul0kGF1TKPvXqu6Fk2/KtiVsENsBZr8Cqe5Eiw
 dhH67yf2LpZDIfHfuL2cRvUx9w2KZl4+bL4kjvw==
X-Google-Smtp-Source: AGHT+IFqRsE3ZzL5hHLWEa0LQf3OgC0TRPdkp5AI1ZPCfvtCpBllcsChsok9X4zu+isyUEcdRQcXhQ==
X-Received: by 2002:a05:6512:3f02:b0:58c:787c:5f05 with SMTP id
 2adb3069b0e04-5906dd7ada3mr8964248e87.52.1760543106174; 
 Wed, 15 Oct 2025 08:45:06 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:45:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 07/11] boot: Only run global bootmeths once each
Date: Wed, 15 Oct 2025 16:44:10 +0100
Message-ID: <20251015154423.908468-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015154423.908468-1-sjg@chromium.org>
References: <20251015154423.908468-1-sjg@chromium.org>
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

Use the methods_done flags to make sure that each global bootmeth is
only used once. For now this has no effect, since they are all processed
at the start.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 73deba24d30..ca1fe741bab 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -294,7 +294,13 @@ static int iter_incr(struct bootflow_iter *iter)
 		return BF_NO_MORE_DEVICES;
 
 	/* Get the next boothmethod */
-	if (++iter->cur_method < iter->num_methods) {
+	for (iter->cur_method++; iter->cur_method < iter->num_methods;
+	     iter->cur_method++) {
+		/* loop until we find a global bootmeth we haven't used */
+		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global &&
+		    !bootmeth_glob_allowed(iter, iter->cur_method))
+			continue;
+
 		iter->method = iter->method_order[iter->cur_method];
 		return 0;
 	}
-- 
2.43.0

