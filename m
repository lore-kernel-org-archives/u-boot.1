Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42262EB1076
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA5A840EE;
	Tue, 10 Mar 2026 16:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="V5MdoGg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF25C840EE; Tue, 10 Mar 2026 16:58:56 +0100 (CET)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1B2840AE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 2026031015585498e015c9300002073d for <u-boot@lists.denx.de>;
 Tue, 10 Mar 2026 16:58:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Zgo5m5FJefpZRhsLoYaHzGyYdGN2Ziz9CmEwifSuFcM=;
 b=V5MdoGg+I05qybVBTNDOGFRQEdzUNPwRt0iQlnbcN8Fw9Zle13IMKxpKMjjh/ldMw6B/0O
 lCJfrY9kSml+eijaKRt3WtsXihWjvvF90voLz2+Lq2vVEAtrZJTfHrxxqeQNQ7UqtbUTluEZ
 Uo47q+qkbaa8HjdrDGEhdMS2ZznjVPTe1Ba8AmGHwKCFVhX0QbQdOwMKpCy6t8gSFR3roOtS
 LKCHXmuIP6GxZ8SLMogaGPW9kbGIyZy2zoDrjcA5gl08b2nN/IrITIiRav1lHiYNmcA9Qgc3
 XKB9TifRNIV6GiPjALZyAfKWeE8kPHkljNQMNu0xe/NQ/GaM97CUGw+w==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] Remove confusing NULL from error message
Date: Tue, 10 Mar 2026 16:58:27 +0100
Message-ID: <20260310155841.126525-2-ludwig.nussel@siemens.com>
In-Reply-To: <20260310155841.126525-1-ludwig.nussel@siemens.com>
References: <20260310155841.126525-1-ludwig.nussel@siemens.com>
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

If no signature could be verified and the loop terminates, the iterator
'noffset' has no meaningful value so name yields NULL.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

 boot/image-fit-sig.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index e7a768b9add..433df20281f 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -593,9 +593,8 @@ static int fit_config_verify_key(const void *fit, int conf_noffset,
 		return 0;
 
 error:
-	printf(" error!\n%s for '%s' hash node in '%s' config node\n",
-	       err_msg, fit_get_name(fit, noffset, NULL),
-	       fit_get_name(fit, conf_noffset, NULL));
+	printf(" error!\n%s for '%s' config node\n",
+	       err_msg, fit_get_name(fit, conf_noffset, NULL));
 	return -EPERM;
 }
 
-- 
2.43.0

base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
branch: patch-signatures
