Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D84C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 08:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B48887190;
	Tue, 24 Oct 2023 10:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ap9tkigJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E503C8717B; Tue, 24 Oct 2023 10:38:32 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DA68719C
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 10:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507d1cc0538so6115628e87.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698136708; x=1698741508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hlezG6pgsVMoYl1g8AZSnMYNq3285HvAkJvVs3zik4=;
 b=ap9tkigJx2VU3mM6BLFZL0IBqFhhOjUEyjlMI0725KMTc3j9YeALNqIXA7/pPHXca0
 nOzyQdkW89CnjjRxZaj0B6/JgHZTxTaDbYQmovzF1g+fTEcqdehLQEBY33r2rkZdnsaL
 5zRY4CDg29FEs+Zvdx+lYpnniZ0AWu6yNnvq6jPDzTBbZOZT8hwluj8gyguz9iSY90is
 R6c81Ofa5HoAs+LufXuNBKoK221wRi/z4xaALaykCipHJ9cH8wAiyRfP9AHbEHNnpM2A
 fu/3BHJZdD2cEHZ9KZlTtExMEIzB97Xs2/3+3RLNYPfvipQCVXHV4BLYoO1gDDtpr0xo
 Ib3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136708; x=1698741508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hlezG6pgsVMoYl1g8AZSnMYNq3285HvAkJvVs3zik4=;
 b=J+p3ip5+WMvxXcEF8CJHtF02PNh4sbVqe5WVuAOlirOmRldvdgZ4eqlo+E9+MVgn1D
 cUB3G5Lx3ReB8747qc0bDbTY1wcsb1T8JRQg6SYlRRlBEL2SJ4zW0MblOJISYwpWnzkt
 8EwnChMfMDLhQ8ydgOLD3ELCHBXXc82jc2DMFFDVHH3Hzl+SiB7rnM/zCCMG4LM5wXoZ
 9T7xsT/MuCD6+KrrXyEJGN9wMDhF0ILTsX0dpktF5cLMLtKZZcN/eOVaFDh4JEoSYP3o
 K8iw5RWunogLUitSikriTM9u5YasVdM4f+Ko92mcwdOtFs1S5cI+DY87dd/AGmmD+xa9
 zsGw==
X-Gm-Message-State: AOJu0YxrXZHszFT15UyiwDtwF41chkZ9dh0BFVoCjTZmUJhqTtvyOYQx
 lpmILZeo3VE0f2zg6EpUrMw=
X-Google-Smtp-Source: AGHT+IHkfjBK9lp7Zy/UcqeerGz9gGEw9m/kwqkNDv+uUZIDjaJ4rwfbf7/F+rIG5oXCBquStrsOSA==
X-Received: by 2002:a19:504c:0:b0:504:7e90:e05b with SMTP id
 z12-20020a19504c000000b005047e90e05bmr8135692lfj.14.1698136707727; 
 Tue, 24 Oct 2023 01:38:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 z10-20020a19650a000000b004faa2de9877sm2063304lfb.286.2023.10.24.01.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 01:38:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] drivers: gpio-uclass: support PMIC GPIO children
Date: Tue, 24 Oct 2023 11:37:59 +0300
Message-Id: <20231024083801.202365-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024083801.202365-1-clamor95@gmail.com>
References: <20231024083801.202365-1-clamor95@gmail.com>
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

UCLASS_PMIC may have GPIO children without exposed fdt node,
in this case if requesting fails, check if uclass is PMIC.
If so, iterate through its children to find correct device.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/gpio-uclass.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 7aece85a70..a3fc470a5d 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1143,9 +1143,22 @@ static int gpio_request_tail(int ret, const char *nodename,
 		ret = uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
 						  &desc->dev);
 		if (ret) {
-			debug("%s: uclass_get_device_by_ofnode failed\n",
-			      __func__);
-			goto err;
+			struct udevice *pmic;
+			ret = uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
+							  &pmic);
+			if (ret) {
+				log_err("PMIC device get failed, err %d\n", ret);
+				goto err;
+			}
+
+			device_foreach_child(desc->dev, pmic) {
+				if (device_get_uclass_id(desc->dev) == UCLASS_GPIO)
+					break;
+			}
+
+			/* if loop exits without GPIO device return error */
+			if (device_get_uclass_id(desc->dev) != UCLASS_GPIO)
+				goto err;
 		}
 	}
 	ret = gpio_find_and_xlate(desc, args);
-- 
2.39.2

