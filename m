Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACE7C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A13A440CDC;
	Fri, 25 Sep 2026 13:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YkuOvWO_X1tt; Fri, 25 Sep 2026 13:40:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF09C40C90
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343658;
	b=E1cJKSakqEfRkJIDMcxwsSNeAjUafSKyR9GhKRmn0jxI5Bsoh77QYSx/Q1AaIr4lmUUc
	 ZlR2YV7o472k2/3DqeT8jWX3n+Q4lgB5DNWPXgJubFs4g5/an/MBfYhINgaixsw4ONEW7
	 Z3GokdHw82lkJdQ1DrJ5uBUftDnDs0OoHM3ZECgd9xn3/RGU37HAGOIBK9ea7s8c/4eXc
	 l0sQX873fx6QsCvt1WXfnpWANYsOwoBWE7YkSZ4HxidB5BBNjsnC0UZi0NATo+ubGPNYk
	 yGomIoK5xBd7d54R5qi4XgJsAcZzRAVAR/bKyU8Kd7rG/3V9BXvd48PJDO6FtZTNbNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
	b=fFya/iTZjTUIRMfuV7NiThS3NJHtlDRkbCL5i+O1XSCSlCPfhuH7Mphf+0SzePQqXmpm
	 kGKLkm2kgDqsdBJqRPJz54gIeYd28XFVouoPMjkSflI0ndR+HF7xV5RJ7WHFVOZwThs/u
	 p8PPR5Jk6ByaVk+GiWzm3Zb7Fxps7/SSJVE2AqCEfmgumSLMub0m0cfnlnQWnWQ7ehT5t
	 4VVkiF9L20/86Ksma6NJfMNYDQMeXCd0GUjKZ++I10/BdvT77K5NBuzYWjoFVW7TXTSj4
	 TQ9XBH/D19Nz1sSp8a2X39vbTcG+gHz9asloXdDFpi2t1S45cuM3PUPbinCNrwFebRA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343658;
	bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Hmnyped8RKBeHG1ccfmvFRVEaeQ3lO8RqgNhW52yIjm3Y4NkG5enba+6IGnt8S89
	 Jdin0nv2W+JtryeSd/3IIJIlNfEFFvRAFYs0nx/+M8yplxHkz84XFLFFdZOlV0I3oz
	 93xJ/5d0Kah+0sgTiP0EAu7916zoQ6cHARGFrNUPSwg+yn/WaVi5NSYvqk+USYE7tD
	 rOLrB/hoRQSPF57RxbZDA68A0CkraZaBOzth27e36bY8skAVbzndRggAZyJSXdW4VB
	 B3raAIIEBGt3WuRdJqqNmDAaQcjaDHt1RGM75w0PeMNuC1lt8iI7pnHzEZ7lMQFo0a
	 RWbDEY3H0iLvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF09C40C90;
	Fri, 25 Sep 2026 13:40:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6909432F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EDFF4046B
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CPkVP4MWh2c1 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5B56C40180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343645;
 b=KZiLfBzdyn7Z82aplTSg33o6hOMNT2o+a2ixnRWvrS7b/AkTqTPmRgbwsZQ5cJsLw1hr
 /J/ccDBUOSYaqQv1ffG4BEMc557OxG36bBt1pDSVPq3XSywCeWW4d6h5Qu32e2HtpVwxN
 kGLmBg+XvuHtPgY2MkiQxnNtdpBMqjd+Jr4PgQeSQxAi9WZeLM0oTHRwzIz7jUSNHWDpa
 DgzjoiUso2A3+oUiexHHa0Oq+Pu15vpd7nqa/zFtxUgbmCu2swLAGI407yKsXL4APvS4Y
 UP7ik0x9XEXfkF584eJuxLpUPmneJ43LMaIKc5mj1tACX3cguGLsrhd6DZym8g2vPIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343645;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=TQptwMK3rfhZ5dsDTZcoz04AenibeZBhfBQANuX9kck+VBqhYhFmMrX5UoTQbrXL86dP
 N5G0lKUB+TIGJuTugNenerbrBy4hGoyb9JEOGB21+lqUeqgLY8ZDISI4x8QiPTDPSrIvW
 NOZgqvNxQq7iwfElwijmKW8qAkhiQ0UDGixBLTkQNj+PtmuUqqYzpgQK0fr8fbO7QPOuQ
 NDbaqB0m29A7wjR8jF7FVsvZBiT78S6vqY3m0Bu/092yCacyAfim+SewjvfZQ/CsNwjCk
 H1nraYciP1uj6SoQUQ1lG6R9tsiQsuRRyVBvnTKUmRi88Z5rKnrXqlVwqF7BRZ/+ckg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="k/zrYHQp"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=k/zrYHQp
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B56C40180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:44 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so8577075e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343643; x=1790948443;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=k/zrYHQpHlDmFuWuVHJCnhrbUAUH/rb3ts7e8Xhh0MbezGzz6HTumaBNSXIKmNJPHy
 T8kqkZwJJk0e0Bc8q78W+4+NVoqlq5uvbvij5x/8YVXtL6njpkvJXY4ritfY7e5pQnng
 HNxyVa6E6GOqOQNteI0v8UC2L1cNRgJF46M/+zj6J0LQtZwt/5EdPYsU4t3AmEil2LCX
 v64Ql0dY+jGNfAZQ8SUq0lH+9FQ5KhlGqSp5I89ZIzjIg81CR8ONzuXzrCc9dhcjS04r
 3uzJT1R+KR2OiPksY+yobbhbzFQoom4Q6jfOkK3pSAw/FfzcX4DOtQjsawNubMFq2C9n
 lLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343643; x=1790948443;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=aPDCFyJ0qbSMW0Mxw9KJQOeL7HEneNECSCD+iXXcqa2Rf1oteroghTy7ocOODm+emq
 Y6E8skHrGpg9JR3ARi4OfIKdcRA5QJgYwCB3vRGtvphlWkdCX18VXj634c5W8kxGiYX5
 TadMwFpKlF8n+VA+500bPELF4Ff/A90F21oVW3OcsOBtb0zyhaKtQAcGUoQYXDiEihn3
 LwYIKrRa0JiKa67P1ICaZ9KgODHh5mzw52Fpmxk9tYp/0l40D9NfR/qzW+bMhGoikNAE
 8SRh8uH97QijXimpyubi5ELUCUrTP/VO675BBwQROOOxl6Dh9wnA7MybMNwJ/JPLZZOh
 3HBA==
X-Gm-Message-State: AFuF++lsBDRj99THvIwMSUm/BV3ovfaiQWEzUKmdH4V+h1ydk/kUHLri
 BTZJRDfc41KXttKhj1OO8ijRbpMUPo4JZJPxtszgcmd8P3vJw7ptLQ1sZ7blIPgrqJw=
X-Gm-Gg: AYBFou2o/zOBc11vUt0wByhFvvn2QlQ55hSD8lQ0TAoI/nBFxhdE3Yy/WFIi/H15E0O
 Erqo0T2QXIXNJ7j81BBuESu4+l6GYZnNiYxpKHJv1fqhDfvC0zyTRUIj6Ag5lHbpWUrAgavpEtv
 Y9eySDQyCBeJs5jtxnbGEAfpzzJlHEVbIWDyi3HQYF5hoNmUBXW04odKg7b6ulGJB83Eov9aMBo
 VVG//MMYXBtRMDY5zNjwjjsKfOzlf2Qt7qPdT09dzwDOjpGnxm9SyCToFGC30w0+n4p1AT5tXPH
 qxFy90EUnEn4ZRF1d2FXpYRGwCpJVZ58J2IGZyKm1pa6i/lW7L6pJuBVrkGTB+s3Ow/PACo4Frg
 8NlQPCmU0VPQl0HNtfIH321j+yCF14IzA9+NRH3U7OEi/XiVRBfPo99VEvaUec/qv+hBPylTuBK
 hyDvHS9DSdCxGOAPw0bGKm4ozArldGwC9ikfOxihWp7Z7IyaX/s4JhpFOwuJuIrlIcM1bDy68ge
 mVSastEeK8xK+a20pvKz549WPXuHxHXRXrBjiaOV9WDArIn0ZkxOfFdME5IJpfRAy7qArvBoneb
 X8DQ8AfwfUZak3s1gUNOUyjaS3ekyNsgPRcIhTn8JVQSPZiR+Q5Q5qs=
X-Received: by 2002:a05:600c:8b86:b0:49f:ce73:4a with SMTP id
 5b1f17b1804b1-49fe7bd8efcmr86530215e9.34.1790343642832; 
 Fri, 25 Sep 2026 06:40:42 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:42 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:10 +0200
Subject: [PATCH v6 12/12] configs: mediatek: mt8188: enable hdmi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-12-29e626b213e9@baylibre.com>
References: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
In-Reply-To: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

Enable the configuration required for the HDMI pipeline on MT8188
based boards such as the Genio 510 EVK (MT8370) and Genio 700 EVK
(MT8390): video, the MediaTek HDMI driver, DM I2C for the DDC bus and
the PHY uclass.

Everything else the driver needs is selected by
CONFIG_VIDEO_MEDIATEK_HDMI. The U-Boot logo is not enabled by a symbol
of its own: CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so
CONFIG_VIDEO=y already brings it in.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8188.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index c6785476d9a..8073354273d 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -15,13 +15,17 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
+CONFIG_DM_I2C=y
 CONFIG_MMC_MTK=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT8188_POWER_DOMAIN=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_MEDIATEK_HDMI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y

-- 
2.55.0

