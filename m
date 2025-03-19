Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54671C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762C9820AE;
	Wed, 19 Mar 2025 15:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RNq2kcyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03C6881FFC; Wed, 19 Mar 2025 15:56:00 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F299C82075
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913fdd0120so3756744f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396157; x=1743000957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nhrbqd+Ura7IlG+cOul1nbZH/bj08awwxkXE+6DwlYw=;
 b=RNq2kcyokbyrK3nD6Uz5uIUc02/Ec2S38CcUGfDYvFW2oP3OngNTNbq7EDOrCIywjB
 3rs2YDVEFT/vzRTAvDPW5C1Z9d7bgrWLIixVhldzGfS/tu8V0l4mIoRzTsEGrtfS433R
 bMKMMnmkLghvV7aVpH3EJECq3q1GNWeAM0ebQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396157; x=1743000957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nhrbqd+Ura7IlG+cOul1nbZH/bj08awwxkXE+6DwlYw=;
 b=pxHpIGfcZ89+hmLUeZzQ6BD+yBt2WXJngOgSJbLfVgMzuGkF6AI9XjdX/lCttIbmj/
 CxvZa9DHi/dcuzBU3FCntFN9VvPvqmQfTuYvw5N7F40jtzVeLCN94CAEE8S5HAt/pMUU
 meJfCgMG7suJ0nCg/cgqhkpMf5dr0HFXvIKDxim1U2B/2R5B+i9n0Yv+bZ9qOuiOCnVk
 exMVtOFFCWjGM2Vl8OlLoreNccROu9DQx6xp6FAwbX0bFSrXas/pKyYteXCuHsHyeaTj
 1Q2H4zvT+xJkJ4FbOf1FfETidLjQUFBNFw2SnFCnFK6mHLO6S5pxuxv8QnEO4gDLEkb/
 xP/w==
X-Gm-Message-State: AOJu0Yxb06tjE7mwAEg9IsgJDrgRg5mL6AZ5SkZGrxLJGKOOTY+mUyuJ
 gaeJCSUdGYl1N42rJjgO6Vnf/Cgy2sqxnRdirr9M/NkjpEf7Y2XhP1YDioB/twuG1U52YiCBMTY
 =
X-Gm-Gg: ASbGncvDu08TtqdZeor8aQaRn2V7TIDnXxqL4yeybZqWlRxgyR+FmI9wOXdIoECDYBY
 2Tpm4/KuNxG/5ft5x4xgbDpePOUctEFTYJ7WLrkcKhZG4PSoLfLhdAObjD9EdImUxDd8CmRZSG5
 mlVmLc2wgoqx0coyinhl/vLjK+r6secE+FUK09GzXrcvDBEfbcdMYg2d/y7cOyLQUpL8jAiMDDk
 z0Pc5IyEDkcna6c4ycMdDcP+n33L39X+AQHXVGo1gjlPZkKhAfbi7Awxw9cRRFH3cAUXcEisgCZ
 OrRtOTNIrEttyXL415ogVHgYB1bnMZLaSY027dl5pqC9z8jT7CAd
X-Google-Smtp-Source: AGHT+IHKz/28LzvyD92sf306DbHbLHDAEn0IwUKxc/BQkPoTNhbQnmSz+KJywUP/+3aicBjdyNkkyA==
X-Received: by 2002:a05:6000:156b:b0:391:253b:405d with SMTP id
 ffacd0b85a97d-39973b50785mr3156465f8f.41.1742396156891; 
 Wed, 19 Mar 2025 07:55:56 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/52] expo: Destroy the cedit expo when done
Date: Wed, 19 Mar 2025 15:54:20 +0100
Message-ID: <20250319145512.2391122-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Once 'cedit run' is completed, destroy the expo so that a fresh one is
used for any future editing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/cedit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/cedit.c b/cmd/cedit.c
index b0eca7b4daf..2e15b063462 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -285,6 +285,8 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 		log_err("Failed (err=%dE)\n", ret);
 		return CMD_RET_FAILURE;
 	}
+	expo_destroy(cur_exp);
+	cur_exp = NULL;
 
 	return 0;
 }
-- 
2.43.0

