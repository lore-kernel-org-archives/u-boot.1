Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5497C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 20:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A2F81101;
	Wed, 26 Feb 2025 21:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IobPXmJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C60EA8081A; Wed, 26 Feb 2025 21:31:20 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA11D80FDE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 21:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-471f2e1bea9so1950711cf.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740601877; x=1741206677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iWLYgf0U92OCvEcTjVEnKkqrtjiK3DITvMIeIwFJsj4=;
 b=IobPXmJrQ2Av6c5mjKiipX/g1EaqZ3XrWZE8S4gSCIB/auqMsAMt5cdbFT80BkQ7oC
 XQfuiEnWzzqw86eOta+B7CvjS/jOuvy6VuNBfjbJoXHvPQ1YFps8TvccsC2WQrBu3D1m
 Y12W1nuxJLnuGxbHAOuW1EyNSfzLJZeo+79Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740601877; x=1741206677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iWLYgf0U92OCvEcTjVEnKkqrtjiK3DITvMIeIwFJsj4=;
 b=R7kfwcF3+EnIzstSrhQV9fz3SqAlaWSRH0kZA2FRSy8FRTwXIvdbEUdkEWRuwlBiCV
 1JQ81c3jUI74bkKH412sy5RIXalMHrxac9Bit4661MNeanwsdvpxWD0grFe0EvvHIOKW
 svPW6aOtdxvNv4vfiQ+hUjEjSf83++BBGR/hMtbeUcpA3UgY5P6WH+wsXWYLilnj21a9
 iM3J5MRmRacFV6dEEnwyUr3RH5CdOq3TS5GipBo8OzMuVJeWeZQ/Hcbj+Kh5tT/wMjAw
 EuDRRra0FWBtlkepjeU3bxbSq0yfvJdJzyVL4IWXs/UXEWK7K3ApTEcjMdh32R20bj4P
 tzow==
X-Gm-Message-State: AOJu0Yxnz/Q93b3TBxwJxJu/Htzcc15zy1KqhbVWbB+meNLvOz1nT6H6
 rut1Vwbg8DqDldx+jF1UFQEi74WzjQZ3o6uK0GcG57Niwc3EhqXd/wHHa/IAVdq0GXxpr+QABoa
 G
X-Gm-Gg: ASbGnctdrVk4rAa3nT64jr+ZjhSUdRx8Sk7bNYvXHiADlzcWFkXeZXjroadD/n+kWFt
 Ojvbb7j8YDnVzP27P+NP6OyLrXze5SZdMZyYmdr1qhweUrV5hCiGyLyECB38Y4RQllg6PL67Yd9
 w46gl5Dw+ULZwcNzAs7G/IfStINC4eY6SDUAHNO8rgVRCdyUjOMzRp2QJw3sz0eCoTt7BN2Jp67
 cvpozdwB46opr9osFnazEWAIQMeDXmYdXHvGzZNIhNpI5IZiSReLwXwYy/c5Tqg9az/q0JJBY1i
 /htufjC12D2U9IZeznCcTESRMxc=
X-Google-Smtp-Source: AGHT+IHghZyS1gVkJhk6QiKMTfNdrD7vPqZN3tkRukBjOemvpsGhzSn8jXk46M68sgozzgQVnGPUIg==
X-Received: by 2002:a05:622a:64f:b0:472:744:e26d with SMTP id
 d75a77b69052e-4738136c5a9mr68186021cf.39.1740601877559; 
 Wed, 26 Feb 2025 12:31:17 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-474721bf100sm470571cf.33.2025.02.26.12.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 12:31:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] x86: apl: Correct usage of IS_ENABLED() macro in
 acpi-pmc-uclass.c
Date: Wed, 26 Feb 2025 14:31:15 -0600
Message-ID: <20250226203115.3831923-1-trini@konsulko.com>
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

This file was using IS_ENABLED() to test for CONFIG flags but omitted
the CONFIG_ prefix and so did not work as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 drivers/power/acpi_pmc/acpi-pmc-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/acpi_pmc/acpi-pmc-uclass.c b/drivers/power/acpi_pmc/acpi-pmc-uclass.c
index 1e94104091ea..40488402c320 100644
--- a/drivers/power/acpi_pmc/acpi-pmc-uclass.c
+++ b/drivers/power/acpi_pmc/acpi-pmc-uclass.c
@@ -141,7 +141,7 @@ int pmc_prev_sleep_state(struct udevice *dev)
 	if (upriv->pm1_sts & WAK_STS) {
 		switch (acpi_sleep_from_pm1(upriv->pm1_cnt)) {
 		case ACPI_S3:
-			if (IS_ENABLED(HAVE_ACPI_RESUME))
+			if (IS_ENABLED(CONFIG_HAVE_ACPI_RESUME))
 				prev_sleep_state = ACPI_S3;
 			break;
 		case ACPI_S5:
-- 
2.43.0

