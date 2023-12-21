Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA54C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEB58785D;
	Thu, 21 Dec 2023 15:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dz+yZKc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A4D876C6; Thu, 21 Dec 2023 15:24:43 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C929876C9
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsankouski@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e270639d9so1082890e87.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703168680; x=1703773480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFYucL3H2W4KKkAcQUNcz3JBnJSbk0icGucO3BAyex4=;
 b=Dz+yZKc9Krn4OWuftZJQkwUhOo3WrMLkgXTirQBFhBmQgaJZOgpDZRMGkNw94iwSTz
 1Q05ThUElkvLUyT2owMvdW32FHIp1XKhDiqpuzcMnLKmPEqlvY0+kQTA0MVqTdUo7Fz8
 vD5N7465r/cd9HCmVIZsYPtNBtXFEQRkeR+T9uqcSe8fYzk1fUYbZ97L3gNDgoMNzHer
 /fUbrdPCoXvY7JGT6s4Pl1Qo5hzbiHwhdmkD+rIsQuP466SKBE+8iekZKsUXF238JKOF
 7AK2cQaV+Fdu+TkWUA2pg/99pQuKrdY81qhZ9a2QoYtD9UqbPVL1JV+F43C7lRWwVuwt
 x0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168680; x=1703773480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFYucL3H2W4KKkAcQUNcz3JBnJSbk0icGucO3BAyex4=;
 b=X69KXqKPQweKKmBcHb4IwyrOt6JMmyJQEKIljIX11Iz1wB76qf802HUWl2znLyt0x3
 H3F+dKESvhvEIhnDzhbzrlHZ8ttrqSW7CM9Oex/PmEK0WhMued/jGquy5HmZmyiisKtL
 3yFiHD84kT3zQGHn/kIVUvwo627Dj3wKDTIKfXJJKhh9n91ERpsUBEh2kraq2zWhW1wU
 dszh6+iQPpx2l1w0vRziVnJRzPmioHIIz1VphUHwisGSb0eoCMNr+ZoglAJTHM/WG8DR
 vkOUjF/D8KsCvErm6mdzaDpq5M3RPzbwiCGs6akKy+hkojOzdnoEmVa9y7NSSYZgSyGo
 sWOA==
X-Gm-Message-State: AOJu0YxIbL+/9LXuJS7t+Aluc7od3yTHSRGSsUSdE7hQVbfna0X+4zMe
 tavqlL1OjSmsEHhyvB9uU8cMZAwA4Rc=
X-Google-Smtp-Source: AGHT+IGO7WPp8KSuZuuUdzLvhxVhfw/ztQLzS4vruUMIM7NBK0Q/qGA4KnBoc4cQSEFrllMXDKN9jQ==
X-Received: by 2002:a19:2d03:0:b0:50e:2237:3f21 with SMTP id
 k3-20020a192d03000000b0050e22373f21mr4167336lfj.46.1703168680136; 
 Thu, 21 Dec 2023 06:24:40 -0800 (PST)
Received: from debian.localdomain ([37.45.245.217])
 by smtp.googlemail.com with ESMTPSA id
 q17-20020ac25fd1000000b0050e3719148fsm280653lfg.235.2023.12.21.06.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 06:24:39 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
To: u-boot@lists.denx.de
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH 1/4] arm: dts: starqltechn: 4K align memory
Date: Thu, 21 Dec 2023 17:24:06 +0300
Message-Id: <20231221142409.82877-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221142409.82877-1-dsankouski@gmail.com>
References: <20231221142409.82877-1-dsankouski@gmail.com>
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

Fix memory size to 4K aligned.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---

 arch/arm/dts/starqltechn.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
index 3c0f42c977..e6d57d2668 100644
--- a/arch/arm/dts/starqltechn.dts
+++ b/arch/arm/dts/starqltechn.dts
@@ -25,7 +25,7 @@
 
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0 0x80000000 0 0xfe1bffff>;
+		reg = <0 0x80000000 0 0xfe1c0000>;
 	};
 
 	framebuffer: framebuffer@9D400000 {
-- 
2.39.2

