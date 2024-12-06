Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A507FE77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1E98975E;
	Fri,  6 Dec 2024 03:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mb5gDGkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32EC89774; Fri,  6 Dec 2024 03:38:07 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D1C89639
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a77c066a15so6014525ab.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452682; x=1734057482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0iBc9rZUrZFtdY+XumUVUYCijopZZSx4HIM2bazzRo=;
 b=Mb5gDGkGoUJzPb8CeqF25dgZjOOlVqBgqz3gvyoomQd7c2jYkU8MM5WCXFDePjh25H
 S+zY12CFv8VSiqiIDXSTvpvUqm91DbnVSKVF47HK7HJShyEVzZ7P1IhWu01dhNPFcrb8
 0SLDp34RF62bxZCDgBqE6AaQyEnxQ7UfqaikE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452682; x=1734057482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0iBc9rZUrZFtdY+XumUVUYCijopZZSx4HIM2bazzRo=;
 b=rjeJRGo2I5isWvEfh1m2AIN0TmPjMSK6ZJzAuVLicwkPxw5OTgTdeDqjcCOnE+5zJG
 yrl8g/QX3kHxCUPrzc7oZcjennZh3X/Ek9mMpNoFT3sZwVVYafq8p2LS8UAspPo132f9
 BNPBC09MKUsVGRM9E1+Sg021mUVbeYbTjR9a/LeExR83W827WtbvnDWD3s6NLn0QdJRe
 OoUfRbtnoYluq/qpMpQSwYLTPAY5ACtCt08KAsLsSQ/cYy29DPSr2284Ir8BfH5sRXXg
 q3T4FoL9IxWLVXGZcqU60BwK2EVBvN4MMuu2Rua3DsY2IRw4EPvV4KBppRAJh8AbVpka
 OJ4Q==
X-Gm-Message-State: AOJu0YxuYCa7i1J98MgVMlxMnwDcp+gXL4INJOdSfElFnU15kgSpjbGD
 aRRJ6bRbEJ9wOac4blYWO5Kj3ZofizxNsrPKkIlFVFDgcbAzF5z+eehKQDOswxhPBX1x2cYstxA
 =
X-Gm-Gg: ASbGncsN/eLdbqzZzty353O8JiEFCeg26nF3vO6qUyIPSXjYyYtGJx3d/K9fLocqvJt
 kPdDa6Wj5JzJ8NSCJlAc9ime7fI2iFqnML2iznA4s9EEervycC8PBcep9DdBNqvnvTC7QdO/Ur9
 kpLFNL5VFuRDLCsqrLRCgy6zrrt8BvacCs0sZFs5f3XN6k0Yt8QHMHy2DIExrFw5zedG1m9Zx0u
 T+ViRbz7He2gwBGaAQoUwC71POU/DJ79Y9wBihN1e3+i6tuFP7LEvahBBDgkgA38GjZ6qa2iAXv
 /AcJJ1kV6dI=
X-Google-Smtp-Source: AGHT+IHt2tV74KQX4wkbFdNUWaopDuzv5Kl8wwy/Ec2Kf5DCZHyRhiPHYjOg2e2RQkLFtD6QbeBMcQ==
X-Received: by 2002:a92:c24b:0:b0:3a7:e83c:2d07 with SMTP id
 e9e14a558f8ab-3a811da31c3mr19771735ab.14.1733452682143; 
 Thu, 05 Dec 2024 18:38:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v3 34/46] test: Update bootm test to restore silent_console
Date: Thu,  5 Dec 2024 19:36:13 -0700
Message-Id: <20241206023626.2456858-35-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Unset this environment variable at the end of bootm_test_silent() et al
to avoid affecting subsequent tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/test/boot/bootm.c b/test/boot/bootm.c
index 9455f44884c..0dd8bc2979f 100644
--- a/test/boot/bootm.c
+++ b/test/boot/bootm.c
@@ -122,6 +122,9 @@ static int bootm_test_silent(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_SILENT));
 	ut_asserteq_str("console=ttynull something", buf);
 
+	/* restore settings */
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_silent, 0);
@@ -229,6 +232,8 @@ static int bootm_test_subst_var(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline_env(BOOTM_CL_SILENT));
 	ut_asserteq_str("some${var}thing console=ttynull", env_get("bootargs"));
 
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_subst_var, 0);
@@ -246,6 +251,8 @@ static int bootm_test_subst_both(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline_env(BOOTM_CL_ALL));
 	ut_asserteq_str("some1234567890thing console=ttynull", env_get("bootargs"));
 
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_subst_both, 0);
-- 
2.34.1

