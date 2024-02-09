Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4DEC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 15:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E79887E71;
	Fri,  9 Feb 2024 16:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yACOUp3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653CD87E73; Fri,  9 Feb 2024 16:14:02 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D18B87E70
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 16:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41068e36cbbso5962765e9.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707491640; x=1708096440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BWBNxHUfGbI+smyjEUcYQObYXQXZctao+uvqQ5DzYL0=;
 b=yACOUp3MSstehqOM+mRhhrxUgjgtAs/F2Au72rrMpHC7bTSILbhm1/W3nc86Y08o+M
 rTtQtaZdp2Lri/FdXB7jzawjeBTKT/EiP2XV4O20MQkdluA9tRAJUDUeucvzocpAwogh
 73hUclVX7Z2IQd+cno9MFQ/QO6DaAQYIYwpORumsrH+KavcebPo98xkOdl6SWBfANosL
 v0LebMwxY85Iv8VHqTcDVE7jIbdlXI8Skl3+qsUJCNLYYjgcvNwvbOHlOj885trQB6gt
 ICPeCLjPu2rcWT9lbR+0XrOKsmKnVKP16nnIEmXmSGSYWDkHfe7EEKK1hUUQ4mkZXMT4
 hONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707491640; x=1708096440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BWBNxHUfGbI+smyjEUcYQObYXQXZctao+uvqQ5DzYL0=;
 b=dIlW6/mkqMG78adLyxTydIv5YGrl3z8Ysmj9xDVlOnkHSZwgJWGuCVIwQ88TvUm5EX
 m+6JepNcVe8D8zufa42YB1KbrEUgnvux++CP9oKipCGi/+bWxKf7b6glU92I/S8YiQBd
 9Lb3KKXTbdI+xZGAUE7AjTaIY/H/s8DH+XuLcLRKVjkPiJdN/U2S4V8CkFDFAWTk8o38
 8GZOGFEo6PrAXxAp+EUFU6lS9YZ2339Of6zMnbrZ8QxJZKQCFi7mxoZezZp4tUiCzLhE
 N68Xf5JkYT9+jwZ3NGf/Wk5mWs2v1wVzxvL09vpkMVjRJcC55pTtiVGNSIJbWQKPZGgW
 XVmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwlZko/ifY6xObwk4vSbtyiqHXzdXMgTqW7FQzU5yIkVt8xBL2P4ouxNDsHqwz3zN06gSnjmPEjfzX+gpTNmtAC8NjBA==
X-Gm-Message-State: AOJu0Yy+bbeMpK4dR35xT14DHso4xx3ig5GXLz3omA7BvomffHoV5adv
 qPyYxMdK3Mlxh+gtF3Q2iWbipHa8eQO4xLO7yyj4JW4plLPM3fSo8yVBSD57aag=
X-Google-Smtp-Source: AGHT+IEKR+yBSrAhW01tbAvHG/MAFgCw2tmYRhnxYMVT9Go41qbkXNA7dMhQkdhRlLXxeqcq6PyABw==
X-Received: by 2002:a05:600c:3510:b0:40f:e1ec:5d41 with SMTP id
 h16-20020a05600c351000b0040fe1ec5d41mr1636197wmq.32.1707491639900; 
 Fri, 09 Feb 2024 07:13:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXgvmZfUSy/eka+PPEJR1/EpYXUhZauiK9uVTezaepMNc99A4bamJ37PWdtw5rVM+m2OibWQVwVy2KhdigpyOWs8dHbjpZDCdN5xt9Rmu7qjd3grZGHEkUGHcTvPOUlrRredYiuA8SlFmfstCE9esvp5rz9NsN8/oHD9Q==
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 m24-20020a7bce18000000b0041047382b76sm934506wmc.37.2024.02.09.07.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 07:13:59 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] button: qcom-pmic: demote "unknown button" message to debug
Date: Fri,  9 Feb 2024 15:11:34 +0000
Message-ID: <20240209151221.3967655-1-caleb.connolly@linaro.org>
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

This message isn't an error (there can be a watchdog subnode for example)
but it shouldn't be printed unless this driver is being debugged. Demote
it to a debug print.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/button/button-qcom-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index 34a976d1e6c6..e6702139ca2d 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -133,7 +133,7 @@ static int button_qcom_pmic_bind(struct udevice *parent)
 		} else if (NODE_IS_RESIN(node)) {
 			uc_plat->label = "vol_down";
 		} else {
-			printf("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
+			debug("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
 			       ofnode_get_name(node));
 			device_unbind(dev);
 		}
-- 
2.43.0

