Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE776C83F2C
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 14:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1287E8679F;
	Sat,  2 Sep 2023 16:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EpiEEQJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51DBF8684C; Sat,  2 Sep 2023 16:53:25 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9D9486759
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 16:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso84765e9.1
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693666402; x=1694271202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7hb2jrvivQxON1XeovwgMxiW+RYRxZdLPP3zp29do4=;
 b=EpiEEQJrU9oE6U1sdemFnWeZCcQ5GPpjsId0DUkUMmXccYMqowgVXqWUU/erpZi3+y
 /XkdFEHzTRIKFAhzdWpvi/f6rzbRZvzM2XwaYQot/Sc+LzcFsR1Cjc247KAUMJtAJGfy
 9BdW2dP+jgYoqdrvs5XFAOnWqVD3n3OjeA7TvY9hdZjP11dVgskl9hHa1q3N18RbjUmX
 CT02fBtZH6g6QaZs24xWyhgrJemsIy9rWDNGGS4lD3MWhXWfQxMqYdl+EyDLsyP0D9el
 5iPmck+fBjCnVMbziayB847Z4JF8twYYVolrwSN411dUctdP3osuNtksLU15XoNsn5vR
 k3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693666402; x=1694271202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7hb2jrvivQxON1XeovwgMxiW+RYRxZdLPP3zp29do4=;
 b=kU+FTS703Sa14im5ZmolPZgd2lj96qvwZGB2rqoByteiaMymN5eN9SY7eOzgAkdugM
 ecyBzoL+Qp7A2pzVBcmiW/WEHVvgem00CrqzRHzBB31JuKJcTZHARbORQeJyBopMJred
 bxdwCyZWh9rL2TeVeBOdklCsyJPFrqyhM+MZTC1CMAxS5vW4ISWTPfs2KFBSJqvleZbg
 cUge8/7n+0ufdwDazByIL4cNARJnYhSppw5v17fJs5gdT+rwzOiG52AlJAgcWvs3B+jk
 gVimOLt4IB9zjrwz3Zg1ufHArcYTi3szzlpKDX0HbJHMsHBzw316KJI8pRRFLbXTcfm7
 rWqA==
X-Gm-Message-State: AOJu0YxYBCVXpY66tYyT2RSOa2hlZ1hSAlIpKCmfp46NaSby0WfYrCCD
 bFatMtP2lM937v3vEpTKEs0RNKERrU+c1Z1q
X-Google-Smtp-Source: AGHT+IFcXSQ8GG1Yw4EjsDCa5kcBctDKQmGXHJ/6+RBfADqZZSht++GqTUIuemJ6xsjQClKX0W0aJQ==
X-Received: by 2002:a05:600c:2196:b0:401:4542:5ee1 with SMTP id
 e22-20020a05600c219600b0040145425ee1mr4579434wme.5.1693666401675; 
 Sat, 02 Sep 2023 07:53:21 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 cc11-20020a5d5c0b000000b0031f34a395e7sm2385449wrb.45.2023.09.02.07.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 07:53:21 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v3 2/7] scripts/gen_compile_commands.py: adapt _LINE_PATTERN
Date: Sat,  2 Sep 2023 16:53:05 +0200
Message-ID: <20230902145310.107054-3-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902145310.107054-1-jmcosta944@gmail.com>
References: <20230902145310.107054-1-jmcosta944@gmail.com>
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

For U-Boot's context, the regular expression defined by _LINE_PATTERN
should be adapted. Replace 'savedcmd' by 'cmd'.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 15ba56527a..0227522959 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -19,7 +19,7 @@ _DEFAULT_OUTPUT = 'compile_commands.json'
 _DEFAULT_LOG_LEVEL = 'WARNING'
 
 _FILENAME_PATTERN = r'^\..*\.cmd$'
-_LINE_PATTERN = r'^savedcmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
+_LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 # The tools/ directory adopts a different build system, and produces .cmd
 # files in a different format. Do not support it.
-- 
2.41.0

