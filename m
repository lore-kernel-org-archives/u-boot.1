Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD44EE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA9E8927E;
	Wed, 11 Sep 2024 11:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ec+TPGJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63F78926B; Wed, 11 Sep 2024 11:59:06 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC8189246
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so12439605e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048742; x=1726653542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KD8m8Uo52xIaPv0WvJ+JiahFSS4fy+418GyTfuuiFzI=;
 b=Ec+TPGJTRIMTCo0LBdWBqTFm2jqiPThnq/zaXI2h+I/Tyj1U5BO09JozRFWSpVnVyV
 ZG4yWzrPCXWk8j76oPs7c/MkVRM6KDPMM9ObkvSrkcufz5j/jaSRYuImUGiz0u+BTD/M
 EcwVU5+Wfd2rYJm1G6S+4BOk6TAxs2F8COOutH4UlDuyrS/yTkiwDpWGNFMRJpyOfg5v
 cFPggRCX+RRZCumXRdouHFy7C8QOjgLwEo1vMYZ9ZflMRdC2SIw793mdRzaQ+NDnyxo4
 YXePJns6JZaT64/AveOcv1EzfCWomgO0qaiwCCfO8fagi5i+y5GsK/1dTSZORi0A81zy
 vvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048742; x=1726653542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KD8m8Uo52xIaPv0WvJ+JiahFSS4fy+418GyTfuuiFzI=;
 b=j9/q6r/q7gWsuXjvcxzaa9FYz49y8nLwscUg/f/6CN6q+dz28s7Id/hQ2r7eSLiCn9
 VSUjrbN3PAHODg4p9mo7EPXZQBkKAM8z0zshM0mOxEjZKDeA1xrh8TLebFW1fkf23/4D
 zBuVyr8vap3OGIGMH1KqUAio5fZXhrnEjIB1cMtmQUmsLP+I6KnCF+XDZ/eq42XvW9Jl
 w41OCooJGp1H5TypHP6uEJ9HWCmQLWvbf8awrNX5kKBZfnKEiz/B28v3ERGRYkxpu8Z5
 +68Ivewyn7Yf/j4YuZwyDxAMuKr+pQqaDadgGeUZSbXJkK6ZCstzkfGgkIbebvXQX5Ap
 JZtA==
X-Gm-Message-State: AOJu0Ywfe8tyskCDQuotzGlWNHAPyNxDvPi4+nVsfCOvayNp+/LJUoUK
 m9/is0JKs5+O8QurfmEMrOacirUPSGDtHCWap6BdZcV3bKptWuf4ZgTEcoPi53zf+84ApcZhYTh
 aYVFeLQ2h
X-Google-Smtp-Source: AGHT+IFS98lCdF1TmNJ0l/ZS2jNSOHrCrt8VRlBwTx0k4nf7yYDHTHMQ57OFXfrnD/1A/4PVBFPONA==
X-Received: by 2002:a05:600c:35d1:b0:42c:b5f1:44ff with SMTP id
 5b1f17b1804b1-42ccd35b3bcmr19533395e9.24.1726048741788; 
 Wed, 11 Sep 2024 02:59:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:59:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v4 15/15] cmd: pxe: CMD_PXE implies CMD_TFTPBOOT
Date: Wed, 11 Sep 2024 11:58:28 +0200
Message-Id: <16ee83d900089302331807d5b1e4f24468b1c9ad.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

cmd/pxe.c (CMD_PXE) calls do_get_tftp() (CMD_TFTPBOOT) therefore add
an "imply" to cmd/Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43f78a5aeb1..83c82818bf4 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2099,6 +2099,7 @@ config CMD_ETHSW
 config CMD_PXE
 	bool "pxe"
 	select PXE_UTILS
+	imply CMD_TFTPBOOT
 	help
 	  Boot image via network using PXE protocol
 
-- 
2.40.1

