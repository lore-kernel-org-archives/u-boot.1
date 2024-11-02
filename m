Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75A4E677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6268890F8;
	Sat,  2 Nov 2024 20:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f678xKFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C849589109; Sat,  2 Nov 2024 20:37:31 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60783890C4
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbcc2bd7fcso20180966d6.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576246; x=1731181046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsPmMlLlwBwvG6LkTiLX82VKIxDt97xl983INMWvS7w=;
 b=f678xKFj2KSHSU9Z5Lyo0HIKZSHWO8AkZIlw0SqbOqBU9H8Vyp6bjhmj4moQcszver
 F6iisZDKEj2MJMwD0ZZ1yFAAmGODSuRqXyWPlePQwFljBrJLKObUruILZYcvVH3LyqbH
 lMJEANek1wwSKn6kCjbPAICpGjwVJkf6Ech98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576246; x=1731181046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QsPmMlLlwBwvG6LkTiLX82VKIxDt97xl983INMWvS7w=;
 b=aNXoKIBULALqGaEdXUfa9zLL1iytOetC3Kdu67d7fC5gGPPkxcrQcQvXdiBEMBfxH/
 Mt36yJ2c+UX3gsaFoDTl+SrMZ1H1583OTSHSm4j5NkCzujKlrDkh0cVUwxbsNA9Gb3TX
 qImciPHJIGcPOgE1mwRRNsw3mHQSVyhjBcE54uHA2FcFmsaVW//8jw61naI+ChsEK33G
 4ogLXX/CRUzW7dp3AgfppyA3RF78H5+16lKMIufxjdVx6gQAozIs+DMii86aogxZxlCu
 oL/5oKh2YM8jXwn+QibKZeHStrcLwsSQdn80sc4/JPf0VhG4Ctawj3/je0mddeHy1mCA
 3E8g==
X-Gm-Message-State: AOJu0Yx9sDzgxofjm//hwBbaS37bRRNktfQQoDB7t2Z9Qb9SmL5MI4Y9
 BcUN2qNq+ACZtIs3oIfaMI8W4Tfr2quI51eNlBijd8RavhOrdDSQhAyoz1jqF7PYqJsKB7NO9sc
 5XtPL
X-Google-Smtp-Source: AGHT+IFs7HfBRTBfAb7LALZGI7kFALBeePRi87MGpyofOk8gSQg0Tfb5KC0HNduBo8JLTXEPU2pegQ==
X-Received: by 2002:a05:6214:4489:b0:6ce:2fa1:842a with SMTP id
 6a1803df08f44-6d351aa3ea9mr153025166d6.15.1730576246517; 
 Sat, 02 Nov 2024 12:37:26 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/20] bloblist: test: Drop global_data declarations
Date: Sat,  2 Nov 2024 13:36:47 -0600
Message-ID: <20241102193715.432529-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

This pointer is not used any more, so drop the declarations.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/common/bloblist.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index fd85c7ab79e..7b90fa7f352 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -6,13 +6,10 @@
 #include <bloblist.h>
 #include <log.h>
 #include <mapmem.h>
-#include <asm/global_data.h>
 #include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Declare a new bloblist test */
 #define BLOBLIST_TEST(_name, _flags) \
 		UNIT_TEST(_name, _flags, bloblist_test)
-- 
2.43.0

