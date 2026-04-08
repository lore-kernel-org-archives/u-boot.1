Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D18810FC454
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 22:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D95B84099;
	Thu,  9 Apr 2026 00:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="mkut9WoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A91B184120; Thu,  9 Apr 2026 00:09:54 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F94B84099
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 00:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82cd70febc7so210363b3a.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775686191; x=1776290991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wh+AjOI1neGCNksUBRwhLrJZffLtfeFK2xp9XDYIzUM=;
 b=mkut9WoTOhkLzcLkOzOlS1Be8w07Yr0N04qbA4JVFIS1+sRFHu9skmz69Vbt6Dd3z/
 0ejSamlJI2VzqF4rQbJ65aog3jGxZz5Ra6/ROILds946EWHbUuT6M1q0A6TvMUUHFUTF
 hSQ7tMTL/Ngy9H1Jk3JVCwGnuyEY7f8oq+Cww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775686191; x=1776290991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wh+AjOI1neGCNksUBRwhLrJZffLtfeFK2xp9XDYIzUM=;
 b=bgK5r2kx2e9liY7ow85vxM1CNF/yF07rITLVUpdSDkWjOqLbiRussco5MdrxAeRvVH
 uu2q7eTGm9efoiSfLGzOUpSEnR6j46pyPIzegHDZASBNwbT8uXSM/sNxacpHjkJT2Qo8
 4D2KbvdDlyFDsFJiCdeiWx04W+Tju7yQNacx6uYPaqPMTw6eIbZKARjdCe3vH96jrc2U
 TvvR4r/cRE61C8w95mtQsbRhhC0IE/dw8XcgAih323skbl2lycbaoHbkBcguHnIsMAlQ
 CPXUxJLbh2k6X+p6J3j6mOe5hOqqzNyscaw7Y3Fdmn3hTeGqxh++0dmyQwfWHeflw4qv
 wfxQ==
X-Gm-Message-State: AOJu0YwJH8OYeWb+rpYalklxFG6RVPA5pp+kIt/zcs0ZytzX1uYJVcz8
 0d/0QNzgRj+i4kqr2vGNGbO5l4yDMOD442p91XuorBDW+s2tC3ERzAi6kRFXtnz8rmI=
X-Gm-Gg: AeBDiev52u3UkDdnmEd8WIwdrBgFugNImfm5VtE+Td4zoW5cXhw21F1ibMcA54FyRz3
 4D/Ub95OKcByIaOiHzSrLiWl9kG7ZC6r03v4AqvH4wReSNQo5zG1ybue0/uW9Q5iJXI884AVW4k
 PDYtUuKRNzuMGCD+JfWzHNWVvX6EtJ99Rfb3rUf0Nnjtl765vxUMnVuY3Ii3tt/TajLu9YA4AnG
 JkRu8rRL9NNFZxSh2QLYUegrqdV+wBZO2MEp9gGtBv2FxXcItIJ6TMTaK1G+Vczgby7NXg3DYxU
 lySqRTGqRknZylCwZ9oa/aryO+pHTptROnNlKkGyfkE9wWQvulxvDxoVCyOR0Hl5i46z6aXKt1q
 mQQtsynul47Dc8AochddTeT3OWj6vN33SEVdayzIXVZMNGEUr0x2X5F7yTEd9E37mhtU5FF6C5c
 pXKWOYaWwf/JGKYcZHoH9uZ2U=
X-Received: by 2002:a05:6a00:e06:b0:81f:5037:a317 with SMTP id
 d2e1a72fcca58-82d0da2834dmr23045091b3a.11.1775686191008; 
 Wed, 08 Apr 2026 15:09:51 -0700 (PDT)
Received: from kinako ([2400:2200:7f0:5ee8:dac6:2cde:760c:93f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b60199sm19877723b3a.25.2026.04.08.15.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 15:09:50 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v3 1/5] sysreset: qemu virt: Use __raw_writel()
Date: Thu,  9 Apr 2026 07:09:24 +0900
Message-ID: <20260408220928.3328551-2-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408220928.3328551-1-daniel@thingy.jp>
References: <20260408220928.3328551-1-daniel@thingy.jp>
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

The virt ctrl register seems to be native endian, currently this driver
uses writel(), which works by luck because its currently broken on m68k.

Use __raw_writel() instead to avoid breaking this driver when the
endianness of writel() is fixed.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
index e7cacc9b6e98..5ab16001922b 100644
--- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
@@ -38,7 +38,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
+	__raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
 
 	return -EINPROGRESS;
 }
-- 
2.51.0

