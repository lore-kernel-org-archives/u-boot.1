Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0522EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 18:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF4F86CD7;
	Sun, 10 Sep 2023 20:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fx38bjZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F5586BFF; Sun, 10 Sep 2023 20:25:09 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBEA86CEE
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 20:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3aa1446066aso2666295b6e.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694370304; x=1694975104;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YludUDClnB7NiU9lKL4p9hbZieK2S4U9NN5JPvjKYso=;
 b=Fx38bjZmbjjl4n+2WH8/p3RAM0s1M6PHH2Vq0zO1nDrl4MfsrMM9wQD4jm+5bHyj+z
 hD+JT64ACLXZ80X2PCn0GrlDWMjM8TnoY1BWJJHAqjZRglE42eLlulT4vJhzO7S4zmYm
 sqV5+bp3t+CToXNfR+5kWm2FEB0PTIo6WIvlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694370304; x=1694975104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YludUDClnB7NiU9lKL4p9hbZieK2S4U9NN5JPvjKYso=;
 b=kQNZSflD7WVbI4uZj2osQ6/ViXz6ZQXXppVdY/dUdIbp86H7CGi3cIyJM/oWwPxXed
 p7uSCOXzPUOoOvN1M5XuBs3MSYnN91o4pHG5zPh2GYALYeF+lNSAQvT5AHyO/dUDysEn
 i5KzKpM56vGOyFJIgkH+2urtMOz+aXWWZJmbJTjfXJVUOCRUGoluUdpsdbsXgbnUKq82
 4MspfvsuQyrEbiX32szatYr3vCsnuTAZQ4u9L0uk6A3XHRN5o2WiWnUb9zSBHN3rFXWw
 TuAS2WnH+KMr7g6fWtW+cOUt0rDsIoIYtZQP2lDO5Gzxl3Tee5zYtm65YgGjAbuhF3zZ
 t4xA==
X-Gm-Message-State: AOJu0Yx0DY8ccHRsw4nF7gNv+k/Vi2SNCSVOuLd4Q6vmbDgamVWyWVyb
 UEm4KtKqGK6YWjC2jYa0B7mt4A==
X-Google-Smtp-Source: AGHT+IHJdGbppb/Ek/HZQ+ulSPdkw9SRQ7dMmHcVpUBGTvGmueraeaoQTou+bbkPFik5LN8CiNYypA==
X-Received: by 2002:a05:6808:144c:b0:3a1:f237:ec62 with SMTP id
 x12-20020a056808144c00b003a1f237ec62mr11892553oiv.48.1694370304660; 
 Sun, 10 Sep 2023 11:25:04 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a655c85000000b0055b61cd99a1sm3720593pgt.81.2023.09.10.11.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 11:25:04 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v3 3/4] rockchip: Add support to generate GZIP compressed
 U-boot binary
Date: Sun, 10 Sep 2023 23:54:47 +0530
Message-Id: <20230910182448.285542-4-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230725035101.281325-1-abbaraju.manojsai@amarulasolutions.com>
 <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
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

Add support for generating a GZIP-compressed U-boot binary with the
help of binman, if CONFIG_SPL_GZIP is selected.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v3:
 - None

Changes in v2:
 - New patch for v2

 arch/arm/dts/rockchip-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index be2658e8ef..8f248f941f 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -56,10 +56,17 @@
 #else
 					arch = "arm";
 #endif
+#if defined(CONFIG_SPL_GZIP)
+					compression = "gzip";
+#else
 					compression = "none";
+#endif
 					load = <CONFIG_TEXT_BASE>;
 					entry = <CONFIG_TEXT_BASE>;
 					u-boot-nodtb {
+#if defined(CONFIG_SPL_GZIP)
+					compress = "gzip";
+#endif
 					};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 					hash {
-- 
2.25.1

