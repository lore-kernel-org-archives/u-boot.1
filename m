Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C53C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA8FD8855B;
	Wed, 26 Jun 2024 18:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fm6qKhtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072F1884DD; Wed, 26 Jun 2024 18:00:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C20C3884F1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-424acf3226fso8632935e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417611; x=1720022411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfQhvNgKcrCfr+fuDoJ/yQIZ0hGftxiA34nh3+CI+jY=;
 b=Fm6qKhtfz8OismkO23MBYcX8NEjJ7rGQWynx2NGGHXdHA0bFl7uEvA0lS2zWfp9UmC
 ShJW6Yq3pshahYQ6oM6/S9Kr2OtIfC/5tFLBn3prlndH8UE7jg81KfQEzRQPvH6LeGwg
 gakJx6AODXjMpz7cDkGqGqKB80EE3zFOEOJLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417611; x=1720022411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfQhvNgKcrCfr+fuDoJ/yQIZ0hGftxiA34nh3+CI+jY=;
 b=nnX548FcQK3KgAWgPvoO6yDe2c3PtdF1Ej13sXAnV29koF0JmgAKu/CY9xZ6faeLT6
 4gepIIBzRR4l/v749HlI68yEGOuPVjLM7zYxe9W48l/j3+jnCEH1u63468BWLrco/Ygt
 gWImJSQbYXEwnTMiXs5d8A1A6hIm2ZjNB/yh8xU+J2UIhmlkr/D3jsRmnoT1M/OuLNMA
 37FSaBKQXKpZKagViUW0R8RGTaNf1cqDOqebgV9CvNSBPZL70QcwNfv+2zV7yby4cbJd
 a5/IVmLzuJoNmQkbO8WqNj8Bp1s4Xx1c61hqtNZU31jrfBn2o1kJZwvmGWdnx/KOdcLt
 mBLw==
X-Gm-Message-State: AOJu0YzKF5NeqFIIdADvFL2nc5TXsJzSLH8QdeqqF8QDCs35R8v8JgUZ
 3hUKAckr2vpqdtedH/I8OBkTK9UQKFLLjwHyZ8+3C8iZp/5QTDLdnxiJ7o/rIjiLv3YgrmxISb+
 +vw==
X-Google-Smtp-Source: AGHT+IFvp/1tZMc8CN0d9uxkAn10nNhMOY0BAmYSaUReeac2+RmcPjjOpySQUKnbnvkBSBoNxsXvXw==
X-Received: by 2002:a05:600c:3b9c:b0:424:8e97:5feb with SMTP id
 5b1f17b1804b1-4248e9763femr66249195e9.3.1719417611093; 
 Wed, 26 Jun 2024 09:00:11 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 08/16] x86: Set a board-size limit for chromebook_link
Date: Wed, 26 Jun 2024 16:59:37 +0100
Message-Id: <20240626155945.278640-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

Set a size limit for this board so that we get a build error if it grows
too much.

Note that the limit is approximately, since it does not include the FDT,
microcode and fdtmap, which can change in size. However this board is
fairly stable, so overflowing this limit will likely result in the image
not fitting in the ROM space available for U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Add new patch to set a board-size limit for chromebook_link

 configs/chromebook_link_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index a9f91dd9b26..1a72fd178a8 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -15,6 +15,8 @@ CONFIG_DEBUG_UART=y
 CONFIG_HAVE_MRC=y
 CONFIG_SMP=y
 CONFIG_HAVE_VGA_BIOS=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=630000
 CONFIG_FIT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
-- 
2.34.1

