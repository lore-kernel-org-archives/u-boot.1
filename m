Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FD2CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 556C183807;
	Wed,  1 Oct 2025 23:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ARyxicQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD6D83544; Wed,  1 Oct 2025 23:30:07 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FA783804
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-4248b34fc8eso3345345ab.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354202; x=1759959002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OE79mrVmr89L3ERFStLhkMMMO3eD2R5bkWh3Z/dsH8c=;
 b=ARyxicQvmAJLgLp6G1dtgExLLXD6RsMJtxFc2Xt7LRkrTSg2YBMBgeaXfdn3BrqtpL
 3t5KppvDYnDSgr7MfUI/4+RQVzmqqg+6YO6Mcs/jurFzH1J1MMrPyVGgwIyjRDidYG96
 x7EFYT0rczoMiypd4jTzPzD8TKQ6DRDfFNaBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354202; x=1759959002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OE79mrVmr89L3ERFStLhkMMMO3eD2R5bkWh3Z/dsH8c=;
 b=ZVVPuyj2zZXyeP7oXSFnD39YKbiluzHXdbAt0IxStYXvLc66L9nij28hC4ZJ/beWUL
 /NjZmFOFHnQUO6o9r1y8qpOIjej5NW9+aHDP315tYRJJRXYhXqhgLl/lpqYfPWmKpyhv
 l2SCFoEKxZw9mTzZZiZwFq2B8VW2Oy1j67f2ZuQmJuARRubDaXCPjU5M+oVk06J6TVjH
 F/+FXcM/39xMiu7BrTu/pjj/pP8K/qMi0MXF5Pr2TZ32vZQWrQxVo33aDtc0oAUOL15c
 3o60tSoCG9c4BO+QHXdOU5H9ibLgTk2/uZeDVZS0FY2jlBOjUvVF0uJg83PcyE/M5end
 9d8w==
X-Gm-Message-State: AOJu0Yx/rMxqeIvvZK0eisfIa6+YQpQ9GIsKGn+EpzfHP/F3gDmK742V
 iorwXCyUecBMTvRgYAPQpnHRzWZHfqdnlZDOWnmiQOwUx04SX8fIhO91RCSV0mMwSQ2BjlXf1pK
 aGLEnREyO
X-Gm-Gg: ASbGnct7EpuRESNq9yvBf+yOSfosGIhVN+wC4T+DJFPxSGLF4G7Enf2Fy3FIOHmtgB7
 kNhYTobb8lY5XGnksscDWBFZjINOOGUnb7D8iwi1POD/ZevC/oQBjbGikcYinNVKf2/fHLTzBTM
 K3xpPpZZrfGR4lotrDcqhmjrYwBlcChBjLhuM3tjsvmzqHMUQXBykve0rNcZZtDuhX74dW9fWO6
 CGqCqhskBeXNsSL1oDMPhHWCC7e+MHkExHLd1ykBk+bqk6c6j6mpbkHLGcwkTXelS0p4auo5iPG
 KmEQ4iFsUOjbSp9Z9k9g58Ye5A4LCYbA9dTmQc7ACo8hHK565N73tz4JjXxYxLVE+D4RxRgAbG2
 vQQESve+F68O1W/7Q38xtAnqH8csPagkTejsR6dwqzYWM22wckJM=
X-Google-Smtp-Source: AGHT+IFg3NM5VrrTiHOKCh2dm/vvELyxoUA28dHo0e6j1THKR7BWnQTRP+8jSD+y2KV+XKYtAuHpQQ==
X-Received: by 2002:a05:6e02:1a41:b0:42d:5d48:acb9 with SMTP id
 e9e14a558f8ab-42d815a0b0bmr65169945ab.7.1759354201727; 
 Wed, 01 Oct 2025 14:30:01 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:30:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/17] boot: doc: Update for new global-bootmeth features
Date: Wed,  1 Oct 2025 15:26:42 -0600
Message-ID: <20251001212649.3263574-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

Provide some developer documentation on the priority feature for global
bootmeths.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a bit more detail suggested by Heinrich

 doc/develop/bootstd/overview.rst | 40 +++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 0a237359575..e36cde4d360 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -133,7 +133,8 @@ which scans for available bootflows, optionally listing each find it finds (-l)
 and trying to boot it (-b).
 
 When global bootmeths are available, these are typically checked before the
-above bootdev scanning.
+above bootdev scanning, but it is possible provide a priority to make them
+run later, by setting the glob_prio field in the driver's bind() method.
 
 
 Controlling ordering
@@ -612,9 +613,9 @@ simply copied into the iterator. Either way, the `method_order` array it set up,
 along with `num_methods`.
 
 Note that global bootmeths are always put at the end of the ordering. If any are
-present, `cur_method` is set to the first one, so that global bootmeths are done
-first. Once all have been used, these bootmeths are dropped from the iteration.
-When there are no global bootmeths, `cur_method` is set to 0.
+present, `cur_method` is set to the first one, so that global bootmeths are
+processed first, so long as their priority allows it. Bootstd keeps track of
+which global bootmeths have been used, to make sure they are only used once.
 
 At this point the iterator is ready to use, with the first bootmeth selected.
 Most of the other fields are 0. This means that the current partition
@@ -714,8 +715,35 @@ to the next partition, or bootdev, for example. The special values
 `BF_NO_MORE_PARTS` and `BF_NO_MORE_DEVICES` handle this. When `iter_incr` sees
 `BF_NO_MORE_PARTS` it knows that it should immediately move to the next bootdev.
 When it sees `BF_NO_MORE_DEVICES` it knows that there is nothing more it can do
-so it should immediately return. The caller of `iter_incr()` is responsible for
-updating the `err` field, based on the return value it sees.
+so it should immediately run any unused global bootmeths and then return. The
+caller of `iter_incr()` is responsible for updating the `err` field, based on
+the return value it sees.
+
+Global bootmeths can have a non-zero priority, which indicates where in the
+iteration sequence they should run. Each time a new bootdev is produced by a
+hunter, all of the global bootmeths are first checked to see if they should run
+before this new bootdev. For example, if the bootdev was produced by a hunter
+with priority BOOTDEVP_6_NET_BASE, then a quick check is made for global
+bootmeths with that priority or less. If there are any, they run before the new
+bootdev is processed.
+
+Assuming they are enabled and the iteration sequence runs right to the end, all
+global bootmeths will be used. This is handled by a special case at the end of
+iter_incr(), where it processes amy so-far-unused global bootmeths.
+
+It is important to note the special nature of global bootmeths, with respect to
+priority. If there are two normal bootmeths and a global one, the normal ones
+are run for each bootdev, but the global one is independent of bootdevs. The
+order might be:
+
+    bootdev priority 3: normal-1, normal-3
+    global-2, prio 4
+    bootdev priority 5: normal-1, normal-3
+
+Of course if a specific bootmeth ordering is provided, then this overrides the
+default ordering. Global bootmeths must be listed at the end, reflecting their
+hybrid nature (they are bootmeths but operate on the system as a whole, not on
+a particular bootdev).
 
 The above describes the iteration process at a high level. It is basically a
 very simple increment function with a checker called `bootflow_check()` that
-- 
2.43.0

