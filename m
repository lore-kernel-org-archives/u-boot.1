Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A40E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D8CB89642;
	Fri,  6 Dec 2024 16:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E/HxdTA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0FD489642; Fri,  6 Dec 2024 16:41:19 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE011895D7
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ff976ab0edso23373081fa.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733499677; x=1734104477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2a6X1TVqewReoc0huebClVn5ckJ5pfypsYVurLtXasY=;
 b=E/HxdTA9Pr3/cK+Xk7YM964MCLkxR7ZVNt1NPIHG/8m2rMVmXF/ZK5DZMznLUtmhri
 xRSJgWvs7hr82LhqUOTxloFMBa76B2gxPJwx60PaCH8LLy5EOnhUH8yivPASMNd8WaT7
 LrLWIyiIj2aN5VxrEZ0hJ+boqWWQQ8mRmYXjAyOSiZjX7VSStKrV19AYoRsD9zz/9lkR
 uuC7MusTe094dsjTpbOK0T2o5xylH9L4Ghvogc/dJ9ozztFsVui92ebfvYYIHltdeAgp
 4aMcBgSIXe5c3fXlkv+ZqVsT8RT6o7qkchSLZ6wQdbH0DUpE5uGduSRhp7Xlf/mbaa2n
 YuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499677; x=1734104477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2a6X1TVqewReoc0huebClVn5ckJ5pfypsYVurLtXasY=;
 b=aDb1ALjhjN56eC/UzhMuLskB3q8Kaxfo67lm//oTj8HYauFFNcDK6DAbiVg7kaMdco
 cOP4VtkQQ97t3pAfb4nlxMvh++5w/ttweiNZ5so4Zu0wupss4nnLNbWEdISZlIXPNbjq
 G6W38pO6+UTLHtjsoKRlCqJ4Ee2PuxdI9Sm/OywjzIwLlKGI9mS0sNs989AwNVoWgLEy
 yji4NpdVG/FwoDKWtAhaCNNZhx4EKIWZ50fOo4jUlY/LYRuuQI980tYbE9wRk2Zs0h4w
 A/55HzpQAPXCNMS/SlioxgiiWY7K2n9AugHwL3VPo+MlvzD/QkKEzbVb/phGHu7FLdlS
 UlnQ==
X-Gm-Message-State: AOJu0Yw1KqhhfKn/q1dYL8r3071sJkgJPJdWACdv/1FmdD8jjkQiAY0f
 sWDnLLNHAzF1WhxyxaMNgvhmSQgrt3PMWy4gN90ltSzfhya0ANm7p2x8TA==
X-Gm-Gg: ASbGncuofvfCgZVm86vggRDI4LIRs52iPta5SPOSZ9RFzb7s1HSIhYl0A/AJqfsh2Kw
 Z1Pxkgechtc16F3CMaFPf/ep/ktoYaLWzGlm6R7GHYLHn1WGQeTiC+NBHKQvLCSWp5FFUorDFtA
 efB3F8AxVNAmFvbJRpQs5DoeCJVHbHpPIxmEjnzjq9ko/V8Lo7usx+JhSNXVixxZLLossUBBSQW
 LcasAdBW3qpgtS5b5koNzi4iaTAx+8yTIQFog4+
X-Google-Smtp-Source: AGHT+IF3hZsObuyT+xhec7E4Fsgfw4FtdKmqZcscpqSAntFNunXKenWoR3vtE3jgd+UMVB6AmSf7hw==
X-Received: by 2002:a05:6512:31d2:b0:53e:23a3:e44d with SMTP id
 2adb3069b0e04-53e2c2b0d6bmr1760794e87.2.1733499676943; 
 Fri, 06 Dec 2024 07:41:16 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e34a49561sm154154e87.83.2024.12.06.07.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 07:41:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Ye Li <ye.li@nxp.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] GPIO: improve and fix pmic gpios behavior
Date: Fri,  6 Dec 2024 17:40:48 +0200
Message-ID: <20241206154050.48353-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

First patch makes support of PMIC GPIO children with no dedicated
GPIO node simpler (just add select PMIC_GPIO to PMIC GPIO driver)

Second fixes getting device if correct one was found among PMIC
children.

Svyatoslav Ryhel (2):
  gpio: add PMIC_GPIO Kconfig option
  gpio: fix request of PMIC GPIO child

 drivers/gpio/Kconfig       |  8 ++++++++
 drivers/gpio/gpio-uclass.c | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.0

