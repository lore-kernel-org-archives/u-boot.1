Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9D610F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1B78409B;
	Fri, 27 Mar 2026 17:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQ58bt0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8938F83E7A; Fri, 27 Mar 2026 14:51:53 +0100 (CET)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6636F8394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-89a06bc2f1bso33898046d6.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619510; x=1775224310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6O+pKFwNLypageFlQ8uCy5NsL1KTAHz+rsH7vM/YJQ=;
 b=WQ58bt0aEibChqMaXLIO2QAxwE1+wpA20nc/OBn82JmrFL5qqpHuYeqh8V6ndiE6WC
 vIo+2HOIhSHAOQU0/E8N+SkQuroW4qIYDmK/7UUA7H5YqARgwmItehrrc1vRy8hXZbo2
 2YyZeaFtrQmtNKLDFBTgrQbAuLw6kvmYtF91WBNim3+Z+08FM1UdSePdvWnFDQCBiQUk
 uPh7slzoNOfefkbyUkTBm4fyNfjc5qSk2ezDs1ETLScxVTG/vn0A9Vb9O5TW61tF7azV
 fuZj2kEHOXF6OaxWiYcAFs+4uEwATER/JfhdryOOO/M4DWOZqGp1ailTjLECtfyZNDX9
 pWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619510; x=1775224310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R6O+pKFwNLypageFlQ8uCy5NsL1KTAHz+rsH7vM/YJQ=;
 b=dzEk2xvyXatNoQQmVgOXVwQdQCZPt8+KvUtVxl+nrHTAqjfARt8gpWlnq3PTuRonaF
 P9NhfiRZcjMlRN6Ei5IX3GBUMOPjeMwNvQOUpIO/+dG+aWtZW6dWJ0A690J5wCy5uOtX
 aXxCm81LEtTh9YRplTtaknabKzI5g6aqZAQItni0NyXWbwdNkhPUWnOzk5/eDDl/yEBq
 tCqRbd3lnSOdkVVfimctZ5fHDX53SQmILGjlJgv7Xpk51BktJ15yGGbaO374wyuoVz+N
 /rWY8ApFfp7lJiuEgzC1S57PIk8eKfU1k5XevqHxv6C7hGLYd3M0Wa1Fuk2yDGNgDHTp
 uNLw==
X-Gm-Message-State: AOJu0YyMhvukylxYhnzcWhhpeU3VUCsEv+R9TnjR+Xwf6FwtMJTGr5er
 SCJt8wENUKyGopaQTscwk2wXOZOsbMqaZGkoIVy6MhTvbwipHsrJJ2S7rbJmW+UH
X-Gm-Gg: ATEYQzyYbG25BcKK8aZ9ZvKhYR7RLEU8ssw2GtNG1qt3SakTz4e1wjxpMOGj8FrZ4og
 rFXbZf1myH7P9V/84jRTjLkERGoaP5+kOH0L21mcqNXCMxO0LYcAi+Wl91LAexLZwspNGmKJbr0
 ExGI5ptAGMOd0il/RUtABxWustoSV+nlyX5+Us0ZqgSY3AUGqt9A+sWFgYPyZ/dYPppHbcrsiM4
 0cjBz9+wOUjgpvpINHux//iQfiZCvJo+6Yoqzrck5GPM6Dr2+K2UCPZIcJT8GkQOiRyO1h9ctm4
 h3zn52Htxapveh7Jssom+Rj5HxtnHwp4Val0iBybi2pgHohaQ2sIrWpKyoLe9bpt7sdRRnfSD+6
 JQAuJkr/hVH86X9NG9SgKMkJbPsh8bu0n0Yi1QKb/XJTWaq7wAuugJ4wg05R7ILPz9M+fwEseEZ
 xfKdSEsitxdpka7PMUeWpOo6pz1WFSKTr18gYz84u3K+BV
X-Received: by 2002:a05:6214:6005:b0:89c:5c57:98c with SMTP id
 6a1803df08f44-89ce8d3b820mr33300536d6.18.1774619510071; 
 Fri, 27 Mar 2026 06:51:50 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:49 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 07/13] dts: sc594: Fix gige-reset line on EZKIT
Date: Fri, 27 Mar 2026 09:49:22 -0400
Message-Id: <bc44c8f140dcd33b91db530b37c98ffcd1ccf363.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The gige-reset line on the EZKIT was updated for the
sc598 but not the sc594. This commit aligns the two .dts
files since they are describing the same hardware, the
EZKIT carrier board.

Fixes: be79378 ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc594-som-ezkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index 11154e65ed6..e1628ce2082 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -130,7 +130,7 @@
 
 		gige-reset {
 			gpio-hog;
-			gpios = <15 GPIO_ACTIVE_HIGH>;
+			gpios = <15 GPIO_ACTIVE_LOW>;
 			output-high;
 			line-name = "gige-reset";
 			bootph-pre-ram;
-- 
2.34.1

