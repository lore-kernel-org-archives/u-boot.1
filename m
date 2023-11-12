Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F89CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A0A870E6;
	Sun, 12 Nov 2023 04:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aOb4k/Z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B6286F88; Sun, 12 Nov 2023 04:50:46 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD5708714F
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7ac61c58d85so141037639f.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699761031; x=1700365831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3J5qbGPbV4MgZOzrY3+zGsGXk6t9zFAjUxaImmgIOI=;
 b=aOb4k/Z8EDqML8XhvzVpo3R6ydVMmB8J33SUng/J3KAABSTKnDfTpRC3GKjTNzGG87
 bhup2BapKaNFJJ6XxGCEUa6juK9XsaxhdPdYB+v4uQR0w6rkce6Y9771jDbXDhH/HPGH
 m70yeFhIL3+38EIi2/YiIAIYsXagXmKmqi/04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699761031; x=1700365831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3J5qbGPbV4MgZOzrY3+zGsGXk6t9zFAjUxaImmgIOI=;
 b=FqxNj++iC09pnX+PqLnTDbtcKqFCrpMgUYOZGbnOjv3nugZaHAd8uuXo9ecMA2eQfP
 PSeLpS7NFvJCZXePpfzmCabeSLWRE4IqlvROlzuYTIhlUVqSGqIuww08sT29xN0+4Nlu
 VCdUAwS7/m2whk7yCFp3wRKdUKKIzRXt5RoU5JPiF9EQ35k5uhyOPw1TEsonziGQ29mJ
 Xvv0qSILJHzWfn3GeSFrTS/B7AxN3yBk9Pe4gqfpZ2FIRaIhYd5W3CzLTGWOvvwa6Ka7
 AJyNhppT1ZFZFLHxq23Q8MOm+4JNJieXWyULW6iwqWC2AsY9QNMF2XB3xyHXW8Sqmz9X
 j8sg==
X-Gm-Message-State: AOJu0Yz8G7fvUcvLDsnAG3ushlwtvoRipQ/XRuHAUiWv52B1xkwItnns
 SDcsSECU9tnv2umQSksE7adlR14xZfFPfmd7TsdU8w==
X-Google-Smtp-Source: AGHT+IFhXrUBSs4FpflDG93OE0Ri/zbJT1K/kDklRzL3AA9E+NaWezX+6VbNffV8N+3QbVbLiuaShg==
X-Received: by 2002:a5d:8199:0:b0:780:c787:637b with SMTP id
 u25-20020a5d8199000000b00780c787637bmr4229907ion.0.1699761031467; 
 Sat, 11 Nov 2023 19:50:31 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a056602305000b007791e286fdbsm817864ioy.21.2023.11.11.19.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 19:50:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 5/5] boot: Don't allow kernel_noload with compression
Date: Sat, 11 Nov 2023 20:49:57 -0700
Message-ID: <20231112035001.103897-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112035001.103897-1-sjg@chromium.org>
References: <20231112035001.103897-1-sjg@chromium.org>
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

It is not possible to execute the kernel in-place without loading it.
Detect this and show an error, to avoid a crash.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a 'success' case to the cover letter
- Redo how the arm64 support is implemented

 boot/bootm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4c150e895f2f..e3f5f81becd7 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -248,6 +248,10 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	if (images.os.type == IH_TYPE_KERNEL_NOLOAD) {
+		if (images.os.comp != IH_COMP_NONE) {
+			puts("Cannot use kernel_noload with compression\n");
+			return 1;
+		}
 		images.os.load = images.os.image_start;
 		images.ep += images.os.image_start;
 	}
-- 
2.42.0.869.gea05f2083d-goog

