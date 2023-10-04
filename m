Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE03E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABFE875C9;
	Wed,  4 Oct 2023 18:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AxVZgvSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 374A2875E4; Wed,  4 Oct 2023 18:44:01 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC89875E5
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so4259169a12.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437816; x=1697042616;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVk7CErr+ozJxaznr8JlhI3CGgo9KqqoNNJXNuAlWEE=;
 b=AxVZgvSNDtt7ZFfTCykkha89J3U2ooZKY9oR2VWCrThCn6+/QRFuyvbU6eKYVCCg7Y
 U/v0aSaxKISoCRmmWp/x1np4f2jn5yicyYMMIi9uXTmkpEX3J+MzHzVq00j4AAy1JNkr
 JukZ458lk1juQ0tIvSATYrOEyQ/QcBaTB6RnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437816; x=1697042616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVk7CErr+ozJxaznr8JlhI3CGgo9KqqoNNJXNuAlWEE=;
 b=g/i88uLpWSxY/jTWQltAzbH43bDmWzXJ16LYdK9pe5Qk/fE0STDUTB+hD6QsuUvNrg
 m3EjwrOA1ij1n7Yfk2DYrthELhhmlaS2NzFSUjos6TA8vKxIjLLL8hXVfUT+tF76WO83
 GX6JbEQirhyUsTHnnN83xPCwLL2GKQtckiSSIQF25kFVud/ou+9j8NFJbWgnuIXO/G0N
 i1kiJOmZEy+/nW5QeyfJwTuNONyOXk160t7gwoz2bTk1pvsC9+pzqr6cEQlOz2504inN
 DGj2fEXBQ6ZVQiM7tahqJz2ZBepOGIM6czHAo1oUuD34ObbcEwfyyy4EkqMcKPXrpfsm
 8Www==
X-Gm-Message-State: AOJu0YyipQ1HF6mtzdYR1IftpbyBNu/0jJ7ijJHgR2GpN6AtKRlZC4If
 VWprcq2MNNHmoSwqxlGve4f8ZJADxkkiSk21DVE=
X-Google-Smtp-Source: AGHT+IG+94mXwvjoeJ72yYWUIhq6lJ+4k3+lFwWBcAdZDdvZkjC9Zsws7ud0Mdtf6QC8OGalM+9O/A==
X-Received: by 2002:aa7:c547:0:b0:530:d8df:afaa with SMTP id
 s7-20020aa7c547000000b00530d8dfafaamr2384332edr.41.1696437816514; 
 Wed, 04 Oct 2023 09:43:36 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:36 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v10 24/24] DO NOT MERGE: ci: Build the world in any case.
Date: Wed,  4 Oct 2023 19:42:20 +0300
Message-Id: <20231004164220.15738-25-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

The CI can fails previously for reasons which are not tied to hush 2021.
Let's build the world in any case to check everything is OK there too.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 .azure-pipelines.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index da701e42da..3417722b21 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -447,6 +447,7 @@ stages:
         retryCountOnTaskFailure: 2 # QEMU may be too slow, etc.
 
 - stage: world_build
+  condition: always()
   jobs:
   - job: build_the_world
     timeoutInMinutes: 0 # Use the maximum allowed
-- 
2.34.1

