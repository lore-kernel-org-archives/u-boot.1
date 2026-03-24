Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF27E9A767
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 10:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9594A839DF;
	Tue, 24 Mar 2026 11:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o6760VEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A76F83981; Tue, 24 Mar 2026 11:59:39 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCED80077
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so7833045e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774349976; x=1774954776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FwoUBnAE8oA+nBnxuJA8SZNAOsBsWI7exBq+XaOjI/A=;
 b=o6760VEo1f7apZuVumh7VvAXeb07He3JBAIh5YE4v0Fx/MS1bBYkbQBIA8wF69wIbU
 awZHj7Vih7hpqzVvRlbX7vCF3iivSn4xLwR6n1HBMN6rtitWjK5DTtC2B5ZBBY5sRcCY
 fiHvfUvLDRPURHhjTa8ja3TOcYFLNOozwK/laR9CQ2W/b9cYEwQh648Rfiw4TCu1uLk5
 8b6Uyn4F4p1Juhvf5LuC8Af5tI6z1TYgi38RpebAM7RFM4iRf9O8+OM77+dCQayMzHm3
 yX4Fm4Z/K1mXporEJ7bpfmXR3tqugrA5sjbhgpweBufkALy4BgoCJDWQXyV9W1Ew5Wy+
 ItiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774349976; x=1774954776;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FwoUBnAE8oA+nBnxuJA8SZNAOsBsWI7exBq+XaOjI/A=;
 b=orrKKohaCr9YW3nocmXsPXx9cbGYew3SbkW4taJiMJLBE4MvsxgKZSe/b0rwkob+xD
 vuoaqErPthp1DEuLf6TPTdhCFMMk4rR7ibWLdk5ne/c+bU/bQpCGoHOrUeXSKZ7pSiuN
 LG8XS1bUIVcoYMW4/5dVdIzcoKZ2E/jw9CnaBGJzOsgqfPssfr3hvKGUA8byhS7YGwm2
 MCR3YoetB9gCMl+zhPJ4rGqZom9+qkdG3oECGkndKgY/2DeFTwz4/czGYciHe5XJsYUR
 IfX5ApQYq+Hu7ADGtO1As2rTGmbnKMl4puGxY2+c6BF6lXX7iaFLMIZdBLSQ66YfuXIg
 0XVg==
X-Gm-Message-State: AOJu0YxEayC1zQvNasDbwa22TMHhG/SpLOZPExbN/D6ekydyzvXpDDjT
 SWz0vFHhMMgdxd78pwuwEuhyzUid+1EMDbixLstOrrPExZWsmKzEcgtYdZFp5hARsoQ=
X-Gm-Gg: ATEYQzxd0a9lxrUNQEcxuWgmajoL/fkpkcbiUlOoxPvsv5Z0sRdjaW1n1rOgJUYHHI6
 tR3KcTGNtKjObz26QOu4+F1c4jWnJ8ZJO2otFy294v2YM8i94FKtflhZUwTDdCQHgyzAvbTlhW5
 WLuk05UFJQAh68qnY5iKBWSOq085/6yRUOY9w5QS8rhfLUEN8YveeVot2rwdn0VaZ0OfNtaGR/3
 6Zt0YPv7BjwbUwjnifhEMxJIKO1vgASog/GB9+Dr3ulzL8sXlVT+lblM42O0sKv/bNGMn/YZSxT
 oxj58W98rBL6I6D4zkFYpef3PwQNU/B0VER1mV72c05dTSL4BwhQ8LlWsgu1bx7xb00upIlg1Sz
 5dwprz2qd3dQf2A1DBmAQlbZKaktBI4Ym7BdAjPWzw43kUrPaGHRE2dq6M/SFbZsN2SsD7kx8EN
 weWBk5FUxsByIPZ+BQDEXq3BNVPea+GtNpk8ArfHR0H/9GnTs/sq0VwkbfC3eooAVFmw==
X-Received: by 2002:a05:600c:3f16:b0:485:3f38:3de3 with SMTP id
 5b1f17b1804b1-486fedab1aamr217421175e9.3.1774349975577; 
 Tue, 24 Mar 2026 03:59:35 -0700 (PDT)
Received: from lion.localdomain (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470b243sm37810416f8f.26.2026.03.24.03.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 03:59:35 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195302.2363577-1-trini@konsulko.com>
References: <20260323195302.2363577-1-trini@konsulko.com>
Subject: Re: [PATCH] power: regulator: qcom: Correct dependenecies for
 DM_REGULATOR_QCOM_USB_VBUS
Message-Id: <177434997476.3720457.57595020023433204.b4-ty@linaro.org>
Date: Tue, 24 Mar 2026 11:59:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Mon, 23 Mar 2026 13:53:02 -0600, Tom Rini wrote:
> The DM_REGULATOR_QCOM_USB_VBUS functionality can only work with DM_PMIC
> enabled as well, so express this dependency in Kconfig.
> 
> 

Applied, thanks!

[1/1] power: regulator: qcom: Correct dependenecies for DM_REGULATOR_QCOM_USB_VBUS
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bb5012fb66ca

Best regards,
-- 
// Casey (she/they)


