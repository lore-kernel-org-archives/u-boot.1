Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5158CCDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFA1988FE2;
	Fri, 27 Sep 2024 00:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X8b521aI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71ACE88F9B; Fri, 27 Sep 2024 00:42:56 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C15D889AA
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-45aeed46f5eso6707761cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390573; x=1727995373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEzsHDcxeOIs29JdDFKKZCHsR6B0CDfy/ct1oRnnm5Y=;
 b=X8b521aIk0Iy2eXolviIPiWTNg/me5g2hiV/AAi+zR0ELXzTMDlVmpY6hahUc74BTp
 n4p//65yT+2iqIjSXEk6m2JK11oEi8DSCsuk3lnWsN+Ho/mQqaEhiqZYJRbQ2RzrH4N6
 0tqmhPMkFN6HSs0RMMOdtrsr/0uahEv3aRKq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390573; x=1727995373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEzsHDcxeOIs29JdDFKKZCHsR6B0CDfy/ct1oRnnm5Y=;
 b=rq5wTYV3X0zrqLWNtSb51+G+c8jIAHXer0geIn+qZo/dzy/2XcbwuskzQOF6oVPHja
 Y0092RUW8XtmKrMMa3yOsl05kIGF0M///po3H6zx23VFHQiIxK/EPFT0QRJ7+ZGrpMnH
 BnbOuTBulLop/vnJsnfgN3yuzcSuKh9Cmw9tK7kmLtRlX7KupKUJILV1SK7Gh+ZxH471
 TLLUfuuSLqSLyU34bGMJxcabQK1r7X9FsGf97lt62mDtmo3/0bqfCq3xf7AS+5OvqPkP
 TW+tT3g/fRfmkvfulcrpQxDueF8bL/No56/rHo2PUD8Vfk7J0444iyo/jadUd8hWrj4a
 jw1A==
X-Gm-Message-State: AOJu0YzkM4692BbvJnMGv9tzvWo6RXZF7xJ8cnIJWEexDz4mR/71BB6P
 1Ei0ms0KnGQqo0AwTGhx/gQFBIwPHBLFVdEDx5OQxi8W5HEfDVeJgM6khwMo3I76woxD4KQQ+M9
 rXoPo7O0=
X-Google-Smtp-Source: AGHT+IE/ECFvqp25ZBchOXUhE1bW7BhXtJoNC3bMDtFdlZi0fJPKNHwvGw/zgQJI71CxfSC8kgL1Hw==
X-Received: by 2002:ac8:5856:0:b0:458:5716:fbd8 with SMTP id
 d75a77b69052e-45c9f20d1ebmr14709981cf.32.1727390573195; 
 Thu, 26 Sep 2024 15:42:53 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:42:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 20/42] dm: Simplify check for SPL
Date: Fri, 27 Sep 2024 00:35:45 +0200
Message-ID: <20240926223814.1276764-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Now that SPL means SPL (only) and is not defined for TPL, simplify some
checks for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/ofnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 129b34a5cd2..1ea6dd0e58a 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1468,7 +1468,7 @@ int ofnode_read_simple_size_cells(ofnode node)
 
 bool ofnode_pre_reloc(ofnode node)
 {
-#if defined(CONFIG_XPL_BUILD) || defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	/* for SPL and TPL the remaining nodes after the fdtgrep 1st pass
 	 * had property bootph-all or bootph-pre-sram/bootph-pre-ram.
 	 * They are removed in final dtb (fdtgrep 2nd pass)
-- 
2.43.0

