Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50019C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A603482F8E;
	Fri, 11 Jul 2025 17:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="juYq6WRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1FD2830F6; Fri, 11 Jul 2025 17:20:21 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA75282F14
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2efbbf5a754so1375219fac.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247218; x=1752852018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uUKU084LcCC9gctSbMeTEk0jlGxtEhxxMVNo0dzIev4=;
 b=juYq6WRUnagZ6E3yilriGfiFf9TXEwbB6c+XIQEM8BAspt8B+0bmeqNPIlKTSKsD+c
 KS2qZ47qxLiSGb+m9zrHhhYO2HYAilS0+zpXCoeaWjWaTyIeGK03nErZubljyJ4pS0RV
 K1vqZhhl+aNysta16O9fyT5zOBQoq/JE/ugC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247218; x=1752852018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uUKU084LcCC9gctSbMeTEk0jlGxtEhxxMVNo0dzIev4=;
 b=YUoIpvQUF9qtq2uM08lviFYaANTl6tZfs93VUUsRXeWvxwfyn5Vv6PBpF1OW1ClLIs
 oWfBZKoW2DXw4aJ5jKAc1fMys6LnepK46WGgcj1WPB6GmgRpvM7GlDtJ4GyToGHb89KO
 Gx7Rvqf/ywU/0fTNbhmm8jAblMFgetitkWhcRaTK1JD5LddgfKLQI/gA+YOGYNBtFnsx
 m/s+dyKu8EN7qzynApK6f6wJtC7+kPF+gwjbqSZ9p54qeUrT8EwTC6ZJjYVDFfIRvJyT
 qTPpvIS31J7ZClh2kdD4wDOx715YUuGnYB3Uj+T1o/K/4LNJPiKE6WlkeQLlzDD0k2mh
 NCdg==
X-Gm-Message-State: AOJu0YylI2u1FHNJFGX+0T2musWkS7jNY5yasjjYHSFomqK1FOUTz0EN
 N7+MBgjbJPiM4Ykf20NlNIfZIxvtUxBIXPGpo/jlb1D+jpSm5CP1xp9xwSGyKrljS/pbtChRPNN
 hReqoSeA=
X-Gm-Gg: ASbGncvHJbl4LbR3Ge9JBRZDORrniEjInGjTaUjVrEY3TVzzw5Vp1Dz5ShPAZu8OjZ3
 wGgrZarjEIfVKphrYM9bmT/yEtaPRZ9EGEUa5IEs42LeoeTwRyt1aHwZclTQoZiNZ+1NwtR5KF3
 YZ9+J1M4b1MLidrVNmHniCpo8vL0nGUiPrh4pvBH7BnrqVbcd9yZTwK9JpWxypplyO635l7+aaO
 Jwaep+kUGSEhvkKOUtg3hEYy5moknRpjbpx+oIfkMLw39NaWO29hs6/mKMJKpnIXZ3LMP9DHNCO
 cHy4Rj7IHe7xJs6f0h9XSRhNSH49w/4Ia+yVUNCfZPNoyOq1ZYff75s2xfOjDO+D60JYmuwVXSs
 I2YPSoezCem19vZLXECdlTxUEhImDrVorNml+dOsRP8UmseisOSRJnCDmTPRhxccLKop/8Q==
X-Google-Smtp-Source: AGHT+IHKKcHuyHUz6FsO/6GQjuDRCwLXrPw+MDN7S7SmFfNacB95lRwVgVWgH8UIS5PcQdmb3O28PA==
X-Received: by 2002:a05:6870:7909:b0:2d5:2191:c8b3 with SMTP id
 586e51a60fabf-2ff27049ca8mr2872062fac.29.1752247218310; 
 Fri, 11 Jul 2025 08:20:18 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff1172e5c8sm761583fac.44.2025.07.11.08.20.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Add dummy sync()
Date: Fri, 11 Jul 2025 09:20:16 -0600
Message-ID: <20250711152016.2225486-1-trini@konsulko.com>
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

In order to compile more drivers, add an empty sync() function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 6e3f9547fee7..11ed89e00710 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -8,6 +8,10 @@
 
 #include <linux/types.h>
 
+static inline void sync(void)
+{
+}
+
 enum sandboxio_size_t {
 	SB_SIZE_8,
 	SB_SIZE_16,
-- 
2.43.0

