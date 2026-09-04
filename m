Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F519C79F87
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6FA881203;
	Fri,  4 Sep 2026 13:50:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UPwiXeR3th6R; Fri,  4 Sep 2026 13:50:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 077158120C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529841;
	b=g4L1zFKqVj6uJzSrQFONX46oVfucpjTuTdek0w1IPmk/umLsHflGSLc0c61xXG5S4tiV
	 QAoBh2pKa8ydhDDW9KCKWtH2KyVTHtB2iRtSwSFgtJ0r3YSxY5H96uXK+nCQa8vz0/OP1
	 v9R4+q6vU1/Al6cSd27+totKzbrJTCnqYBt3nZAjFiu82qlg9WMVdi5VC7nzoPCOCuYL5
	 jCjjJ0LaNVNkEGVXyUf+5TmevQJpE4O024kKBh48QnRiIQLuQu1OooGPEyQ6EAEWTqZ2Q
	 31/3lNdGkwmfBhXfaQyZAlMbtZ/tebG7+OIJpFvVw5WZMHJ/83iCDgx1pVzHJf1jKCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529841;
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
	b=Fm3vXr8YiUPL+2Cs276w7NhkcnY64W9NWS6DQLOC4C/bLITlgXg/negRlmI0NYDjutUO
	 gCzkmb4hb6muvP7evjRglzlkC+4Xz4xD4K9MlGVdzDXnqNI8LGWdrgqI34bnKPQqCI7FD
	 uyeh3xhof5DKiXOgnQYiQ0siut50XUT7YbyxugCrhClBbxnVmcnbE6gRG1K7qLAcQupmn
	 0IgNmSlw1NouZK0EdMytXAHmUdnRM9E5YgZQP4LV3nioxSCED45qSevZbKThg5at8T+jo
	 6LB3273w9cj1nCwIMhuyqUOjN1qBiOP21EwOnnzLLWskun9qIALlZZZu5/VRiUOMZxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529841;
	bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HWJzekHR0LdMZQhwyMUDAr1SrTBhJ7jzU2UYjEmqqxq0VGJUtmQUkFM8//flvzyim
	 M9FsLHY/80VKIAKbbo+g5eJFEP7We+NJ3VIMiA87fkxYF4tToeKTxDD5XXfufzcIMw
	 7tFaZeDakZ8BDtJ9AVkB64tRdackp/Bul7Ewv7Ubt7WMUVsBX14DYVMB6CuQV3ukP0
	 sFSzj/OtVpX9NUOipMN1t9EeUvR2tCRN9uE9nAaNGSBBE81ZUVqSIDQAkwCZnFIIkd
	 wlDq/UMP/v9ByogKUhnxiLLOytpXERLdtnctvq19Q2RUVCnp3sOjhhzLYg+3nsny8b
	 NIaGcohbbtwXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 077158120C;
	Fri,  4 Sep 2026 13:50:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE5993DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC1C440BF6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BtprF2Nb7IQo for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F32DF40BF1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529826;
 b=qjy6mIzyltgr1cPtTm9hRHMP13pvXwUDP40OT6hO2CV5MAqGuf54k4FVZzFBvMl5v5td
 kUJYsKoOiQB/yZdp4tWigBvdjBbc+1BnAiqgv6hmWPkguxaPjdPVy3i1fzOgbD/dNlm6Z
 r9iaNE1ho4vo6klXUWZtfnyF5sECbMjf5ZLgeuSCgjlNsimX7LNrEUbmKeJqRYGwj4J6d
 iIVVSwe5IR+M4HiTAVtBSr9gzjCw2dMgwZUG7hFYUjAlBQHaUt8GLWjOi91Bfg4u9Y4K0
 zIjvKXIxunJjQ9/vQRoB3iBP5XGm80L5UKMesFWB7+CdeOzxw4EQ61rP4+dJeMYJqJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529826;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=rkh6l1Rn2jjC1DDvYp90BZqvHFZnwSgVN7GVjQ4/bS8uqwK6YzvjNTBSemsinZOtC+cw
 vSGzqI6SuWnRH9GSGYbBKdhkQk6mknB6GKWZnV6hoZqyvknKBFgwQb2+hwhNrXpz17pxZ
 qlvdqHYUA20CcHzYu19z0Px13Smp4pArvUS+3JbzbVONKgwIYWBPrJbopjoPMmTjIX6MM
 yowEZLGva4qeW4ejLEsEbir/Y9fF5sn9ptWnlnBMI5R3O5o0mZVdqf7CBYp2gLmEiP+lG
 hAIbu+lOiCRtBj/ETwjbMgXod4MO0zbvqAGLfefSZY8624xPH/O/TL07Rji80Jz271Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=iFNVIvye; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iFNVIvye
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F32DF40BF1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:25 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so7587715e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529824; x=1789134624;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=iFNVIvyeqCPA5dlGH4Uj/Q8gsM+/Cb+HNAQEFozwXYRg2WKfSoR9HbWAj2s9YvZtVE
 3nW/TsympRKqHsJR+x8EoZ/up5m8VztLznhNqo1kZQgXVYgNqVqabpQgmAFiNR5ssMPD
 d4bun5CfBYl1YAHPzGcQcEUTyuMbdK2MB/tZvm6eCeefnmvKmKD0o3oO64wdoTglz7Ik
 xlk3PanvU1b9LY7tiRZnM0ZhGBl1uLbpdB1xCQrot73Uu2xR89SonjsJ8OZkrHp1P1cL
 OlJhuw0vkEHnrq0+Wu50YCPyKFOyrlDgELRyg52ryos9BR4LCgSi9YzsQ4B1tpmv/3XD
 73bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529824; x=1789134624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=evX/YqmG5t06fo4ZtC/VYqowu67RtaA302KLe/zOY0XcbPno5gQOKOdxzLj2tMPfEI
 VRH6hSxKYXybSbuxVBTaQG/GSJJNf7wSwYQPcHVmUv5YBTJ0Vd3kY8Uud0YLOVB4T6qA
 um+oCEwvzI/mWXMyXoaf2UX1OlHSOyy09VGrafNBJmaqifQj+0dCKoGcaDaUIckO4GoB
 zOAPtSfLQZjcvHD3p9qhr03oBiPgd0+zLvtQd8+iBlJQnCotLfP+uPiKmRJ5JmxTDjep
 sXnrSdrnYuOuLrcu2WIsB9wJq5EF3XeR0t0Iu1NPTHWdaKo5OugcPwi6MnV+hh+ULUGo
 +3qA==
X-Gm-Message-State: AFuF++m1XFXq+k9IG1wwvdLPohc5UhRnB54k/kHbpfx3OugSov9Bo7U3
 ZRybom4AIwfVHZX20OC5SkOK26PfBqlLszTrpg61JKJyTKaIquHVJ5V2f/qNS2zh9f0=
X-Gm-Gg: AYBFou2SjpmWt9R0McsoYeJtGi+2I75MGs1QiIhqXlzI+CLjkjHU8qxDGXk+veCpqY/
 rFdAuIa+6DpKau49P0KumLzS4BpJYRl7Elxb+wJp1kwEYJMCtvH8BmurM5C+rYzxplt3J59UG5K
 nK1gE0rC4xGBhYhT95P8UoB8KYofo3PvJu+uLsbPkeQ/ia+uSJX17OGlJw2MhR6Ao9hlyNr/b/D
 KPIcEED0+5EnfO8oGamsn8z6sdmayduu0KToZoqMI07z7+btwmHGavOmEaT7L8Bi+3A8V/CC0M3
 qYU1Qymc+SmQE+95EA0ZsA44cRhoWoCAhd49h1np5qh9T2EDOQFAKKOmqyOGF2M5SGTe+oiY95x
 njV515UC6vRqd6uUvZ5ukOaaeVk74UDFp06NKRnLarUeKoaNttuVFXhd/kAdGU3QtY3X7jAoqHi
 pit2opSHfoCCFr3DCsz+RJJ3T7BYKHr5rKOxDi5viqdpscC/2Dg737OfCnhfxpailkNpGtecK0+
 SYpCqhEtUbjNSUGYMU5y02YFOD4FG5qniGgYtuuxUIO96GG9ZG/Cs9wNoF9Z8dM5Dy9hsGhObE+
 6x2hwH8I8fYm5EmmL1uobnNaDTZLdQcfvd1W3ME6/pE=
X-Received: by 2002:a05:600c:35c3:b0:49c:fc6c:be10 with SMTP id
 5b1f17b1804b1-49cfc6cc055mr35454025e9.22.1788529823534; 
 Fri, 04 Sep 2026 06:50:23 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:23 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:19 +0200
Subject: [PATCH v5 13/13] configs: mediatek: mt8188: enable hdmi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-13-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
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

