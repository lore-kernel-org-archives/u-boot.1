Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DA1EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A38986A49;
	Thu,  7 Sep 2023 17:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l/sxsQos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0838286A78; Thu,  7 Sep 2023 17:58:45 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877B186A7B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso45235039f.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102318; x=1694707118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkfDEVz2ERbQRqwi7v2/7eFSOFxCb2gLUclaAxl1Emw=;
 b=l/sxsQosRJwCy9Ugy9BYDO/Nc68jbaRHmz3/aDsuHo6KwhdWBd+xC0cvV1Bt2nIZVR
 f+c0giDlG1kpx9ry46qwasxQhiqbArMWqRKXreI1QblgnJs/E2ziWKi2Ms7U7AGQBo1V
 lmHLaOXfq+jdjRByojf4q1lNTNGMAusNpsokI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694102318; x=1694707118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkfDEVz2ERbQRqwi7v2/7eFSOFxCb2gLUclaAxl1Emw=;
 b=VqkMEXRY6sTblq8x65dRzA5+sk7tIPZpainLylmSycopiACJFBDi7Af1ye2Fl4xryt
 CBceg+AB9zH1vY6qIlNK6m6vTO7pfho4wOuMywk7OUb1hWodJJ5NOmjCwInZJ9c9+eQI
 m8eFdHDCr3tAjQiphvZ4Z0mzp69ZhaJU0Wv+VA8tOCswh1le3GwfDJ0E7j2mYVhM/4pv
 WX2dHtNPit5ZPbdgNkfaN0MaaCAXFOq/rMri4ZaTVhOSPjbV5anuxDyrTEXC+cn1C1N5
 MhpPx2HagfQwP+adX4qejQIXjaWS/HyKsUvmw6fjti1RSaicEhMBdD9KuBOTcUS4raXt
 1kyg==
X-Gm-Message-State: AOJu0YxZ+4pdEY/rDKj/pGdLVIsyTcaNLlZMoPRMJ9iEnTDyvNSMOU+H
 0XGrAf3n+vpGrgXW+56TXGOM0DVKb211jrQu+PI=
X-Google-Smtp-Source: AGHT+IHXVZT+CfaW4pOYIailJGoWxnNHliWIif5+bUwwj2aCRlbBNOArxJWxdggihjDsjCEEZmimAw==
X-Received: by 2002:a5e:c814:0:b0:783:4f8d:4484 with SMTP id
 y20-20020a5ec814000000b007834f8d4484mr166241iol.2.1694102318011; 
 Thu, 07 Sep 2023 08:58:38 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 9/9] x86: doc: Update the list of supported Chromebooks
Date: Thu,  7 Sep 2023 09:58:21 -0600
Message-ID: <20230907155825.48056-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
References: <20230907155825.48056-1-sjg@chromium.org>
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

One is missing, so add it. Also mention the SoC used in each.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 doc/arch/x86.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/arch/x86.rst b/doc/arch/x86.rst
index 725a1ae58639..89d3e7ba0e4b 100644
--- a/doc/arch/x86.rst
+++ b/doc/arch/x86.rst
@@ -25,12 +25,13 @@ are supported:
    - Bayley Bay CRB
    - Cherry Hill CRB
    - Congatec QEVAL 2.0 & conga-QA3/E3845
+   - Coral (Apollo Lake - Chromebook 2017)
    - Cougar Canyon 2 CRB
    - Crown Bay CRB
    - Galileo
-   - Link (Chromebook Pixel)
+   - Link (Ivy Bridge - Chromebook Pixel)
    - Minnowboard MAX
-   - Samus (Chromebook Pixel 2015)
+   - Samus (Broadwell - Chromebook Pixel 2015)
    - QEMU x86 (32-bit & 64-bit)
 
 As for loading an OS, U-Boot supports directly booting a 32-bit or 64-bit
-- 
2.42.0.283.g2d96d420d3-goog

