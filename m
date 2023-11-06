Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94887C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0AEC87060;
	Mon,  6 Nov 2023 03:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nXMjmxVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9CAE86CB1; Mon,  6 Nov 2023 03:26:24 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C810586CB1
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7789a4c01easo256147785a.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237567; x=1699842367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1Va1X3XdXiF+iEIUmHfwugKU/Uuh3QZg5MfQZcywG4=;
 b=nXMjmxVst3EF5ztCTpfpnsMGKenbVyh+AfYj5vtzdK+rPTQmu3HfQdc+x6KITP4BWr
 xKHM0Qj5ArwI2kvEdSe+wxWeF69o5NIAmzcgjWTUF8fYrD1lNATJM5AkfNXPxiUzmO9i
 HTQdxW1673mIa2xho5zkGd3BDKHYtcaSeSb4uAd+bslJTtOcqvJK1gJ6W9PQ57AvMMrm
 bPpnnC+Im7hPUKFMPrBqkgjn6in24qXHrLBSHJShpRokTshfuWb3BKPnpPB8r5POqqEO
 QQEEnV//9NDLGjszkX35Llrovu6Mh0xQJR2oj2h4kYq/eBKBjgWNprY+Yw0eCCNyQjBj
 q/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237567; x=1699842367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1Va1X3XdXiF+iEIUmHfwugKU/Uuh3QZg5MfQZcywG4=;
 b=U0ySgEaNLL6FH18PC6BMgOmZ43gFnzxWdrTmhC1EuQmtaXVahYDzzXBAl1s5ZedgyK
 Nad2/61+M0+hNXZsc5sEfP8DeRU2Up5Cd/bMG2lHtuEKir1SjgvI0r8eBxgVf/kUOiMt
 XDNK5TCC+lPBu77FwzLNC9LlEhT1NAFzUorN7lxBP01ufXjusAW3q34U81oFES9zTm9s
 STBw9h/9UxL3c4CSZJAfxfzYnL5VJlMe6107eu3G52b1gr2V2E1kwZd06zoIOxPzCP/D
 eFfg1xcGeIJDHOs1KaTjUdI/4/WAyQD2mhxzCecFjQntC9yimKMyKL1NqkV8ON1pqSB1
 ctEQ==
X-Gm-Message-State: AOJu0YwXY1aSjMcR00XzhmZEbv6k1c1hFLwAKBu43+r87kD66ITNorrF
 ugJj6WnHxRAynWYZ8SFM/g4=
X-Google-Smtp-Source: AGHT+IGI750E2DkqUenQYNHWjBtK8upvdMfWjrWvVfqwDF+yW0q+D5VF0ahQOJdJhmizC2bJ/zd9tA==
X-Received: by 2002:ad4:5ca3:0:b0:66c:fcfc:9174 with SMTP id
 q3-20020ad45ca3000000b0066cfcfc9174mr40928459qvh.41.1699237567411; 
 Sun, 05 Nov 2023 18:26:07 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 k6-20020a056214024600b0064f3b0d0143sm3024061qvt.142.2023.11.05.18.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:06 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v6 01/25] spl: blk_fs: Fix uninitialized return value when we
 can't get a blk_desc
Date: Sun,  5 Nov 2023 21:25:39 -0500
Message-Id: <20231106022603.3405551-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

Initialize ret to avoid returning garbage if blk_get_devnum_by_uclass_id
fails.

Fixes: 8ce6a2e1757 ("spl: blk: Support loading images from fs")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 common/spl/spl_blk_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 63825d620d1..144c8a65b5d 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -50,7 +50,7 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 	struct blk_desc *blk_desc;
 	loff_t actlen, filesize;
 	struct blk_dev dev;
-	int ret;
+	int ret = -ENODEV;
 
 	blk_desc = blk_get_devnum_by_uclass_id(uclass_id, devnum);
 	if (!blk_desc) {
-- 
2.37.1

