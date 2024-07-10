Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B498C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 14:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6D2886D1;
	Wed, 10 Jul 2024 16:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f1Uw0I/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1BC88712; Wed, 10 Jul 2024 16:49:39 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6A988702
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso5414515e9.0
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720622976; x=1721227776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyjEfVaMEMdjvdWW1aJDTs/IKplrIBJotIiCmLQm/TY=;
 b=f1Uw0I/2Wr27oslyzEOTNYZHHNd08D9Bor7LiM+Ef8G5rhRH7d1PFUbz35IGBFI0PE
 vp9ikNBUBkhupPhX2kI1CihIEXkTFCdHkuHGjq/13f/5kgEHt0X9WQu1n0Ssd5S+QsXA
 aOSBEJP+2lrXcb1hls/kr1diPCUek0UefH9FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622976; x=1721227776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyjEfVaMEMdjvdWW1aJDTs/IKplrIBJotIiCmLQm/TY=;
 b=DAGdNqeilrtJw1bLV7ipNwUyDm/YG7U344YEDoiV7fYC0PbKl8zH3lbtSAhZbPsQD+
 DHij8i+L8YzHf+lY9Aol8Yq+UiiYb96nJvlrscokOGTCwzjfqjAp064Wfi+zuQ1Alg3n
 SmSHFnRqzN+CvO3rh9/ugZuTcm0aT89VFxfRwhqG9tNp6UGXqvDm/5uVb4BDtvZdrEdF
 Ut4IJZewYhq9TpJbj1yEroyWHIV4vPLcob9661SguvFVIcy7ECEea0WRZzecvdyv6v4m
 xtii1VuKD7q3xrCHt5uqg8wnN331ZzivD362HqB8So0OsecCUfZ5cfigIdadxoG2NsnH
 CfZg==
X-Gm-Message-State: AOJu0YwAt4U6rvcpTIF1YbbYu3rodtpS+GuipkVW8TKyHpSUCsqoJHEj
 r/zuZrFH9YuJEkZuazxQi/9lbu07Ql71fzXfGlAUfXyM/vOS18Xk7mYC9YDTqhPTc0L+UU87YHM
 =
X-Google-Smtp-Source: AGHT+IHnhYxMzloUixuKMtSUlh7WUBKon43uFMZo2rG+e3QqFSepPsR3mNvhBxK1VQ4ht8DOM3SFpw==
X-Received: by 2002:a05:600c:1c8e:b0:426:58ca:5a3 with SMTP id
 5b1f17b1804b1-426708f18famr40046825e9.30.1720622976287; 
 Wed, 10 Jul 2024 07:49:36 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426615876bbsm171534355e9.6.2024.07.10.07.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:49:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bo Gan <ganboing@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/4] malloc: Support testing with realloc()
Date: Wed, 10 Jul 2024 15:49:24 +0100
Message-Id: <20240710144927.3940789-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710144927.3940789-1-sjg@chromium.org>
References: <20240710144927.3940789-1-sjg@chromium.org>
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

At present in tests it is possible to cause an out-of-memory condition
with malloc() but not realloc(). Add support to realloc() too, so code
which uses that function can be tested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/dlmalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 9549c59f358..65b130fabcd 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -1758,6 +1758,10 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
 		panic("pre-reloc realloc() is not supported");
 	}
 #endif
+  if (CONFIG_IS_ENABLED(UNIT_TEST) && malloc_testing) {
+    if (--malloc_max_allocs < 0)
+      return NULL;
+  }
 
   newp    = oldp    = mem2chunk(oldmem);
   newsize = oldsize = chunksize(oldp);
-- 
2.34.1

