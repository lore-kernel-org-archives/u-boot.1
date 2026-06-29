Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA22C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E581984874;
	Mon, 29 Jun 2026 10:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="Hpdj7K4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568DF84869; Mon, 29 Jun 2026 10:02:46 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42907841F2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20260629080243ba58f23ee3000207af for <u-boot@lists.denx.de>;
 Mon, 29 Jun 2026 10:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=POXwMJWCLdIjh3Xsi/N8Pfhd5RkczbfS++CgUdJSink=;
 b=Hpdj7K4O/T6lRyBlYlFiPo4ywRcuWNerTIUqLOnocdsyhwjeOph69ZZDcsr0Hs+kfPpT4Z
 SVFgrX5S8JSW0maGFAxnWB5RG8MKOu9skfqsxS67BWcSq5qTgszG1RXZSRG07oeMWlZh9pEt
 q8GsKHMDTNHA5CIVAdlvhDI1oBbM/PLNvV34CCVP1nHH+vT08fuSdx6mFe+pCPDTPoV3V7n/
 DQacEEliWKDLEdrXD+9bT4jZo5ZyiBi8RPUuzwTlmzX7VYiYF16X+JSbt6PtXcLQ/8sW66d6
 wEYEsc4FWBkkOq7AwSp//YA10QDV7hZua/8JOf0ikpVjPgJXMyAP4SXw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/6] test: include mapmem.h explicitly
Date: Mon, 29 Jun 2026 10:01:00 +0200
Message-ID: <20260629100104.v4.1.20756bff4397b8b9e5cd57e4be96a99118b7c1ba@changeid>
In-Reply-To: <20260629080241.36311-1-ludwig.nussel@siemens.com>
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

The file uses map_to_sysmem() from mapmem.h but relies on implicit
includes which may not work in all circumstances

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v1)

 test/boot/measurement.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/boot/measurement.c b/test/boot/measurement.c
index 71f503f1567..de4f7ff6196 100644
--- a/test/boot/measurement.c
+++ b/test/boot/measurement.c
@@ -9,6 +9,7 @@
 #include <bootm.h>
 #include <env.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <asm/io.h>
-- 
2.43.0

