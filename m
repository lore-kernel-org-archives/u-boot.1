Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10079C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D25BC81CFD;
	Mon, 24 Mar 2025 19:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nimVm52J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C794581CAF; Mon, 24 Mar 2025 19:01:02 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7A381BC0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-399676b7c41so2510263f8f.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742839259; x=1743444059;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWtLUy443OQX99OX0MPkxNLbUAbVdnOztC7Pi97r7KI=;
 b=nimVm52J5/dcNwX36vK26nESamlHvpiuhFktcN3FY0U1UNr7G7Y+asujOO3bR9BpW3
 jxUJVBxgYK44l34+jb7U7WT1r2QPs2B0um0JinGqpMzYN8eyy0eSZY1ZUUOLoo3CpYwp
 edIIg0CeMdrFXAP2sEIQhdIYCqep2vkyfUX/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742839259; x=1743444059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWtLUy443OQX99OX0MPkxNLbUAbVdnOztC7Pi97r7KI=;
 b=t5XKzK8hEMTetIiHWpfD6OnQLb6cZkl5hiIaQaoXpBvpQ0A+UuzSBSFjTg0rw8MXqB
 oNTeS3y6Vj6vzbKVxLVVTYDaivav598UqM03oObfDdn+tBksyw7yDLKw9F2MPDPmV+w8
 m3zYf8+UN0bH/tyoaZ3fDeLHESYCAf12sxJ5OtlhjfurD30kx1ZYkYKccpfJm7/uUllI
 vkTv23d/E5Xus3UCV/oB/aOJ8HhgbgsUWupT+vvEQiBd+TqAR8iUsn36FPaP0k+G6oKy
 wDJcmoAceOm/sy39ZFkSs6Ee/nKXoB/Rqn27qiKLK1Iljjx+zZ3CdWV7cQEhk+mKqJT3
 8Djg==
X-Gm-Message-State: AOJu0Yytlfy6Dpfj1loJMHh1WElPf0Cb1gp8e2UsZU+yXJ0RRN8HEmoZ
 a/3C49lSdgKwUAFUbsx+tpSlFvdCYFzp+7hwisXPH0IsMQcXCfjBIU79G8LvQ6ZRDSfKEEiX/Ro
 l
X-Gm-Gg: ASbGncso07ztFIwz4Tcs2Iknq07mgWBpySbWuW0IKvqCVGn/0yDgdxVjh+kxVmnNvvD
 eSC/aQUAHoM4cyEokHACw/L9CCQvMH0zcsMf2jQ42MD2wfLccivJ0VfV8S9EzYeXx+nqsT+H93M
 NEwCWb+J68+IsKzaU1BtWjcByxXUb6+0/5AkMsL1QtVrW1YYHyt1+KxBLR0Jdn3fmbrsQ/e6iU1
 W44vbQwLJJghZeMZNFacXt0Si7g+PixOS1SSZ8vC0TWhb+h7dmvVUOkucJk141Y3oCXFaa9LSir
 5CvHOhzhpq79vFZ222kMlOrDA1/iD50IzCB3CQJCeoADHhn+sbPAZARapl8rDieTeuDW7+PdZAT
 hj1PRGsd5Nt643JoKX8k/pq+OiFdq7Ao+2r0=
X-Google-Smtp-Source: AGHT+IEFVtVe790JWBHXZER/NW42FPFw49GvCR7j8sSJ5aIdmNau5TagXhm9zFwKEa0q0XLm6MGq4g==
X-Received: by 2002:a05:6000:4012:b0:391:4674:b10f with SMTP id
 ffacd0b85a97d-3997f92d312mr11452577f8f.36.1742839259024; 
 Mon, 24 Mar 2025 11:00:59 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556a4sm178289285e9.22.2025.03.24.11.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:00:58 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 6/6] board: stm32f769-disco: support FRD400B25025-A-CTK display
Date: Mon, 24 Mar 2025 19:00:30 +0100
Message-ID: <20250324180047.1571378-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
References: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
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

Support FRIDA FRD400B25025-A-CTK display on stm32f769-disco board.

As reported in the section 8.3 (i. e. Board revision history) of document
UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
related to the board revision addressed by the patch:
- Board MB1166 revision A-09:
- LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK

This means that the MB1166-A09 is using an NT35510 panel controller,
unlike the previous versions which use an OTM8009A controller.
Therefore, let's add support for NT35510 panel handling to the
stm32f769-disco board configurations.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 configs/stm32f769-disco_defconfig     | 2 ++
 configs/stm32f769-disco_spl_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
index 5be221afd2fa..e50d62e93bd6 100644
--- a/configs/stm32f769-disco_defconfig
+++ b/configs/stm32f769-disco_defconfig
@@ -52,12 +52,14 @@ CONFIG_DW_ALTDESCRIPTOR=y
 CONFIG_MII=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_STM32_QSPI=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_LOGO=y
 CONFIG_BACKLIGHT_GPIO=y
+CONFIG_VIDEO_LCD_NOVATEK_NT35510=y
 CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_DSI=y
diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
index 7d4bda440685..6229ee5089f5 100644
--- a/configs/stm32f769-disco_spl_defconfig
+++ b/configs/stm32f769-disco_spl_defconfig
@@ -75,6 +75,7 @@ CONFIG_MII=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_RAM=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_SPI=y
@@ -84,6 +85,7 @@ CONFIG_SPL_TIMER=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_LOGO=y
 CONFIG_BACKLIGHT_GPIO=y
+CONFIG_VIDEO_LCD_NOVATEK_NT35510=y
 CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_DSI=y
-- 
2.43.0

