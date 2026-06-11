Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0918CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F064841C2;
	Thu, 11 Jun 2026 16:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qEdvl+mB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B4D83FEC; Thu, 11 Jun 2026 16:18:53 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB46084671
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-51761d27612so93327151cf.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187530; x=1781792330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pKiKVio5u+525yNA1dnCFu5OSeJuirbD07ZacSsyTc=;
 b=qEdvl+mBhNEotwZ+C8uyPOE4lgkfWc9q/QXZI9ENZOAc1SELJJbdRBUU2DJoHE2Ied
 QMocUwEnFXhPImW7veO4wRPIGDG5sNSyFjugPUktHogW9UZUuTlsrEHhTNChRzVaFBFY
 TyiL5mhckJfe2NVzO0xHto+ywFL+WPBh8X88YdhuTIdBTgthYU8kJdX4MFs/DirPEPbp
 W8gXJVzvgpHM7V4sx68tp+f7Ps+7oTI8XiIXasnXbVM9myASq433b91/+xFsu3BuVmPn
 cj8xbQGxov3G6yxqU4C01CLvbloqt9ePGjW8TxuV3SYnCJpUZvjODZ5s7SGvzqM1b2sX
 LJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187530; x=1781792330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/pKiKVio5u+525yNA1dnCFu5OSeJuirbD07ZacSsyTc=;
 b=MMiNmeq0VXAUZtwiokAg88sIHvXxOaekX5Cf3dR/hHGO7I+cLgFoA+ob1BgsGvByx3
 Mkrw9dE65q44MqAUTmMq9gpKCEVna9gEeBQNO4C1/m7cmuZsfDMBfo6rxE9V/irFn7uu
 OfP+FATIOVREvI4vALEsDwo9Nwdx7rccpvTks25vQVDGWzssUHK/5UBSj6M8OOchg8Gj
 bzDkVMwYx9yZ+Qr1jyCKHu59LYxIeJRaJ+t7g3MlzT+jnsk98qRllQWxlNQiQB9Vf0M7
 VnRBBP1yiWiNwsLLck3yckpFF/gfErw+JU7VS+2zZmBbmv/kIspXZT+XFD7paUhobSrg
 +KpQ==
X-Gm-Message-State: AOJu0YyY5B56a/lZs1NwfnQNvaFmILZyq6oo0gLgcD5fMxjUm3snQSeQ
 2qdrOtfOnHRfQTi6culFViUyJbntTjV7cWBNClQnYKcvg6+ywOTXTI1ue2/J9etS
X-Gm-Gg: Acq92OHJm9i9fYs65l56IfUIclk3JnfINfFJsUfJ664WxFcHYfCV2SoSViLVTSYVC9c
 5NDmPNM71Yz5HtmpvmG1ulZUUpvNh5nHSs+wwI+fbEywsh6aHwcicacHj3S/hH91bvP2xBUM52o
 Z10rdcTWLyQ5ITcBK5romT+8EMLku8qGMP2UQDFk1DUHBpCTaQxPaXJRQNuURlocJOv2rwQ3kbu
 GWQS78+vhwbOxbKbY40mAzW59lQnpIMvQvrTWSTJZ4NjsmDQgpkn72KIP7rezB1ZzbyhPly6G7n
 jTr4YS+msGwQuOfZYDQJk6FLwMsTJlySnOFo/khf6NNBE+sIZWSUvKPu4NxvCI2eQq2PcQpR9xB
 oGvgYKIBYFp0LOoivSQ3KZWvi59bMYY7pnYHRBKTTBd2J+b+p8sHW4qrDGO2i42JX++ynVvJSyF
 BsIz3aYmwxAN7hD/jhFbqYJdmc4rH7h52fxAyTzVmi3LwmDSb1M65ZGxIIAxT2zCEfgytSSiCdJ
 D1drz5DL+tq2rkgYUY=
X-Received: by 2002:a05:622a:1b91:b0:517:9d3f:8f3 with SMTP id
 d75a77b69052e-517edccc410mr43310541cf.5.1781187530125; 
 Thu, 11 Jun 2026 07:18:50 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:49 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 9/9] configs: k1: enable pinctrl and gpio
Date: Thu, 11 Jun 2026 10:18:11 -0400
Message-Id: <20260611141811.68904-10-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
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

From: Guodong Xu <guodong@riscstar.com>

Enable pinctrl and gpio configurations for Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- Also enable CONFIG_CLK and CONFIG_CLK_CCF (U-Boot proper).
Changes in v3:
- None.

 board/spacemit/k1/MAINTAINERS | 3 +++
 configs/spacemit_k1_defconfig | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 8976c575dff..32d47ecc8f1 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -3,9 +3,12 @@ M:	Huan Zhou <pericycle.cc@gmail.com>
 M:	Guodong Xu <guodong.xu@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
+F:	arch/riscv/dts/k1-*-u-boot.dtsi
 F:	board/spacemit/k1/
 F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
+F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index ee47c05d923..81409c844a6 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -49,6 +49,8 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
 CONFIG_SPL_CLK=y
 CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_SPACEMIT=y
@@ -59,7 +61,11 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
+CONFIG_PINCTRL_SPACEMIT_K1=y
+CONFIG_GPIO=y
+CONFIG_DM_GPIO=y
+CONFIG_CMD_GPIO=y
+CONFIG_SPACEMIT_GPIO=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_SPACEMIT_P1=y
 CONFIG_DM_REGULATOR=y
-- 
2.25.1

