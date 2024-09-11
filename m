Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765C8EE4987
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C83989267;
	Wed, 11 Sep 2024 11:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bR9dV2KG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1674289254; Wed, 11 Sep 2024 11:59:06 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D0989274
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374c3eef39eso3739432f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048741; x=1726653541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pQJ/U35Kq9qHhWWud44CyWS+0/ZT8DvHOfQHL+FlLc=;
 b=bR9dV2KGQ4lXKOLBwWFNxIw9rBV/gGAzB+TrDKaFV+CGquusYjdQPyXbgvPLx2evLk
 /DL5p5eCd8lBAnCpgEfwKpTRu2KPyKPAeEHP1eu52fu/5ZZtyw1UtXTHxsPIKEORMV7G
 q96VkwsqAfJdqb5vYhRPnPFAQljU7smKi2FuusfKZ4WV/32BG6Fz+duu1mTxn9m6dh+F
 zJkkeCHTTC2GALUzR08tJQL9LbkLAKjLgg6uTyq8ULwPUQFO7pI4GuCvE/9V4MCVE6NR
 vRVRtZ3Sx1/MeSYL6tBq0kMjFWqvUZSrltKyUkLeFm5K4/IucxWp8lAWOSevnv75m2Rw
 88XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048741; x=1726653541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pQJ/U35Kq9qHhWWud44CyWS+0/ZT8DvHOfQHL+FlLc=;
 b=mwUCmg/TvZgIk/et9UnzMmpXAV4vti46YQL7zSDcwo09pu+99D397nh+OxBAFMsBty
 UImjWi30N2jW4KUTQviuqc6wWjzRbnh4AcFryuoy6KMQ2Sb7OgUm3gixrSQy9UA+Ce4X
 mmKFLaNAHRhx6YP4L956BmsXjy6UxTSaw+OF+SpGJMYO5UKXfmSaPgu2AjfERC3JhHe8
 T6jyQzp+xACnTPdGyMxYMbirmCE6p7t4H0sSc1+TNJtxWmcQMJmZ47EU76SbmGWgNP1O
 uwHvKOysspmuIu0rSRYzCKry5/4dBnvMLzSy2DOVwMdLtx4azIaPCiGm1nI55z5SrOFN
 cXYw==
X-Gm-Message-State: AOJu0YwNcWQaIja4/niZgIw0nAe3U55yEs13HHxJ5zbceMEwrblcbi72
 BkAgc+oTmDCFAnechK0wPod2jckRVVIBqW0ZL+UD0ot4xb9SmoVJS8WuDQ3q/OvPwQm8FOUwRrd
 zL4w+Y3bg
X-Google-Smtp-Source: AGHT+IGOsw9rgf9egZPFHZxDvUEZ702B6sIqeOdtyUhTY0iny5GcRUvFceabAAh605taWS4FAQCQeA==
X-Received: by 2002:a5d:634c:0:b0:374:c40d:d437 with SMTP id
 ffacd0b85a97d-378895c9f9fmr10620546f8f.15.1726048740811; 
 Wed, 11 Sep 2024 02:59:00 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:59:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Devarsh Thakkar <devarsht@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v4 14/15] common: update: UPDATE_COMMON implies CMD_TFTPBOOT
Date: Wed, 11 Sep 2024 11:58:27 +0200
Message-Id: <38f8f0ef516ee215f9089a6cfb687fdca180de35.1726048404.git.jerome.forissier@linaro.org>
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

common/update.c (UPDATE_COMMON) depends on tftp_timeout_ms which is
defined in cmd/tftp.c (CMD_TFTPBOOT). Therefore add the appropriate
imply statement to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 83c81edac20..968d4fb66a8 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -934,6 +934,7 @@ menu "Update support"
 config UPDATE_COMMON
 	bool
 	select DFU_WRITE_ALT
+	imply CMD_TFTPBOOT
 
 config UPDATE_TFTP
 	bool "Auto-update using fitImage via TFTP"
-- 
2.40.1

