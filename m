Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED4FC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 468838197D;
	Wed, 12 Mar 2025 18:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bwWw10Bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1859F81760; Wed, 12 Mar 2025 18:59:29 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42AB81870
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a66so28215266b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802366; x=1742407166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7XqagNELDS/EVs+Mbn2eWBNhVZNxuTsEtgTZ1Gvirs=;
 b=bwWw10BgkC4CmK09LHJNVLuKC3c3nvUKtqhNeHCaaFFh02bXExGEgfOqFF++nwukDG
 n981uBkz/FRJu6pSn9eQDrmcttEOym0aoUhsyrbjBtMjB+hHUJYQR6/o70pr402Q1TBP
 tT3iunSWV9W9zEaDuFSOZwgB26SZ4+gIr5D9c9ki4Wp1JGnK/LgL4UDBkWeKRmQpDzpV
 +B0ggUVP4IMcu+J/HQe2/QTnMHltit+53QiQbs0ep4o77HmWa+O3k8uWSAeEnjzOdFJ9
 8G5X0/+bMDDD4HEOA2MfaegAuAt/lSjhmZRLkG6KZQi4HBMOir1fiVp+P5VMdtCHgQf3
 83kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802366; x=1742407166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7XqagNELDS/EVs+Mbn2eWBNhVZNxuTsEtgTZ1Gvirs=;
 b=UupHjXb6ES+vLT3P8IMlPps/fqaU8MifCZqSNUnUiMBRfKnSf0PLBd7BfKlNythBD+
 vcVrG3QWN/ogYkI4yBLT6VGXdDoDqACOZQLMSqRyMqoAD6h+gaS2d2Noue2FgSbxXXiJ
 i2R1xsgU3gcS1H/X4EwLAwDHe102u4uCHARsAUKd8R0xk/cejJKKhXhDkLqoIVNRsA9+
 Y1kuROFd2RLysWrqK6guHJs2kEFqmnI2w06RXtmT5thvUviBr/vvl6Ve9Db8k3poXAzK
 xhJI63WjC+Zitmo1bLWuutFLv4347rHmI5qn6UtM8V91BEbxpKaW8NrJgPx5Ncjtlsov
 b8QA==
X-Gm-Message-State: AOJu0YyhtlW5Dir96p/AxFdTadlZZ7pYm2R97GfeyG2ugqIddkvWo48N
 Q2sjQc00sNW7yaZ0GfaHEART4Z9QNlbdAYM5kAdzAzdaX9Sc7aB8
X-Gm-Gg: ASbGncunpW99vP6Y8ikRi2Xeyqp+WaGoYhPM6rimbSaziHG4ECg1nLdcO3YTsuMKoPs
 PC5ndfy2YZ0UJuZiBaRrMvckJCEJBMJh1NHZnp94AOk+4nPHpwfkAJlhvvsNIiyRUcHXe+yoLaj
 UCEYMrWKQ3o+GRcmqjfyqw26d58s4bA1t5CzWxHgLk5kkv6eajOnS0tjiXI/5hvs4xsJGnzWDJ8
 seBio0wWuPJ2GNBNjSNy9fe23ogULcDxEPPyuhHwRHq6JzjAWS3L5zfNeV1e22B2eK8wncBb+nY
 T0j5XUPfpMf7/auBJlP7NO8zccU6/WsdJ1MI
X-Google-Smtp-Source: AGHT+IEMj5UmvvVJx3h1dfvue73P7cefTEul868rZxqKgM5Zqa5qfKNa+GFBnFYzk3ad4Rb+I6nkdQ==
X-Received: by 2002:a17:907:3e27:b0:ac2:806e:bb55 with SMTP id
 a640c23a62f3a-ac2b9dea0e5mr1053193066b.19.1741802365812; 
 Wed, 12 Mar 2025 10:59:25 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:25 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 05/10] video: tegra20: dc: get DSI/HDMI clock parent if
 internal DSI/HDMI is used
Date: Wed, 12 Mar 2025 19:58:52 +0200
Message-ID: <20250312175857.120313-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
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

If device uses native Tegra DSI or HDMI, DC clock MUST use the same
parent as DSI/HDMI clock uses. Hence remove need in device tree
configuration and satisfy this condition by default.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 775043bb1fe..904d0d205f6 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -524,6 +524,13 @@ exit:
 		return ret;
 	}
 
+	priv->clk_parent = devm_clk_get(priv->bridge, "parent");
+	if (IS_ERR(priv->clk_parent)) {
+		log_debug("%s: Could not get DC clock parent from DSI/HDMI: %ld\n",
+			  __func__, PTR_ERR(priv->clk_parent));
+		return PTR_ERR(priv->clk_parent);
+	}
+
 	dc_plat = dev_get_plat(priv->bridge);
 
 	/* Fill the platform data for internal devices */
-- 
2.43.0

