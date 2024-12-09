Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B487E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5ACB89717;
	Mon,  9 Dec 2024 17:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LZVcLSLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF6D89723; Mon,  9 Dec 2024 17:15:05 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC7A896DE
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30039432861so28549851fa.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733760903; x=1734365703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gj/IJsiaweRPR4vj8hV8g8ZMhf8jYJbIPxMrKoYwCkw=;
 b=LZVcLSLsQflPQ2gvL0KzmlIB/B4c7luHMri78+6zKkT0UyeA3FKHs2wfChaJJxEcMs
 oBPLuJQNuhhXBo6rcXQIn2K5Fivc9NkaXCjvVo4mAzLIpEJHVKGsXGgzo90RDtCEfHQK
 zzFgwT8K3mhW6z6lk1RrPED4MsZs0yM507ACQXs1TV/Pt03VY4XLPcxFP5tYyZGegmZx
 yxaWCk+8aDySynFL83C+BdEfiE447xxVoTfV+Sa0972v33nOuD1cZVPmGik77XT6C6RZ
 GBVEfwk5IURpciyANxauaLhswNLu6KQ1IRoc+DhOsf8mGiwKEIGnlBMcR5bgHQiN3dwB
 58qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760903; x=1734365703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gj/IJsiaweRPR4vj8hV8g8ZMhf8jYJbIPxMrKoYwCkw=;
 b=lLTFoeqoHtn60XC0zYvZerQfchb+1RFOHO/yy33XS0WTZyd7KLvILtaNWzUN/xV8lY
 x38ABRSDpla8VWp0zfiJV/3tX17//WEn7Bnxxkl7AjVpGdlM/dwqeZNnYUhOqJluHU7r
 BqI6jkRy1WxUxNbQlgnbTtwIg4jcHqoIeKKkMIWRwDBeyIGvLKRBq59HCXz6q1BGANsI
 U+dvGhDHIbdjS4TQp3Xbc6SFA30NOFpuOSaPoB6E2R+zUOSwMS91Og7GTP3kTJ/0uqU7
 h7DU7x+UWxgSX0FgK+LoFdwRvDW1SFYOsaZWEPgy5/++xvW7RH+9LNAttBilkAurkma3
 5beA==
X-Gm-Message-State: AOJu0YykeXb0mES0s2sQUHySwQoKAPvNaZi7BtrrQUKZ8p6dhbEzERht
 NT6tAL5wdlCKteqiCszL/uhOoYi9X5nn0OnEcT4TcefSr9XHGHnF
X-Gm-Gg: ASbGncsWrNqGPF8d+MVb6MFoCrdGFHYVxi/3g03ZISBRZ2QjFGjKssN6QWvjpdXdDmn
 TzljZZQEOV0Xz8Z52QbaqRTzcJhRO0psb3UZS+vQ39tim4hN56dAut/YrqJZbJlQePCbHEMqG9h
 yfTH/se/TTutHYCXfp/lpBJAZ44qJG7JGVwC6HNWMOZo1U4Ee7IQanuamlkXHQL6g/Q14K5j70R
 R4u37NCvc7ZJg2VJUYjnUcSCJXQOpLMP/qBtzjchQ==
X-Google-Smtp-Source: AGHT+IHOlhS7C9vW/ncTL110w1GypyISGDVt4TbTKpjSK7by+oqMMLJk7aslkYiMOx/U+wAVj6XCRw==
X-Received: by 2002:a2e:ab05:0:b0:300:4362:40 with SMTP id
 38308e7fff4ca-3022ff7f932mr3924831fa.36.1733760902786; 
 Mon, 09 Dec 2024 08:15:02 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3021a02d90bsm5940971fa.80.2024.12.09.08.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:15:02 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, Heiko Schocher <hs@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] pmic: palmas: bind sysreset to parent node
Date: Mon,  9 Dec 2024 18:14:34 +0200
Message-ID: <20241209161434.6563-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209161434.6563-1-clamor95@gmail.com>
References: <20241209161434.6563-1-clamor95@gmail.com>
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

Bind SYSRESET child to parent node since it does not have
its own node in the device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/palmas.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index f676bf64169..37d4190fabe 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -49,8 +49,9 @@ static int palmas_bind(struct udevice *dev)
 	int children, ret;
 
 	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
-		ret = device_bind_driver(dev, PALMAS_RST_DRIVER,
-					 "sysreset", NULL);
+		ret = device_bind_driver_to_node(dev, PALMAS_RST_DRIVER,
+						 "sysreset", dev_ofnode(dev),
+						 NULL);
 		if (ret) {
 			log_err("cannot bind SYSRESET (ret = %d)\n", ret);
 			return ret;
-- 
2.43.0

