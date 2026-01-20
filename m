Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C84FD26296
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 20:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BD683A2B;
	Tue, 20 Jan 2026 21:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TlD888ry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477608313B; Tue, 20 Jan 2026 21:13:34 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA7582A9E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 21:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45c9fdf2a06so2712561b6e.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 12:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768940011; x=1769544811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+Gdpebc1QkyzNIS/yJFnF4ByiQVtKx4D8+CUIWYeFU=;
 b=TlD888ryfmixoZPNZEUrIaMlAOTkTXd0Fk8KVidjPNyVjSQtJN49MelsieBhaXM0e6
 gc4Z9cAmwt7em8Q/q9W9Mz4nt+uDpc/06GQ0AkPYyBj1VtL3wM+OSgdbYHWl6KBtCuJ3
 CH3G9HoJhQytnMLwihBgZ4JDfaiyjacHzVyQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768940011; x=1769544811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c+Gdpebc1QkyzNIS/yJFnF4ByiQVtKx4D8+CUIWYeFU=;
 b=CRPbkOCk5Py2xdurBI5DQvu2raNdqvQ3juUl/AEGR2ucXwNjzW70jiuGb3vz0f2vqH
 QyGrrLTrwJj6tKPnzZ7+WNEy8cLAiBuqDNzRfNUr/eA0bMJ82ci9vTvSkwAgjtcptYlC
 8vBHacz6PIIIjYJrHUk0k1ZVdUM26uAb5t1H0piFrO+xJobMEwEecDX+151N0tjafYpt
 HSaqRfB4VHp8d/9wbQ4vRdowxmmV/XQ6kwlIFhSkunTWbfjv//GNiGxtyqZX6U9IS/vo
 z5FjLSXaQRLoE2YjAghuQ4k722vLJzswdg2YdQmkvV0MmQVM0pVgRU8MxZGyXEVj3nSz
 Vtkw==
X-Gm-Message-State: AOJu0Yz8Cxh9yatXTERKjGtQzcvIcx5JKDliIMRiDeJcmKAucLpSU/d0
 kt2pGivURzNfw45M9BunmrZ6SFL6p4zD05w13OeSdrEVaSQiTRyS7HL/HwLIUc7yvWLtFEAdN/R
 8jjLH9sU=
X-Gm-Gg: AY/fxX52dNH4bjILJA1A1x8sP0DrCxoqL0wsm1caWj3DAkBCb9jKkJ9K1xJMHgQKgic
 LcXftIndczPzieATRN+e0fdUZSy0sSdcqOsGxOYbHrQzUKmHXPrvU3Ef1cGS9QszmviqJmZGoLm
 CGxUBtYJSRQ0s+ozZWRwC/PTmKvYPHFrc6MgmYrJVYt6QJYk1zfHdYaCd298BmLiql5luWWtoON
 ZtAOpQbqx9tiX6jeYhLftJBWlOQOsK0nPLlDVTXoRm8uHMRpy9P2rPBekThbXs0QPPz6sVwJdb8
 ePrVy6VtUO447gkC4eia2AGkj+RprxRbxv6fWO6yaJehQUyzNzj9AJO90M8k3hSI1braDp9TxSQ
 JNzApMcUsGkIx+hH6hI36rKZvputQfZAWC2wY37H32++JojMikQ1XGr7EQie7xJWi8sCN2d1LFR
 CSBygLtLuMkeJOYiL1KGCzonS3j/4cfbeqa2pCVj+eRZogu0B3+Z6Yj3440NYhYt5qaM1Pl696W
 GiekPQszy4uX+miZR9pVYm8vX7e2470uvwr+Oirhg==
X-Received: by 2002:a05:6808:1a06:b0:44f:6a19:433e with SMTP id
 5614622812f47-45c9bf516e1mr7051181b6e.15.1768940010884; 
 Tue, 20 Jan 2026 12:13:30 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dec6619sm7417337b6e.3.2026.01.20.12.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 12:13:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 1/3] doc: develop: process: Move the existing block about
 patch application
Date: Tue, 20 Jan 2026 14:11:43 -0600
Message-ID: <20260120201327.451872-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120201327.451872-1-trini@konsulko.com>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260120201327.451872-1-trini@konsulko.com>
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

We have a long block about the expectations and feedback about a patch
applying, or not, as part of the Custodian workflow. Move this to the
Custodians section from the Workflow of a custodian section.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- New patch.
---
 doc/develop/process.rst | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 4bfbf0eb9c63..81e1aa7e34db 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -143,6 +143,17 @@ reworked/resubmitted, or if it was rejected. However, if a submitter
 feels it has been too long since posting their patch and not received
 any feedback, it is OK to follow-up and ask.
 
+Another form of feedback is about applying the patch itself to the
+source tree.  The custodian is expected to put in a "best effort" if a
+patch does not apply cleanly, but can be made to apply still. It is up
+to the custodian to decide how recent of a commit the patch must be
+against. It is acceptable to request patches against the last officially
+released version of U-Boot or newer. Of course a custodian can also
+accept patches against older code. It can be difficult to find the
+correct balance between putting too much work on the custodian or too
+much work on an individual submitting a patch when something does not
+apply cleanly.
+
 Review Process, Git Tags
 ------------------------
 
@@ -236,15 +247,8 @@ like this:
 
    #. U-Boot Philosophy, as documented in :doc:`designprinciples`.
 
-   #. Applies cleanly to the source tree.  The custodian is expected to put in
-      a "best effort" if a patch does not apply cleanly, but can be made to apply
-      still.  It is up to the custodian to decide how recent of a commit the
-      patch must be against.  It is acceptable to request patches against the
-      last officially released version of U-Boot or newer.  Of course a
-      custodian can also accept patches against older code.  It can be
-      difficult to find the correct balance between putting too much work on
-      the custodian or too much work on an individual submitting a patch when
-      something does not apply cleanly.
+   #. Can be applied easily to the source tree, as documented in the
+      :ref:`custodians` section.
 
    #. Passes :doc:`ci_testing` as this checks for new warnings and other issues.
 
-- 
2.43.0

