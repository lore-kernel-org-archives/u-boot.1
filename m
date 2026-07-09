Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F403AC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9D084BC9;
	Thu,  9 Jul 2026 15:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="IguwP70S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E03584A3E; Thu,  9 Jul 2026 14:58:33 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FCB584ADD
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso1599133f8f.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601911; x=1784206711; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FRN6ZVt1VbqnQo6FTJcJAFgDeQFfWM2FOpxwD5VJyyE=;
 b=IguwP70SdKn/d0k7V/bZUzxdg/OM08MmD3HsiGYn1hvmP+nMh1tSyTWHO1wqehNaWX
 V8kkRI/0SizWXVTDm1t1UzB3fE7kR3kLrYg6w+7X8xpRc4EFvicoPy/q7dwCg0ByNDLh
 xVg1u4/Be3kBiydRRrxZeefgUXjjA5s9iyLKiAN7PVzoX5b8euN+J0XyTg0JXEHOjrS5
 sE7w0hlHL0TuRWfbn0yrFLuLbXHgaIZa9AfDAvz+MqzG8iC3DfJgJYRJ0MgH7ld7UW0V
 vIaMAby8E0uv0bhwUkhevCimTUp7sNzWeluWhUiL8ksxvgey4m80Eg5d0JQLiw4o5qQu
 icdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601911; x=1784206711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FRN6ZVt1VbqnQo6FTJcJAFgDeQFfWM2FOpxwD5VJyyE=;
 b=Q1jfEwxO39ZG6vzZMGuzKmsd9b7Hw9fQ1hc9Hk9MVprQAZZvtnHaULYyytvxP4aAub
 I8c4OrrKGqSlW6GZCZebJDCSHPexiCZ3dRE+K1/Uquq+fDXIROXcOfVUeQ8sJ0xFvUyJ
 7qIQbYhMlhEVTlDk27wZEt20wiWVvZaFlJhP8OTgN3FVdKhUGaUz0MYNomgFMXddBLPF
 YRLoWtF+Bu0dy8dwPHGtVVHymTTXWV5BfaFMFY2qaRKPvtt0LWlEsdGU51yXbI53pQ1Y
 7cP0uewWrgaO1smCkbLE55iXEEqpMa9HZIRERTkDi274yn6wwnp/gWrzoxAYKR87mg2f
 KE6Q==
X-Gm-Message-State: AOJu0YxmoIJ06NnR1va4RmNmQ5VgZiCf6Q1BxxfzA0x3lJdzPXrUxxmS
 PJBBlZAG+aogApyE07+SxoRzSpifbQhMe0Gewvc8Hcuwuf4l0vfj8CFmrCILcN4M2h8=
X-Gm-Gg: AfdE7clMpsxRHwT3eIZkz8sfR132W5CAuX8U+KMznB1ICuY0ez1VuSudpiGL55IKdIn
 kKs8pGblLsrMhpzs44U3rxPTIpWR2Iz/TsXD/k6NPPXW/H+vwuWrFMQtixtzR1UOJo8MLPqjs0M
 fn7E/WDG4sjAZ2pYBkYJjbimdDXulgS5RMIsgUGw8Q0CyeE9gY+G26wfE5i/H5BELQHdOsUHSxS
 Y8isUK8nOj2aXxpqifhqMwReDd625cHSIFL6ZCNO8Xr7c5HibdAotyrXtZqKJfxq1mOxKEGK94m
 Ko5sFt26LGho5JZ/XxJtl7XF89Bfi2CqUFASZobXJgxjei8/B3bOX8kB8/3vTte59Mah57HP5KP
 ZOvlZuTBehLdfV6nF/FAE1cWTxacekH7o1ZJ11MYNRxnfTHzzAntGzfAtiTlCO5nFfRbgRTq0mH
 6JmEAcs2PUOK1T4ooxt7/SyWyNztgLVZpa220ykoYIyR5KxqG+sKLBtkrlK01j9soTzHMziMEMZ
 lQF6CyHJd+hh7ifefzO35vKrlzaTRwDhSjGJDHYmy8IbkWIFaFedJ6BnS+5gQe59n1sIvY=
X-Received: by 2002:a05:6000:98a:b0:46d:d6c1:8383 with SMTP id
 ffacd0b85a97d-47df0767535mr6829739f8f.44.1783601910870; 
 Thu, 09 Jul 2026 05:58:30 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:30 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:20 +0200
Subject: [PATCH v2 14/14] configs: mediatek: enable MT8188 power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-14-589ace7d30e2@baylibre.com>
References: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
In-Reply-To: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
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

Enable the MT8188 power domain driver.

CONFIG_POWER_DOMAIN is required as CONFIG_MT8188_POWER_DOMAIN depends
on it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8188.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index ece4e60f1ee..29e2b3db878 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -19,6 +19,8 @@ CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT8188=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MT8188_POWER_DOMAIN=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y

-- 
2.54.0

