Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D3AF54AD7
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 16:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F959807C0;
	Tue, 24 Mar 2026 17:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="exeSdme3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276D5838FA; Tue, 24 Mar 2026 17:11:31 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B9680087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d7447778b9so2104461a34.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774368687; x=1774973487;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieCIyJ8pDUnsdxvcq4ZRkxr/6cklNL3XX6nHiidpTxM=;
 b=exeSdme375QPnsoGu7/vdNpQWkmXh7pIeh2+J6QIzxtHC5sy4mRIpv953DpmQ6i2TL
 Nlz1SQLqfZj2+kVFRkaZz/iblePC9Z5PYDrEHLW5wAYxp7ue/2JMAsTn95HNm8zc1KcX
 iB7u4SmXqeQlTWm+xFTYcB21xzjKr6AeaUYHqPnoQ2NvQDAYj2VAjdh+Dl17qiO7BpmU
 coS/BeKtoeVrU1T5ml4soOBfRmNUAi/bHoTar91iGpVhvO2jbXpf5bE99/OMW0mBSt9I
 +Fx3yUnrSJzRJf05cEnpViwjtl+iFaGUTNd2gNlUaZRsn76Lpwzxj+pojbCkab+6g5IZ
 Ttaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368687; x=1774973487;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ieCIyJ8pDUnsdxvcq4ZRkxr/6cklNL3XX6nHiidpTxM=;
 b=C5IgKzYLuMpkrhtI6a04BSk/rUBUHDyUCiFB5okeGWumO5ez5/puhRHQ9GTO+sA5yc
 XchJCPZp2yc9yKNOyhLwJ7fNhLoAhdMwBD7NlMxm8BrK1Xp3J2diAoLWsqwF8DpyeEwm
 LBtiJ1DB3tqA2YLIo8jjRKdARjIjt8tXYk9PIst5+cSehnB56X64Unh2wrJw+ygwILaj
 vj0oiwGEOmD6DAlEBdINDhXTOBdIViORuIUABRWoiER4nyZmZe92MTzANl3M1W7pyKYQ
 TyPb8Hfj0cQKofWLkV3RupjhLv0M/b2zpIMdASMdrM/A4IUjr6UPMB1LOwfFwwCJI7hK
 Nc3A==
X-Gm-Message-State: AOJu0YxuAnYjNFXa+ygBPuWhKmm+hCQ7mSZ4AlpcQq5ciT3dipzbqNAk
 5Kf1xQ4Cvl7eL2RLDuF94oZk1h6m1biaspDUDeT3XFJUmsf5ouMn24Skz3hQzrSQVk0=
X-Gm-Gg: ATEYQzy6uWZs+XcEX+0OKZFfzfOS8sqS+KqXkZz3f+7Z8/04+DL0g4aevqwA/fbbB/U
 1TrnF0oX203TgZF8c6H8ZS8aJuWuleX/XY34VMqPmwOlkG/eqrPe1dblHlCw3H5MdheA3vX7q2e
 V09ND6e5ilMiOmDKFP1xonSjh5OCx0lbpdMNtfoEjSCGkSSrTxGmRLAyFkjE5Xu67nre+P0IN40
 9X+KVgXQmfGfjKMZvvSRQxebmKMmVhtCSCNixMl8wVozWrKnUW1K/WRjYgirOghMAeqdyQuLkQl
 MOP2srROPcz5/4NhX5KnXT9NC2LDzZqr75A6NwRbOg/QVxJTIjrbFfudSUAhMQvoYETd7s3g4hL
 g+6FEekr8l+RHnDlcowFslW9Hy8HAEHizjS2aAhvLj9gtAo4817iSInpXVhWSeU9W+AfR+/c9bo
 i7RTBiIeP1dqZY2NP36nGgYXFefVM=
X-Received: by 2002:a05:6830:438e:b0:7d7:f58a:10af with SMTP id
 46e09a7af769-7d7f58a3b2bmr10086130a34.5.1774368687600; 
 Tue, 24 Mar 2026 09:11:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac56278sm14102264a34.12.2026.03.24.09.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:11:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Jill.Wu" <shu-yun.wu@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
In-Reply-To: <20260312-pinctrl-mtk-bind-gpio-v1-1-21b8968902ed@baylibre.com>
References: <20260312-pinctrl-mtk-bind-gpio-v1-1-21b8968902ed@baylibre.com>
Subject: Re: [PATCH] pinctrl: mediatek: Add missing bind callback for
 several SoCs
Message-Id: <177436867662.3897241.12096288590972200028.b4-ty@b4>
Date: Tue, 24 Mar 2026 11:11:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=353; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=LYQ2iaolaDdLKiKZqzm/iU/JgUlJ8rJmX8MDUJCUtBY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwrenV5mcwx+Bz48pGFG62KET508U5uCmXnPjJ
 /PiibQSBXyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacK3pxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AMpMH/j92UhFn3ASpsHyogZunHhnfNgIg//u6bxSkHOL
 c5zEIduNOUIM9+xwNKADJS66ya7rthvGOZNgREDWVBNIwoPJjb0ScAZPvoJOE4iYYajubbvfuKy
 62VUFRKN0s68BkgSSU8xijHP3wsUVCYFrQqGTBhgijs3TPE5W2wPKBSvJtJ1WkHlPN+7DBezCs7
 oH4b8jAM3VS6sRPC90V8bMlKWLxIf78VcSI7nomAoXj2J+Bq1dS9wwvORqx9ivjQc3BkRo5bD/1
 oNTnyP59sjkx7d+oVo4QA4LgkcG+udvQo6vfjr08kqE/tKdR4hZZvH98SdEWgtVXtGXYx0egUgR
 MjiY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 12 Mar 2026 17:19:26 +0100, Julien Stephan wrote:
> pinctrl: mediatek: Add missing bind callback for several SoCs

Applied to mediatek-for-next, thanks!

[1/1] pinctrl: mediatek: Add missing bind callback for several SoCs
      commit: 71e736ed6d4ff22130aff7b12b0150e042f64cf8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

