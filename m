Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9094BCDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B9388F75;
	Fri, 27 Sep 2024 00:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aCE1brIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571D688F75; Fri, 27 Sep 2024 00:41:30 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5320B88EA3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-45826431d4bso9586811cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390487; x=1727995287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuQWk7Wsds8j4m4mEEAWE3rrdiI7gxeAJseaSyfjESM=;
 b=aCE1brIofBsRGY6dc+/UFFUUq/GbFgXpD3OmBxTYvrZW3W8dHzv0i1rAAKRpMkdrZQ
 djpD2Ff3h7DCmouCF9Muw9zfo/l5uqWQwxJijS0gSkseEjttklOClCTd1ZySkAizFksh
 r3Tjq4YvNZEtcLuh34hFQ/XInNkNTqn6nnVPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390487; x=1727995287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuQWk7Wsds8j4m4mEEAWE3rrdiI7gxeAJseaSyfjESM=;
 b=XZGNW3+YU1yAeKArbGM+oN+SnySPB3VUmSntxGCNtkpaxpcIoiut3u0sKqOXCVJ8Ev
 yOCRdMplDlkJK7lpScSsa2PYfYoGFHawOiX3Ef0K2t6frMO12EISoZQHEDOsQub3VSEl
 +L3EfFVHPbxTZljtYpmKgylyLBdnI4bxw8zuhZQNIqJrz2AY7TRFsACVcRC/p4c4vQsU
 lK4lxU+DFHuVLRPaFDYAurI6VwFzB7fMmWkMhEJu0qJ/2ie3aO7iwoAGxWuvCFm7dkY+
 WlSPbdtOBbWkfEB0vberGNoSM0eyoJ0YF4dhDp7fA9W3cmVtlli0tF4WXp9nLEne2+o5
 qu1g==
X-Gm-Message-State: AOJu0YzBDf63KL0CTwXD3B2/hYUq6Yr0xnZyEk9taivuqyxOPMkSQTMz
 hNu0j4S7eg4mtoXdrPcnrTLtlqBk7P1GxBYyaSMdWy9mrg/soQmvL8AUxMFa8zxpzn1/1aVlfr8
 Iy/MiEKo=
X-Google-Smtp-Source: AGHT+IHetyKXulHagZ9SFvunrVA7Cg4OBTBnHXgJgVTOQ5JOWNZnK/wcQ4nyqnHcUVjNuu6ARss/iA==
X-Received: by 2002:ac8:59ce:0:b0:458:4e4c:b68f with SMTP id
 d75a77b69052e-45c9f2713eamr13543871cf.46.1727390487082; 
 Thu, 26 Sep 2024 15:41:27 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:41:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 11/42] qconfig: Add XPL_BUILD to ignored symbols
Date: Fri, 27 Sep 2024 00:35:36 +0200
Message-ID: <20240926223814.1276764-12-sjg@chromium.org>
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

This now appears in the code base, so add it to the list of ignored
symbols in qconfig

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 8c2fc9efc5f..71e911eeb3b 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -77,7 +77,7 @@ IGNORE_SYMS = ['DEBUG_SECTION_MISMATCH', 'FTRACE_MCOUNT_RECORD', 'GCOV_KERNEL',
                'IS_ENABLED_', 'IS_ENABLED_1', 'IS_ENABLED_2', 'IS_ENABLED_3',
                'SPL_', 'TPL_', 'SPL_FOO', 'TPL_FOO', 'TOOLS_FOO',
                'ACME', 'SPL_ACME', 'TPL_ACME', 'TRACE_BRANCH_PROFILING',
-               'VAL', '_UNDEFINED', 'SPL_BUILD', ]
+               'VAL', '_UNDEFINED', 'SPL_BUILD', 'XPL_BUILD', ]
 
 SPL_PREFIXES = ['SPL_', 'TPL_', 'VPL_', 'TOOLS_']
 
-- 
2.43.0

