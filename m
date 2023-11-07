Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647CDC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AC2876AE;
	Tue,  7 Nov 2023 22:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q4JgddHF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4028762E; Tue,  7 Nov 2023 22:42:39 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D50F187624
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40838915cecso45086205e9.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393345; x=1699998145;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHMQIIW/vUaY7YbsnrgSF0GxJBdF4jYHkR67Dz3XsU8=;
 b=Q4JgddHFJLA+ey+s1gByNaFWCymnnWfICEUVUPCEAbbg7/S+khJK6QIeEX8IJ1Hgb9
 LeNdU2Q28RM08k4EeFeJKJV7ET0Df0+UfaDsbeI+H2MiWEdFFP3y20AASdwFZ6Y5dErg
 mPF3MfHrBmOLT4LWP2qlLZ681qRcy2zjoWEcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393345; x=1699998145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHMQIIW/vUaY7YbsnrgSF0GxJBdF4jYHkR67Dz3XsU8=;
 b=hdwIjRow2lRrA9KP6SLAofWkuo26n8R4fyarpJi/tviDSNbwzHhgAIw02PmudJb7Zb
 tNTkwu8fzU+bbnhkhmE3seeRWv7tAW8qkT1EQ6uowmPlmR+euvXJJXhuRiFbHMLbv9EG
 OtQmKt5JvmMHEWOHX+hHkR3D27UcJd2UfB+obZ9lyfOEzk5bZjUwpdUyI0qKRo55z3lz
 O6YfEBxcPE672IT3lTF0ipNsHEsG7u3+EjecnnIX48/4ZK/Wuoa/s1ayKHVjHJ+HGckX
 pt1mhzH1BSK1/6hhNTwTJBVheEocVrUlCHK7+/hX6lM5ERWl6QAeKWRCEJ/D+CO2X4So
 rNyg==
X-Gm-Message-State: AOJu0YzJl3EsS7YkeEGFO4VNDE5bj9zVd1sa73oCMfNj7vnBU53Xrvzm
 nFiMA0o6edvDmpPMSKBkudd2qH7r7FU7jTOkwM0=
X-Google-Smtp-Source: AGHT+IH6GxAqVR7VbfcRWQhLo/cXorKRI0S7Dc4k9T3j8W9QDD5Ealt9BBipAFrCmDmpnWPxnM4nCw==
X-Received: by 2002:adf:d1cf:0:b0:323:2d01:f043 with SMTP id
 b15-20020adfd1cf000000b003232d01f043mr53008wrd.3.1699393345477; 
 Tue, 07 Nov 2023 13:42:25 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:25 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v11 24/24] DO NOT MERGE: ci: Build the world in any case.
Date: Tue,  7 Nov 2023 23:41:21 +0200
Message-Id: <20231107214121.132079-25-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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
index d6f3fa423c..4eaf0e9062 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -469,6 +469,7 @@ stages:
         retryCountOnTaskFailure: 2 # QEMU may be too slow, etc.
 
 - stage: world_build
+  condition: always()
   jobs:
   - job: build_the_world
     timeoutInMinutes: 0 # Use the maximum allowed
-- 
2.34.1

