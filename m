Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB660C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DEDE40807;
	Wed, 29 Jul 2026 14:48:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8wwObElqGQfi; Wed, 29 Jul 2026 14:48:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 046A2406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336537;
	bh=ROR+qGCDwnxmrW5tdKeKQbw6hKqk4WyFrrTMRxwx9Zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yjSDTiKuSSRhdL9TXfVjsKjb6TbLmn+hsd2LkhG9H5/d4MUsf0/6QT4PDkqVBhhGI
	 7eys4Nf2JBHjUO/K5dl0NA8dfwLLsFEAu6vZUL5opJOq8kVbh3+bQN+hAl311XEyFD
	 A1Z38bW6nL6GpE8mma/3f/DB8tEaGuyt2pOBhr5Wx78A4S6210HAALwtzk2nuNMV8X
	 ol4FwVnpDRG3lcAc+CE0xN3w4J81JUeWLa9ZyN6MT6bH95a2G7QnCa1LSYaVbo64cK
	 GCH8q8k0SAGlTLxi493JxlKb/s95Z+HqcNhyo3gQmKUv6XxW+u9JCGp24ljSwFa0Qa
	 UctHHspJWljtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 046A2406FA;
	Wed, 29 Jul 2026 14:48:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C37C9490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9CC060674
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id htXM4vYDcEDg for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:48:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 08569605EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08569605EA
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08569605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:54 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so1213041b3a.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336534; x=1785941334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ROR+qGCDwnxmrW5tdKeKQbw6hKqk4WyFrrTMRxwx9Zc=;
 b=Z3VLqB6ahWoBAB24Vn0Zso8E64GeWVAIlE9WjfpAlyNy3O4UhyRqSgnWEMsiRp7guv
 ufHYBZUfem/2jG5NjM2UnDqsodLJHpkWF4N42JRbVjewq+/k2+KcXZG6TKBDvSTa29xP
 4sbeDALfmvGDyKki8Ant2ycXw2p7RJtFh273R1YmgfFS4fjzLygqwBmIu4sz2zD69wR9
 5Jn70DsaIqRVsJlyhA/ltTeVR8M49KyOLeNZ6jPLnm3RP53OhKK7DX3jdr2E9fkt8QEn
 PJUIG6iz1piZBeYI6mgYXimMWEwkdj7WFIugQVj9XGYqAwwZuMtxxmGZdl5aL8fb7Xhx
 wcmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqj1SQu3fxUIz3Fh8gCpXKF2yQ27xtlmIU7w66038iPcKyfuG/FAkPkvev+AskJQU7norkTuZU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwpeRwAQvZz0rTj0O0qYnwchUK/bLVEGiWQg4zM8Y9epffB/S7c
 ZYkjGzh/xrleNxZhTY2ybMkC4CI6FApQN4o2J7rqugBx/Mr1U9UgZldH25X0RS1FbT8=
X-Gm-Gg: AR+sD137NlMOCyp275S02GInh5qjHpD337wvqwLJlH/roZWBCwNthNqjhBUDD4B6aBy
 v4s96C6NqWR3KjR2l1GwUiTPVehfUTo5VgpGQPXX1rK1Bl0e6E1eNFBXw/BNtpdN0Z/krmX6aXe
 lRhR0xB7Hu9DsKWVzWVKwALh72yuvLCHnwHm/0Ekpg2YILoYj3EDikYt7kPI+er7hUnNUWrQLzl
 /sLtIzFWvaQXqYt/vgzVLNyLrJegkOV3yXw5KgTxKsXds7/LfdAE5z9XADJEzn5M9xCwMpST76t
 QggTzoAZ96T831j/8MKImSOocSTHElcJiA6hJdFuZO9mQpcJj8AYXiLJxPgavQ3dSGRdGx99m3l
 rdZkL5EVlQQIpdjevRlVctorG3JTMBcpKZN83l/sqLxbmYTRJQcYIpeYsZzhgwr5dKa3kAKxbxv
 zMyiVhJTEHZCm9zxlKgPmjpqsSeWQLAO26Uf9nlqiFbaqERuliSkz9m8ifu9ncp81/5DejAwLyW
 CiG9cMZnz5z+D65jXB3MpMtAxIcVco1owMvhT6YPhD9mMjDXPd1c9aXb5NITZKtWHNxFfgWpm+e
 iV1bEqbqRMSXIBCT2hfBMHiesb9y3iP9OOnylQ==
X-Received: by 2002:a05:6a20:d52b:b0:3c4:5f94:f22c with SMTP id
 adf61e73a8af0-3c8ba5d871fmr8539281637.43.1785336533836; 
 Wed, 29 Jul 2026 07:48:53 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:48:53 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:20 +0800
Subject: [PATCH v7 02/11] pinctrl: k1: fix drive strength configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-2-2cb04b4fe389@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336534; x=1785941334;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ROR+qGCDwnxmrW5tdKeKQbw6hKqk4WyFrrTMRxwx9Zc=;
 b=ZwXInxAW8cPSpbslZo5VCAxTOB3PGhyWIqJawwugD2FuwgpcqQdpxNBs9O2HlfH7iN
 KKha8jb/7lynj4esxynBfWBrnOsHd4GpeyG3K/oDOlgdorr6cYmHwzrYFbyVwf/0VYHX
 PH/VYIPVFabFxjQCQbM2dWQpeVq+PXJ9xwpsoYTTZSl6/ZjX4j71u4nfIA3+RAlo/Sps
 LQQu+Y8CW43bsuRbYuX51kY7Ol5HPImFETcpeua+3wo8l3WspRE/1tQ+AbZJD4DvGhF4
 I1kx/JPNEU/VxjiJmWOWSsBIS1qBm6UgqkkWl5Q8aGoXwkRRUtxLIOaXFJRlcqjWh7S5
 HEXw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ZwXInxAW
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

Fix drive strength configuration by:
- Using FIELD_PREP() to properly set the PAD_DRIVE mask bits
- Not overriding io_type with IO_TYPE_EXTERNAL for external pins
- Returning the pin number instead of 0 from pinmux_property_set
- Removing redundant zero-initialization of the mask variable

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v6:
- Fix drive strength configuration.
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index a6a22eacac7b..6ed511879daf 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <dm/read.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -386,10 +387,12 @@ static int spacemit_pinmux_set(struct udevice *dev, unsigned int pin,
 static int spacemit_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
 {
 	u32 pin, mux;
+	int ret;
 
 	pin = spacemit_dt_get_pin(pinmux_group);
 	mux = spacemit_dt_get_pin_mux(pinmux_group);
-	return spacemit_pinmux_set(dev, pin, mux);
+	ret = spacemit_pinmux_set(dev, pin, mux);
+	return ret ? ret : pin;
 }
 
 static const struct pinconf_param spacemit_pinconf_params[] = {
@@ -406,7 +409,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
 	void __iomem *addr;
-	u32 mask = 0;
+	u32 mask;
 	unsigned int io_type;
 	u8 ds;
 	bool found;
@@ -433,7 +436,8 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		for (i = 0; i < priv->nr_io_pins; i++) {
 			if (priv->io_pins[i].pin != pin_selector)
 				continue;
-			io_type = priv->io_pins[i].io_type;
+			if (priv->io_pins[i].io_type != IO_TYPE_EXTERNAL)
+				io_type = priv->io_pins[i].io_type;
 			break;
 		}
 		if (io_type != IO_TYPE_3V3 && io_type != IO_TYPE_1V8) {
@@ -441,7 +445,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			return -EINVAL;
 		}
 		ds = spacemit_get_drive_strength(io_type, argument);
-		clrsetbits_le32(addr, PAD_DRIVE, ds);
+		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		for (i = 0, found = false; i < priv->nr_io_pins; i++) {

-- 
2.51.0

