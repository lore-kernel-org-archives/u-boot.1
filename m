Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098FAC624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADE2E810E7;
	Sat,  5 Sep 2026 09:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qd4KRd9LErYK; Sat,  5 Sep 2026 09:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B737881004
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599654;
	b=LFPJFCV5+YqhFS1oiKzOvinERqgFpFrdEgxLQQPK7QW1y8bpXZmrb7+38hMZUN+thOI+
	 AHVfznSjN+28rY50JM5FhW7turGObfEq51JKO/3QUxdiIVOiyHG/12SKt0sTfjRV75sJ6
	 IyTY8M8DDLuRnyEtvJwI8SWed7DsWX9y7duTLJ93W26vS1/8I7pzSv4xvITYkXppn2HS+
	 lxANxMHvrAOcc5qtmtIW1aKfoc091amH/zZFM5dUvhSXe1yUVaVVZxEXnjCW1w+QTgoLg
	 ryVFgv6nohb9pxF1diijMaXrLCJS7rIFHOg80gjhC0EKc7ceaRcGxq8DPzP2hj6ZSPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
	b=KlUt/TSBTg7zG1YiXetaomHJYXaDwqId4IAIEtjD31ZG1FZSnLxi4+Kk9sYqhw6CqQMt
	 8Behtw0w80MrRDPPGSfZoDzFRY9o3/+K8cxy7Mf35kLsx5ye4mGonf1iNnbiobQtnZdPO
	 F1t3hQZLt7cVYzNSadySGhg316qyoXGKtz100Reoz0DqKHALhIrFYa/4ZYjcRYWZy7gBE
	 MO4cbxTCgDCaD46XZzci895ceschmQK7O3igz2JVvic9aMuSKKy3UIbnIoNPAAyIiyJId
	 BSy0G7JFHRmFLNckeWjC7DWot6sa9oCn9TxiaQICRjLI1NgnX+2rJ6U4WmJV3taLq8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=JbviSHON;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599654;
	bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1tO4bGJscYbeTnw1aDrcImVqfIy7rHoi8TO1drHsWNmtl9sziWqbmZ8o/fc7TVDn
	 8KqyVqBc86r6zIQDVdIp41S6gcV30ZKfXe6OQUssMT/FlbV7ZfxAFjCBSfXTPJrmFu
	 kT3GNOjgQ+aaBLXYMIogaGm7v0IV09xTih81bO3A3BpIPw5FyLugWQ0VRVmRqhnt9H
	 FvHYE4Lxhma/5jUu3SeTBPX/DMdgNmFfxY23e0OfSrzbxoN7QDED9Oo+1ctyW+LB6H
	 N2iwFYEnjScjf1zVtYwQaRHZqpZnAiVg6xUAojdTmBJe3O4tTV1G9TSZCApO17EUHN
	 A9GjwqckaquuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B737881004;
	Sat,  5 Sep 2026 09:14:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECC11B88
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0BAA81004
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Azavuv4_Om-M for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E0FFB80FA4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599653;
 b=iFPYPt1U5xF/MXECAVoj1lcybQ3rdSAjU2lqc/k9WL6IwVL5aqLQtVdzy5RrEJLrKeYn
 CUXjhdUzT/BPRgsAh1Qe2dOaKaD9b/5GPIp3LpHMtjUQn9jXDM7i2nz6eXkrvg95xptow
 B8vrHU8SVehcAFncgFptDx8t2wYdafngn24qAdGsURORVFElMmCHAHBoV0tnuDEHGNSyd
 ZhIoALHIlNobl8sYYagUCqHwEY/dGqoDGTyykI+8ZZw2GN0/NZeISQ0QM1INvc8IBxVHr
 09JcMSNi7x6xpwfkZ6l8ANvClR+n+1FV2DgvJVBj7q3yS+jdUOrearsQqWDnToLNgMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599653;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
 b=aF9fIShsI17Q8Nw6UaXYaRmLqKRsM4beRlkho4nfmvv2rJq3EG+wf5t7AANGbXzsWsSO
 G0tO85DZhqnEKtmGT6mNclbb6eMz8Fh/Tl0BKxjNWxEuBMmGfufMtlNQkFv1VgKaSdFgi
 jhzY1xRgVY/UlOmqLcLp7jErGWr8KAKIpfCFFYX6lUuRPQvJd86EXWSKUVuUICh0Cwyjp
 7k7QqO3fYi1FIUUzsEKNnEfPB/N3FqKjwHEjaowZT3poK1fFeWqELpNepkTdn1pvffozq
 ZjbXrP9TM78iZr0HgGCuQkl1phZqJ8gAmcYGJDIjGQOnIPkomvUGrZJiXUGtGTXJ+dA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=JbviSHON; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=JbviSHON
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0FFB80FA4
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:12 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-39647184c73so2838907a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599652; x=1789204452;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
 b=JbviSHOND+RZSjEsPxzBeCwnvToMaKi/uNl77Hjf+QtAmGDzJFuNwHZK3TkdmCMPPe
 TFqnfWOULC4jnL14MnxFcsxmdyq8ssxuxFUdwI2uliSvJXr1PQDxOwVufflBsTCkZRVj
 DP5AzcgcAZaANvR38C8I6XXj42Y2xQUoF43QdFFBivIO45vP1DrR+ndZlxoyearSCF+0
 jJ0NKeqdoTP0/cXY7gEEVND/qejj8Tf46AyDqskzdxaBX/2gqgRAEpv6jCYQ0vb2oq09
 3NqlnWWA4vQRc6gtOSNjZEPCasvYt6/HxRGbMS6LEIhKs0Zj1j/eAMxfWSG/E6LXpH8+
 CZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599652; x=1789204452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W7cL21lX8JIoKprcVe0rIw71Y9TY9Flo3QzGYENJ0pk=;
 b=qmUmrqm1RhncOMT4fvFdPXE9nfFUJq7tni9llbNXdCVMTbevEV2qFi7O6tz5G7ph6g
 KYAL5QxfnU0Bh6H18AbsG+YDtE5NGxMqzD8Nvk2wplWcRxLK1h04l6uvDl5VbpC8eXmp
 x8ThqpilGAcD/gEJ4Rb7WyWs+sizedA8K6ZpR8P96L/8UrMZOfy25N2DSUG6pRY0lFI4
 A7iIEe0o6C4f81oi0C07SGf5aywb1VLzhzOuoPypnPofq/aQQevPWD5v3yWTLO1Exxo1
 SwmJCKnArXRwFdbktpjyK+gwMS/4RoVrmLDZt9asW1QZPBePFpHtCiadk35q3WAwlx+A
 DVZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0TShcvxefHSap4hMQl6WfL/6FXRxmz/EAczFslSUbPtmEdD5Cre9lFz2W8NAHObG/JVlGmyI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mLZmGIX7oVAaEQ66TaQ+C/1fSnS1tWWDdqUfjzhGozf8NG0vQT
 WPkEDuA4Oyk4DNbAKK5B5dwsyyIARhdU8ubLK54+xYAZYYDCH5DPMSq70CphoEnYfzQ=
X-Gm-Gg: AYBFou1ooQeXwU8ToNjp2ItQ7g2Mv7X5Dwiuk65eX/i30koK+4/1xrpi2WHRRumWsUr
 bZZhpBIQc/bdSYhU/h0so71cpOYv48WC+WVfvW2SKJuiLZ5P5YCU1j+d8cNBmGa/SYPnw9D76mk
 XBtA+Btm8RZyg1vFp6oc4WByBd8J2xvj+dkvu5jpzUEUj8fmHuzChzn3AOR0/3i8hKKTgPzNfRx
 bUb27MrzcpNE4434X/rduIynwbMOeq2nSRJ60aHUV0U7MhS166TVUVRPEwSriVFWc9HJvCyj+3F
 t3uGToggqHwsj5M5Ux5SJ0WjLhZR3eQs5ZiU1BhzMyKZA7GzgoqmvddHBDzgIczk8tMKMpnAQU4
 Rd6m/WEi0KDmhjrguB93F+NC1+27ILlxk1R7SOdStzyVhepfz3mR0DVxV9vXosirL9qTF1GcRAY
 ShOx92qLArMAVPtl1M5XajEK2lyrbL2LYO3ouLmJZs7liTL2bCzrDYvSl0lkViKCknOWn1arAIg
 PRrt2wCit/rAtepFzInGtHw/WtU0PMqltT+3h5HqTV+m2U8hz9yAN7GTj6yXdvQqqVrpAq/FPyM
 XPBc66CI/5sTXXMJJAKDOqXEsIQ=
X-Received: by 2002:a17:90b:5242:b0:381:10a3:8b10 with SMTP id
 98e67ed59e1d1-39b08046aaamr21080150a91.14.1788599652015; 
 Sat, 05 Sep 2026 02:14:12 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:11 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:18 +0800
Subject: [PATCH v11 05/17] riscv: dts: spacemit: k1-bananapi-f3: add SD
 card support with UHS modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-5-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>, Anand Moon <linux.amoon@gmail.com>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>
X-Mailer: b4 0.15.2
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

From: Iker Pedrosa <ikerpedrosam@gmail.com>

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with GPIO_ACTIVE_LOW and internal pull-up
  support
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Link: https://patch.msgid.link/20260515-orangepi-sd-card-uhs-v10-3-094af27e310d@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: c76e2f058cbcab84e4a703f26857a58bdf6a0042 ]

(cherry picked from commit 3efd965004f1604c204001dcead9a44f729d5d58)
---
 dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
index 9429189354d6..9beb8947f12c 100644
--- a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
@@ -17,6 +17,8 @@
 		spi3 = &spi3;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -221,7 +223,7 @@
 				regulator-always-on;
 			};
 
-			buck4 {
+			buck4: buck4 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <5000>;
@@ -242,7 +244,7 @@
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -374,3 +376,21 @@
 		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.51.0

