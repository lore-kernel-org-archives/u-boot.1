Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2EFC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 15:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7B888091;
	Tue,  5 Mar 2024 16:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pbwI0OiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 450E288093; Tue,  5 Mar 2024 16:16:27 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFB288084
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 16:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412ea23a750so7823155e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709651785; x=1710256585; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N8E6012pbyDH8oUsEymzLmbr50AAhT1K8MEq4mDPP8Y=;
 b=pbwI0OiIM0pIyRtI5j18v92X2vyVmv+MfY06bFdNX5jq+14T/rW3mu7LpBGlP03CHe
 DPaqdcxJgTN1VBYcp4pH/9Guue6JJACT9k9HMlX/U7/pkXPyzIE4WxZiTXT24NuShLMl
 mg5+SUp5UyR4uJvSMyI5J6bk9ow+sNLkvJwFABxeJybAJNOSosDgOKgAA00o0eum15ct
 7YdQef/IMhLuz+mLiVvZJeOo7q80/MHSw9D4FOGGnuAd82dWOui6IUa6+eX04giWmX+y
 bNutmqjNmeG/XPVbuJHIC9J3MZpDFDCyfRY8HfzFL0Plo+DYmsIw9ItVOEFP2T5cSoJM
 yUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709651785; x=1710256585;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N8E6012pbyDH8oUsEymzLmbr50AAhT1K8MEq4mDPP8Y=;
 b=adMELPFaVFzOvWXjghrCqOcWXn/x1Z0IkaeD6E7xpM+jXfFP7Qpk/AZVJyct4WVb/L
 hxP3cGg1lPNoIeBiZqeTPqOZbqoT6N58nuE6vILNTzCP4dGAzWqBuu4+PqW3EIdpXwsz
 DlIGj1gHte8mQS8QH3EEy4l3fJAk8Woz/zpYwQW5AZ3IN5YJ9Tls5qGKlWXwO1QTwJne
 rpIO7ynWeArmx2XfNCZkvmwnXXwCf5eZsLeTwgc1CEMLuosl+8i3oKnPWGtA4xGSn3U0
 PUlx/n+9vgKsSY3KUHB6R+Bg2Iz2fjFgQODAnsiwUPNqbGNe2zKTZ68WghOFd1iZGzm+
 WAMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU83JT/0/IywVX9ntumpBQM031jn6Js2nUv3ykibTsuXGUbIAzwvLhuTQMaw2ji4KJtJlPdn8G0L5L33l5KBplkstDI0w==
X-Gm-Message-State: AOJu0YwetdpqMMwb6CgA9d0X4bIbw+1xwy9HIz5zp7mpBz7Ni6Clt6fu
 C3YIMDCwhxGUk7CI/5A8YaeJCEoMMC+/O2D/iH4Kk6CgPtwaQlLV4Af4AqKuXLM=
X-Google-Smtp-Source: AGHT+IEfkUwcCF+JpJeWROa0n1D/v/iCBU/4d1qA1uSAbPwRcxmt73uxXutYbbl3J8dDDm2JbfH6MQ==
X-Received: by 2002:a05:600c:5d6:b0:412:eac6:8992 with SMTP id
 p22-20020a05600c05d600b00412eac68992mr2490430wmd.9.1709651784666; 
 Tue, 05 Mar 2024 07:16:24 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 m19-20020a056000181300b0033d3b8820f8sm15147062wrh.109.2024.03.05.07.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 07:16:24 -0800 (PST)
Date: Tue, 5 Mar 2024 18:16:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] sandbox: select CONFIG_64BIT for SANDBOX64
Message-ID: <4ee938f4-7e75-4348-9237-6d2cbe4ae67a@moroto.mountain>
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
 arch/sandbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 0ce77de2fcb4..c431da60e8c4 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -12,6 +12,7 @@ config SYS_CPU
 
 config SANDBOX64
 	bool "Use 64-bit addresses"
+	select 64BIT
 	select PHYS_64BIT
 	depends on HOST_64BIT
 
-- 
2.43.0

