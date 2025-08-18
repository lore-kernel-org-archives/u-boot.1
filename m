Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A77CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C806801DD;
	Mon, 18 Aug 2025 12:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cUaQrS2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC6D82BCD; Mon, 18 Aug 2025 12:44:34 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AC78211F
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45a1b00e4a1so26091495e9.0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513871; x=1756118671; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MYkTfxUaNShseXoYhFDZefL1wRCTEwkg8adkAlfhu/4=;
 b=cUaQrS2rPgIqFewai+iZkRs9m6Z4Q3UwKTUZveDbIaT0zo7yDTZEQBzlPi8cwq6G6P
 0APIZ3BZQ7Ra+0M2ALxkYmf4qIDPPnnFY/wECkQUlKUPQcw+lv+6VheANZ2XXZyvTtqb
 iZtPWxV4Z+LtcVgdXui84nvqI1ZhfyDHv7qa3X3PkEuhkLmfzSm4QFT0BTZaVw9KX/Br
 PE/w/JGaeukbAof78WWka4C1zDj3OIBwwJOYaLLRLN9yh/Jfh/k3RiL5Wt7RVIa77qCM
 BFF3PSKLwbn9b5D70q6Vv2721HCbbHkhEi1yxJS6XmWfz0gc9ifpX0BxXre4oUAhp/Ov
 hVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513871; x=1756118671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYkTfxUaNShseXoYhFDZefL1wRCTEwkg8adkAlfhu/4=;
 b=kiMglgOjFi1fedXcoHCgZIBEOa5TZTm/qtJQQt04hl0Z6LttNZ1HHuYDRAZQkRW/F4
 HYcfd+hZ1lZgxp0zHRbKO07nOrMDsmbfnYdcW1oaFmNxVy2vy72odXzdHbdyLuOxwRy3
 dvqP7X8ZqKIoCd2uzRhwJWM7fc39ggth1TKX5UY/a6TadPOV9vJuFJLdGXbhrCYw7Q0x
 dUnFl3rU9rStE/O6lquWosByfcnY96wlxwHSvZfYfn+YfuZYUHjddWxEhO+UhOACPz4y
 B34GqKjmrvtCWxvX+i9EtKKD2qiaWgMD2cbnFBncavBVxneTzoSSoFXihFpYG4hi5p4F
 eFng==
X-Gm-Message-State: AOJu0Yz+I7ElY2qtO0ZMTrk/qe0kh/3P26FQLrtQc2qPFFqn6KZMCPa4
 +vv1FzChIDI+UatlwspR+BHMLFOTSeXKfU22tMqKqazowQ7KsO3GD0QGKEzJyyjbBVWUzLavM/u
 sbeQF
X-Gm-Gg: ASbGnctg5F+9PV5Wrz5Tv01ocx+LnxALwaIYG+wBfPpg5foZ/cI9K0w+qQ8m1XZ4MEN
 BRHjPnt+S8y9JRLD2rzvBHmRzXv5WMmhWWG/MXmuIqjAsKv6jh2GFaQuQiWzAsdnvJXMAdUgk+0
 BBB8EnVyt4kSUp4TEEJu+k+i1hXTFikpznK4WB/REmYbl3uLoERyfG8V1bmomiJYbDFqsfwSPzi
 emOZTyCGgOV4HDMawgkPdd79va9i0TZOn2d/yHdV5r6WjFqcbufgtkDEBmlTHPRXs6SOdyXrsb2
 yqqkjRSpPcryMg8Wj0dXVVaco58WTyOeR1w7goFYg2WhRu5Ubb4gILTkohPJGiAmn84GR4zpERy
 7rOM+B1WqrvuJmeIJavCXOrzZpidoWid41JIqi1qXDcphy0tySME=
X-Google-Smtp-Source: AGHT+IE3Lk/N0QfVy3riWjZPufDpe8HPHJZgdQRu9SrFpyx7vmycZgyg1OhhlmVuiH8T9FpW3rR1cA==
X-Received: by 2002:a05:600c:19d3:b0:458:b01c:8f with SMTP id
 5b1f17b1804b1-45a217fd389mr75755505e9.8.1755513870580; 
 Mon, 18 Aug 2025 03:44:30 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:69b5:38a0:910b:c9c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb652f75aesm12293643f8f.23.2025.08.18.03.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 03:44:30 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 18 Aug 2025 11:44:29 +0100
Subject: [PATCH v2 2/2] phy: cadence: torrent: Set an error code for return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-phy-cadence-sierra-v2-2-f2d309b170e2@linaro.org>
References: <20250806-phy-cadence-sierra-v2-0-f2d309b170e2@linaro.org>
In-Reply-To: <20250806-phy-cadence-sierra-v2-0-f2d309b170e2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In cdns_torrent_phy_probe the test for too many lanes configured does
not set an error code before taking the error path. This could lead to a
silent failure if the calling code does not detect the error. Add the
code to return -EINVAL in this case.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 1f566d082f9..28fe026223c 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -719,6 +719,7 @@ static int cdns_torrent_phy_probe(struct udevice *dev)
 
 	if (total_num_lanes > MAX_NUM_LANES) {
 		dev_err(dev, "Invalid lane configuration\n");
+		ret = -EINVAL;
 		goto put_lnk_rst;
 	}
 

-- 
2.39.5

