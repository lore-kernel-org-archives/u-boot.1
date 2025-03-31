Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8516DC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40C981F54;
	Mon, 31 Mar 2025 19:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="gh8Woaix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9BAC8129B; Mon, 31 Mar 2025 18:26:29 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D692881F0D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so3601791f8f.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743438387; x=1744043187;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3puv1GKpK1A5Ihu1RN9oYSzNej1koDZmDAlbSEQjcjg=;
 b=gh8WoaixvjIMJSarn5KPTQWgF2b/gMbya4bsdbilRXmuqcGrc5Zmt5ZBpPCbE3NQ5Z
 VJncLx6KPGEbJAC91gjJ5vYdJ9XNY1H3ZPiYdJAe3RdJQaFG+ZAvlOTQK2XWsRp2Wglv
 lRIc8Elkid/YbTb4yi9xx1ZpRRGQqTo1RvRz/SrYfVd+NWAqxyEq0m3tLeVXI9xKKlC6
 ZWlixHT4zpwifiAJtql0w7GrkXdNMXmQ5ILUKJTZ7WQK/e7n6QmXhTVh/2otQkL3jaO8
 Rjb5HqDHPDXDesGlRphCoNOTmH/SU+8IgTApnwocY8XBQADivBZ4pN191TTDGqleDU61
 QS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743438387; x=1744043187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3puv1GKpK1A5Ihu1RN9oYSzNej1koDZmDAlbSEQjcjg=;
 b=o1xfTYRQA94KR+6TbhrABjN7Rw0efNHrVz5Fw12xM3x2AjB/2M30L882Mj/1zoE4mm
 YP+kDJAe0tLVRhEg3+bn5C4JSrvUttRlGWBo/Zp4G9bbw/A3KqiTwdQl3n++hfvuXnij
 xpYciZ6TFTKYPYl+dYqnwrrs2YH+l5cRM2k6w+1OmW6UYOs0BQu/tgGkSJevy+lbcPqP
 9e12sXtrlaGyb4H17hj2qYLWg2ZfY1XGBgEcZJIRl1fBSAyFdEzHXKSHRCvFfqHgKErG
 zw8usQKJBlKFyDzub3051NL5pYzN3XjowLpJUOO4rRNPCdqfnBCkoWc52p/FRAvEQpTY
 llnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQBYjY6+qZkuApfAXTRkhdgo7jMrHXsLOyFJBZdqCuq+TR1LVczh6zBYw8yefUPQ/Efk2dVNY=@lists.denx.de
X-Gm-Message-State: AOJu0YxLZe6i7LFlqiGFzAjYLQ37J4iZ7BPrtcJqFvCqaDU7aV+OumcN
 ZT/DNvPYd6FwygrI+XF3LrK17ulqjKFR+51PLSRTe4fuehKfUeC23cPoMPyDG8w=
X-Gm-Gg: ASbGncvtdfQViOVRChSvNciZDoeCUFIYLz1eByrp3aTGTe8hkshOqPvKf32ld5hlJ1M
 K0JevU2/Edh57hoZYM3gry59dKqzADjMAQ79hTFTHZEe+/22lx0O7UI6tVMVQsgq/krFTCkm4cf
 3S7/MvpWNQqWAW2ga8sp6OVsW682noIwMgBDLyhLZXfB8YlWFlKo8ZazHfiMoevZvTgqSmv/jUw
 9OKspMKZGNlKOOLBNEfCisgABRbFYZygZmb1eMoGgkrvtPA433mss51wH/YC56Qp+PsH3c/ae4F
 ClIW6A6pXGv+6+3j/TpviaJZ6VSXboSByeqmSfxT+Gg57hK3tRXLusoU
X-Google-Smtp-Source: AGHT+IHUkwHS5FGX0JoIt7z+TEPeyfjIizW5UXpljN5gruHka+Htgh/J+AydoqCUhXxcdy4YcqBZfA==
X-Received: by 2002:a05:6000:400e:b0:391:31c8:ba59 with SMTP id
 ffacd0b85a97d-39c120cd139mr6834408f8f.4.1743438387310; 
 Mon, 31 Mar 2025 09:26:27 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d8fccfd9bsm127267695e9.20.2025.03.31.09.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:26:26 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/3] ARM: dts: at91: sam9x60-curiosity: Enable USB gadget
 node
Date: Mon, 31 Mar 2025 18:26:09 +0200
Message-ID: <20250331162611.1557759-4-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331162611.1557759-1-admin@hifiphile.com>
References: <20250331162611.1557759-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 19:00:14 +0200
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

Enable USB gadget usb0 node support.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 99867d2bf8e..08480df88c6 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -248,6 +248,10 @@
 	};
 };
 
+&usb0 {
+	status = "okay";
+};
+
 &usb1 {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
-- 
2.49.0

