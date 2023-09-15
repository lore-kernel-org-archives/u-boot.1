Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E952EEEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B3286A6D;
	Fri, 15 Sep 2023 02:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NB9pe1qA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45CA986A3C; Fri, 15 Sep 2023 02:23:05 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462EA8698E
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-794c7d95ba5so60567739f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737382; x=1695342182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVwRtE41w7vAorF1SAOgGuLPbYZOJpdZLtoAjRKWTII=;
 b=NB9pe1qAm3/hwqIlsCfrh4nUMyqlL3dAdoQnmGvBVeQe9olTDwnRBjyygTSYVKntJs
 EIMaWQnkCJEcy9jwTo4+zp92Ia9yahq5fxvkppZJKGxnSbvgKu2lpkMYlyluuGsp0XJ2
 lkTuhWjnokAuHBC3v+v0pbOgzPeuUM0chzUuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737382; x=1695342182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVwRtE41w7vAorF1SAOgGuLPbYZOJpdZLtoAjRKWTII=;
 b=mC+QIWeStcwwlFw4xY5fI10vSOMWphuODyghBDUDyqflPbSlwrAyCekwdfJb1Nbufz
 kPBd4KUZP5dBiN4CEriA1fq65eRh+9lYl7tDh+B5y88OKcdxn0Y1lYwNmB15Eln07e9+
 wL+Awj3ANRtw49QM8D0kwqSPUpyPtR9Bz7lgbJCrkku90TnHnovRpAkynTGqrYC6wMf7
 wtEkbRhl/X9ftk1+NNkM91/e3HThyf1fwStv/hemojp73gpwsOm2s4LTF5Pk+qGmFSMu
 pSPdTUAW9thDQB2h4igHL3R+iqJJHCW398F1wkOrRY9/Z8VD+foFVRKCei6c9QDmqE3B
 wTVw==
X-Gm-Message-State: AOJu0Ywjdi+BUkP7nd/TeQKsB8LvvOl8J77gy5En500hJls0UFDmtGwq
 gLgeyAtZ1zePssqO45Erk+BH+/08uPc9hn9fBoI=
X-Google-Smtp-Source: AGHT+IGzhQsfV5mhpombyyxyqyjEUJGkp/suLZFKwjHGvWu9mI3Ll1SHWdgW1ImK87iuZg5TrDhH4Q==
X-Received: by 2002:a6b:e40a:0:b0:792:9406:a453 with SMTP id
 u10-20020a6be40a000000b007929406a453mr40489iog.14.1694737381895; 
 Thu, 14 Sep 2023 17:23:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/27] moveconfig: Avoid showing progress at the end
Date: Thu, 14 Sep 2023 18:22:21 -0600
Message-ID: <20230915002236.798760-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

When the process is finished, moveconfig leaves a line saying that all
boards were processed (for better or worse). Drop this, since it is
unncessary.

Future work will provide a summary at the end instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 9d228720c739..0131034a3787 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -282,7 +282,8 @@ class Progress:
 
     def show(self):
         """Display the progress."""
-        print(f' {self.current} defconfigs out of {self.total}\r', end=' ')
+        if self.current != self.total:
+            print(f' {self.current} defconfigs out of {self.total}\r', end=' ')
         sys.stdout.flush()
 
 
-- 
2.42.0.459.ge4e396fd5e-goog

