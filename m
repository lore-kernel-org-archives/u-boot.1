Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3459C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD23A8744D;
	Sun, 12 Nov 2023 16:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jHM/sK5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0915B87164; Sun, 12 Nov 2023 16:28:03 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C0786E24
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a93b7fedb8so127795139f.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699802879; x=1700407679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suXcQPoTvuSyYgLcc/Fmm4ZeVbVH9OJBua/76XG1yGQ=;
 b=jHM/sK5bWYURzvSg1oiwXU46yRn0WoAClUKaTewBQTbd7T90HmiM1EKC14pYDcsHfj
 +gd5Bob9JI2SJbebIif1rcOv7F02AV46PVFwgjoosFR6wzBMvrxKVwA7cHFLG+xJECx/
 dozukfjnM1a+7vCakMGonSTs0wtj44Nb+D3/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699802879; x=1700407679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suXcQPoTvuSyYgLcc/Fmm4ZeVbVH9OJBua/76XG1yGQ=;
 b=hnQlCixfRakdsf8DjZNZaVeC/V59dk6Hvas0nKFqOE736j1bmGpmoQ1wOaNcC5c+V7
 OkJL+wUDyWzehNtgo0xTXnr5lrSDl/YND4YmK8yHsu3ql25xXMtXBoly3pxVioQYz9Yt
 FF3LxxQjG0pwXwRZAN/hTH6FVYzHeSbTo3u3z8VItidazT/SxpraDj9CmWspM3ZObPUb
 DdHXBqaww6swurNDppbIq9Rsi6GebHg2lYm0fRZvKnejkWw7o43qPVEJ9WnFyd2jHMKD
 ldzU1XrnXXoRMYc2agbDy+Thc++LoEQBM34zMop6546isaE4dZmgIFL3jd7HcHgjIGxe
 LGtA==
X-Gm-Message-State: AOJu0YyZOOIJDixT3pTVNXXGiDPueSOYfw1zU2RNscXdNB+xo1i9wdpb
 dpdb7An4ISsq9m5k0bsCzSwoQeqfI4KLTxUAvY5fxA==
X-Google-Smtp-Source: AGHT+IHR46RGgi1eTSSOg0jK4sOiSP6u+fNG8mORh6M27cdhljRlj3uVzN8fpZLCACK8nB35NMi4GA==
X-Received: by 2002:a5e:8809:0:b0:7a2:dee5:84b6 with SMTP id
 l9-20020a5e8809000000b007a2dee584b6mr5038987ioj.21.1699802879355; 
 Sun, 12 Nov 2023 07:27:59 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 76-20020a6b144f000000b0079fdbe2be51sm1226241iou.2.2023.11.12.07.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:27:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH 2/7] fdt: Check for a valid fdt in oftree_ensure()
Date: Sun, 12 Nov 2023 08:27:45 -0700
Message-ID: <20231112152754.130399-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112152754.130399-1-sjg@chromium.org>
References: <20231112152754.130399-1-sjg@chromium.org>
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

Check the header before starting to use it, since this could provide
very confusing later, when ofnode calls start to fail.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/ofnode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index c3d326831fc6..3956e1999c36 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -83,6 +83,11 @@ static oftree oftree_ensure(void *fdt)
 			if (check_tree_count())
 				return oftree_null();
 
+			if (fdt_check_header(fdt)) {
+				log_err("Invalid device tree blob header\n");
+				return oftree_null();
+			}
+
 			/* register the new tree */
 			i = oftree_count++;
 			oftree_list[i] = fdt;
-- 
2.42.0.869.gea05f2083d-goog

