Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E58C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9115C83444;
	Sat, 24 May 2025 01:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jZCdBfwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45BD283409; Sat, 24 May 2025 00:58:56 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2397483340
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7376e311086so454243b3a.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041132; x=1748645932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02NIdCs4zhnB9+h0eSTxPwWETTlYNKWX/2MyrGOgvKk=;
 b=jZCdBfwW9dR5cE4rf+bh65kCfOvXlygIxk6apnmXrauXFDe4hqHAHPAGLkUdSjv+sg
 223ZoXef/sT51K9ScGXVd3dpW8xKihogsIKgbJ3/5x0fuGa8em5hY+AhtH6KOuVKdEbg
 5ZXMN1n1pVjYyzZ6K7xx4bAQLObWiKOeB0tPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041132; x=1748645932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02NIdCs4zhnB9+h0eSTxPwWETTlYNKWX/2MyrGOgvKk=;
 b=DGGXZbvIRzNzXwKHfsxgD7PkLFvNYMPNl8yCXzTZ0CQv+CQ/AveLRrspCbvZT5k4bR
 rLMygYGQvbf5QyYyX+BR0KVLkaarf9YeM1jezXIbn1aXQfbZNzopGtUJtGKXBr6rWnWu
 eDgUrp6PtGtXp3bYA08NmfAwMHfskTgEwJDbi3qfzGo9YD2ymdOySUMBb2B5yiOD5KA9
 ewbWKn5gp/K5vDDaOQpwHofbsEXy5UasH+R8NcebTmW+J+fiYy+qhBbtgKFdzwQlwbf8
 Ratd7SyEXRHAlRizxpXNo4A9VJ1tANPepZsrV/Sdj9TP2jNW/R2vJ0W3SJvgvZ3Iv2Y5
 YsOw==
X-Gm-Message-State: AOJu0YwCMrR5xBCWRT5NaYmwv1fPa2Lq1EFztTQILqXrITsE1NCv+5vb
 Yt9SFxxu35qWicE51T+tETs0UkF5AuasWX42bOAGUNyDqMj1QhnF3UzywFZinr+y+PJkO/oJ4yO
 HrXI=
X-Gm-Gg: ASbGncsBAJ8fu8p1IK3/Glt4oSYLAjP6it4Nt223azm4PKI5Z6jKbOUdngWYDSjAY2O
 YLd47XnOlvdyIt1DDStCbUQJ0Ds7xf+cC9ziEXtdmIoJy6DXUYy/U8+kc8F3Uv1Wt1avCQg+LnX
 b9z4FFptaVWzVpX/I3VSzAP0rsAkxyxXF04gEtJxGx+YZiKOI8WfesnntlI1x4oWYplaTHfuPPv
 EBUEP2WTI6ZRh89lGWGVZ58mHTJ9kzt3RhRclKTYt/Ml3tA/BOJ5AEFMExJwMIQJVmohOX/g+Bi
 KbjgXtFv/mpoQweXoosYUar4pVLnoY1vmTC588CewD8A9HzyIsOo9NAcd3SWuXT3s7Hy/4oBoaO
 P2fnCe8E0lkuHL4I=
X-Google-Smtp-Source: AGHT+IFS2Q3diJmMqDX+4Uv5eudd+lZd3ZpyFSF4MSADvF7p+rYRKyQfQWz7u1uZB4Hn7mG4Apf8AA==
X-Received: by 2002:a05:6a00:114d:b0:73f:f816:dd78 with SMTP id
 d2e1a72fcca58-745fe035fbdmr1724097b3a.15.1748041132535; 
 Fri, 23 May 2025 15:58:52 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a982b884sm13774469b3a.95.2025.05.23.15.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:58:52 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 03/28] clk/stub: Add sc7180-rpmh clock
Date: Fri, 23 May 2025 15:58:18 -0700
Message-ID: <20250523225845.2311989-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Stub the RPMh clock controller on SC7180

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5f5aca41d5b3..23670c2f4425 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -51,6 +51,7 @@ static struct clk_ops stub_clk_ops = {
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
 	{ .compatible = "qcom,sdm845-rpmh-clk" },
+	{ .compatible = "qcom,sc7180-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
-- 
Sent by a computer, using git, on the internet

