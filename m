Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1EEC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE3A82CEB;
	Tue, 20 May 2025 07:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZNzUB+h6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1817182BD7; Tue, 20 May 2025 07:22:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECEB82BF2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so56961235e9.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718560; x=1748323360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZrKWnYZXXNTGosY75zyzhsNnAawmI+hKa+SKDv0ZfY=;
 b=ZNzUB+h6Kv1pq25b7IBpRQosGRaWP9TFst4MlnMSKtv1yr4uKzcVIBCLc+q+bFNewk
 EC2n49tCfGpWgpFVRRTd5EoFA6dF4weUVJb1nUfYt1GwHFq2RQG07PLbznmSBDYkFxnM
 h5pQvDaQ664b5pi8KQb8nKo1TBwOHt4U0eJlB/VIwbDc9RN6dG6kW0pyyvBfOVkC0Lne
 ZfwHhbZR/KPHNg8dxXprEv5Cw50CnKo4ikfhU68UFS2yWu9QN0zCmpFV2gEQ2IMSnpJw
 VBPaCjn1Hm+5UEgAfdEsBgGOyHqo0BmS9aukLbEwlRLev4o+1LuDdGrwaN618hsmo5qc
 b0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718560; x=1748323360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZrKWnYZXXNTGosY75zyzhsNnAawmI+hKa+SKDv0ZfY=;
 b=e7YWeYbqSlLCDbMgVEdx61uXsZCB6fnxKApv/igY1aRxCwZVfdVYzZ0/7KqzZjho69
 Ct8L8CC9D+F3kKLNDd10+bBQC7rhrop5eJWkZjUlPGK2TXh8KLHXKUQuFk9nyn76S+zO
 zibUCSVEV8ILDUs/8/Yk0o25gZmYoHOMV8q8W03CgiaaahvCs0uK36ZBdQhhBrqbi6Kr
 Xld+JDjkCnoJHdLfaU3RKkIO7bOnd3GQMAfUTH4fOgz6d2Du5xUjQdliKOexcuBGL/qE
 whS+k0ymMcNHRD6ThjAWVIqvxBNe3I7DGAnX9vRY/yl2us35Av1id3LwsKEsM9Vv6/ZW
 tbSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0GZxqT++7n0mTMI/OjTc+KOIZ5rzf4fbqLM+nAl6WolpRN9up8HphN4ecNGr9DJqkKxNrZF8=@lists.denx.de
X-Gm-Message-State: AOJu0YwVjky5cfWElMos+B4SN/BV5gaop1SlHMe4j9f4EhK6+E2+tVuz
 QMHf+4nqVGFizk5jgM02gu1sHnE1NeSsSces0CHsa0rhxtiNaLRFcm62tBMCsRdmZr4=
X-Gm-Gg: ASbGncspPDVvXw/Ie3y3eDWgF1Rp5ccaVYnNb4rSJzdmYtY4TF6RDEJ8i5Q/dJ4kSqq
 58dIjVm1G9uJCkYl5rZsBn80VXuiL2yRteKQXZ8J6lb3g6Q75dFuJnKMtkqBZk9Dw+LnF/oHfkM
 UdRbnLSx5P70sEMU1s19XMPqGO7nyBHhGT2IFQ17Ajss/krBiUy1N7tblGY6gVFw/nQR10fgjR3
 hWW9U5tMJu4n01/iX/6RhhV1xyudpPhvBdAJIADyN/13P9oq74u3A+AYdRIDyHKOkVoSnSYMMIn
 rUgRssZoVUKqPBnseMUZRCnpcmyPnhnUKLKjwdPptfDfNLG8zMNKafP/MpFuC2qiNy1ZltH+2e0
 =
X-Google-Smtp-Source: AGHT+IFnx/mASC/1xoKjsbF6qTXs7R3CO8e4ycvqg64Rq2gKtzcbPTcuParUQP4VXSssVWUPpcny3Q==
X-Received: by 2002:a05:600c:1d07:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-442fd660721mr114794865e9.24.1747718560542; 
 Mon, 19 May 2025 22:22:40 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:40 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 17/24] kbuild: remove redundant quiet_modtag for $(obj-m)
Date: Tue, 20 May 2025 08:21:28 +0300
Message-ID: <20250520052153.307194-18-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit b39a691617e4 commit ("kbuild: remove redundant quiet_modtag for $(obj-m)")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fa91445f132b..29446298041f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -125,8 +125,6 @@ $(real-objs-m:.o=.i)  : quiet_modtag := [M]
 $(real-objs-m:.o=.s)  : quiet_modtag := [M]
 $(real-objs-m:.o=.lst): quiet_modtag := [M]
 
-$(obj-m)              : quiet_modtag := [M]
-
 # Default for not multi-part modules
 modname = $(basetarget)
 
-- 
2.49.0

