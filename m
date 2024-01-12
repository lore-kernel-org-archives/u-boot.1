Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9A7C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECDB87985;
	Fri, 12 Jan 2024 09:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WtLOcxLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B3387142; Fri, 12 Jan 2024 09:40:53 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A194C87933
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3367a304091so5242961f8f.3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705048851; x=1705653651;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dTXHfn/OGUFSqYJ372dxx9bXc5nhRyKWMWhwaHtav2g=;
 b=WtLOcxLAAVUcCopgYQdBeiZspxMZ1bhNZWzk6DqyFnqp3LoTa2K6Vpd3tJYa4JefmT
 kk8XyTxE37yhmw3hrF0aiVT/ECYhbCZEQkr5lMZPcbtnQNwkf33A8BtjvpmoOnr4cL4c
 Lr8UxzacLJQE6y0a3XVL/wDE1tvMP6ZXjUooNJ7YCKK8jHzyoanoMkj+Y+bSGS1Xbp1C
 sbBlyCyJPJbIyTzHAoogtMOSm12mn0O89c1zFlWg/dU7OivcQVZurlaqLvbcBP73oXT4
 7pUpMaJdvZ15YK9rePl5Ajn++vtLjuuow3JVB9ZRAD00uZ05p1X28FAXGB0IW88yGpV0
 ojdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705048851; x=1705653651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTXHfn/OGUFSqYJ372dxx9bXc5nhRyKWMWhwaHtav2g=;
 b=Qy/V/O6NZj5GsnkIprWjuVdVNqDmqpED0o7YOVtLkqniAYSdKj1+cBj6pWAY99tAhA
 bIQppRLlY+G6IONy1PzcnYJdFvJg8ApmNbM3BUrlXPExntE20FAqooSP1BjvIme8N6+m
 X8SIaDSspmrUk4yWusF2x9thPEZ5nzzDKAJyRsPuQZRSqG4frtnQcLtHZshqo/6Sv6yp
 1V+jzOMd5NwXKmQA5D+NgYTromo+8bxJ5QTM6cMAv+1RX8M5uDxc4WCxlWtiTwGttufR
 Wi9vV5SSwqaR04KuxxGCaN9E3rCjBNky3tEmr6EcghRFbu1jyQqK1P+uUmc/Bt692qeG
 OS5w==
X-Gm-Message-State: AOJu0YyS58bAZoCWWTs3bn0v7khyCwiGrprH4C0wOhUj1tSV42qA8r6q
 PH6BkFXTnDukJ0Vcul3ni68mDSp3O2DzUw==
X-Google-Smtp-Source: AGHT+IGCFw4ZVDsvLxC+qMGnpth5WjLPiqDIzk+l0BX2NFpu+rLm8gdGmNruxXPW0gL7J6uewatRkA==
X-Received: by 2002:a5d:640d:0:b0:337:5d0:1f1a with SMTP id
 z13-20020a5d640d000000b0033705d01f1amr342653wru.66.1705048851201; 
 Fri, 12 Jan 2024 00:40:51 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b003365fc41bcasm3202118wrq.51.2024.01.12.00.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 00:40:50 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 12 Jan 2024 09:40:44 +0100
Subject: [PATCH 1/2] MAINTAINERS: add Mattijs for Android AB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-maintainers-ab-v1-1-f2a538eab18a@baylibre.com>
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
In-Reply-To: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

Igor has not been active for quite some time on lore:
https://lore.kernel.org/all/?q=igor.opaniuk@gmail.com

I'm interested in helping with maintaining the android_ab
command. I'm a long time android/aosp developer and my daily job is
still doing android work.

Add myself as maintainer for Android AB.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fec063a242f..3c73d8c35c4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -59,6 +59,7 @@ F:	lib/acpi/
 
 ANDROID AB
 M:	Igor Opaniuk <igor.opaniuk@gmail.com>
+M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
 F:	boot/android_ab.c

-- 
2.43.0

