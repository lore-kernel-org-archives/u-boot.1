Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C9E9A04B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 19:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A7183DF3;
	Wed, 18 Feb 2026 20:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TCQkacvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084DE83D3D; Wed, 18 Feb 2026 20:26:52 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CF383B99
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 20:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso198339a34.0
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771442808; x=1772047608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WhpuRlwK4ghi5njgqWKlDjs/8GzeWv+vcl4x4tmzSY=;
 b=TCQkacvtI0xf26GKwYjxjHARgCjlAkdmYJ9n02JuqFn41GdjmSGhiZALCix6bKH0Ur
 QjAaGzrYmMPBBtZs8Lv8qnxKs4GS4AB8JeF9v68IHtKAJ08GmFKorjnnK3ov/WR1bQkX
 /zJW0sC5ihgKLGDPJt9L+EtgSC+4/4BDHZZBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771442808; x=1772047608;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1WhpuRlwK4ghi5njgqWKlDjs/8GzeWv+vcl4x4tmzSY=;
 b=CxriepaluAaSoVrUIsIUT9pQ7Ta/WYCYpVl7OEYu16mSOVJON/KG+l9304r74Sqb10
 0wYL0QK0CI5cY7IN/ivN4MwcHtmAbQEIxI0V2528GeNZEMYiS072qua9V6DPfX1tHTfk
 M3FvSWFhVsrOI0hysd37oQ9bDVZ2CWZXIRfvhT5NU0rxohoFUypLV53zDniC+NDAP6yL
 7m4g/3N6WHDTZLOGeGfH8NSjiR4x0u6p+A/xu+BUILeVEB1D+Wsza7PThWgiKc9d0rm4
 x8qflJwSmbmdnIqB9peVwFKp1DLdbSDLW1H2dAmq0FnLdmz5Iw0TXAOVXzrHx1xMOupB
 nImQ==
X-Gm-Message-State: AOJu0YxX2VAqZdu8HZaJBQLvDz5ahi91jrZuv7j0XLKv5/isiJmb3BvL
 G5n+5wBHwG0NYewC+CTKT45L0wRGnV3v7JgGk5Aob8YBKO8Yxf+eXwULfH0dkkdP7bg=
X-Gm-Gg: AZuq6aLCnl44kKwa7NUIoA9HmA+HgN5kl4S4hhKtA+91t1rWM0wKUfN3algtpIDQWn9
 9r2jB/pxA2MyNVWKq9rOUyeHSqyc348scLb6BtPVgs/NsxRHwd27/dF/LZEcI1uBkve75jpZWQQ
 C6qAEyNDnkIXE01y0kd8uS5+Q703HUZrX3FodYpRFXqQ5DMgjc/4Z+Zj+eCbfKCrAn1MeACIio1
 uoptd7QvhRar2AqqbZgOvApiLrFNi6k0jAOztTaNy8hzpq/ueSgw5wiy+ZpdPj8i+wuk8ZGoTD+
 HrNLU9G+uyKl1bOaoe3t0eO/CFGqDtzJqm0ke/m4Rs0yGzEUO7kYOAwReXxHrSQIw+LSLaVitEQ
 GSrn7etKr4QsthzAyQTlte0jcdqm8I0TQv28X5rQiSOISNDulxtIO8gXl5kj9BZlnGOLENfLs30
 rLH2T5PKujJLd4Z9OPXVRKuFk6evFrml2aok8Uv5eW6m8lBFRw3LkWO1rR0dAPnhM13Ff6BVyL3
 mzG6j1aJBy82r1hWvDY7aogEq1hZ7wm6ib7ej9u5cjdmGtI3g==
X-Received: by 2002:a05:6820:4688:b0:677:5e0a:a92d with SMTP id
 006d021491bc7-679aef3bc4bmr128821eaf.73.1771442808622; 
 Wed, 18 Feb 2026 11:26:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e858bsm21568269fac.19.2026.02.18.11.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 11:26:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, "Jill.Wu" <shu-yun.wu@mediatek.com>
In-Reply-To: <20260202-add-mt8195-pinctrl-driver-v1-1-df3401bd0a02@baylibre.com>
References: <20260202-add-mt8195-pinctrl-driver-v1-1-df3401bd0a02@baylibre.com>
Subject: Re: [PATCH] pinctrl: mediatek: add pinctrl driver for MT8195
Message-Id: <177144280754.3629982.15191416222955387729.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 13:26:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 02 Feb 2026 13:19:57 +0100, Julien Stephan wrote:

> Add support for MT8195 pinctrl. The driver is based on the kernel one.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pinctrl: mediatek: add pinctrl driver for MT8195
      commit: 06cfded6edf5d881b3ad451943380952b5aebafa
-- 
Tom


