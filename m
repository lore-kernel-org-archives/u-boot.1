Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A95CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 08:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FAAA86D38;
	Sun, 15 Oct 2023 10:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GJWpQYvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BF586E2F; Sun, 15 Oct 2023 10:10:36 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE25F86516
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 10:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57b6a7e0deeso2183695eaf.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697357432; x=1697962232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCN00h6MssjXrMy4jD3Rwo38u9v9j03pDBdmUricTMM=;
 b=GJWpQYvWE9Iu3wDBrXXspUJZojGBOWZo1FfzH5KWjWsvedZSZyk8fUB1e5hTnWMYqe
 ozcX/vTeiRduqQXQR+BFimARRHbK08Vw6Z/ap1M0aGk79cMVwcQClfoLji8PIo0/Whq0
 uZ3W4GqKqkW4ieKw127YCLSeB/LbG6cE6yqhTQuX9Yti+wE6YyZmcrWz1KY7NMZ3u73y
 qvzwyvWg2NGn1oxBTMlvW8f5eWcAjXw0ejher2TT8BWgJyX7AQJbNetCQeDPsejStT4U
 qUQ4sImDU/s8buL/uDNiAjt17hbfCWYGiL1wg25iDwG/I9O3d/y+kcPWUsqfA+rT931F
 aMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697357432; x=1697962232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCN00h6MssjXrMy4jD3Rwo38u9v9j03pDBdmUricTMM=;
 b=jMkD80vNDx4r2kwWhd4vYyMe5aIrN6a+dF3FNethuYQyVkOxBPPyQA2Jky334NqOgl
 hvNgF9mCRoA+fk1nXILZuW5yXiuS8ehn/QXiMJX/zjM3QgAHrllz8h1zIMpZO9BVGOs2
 wNB/eyXrbEPb7Ip7OQZRsWqBOUhlebf6dAeQRxjggmJcEOX6FmsbYhk/gIimplIJxlQU
 aeB4G2CkcngwyL8YhOQwPyjFClFjIZniKOZNfgdozjrMO+P7sol9sAiEfP3Ic+lrDTe1
 KgIgX38A9cJF3omg9hZ8UflZMwQ4R1dRB8b80Zuz/DFYT6sMZ2s/ZHNrk9KNqygmNG/w
 7/Wg==
X-Gm-Message-State: AOJu0Yz+Ftwkl6jjwWBlUqgB+AI4yTg3FbROeNNP08JEeQSp9uVjBla+
 tJg/Dg7Mqu2zJNhCPy7/ylKInHv3/ST0UA==
X-Google-Smtp-Source: AGHT+IHkekMaUEm0nJvQZks1CWQAroTN6LD+fH/5Ix6odNTWSJX4IUcreJd/WE1+ayD7NzUzB9mHCA==
X-Received: by 2002:a05:622a:1187:b0:400:797e:d694 with SMTP id
 m7-20020a05622a118700b00400797ed694mr39313737qtk.11.1697316492503; 
 Sat, 14 Oct 2023 13:48:12 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 a30-20020a0ca99e000000b0065d1380dd17sm1955679qvb.61.2023.10.14.13.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:12 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 04/29] arm: imx: Fix i.MX8 container load address
Date: Sat, 14 Oct 2023 16:47:40 -0400
Message-Id: <20231014204805.439009-5-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

We should load images to their destination, not their entry point.

Fixes: 7b86cd4274e ("imx8: support parsing i.MX8 Container file")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 arch/arm/mach-imx/parse-container.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/parse-container.c
index e2a9e2b2732..d7275a58c17 100644
--- a/arch/arm/mach-imx/parse-container.c
+++ b/arch/arm/mach-imx/parse-container.c
@@ -45,7 +45,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	debug("%s: container: %p sector: %lu sectors: %u\n", __func__,
 	      container, sector, sectors);
 	if (info->read(info, sector, sectors,
-		       (void *)images[image_index].entry) != sectors) {
+		       (void *)images[image_index].dst) != sectors) {
 		printf("%s wrong\n", __func__);
 		return NULL;
 	}
-- 
2.37.1

