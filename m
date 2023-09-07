Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6501FEC873E
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A630186AF2;
	Thu,  7 Sep 2023 17:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HwIlBEZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC6386B01; Thu,  7 Sep 2023 17:59:55 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6879186ABF
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34df008b0cbso4633185ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102391; x=1694707191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUVIy+NlgE679vE2b4tVji0tzWv9k/BOslOkZCxCnqM=;
 b=HwIlBEZAfYsSw9oKoIvkErE1snldwHumnSk7Pq09H7U8AtK8AJl5EXVEXt5a58W+eV
 5umyBeiczlUrHQnFL7IMQWB22ZKVinIRALzKdPAoVMYrGSSWgL+FUvo7Y0oavCds2Ain
 0xUFCkXOcjEd3IAjxuVttZcfw00pGx3fPZS6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102391; x=1694707191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUVIy+NlgE679vE2b4tVji0tzWv9k/BOslOkZCxCnqM=;
 b=gnaqfZnicaGwl+ZjIX0c9CFzVz8EKXg+mPEZu5bb6n/yBehMNBo0St9+o4lxwhPdgp
 TfFfDVQJpvRk5DQHrFx/TK1jLImu07FFGz/dM2NaVasFSXbed7G/294l73bj2dYXufyK
 VP9FaB2ziRvbSpWDRFLOsgmqrq0KJaR3XNpz5yO9xUlxQIiuJ5f8f+vPNi4uxy3W3YZ1
 A1xK8g24kP5eCVDdYx5JGlZECp86H0WTsQLAUTrCpzsbpNbi6rlJqX1L31SrCakOoHPq
 badkiyj/zBzAWlerHfglnYtOApAW0+LcH9UV6FzqWNtWpSZf9Lhy0DHKzTOzUdqxgg2L
 rMnw==
X-Gm-Message-State: AOJu0YxPM3m4QXc8WxEVzwPO/NnJO2jCz72SNs+EWnL7otjeWULlJ4vB
 zGZXUIECXAv7K0Bwrq0aroB368+Sf+MnPDN5VLQ=
X-Google-Smtp-Source: AGHT+IE/BIlAGZyHaWQsik83A1ws3B5yjfGH/b/nciIoZqZx7xr2T6C4A6BHqGiKA12XigBeLcFOnw==
X-Received: by 2002:a05:6e02:f47:b0:34c:dd54:10c6 with SMTP id
 y7-20020a056e020f4700b0034cdd5410c6mr117913ilj.12.1694102391084; 
 Thu, 07 Sep 2023 08:59:51 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 14/22] spl: Drop SPL/TPL_RAM_SUPPORT option for
 SPL_LOAD_FIT_ADDRESS
Date: Thu,  7 Sep 2023 09:59:19 -0600
Message-ID: <20230907155933.48511-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

All boards which actually define this address enable SPL_LOAD_FIT, or at
least just rely on the default value of 0. So drop the dependency.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to drop SPL/TPL_RAM_SUPPORT option for SPL_LOAD_FIT_ADDRESS

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 99a2ffca2fc6..f564cb8dd84c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -217,7 +217,7 @@ config SPL_LOAD_FIT
 
 config SPL_LOAD_FIT_ADDRESS
 	hex "load address of fit image"
-	depends on SPL_LOAD_FIT || SPL_RAM_SUPPORT || TPL_RAM_SUPPORT
+	depends on SPL_LOAD_FIT
 	default 0x0
 	help
 	  Specify the load address of the fit image that will be loaded
-- 
2.42.0.283.g2d96d420d3-goog

