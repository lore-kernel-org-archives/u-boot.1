Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D59FC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 14:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1999F88071;
	Tue,  5 Mar 2024 15:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hTVqtCyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E623C88055; Tue,  5 Mar 2024 15:55:44 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FA787FA0
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 15:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412a9e9c776so40525265e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709650541; x=1710255341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=abu9HKTakdKiuvXuoDk3AvvkRfGNyASHXfujBHBqQzg=;
 b=hTVqtCyifkQibX6268ERcZEBVjFaCAzAxNChTEdp7A08wRz0XuZD4G+sFgz570LLzw
 9pzdV34cCE1egysBdhMShJEpjNFl8MxBElQLX8kgzf2uaRw4iEivbqETIynVXtgdZCfm
 q4T8NO6XZtfmeuItudRBDnlRjnGMxphtdkG0DgF8I48BNIxge/M7oZIGmv/iXPu7zGts
 /HmSF+S/FRoZHZq9nrIHVni6WYwDb//2gkzqpzdEt8A2eNk4b394t+d4mLXItoVNskrM
 0Ai1JHRBpN83aonvx7a3qHuV5ZJf14An7lK2+B1gLmPdU+UBD2bj4a+bm24uXJO72xDY
 Z1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709650541; x=1710255341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=abu9HKTakdKiuvXuoDk3AvvkRfGNyASHXfujBHBqQzg=;
 b=q0gHb30YaZpyRS0ODLVO40rfqIwfgP60ZBTHS47+4+zCuzGdgaZFFmRadHU/BfTykL
 IMF5RJRFNDkNYEn/YiyYQkhN/9icadM03hncZGejc/pJyzG0XZa7oR6jAAW7kgPRKg5n
 E4OewRtWg712fz5t106IhH3RfVKICafOoGBDvj4KSHzStM1EtXzgZAfd0viKmJIgJSFk
 TiZrLvSV3k8KqNjkORse4906XmHdggFYSFTCtKwjk2s99wwuvgFKQSp7ee+AAvLg3CBa
 osuSGYZWT68zQoHzbyYQI6v/zH37P9G6Rc97OxIqLJO7vFv3EaAb8q+veAzOAUKKZbZ1
 OR2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsor9mfBCOoK4+pgH4Ck0rIlNYCzL/UZ5qy8NW/imIbkN7hPKaPP0yRUpOKyYh6WbVRRuauYumzJJC2At1747167HZTg==
X-Gm-Message-State: AOJu0YwqkCfSAtoizZVHbe6+VAwbKDCF26wfPaLC23wZivjIpVoC2gJw
 AAbaXQnlR4ihKRB5hLCH0/K9ODDrUVTwXUUAMFQmGYFqHWQ47Jn+HYlu4FNS0VI=
X-Google-Smtp-Source: AGHT+IFnoRgZMKzHdlG3aHqJGQR7mVfws6oZBD7HfShZjUhIE4cfMDHvgBS6ClK3GyR7jPwZS1UvLQ==
X-Received: by 2002:a05:6000:12d2:b0:33d:7e9:9543 with SMTP id
 l18-20020a05600012d200b0033d07e99543mr2875197wrx.32.1709650541052; 
 Tue, 05 Mar 2024 06:55:41 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 i12-20020adff30c000000b0033e34b344f8sm7098548wro.77.2024.03.05.06.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 06:55:40 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2] initcall: break loop immediately on failure
Date: Tue,  5 Mar 2024 14:55:13 +0000
Message-ID: <20240305145525.1397253-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

The current ordering always results in func pointing to the next
function in the init_sequence. e.g. if fdtdec_setup() fails, ret will
be set to the error code, then func will be updated to point to
initf_malloc(), only then is ret checked and the loop broken. The end
result of this is that the "initcall failed at ..." error will point you
to initf_malloc(), when the error actually occured in fdtdec_setup()!

This can be quite confusing and result in a lot of time wasted debugging
code that has nothing to do with the failure (ask me how I know :P).

Adjust the for loop to check ret immediately after the call and break
early so that func will correctly reference the failed function.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes in v2:
- Don't drop the initialisation of ret (thanks Dan!).
- Link to v1: https://lore.kernel.org/u-boot/20240219183519.2183405-1-caleb.connolly@linaro.org/

Cc: Dan Carpenter <dan.carpenter@linaro.org>
---
 lib/initcall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/initcall.c b/lib/initcall.c
index ce317af213ab..c8e2b0f6a386 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -54,9 +54,9 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 	enum event_t type;
 	init_fnc_t func;
 	int ret = 0;
 
-	for (ptr = init_sequence; func = *ptr, !ret && func; ptr++) {
+	for (ptr = init_sequence; func = *ptr, func; ptr++) {
 		type = initcall_is_event(func);
 
 		if (type) {
 			if (!CONFIG_IS_ENABLED(EVENT))
@@ -70,8 +70,10 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 			debug("initcall: %p\n", (char *)func - reloc_ofs);
 		}
 
 		ret = type ? event_notify_null(type) : func();
+		if (ret)
+			break;
 	}
 
 	if (ret) {
 		if (CONFIG_IS_ENABLED(EVENT)) {
-- 
2.44.0

