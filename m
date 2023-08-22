Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713A3EE49AA
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 471238724B;
	Tue, 22 Aug 2023 05:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TaS+D0c8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1477F871EA; Tue, 22 Aug 2023 05:17:22 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E69D871EA
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34b0f3b792dso13633835ab.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674238; x=1693279038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCGEI1FcdRMc+7RjEIwG05Zmxtb+ccfxmpgMr21A9p0=;
 b=TaS+D0c8s1SuVXUVg5uZp/Ndr1FmTZNbUKn6UYO1PkqzzteElYvwvkvFVBaPv8LY2Y
 rkh2/uAdhMxJ/WWlmeM7oPq2lkzTnpTTWJcx0e69pxnK5HiHBTDmUH34ICe8vHWLpbhS
 SZG/FWlMkX4hWPYMuivkX3yHywrlqa4uslhxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674238; x=1693279038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCGEI1FcdRMc+7RjEIwG05Zmxtb+ccfxmpgMr21A9p0=;
 b=P1g0Fvnw5w+RNTtYchgthhUZHmo0c1FVir5mzRP8qvfrkflp24bI+de+w/7huzcpmh
 3NKigvPw5uqwS9aOaadfxbRQNEOv5LHkdxNhz/XXwwA2OxYA9MEjJ/qHOkgiqpSwtJFr
 7j+spVWHY4CB2TNxqiie0PgsH+4vhV9btEkGqm9nLKjJfNhtwggUd6ZqPph+9MaPvw5g
 +7K8qAvO1fMHP0JeRWv9S8FtlxTnZRb8HdD+xZG0jsUNdvLovI+Kvg8PqUrcpVNCdydn
 ShkiRjpplNZab6dm+r3zZD+1pmMb6afoyq66Cjc9zRNdKTH3nxYS75eanEz6nvYL4rN1
 vwVA==
X-Gm-Message-State: AOJu0YyG4j4kEBSlVhg97CBabH0RzQhN3XrifqLBerxB1Wqj5/vw1U/A
 mfOtY9QdGye0EhWbm+LG34o81PFvy/SKsNUGJw0=
X-Google-Smtp-Source: AGHT+IFZK3LSfrjpT6C2vH8HFHjoxLJLSAVh+nM0zSwHpRNbx1BRdtvkMa2s/wBtG4II/h/zdjTlWw==
X-Received: by 2002:a05:6e02:c65:b0:349:9778:da0c with SMTP id
 f5-20020a056e020c6500b003499778da0cmr9383380ilj.5.1692674237927; 
 Mon, 21 Aug 2023 20:17:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 10/14] event: Rename EVENT_SPY to EVENT_SPY_FULL
Date: Mon, 21 Aug 2023 21:16:57 -0600
Message-ID: <20230822031705.1340941-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

The new name makes it clearer that this is for a full spy, with access to
the context and the event data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_request.c   | 2 +-
 boot/vbe_simple_os.c | 2 +-
 include/event.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/vbe_request.c b/boot/vbe_request.c
index 312edfa2bdb5..2f218d4bf97c 100644
--- a/boot/vbe_request.c
+++ b/boot/vbe_request.c
@@ -230,4 +230,4 @@ static int bootmeth_vbe_ft_fixup(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_FT_FIXUP, bootmeth_vbe_ft_fixup);
+EVENT_SPY_FULL(EVT_FT_FIXUP, bootmeth_vbe_ft_fixup);
diff --git a/boot/vbe_simple_os.c b/boot/vbe_simple_os.c
index 8c641ec07e2d..3285e438a568 100644
--- a/boot/vbe_simple_os.c
+++ b/boot/vbe_simple_os.c
@@ -109,4 +109,4 @@ static int bootmeth_vbe_simple_ft_fixup(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_FT_FIXUP, bootmeth_vbe_simple_ft_fixup);
+EVENT_SPY_FULL(EVT_FT_FIXUP, bootmeth_vbe_simple_ft_fixup);
diff --git a/include/event.h b/include/event.h
index 062b5847897e..b2cfd65c9f8b 100644
--- a/include/event.h
+++ b/include/event.h
@@ -195,7 +195,7 @@ static inline const char *event_spy_id(struct evspy_info *spy)
  * away the linker-list entry sometimes, e.g. with the EVT_FT_FIXUP entry in
  * vbe_simple.c - so for now, make it global.
  */
-#define EVENT_SPY(_type, _func) \
+#define EVENT_SPY_FULL(_type, _func) \
 	__used ll_entry_declare(struct evspy_info, _type ## _3_ ## _func, \
 		evspy_info) = _ESPY_REC(_type, _func)
 
-- 
2.42.0.rc1.204.g551eb34607-goog

