Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7213C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 15:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E298809E;
	Tue,  5 Mar 2024 16:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vD7xRWpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E639B8809D; Tue,  5 Mar 2024 16:16:38 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A4AF8809F
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 16:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412e1b52934so15106215e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 07:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709651796; x=1710256596; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EbJqjZpvizCraGsN/kaTWMUhKLhUSQo34sUwUJs9/Lk=;
 b=vD7xRWpTaDQMGGOem46cdqdnC+fNoLiiZtbp7WfoZDnRD+Fep3XD9VaqfJz0jmgda6
 TJbHy72VvObfCyCAnpJDLWcmYqwT2sKs5L9RBCkzrqy+ie6Ro1jVhbTB65dA0gp9aSLj
 C9Ka2jdSKWCA0TSE4M3wTaHEh1gP94VMp2gEPF6vb2JWiUsvCyKq1bPQe7hfFs6rqPQD
 /a4955HCzjqcxAzZGlZAPhBK+ycp9/pr3Q3AFVEU5j81k0gxEoXThfyEEoOaZTP+OVmc
 GxBRNt5N3LmNwR3QSLtM4vc9f1uVtj7dQVsCe5Jw1cv+WsJhzq6OlolzPU/3De5TSFGL
 RUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709651796; x=1710256596;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbJqjZpvizCraGsN/kaTWMUhKLhUSQo34sUwUJs9/Lk=;
 b=uuxEZ4xPrPEepH9kgFPpX5BPEo9fi4cX+2qHvbGvj0xvy8RZURLK6WwjTiBZV3auCG
 mTzgQrhR0gz7raS65j/9TyHFm/Y5RFezDqokDrH8x3f+HlwBJN43qQqDomTNQggYu/0t
 KntdmhPfryt601EaNlaUwKUvEK8JQ8vTBSkkxPHKkL3xlQSKrmZ51S8vZaMak6ww82eV
 c9KLoTV1Div5wHO5e2JiVw6bZUh9NIrremL9O4CyJitjwrDRLW0TIzdZQ4a3ir0ol33u
 bfVbQsFJwOaqknqJkPYzfr1ii1KPDFIW6VPBoGdZRk8JZglnVnYT5xy0GXDIGlIu1CeF
 lZPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzsDYXLMkqYBmGVIJjarPDsDxevEqd5C3APaUeFnMd5HBR6HW2Djr61EJi7lOnf0wnoLpaRCdPYuTt2BhpzSzVl19YJQ==
X-Gm-Message-State: AOJu0YwODWo5iHDVyISlVlibDwe2dwiD2OFHoWH+bhcxnwS5DA7C+1kh
 yayFqN9ng06glcjj8mNroygcL1sbmvzq4gEvJzpLjVQ7fvSDDm8VnHwiibOTYCs=
X-Google-Smtp-Source: AGHT+IFhudac3RroleFl/CgXqNKGV5jd/Wqb+P+CtXYTdkc/eDu0+o2U6cXmmIYtN9jcA2p6HDjTwQ==
X-Received: by 2002:a05:600c:4e8a:b0:412:e96b:11d7 with SMTP id
 f10-20020a05600c4e8a00b00412e96b11d7mr2704233wmq.13.1709651796424; 
 Tue, 05 Mar 2024 07:16:36 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 co14-20020a0560000a0e00b0033e3ce48ba1sm6062086wrb.16.2024.03.05.07.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 07:16:36 -0800 (PST)
Date: Tue, 5 Mar 2024 18:16:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] sandbox: select CONFIG_64BIT for X86_64
Message-ID: <74e3f17c-6915-4a7e-a81c-af0fbf64fe16@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1a59f6a-ef74-4774-8319-983b1508927a@moroto.mountain>
X-Mailer: git-send-email haha only kidding
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
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 99e59d94c606..fb7772936cd5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -44,6 +44,7 @@ endchoice
 
 config X86_64
 	bool
+	select 64BIT
 
 config SPL_X86_64
 	bool
-- 
2.43.0

