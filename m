Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E36EC47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45F0879A0;
	Tue,  2 Jan 2024 23:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o5WhC/AR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213BB87987; Tue,  2 Jan 2024 23:14:12 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C9C8798D
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-680b12e5d42so14644236d6.3
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233648; x=1704838448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qmxi7Xm6MPG70aTc5pbRkb5IbOkpnJOZzhkrqaDaKPA=;
 b=o5WhC/ARpKE0CvL8x3XZl+u1glfEKG8Y/n11FQyDjuBHHin9Q2gXPkWdx/GoPVA+lv
 kmxstQIhCMn/5pCNpVFq0ruvUNQYaHRqTINjjjELOCsV83EMTrpXhPS5YxXHsmOZPDt2
 UwYbh+pl2Kuyfwy0Vwq/efOCk4uj4WTOwNvA3PfR01mFRCiNWN/8yFoIcSQrialkWpJJ
 h8FNTyvNqYbAvB1HD2ghnGZ2rDGQLp8yHcIGB9h/dJta4aVENKOuNEvcjKpTTn3mjUo1
 qCOKIRxMZBmWz2EPfLcv+NIJqob71ZrInpmavjgWJnZvEZk0X63Gj8WpwuDDfSt242Xg
 ORhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233648; x=1704838448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qmxi7Xm6MPG70aTc5pbRkb5IbOkpnJOZzhkrqaDaKPA=;
 b=pNSO6UEIzucrrRcuLfTOL/vLNeU/ztvPsGbD1iyq2siOJSs45q0maQZwjC4S/noGM/
 wn3qly5bt3L9V5JxCa4VvL9Hu5aF+tBa1RmLu9UG6tzl/ZnHieL1m/34iRT51dQRIYEW
 14Q41vmdwfyURBgpbU02vDvb92EfGNTYzEgUyenkWugrhsUMf0qTOlqhtcssQ1IsWXZm
 DaOIXtmkOIP1xCzFTSd6sLiBzNJW2S0VIzhTLYo2ariuwvR2J9MkqjbmcvthT6e2xM+n
 aRRD+TBNZBoWP7bmE9qrSZjye0UHgKQuturgFrbpwCFd+otBzbyYoq8aFso1aqKiz4n0
 1+BQ==
X-Gm-Message-State: AOJu0Yz7e4MD4r413/DiXjQVmFLClmPu41tLYwBpmiKoH7K0SPUgBfWw
 boB3fyVjEelNxxOQ95dh+t45kRWo/k+HX3+Ysz7Q+OaK4r4=
X-Google-Smtp-Source: AGHT+IGu1LEt+bU6IqgWArRKtkiAJ0pewpmMh/Y/kCY1m2WF1MbXp6UC1HlDFcopW1aMcAwp4uAFpA==
X-Received: by 2002:a05:6214:2601:b0:67c:cd09:9b93 with SMTP id
 gu1-20020a056214260100b0067ccd099b93mr25520674qvb.7.1704233648554; 
 Tue, 02 Jan 2024 14:14:08 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:14:08 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v4 9/9] fdt: get FDT from bloblist
Date: Tue,  2 Jan 2024 14:12:34 -0800
Message-Id: <20240102221237.1007090-10-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102221237.1007090-1-raymond.mao@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
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

Get devicetree from a bloblist if it exists.
If not, fallback to get FDT from the board custom function.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Refactor of board_fdt_blob_setup().
Changes in v4
- Move the logics from board custom function to fdt library.

 lib/fdtdec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 7a69167648..02a0504fad 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -8,6 +8,7 @@
 
 #ifndef USE_HOSTCC
 #include <common.h>
+#include <bloblist.h>
 #include <boot_fit.h>
 #include <display_options.h>
 #include <dm.h>
@@ -1676,7 +1677,13 @@ int fdtdec_setup(void)
 
 	/* Allow the board to override the fdt address. */
 	if (IS_ENABLED(CONFIG_OF_BOARD)) {
-		gd->fdt_blob = board_fdt_blob_setup(&ret);
+		void *fdt = NULL;
+
+		/* Check if a fdt exists in bloblist */
+		if (IS_ENABLED(CONFIG_BLOBLIST) && !bloblist_maybe_init())
+			fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+
+		gd->fdt_blob = fdt ? fdt : board_fdt_blob_setup(&ret);
 		if (ret)
 			return ret;
 		gd->fdt_src = FDTSRC_BOARD;
-- 
2.25.1

