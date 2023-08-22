Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FF6EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 553E9864FF;
	Tue, 22 Aug 2023 13:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ntsUlIhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 744BB8649F; Tue, 22 Aug 2023 13:22:59 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3EC3864E5
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so584087366b.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703376; x=1693308176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhHy/gbx5fgaYaEj2DSWQipG3mUbqExdYXyeqnr5XLs=;
 b=ntsUlIhz1Ml35AYv4aej91+wN748+ZVwm3y33SB4UANpyMInSng9NOeIN4CofJUfPu
 OKuw+JRAav6fei5vYKfgV0QbHfDVSPvp+GdknzGNQHkM3CsAT26RaF65/xIhfCOnc5mj
 L+O5dfmVaHho9OA0SdQozVKxlSCHW80VNPFbVl2Jar+zTvQ52W4+uavuEm4iROR3CTg7
 xbx0mdMjQUOaZFL34/ctxBEBOSqwQe/PKOwkc8ehcsDFcUxHgpTQ/fVQKUt4IxCPI+nx
 cajtRNvbjinWSzrGkXTzfF2zam0nCs4SUuDGqzpKrHM6oamcssFEj5uaFJGI7BCZfA/x
 t1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703376; x=1693308176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhHy/gbx5fgaYaEj2DSWQipG3mUbqExdYXyeqnr5XLs=;
 b=KWHWsxbEZIusMvKxXNu+ilpeQmbiv7utydTp+SmetGehdEQ3siOpt3KEcw15wy6e2t
 JJYDNvRqgTmGm+1w+oo1xcNv6g3YNc6Ta6JgX3QN3Krl1lqiHsMIrHdB5KoPm63o9iFg
 7ws8UM1GQC/sHp7+GvMsz02mRgzEbBGGqGoz4LjLOwqeV1DzQwvVnX2O1aEcNk3ykUnh
 WZGaL56tI6yYuFnykM5Tyy99U4UknG4OLwGKdW+WYsDm2tSGB3/9UBcGYEMDFDtXkRh0
 CVimSbe6enfcmonjUd20kv04BGj53wSA7Xsi+Q7dWpSTC7OZyd74xWRyMrwDv7DNcaEB
 CVnQ==
X-Gm-Message-State: AOJu0Ywvm3KKs2B8vI/ZaTSS9WmOHWDI5biYU89UTOQMat34LVokr/pi
 VjiEabqFQpNmbHPNmqwX0b4FTuUdKviGZw==
X-Google-Smtp-Source: AGHT+IGAUAhtKeV2oAl+2mMGBTbS6ucI8QbHYHtq3g63ziRet4WYiAmein3N39E5BjSLLuUK4qU+Gg==
X-Received: by 2002:a17:906:cd2:b0:99e:1041:f849 with SMTP id
 l18-20020a1709060cd200b0099e1041f849mr7537855ejh.20.1692703375868; 
 Tue, 22 Aug 2023 04:22:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 19/19] board: asus: lg: move config fragments into device
 boards
Date: Tue, 22 Aug 2023 14:22:17 +0300
Message-Id: <20230822112217.4646-20-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

Move ASUS Transformers, Grouper, P895 and P880 config fragments into
their respective device directory in /board/../configs/

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/grouper/MAINTAINERS                             | 3 ---
 .../asus/grouper/configs}/grouper_E1565.config             | 0
 .../asus/grouper/configs}/grouper_PM269.config             | 0
 {configs => board/asus/grouper/configs}/tilapia.config     | 0
 board/asus/transformer-t30/MAINTAINERS                     | 7 -------
 .../asus/transformer-t30/configs}/p1801-t.config           | 0
 .../asus/transformer-t30/configs}/tf201.config             | 0
 .../asus/transformer-t30/configs}/tf300t.config            | 0
 .../asus/transformer-t30/configs}/tf300tg.config           | 0
 .../asus/transformer-t30/configs}/tf300tl.config           | 0
 .../asus/transformer-t30/configs}/tf600t.config            | 0
 .../asus/transformer-t30/configs}/tf700t.config            | 0
 board/lg/x3-t30/MAINTAINERS                                | 2 --
 {configs => board/lg/x3-t30/configs}/p880.config           | 0
 {configs => board/lg/x3-t30/configs}/p895.config           | 0
 15 files changed, 12 deletions(-)
 rename {configs => board/asus/grouper/configs}/grouper_E1565.config (100%)
 rename {configs => board/asus/grouper/configs}/grouper_PM269.config (100%)
 rename {configs => board/asus/grouper/configs}/tilapia.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/p1801-t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf201.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300tg.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300tl.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf600t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf700t.config (100%)
 rename {configs => board/lg/x3-t30/configs}/p880.config (100%)
 rename {configs => board/lg/x3-t30/configs}/p895.config (100%)

diff --git a/board/asus/grouper/MAINTAINERS b/board/asus/grouper/MAINTAINERS
index 18b4f0641f..f4068d8562 100644
--- a/board/asus/grouper/MAINTAINERS
+++ b/board/asus/grouper/MAINTAINERS
@@ -2,9 +2,6 @@ GROUPER BOARD
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
 F:	board/asus/grouper/
-F:	configs/grouper_E1565.config
-F:	configs/grouper_PM269.config
-F:	configs/tilapia.config
 F:	configs/grouper_common_defconfig
 F:	doc/board/asus/grouper_common.rst
 F:	include/configs/grouper.h
diff --git a/configs/grouper_E1565.config b/board/asus/grouper/configs/grouper_E1565.config
similarity index 100%
rename from configs/grouper_E1565.config
rename to board/asus/grouper/configs/grouper_E1565.config
diff --git a/configs/grouper_PM269.config b/board/asus/grouper/configs/grouper_PM269.config
similarity index 100%
rename from configs/grouper_PM269.config
rename to board/asus/grouper/configs/grouper_PM269.config
diff --git a/configs/tilapia.config b/board/asus/grouper/configs/tilapia.config
similarity index 100%
rename from configs/tilapia.config
rename to board/asus/grouper/configs/tilapia.config
diff --git a/board/asus/transformer-t30/MAINTAINERS b/board/asus/transformer-t30/MAINTAINERS
index c6c15323b2..071a9c04b8 100644
--- a/board/asus/transformer-t30/MAINTAINERS
+++ b/board/asus/transformer-t30/MAINTAINERS
@@ -2,13 +2,6 @@ TRANSFORMER BOARD
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
 F:	board/asus/transformer-t30/
-F:	configs/p1801-t.config
-F:	configs/tf201.config
-F:	configs/tf300t.config
-F:	configs/tf300tg.config
-F:	configs/tf300tl.config
-F:	configs/tf600t.config
-F:	configs/tf700t.config
 F:	configs/transformer_t30_defconfig
 F:	doc/board/asus/transformer_t30.rst
 F:	include/configs/transformer-common.h
diff --git a/configs/p1801-t.config b/board/asus/transformer-t30/configs/p1801-t.config
similarity index 100%
rename from configs/p1801-t.config
rename to board/asus/transformer-t30/configs/p1801-t.config
diff --git a/configs/tf201.config b/board/asus/transformer-t30/configs/tf201.config
similarity index 100%
rename from configs/tf201.config
rename to board/asus/transformer-t30/configs/tf201.config
diff --git a/configs/tf300t.config b/board/asus/transformer-t30/configs/tf300t.config
similarity index 100%
rename from configs/tf300t.config
rename to board/asus/transformer-t30/configs/tf300t.config
diff --git a/configs/tf300tg.config b/board/asus/transformer-t30/configs/tf300tg.config
similarity index 100%
rename from configs/tf300tg.config
rename to board/asus/transformer-t30/configs/tf300tg.config
diff --git a/configs/tf300tl.config b/board/asus/transformer-t30/configs/tf300tl.config
similarity index 100%
rename from configs/tf300tl.config
rename to board/asus/transformer-t30/configs/tf300tl.config
diff --git a/configs/tf600t.config b/board/asus/transformer-t30/configs/tf600t.config
similarity index 100%
rename from configs/tf600t.config
rename to board/asus/transformer-t30/configs/tf600t.config
diff --git a/configs/tf700t.config b/board/asus/transformer-t30/configs/tf700t.config
similarity index 100%
rename from configs/tf700t.config
rename to board/asus/transformer-t30/configs/tf700t.config
diff --git a/board/lg/x3-t30/MAINTAINERS b/board/lg/x3-t30/MAINTAINERS
index 0ad29563e9..13c8588d0b 100644
--- a/board/lg/x3-t30/MAINTAINERS
+++ b/board/lg/x3-t30/MAINTAINERS
@@ -2,8 +2,6 @@ X3 BOARD
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
 F:	board/lg/x3-t30/
-F:	configs/p880.config
-F:	configs/p895.config
 F:	configs/x3_t30_defconfig
 F:	doc/board/lg/x3_t30.rst
 F:	include/configs/x3-t30.h
diff --git a/configs/p880.config b/board/lg/x3-t30/configs/p880.config
similarity index 100%
rename from configs/p880.config
rename to board/lg/x3-t30/configs/p880.config
diff --git a/configs/p895.config b/board/lg/x3-t30/configs/p895.config
similarity index 100%
rename from configs/p895.config
rename to board/lg/x3-t30/configs/p895.config
-- 
2.39.2

