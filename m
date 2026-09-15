Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D2BC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ADD080972;
	Tue, 15 Sep 2026 15:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wMyQy5_xqKLU; Tue, 15 Sep 2026 15:00:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4804980A87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789484410;
	b=JWkVg8ya3nGggioPYY5ceR69Tgen6aWaldm+VhQvwX+vMm8oVD5hzey8ZsXgSvwngufE
	 tr0ftv290ZfnEk1rUyKmmRyMoPFpY/wIYYEkJK0GmNNBvYEj7fwCVF/V1d1lqIdvFH7kr
	 fuMvbpXGBCndYvz4qjXOiK0UBdWqVVQYCV8cw9Qb4ezA8sip7Lu5HU1Q/EQdwacgEdvO6
	 1uoqYHSRjT0Way8vZiQz/oK+luAABmkvXkc22A+UCozSgk42FQ/cC+6d81v8mJVBYpHsO
	 gQZvCqxNbZqQfweSAHGklyDWL14DoZsmPiu783mYO0Cng5iwbHtgMY+Mrgu+AYCGJ0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789484410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
	b=KZQX/bRXNUThXEzM1S4CslVX5PRjWILE2lUuL6mXyFgpirM1Fafb6/4H3/58MgA2z9ds
	 G72F6N41wCmZ/ZAthK03AVcgGq7D/zZQVU7BGpZmYZdqsEtU3TA15Y5z6h+0f2u4yoP2l
	 YxMglMFXSZta4hbeAI9206l9Rw3yOUcQ+zMdSHkhrmaqm1/fcMfUdzp1w1dcPL0rLvDmt
	 XGbQDD6h/DKhJt06bek0bjDK8GCNqp/mQv6Cld3gcwJDVvNzBGPh55TYBmFKzFEhLV0aN
	 EROaLVNRUtAuobpISPPrwozK7gvKic5jeeJnjo12lzadBcMo/gm+vQw0EfNHLabakkw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789484410;
	bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZeMzSZbFEnztTKtTOJXefwzlnwiLtPZ25M8Zbq/sB9uY979YofKQJzpXGtK+mudcc
	 GHOkRdhLmKpKx52NIa7T8kDP2+gEmuamUeKTRh1CActFKfhporu9ckdY+YUvREi7X2
	 5ipfARVFZwM1S1rt1wT44Zkl8GC4/ZZSZ0zUVD50R6VMjH9eeT5Z8gWfgsMv950HRg
	 TOjjxqR9006t//+zTVpf5F6cdZ9pZhkmSq7CWZtakjBc1tQVfDrJY/sFdqM1fKsemE
	 BaOAqJ7HR4u/7lYuZJESOmumV2JcbYvdVx1WjGtYdgUvZph4SZ3o86cQJPvaBg/7Ug
	 HUyI8SITtku3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4804980A87;
	Tue, 15 Sep 2026 15:00:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0B862E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2E34606F2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v5FGbY2EpMKy for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 63E1860689
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789484408;
 b=ZW4C4MM5jDISbGO9eCbTApqleqnhNQpJunZYGFaJdP6qcci4eWgCoSTlZtZ20o1A6+uy
 KxYqy1lt7lO11f4kJFZ1C6lnKqEy7EcqpyMMfssuTfCWxXmg517cW0eI7W8Ii5tmZ2iji
 Ia7AFtFBAyZXvWRWqTvz3d2eHN305dPEg7pHzm4PF32uJZSvpN1oG9tW7gmIhZoFmX2HQ
 x9WhzA3ao8jBm7CcijpT0f8wXl1o2zKiGNTJcs5tESpPopo3lpKyAi6QOhPsZlLjo0goh
 k8qaLJy8tPxI0cH+vhEC1WDHR5Xy5R21CTQ60rkTg5DigJKofVhiwt1lHhS/LPVOjRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789484408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
 b=InGFF1WYbPvttWSBHj3FKZ9YjYe+zttY0FUloRlK7QzghI24OJoid+T+3JwAiaOSyZd+
 BuJx4C7LUgpOro1f4/9tcQty5Ug1ttIWdaFjl3205JZj9cGsifxq9/6k1xzyBsYqDLXn2
 cM7YkhGJVnLkjh9bRvoMURzjeHa23RuXoF+NyfzQzexM4y6wu6L2LuiheDTMeIkoHicj/
 XzpGwOFFn1cmBAKq7lUtcAtdAItznbgAo3N0SGfT4OcUwdJCx4t6vQNxkEDzj3GlFjPYv
 Sz0MSi89mMh3dFeHueHePAw24+KXzXH6s8afC3BnkovrMmCquAg/8x9Hhb8gO6lNC+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="E360/C3l"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=E360/C3l
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63E1860689
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:05 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so3336585e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789484404; x=1790089204;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
 b=E360/C3lsedT7iG817MdNhCkT514pNyQ9ttHtqO6y24cG6Ylu0RBT/JGnTr7yF/iIG
 zsfTuahmcTY/D+sRi6f6XPDXSGXgjcVI89GepKM7ai1YXaAIlpQ1Ia6bcElNL9Q+TtWM
 5r9QDbRfTc5PlyuhxECNMFcJKsCo54c1zDaqAl5agz9YCimZBZ/Oaza9JlZtZmOu6U3T
 cibiL8R1egdqwaxN8Hr0Y9DT6fSPda7h6lt0LlecBy6LerW88LmQezS57kHXGj7sm9zF
 fQt+XGOTfG5I1Mj5VrHEG0rJFXyjWStXt2C7L+Tm/PzIoaXREuWKy/vAVtv173lqCrEX
 1WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484404; x=1790089204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CIE7fW/jQ74wTpF14E7UixpKM7NJfasGE06nTq3BiOk=;
 b=PfupSYVTcBWIh7FIamazHa9KxPRYmXdh+SQH/WiDN+oVaxA9TvG88/Ubv7TOAYtzLT
 k/6XhNi5aTT1hZfBGR3wYvgDG+snqXFCXOGtbrlQN/psiSmKRR4otwAqwNQi/gv8NGom
 4uxH26hQE6woWAA5sNH4sqoIqcNG20i7QUzHzuyogTzLfKzcLBzrng2VnVTfvG3JvBTD
 KgJe91YG4bKzSkEtTUzNDfIupaeotGcAx7dafrP8VV5DVJm+X+No2oSi5N3u3lPaOa2V
 WQ5t/IYl77Dj5v9fjIse2USKWOp8HAgzHEYv85TqdaWgNxgvWbIOSbroyFa1sAQDgJ5+
 VKdQ==
X-Gm-Message-State: AFuF++kleTbGFi15BXPS4HO+/iR/MisV+eOVdWdAl90mPkIQ4LRZqBXV
 hlmzBtkBwwnyHX6wHoOq0yQpp5yTI3yemzJYsNY3JBh/iNAJTL11EAE24pmHJ4OrK0U=
X-Gm-Gg: AYBFou2pKCSBXGjP9x9hc+No2//DNpr7CNkZYF+ULH9ZfkbpdQ/3BaalZ0bKNK92vKt
 RKTmM4pKlcApPcFGhwTVebeFgfJOjpoM3C9PMcVFvX3i6vK3acrKRmsJJQDT140WQVsNwos2337
 eR4ZuQQdhjAXvfzhl9+bPEhcsg9qs0TglOMj+p8qqyIi90+n5z1OfEq8K8UhaLMdTkfN+VJhs5a
 15f38ZQpemCfjzFfASfZ66X60df0aVGcTVBiJco8LagSUQ+C1sStFXPIRUci4E3U/NFlZDr034l
 9swZi83+48AmL6QougdvjY78n+mqgr9RtnuyGU4/dJKZ2SKMbg96hEw7fnCNadCB3zOzyI3KJCM
 V3Awj+pd9L2CugatJ/XUrNz1UMk8FXut+0OTyMnwNkLi+yhl9FCrm3VL9ImKwKDo4UuuTdK+DoN
 qaiM5/BElfL1X0Dno948vKQyGzhcDX7zgBeF4kJ6gI1eri82OsNXhI/lNjxdzecTBGjGlzhZHi/
 +cL+LVio1WehY4bLMgGxferZfNGpM1VcRfFRyOQm4XRNNGQLQyvTjLztQ1wZxxoNmPmGUN0i/rT
 /PfJ3SJ6e2qIOnk2piOOiJ7oblBiH7YiljITMOUL215ofJ20XiWCteWKWV40KmWMqA==
X-Received: by 2002:a05:600c:4ed0:b0:49e:81db:4926 with SMTP id
 5b1f17b1804b1-49e821ffdb3mr19774115e9.5.1789484403486; 
 Tue, 15 Sep 2026 08:00:03 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83aeb654sm1538675e9.8.2026.09.15.08.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:00:01 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 15 Sep 2026 17:00:30 +0200
Subject: [PATCH 1/3] phy: sort vendor subdirectory lists alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-1-83707ed5242a@baylibre.com>
References: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
In-Reply-To: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Stephan <jstephan@baylibre.com>
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

drivers/phy/Makefile has two separate blocks of "obj-y += <vendor>/"
lines, neither of them sorted, and the list of "source" statements in
drivers/phy/Kconfig is not sorted either. New vendor directories end up
appended wherever there is room, which makes the lists harder to read
and to extend.

Merge the two Makefile blocks into a single alphabetically sorted list
and sort the Kconfig source statements the same way, so subsequent
additions have an obvious place to go.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/Kconfig  |  4 ++--
 drivers/phy/Makefile | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 6262380a60a..97133304cb6 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -363,12 +363,12 @@ config PHY_XILINX_ZYNQMP
 	  Enable this to support ZynqMP High Speed Gigabit Transceiver
 	  that is part of ZynqMP SoC.
 
-source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/cadence/Kconfig"
-source "drivers/phy/ti/Kconfig"
 source "drivers/phy/qcom/Kconfig"
 source "drivers/phy/renesas/Kconfig"
+source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/starfive/Kconfig"
+source "drivers/phy/ti/Kconfig"
 
 config PHY_COMMON_PROPS
 	bool "Common PHY properties support"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 19cf95759e5..02f8b495ea0 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,9 +4,14 @@
 # Written by Jean-Jacques Hiblot  <jjhiblot@ti.com>
 
 obj-y += allwinner/
+obj-y += cadence/
 obj-y += marvell/
+obj-y += qcom/
+obj-y += renesas/
 obj-y += rockchip/
 obj-y += socionext/
+obj-y += starfive/
+obj-y += ti/
 
 obj-$(CONFIG_$(PHASE_)PHY) += phy-uclass.o
 obj-$(CONFIG_$(PHASE_)NOP_PHY) += nop-phy.o
@@ -46,8 +51,3 @@ obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
 obj-$(CONFIG_PHY_XILINX_ZYNQMP) += phy-zynqmp.o
 obj-$(CONFIG_PHY_COMMON_PROPS) += phy-common-props.o
-obj-y += cadence/
-obj-y += ti/
-obj-y += qcom/
-obj-y += renesas/
-obj-y += starfive/

-- 
2.55.0

