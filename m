Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47805C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762078144A;
	Fri, 28 Mar 2025 16:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="khb9RIh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DECC1809A4; Fri, 28 Mar 2025 16:35:40 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519118144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8dfso68519039f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176136; x=1743780936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmJKgIxcfQAIYD0EMA3/KIQPOQVJXOYiu32z40Bvx4g=;
 b=khb9RIh/clSdnydl2BspWReSpiV00JocC+9Cz9l1gbBDzSrgIuBN1vBuXq4aaZzgyI
 q4jkr/shLbrU/kezaR+9t81iRQiyIoineHSM7ALrbRXrz8YgnpkW8d2mLDLnoKSQghLL
 aZNvSyCCpkCkbAvtx4ALkY4UOn4XF4kFn3+UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176136; x=1743780936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmJKgIxcfQAIYD0EMA3/KIQPOQVJXOYiu32z40Bvx4g=;
 b=oztFq12Fyf3KEqsaXfIg3uGL8c00dBGoasnNod/RcRt79ywDcmAdOHGVOJu08gUwRV
 eWi9VzOLTg/p0dQOOWuy0/kzNmXaYptA9qiQJlqEvWmyVWreePXxUP0hrtPNw/N1776V
 30GBlFcOqTrdMnrzoqX23fu65k2ixyoxtxVYIin6ji190XFXqECviJvbUGzvGlhlpvgT
 eoq0vWUoIZlXNB2K5l1aPzzwRk2n8rzKiUS1YpaQuGhDH4LLOFT7ioVuxz68PaTB46vX
 YWn7uzK7K5bJBDSfB5zPgHtb4fqac455Qpp3LjElJTW0z5+pYfye4yQ9r2qP+guh/52N
 jWng==
X-Gm-Message-State: AOJu0YzAZcJ8fbO+TcCrMTl3fUDXVxSV3NQ8UyJmKJs9nXzd1kMrKTFz
 IqYGrtIKAKixc5r2VQYa6b8epeNasgBTxjvJ6/+M0xSSS7UkKfu+CvyWKzeepNHUl/rQX+8R42c
 =
X-Gm-Gg: ASbGncue377DHuxyUJfT3SNJWKHARZ8mJHmfEmY2nSUl7pktDAegQW+NN9Ak5EdJ/Us
 16NA/CVGGvT6/ZQNHOE24k4HnotNhxHDQWWXEohioYx+4oCSJIsW7NzpCuCtQsNMve4iBKBSRKO
 4c3FdyhrqBT4Udj2b32azro4DHMw1XBrtLK/1DZQq3Db4qWrNoeVb1eYYpEKuvn377dggBTdRqK
 riv0a/QKFPPzEOvwzJTWFRz6Aqnmt8zTe7daW0czARwaBWxnRBc051ZUN+e2ECQtNvdbBvItKiZ
 sSXk5HEEJ1dMaRUgfaUbNLTbpEJS1vIirFYtbszyIMv0NmtE2fi4xLBU72qe81cGGf3Y+MUSCVw
 eRSyRXWDDwf/LFJoL
X-Google-Smtp-Source: AGHT+IHezXRxoZhG1F+xtgIWfwzbdu+8whlnmrfUp4kJxtE9T00RIORhFBGBeriXoBEfDlsv1d8Bxw==
X-Received: by 2002:a05:6602:3897:b0:85c:c7f9:9a23 with SMTP id
 ca18e2360f4ac-85e8217f462mr1179008239f.14.1743176135738; 
 Fri, 28 Mar 2025 08:35:35 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 02/31] spl: Allow VBE to handle xPL size
Date: Fri, 28 Mar 2025 09:34:42 -0600
Message-ID: <20250328153522.3555472-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

When VBE is in use, the size of each phase is obtained by reading it
from a FIT. Avoid using binman symbols unless necessary, i.e. in TPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6b75910e243..e7157df1ff9 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -200,6 +200,8 @@ ulong spl_get_image_size(void)
 #ifdef CONFIG_VPL
 	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, size);
+
+	return 0;	/* VBE handles this */
 #endif
 	return xpl_next_phase() == PHASE_SPL ?
 		binman_sym(ulong, u_boot_spl_any, size) :
-- 
2.43.0

