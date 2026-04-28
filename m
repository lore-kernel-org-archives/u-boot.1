Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C60CFF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E0D846E5;
	Wed, 29 Apr 2026 00:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="WVqW3pvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C9EC84698; Tue, 28 Apr 2026 23:23:32 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5363F84682
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 23:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7c57b52cso2314580a34.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777411409; x=1778016209;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zNf4103342y93JMpyUya/qPjqxeZwfghaI7mXYo+YhI=;
 b=WVqW3pvXkqv6gV0rOX1Bex6yvIEm5Ykx/KYRZJmOJbdvr1Ai364QvAgSWZb6DTSpMN
 PO4TqIIVYaPa36DAY1H5XfxJrGrKondvV6gDPE6zur9M7vzv0nzc+h1/DF5Qa5UppIme
 2Y16yMFEVRviLYUwGT5vSUL5ZALG3z44blfwXfmzmv+Q2BHyYZCfZpdoNTayw/UDB3vE
 y+RRGgpVc950/QmKpGsUuMqcXauQ79EWUjIs+/6KwXyzM3wV3UwSaif14dZOQ/JkoC/b
 P22X3hK/kh4SkvMaACaoxgz8c452cOO5VoPHOzq0t6LY0Vyk8hrjz580/VWua2i7b+YO
 C/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777411409; x=1778016209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zNf4103342y93JMpyUya/qPjqxeZwfghaI7mXYo+YhI=;
 b=KSJDuNKNRIlWXH3rPpDyGBm5AbMeVwa5FVYpBw6LKSvOLXx4EQ26CnetN5qET3bdOv
 yEVrTXUy0ZxWdCSwK96h9ZZhyk90fY4X3uG7onsZjIG88FCa3idB233AkzuTUlVm6PKI
 VeD2mQezzjaZKe7kekUmNjVECzMmoiKBJN9kSUfcjm4niPqu10MHJLlWey3aQHKSbENi
 ySurozizO11bIHCM9FuT9dXb34j3o1OA52vSNs//jDrTvp5ENQGjIr9UjPHXjk/t1XIl
 /vOzdJccAZOHC1AQI8plMkppqGYBBnLSrPByaEEQSG3d2RLUDY/Aig2mb45e+lqHJ8NU
 oWyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qkS3HJWnQasZ0fZliDfGuWIYxlBgZbHsvihHVKGZCjhyS8QjDaenhE10tH22Thh7+G4+eCw4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf4+VTfN521JRfmRTNGj3FGNV9H0alzqxm3hQRMiThmAgqawbV
 PKqiVp6yF6+OTUa78OptjgFNoyeuOFmEpBlOhO9hQ0c2TwAYpCeYGqFCKDbozSLdeb0=
X-Gm-Gg: AeBDieuvzy0UW47rwr2U4o/NQ/XvMMo/zAt4jwMJnYdzbYxKzbM/mJnXLZzF4/NDKQf
 y6OJwQn/PUprIunV6hfOnMNu4fACgg5kcjq3/lTZrBegMdoe5nHfHQd/CR2wfF03xwImqfPKZYS
 YMzpNBdCwjHPJqX+5Ef5pkHbaLc4SpruLdCiM90qFq2OJGFAu/NniX0UhV/46H5id73zWsHkwNo
 3QZx7DpMksPOoeN6hzs55wm9Vw2+6VAwTg/lBD23IWERNu5aNC/gf/fKv7f36q1FDPWmpzJa7Bp
 q5Z/Cel+QHk8D6Yg9eoqB/Ii6ayU7n7fGPGLLgEEisl+0R0ic2yLPJDrtygRNpJ8ivV0Y+U6Dcr
 l4vbSpHrhHPYkGpc2w+AnFrClMS8Tz7HXZ9flBzhF4zFImGjxpYMZ2ucRwFlqRLFJJxo4ky5Dr6
 hArxt6yFpxywSgpJvnbbomb1b3zcMoUBeyMnqcCdi/+1d7Wf4O5sO5RphK4w7OHXoZtJtmxonwn
 d549zQK+bey
X-Received: by 2002:a05:6830:67e8:b0:7d7:f031:37bf with SMTP id
 46e09a7af769-7dea687bdb7mr1000908a34.19.1777411409061; 
 Tue, 28 Apr 2026 14:23:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab98e220sm5199a34.18.2026.04.28.14.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 14:23:27 -0700 (PDT)
Message-ID: <a55cc0cd-cf68-4dea-bfd8-74e67a6c10ac@baylibre.com>
Date: Tue, 28 Apr 2026 16:23:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm: dts: mt8189: Add ethernet support for Genio
 520/720 boards
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Samuel Holland
 <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tommy Shih
 <tommy.shih@airoha.com>, Kevin-KW Huang <kevin-kw.huang@airoha.com>
References: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
 <20260428-add-ethernet-support-for-genio-520-720-v2-8-9cf2f0884bd8@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-8-9cf2f0884bd8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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

On 4/28/26 8:17 AM, Julien Stephan wrote:
> Add Ethernet support for MediaTek MT8189-based Genio 520 and Genio 720
> development boards.
> 
This does not apply cleanly (conflicts with USB changes).
