Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4E4C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB3988D55;
	Wed, 25 Sep 2024 14:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZWN//i13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7083D88D25; Wed, 25 Sep 2024 14:58:19 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D68988D16
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d4979b843so845508266b.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269097; x=1727873897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rQjNcZEiTcKHYlVkJr41nBOjX/ScGLdvVwUCY2Idmg=;
 b=ZWN//i13PUcFKFtT1oWvo0GukUrZj2ZMVtbVEdYF68HCDXR6RyG05wSkrBACagbuTk
 A45gKH4equHsF0YcPQtrMok9W2Nc1yg2wJbnz8nU0tu/u9I5MEwRMGz50Nauje9Kewld
 NTPk7HW+8/4DaAHrR7w5hQXTbhk0H6obt4ufA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269097; x=1727873897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rQjNcZEiTcKHYlVkJr41nBOjX/ScGLdvVwUCY2Idmg=;
 b=VCJzniBNu79lZtaMKk/9vQxlVk+ReF61aknuvI6Zxs1ukKqYBM3SUeQE4VqYYcrAR8
 JFcEWn8oLGff7ZVOcu5DBx9m4i58IpAVANzTMx74t6MmIuqzlP9RwI1ibNB4imQc31IQ
 Zrz18A/U6CDMgqg6WUI+XyuW0b4Q1v8L6NYvc5rVd0wjD8su3a2OfrVkxbOW27RMenp2
 xv56JC4v8T1PTMS93Bc7PrLZvmHkPZydIQftf+e3GkA77ewTqlJBf9+abzlvU35bJl3O
 Gie7/hNCK5DZRPlm2qwOPL+vQYVbUrPeXJsTwLLxaGPAlqUozVBEkk94A9IQW2cEqyn2
 Lg/w==
X-Gm-Message-State: AOJu0YxLBWVdEfM/J15nQj6eFu5y10BY57S9ivbZ2t/pRTSZy2f3hhjK
 0Q22QiOktGL4ujdMIbEd5iYH1gPeidhqOVD5zSV5BQ83JTEcqt/4qByTkpTMaF/RSRX4gLfbzPB
 tIA==
X-Google-Smtp-Source: AGHT+IHBItOPKu6vdOYVmZ5ot5QEKY7pZeUzVrEJ4tNLZYsR6UVMsev7+W0x/1YsEm5NyWuW2d0tWA==
X-Received: by 2002:a17:907:3f0e:b0:a8a:7062:23ef with SMTP id
 a640c23a62f3a-a93a03c6dd4mr253839666b.32.1727269096615; 
 Wed, 25 Sep 2024 05:58:16 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 15/19] arm: qemu: Allow SPL and TPL
Date: Wed, 25 Sep 2024 14:55:41 +0200
Message-ID: <20240925125622.197915-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Indicate that these boards can be supported, so a new 'TPL' board can be
added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 656f588a97c..dfc735237aa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1043,6 +1043,8 @@ config ARCH_QEMU
 	select DM_SERIAL
 	select OF_CONTROL
 	select PL01X_SERIAL
+	select SUPPORT_SPL
+	select SUPPORT_TPL
 	imply CMD_DM
 	imply DM_RNG
 	imply DM_RTC
-- 
2.43.0

