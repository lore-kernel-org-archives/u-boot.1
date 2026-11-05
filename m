Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FC606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jBJc+T64;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sn13F6YU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22FEB4064A;
	Thu,  5 Nov 2026 15:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9E3BjXleAb78; Thu,  5 Nov 2026 15:11:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68084403F1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793891487;
	b=aBXFWTNkPuSS7KQBb7N3wlLJ9vPY05q/8lgnN49N7btBCjLTBx+CQRuVBIOo6KqyO5St
	 U+0YiMLxQyBg8SHxyRr4RNw29BVriJruLitmZ0FsomAWp139kvBtvHeHgU5GwlDc8YEGy
	 AwDWjEL9kr3aDCV8a/Q+V7BKy7uq+awitSyfxslHTxrh012Cyu9wIOVJIoA/ODBPek3qW
	 KRidijXhrnUHcVDf/L734lSGA5HuEpxghAU0wrc7Yp8hrRkuRTRoomzKx1ELaLJtU27gV
	 ps08DJGEVkZsXwOLjD6PDLD6ZQnVk6287CEnZFswTCiMt3VA10jJ6/U+Io62KlkyGeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793891487;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BWNuO7Y0WROmU+y5vDvH1UzbzGbp+mBtLt8x6B0MrQk=;
	b=ib1PIJrW6kyMthNyXR/nbxVn56PVu2+mLU5o5jrJeVS11VrdcWBRqXqyBdKzb1B5SKLc
	 KfHLbXKix+ST55sgszFopUSuERBIGMBohF4VY6hwo9SJSy2NrYYV4NQE0VkZTlPouAcOy
	 WGha2At8r1po6Du74eoMuGZLw/g75qCEiJzJOzBeYqt42AoYgUwSaO33Th6OvkbWkQP43
	 ZCbFJBy6KPjMpRKwYYa2JFx3tvsREkJKjIiHsXklUjPeT6TONOc5kYvGhOJIBOheLs5mI
	 fj0bw1rVXJi2EY76CKB8bzR8U9v4UncnewSdaSEQciq3IhOg2BH54w8b2xLfp6u5q9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793891487;
	bh=BWNuO7Y0WROmU+y5vDvH1UzbzGbp+mBtLt8x6B0MrQk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jBJc+T64uizpKN/YOwxCUiGOMsV01o38PiTUNYgFZ3o/x8934CO6B9fFk72fvfc+F
	 aWEwrJvPVQeCPlVO4NDq4fI8vXoiaJyiMaHyWXFpAQQmfFtDB3FJW/paKfCt2Y5yMk
	 cQlMqfioQIbVKdKfJGBfzxcsaLi3DItWss7KZQmxVJ6kTGvvJWgLWR+ZXodklBiBqk
	 kCVOHy1tvHMrkvqejdaypdiEiukzW0YBjElXYMJ8qdgCNfhmKuDgj8blZRqs+VxJj0
	 VfHulbmqNTsCJ83NtXn+RlALUV6LlLEHOspxeQzpbv81sC3EEwwxLIaJRS5CSuzhTO
	 K7AGQTbeqTyWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68084403F1;
	Thu,  5 Nov 2026 15:11:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A3C137B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FBA480D9F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jbAOeZhDPoaA for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 15:11:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C45D780F70
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=macroalpha82@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Sn13F6YU
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C45D780F70
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:11:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7768482A; Thu,  5 Nov 2026 16:11:22 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE5884820
 for <u-boot@lists.denx.de>; Thu,  5 Nov 2026 16:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6dde81a6820so1270315eaf.2
 for <u-boot@lists.denx.de>; Thu, 05 Nov 2026 07:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793891474; x=1794496274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BWNuO7Y0WROmU+y5vDvH1UzbzGbp+mBtLt8x6B0MrQk=;
 b=Sn13F6YU0BZh5t9uvqDAesvOqL/uccIOiNLlDGJ1i/WaV1pnZD47fvG6QztqBe47rL
 +IyPFDA1FJ3Jln8xDiwksfASnGuxfQ+97VK8SbOhTWa6Z5Twg7g5fJ8LZm+U56M9UnyF
 9CHpnjLpsCIVy1FSZKJPgbX7vbQE8udMmDXJeoh5zpWtHiIEjbvrebJA48bAABMbq0Ef
 ZfGA6doGT5wCR7V/+Rlqmsfkw5lMKsIFuRBxqx9KOifMAI7DLPAJMzrzCR0VDYFovOoR
 QizrgliWxxQFOYNyS8Yps50TVfo9fgNJYuM/Ro8p4Nrz7QFqfv7z87ltUkgclUCRIyeN
 UVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793891474; x=1794496274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWNuO7Y0WROmU+y5vDvH1UzbzGbp+mBtLt8x6B0MrQk=;
 b=0fmxTlU1iH5Z1kWT04eajJKnMNSxj/CVmcOjcy4ngCEhxtZZXQMnd9WJFoQL7R5zmk
 yJgvfs5Hbsoyx+9GlPC1u86RtwTQRD93ZpqcOdWbzvZsnpsZv9izyTLHrJ8UgkVd9Te3
 uo2eCsUoeKLnhKcOPXEnX6ZKaWEbD40xoW9Ho+yao0hm7jZcJ4mgYNVT9qvr0UjYKH17
 q2w7hg0ysnnv+JYfWF7AUr3BhFvvbW2GKh9h3GrtyPERladp+Y83yfOArQOBWKAEDxMf
 JZjqmlA50DLNY1fCld9MqJbnTfpSnMn7ssfjTtf5FcbLQfuDNZKHb6IxpwNoPczyTyJY
 Z/CQ==
X-Gm-Message-State: APuU4Z8gRyTZAAhilJOxIBxlsYh575nhe7OjGy8YrpQq1wFQWbcnofc3
 SwWswWjpi+6kZCehGXDMoeBn5Zydbxek3gANCdQGuecMQCxJkKC0j5ZwAN/mOgNg
X-Gm-Gg: AYBFou1OAIDp+B90DZ4cYUsZWP06xOQrcVAhIIiBLvEWLmANaFtfceBiBVU0AzyGaPb
 WJdSTgyquJ6qsfa7ed5ZBfLz8Buecq6p0+pRvT9DQfchu3LLBeIqFGTLRHDTPEbWx5hJbpllNNj
 eRbB+og4joer8wA0FKOM7dxSjlhJ+6VNde6WhxpK/JkM00zt0r7/tXzJNJ8a2ZKWlk4CIZtFoH+
 kdyPscK1zSy0UOCk+f9/uJcUqo79seQ+wNhTHSX9A58J2hEW/9H+bKKdKL4lSYmTFI0kTWwFM0g
 uNA8NfZfVyBSlolNkKgoA4zh7CaeY+C1AzCwNu0ku89qvMs47EBe9ToGrxPAchMgazygYJo7BHb
 /0WPBolmFDxji9cGFOxpfwWLFTNpVv0ICjECIw36hiKhCJ9W5TqMxEySQzCO0W9Ys0kBt1p1IIv
 ltFWgvTSEianhg7rzYAA1vXd3gDaSpVfqOltxpNKBMwK3+1nHVts/rwWlscKYRKqhGxrA9W/5j8
 jCRjVVuv9b3u+6N/g9NetXyV8uD2+S+15j27P523UDdAB3218HXyGcfcLVkfEJ7MlRg9HeA3mBJ
 pVOcF/I67OBEz26hBJooetKlK82GqA==
X-Received: by 2002:a05:6820:221a:b0:70d:7aa9:8618 with SMTP id
 006d021491bc7-714f256beb5mr11563687eaf.63.1793891473639; 
 Thu, 05 Nov 2026 07:11:13 -0800 (PST)
Received: from neuromancer ([75.28.21.198]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3a1a6c8sm4718635a34.2.2026.11.05.07.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:11:12 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, clamor95@gmail.com, trini@konsulko.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, chenjh@rock-chips.com,
 zhangqing@rock-chips.com, kever.yang@rock-chips.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] power: pmic: rk8xx: Don't set RK817_POWER_EN_SAVE bits
Date: Thu,  5 Nov 2026 09:10:57 -0600
Message-ID: <20261105151057.477529-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chris Morgan <macromorgan@hotmail.com>

Don't set the RK817_POWER_EN_SAVE0 or RK817_POWER_EN_SAVE1 bits. These
bits are not used by mainline Linux and actively setting them in U-boot
interferes with their function for BSP kernels, causing systems to
hang when regulators are enabled or disabled incorrectly. [1]

[1] https://gist.github.com/fr0z3n-cs/047b24a6fd430e816fe02a877ad7ab8c

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/pmic/rk8xx.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 95b71d2fe49..16b3dc7cb1c 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -251,8 +251,6 @@ static int rk8xx_probe(struct udevice *dev)
 	int ret = 0, i, show_variant;
 	u8 msb, lsb, id_msb, id_lsb;
 	u8 on_source = 0, off_source = 0;
-	u8 power_en0, power_en1, power_en2, power_en3;
-	u8 value;
 
 	/* read Chip variant */
 	if (device_is_compatible(dev, "rockchip,rk817") ||
@@ -293,15 +291,6 @@ static int rk8xx_probe(struct udevice *dev)
 		off_source = RK817_OFF_SOURCE;
 		init_data = rk817_init_reg;
 		init_data_num = ARRAY_SIZE(rk817_init_reg);
-		power_en0 = pmic_reg_read(dev, RK817_POWER_EN0);
-		power_en1 = pmic_reg_read(dev, RK817_POWER_EN1);
-		power_en2 = pmic_reg_read(dev, RK817_POWER_EN2);
-		power_en3 = pmic_reg_read(dev, RK817_POWER_EN3);
-
-		value = (power_en0 & 0x0f) | ((power_en1 & 0x0f) << 4);
-		pmic_reg_write(dev, RK817_POWER_EN_SAVE0, value);
-		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
-		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
 		break;
 	case RK806_ID: {
 		u32 rst_fun = 2;
-- 
2.53.0

