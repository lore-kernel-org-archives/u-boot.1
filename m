Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8268C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451A883438;
	Tue,  5 Aug 2025 11:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRQbuU38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E88801DD; Tue,  5 Aug 2025 11:19:58 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47CEA83438
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so5524194b3a.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385595; x=1754990395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmdZWhBvisZ710e7zyHQ48HiVJfUbw1Ibbvradh1ZMk=;
 b=gRQbuU38agIpLRH46hpPl8XIKMSfnMImvxnEia4Fz6kXW25EP52TmUEmV40LDxYnBg
 nAZnBf+CXzOIHcWlpSAbyyWut3WzV/hfTGpg5ZPzjRxjt370wLAZPMFxNZqCYH9CGzq4
 ll51nFdyEKr7GmSp5TBYwKWBRcdcjYhx2tVljxemb6dnHUVJXZ3miq8f79AWauF++2Aw
 wiJAczuoWi4hh7d2cmjKHA3VHGNnlrGb7L8RAcwqVvoTP3aBieSNsed8pSRie07a1GqM
 WXl9ZyP6slpjgXcbq9X4IiWio88lcLGwO6Vft2nR8GycfLmCOgnmlHDNYu0rGQgVNe5V
 5aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385595; x=1754990395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmdZWhBvisZ710e7zyHQ48HiVJfUbw1Ibbvradh1ZMk=;
 b=hLxbR6rHvHsCOpFx/OhBD/5HQmvydSnJYkSt/5GQpaR/ujHZWZPtDGT8m1x+MJSSJH
 YSgiXjLQWChK41sdRLuB2B0Klu3jCHa0PnIFSvXNdXe+VPbk+Vj93ekHtRHXKA69T8Sx
 L46LXyAxTFOsiota6CaGLhVwq69mqWyYQz7VMwN49DEJoYpYCYCHkcZ0Jnq/DResqBVA
 NxGpHgh547OGico8Rdnn/Knw2OwJO6V0MR2mlYicCh1fSdaa07DGGAkhjbSDAr0GD93R
 QYN5W8xG6Hj+pUvW4MqpCGfSPwjrHw9tMYhdnsfu8BJgMFZM3ReThz8ZDBnK2FhDL/o+
 a68g==
X-Gm-Message-State: AOJu0YwrMK3xAQrszgDs9/wwBKishmCanXgEzLhO+bIOrvLTjKwhmZTB
 wXeSjmQ/m8b5I1DPyjTRwblu/1Vnghsu8s4CCZth01UIqbGzVNUZa5FK
X-Gm-Gg: ASbGncs9JoiccO56pPc0UChmD4kWKKAWOz45KXMFTWkLP/NUOrUmaL7VB+I4rjlnWJN
 f5iFk6Cj1NzG/UDpsqPeCxHId1FrcYxOGUkpz+1IojFCLuGObLizg5RbSlV/ApHhQUsSwnEssqU
 oCrm6T76BoIEcuis22j39uHc4tbBhb/btQ/61325Gst9iEgkXJrdUwnQ+CI0d+df9+opccf+72A
 jV6ri8Co2Vx5VbwJEiaBbNftJ7nj4uBR4BU1yC8tF2xXrRqdvWPS1JBwSL9N67xhmsE9RfuBoH3
 PbkdJ9KSvfyJNzJkUxPLRcoRfnNGB4VzF3cEWDxYu/5nS7RQ1oq7NVmUuLmY5ZeakqOvw3giXyl
 x/ZJvSS0SqjHaEqhuYikNM2b31NYzr83YvA==
X-Google-Smtp-Source: AGHT+IHZdc6hT7CilmShCcgwqyxo9uJcwfisoLuaz9XuQMw5HFF5AUdoFh5+dOQZpvowNbYR4dLuzA==
X-Received: by 2002:a05:6a00:10cb:b0:746:24c9:c92e with SMTP id
 d2e1a72fcca58-76bec3322famr16477878b3a.8.1754385594762; 
 Tue, 05 Aug 2025 02:19:54 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:19:54 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 3/9] i2c: npcm: fix consecutive dm_i2c_read/write error
Date: Tue,  5 Aug 2025 17:18:44 +0800
Message-Id: <20250805091850.2051096-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

When doing a dm_i2c_read followed by a dm_i2c_write, the subsequent
transaction may get npcm_i2c_check_sda error because the module is
still busy in STOP condition in previous dm_i2c_read.
Always check and wait for module to be out of busy before starting
an i2c transaction.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/i2c/npcm_i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index c64752e1467..bff0d04f1a5 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -34,6 +34,7 @@
 #define SMBCTL3_SDA_LVL		BIT(6)
 
 /* SMBCST */
+#define SMBCST_BUSY		BIT(0)
 #define SMBCST_BB		BIT(1)
 #define SMBCST_TGSCL		BIT(5)
 
@@ -479,11 +480,17 @@ static int npcm_i2c_xfer(struct udevice *dev,
 	struct npcm_i2c_bus *bus = dev_get_priv(dev);
 	struct npcm_i2c_regs *reg = bus->reg;
 	int ret = 0, err = 0;
+	u8 val;
 
 	if (nmsgs < 1 || nmsgs > 2) {
 		printf("%s: commands not support\n", __func__);
 		return -EREMOTEIO;
 	}
+
+	/* Wait for module out of busy */
+	if (readb_poll_timeout(&reg->cst, val, !(val & SMBCST_BUSY), 1000))
+		return -EBUSY;
+
 	/* clear ST register */
 	writeb(0xFF, &reg->st);
 
-- 
2.34.1

