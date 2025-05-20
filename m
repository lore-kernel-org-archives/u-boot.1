Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F9FC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE5C82B07;
	Tue, 20 May 2025 13:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="Xru/Z3jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A2582BE3; Tue, 20 May 2025 13:38:06 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6854182B07
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso770473366b.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747741084; x=1748345884;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iVifqlMpjS045IPnR8Vf+MjFZOjKmOJei9bkw4j2Y84=;
 b=Xru/Z3jj8Nt1ZiVYyNChP30N5mpyJmj0+X0LS4NuFcm9BjcWdCJsCMd76aUsAUJYKZ
 Gh0kliidQoLdWTSXp7sqXS3XurkrpfO6ooZfwfqJoIwlx3NcjAcsZ+qTUCJp48QKqPEG
 OD85kufgHI/FCJS/UN1np/IvC1Jtsz7w1l/h9iafbapFFO4zNojJME5wE9EN+ad03CLV
 SJgdTMUDlMTe2UsvLadoSIbm7NBPry3G5lvufmZ8WDEUqJy0Cu1QS+OrgOivpfzB7TnZ
 hKaBMlVjFII4Efg2OCDiS+1zkpCg9kGQLg+h5OCZxIIWEm1KGD1529+i+OVytlk42PtS
 WxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741084; x=1748345884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVifqlMpjS045IPnR8Vf+MjFZOjKmOJei9bkw4j2Y84=;
 b=Jd6F4aid6a0G8hD7d8sVhh2Uda92UfFTOCq4e01UnIkOGaCg6rtPeH9k5+IB7jh1WP
 pgG++f/dnG7TT4Ii7cPaBvtXHF2Op99pWW5hbWwhYJhz9axpqP0lCFHZd7eCc07zPAVH
 3q1plgoJoIywX3sMFYmO/FyvImaiHYFPD7hxzKqqPBLEvkFnFi78pJ1IRbZZ2MT+XqVs
 D12PcgxkFg6hU9ji7DlLzC7oPtz6l2jXBFbPnYrqxi+aHV9jRGWBuLAzM5sH2TKZ3MPS
 LeKzkRjEtie7T67FhYgZeRPzQK7trXwOc5F3myrNurS8n2XYPLuXBMFjkSK8ypSvcDls
 5dWA==
X-Gm-Message-State: AOJu0YzFg+XEGTT6q/CH0960Ri/lxE5lMrJ4xHjdfAW9zZZGgQb+WWyp
 4tQMUMI1l0SMtjnk7NWQ5CkTYZ/G5Bi+xJ3UIeXa26iC9zleL4pJBCj2e/2gX7cq+S0=
X-Gm-Gg: ASbGnctiMXxMAi2IH2JWiqw2btqYKi5oQbb0ub40ih4ALcRqiTjxwkgvg/uoavdy/vb
 0ML2p4TA1loF7XWPlXXJC/aK2OiU7mhvNoh6ZgxvKg0Bc9uEOZcCn7QMzkWQrbCj5pcLJQx4TWp
 BMm6lATidlSkbLR3TwSqLYWLEUIGwCGgef+ww8M4lvZ0wZZyvzsN9z1fnRaUBoX4K8ic4ijiuva
 R3mvk+E0hyVILzclzrmz/juiLgJJOvUJT7e3Y9U9YuoaK8ELobo5y4NLP6QLM4BRVJCLQ5r6Rmj
 CwWEYm8OXWOKPSRsIwTf15eMoPT/oRifQVBN26ehwqhlX/hEzZ2SPmj5EzbW0P/5
X-Google-Smtp-Source: AGHT+IEGQVRkIXlbTZZROcstKzKbx3EFB2WoEzZ7qEuDKoChp1tJRY+vwU7rDCWkTI9gZ9qtdic5eg==
X-Received: by 2002:a17:907:72c3:b0:ad5:1ef3:20f5 with SMTP id
 a640c23a62f3a-ad52d5374b2mr1445301466b.33.1747741083817; 
 Tue, 20 May 2025 04:38:03 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383bdsm715331166b.122.2025.05.20.04.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:38:03 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 20 May 2025 13:36:43 +0200
Subject: [PATCH v5 5/6] rockchip: px30: Weaken dependency TPL/SPL serial
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-silent_console-v5-5-ef9583d93285@thaumatec.com>
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
In-Reply-To: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Allow to disable serial console in TPL and SPL. Weak dependency
to SPL_SERIAL and TPL_SERIAL is also used in other Rockchip boards.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/mach-rockchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 9210877a4a49..dac160d33ae3 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -11,8 +11,8 @@ config ROCKCHIP_PX30
 	select TPL_TINY_FRAMEWORK if TPL
 	select TPL_HAVE_INIT_STACK if TPL
 	imply SPL_SEPARATE_BSS
-	select SPL_SERIAL
-	select TPL_SERIAL
+	imply SPL_SERIAL
+	imply TPL_SERIAL
 	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR

-- 
2.43.0

