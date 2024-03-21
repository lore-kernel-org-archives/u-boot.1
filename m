Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC38C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 12:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD69F88087;
	Thu, 21 Mar 2024 13:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ja9D1HDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F51A87F2A; Thu, 21 Mar 2024 13:15:13 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21E187FCC
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-222b6a05bb1so536822fac.3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711023308; x=1711628108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0BQXrZO7zZnOyGj/lVz7+mUVef/svl89WQ7g+oHBl4=;
 b=ja9D1HDIIePQFWpW9zkmImTiYVpn2n8WPRWbCIzf8Jj5/e0oF6J4xmIMV5bbHLYv44
 YemBxejAo0x9Z9Rv0YgRiOuMJolS8C668v/MCqsV5R+7ZLAp0/3hw+aVrCgqw2ApGA3b
 r909MDRTOx4onVzGA6+lzpVg1CzNkSXLS7Mhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023308; x=1711628108;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0BQXrZO7zZnOyGj/lVz7+mUVef/svl89WQ7g+oHBl4=;
 b=XS+yZoO/dRcD63pgNTiWhSBieHT5ujew1q1WCOimZh6e5XyoFln0iZYKMM7qETpMhV
 0bYsz3hCk4HBjr7gjkjfmfb26NFbJVG0zGThn3RkwxhH0VEAKV1BvNFTT4EAiDDSd9Pg
 S5rYIpu0qNDSppuZFdqMbdgKblSBfXlazIAbixcb/DFdxBDMO6anIlP33HdhQr2A7sNU
 qRufL6m+J6SbGwwtclFdox54iOOLHo1WX42lTPX4e67EY8txiXvGr2Du8aZghYk3YBSB
 FeWXM8JastDGUuJlIzTpy8NTgVntauYkw8NZaig6lxDXaXwOO2XxzdUjdEIEKaZNgkA/
 /Ydw==
X-Gm-Message-State: AOJu0YwOKpR2fPBiLOElnaw1oMWib3+0EBo9BecdogO3WCLKc+/4Bmw1
 xcyvObnrrNZF9JOGyQ4BO+WnBcJQ9Ez9SAYycSxVK0uoVg5VYJ41NnBuSZqcuFw=
X-Google-Smtp-Source: AGHT+IGhIaTyT35SeQ4pGXEcW1iN19ZFzcuRG/5ajhhvCrP2x/RpdlfCTblN7D62WQmo0Khzh8wwFg==
X-Received: by 2002:a05:6870:a70f:b0:221:9442:4d58 with SMTP id
 g15-20020a056870a70f00b0022194424d58mr1967716oam.28.1711023308313; 
 Thu, 21 Mar 2024 05:15:08 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 kj25-20020a056214529900b00690df461ecbsm8990690qvb.10.2024.03.21.05.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 05:15:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kelly Hung <ppighouse@gmail.com>
Cc: kever.yang@rock-chips.com, michal.simek@amd.com, marex@denx.de, 
 neil.armstrong@linaro.org, jonas@kwiboo.se, cnsztl@gmail.com, 
 clamor95@gmail.com, hai.pham.ud@renesas.com, naoki@radxa.com, 
 patrick.delaunay@foss.st.com, christianshewitt@gmail.com, 
 openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com, 
 Kelly Hung <Kelly_Hung@asus.com>
In-Reply-To: <20240313102725.2067651-1-Kelly_Hung@asus.com>
References: <20240313102725.2067651-1-Kelly_Hung@asus.com>
Subject: Re: [PATCH next v1 0/1] Add new bmc dts for ASUS X4TF server
Message-Id: <171102330708.1913497.6343179780001033974.b4-ty@konsulko.com>
Date: Thu, 21 Mar 2024 08:15:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 13 Mar 2024 18:27:24 +0800, Kelly Hung wrote:

> Add bmc dts to ASUS X4TF server, we also submitted dts to linux place.
> Please refer to here, https://lore.kernel.org/lkml/?q=x4tf.
> 
> Kelly Hung (1):
>   arm: dts: ast2600-x4tf: Add new dts for ASUS X4TF
> 
> arch/arm/dts/Makefile         |   4 +-
>  arch/arm/dts/ast2600-x4tf.dts | 161 ++++++++++++++++++++++++++++++++++
>  2 files changed, 164 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/ast2600-x4tf.dts
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


