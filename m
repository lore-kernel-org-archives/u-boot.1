Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97232C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B82839AC;
	Wed, 28 May 2025 10:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eMMOJ/To";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D91839B2; Wed, 28 May 2025 10:26:24 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B82C8399C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40337dd3847so2507368b6e.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420780; x=1749025580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrLvn21sHj+4xUj8yeXZJMpyNPEJfBMCSRkpudTytdw=;
 b=eMMOJ/ToyLIzFxFZIdnzBilNp958ms1LWXRb4exrUN5HLmzLFBdc/bTDT62OgnEu90
 q0L8o8L5rEGBR/uW0K3xjEyDYfWXHAibvvIEDtUiQARgbsgOv5lHlUoJ/bylKw94bljx
 HuAc8KgCEBE3aDS+4R/u5iuPK8n1ahNKqfmN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420780; x=1749025580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TrLvn21sHj+4xUj8yeXZJMpyNPEJfBMCSRkpudTytdw=;
 b=ti2ezyBzJd6+Aho7uWTwFZY1QZnFgCCrEkjiZQvopsHciW5+fKS24jQqaT9tctTZWe
 ZBguIdYR250/P8sjwY8knbIlw01jcjM6T7+XbfVK3fdi7HUwRRo5nkerAVt0om+C3+at
 U/anrrln9pOEFRdzABx8+vPwdHrrJRojimhnxg3sBEnYfAg7JxJYN588tZr0qzNssblu
 SWuma0pi0vyv6WPz+p3l7qhxIuTnHXSRLK9+BYdbjoQ1u6z3zWwXmApwObNk33ReXDJY
 0jSVJShvl0GcLzlfDOSgh4qL0ncADHHuYYCEIAh/+EXXq4cdW2yzuhannMfI1T8CL6m1
 HvBQ==
X-Gm-Message-State: AOJu0YwND9+bhyDsDpwYuKS5r46Xo8srZSG34u2PNsVbETZqQCvRC03U
 oHee4V1aOsFLgbw2If2wjeOvBnAcuw1ZLLvy9o72XxjRSSb6NzpYX4mBHgtUjsXtKwemp1onitp
 OJPKxBqMW
X-Gm-Gg: ASbGncvv42SgetVEA/Ke/60V896SwiV6x05pmKvAKNVCiFIlZKGHo1m70uVcVapou0g
 oX2oRYjDRSIj/im4J1aINcZKabSJ2J175xaUle3lF/WGSDyl2zjeBNRjruU5WE5Los6RH6e/TrV
 2ghVXMXK1mIK72CYBfpkzIv5U7Uyd3tUumKWYvMa8LAil4wqtx+081NGpJvuq0lAHtqclQgtoE/
 HRsM+33dgpLoAUxPN8ep17+ItlNBkIPrXcb9Sv4oHSdnbvfj7ZHIoAMgYL+qm6iaUNhmvs3pyOh
 YnhslImxKS4KvV1yvOxhU1ptdH/jL+4p6yFeB7aiszJdNcMVAP55vB26lTkM5I+PcWSfFsiGpFf
 GmrV0ZLeDdKud
X-Google-Smtp-Source: AGHT+IGTLJjNJRqvtCqgJhw80b4KYFnPZR5/a3Bp7XnaGnLFefd0QNntQ+NQmdiVwDauMrlyfWuvfw==
X-Received: by 2002:a05:6e02:19cb:b0:3dc:80e6:3819 with SMTP id
 e9e14a558f8ab-3dc9b754f6amr171399505ab.22.1748420770143; 
 Wed, 28 May 2025 01:26:10 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/27] efi: Allow disabling networking in the app
Date: Wed, 28 May 2025 02:24:39 -0600
Message-ID: <20250528082520.152391-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

When networking is disabled, avoid trying to use networking in the app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_client/efi_app_init.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/efi_client/efi_app_init.c b/lib/efi_client/efi_app_init.c
index 25a9b105d63..ff31266fb12 100644
--- a/lib/efi_client/efi_app_init.c
+++ b/lib/efi_client/efi_app_init.c
@@ -342,9 +342,11 @@ int board_early_init_r(void)
 		ret = setup_block();
 		if (ret)
 			return ret;
-		ret = setup_net();
-		if (ret)
-			return ret;
+		if (IS_ENABLED(CONFIG_NET)) {
+			ret = setup_net();
+			if (ret)
+				return ret;
+		}
 		ret = setup_tpm();
 		if (ret)
 			return ret;
-- 
2.43.0

