Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD39E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9EB83CE3;
	Mon,  9 Feb 2026 19:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dDRhYBeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB4A83C91; Mon,  9 Feb 2026 19:12:06 +0100 (CET)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E2F805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x144.google.com with SMTP id
 2adb3069b0e04-59e4a04f054so2487803e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660723; x=1771265523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=so50/zwGYsURc9daEmRZdHSuQV9ytJK+cLvJnEyjU4s=;
 b=dDRhYBeGALQ5CJTuJhkIr65C3FiYV/vAQVwTALrhUld4duuOYz+0dlnts8ZQ4bCz6r
 wC6oq6UiUKEWZyLf+bBRrBho6kDQLHpP3NflzumlqgixE0s/wJm8H1VU9jGsUywBu8D2
 Qfeh2VJwImtHvnuGUhhSsp1lRXZW/0kiy/ANO6rfpOYp6iRmq5jDv5b22QNVCZFcZKFk
 iLOyHivgtXh0zmOI4E8NGdBoxnpEHjjFeDdryg6TLPnYyv/TiOkDd2I4AaxXf4Zd1jny
 A92SeAx8+nhzaZf2vkeQxaYjBBSH56L/NCtkZnfmblPCAKW0FNTnYKZtq3GqAIjOX4T4
 wa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660723; x=1771265523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=so50/zwGYsURc9daEmRZdHSuQV9ytJK+cLvJnEyjU4s=;
 b=l+lRumukcZ+XG9uzVpHOe1Onu+4wVWEbcKffoGKc3BSl/bROq4MrfHniwOlJtNc5pb
 hR8EPtvMosxYzkOLbcrzYkflIxatP+uMKvKH3kWgTQ8iG0OlPmG6kMOaR89AFfyE8G6C
 s99kp62R9wEaa//QzG9c2yxbmMgC6+zRcOoDENcY3LedtV8tXfNsM2YcE1jItH5LlZg/
 klljkEhoa4vgIfh0IcU/HTudC0a+GNkA7GEowJkQd39HvvCKZv/KbmlDtKRBqV27oC7P
 Qiy6GZhpQlgfrYdssCseaWMnz4oQBQ+970jU708KdP1WWhnVjoOd+caYH7z13ULQdaYn
 BgyQ==
X-Gm-Message-State: AOJu0YwAFkMLPvXqYG6I0ql0ZMQMQiv5FTNkBDbo3Wa6NLHxdXSOdv5z
 rwvTVZPG8uIFDyFjlq2TUPEl0EIzULCG/nfMoo18b2XOOJ1UQbVx57lK
X-Gm-Gg: AZuq6aKi6fcUR/zypFyIUG177CysVAfZi9caI9CVeCgnTKD7yNPYUzBUB/J+YafOvzF
 8HYTEjIJGTQde42DQhgGIqtxcecSM9GB7R/3MLGopRW+lFxwOPzUbu8z6jqZJh9Jrkk6hmVDfwT
 rr+x3fYcj0ICvx7PP8Kr8UPDA4JcNg16N5bhkQOHJPjrLR6AghJ34+yKRBXQaPj1YS54YAHfJyi
 U+l+K0QJxJ32wmh0cRjuXa5P68nIlWtruWlxWnvXFZfNQ+wHqByGCChwkhYhiw/E2E8F4jMJaIE
 swqCrLhipMTKH5/YMLQidHRQurMphroSUYT3SQ/0qL9kfzgRG+22QPMScSSpdy3o0IKYx9XTblZ
 ME4WiIgiYIx6fP38XbtpdrxACULdWFkaeRXh+gci9xty9nwfzI+irWEas/+WBu+JI20viunTeK9
 RWjsvlSkBkrrk=
X-Received: by 2002:a05:6512:3b91:b0:59e:249e:d5e4 with SMTP id
 2adb3069b0e04-59e4515cb49mr4445602e87.42.1770660723051; 
 Mon, 09 Feb 2026 10:12:03 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e25e4bsm2792801e87.88.2026.02.09.10.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:12:02 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/5] input: cpcap_pwrbutton: set default keycode fallback
Date: Mon,  9 Feb 2026 20:11:48 +0200
Message-ID: <20260209181149.32714-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209181149.32714-1-clamor95@gmail.com>
References: <20260209181149.32714-1-clamor95@gmail.com>
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

Set a default fallback value if no keycode is defined

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/cpcap_pwrbutton.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/cpcap_pwrbutton.c b/drivers/input/cpcap_pwrbutton.c
index c8ad39d33ca..c52c0481f67 100644
--- a/drivers/input/cpcap_pwrbutton.c
+++ b/drivers/input/cpcap_pwrbutton.c
@@ -87,9 +87,7 @@ static int cpcap_pwrbutton_of_to_plat(struct udevice *dev)
 	priv->bank = irq_desc / 16;
 	priv->id = irq_desc % 16;
 
-	ret = dev_read_u32(dev, "linux,code", &priv->keycode);
-	if (ret)
-		return ret;
+	priv->keycode = dev_read_u32_default(dev, "linux,code", KEY_POWER);
 
 	priv->old_state = false;
 	priv->skip = false;
-- 
2.51.0

