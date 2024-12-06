Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9A5E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6098971E;
	Fri,  6 Dec 2024 03:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AEW7Ess3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88AFE89622; Fri,  6 Dec 2024 03:37:09 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57CEA895DE
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a7deec316aso5579645ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452625; x=1734057425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEaE1fphclgQDqzpnHdWb6ml0j7J3NisLCZD8sOxWfU=;
 b=AEW7Ess30iL/SnjdVcHiEBQb8eA6P/D2MC0IfJt498aJCDB3PLJW0fbpyqScEXXIea
 WyVbYLKpfFAyynhPLfTc1D33gJQAeNAQtcF7iwbRIJZCrbTlRkCcsluYCLD/JhZDeZ4M
 zVofC2ChAjH/MiHiJ50xoHn94/A6nxrZRgyn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452625; x=1734057425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OEaE1fphclgQDqzpnHdWb6ml0j7J3NisLCZD8sOxWfU=;
 b=S2sEa7Y0aUO2/uVvhYPPH2LA4GK6MASvkNzIZIWMPtF6dMazmg943+rL0jZmlyzur3
 UtIym6qLTNawIdii7JFwBK3ZZ3t9kohidNh1XXPhyV5gEWu8bAczVY6rJfYhsrNWEpQe
 756SKijUXdMwzoVZpPNgcdPWmcr1ovkhcyIcTeILvyBySCBdxEVviZm+yzXKv035VuDc
 HNK2P4webnUbgbXNOT8Q2DCf+kmicOXw1N7CrZCsPzHagXS2LCaiBGLSxoetAx8BvJj8
 9DkDJs5xN7gNWr2DzdDlChVYQ4gXyIiU5hiCqaemSaVZNY3MAlVrKxN+mRhuuWiU7ufm
 keVQ==
X-Gm-Message-State: AOJu0Yz2oPt/h8pj8OBkimHIpol7maGgh1bjYSvPOptu0+HrL/T2CzaG
 /h8SSOaHERT15x2Ui2jYvrl9Jo8ZZgtKxEVX6tD1gTcjJ/c3Xj5PHD3Vk1RnOxdiZ5z27/MWV9Y
 =
X-Gm-Gg: ASbGncuKzRJ5Onp5ISvym45s3gsVQYwjrwJpzKXpnVUlWVRY3S/HlOYyBh0nr5ObMf5
 NyNBGeej5UCnPa5SxtPNsf1s5mnUlhM4LnV8M6UsSmagDgkVhFoqb5VZ8ojWb0ZLUR/0Cp5XGbK
 /gD1SXgaMsWXd+H97cTgcyitDpta7HPLI2Fk2qrl9MvSoNQiuVe11NHCNp+lTC9NuAd9Tz0BckW
 yezjAEUhLASe+PScAWfl4UcxC+n4LccEHos7egPS96HgA85XC7sO5aP/+msKldXq4RuoctlctN+
 wf90fWh+XMA=
X-Google-Smtp-Source: AGHT+IHfATTvoaIAxBSQ5gih5qElI9Be25LY7FmW4bBbuZQJBJHX+E25Gwvb2dXs8vyLjkOeed66Aw==
X-Received: by 2002:a05:6e02:1c8f:b0:3a7:e528:6edd with SMTP id
 e9e14a558f8ab-3a811db7d25mr20105995ab.12.1733452625545; 
 Thu, 05 Dec 2024 18:37:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 13/46] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
Date: Thu,  5 Dec 2024 19:35:52 -0700
Message-Id: <20241206023626.2456858-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

This code cannot be compiled by boards which don't have this option. Add
an accessor in the header file to avoid another #ifdef

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/bootm.c    | 8 ++++----
 include/bootm.h | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 16a43d519a8..0a1040ef923 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -633,11 +633,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
-			   load_buf, image_buf, image_len,
-			   CONFIG_SYS_BOOTM_LEN, &load_end);
+			   load_buf, image_buf, image_len, bootm_len(),
+			   &load_end);
 	if (err) {
-		err = handle_decomp_error(os.comp, load_end - load,
-					  CONFIG_SYS_BOOTM_LEN, err);
+		err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
+					  err);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
 	}
diff --git a/include/bootm.h b/include/bootm.h
index c471615b08c..d174f18ac18 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -89,6 +89,14 @@ struct bootm_info {
 #define bootm_x86_set(_bmi, _field, _val)
 #endif
 
+static inline ulong bootm_len(void)
+{
+#ifdef CONFIG_SYS_BOOTM_LEN
+	return CONFIG_SYS_BOOTM_LEN;
+#endif
+	return 0;
+}
+
 /**
  * bootm_init() - Set up a bootm_info struct with useful defaults
  *
-- 
2.34.1

