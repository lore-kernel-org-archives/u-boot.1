Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A226EC531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69EC060A4F;
	Thu, 23 Jul 2026 13:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7AIUfT3XYEQb; Thu, 23 Jul 2026 13:23:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9AEF60A37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784812990;
	bh=w5sQMov4nVBn8gGPIWqmVzruZ74it58X3oUOi2NGyHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RkeKdS5jRYat5QmilJkDi55ySrgAJOOMrdZ1IBKf06MlcgIOo1LtuJQ0lRiFL1Tyo
	 h26vbsCyg8iiObtbu2oR2eXgmHD6VHFf6LO3YJJJKizArTFmidwoYw9ZFrhyIg63JU
	 QnJcAKWLxSaEV/2N/nvT5nEqxKIrjrozUKhzLLa+WrF67fnboDYQafL+Fzz4wzNMYg
	 PrIxp5YTjuG0KuoCtaNaSfm6jRtw+lrhbeNXfcrO3PNlCL/Gnbih4Y289VqaIbNaj0
	 N1zBHeNu44nqv+jw/rB23iXifYK7u1ISeV3gk63+pqOJdDIWewtTra87AvkcwJTtIa
	 99962jk2CsJew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9AEF60A37;
	Thu, 23 Jul 2026 13:23:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AA97EB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07F0F40085
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rX1wipN9pJZW for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:58:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=fugininsane@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0BE9540026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BE9540026
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BE9540026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:58:34 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so4146785e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784804313; x=1785409113;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w5sQMov4nVBn8gGPIWqmVzruZ74it58X3oUOi2NGyHI=;
 b=ernR7deQIEnzacLU7+9CrS73RbW1ztLfLLUGdlLrCvk32KJ4It5iJ5SDyXuDI6cD6N
 wcPBLX9mHvqBSh6hEUWtH0i1tBXwuOWqYH33T2bLpLphJM2J+lCeaPTbcd17pTXRyAWz
 SNG+Hh1MK5tysvZPka2YMmAtZzPpd3Rdd55yONZftooz+5MgaiAUBkMQ5sREfi9eJRIO
 1AuqT7o2QhXxmmqRGsyTwgwtqo625ZnBSIB/bmydgnZm+XTgtSj40EryySfu50rVCrOw
 DaA2QcCYqTh7l/Dp8366B2BTCb9rn8rk43PMg6n6baa10N3FxCUNG4wOUrhRV8YAlps9
 bS6A==
X-Gm-Message-State: AOJu0YyjftAWCfvCzG2K1vXVCEAgR+wsy6NaVoZWBcoZtRCD2IS3zPTh
 809RdABL8OSLmfHj7aajSw7jldSnXH52UJgEhBCLro9WM6K0i2RErmat
X-Gm-Gg: AR+sD11KRoiJ7SKUNH0uiWTJM01vouGtLaoUrVkvDwmK0UedKsHPqFSTg7xUP208wXP
 Tlr0b9ZXcSl/+w1PfPIidrhXzUP+VRYoXffypKkFXVK0+1xEhvN7dXBr4t8Z+3eAPi0HXurJXvs
 z7zhO4yiJkevGzV40KS78vBBhGbI0KuIAJ6NQVdZCzdbC1pzvq5RF81HI7mqXr/pigmagSwbH1q
 uaUso0Cd7ZjBAuCoHK5emTkWfSx/azG3SJIgcB8sSG/0yuTwBlmmIVafhuoi3Mba2pWzIRvjN46
 NbgG8Jbkka92KpuRNydjQkIpbYIr8OCwwHOO6W6pM2UTiUokoA7YWaddHzaJ2oJC9Ch+UMz1Ucl
 fOtLrznXP1M0cFYAhRjdu02xcyydNTqfZX1olgHsdYusn3bto+X8f09p/ZJC9iQFKLF73XO+ZoY
 ZJhJ6OcZiCHqaFSi4z1ozoLteQ
X-Received: by 2002:a05:600c:a210:b0:495:5044:d37d with SMTP id
 5b1f17b1804b1-49573cd9403mr17860485e9.19.1784804312692; 
 Thu, 23 Jul 2026 03:58:32 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:9e3a:5128:fb39:796c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a634cf9sm154119915e9.9.2026.07.23.03.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:58:31 -0700 (PDT)
From: "=?UTF-8?q?S=C3=B6ren=20Hantel?=" <fugininsane@gmail.com>
X-Google-Original-From: =?UTF-8?q?S=C3=B6ren=20Hantel?=
 <fugininsane@googlemail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>,
 Claude Fable 5 <noreply@anthropic.com>
Subject: [PATCH] sunxi: Fix misspelled NCAT2 config guard in gpio_init
Date: Thu, 23 Jul 2026 12:57:05 +0200
Message-ID: <20260723105705.3338923-1-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a93b75ce-5dd1-481c-8de6-06d58e6d2715@arm.com>
References: <a93b75ce-5dd1-481c-8de6-06d58e6d2715@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:22:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784804313; x=1785409113;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w5sQMov4nVBn8gGPIWqmVzruZ74it58X3oUOi2NGyHI=;
 b=MT+j13fFptv4si/A49ESrWROfYkiQxkWrA7KoNqG7EA0gFzIVSVOLJ44rpXyZ7bEA1
 m4vu1AXHtVPLuTxTqDHgGD0l+5OMd9hQRhdJopsVtkZ0WxMf8yQbM8y/qvWHpiVHuqQj
 XXIm+B8iqbL63+u1ej3CAR2FsdUXRIaW3BGIvG9QySYhv1sEBlTAr4pSUH67PIXaU/2q
 I9+7EtCBYKatSr7RGt+o/u98N73SsdyV3WKbFxQnEpiAqS5V5/RbUoU1YONlYO731J5L
 O7W6G8fOgAeh1Cuw+hK/dQrrcHcphWa8ebUtGPgAh7oAqKjQmlLeF7R688I0GI5XQBm9
 Z9jw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MT+j13fF
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

The PIO power bias configuration in gpio_init() guards on
CONFIG_SUN50I_GEN_NCAT2, but no such Kconfig symbol exists - the
generation symbol is CONFIG_SUNXI_GEN_NCAT2, spelled correctly by the
28 other users across the sunxi code. The typo mirrors the
neighbouring CONFIG_SUN50I_GEN_H6 check the line was modelled after.

As a result the condition can never be true and the power bias
registers are only programmed on H6-generation SoCs; on the NCAT2
SoCs (R528/T113, A523/T527) the block is silently skipped.

Use the correct symbol.

Found by a systematic sweep for CONFIG_ symbols used in sunxi code
without a matching Kconfig entry, prompted by Andre's request in the
review of the similar A80 mclk offset fix.

Fixes: 4a9e89a3e390 ("sunxi: introduce NCAT2 generation model")
Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Sören Hantel <fugininsane@googlemail.com>
---
Full results of the requested sweep (all CONFIG_ tokens used under
arch/arm/mach-sunxi, board/sunxi, arch/arm/include/asm/arch-sunxi,
include/configs/sun*.h and the sunxi/allwinner drivers, checked against
all Kconfig symbols plus legacy #defines; plus a second pass expanding
CONFIG_IS_ENABLED() arguments):

- CONFIG_SUN50I_GEN_NCAT2 (this patch) - the only misspelled guard
  with a functional effect I could find.

- board/sunxi/board.c:218 has "#ifdef CONFIG_NON_SECURE", which is not
  defined anywhere in the tree (only ARMV7_NONSEC exists), so the
  printf branch is dead and CNTFRQ is always written. Since that has
  apparently been fine for years, removing the dead #ifdef would be a
  behavior-preserving cleanup - happy to send that as a follow-up if
  wanted.

- CONFIG_IS_ENABLED(SUNXI_LED_STATUS) in board/sunxi/board.c looks
  suspicious at first glance (no SUNXI_LED_STATUS symbol), but is
  correct: only SPL_SUNXI_LED_STATUS exists and the macro resolves to
  the SPL_ variant in the SPL build, keeping the code out of U-Boot
  proper as intended.

Everything else the sweep flagged were substring artifacts or comment
placeholders (CONFIG_AXPxxx_POWER, CONFIG_FOO and friends).

Compile-tested with mangopi_mq_r_defconfig (R528/T113, the affected
generation) and Cubieboard4_defconfig.

 arch/arm/mach-sunxi/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10..f1f519b7 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -199,7 +199,7 @@ static int gpio_init(void)
 	 * detected value.
 	 */
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
-	    IS_ENABLED(CONFIG_SUN50I_GEN_NCAT2)) {
+	    IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
 		val = readl(SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
 		/* TODO: A523: keep only the lower two bits? */
 		writel(val, SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
-- 
2.43.0

