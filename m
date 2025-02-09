Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC531C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80EFA808AF;
	Sun,  9 Feb 2025 16:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fl6wHxj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51579808AF; Sun,  9 Feb 2025 16:23:48 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD9A807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F5033FE78
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739114625;
 bh=4sWTzOqh3nVgbXeDvlr1OvUNu9UR1J0cPptuPnjzkAw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fl6wHxj728lVplcAbLhq5JyTPbZQqPnBo6Zwav1TSbd68LQUjKAjjKWCMUl6EeRrN
 hfmBuTxc7/cqUgbrIort+B++7TUj0YyOAp1CJvhj79bbuIjfLXfu+BmPLl7gn/t3gg
 RpYZxcIVpQE4uXmYHH0F91NZHCDSPn7J9v48uzCIZXpy5FWEsOt6Q8qu4UxTAmgMcn
 cBwTxuNQL6aJTVT1l5Dbwo5XWx77eRn4hS3pHfqN0PKrmSkADWOhrqI/2UXl0JTKij
 enaOaRqtFow5V/Tzi9WK8AVUZZnBJiRka6nvOothi2BFy9Pvu3GtgZPq+VrYjTpPke
 7tn1xCIwa+zaQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43933b8d9b1so5416715e9.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739114622; x=1739719422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sWTzOqh3nVgbXeDvlr1OvUNu9UR1J0cPptuPnjzkAw=;
 b=ptGAwZx3nxdcuLffv03V83IuogKu85k8hAe1rzwfcQevfcvy4wbUkNmT/eRo4S1Cyo
 AuBKcyrQGd+dpgQiZrEgvCznir0Yfc0ge0qg0cr0oXDCUnmZGaA6KC4GA7r+u294Zg70
 9qwVahrsi8IOzC54c0gvPX2Ojv6R7A9Fcgmf4MPMTKhR+t5tZbOnMJC1Xznho/9Wp0Ok
 32UsaIWXtEQzOWFvFx5QzBoM0+0dQ+41lFKz58oGEncbmIT+vfVOEs7a8VuotPY/flc7
 Xa9x52Dxjyx1JQV7KDEMsHojCVI8PIuMjRbjVGHokll8C3jPWsZF+YsAVDmjFRcPmX99
 t43g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4AnKSV9N0uUyfBcjrDHGsZHgY93Wan7YjqTd6p6dhldOgzWqG3I0/Dg+xbVx43XGhEVNq2d8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9xS9xthFeXWXpvWuW4h3C0TsQR0ahiRENoxQa6qhDLyBiacvq
 YJONJUDXwDzfUiBTAzXE2yZkRpffzSeiwERA4Pmo6DsODu61LmNI0hwZE8sscEVgoN9HZpK7qyE
 THmLSJ5JCNVHH+i+my3I8TN2j3gWq+6Czx9QEGgNIhCGB3PmU3XVvEWF6urDXupoHSRA=
X-Gm-Gg: ASbGncuQr5QoysxXLiRfC65+VOluFd928ViIBsmEjYgntVE/Xlx3C9Kn3qaRH7LvRYa
 pJ65H6ksR8OclsQr/WV3jINxppRmGZBTIQrqPjamPFEM6Hd0Wtqn+u2VnAGjVfLkal61AEqcgoe
 rjTuYw7JZK4ZoLwi1wqi15JX/YKVs+ly8zs1CbPn4W6dQGNTi14LE1Q+JR2L/mUIspG29WmfFNI
 usRgYMRCAigde0nllWiDfMP809y3f3eZI/yxj/1HPzZqYX7FCAcFIIWvSiAiw8UNLAYhKR0haEY
 kJADCuu247QhlixaO8+ZCQ1JPSc44Ep2wPKPL0JIka/eq5J8wKGbtns6PIRn2vuOsaeZitlOrkd
 GVaKyAjw=
X-Received: by 2002:a05:6000:402b:b0:386:3328:6106 with SMTP id
 ffacd0b85a97d-38dc9374026mr7387600f8f.35.1739114622565; 
 Sun, 09 Feb 2025 07:23:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIdEQQXITtiAnJ8yaWfYJBI4ieua8k6jhm/cy2LpAEyHmlUxoNpbf+doHHCeKkcA46yKd4Ww==
X-Received: by 2002:a05:6000:402b:b0:386:3328:6106 with SMTP id
 ffacd0b85a97d-38dc9374026mr7387585f8f.35.1739114622254; 
 Sun, 09 Feb 2025 07:23:42 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd016496esm5912663f8f.19.2025.02.09.07.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 07:23:41 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, "E . Shattow" <lucent@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] configs: starfive: default to
 jh7110-starfive-visionfive-2-v1.3b
Date: Sun,  9 Feb 2025 16:23:29 +0100
Message-ID: <20250209152329.187194-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
References: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
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

We use starfive_visionfive2_defconfig to generate a FIT image supporting
all JH7110 boards in U-Boot. Make jh7110-starfive-visionfive-2-v1.3b the
default configuration that is used if no other configuration fits.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index c3f2142ae1b..ed077886436 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -78,7 +78,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
-CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.47.1

