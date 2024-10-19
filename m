Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56424D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B4188F92;
	Sat, 19 Oct 2024 17:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FvFxJF4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F04892E5; Sat, 19 Oct 2024 17:22:44 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5924A892DE
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83ac05206f6so44585339f.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351360; x=1729956160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k91jrQ8Dy5R42j5DYt/VP08w7fLtEZEvgSG3GQdNRio=;
 b=FvFxJF4mpeQQhxDcplle8zE4M/J6BD6vBNRQrQOx4AobbQKG6oVHqKAHSnoHMnlFZg
 r2aJPS6LDOoFnDQyUNIbWchhsnUO73ogFoeK862y4DoX5J6SPPIlBOSr7lqJixRYpbb1
 dy/knH4h+LO/XuqKG4fAVR4ofNR4BITKi88DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351360; x=1729956160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k91jrQ8Dy5R42j5DYt/VP08w7fLtEZEvgSG3GQdNRio=;
 b=rFoE7uv0+UfkJA+94uisLgsWy2Afh2VZ0E16KEH0bTn6cc+4DyIUTAY7XSfgrtXsN1
 0O73R/oY38EKM83Xs7OU9pym9101xjSt8jjHp40IM3z+kI724YuveVRv+YxWduRYkWoM
 VSa0R5TCVmY4vu+BR+ahCMQHwq6grzrGNgoALkyctxg/so8CsKr/6f6ykTwOcVSd5xW7
 DAaaFqcBUTyotApQi8tY7xli/uxzRA0C9YKNSj17zSj8g7ndAMBHUA2Bwt+89KRG69df
 ROKrq6wlgajPeCSCax9K9WflJ8cxsSnWvbp9ppxjYwgMIxLoqnM+gG/cmL8zAskyC0rM
 2ypQ==
X-Gm-Message-State: AOJu0Ywrg+Mnmr08Uy6qwKCoipGhhIvpVSutosfksokB99HyGfTNA0VB
 hAG66ZVzMeWIWI8qzs8L3jStTY4oF+VZZ77TFQeZ85mPCOVgMSdbST5huc2UHXDk99bfpePO+64
 =
X-Google-Smtp-Source: AGHT+IE9RtNqwp/W5rP3nWRfw+Svt2lL5iXqqdVEYJD91R/5IIJJKqWDsl9hAHTLhIGt9VdJb9EW2Q==
X-Received: by 2002:a05:6e02:1c8f:b0:3a3:afa3:5155 with SMTP id
 e9e14a558f8ab-3a3f40ba404mr52876665ab.25.1729351359946; 
 Sat, 19 Oct 2024 08:22:39 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 10/31] test: boot: Use a consistent name for the script
 bootmeth
Date: Sat, 19 Oct 2024 09:21:50 -0600
Message-Id: <20241019152211.1014896-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

In the bootflow tests the script bootmeth is bound with the name
bootmeth_script whereas the others have a name without the bootmeth_
prefix. Adjust it to be the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 154dea70a59..8ea284098e7 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -542,7 +542,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 	/* Enable the script bootmeth too */
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_2script),
-				"bootmeth_script", 0, ofnode_null(), &dev));
+				"script", 0, ofnode_null(), &dev));
 
 	/* Enable the cros bootmeth if needed */
 	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros_android) {
-- 
2.34.1

