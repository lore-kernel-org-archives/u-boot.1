Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F23E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973B789706;
	Wed,  4 Dec 2024 00:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OOK5mTRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B0D88F55; Wed,  4 Dec 2024 00:47:38 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC576896F5
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8418ecda199so216301539f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269654; x=1733874454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqrsMmPwPo46XJn92V2eHwp/JJbrP7PGh6pnbvICI1A=;
 b=OOK5mTROMLqJ/ezXoqgumKV/BFnxzNbFK4OQ5WHtfFOwwJHiOfmoukzGrx5xWPR1Ub
 ck6kMlr0H3sM15DZdjLK7QGTJzmw8ETxJljgt5h0S96/xJVYrw0UwK3QAePm7LfJyWZU
 LkcXj84mJtJggjgGHbsz/VGlqQaBCMSjRmWTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269654; x=1733874454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqrsMmPwPo46XJn92V2eHwp/JJbrP7PGh6pnbvICI1A=;
 b=Xi47kTSr1UZEeacsrMsZTQn4XCEt434PftNNoszyS0lf5U+LTrA4k/dDLRS5yjRdE/
 0o38WF6gjYrkP2mFlUdNiKGmW86d2MwaLu/R3J6sxzr6ELqqSiW3pCgSAF4Pmz34qzEg
 JWInOEr2F5ANizCaP/KuTcUBtf2asIp4q7gTi8vmlwXCizhECAK2IBwAtIhUWQUHV8YO
 h9Ok7CKxgsgGbJFXb6sZDSzwNppCkvnGkyYQZpuZMni//fPQiqmzfj3vhUCi98aOuhaY
 uteasfd6E7Zt+cPjn4dmBmGQZM+an4jrdnTwKX/YGOvov623/6PBmJL0tn/A3EJIV/B+
 R8YA==
X-Gm-Message-State: AOJu0Yz5y7BKDRrOLP5zLP0AI7GRtP4cmMNlgEkhXMjZ4mvU2qxnWKx1
 hOcfzHWwsMg+ADtjYvGm4XN1iY8GJ/uxSjx+gbWAPJaY3SIlU56gCt7SQDRgQ2wf4Lw34C7VdTw
 =
X-Gm-Gg: ASbGncv2E2o4ZGSY2VfAUOlCKumpfxYhazTjxjrZay7gYiT0nuja/FdFdmz2+9VsS/Y
 3iRSs1JF2/nyuon4YqZ66R92zQ0XTGDZr8afEGpsseFvtu2VulQRdRRmPq/mcv31o0f7sB0ivoD
 g7ZXsBaIXGAGLnL1GvoC6XZ1SPgvmN3WK0Yze8NkEI+ttc+S/xQUdnNSS6RpcOROzEwk5B063rm
 bgcSxMrNdRB5bQiavRVnomClIXN/LIK3SuDRWMi2ovtKp7EWmnsCTq+63DCDt3/2hFkFu+l73tN
 EpOzg8PJNXE=
X-Google-Smtp-Source: AGHT+IHVOxZZ4kIWO88UFVbdkzdiUeGhgxGMLF01zEz4u+ZmLy+QPBDo4rfxn1ux1YVM9qpUGHgDtg==
X-Received: by 2002:a05:6602:6d8c:b0:83b:28e2:4985 with SMTP id
 ca18e2360f4ac-8445b5cb8e9mr553176039f.12.1733269653646; 
 Tue, 03 Dec 2024 15:47:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 29/41] pxe: Allow skipping the boot
Date: Tue,  3 Dec 2024 16:45:47 -0700
Message-Id: <20241203234559.2938192-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Provide a way to skip booting the OS and just return. This will allow
bootstd to read out useful information.

Add debugging to help figure out the flow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c    | 12 ++++++++++--
 include/pxe_utils.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index f7bbc1527af..3531ab1c71a 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -782,6 +782,9 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		printf("append: %s\n", finalbootargs);
 	}
 
+	if (ctx->no_boot)
+		return 0;
+
 	label_run_boot(ctx, label, kernel_addr, initrd_addr_str,
 		       initrd_filesize, initrd_str);
 	/* ignore the error value since we are going to fail anyway */
@@ -1566,11 +1569,15 @@ static void boot_unattempted_labels(struct pxe_context *ctx,
 	struct list_head *pos;
 	struct pxe_label *label;
 
+	log_debug("Booting unattempted labels\n");
 	list_for_each(pos, &cfg->labels) {
 		label = list_entry(pos, struct pxe_label, list);
 
-		if (!label->attempted)
-			label_boot(ctx, label);
+		if (!label->attempted) {
+			log_debug("attempt: %s\n", label->name);
+			if (!label_boot(ctx, label))
+				return;
+		}
 	}
 }
 
@@ -1621,6 +1628,7 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 
 	if (err == 1) {
 		err = label_boot(ctx, choice);
+		log_debug("label_boot() returns %d\n", err);
 		if (!err)
 			return;
 	} else if (err != -ENOENT) {
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index e8e03430a81..beadd221475 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -109,7 +109,8 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  * @use_ipv6: TRUE : use IPv6 addressing, FALSE : use IPv4 addressing
  * @use_fallback: TRUE : use "fallback" option as default, FALSE : use
  *	"default" option as default
- * @bflow: Bootflow being booted, or NULL if none
+ * @no_boot: Stop show of actually booting and just return
+ * @bflow: Bootflow being booted, or NULL if none (must be valid if @no_boot)
  */
 struct pxe_context {
 	/**
@@ -130,6 +131,7 @@ struct pxe_context {
 	ulong pxe_file_size;
 	bool use_ipv6;
 	bool use_fallback;
+	bool no_boot;
 	struct bootflow *bflow;
 };
 
-- 
2.34.1

