Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D321C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC81088432;
	Tue, 16 Apr 2024 14:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SbJ2guci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFDC88300; Tue, 16 Apr 2024 09:53:21 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14410881CE
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6eaf9565e6bso2519596b3a.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713253997; x=1713858797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+pSRHq9IUNtt+FfQAbtamhi30xC0HUXRAdlPl+ed/o=;
 b=SbJ2guci7BbcKWn7AeKBUW74QAiSGaLPmMkl3evbTjxBidcdGtLU/zwn4pzbHeibWn
 JLlDR2LBFSu6tKaznngtgaFuREaxS7uZq3RDxqr3Jxo3/nJ1/2FLA93T9LhukHcA6tEV
 Tn5lXizaDsKj+17sJ66loMFJNCC/Kp8t0bljbChKaNBYtE81VIjS2az242JIzTc9pHMq
 M4suaECJ4qhlIlmwVrL3QynCDy9zikGG5tdVHtyh9lvzIfjY8mg9E2o8Ss4c54ylrnjc
 mDnejncuUf9wLMUL7wYLb6KDPCaS4EY/gkcW7tz/UqTh+taHeWFKV63zMQtXpCUkVw7L
 Ex9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713253997; x=1713858797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+pSRHq9IUNtt+FfQAbtamhi30xC0HUXRAdlPl+ed/o=;
 b=I3u9H3Yx+L//gdkJ2U2xAxQvazbJQbav2x3e280dssgT6RHl/Dkj6Ux4EuWt3UVQrY
 rN/sCRZpbeJL7VTy+auygpi/kmlgPNVZHo/0ElxCf0dv7eWO2Q6+7AUIJg6M2/FrY4CD
 ZXw0Gz+EQATf8fu2RkD4FG7RdvQ6+hzEC0VgplylQ9I6w86H0rOkW7lRrlqx4GJi3MM0
 IGq0eVdXoOip5qFJHqsToWb/KckcXxLNd00R8gfogoCPDec0tpaS0B9x9lNkH3ZLgoxJ
 APfZ0mxbrvm6Exgz/7poZu02YDlxoVovQTdSDt31kWK8+upaWFSdPF8QzSFa6r95mQn2
 CaVg==
X-Gm-Message-State: AOJu0YyVmIFjP+mBMYK2RGEC9h4Dm7apsQ226UL+Va5WxkOa2s9TK1iW
 Vl/dn91g7BF/F4avBGnLYSSiHzVNwj1qoB6r+yjlZMfFY3DL2GzpHE/K98Ehr/aj6g==
X-Google-Smtp-Source: AGHT+IHvJo0AmZfksTu4lBwFUPyuRefdXdWA4RzpfWjKf/wPsckduZs/It+Or8E874NE0gKVeT3CiA==
X-Received: by 2002:a05:6a00:a92:b0:6ed:d5f5:869 with SMTP id
 b18-20020a056a000a9200b006edd5f50869mr12486483pfl.3.1713253996765; 
 Tue, 16 Apr 2024 00:53:16 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a056a0000cc00b006ed2709ada6sm8391681pfj.65.2024.04.16.00.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 00:53:16 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] board: sophgo: milkv_duo: Bind sysreset driver
Date: Tue, 16 Apr 2024 15:52:39 +0800
Message-ID: <20240416075254.13729-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416075254.13729-1-seashell11234455@gmail.com>
References: <20240416075254.13729-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Apr 2024 14:51:12 +0200
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

Bind cv1800b sysreset driver for Sophgo Milk-V Duo board in board_init
function.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 board/sophgo/milkv_duo/board.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/board.c
index eaa47be173..e7e28fe248 100644
--- a/board/sophgo/milkv_duo/board.c
+++ b/board/sophgo/milkv_duo/board.c
@@ -3,7 +3,11 @@
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
  */
 
+ #include <dm/lists.h>
+
 int board_init(void)
 {
+	if (IS_ENABLED(CONFIG_SYSRESET_CV1800B))
+		device_bind_driver(gd->dm_root, "cv1800b_sysreset", "sysreset", NULL);
 	return 0;
 }
-- 
2.41.0

