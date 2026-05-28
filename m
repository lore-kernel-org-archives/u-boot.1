Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C377CD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 13:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECCB83FF5;
	Thu, 28 May 2026 15:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UeEuPXUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA648056B; Thu, 28 May 2026 15:28:34 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3017780398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 15:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E24993F877
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779974911;
 bh=0vK9HBUtyazpnJMY9EviA597szvQS8GAn+PKqtQpdj8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=UeEuPXUHNZL59OW0k1m4eb+iiFM75ZTkwe3UqNaUcX9IT6qyZAbMOvCjK5IEz/VYx
 9hiYIi7r1WW8PAdZTbdpX+yXT+r5d6vlC5AC12ufRYPi2BwZ2/MzCYgRv1F4KZfgZw
 eJ2RDZaHCpZHErVt8ualrfFmmLoUNpdnXFigJ7iVc37T/TFF0lXXCRnnLJMnbFm5Ia
 APUzClr8320wp5RMhhCwbCHxvhGfmB04uWf2OYGtc/YUQGN6qEdMHWnHp/QXYnEIhz
 bDtaf8upzLBY1Nr5EGSWlJlKjn9F0sDB9o+G4yM+RweYAb0nNOQcxP2oJiEYD5JsMV
 KmsCP+vIwFINhDe9/TAwN6H7Js38P93n2+0MmFEDFOxlLAZZh8xdsl1tOTmp7ZLLS9
 eskO+KC2TWr/LzLv17jPhKF+V8wE9NThKz4OJ3qN6A471maMRjngRLVUU1Aq2cBH6k
 SAs5rE14sp/sIBLI+FvnQsfeXxkVt/YDb1D7MaGNut7g/Og8ssLXV+5hxxgfZREJ33
 r/hPPfD+7/66b0SUr9ORLhQi9OHeOzOXA+Q+OrgWRmuWQJzDBKO+6EgN4drrn9VhII
 CAZ8TF+pqO7o7Zyd2GA2Xi2tdMRHjEBP84vnpN6oVmCRT/Bw4HzCWmqMsogops2W3Q
 kZZCVqpKv6BEn8aW0WPCmtFo=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2befe912949so11251685ad.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 06:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974910; x=1780579710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vK9HBUtyazpnJMY9EviA597szvQS8GAn+PKqtQpdj8=;
 b=aREuAR24K/ZxEMDfeEOGhAlMrzHHUEQPYGvJP3puApQ4omxcbMV3AMqZeIt5dk/S/F
 UdUXx32uEz4mFlELySkdTlCPc82TnhAfQyzSlcdcDlcdpohwNFWapw2Y/RcL7CDDU2Vb
 YOotFU4qqL/xsmCIVOGLsQVatgKO1sJjeTCnSbOQ0rovUEkbD7nyKaYOi1Ys83aSGgHr
 rSvEaHSfi8qO0JOaczOf02KWAV+1i9l/YeHJ/7zopKsKedoRnhFd6eEZsd3Tesr6w4Uw
 rM7+9y9TSBbqvjzKHumKTW7LEfMr8e6JGjIXSGlcLTxa42+LR94Fo6L9R7GzmBasenAn
 mHQg==
X-Gm-Message-State: AOJu0YwSMfPsFCGJwZuh4QPrJun8Qdq5D3vuU3IPS+UCoLXMl5SMAIa1
 7rg5YNERuvSSHjUqrHm/Ipg+l23yWblQsX9z702i9OG+ai93MikAhlkawn0ohQ9Tydz5TZXY6+M
 H68/tIpN1yiBimqUW861CyNEPEfKDLp5pgUqobp0Kl3k86XOuzv2pwvqRXwP2gOPviF/7/a9V7x
 7YfXwadQ==
X-Gm-Gg: Acq92OFBSLdIGJ/RW6vNelB3yXlQTmfXFmhpRb6mQuhlbzbave5XvChSi4+sI8g+ucw
 pigCgyTsP3lXEeEiu1XvOswBa/Rf5SepfizAyYUpWrA70hnzxW+/2IPcbqFovhoJBgSRpmqZf6q
 WM7OS+xSCcqg8J5lILM/ONoqD6HmtcwzGQ3YddipyzqqZ1oFaYOVBoAEn+BpEuPEkxHJJEIRBoD
 IAHriB1YoXImGP+0g3YIL2r3AvrqI/128hKqaX3FR4hPrMhi5FxGHtsEMq/MIPmmcU2IAHWisg2
 Tl7tpSXDMF9tkr/KjfZO65RDTDd9seE6nvHMIg93sgarKg//5q4qkVXYAk6zgRkgBtIzBSl6CJC
 rrWyN5ZQd6uyw9/kVCdORbz0VF0IFPchoV6TWEHxoznho5D6k5gOrf4NahvUIkES+sSymP0ZIe9
 sSdLGYd1g=
X-Received: by 2002:a17:902:e88b:b0:2ba:5e44:ce8f with SMTP id
 d9443c01a7336-2beb02460fcmr274687855ad.0.1779974910549; 
 Thu, 28 May 2026 06:28:30 -0700 (PDT)
X-Received: by 2002:a17:902:e88b:b0:2ba:5e44:ce8f with SMTP id
 d9443c01a7336-2beb02460fcmr274687455ad.0.1779974910170; 
 Thu, 28 May 2026 06:28:30 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3058sm187006315ad.39.2026.05.28.06.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:28:29 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v1 4/4] arm: k3: drop redundant tifsstub runtime filter
Date: Thu, 28 May 2026 13:27:13 +0000
Message-ID: <20260528132746.719699-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528132746.719699-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 15:30:21 +0200
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

With all AM62x family boards (TI EVMs, phytec phycore, toradex
verdin) now using per-security-state FIT configurations and selecting
the right one via board_fit_config_name_match(), the runtime filter
in board_fit_image_post_process() that zero'd out *p_size for the
wrong tifsstub variant is no longer reached. Only one tifsstub
variant is present in the selected FIT configuration, and it is
always the correct one for the current silicon.

Drop the filter so board_fit_image_post_process() simply debug-logs
the variant name and returns.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/mach-k3/r5/common.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 484d96f9536..13736ca5dbc 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -348,19 +348,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	}
 
 	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
-		int device_type = get_device_type();
-
-		if ((device_type == K3_DEVICE_TYPE_HS_SE &&
-		     strcmp(os, "tifsstub-hs")) ||
-		   (device_type == K3_DEVICE_TYPE_HS_FS &&
-		     strcmp(os, "tifsstub-fs")) ||
-		   (device_type == K3_DEVICE_TYPE_GP &&
-		     strcmp(os, "tifsstub-gp"))) {
-			*p_size = 0;
-		} else {
-			debug("tifsstub-type: %s\n", os);
-		}
-
+		debug("tifsstub-type: %s\n", os);
 		return;
 	}
 
-- 
2.43.0

