Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981CACCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 10:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121E58004F;
	Tue,  4 Nov 2025 11:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="mO9Oxg9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A604C836D1; Tue,  4 Nov 2025 11:40:42 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8418004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 11:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b71397df721so319001866b.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1762252840; x=1762857640; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tbwyjr5+klPSlLdqdSdojS3p+J/SYIOj+3c8ayt9HVg=;
 b=mO9Oxg9kqTD/o08yEXM8C9pIpp6uErJnBPgF1VxrUqLiW/AwmwthqliE/gswz7VowC
 1vs517hndv18Y4fKMp5ConLQ4LOcwojnCpJVxaYgUh2s3ZI1HjzSvx2KZttczj9gEymG
 1IJcA1XTESENI0lkMyMJX8nVYf45VWdFaQCbou1hEJprL96VzbSQ/cOMSzOVS8qLSBQe
 UC5RDVnRNsj9nsphJaXPEiGokHlSrL3/dGuTC/vqta/8EfI3uzc0RrQdTI87wsRtudqV
 noaczsE1VdR/ssQUzIGbnjJQTvaqaMF+WUYe3O2N2JS2BC5zWuYT8wqXaBrJqLnFFSxh
 jFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762252840; x=1762857640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tbwyjr5+klPSlLdqdSdojS3p+J/SYIOj+3c8ayt9HVg=;
 b=Nr5ELnZQN8agOB6Wx4z8Z+uVzNiy1puyQdSxX6LV/9SmzYkyeoFd2gr+8SgPvxTS5K
 u7gQjQzxrpkYVDodpuEt0aXbPqcH4w5alD36ezGAoRKYrgzWug9ceY/GSS9UoHorb3DM
 apPFZysp1QKrYOvWAkNhF138vAU92cbenn0Kx6IH4hH+L4cHyv3kt+yQHMhAavb39Byv
 Gjcw6/xLUh0n6L9bwkjq0IjTFXikqQ+Om1+5HrdNSPeReS+VjC8W7eHCMyXcyiP8ED96
 PK2YJSQlPYGPONfXfPdkRc+Kxu7ckm/865hBAQ/zGCHyTZKp2Xjd1YnFV7HoT3fl/mnS
 rWog==
X-Gm-Message-State: AOJu0YxprM+ZI1rYiwE2+LKJQK1UridtRTPN2q4YrGAeltYirZ10e3Ni
 v+Ezg+HX9cRHkAdfyIEFWWCihyeyFjOMUGYsTwNEWB5qBYA0kPeP0lbuOnZmzw==
X-Gm-Gg: ASbGncsEJkGYCgUV5YB1kfBEM3HjVA1L7xxsLfQI39nE9k6nQ7KplQauW3h5vJ/CUC9
 3ri9dgLJompbJuk/fw0lBK2Obfm67RtxzmVoZsj2KCeFD4a+tVa7t9ZLjGkZ9wgxE4E6kSKwasS
 WpzI6LBeTUAJfGK09KuaGxeZOqPH8cI82wRiqN0z0PJ20jhJfVeYfnn2N4+ZSXpdwMfKiJw5Kxv
 ocIvW4Umn+w52gB1BN7iZnl/ABrAZLqvcOWh7qpKNDOOblbDdao8iz1XB8JV27FnSpz3V72UvOP
 48oLyOhcdO+mqNPI6AFcileZR39yuA2yJkQANpCE6JV14ppxxLP5EhUiZd/3qE4tfhV+2vAXg71
 zd9sJAsfHuyKmU4Kf3dOVFDTVo/nHxBdmucAO00BgWgmv2F0vxAO1t8ezyqm4yuEJiMWv8mK0wm
 5l7ouJByUSONFgSUb+USogeP3ldf0O4QVACBOLXjbraCpx2ogXx7v2PLPg
X-Google-Smtp-Source: AGHT+IHuDuXm35BRnz6NrAsDSaDMB4Xdz2961Jcww++bH3ZwJiSiD6YVZsCfV48xnXr2y8mx6PIExg==
X-Received: by 2002:a17:906:354a:b0:b6d:4fe5:ead0 with SMTP id
 a640c23a62f3a-b70700b561amr1237038966b.10.1762252839387; 
 Tue, 04 Nov 2025 02:40:39 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e680578esm1717199a12.10.2025.11.04.02.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 02:40:38 -0800 (PST)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] gpio: OMAP: add dependency to TI_SYSC
Date: Tue,  4 Nov 2025 11:40:28 +0100
Message-Id: <20251104104028.3813594-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

OMAP GPIO driver needs TI_SYSC to initialize its clocks when
using a devicetree-based setup.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index db077e472a8..b5729a39774 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -340,6 +340,7 @@ config NPCM_SGPIO
 config OMAP_GPIO
 	bool "TI OMAP GPIO driver"
 	depends on ARCH_OMAP2PLUS
+	select TI_SYSC if OF_CONTROL
 	default y
 	help
 	  Support GPIO controllers on the TI OMAP3/4/5 and related (such as
-- 
2.34.1

