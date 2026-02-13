Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3AAEF99D3
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1D683E13;
	Fri, 13 Feb 2026 21:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dDM4tQta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D9080B98; Fri, 13 Feb 2026 21:16:32 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC6480B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-46394090d2fso433198b6e.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771013789; x=1771618589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6ZUB6bslUzYqyAFQb9Fuz8T6/jT9U1+6pEJf+o4thQ=;
 b=dDM4tQta1nDk5iZTqiGWjbfYOQwQHxxu9TxJgnDyOLWjGHsMepu/fPAPkanzXN+hwg
 jKAXBauHXJgCLjqYjB94NQaOHtcMeA+5z2nqTsVKUDO2Qxyv3mw7xFd6M4H3Imloxbld
 SQal9WgyZpwCwW4jTeLkHTv6W1i74JbJd0QrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771013789; x=1771618589;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m6ZUB6bslUzYqyAFQb9Fuz8T6/jT9U1+6pEJf+o4thQ=;
 b=GX4nVv4Jitg52YuiP9ARdDNhoV4fo1wyHGyONFECQ6inmQcEYQQ2vZyjdV/z2Mipco
 jrndtrMbBdje8Kq4AvLy0O627n/vk9SnTO/jYrE/YBzbgcWrvF4zEOejhaQMGCnjITL/
 ie4zv6SfOfok73JZvvIWWr+41oZbD/yAzFKag7Eqz3x/CdGHcfKdNLNrKjH3asdl64qS
 HQ41kidjYuYZyA+EPpnnCY+W2DoK7QNcjSY+aPRQRlP2VMt4ygL1ageuv0S53aXRWVTX
 Ro8CDPr4zOjAAZGQ0V3AuHfs5xc5MF1yf+tPAw6KGY3S7MNC5X5PSWu8Fe0BrU5GXMRK
 tXJg==
X-Gm-Message-State: AOJu0YymSfhA4bx9CvwxDLDTHEmo7TpuZeQH82QQAag5QT0o4YHjQyXE
 vfVSl+g+E2dp8+GVMH9BBz+WAnEYK+KbnbfmVoHtuGuoXs26+FWHuHrIZYMg+0wjoQY=
X-Gm-Gg: AZuq6aL5kyDEvy1bt4S3ABLqjtciBMCkUB4jbYS6F7R4aLQv3beQOw3MEjBmUN19Zzn
 EwnBo9SwlehMu8+epIC9jx/eCJhhDHhYgoNjr8xbcxDVCFMPRZYgBJR4HBwC+hiVTDQCL0JoG9V
 yM7d/WZgp3JPtP+DCyUBoNp6vNJb5RGrdKxWRq9LF8j6tEvtYggLo4/+djwA2cpAevmDv3LhlXq
 WbKKWce6Ue1jtFUuVnxnadIdtjJ/DnDFMiZBR26+LWHVjYFX8Jy4QfbMOjdkECKxjSsQWJlOxdW
 rEiW2e57Y3K43vjdXry1QOvGbAU2kze+7MlCR7Bob4EN1D+7UGyyhd5Ed9wh82+QsvEIosNtl2D
 qp+yxD8+hePq68cAqSF8tcdxGz4S8j5Ix4esQou3LndLqKxck5iIaD7EoEjI1/+PJvNt3878dSF
 9U3+/V2T6qjDxqM5CNddHYmn5haNLAbT313JP2OaISzp7YSe8YpCS62+JZ+FfC+hrBXfDy6vXFC
 51qjMAUyt0UHwO8ZLvDMejM2mqtoRB3ubumzwznmgt/Cy08YA==
X-Received: by 2002:a05:6808:190d:b0:45c:94e7:ba96 with SMTP id
 5614622812f47-463b403b251mr323895b6e.38.1771013789488; 
 Fri, 13 Feb 2026 12:16:29 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm5152025b6e.3.2026.02.13.12.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 12:16:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
In-Reply-To: <TYRPR01MB155520F5FD75A2AAE0A992875BCDEA@TYRPR01MB15552.jpnprd01.prod.outlook.com>
References: <TYRPR01MB155520F5FD75A2AAE0A992875BCDEA@TYRPR01MB15552.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] mtd: spi-nor-tiny: fix 4-Byte address instructions for
 Cypress and ISSI
Message-Id: <177101378874.2522051.16108135293142114051.b4-ty@konsulko.com>
Date: Fri, 13 Feb 2026 14:16:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 26 Nov 2025 09:37:41 +0800, Shiji Yang wrote:

> In theory, for the same vendor, we should use the same instructions as
> the spi-nor-core implementation.
> 
> 

Applied to u-boot/next, thanks!

[1/1] mtd: spi-nor-tiny: fix 4-Byte address instructions for Cypress and ISSI
      commit: eae0ca2125933c3d1742deba723d2cc4b4955ef0
-- 
Tom


