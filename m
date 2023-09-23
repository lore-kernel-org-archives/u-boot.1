Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5D6CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C4586BDA;
	Sat, 23 Sep 2023 21:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QcRRAOne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A5B8694A; Sat, 23 Sep 2023 21:44:58 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9035F86B86
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3510ad5b542so11863935ab.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498292; x=1696103092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5buePVmiuI7tESDzeaVrsqY/qYHzR62PLoIjRWmuVc=;
 b=QcRRAOnede4E145UgomCaSubteYavuwxpjLQ9nesR8ooidRkIIQcVYKQue6HDFiUsI
 k5i1fieBO9UYxxO5J8Ha9n80jTghHbETirFhvDUkkkOp6nQfWTV3ZR0lD7geqUm7JXuL
 gfuEL2HFuGLrelN2rfOL7AqDAovKn0GR2NSIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498292; x=1696103092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5buePVmiuI7tESDzeaVrsqY/qYHzR62PLoIjRWmuVc=;
 b=BAHLUdrkVQpYC4n5R6AFaKkBrDRkB5lVFsJWumvlrZAKX0+MgxRYZWVhc+m8z25H87
 QAgd4biJY3OOQNjyvQzOqeRAJd8JmYknCBXzlSnEoS3hf/yck+IUvtFS9KralSyxF9vp
 PiZ9MVqWqMXQkCF5PNpjmtjmgSxLBhewUPil1NNv+LEZvZ7KKO4eyag11wadTsa3RWF4
 mALFludaMoW4d42XVPoW+kQGb5AmkIj5zPFAF6wQ9gE7CkTrgrvqoHNoeTrOKURIChbu
 DNzzLSQQxiHaB7+QO/KDo5xBCtxVcHZERa3Y5y5AiWOGNs735Y8z8ci8kTQOAgShmDOe
 qP7w==
X-Gm-Message-State: AOJu0Yy4ZmhtYCF7u7bfvJNPMPrQyT25luIlKFuIDBEhM948SAPGNlML
 kGpNK6/vNpPUSZl5vcIMM1MhlLKeoIKcVnxGhCk=
X-Google-Smtp-Source: AGHT+IHW6roDeJgJQ4/mJG6ylbEntDqy2afNUk/D3UoZPFpWGCcEZNnN4A43TPy+KIHunfEh68DD1w==
X-Received: by 2002:a05:6e02:12a3:b0:34f:1f1f:f3ca with SMTP id
 f3-20020a056e0212a300b0034f1f1ff3camr3282086ilr.23.1695498292181; 
 Sat, 23 Sep 2023 12:44:52 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 23/27] moveconfig: Drop the initial output
Date: Sat, 23 Sep 2023 13:44:12 -0600
Message-ID: <20230923194424.1739224-24-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Since moveconfig now just does what it is told (build database or sync
defconfigs) we don't need to print what it is doing. Drop this info, which
is of very little use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index c6d7c53f8b89..5392e1f808e7 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -727,12 +727,6 @@ def move_config(toolchains, args, db_queue, col):
         db_queue (Queue): Queue for database updates
         col (terminal.Color): Colour object
     """
-    if args.force_sync:
-        print('Syncing defconfigs', end=' ')
-    elif args.build_db:
-        print(f'Building {CONFIG_DATABASE} database')
-    print(f'(jobs: {args.jobs})\n')
-
     if args.git_ref:
         reference_src = ReferenceSource(args.git_ref)
         reference_src_dir = reference_src.get_dir()
-- 
2.42.0.515.g380fc7ccd1-goog

