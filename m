Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA7DD44D58
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 12:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38BD5891D1;
	Wed,  6 Nov 2024 13:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lK+Eu8Fo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589F5891D1; Wed,  6 Nov 2024 13:42:41 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F8A8902D
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 13:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so54060965e9.2
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 04:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730896959; x=1731501759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjQfUSJoYyLqj045F3eAXylgLf/QJALJlWx8BKfNqAs=;
 b=lK+Eu8FotHlluZTNN1X+tVZQTkqZdB8WCPW6vGTOZ6OZGKhCaO6Ecqoz5hZPIoyKIV
 5AiKiBkpoqQxf+GNyW776HjhSW8+i5ibHN2DIsSxGI2RKZr7KuUtPvQkLWZiWpLA7RqK
 0N8eL9P+bsOKG5ZvjqeQBGC4pXEERZ9NGfAEWWfHBOE1Eye0bmAtFSNb8dfbj6vJQsjP
 npdBlJDEg44AiPfVSjxxR8IeHnHMZW//UrGgOetjKXDy9bU/NlAcglUMvI16xvfZWTD1
 nlti934UvfYz8Ttx517tNEQy0vr6tD+tWcYYhTCcMCJTBpvfnA5M4KClSKvklDlHSNP/
 wVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730896959; x=1731501759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjQfUSJoYyLqj045F3eAXylgLf/QJALJlWx8BKfNqAs=;
 b=MAYJALGuE0AVjr+S57n6F8taq66lf5OxKK5vtyG0/d22LCvcnpiOjzqJsExQWW20aA
 23ke7ZK/trQ9sXafmUNT0+1IVKkbN/XgmVHOXFr6gfpjczkXikJbD0HW/7w19ZqL0x65
 RgDD3B6e9iXYDn5DcyPoX9FG/TwGHzij83OpX55XsVis1uCklS17XmkQWdYawFnkDpmT
 CDExU8AyXR74RXV3/8yMhRJwutsTPc2wh3olJXPyauvYbWidysmhcsM5YMH2Puf8Fpbf
 5j4Uqg5dtjuewL/2Qr9zpd0759VpbIJb8H0VX1rLe+s7fEKw+6pUgtiApjRThEJJOxhr
 2j+A==
X-Gm-Message-State: AOJu0YwW5g7gwTLt0LaV0ukRP8JdLy8SvP6XRJK81fmhQdntgQ1xOf9p
 uFywx0aZFES+pCqW7IK/+zyYtM8kNwpKwkAdg0GbaOlAMofBm+U5XtmCfOZWhPdMxUu/pG6XSK0
 lTn/+6an+
X-Google-Smtp-Source: AGHT+IFBgnJLb5vEm6OgrWGqd1/kg7kaCXa3F0X7X87hHiBbQ611tNzNfcx0y+vAiATccBRKlJXO4Q==
X-Received: by 2002:a05:600c:3c8c:b0:431:4fa0:2e0b with SMTP id
 5b1f17b1804b1-4319ad146b1mr325834715e9.28.1730896958627; 
 Wed, 06 Nov 2024 04:42:38 -0800 (PST)
Received: from artemis2.elfringham.co.uk ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116c13asm18884765f8f.109.2024.11.06.04.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 04:42:38 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] x86: select CONFIG_64BIT for X86_64
Date: Wed,  6 Nov 2024 12:42:15 +0000
Message-Id: <20241106124215.677519-3-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106124215.677519-1-andrew.goodbody@linaro.org>
References: <20241106124215.677519-1-andrew.goodbody@linaro.org>
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

Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
static analysis tools.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

Changes in v2:
Corrected commit title to be x86 not sandbox

 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 23a1e21b29..006a59d6fa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -44,6 +44,7 @@ endchoice
 
 config X86_64
 	bool
+	select 64BIT
 
 config SPL_X86_64
 	bool
-- 
2.39.5

