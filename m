Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28418C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9738F80EB0;
	Thu,  6 Feb 2025 22:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mjUslMvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDE380EB7; Thu,  6 Feb 2025 22:48:23 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B5180E94
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5440d5aae5cso1533434e87.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738878500; x=1739483300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x9aykdNJ1b6b5SLjH7AlsiiL4EJdF1/NhteQY3VQhEg=;
 b=mjUslMvhqEmzw1rrdwLyU6cKBJx40xt+bpbojYifM3sk0OgHHDBjUKBFI728uDq83h
 e3i91UY/kPSLPqmsTNGa0OlfMJ/weWTWEGwgt1u14yNWbr5Oz4hFPkpDI5Sf/KCiAROB
 idZFdyoLMVjiTNC6MgNbnuQ7lDElCv3iOY0XmB3Abv2G8YobxcRWnYw0uOIiyb0NwH1t
 0FXDKs67eQTYTrRR8t6eDBb9HGvtADxVoozqYi2svXKKvB3gfjqXWUitxZu5IsTQYGzB
 oVG51UXc6iv2tRaPVl4A40I87tx9Fo/b5bwDNSuDvHhe2Qo/Teen8Agh6/lK6QvaXh04
 lI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738878500; x=1739483300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9aykdNJ1b6b5SLjH7AlsiiL4EJdF1/NhteQY3VQhEg=;
 b=B1kBUVFWU/wQKl+RCzKoK/xLBSpXdymgW6zs6tFlIOYqzi4FfAWK18lOvBFzCnYEJJ
 B7nvMXoMMyjOa9k+edIBoPsZzzXJCS4NHAGsoBcJRrcJlxP3etBHwHhOHB9mRM91hmFh
 /5Ye5KCbZWc035xx/DBnmctppootYcC88O70zZKE+wMAjWaqNOjU6u4LsNe9DUVY3Waq
 WW9nE01pK0UuNjlxShgVJ4UuqJ5kges/ziRl7D/vs8Z6IYEDAaAe/JiJ51raZDS44kTJ
 IVo3RcnvJoMGeIlQdp5KCpteL/6jEy8RlF4Iucs98RL3zBzMKoB4ohXky836MA+2NdnK
 zefQ==
X-Gm-Message-State: AOJu0YwlLNRD9RD15Mj6RSLqsy2rCTgHvlwdyS/7iu6VhiSYWaD6zoL6
 UMgTSVP0T1s7LuGEwudJqm0Enr1fuJ61OefAB1X9x9GTOo85XYp07MDfegLL1vs=
X-Gm-Gg: ASbGncs8sfweHtzcph1Viftv/DCpXYrnmW1cRSQ2qOZaTWlPmHcgz2/E1NCLwhv6WcX
 Kj224WtHgr8y0Gj/VL/Y17/YXyM5oqJgSwO/OXNNAZgAxilBSlz9Zdl9gsbE2pgHWQYeyx5oXlp
 TsPbwZhyP7jHB3ZCik5P5IS1w0plWcGIRjRRIVFvJ/z4cqFxfEz7SBeuCphYl787l5dqug+lL6Q
 biQhY0iFWGs88cN1E395901xTuDgfruwDBFMOycD7qdRnW8WYN76QLLcWB+nCWe0/TUSMYvM7Wi
 gRlVS0ebHVygZMw8NoZeiOlbNPqlvUHu95v4jQ==
X-Google-Smtp-Source: AGHT+IEzG/yVsS2ZejBy3zjBXswDdZET0Mcp5cPOAlBSS1QZk2lmZJ50GB12QL+/FPmtjTVu319rjQ==
X-Received: by 2002:a05:6512:3a8d:b0:544:ebb:6e0f with SMTP id
 2adb3069b0e04-54414b043dfmr136794e87.37.1738878499867; 
 Thu, 06 Feb 2025 13:48:19 -0800 (PST)
Received: from astra-student.rasu.local ([178.66.158.78])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-544105f30a3sm238783e87.183.2025.02.06.13.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 13:48:18 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] lib: ecdsa: fix prevent memory leak in ecdsa_add_verify_data
Date: Fri,  7 Feb 2025 00:47:59 +0300
Message-Id: <20250206214758.353228-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
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

- Ensure `free_ctx` is called in both error and success paths.
- Fix memory leak in `ctx.signature` when `do_add` fails."

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 lib/ecdsa/ecdsa-libcrypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 1c5dde6069..f0095e9dbc 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -363,8 +363,10 @@ int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
 	ret = prepare_ctx(&ctx, info);
 	if (ret >= 0) {
 		ret = do_add(&ctx, fdt, fdt_key_name, info);
-		if (ret < 0)
-			ret = ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
+		if (ret < 0) {
+			free_ctx(&ctx);
+			return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
+		}
 	}
 
 	free_ctx(&ctx);
-- 
2.30.2

