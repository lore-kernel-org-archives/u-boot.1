Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5D0E81BA5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F9A839A5;
	Mon,  9 Feb 2026 12:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dGnvCwk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D539B83C54; Mon,  9 Feb 2026 12:45:26 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 056C48341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43767807da6so918973f8f.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 03:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770637524; x=1771242324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o7xJ2uiHLdB1CtNMVeggADo7mFGc2MV64WthD3IXuQI=;
 b=dGnvCwk5gkUL12V5F60PqvQcLM6a9/TrvLbauNdf0hmxIN92xpCi8PVS+AOPQTv77Q
 X+v17KWY47i/fSeUeHrAfwDPJiR9oqiYrqbHN9L4ET2671QpjKQ2jVUoT3fslmZ37i3W
 Qokne1XWzZP2fsgQtcifRKInnu3dOxcZCipbynrSQzVxk+d4J7BLpfDL5iZ2/5rERw/0
 BQJninbnbO/pUwKrFZYG9DFIomoN3hg+hkL4FIJ/YFB60bSFdRyb2LUidULh8GmHybEI
 LOfx4WEdQa8K/reGD9Gqrd7BvvTzz6g8JDqw///Xr0FxBWksYkKwBHY/BIbCWTosAkbQ
 9bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770637524; x=1771242324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7xJ2uiHLdB1CtNMVeggADo7mFGc2MV64WthD3IXuQI=;
 b=bce3LRroPOASHhlAs1w9Ap1XFJ+dl3BQZIprtVJUKVXZg36VPkr5YsRJ6mvwqyGCbp
 4wpp80kBCHe5fprdU2up1iwCJPe5cFHZvK/3YlZd0WavR+YmPZBFpR0FxEgV/Bg1t90v
 J+TTyWW/UV3TRIhNBjNr4ZRINSZI8oj/LGRD96pA9NjrzVOpIJvJLXt08nm8ZqXGeF7E
 dyX+a8YV5X4OAKOAPyF/gSt1Dtzr+6DJo071b1orXU5qhS/R46lPl31LxLF1Y75Y3rTy
 o0kx8KK5NtqhlRnaggOIkZHtebNfPG74zmYfj3UV8vL2LLttA9TR7MGLicyVUjNGo59+
 cIxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc64yLQBjpwNI0sylnQr+5Z66ArGWjhc8Pkn50kZShanwn5HIQUWutqGPkGnvYGNALRHQyIrs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7W52NOX6edUi9e1CXKpVqCXMlLmASgyE9qNzvq0NOiGzz0vXw
 DCIyDfNgSWH8yymhW3aytoHRwMAFyo29y21+E9g0NU01pQ6YI+w1qRWs
X-Gm-Gg: AZuq6aJ121fGWCNqSqb8bjsaRCmHh3U6kf+DP6lXj2PoO1ej0JxlF7Ac0kl1JBtlYu9
 jU1JEoZ9n0qdYRT0zyty7CjVbgzrsw0V7EEvNR4QlTWVA8DPfJjRJBx6IEliq05t5cFWJrwRWwp
 JSQhiPPlsOn/bGCKCFDYpo6X81jHePkLYOA+eAzlP7ea/peC1c9m1WPkz0Kaz01JghITV+EHmbt
 gImXRScAPpav/TalwKGsPl0XorTs+C0Eh0sD+V0lzGpwk9REgtf3RtNRZCcAeOxWasrWXvTImwS
 F85CSyaDQUzPnRon/P3ObgvG+cS9GRNKuHjPmRzsbu0AX4sfTSSNk08s4kwD7KhYJWUoRA6vI5x
 y6AiD1ROwDKTUoY13VjBx7zyjclsb4/kL1ggoGwkEV0onWHgwdqAF+1/J8RP6JIOo66jtNCMeb7
 FYfpt+f0tmsHIv1p5aGUliNGnEuQrYdAI4JWSgzQAbfLc=
X-Received: by 2002:a05:6000:2212:b0:435:a3b9:9b8 with SMTP id
 ffacd0b85a97d-4362923fc19mr17810328f8f.24.1770637524156; 
 Mon, 09 Feb 2026 03:45:24 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-125.ip49.fastwebnet.it. [93.34.90.125])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436296b20fasm26297380f8f.6.2026.02.09.03.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 03:45:23 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 0/2] net: mdio-mt7531-mmio: consolidate and improve probe
Date: Mon,  9 Feb 2026 12:45:04 +0100
Message-ID: <20260209114515.1916-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
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

This small series consolidate header usage of mdio-mt7531-mmio driver
and improve usage in preparation for support of OF PHY autoprobe.

This driver is still not used (as it will be used by AN7581/AN7583)
in the OF mode (it's used by MT7988 for the MDIO functions)

For OF PHY to be correctly autoprobed, the MDIO driver needs to attached
to the MDIO node (the parent of the PHY nodes)

With such change the MDIO driver can be binded with the MDIO node instead
of the switch node as previously required.

Christian Marangi (2):
  net: mdio-mt7531-mmio: use common header priv struct
  net: mdio-mt7531-mmio: improve parsing of switch register on probe

 drivers/net/mdio-mt7531-mmio.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

-- 
2.51.0

