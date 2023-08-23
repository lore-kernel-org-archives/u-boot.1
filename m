Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDB0C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B18E864BA;
	Wed, 23 Aug 2023 20:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Foz2uUZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D4D86473; Wed, 23 Aug 2023 20:48:09 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60AC6864C0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34bbb4b580eso18684725ab.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816486; x=1693421286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/NTkFkxx+uamYabwvDLLvBCDtTYJwcQJN0gYSfD9WU=;
 b=Foz2uUZHAFvViQvZfzoDGFw9UuEAux14ZdrVQUv245HHv1/LYZUH5hBnNXbp0r6x/j
 njcLjRk7e/6jt0xaNrVrBgQUCU2Ijr1b+zvb6HLXpgTtBWZ/W92bKpefUS1DFN0UFzvX
 bhbCQjjaG8HGPaDr8sAooEQMPa03P+TCizPt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816486; x=1693421286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/NTkFkxx+uamYabwvDLLvBCDtTYJwcQJN0gYSfD9WU=;
 b=bxAxBEGngLI5yj4lt88AJXnwzuREu8rQfPhH6dPPtJX8G/Q34R1WPiE4pMNIFPLEcJ
 yWlfVwrobhIe5V5CC+9Es/D868Fetd5yI9qmQDnkKpbAqM6vyncUF988IoGTFC92dRCT
 bSn87UkgVZOzYsYlbnA2I9qydh4cfWJ3q4re9HImEmWuS4bkM9kDXgSTEsrRvaZz03C/
 qzt7Pa0hYKQlB6y9TD7vaoP+lI4ydmB9vAW7qpGxPC/cja3aTt4Zwc9qNPOeuO2DH0pb
 4bVdfoe97WzVZlNAILu7+/VMJvd0iW629Ib+vQnoQI1xPAWXVoTbBzlCMiyfs/Zftb3I
 naQw==
X-Gm-Message-State: AOJu0Yw9BLMQ7/2zu7S0lD0XlaNygsFb3l0Xuh9w3DCVJ+R1lgU01rNE
 5Mj4/FURA/h862c9Dx/oWM21YOPr03O02AZfheY=
X-Google-Smtp-Source: AGHT+IHCOW9eCxEscHkHZiLgtsHo4jG3YO9mqMnVhyYG7YIUVsnXMt7o5dy0AZ6us+VgS8dcRMdqYQ==
X-Received: by 2002:a05:6e02:1523:b0:34b:b16d:aa38 with SMTP id
 i3-20020a056e02152300b0034bb16daa38mr4058409ilu.29.1692816485953; 
 Wed, 23 Aug 2023 11:48:05 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:48:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 6/8] x86: broadwell: Set up MTRRs
Date: Wed, 23 Aug 2023 12:47:39 -0600
Message-ID: <20230823184746.842091-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823184746.842091-1-sjg@chromium.org>
References: <20230823184746.842091-1-sjg@chromium.org>
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

The current condition does not handle the samus_tpl case where it sets
up the RAM in SPL but needs to commit the MTRRs in U-Boot proper.

Add another case to handle this and update the comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/init_helpers.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/init_helpers.c b/arch/x86/lib/init_helpers.c
index 60a2707dcf1..bf0c921577d 100644
--- a/arch/x86/lib/init_helpers.c
+++ b/arch/x86/lib/init_helpers.c
@@ -15,7 +15,8 @@ DECLARE_GLOBAL_DATA_PTR;
 int init_cache_f_r(void)
 {
 	bool do_mtrr = CONFIG_IS_ENABLED(X86_32BIT_INIT) ||
-		 IS_ENABLED(CONFIG_FSP_VERSION2);
+		 IS_ENABLED(CONFIG_FSP_VERSION2) ||
+		 (IS_ENABLED(CONFIG_TPL) && IS_ENABLED(CONFIG_HAVE_MRC));
 	int ret;
 
 	/*
@@ -23,11 +24,9 @@ int init_cache_f_r(void)
 	 *
 	 * booting from slimbootloader - MTRRs are already set up
 	 * booting with FSPv1 - MTRRs are already set up
-	 * booting with FSPv2 - MTRRs must be set here
+	 * booting with FSPv2 or MRC - MTRRs must be set here
 	 * booting from coreboot - in this case there is no SPL, so we set up
 	 *	the MTRRs here
-	 * Note: if there is an SPL, then it has already set up MTRRs so we
-	 *	don't need to do that here
 	 */
 	do_mtrr &= !IS_ENABLED(CONFIG_FSP_VERSION1) &&
 		!IS_ENABLED(CONFIG_SYS_SLIMBOOTLOADER);
-- 
2.42.0.rc1.204.g551eb34607-goog

