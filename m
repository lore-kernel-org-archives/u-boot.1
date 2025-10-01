Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BFACAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410468352B;
	Wed,  1 Oct 2025 23:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FBakQTww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2CDD835C6; Wed,  1 Oct 2025 23:29:39 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AA580107
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-90926724bceso26458839f.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354175; x=1759958975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+ybZQ6A9oAuoh7dcMCnQySKkkuNhCk4U92orrdkcKk=;
 b=FBakQTwwA/swS4YGvzNbRV4Bnb70vf8EuMcq4R7dZWzcJPyeJ8K5yjxxYqpeFCITaG
 3kfhLdk+UI48hz2Ky1yOuBfmzrzUo7lShLJkKEW/1zNNLWHvA9bKyFqOttOMnQ/+WzEq
 9GbSRReQZuPAJzfcLL8Anl9j2ArF2Wp0cu9kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354175; x=1759958975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+ybZQ6A9oAuoh7dcMCnQySKkkuNhCk4U92orrdkcKk=;
 b=E0v2//x7CZT0/RTQBPGNl9IkxJx0S7FBmaQ5nzerCAk/55aqKECSv/6v9og7mspOHs
 WXnk71UI9sUw+eD3wuFVCqdxaJzEjmh5BctWRA7/uN+WMDzuGpEwNiSMHkeVtowtEWtN
 6TyjYWcJmqChWjtLcjRiMejzq3EL/MDiAISKbWwHxpt+an0ObN33hCkpAG5roGjoRwfz
 y8cAR7taXBrzbHHdHg/N1aRqTiELjeP8hljdwswLwQ1Fb/hAVNgvXlhkghxUShbBjbMu
 eO0HtWkTCGy0+QA8LCcFz01TqekTQlaxstFm9JI/eSl22dsVArd9hUTFgyMwdBjRKUKy
 X07w==
X-Gm-Message-State: AOJu0YwFg84s8wmQz8y70r/Gt635067MUqI+7xxpV9PDrCjeqDkUQR/G
 jYKAoIvfy+qiMBfGRoTfRLwOjjOjUUwF72bhLUesNAHpX+V0fIN0qDnKcBtcEc0lKQnEIIL/scc
 bkuuDdFbj
X-Gm-Gg: ASbGnct5djxru0Q6TQm78yBwN+ETHl1acC90T6IIJpQ98IyHiaL2mlr+hBQG+6Qmag2
 Fh4EhmZ9E+CiY8PACS8Vuil1X1yvGfKbjV4gIZ/gl1TvtYui5NuzVx/St4fW25Esljc+b+aHD2w
 02eEE1et53HTAZeoehTvtEYCdwV7m+JTgVQyAd8212T/NJHiP6kOxfK5QsVWU9cMEzWNkt3jgHV
 c75uCnngm/TyfvLi7Du/52ddPEipcFzsE6hHT8fvYj3yfrnCc5pNTZ0MZt9V7sgLlfOfJdpgehr
 RaxkriFS8hgqfCkWxGXpeFwt+MPWFXTmfF/f5wyO2J4rAmP7695gvN2mk/dgfWbLDcVizG/B/Jf
 LBSDkStk41EWto3vFkdaZglfWlobfhLuuXtLClmd6
X-Google-Smtp-Source: AGHT+IFWDZzZnnOS+wGJthPa3xslNQKybWM7Z3SwIJlgfOPXvoDzc0l9TGumi8Hr+0AALHX8Tccb0g==
X-Received: by 2002:a05:6e02:18c7:b0:42d:8afd:4444 with SMTP id
 e9e14a558f8ab-42d8afd452amr15792005ab.26.1759354175639; 
 Wed, 01 Oct 2025 14:29:35 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
Date: Wed,  1 Oct 2025 15:26:27 -0600
Message-ID: <20251001212649.3263574-3-sjg@chromium.org>
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

At present when one bootmeth fails on the final partition, the next
bootmeth is not tried. Adjust the logic to go to the next bootmeth,
which is the more natural behaviour.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 8f38a1ab940..2ec05fe5432 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -195,27 +195,25 @@ static int iter_incr(struct bootflow_iter *iter)
 	if (iter->err == BF_NO_MORE_DEVICES)
 		return BF_NO_MORE_DEVICES;
 
-	if (iter->err != BF_NO_MORE_PARTS) {
-		/* Get the next boothmethod */
-		if (++iter->cur_method < iter->num_methods) {
-			iter->method = iter->method_order[iter->cur_method];
-			return 0;
-		}
+	/* Get the next boothmethod */
+	if (++iter->cur_method < iter->num_methods) {
+		iter->method = iter->method_order[iter->cur_method];
+		return 0;
+	}
+
+	/*
+	 * If we have finished scanning the global bootmeths, start the
+	 * normal bootdev scan
+	 */
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && global) {
+		iter->num_methods = iter->first_glob_method;
+		iter->doing_global = false;
 
 		/*
-		 * If we have finished scanning the global bootmeths, start the
-		 * normal bootdev scan
+		 * Don't move to the next dev as we haven't tried this
+		 * one yet!
 		 */
-		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && global) {
-			iter->num_methods = iter->first_glob_method;
-			iter->doing_global = false;
-
-			/*
-			 * Don't move to the next dev as we haven't tried this
-			 * one yet!
-			 */
-			inc_dev = false;
-		}
+		inc_dev = false;
 	}
 
 	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION)
-- 
2.43.0

