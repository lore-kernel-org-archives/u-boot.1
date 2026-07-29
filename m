Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096E5C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C07F7606E3;
	Wed, 29 Jul 2026 14:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGOQpkI34-qq; Wed, 29 Jul 2026 14:49:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F13B2605EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336542;
	bh=PH+Jt5Po8u3WCRb9IhAfE0hPEPWjqJp4IyxL9BqvJVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZBsuulqJ9Y+0j7or7eCP4Gfd3aqZx14yMVHnk4IWSHwmwBDdrJDcCqy9x0pYsakqj
	 LUA8l3vqU2XgjtLRRqgLOdyVUF2LUuhXPkfcd2r8l6SRsQhjuG/xqAjB/mxvDj07mR
	 NnmjlzFDiKRaq34DFQdoxlBJJC/6qJ/+6/E4T1IPewaURpiJtLclRkTw1NySQla1sn
	 GBlGlMlohfJS3i0DCqzkIFkF45NbniyGqNvIl8bBlbvpJdjc/phs8dSZ1tVrquE29W
	 AWxyIfgioYdsEH0R/DBzwOv9FHmv55S96TQyrhvbI5EXRkS4eanfV/bP6UP2WNC9TF
	 epRlgU0wSVrcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F13B2605EF;
	Wed, 29 Jul 2026 14:49:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A547350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6821860674
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPDRkQ6677U8 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:49:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B916E605EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B916E605EA
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B916E605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:00 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so14402165ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336540; x=1785941340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PH+Jt5Po8u3WCRb9IhAfE0hPEPWjqJp4IyxL9BqvJVA=;
 b=LVMlqoaj4HOMYpVTUGkigtuEnzqTDJIS38gp0uw1CCpHj1vOFL9LBRgvp4FoNqZZyS
 jD5WeLPyW/IhfwtPk7OmxeQaEyBHA+PGOwURorLyRKCFyYRUxr/78gmbzTcTifpF18+S
 o0UkCbWHvIzjDsZzUXcigCCSkWvwSEfwRFiHdhr//R8WObPYg7DbLEemoJniD5/uG2q8
 KSO1Yop6Up5RGdAx2IJ0RtAvK4KZ44bt8WCjP4KY3h/R6RIZmqAWwhxYiw3g50QVDGoO
 1bXRIIpEq/RNrzsEOWW5Dqsd0RzT3C2tnecOPX1mvlzoZvxq63dGDE93MoZaVh8wVozI
 MEAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpihmJGB7XSWmqtFsaBdW0hngiET6nZQtfY5iT/Km7h8zu1hBpM9WPDtsrIg0S3/w77I/5ccuw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy1pVdsxe5wuHnPc/k16uvW3XZveyYNDqK10qt8Fzyi1VOlN3Xp
 L43KvypNTKtXjbwfOFC0v8JUrjGXUO1G8HqxuGmxonq9PGygfzbk15V5pmcUnmBubvo=
X-Gm-Gg: AR+sD13vg+dtnwTPQVOVFFlGGSpmFykxVEhKEggTO7LH3v7XuiEA98Y+6+QuLeD5Nda
 ETkuAh7j68fHheXvufVAIpSUOj4QU52HyD35LJ3YyAbgPqOxBDm7c7jgfdH1LD1BzvUDIZknw2w
 jjpqz9CteyzijPS4lMha6pxPH+ESAmaEheOMtdTsoS2FK2UZljW42yjfFoDHgJIYRj+7LWicBzw
 r/T827ZzS73OxStJ8uUlJdPgj0RWJgg+u0jr27hah/TEqX8SiR4ruaz+Pxhpx8vTu4n8sMV+kDD
 qfn6tcoHlSBaky1ktpu4rYDvhCoDdhJyUnJHIM76XBaJOMyDusJOWsF6ENBiXX3UHBMf9wA8OzH
 QIaydP53aYYBc4/+zUB8x9ikAqM+ftoGPNQ5YrOpq8hkGDQVh+0whdzcKeZf1sTERGEdkj8wpRD
 OlQMSXC3g6Doo247mlepszKCoeFV/o8Rkk3OyEczK81obW9bHvkRqXLq289/VlUzrQfi8ZtJQ4V
 ofu8hDBbP+7z8OVMyIFAzn1mHfhOBHg3F4ZWySdzniIwADfpBAK5hRQ5ZSKDkO2QRDokcisDu7p
 8lLKXoPwrUk3FGWnYNgsGma5qux5WxePp5zr4A==
X-Received: by 2002:a05:6a21:6b0d:b0:3b3:bf95:f7e3 with SMTP id
 adf61e73a8af0-3c8ba5befcamr8543775637.43.1785336539870; 
 Wed, 29 Jul 2026 07:48:59 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:48:59 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:21 +0800
Subject: [PATCH v7 03/11] pinctrl: k1: fix pull-up/pull-down configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-3-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336540; x=1785941340;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PH+Jt5Po8u3WCRb9IhAfE0hPEPWjqJp4IyxL9BqvJVA=;
 b=o7buf7FceFj+so3Ei1BjbgejKsWZ9r6zH0DT7w6W0t7LUOGGmvMV61uIMMOu2HulEP
 7dNrT3DEkkFBh0k9kdxThfD+j45uynbZpFLnRmjKTHBZBufX0vyH7P9mtdlwhzGp7txy
 /v6kzwcqXQFeatY2E7ehv/mcuDDkle3ZgSxuqlGYQ4RMYfBPwbX8Q16yh3HiAMgGxPJe
 crERe0qsZ/+J6+4ll83iEsl50Wy9hTFNx0LfuQCJtcDMeQH5i55C5qLMgz8HjI0SCWrS
 /3ERExviwG3iO0241a3kCWiZ0AhrNTatWf5+3ROK3n0rinn24I/0P3n2b8Ua7Dy8W+xX
 UBmw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=o7buf7Fc
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fix pull-up/pull-down configuration to honor the argument parameter:
when argument is non-zero, enable the requested pull direction;
when argument is zero, clear all pull bits to disable.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Simplify pull-up/pull-down configuration by using a single
  clrsetbits_le32() call.
v6:
- Fix pull-up/pull-down configuration.
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 6ed511879daf..4e65fad1e8c5 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -409,7 +409,6 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
 	void __iomem *addr;
-	u32 mask;
 	unsigned int io_type;
 	u8 ds;
 	bool found;
@@ -424,12 +423,12 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		clrbits_le32(addr, PAD_PULLUP | PAD_PULLDOWN | PAD_PULL_EN);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
-		clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
+		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
+				argument ? PAD_PULLDOWN | PAD_PULL_EN : 0);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
-		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
+		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
+				argument ? PAD_PULLUP | PAD_PULL_EN : 0);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		io_type = IO_TYPE_1V8;

-- 
2.51.0

