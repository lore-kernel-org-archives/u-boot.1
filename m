Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB0DEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 19:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D9686F61;
	Sun, 20 Aug 2023 21:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DqN8XGiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF66A86E8E; Sun, 20 Aug 2023 21:04:27 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6081A86A42
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 21:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe2fb9b4d7so24897645e9.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692558264; x=1693163064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7hb2jrvivQxON1XeovwgMxiW+RYRxZdLPP3zp29do4=;
 b=DqN8XGiU2JEsK4+pOljt5Uk94ytaLZPEDpJaoCYy72gfiE/uAAKXM3ekAvtTLNyu1v
 47J027LgxpDlSrQLJYN5kPoLuUmgeAGA16ydArqdjRSpFlP4Uy0jWx1WhGQxH+UFxCW1
 4bsqU1uOF8TwE8/GZy9SRmZmlNmjZXiMmGKTior/yAPwQaz/2piJJhzcLWgeyZxyYIga
 JUyNf3Th/A3ACtr1yBAw09fv/7k6jIn/Ocdvc8eD/19U+CN8cXvFI27fJNH+6dW4tPzj
 5Xgm6X2zT8ihcpmA56JX/aPJDVcaIhzQjICH2saashcvCYgWZLNuJyCk5STyCIe1ckEw
 hg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692558264; x=1693163064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7hb2jrvivQxON1XeovwgMxiW+RYRxZdLPP3zp29do4=;
 b=TNsCUh1+MWIO/BvS54ssqEk7x0LGATXRsQOcZT9ivYjXWIYx6Bxr9DJnnvtZHVgYKG
 YBDngcTS3pxucvxvMYEM380o/v1+3R2PauNWONaeVkzGT+9a8guecclXBds9EE+kzX69
 NmPEv/1uRThJhxozqpJiQ+Q2g1AdFZwKXv8PEWXoBWrDg2IBkRm9giSgD7Rp2Pj3di57
 cfXwRcmms/+4/YLdtetGXsD+Zzv6x2LTkX5QMgWqzGRtDjSSkAzS+kOoUhwCJaahngWs
 SgUQXGMugncYThE59dtr654vZWGwb0sox/JEmt9656BUOCVLbuN2VFNgCEc1oVIqwRLB
 g7ug==
X-Gm-Message-State: AOJu0Yxj1EavGKwylF2wA7bY2Yss53O0QgQcMF6OQuWFHyUQG15UaWoe
 Ngb03gRY03dC0uu1+OvCrmlSl7pw+HaFasSk
X-Google-Smtp-Source: AGHT+IEgkgz5ft1HZ0QXwHXw0oHCCenwb0FB+qK0qRYM1y4sri+uw88uMtR2VrQFY4uCoLY2RNpdGA==
X-Received: by 2002:a7b:cd14:0:b0:3fb:4055:1ddd with SMTP id
 f20-20020a7bcd14000000b003fb40551dddmr3579024wmj.28.1692558264242; 
 Sun, 20 Aug 2023 12:04:24 -0700 (PDT)
Received: from fedora.. (cust-west-pareq2-46-193-56-152.wb.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fed78b03b4sm8253797wmc.20.2023.08.20.12.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 12:04:24 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v1 2/4] scripts/gen_compile_commands.py: adapt _LINE_PATTERN
Date: Sun, 20 Aug 2023 21:04:10 +0200
Message-ID: <20230820190412.21266-3-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820190412.21266-1-jmcosta944@gmail.com>
References: <20230820190412.21266-1-jmcosta944@gmail.com>
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

