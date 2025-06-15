Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C262C71135
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 18:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F2382CA4;
	Sun, 15 Jun 2025 20:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QT5aMBiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C976082CCE; Sun, 15 Jun 2025 20:02:24 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675C682C87
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 20:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-407aac76036so2281090b6e.1
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750010541; x=1750615341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOuIZhyVCQ9dknIp0doh7L07efh451naUB8A4UiohG4=;
 b=QT5aMBiB1w0LVy8g4bfUaKUvVQDheI5J41POHdT5/p4M6qDdke4h8TdnveuPjxAfga
 MuI/lYy/zy9WLRR07R3umGwtKdA9BoyWYyVrg3Mvz5HT+Jdkj0xmU6newmZugTKs48zh
 kTr35asQSy5PIHsqeu7pntLlQc4/QpIkrnJ3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750010541; x=1750615341;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOuIZhyVCQ9dknIp0doh7L07efh451naUB8A4UiohG4=;
 b=W1G/0A8iSUBH36DTrSdTkc39xJ+ijWQ09idOq1ADiNnKdQUyO7pCmGlmH4WggSlfu5
 owk5I1tDPv8VfeatZT1ITHRgJpB8CAvop8IfArn4TuBDEK7TRdRBTW0kWNI/7Snk+NMq
 4eiO8FEzhDCX0z19qdPP6P8XPlnNEeODP/gImDA0vcVfUhy8M17WD14sLeg3EK+Ll31k
 sztFjLKz5CjY+eCkB/7FDfS3c+5DeEV0S9r39Q2Ax9Ti4C/0VXs6Di1NrTaA8GTphbkA
 pVxQpsYu+58NhpLNU83Y5C/rpfUD+lfNv8rdlmTnJvja5kpGl7u8+8PKnsIw+OEByEUy
 jDOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW90YTkBoF1UuwUXg1ARiq6ec6LQIA6VXtEaXxU/I9oiswDp9m6vdTbneYemUes+8VpH39QYO8=@lists.denx.de
X-Gm-Message-State: AOJu0YxLnf4RdHkPj4MwB6ggdF7fgHauvy6DApiPzKpNv62mP08L2Wah
 bJ1bPgQMSUI87V3hcM3XXrIOcGOmURopkw3qAKp6VagR2RXEIfOGiEI7m0P/JWAJOIM=
X-Gm-Gg: ASbGncvNwIvNRPzJbQiWJ76UasoH/wYb7KnMaY8WeOZE1T/OLmDbBCCQpKxYnHqd8jO
 faY9CWN1exuU8UGbgHHZ200QSZv2opWR/4qjoDy+ZkKZICGypB4ALZvuEPBUbKALNVD5+mWDREz
 p2upXZHDSaaUacR8tsocLlNIokN2A5ZAlhWqgLU4aOh3iW5wezYlcy1iZiGL2ljkzN06Vnbz63R
 459oEPGqL/zOTxtChgCBIo2MV+oGbidFPRHlUhAgwmUCvpQTAlE8NBWuYUCP2IdPZboHq6QKNuh
 tqgqCBNTtn3yapnKRKem62PPCCm6pPq4UGfXFMuAe4BtJK/OLQFsOTxNYqhSDYLx5YIMZUC0Lc1
 2hfaZDjLJ6f7HsGKEF+Wu5f4lC56aRGmA
X-Google-Smtp-Source: AGHT+IE9uYQn5z+dseQamd/8ArgOImlNFhz7p/K7UEQOKAJxUXhR5YR8HwWFSF6Aa80vkQ1Csd1JnQ==
X-Received: by 2002:a05:6808:6808:b0:403:3c95:3684 with SMTP id
 5614622812f47-40a7c0f73aemr4629611b6e.1.1750010541145; 
 Sun, 15 Jun 2025 11:02:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108d785a6sm728761eaf.1.2025.06.15.11.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 11:02:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>, 
 u-boot@lists.denx.de
In-Reply-To: <20250613224343.3521820-1-jonas@kwiboo.se>
References: <20250613224343.3521820-1-jonas@kwiboo.se>
Subject: Re: [PATCH] arm: dts: rockchip: Fix eMMC write on RK3528
Message-Id: <175001053964.1130810.12447001686719939078.b4-ty@konsulko.com>
Date: Sun, 15 Jun 2025 12:02:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 13 Jun 2025 22:43:40 +0000, Jonas Karlman wrote:

> Writing to eMMC on RK3528 is affected with the same or a similar issue
> as on RK3588, where eMMC must init to HS200 at least once to fully work.
> 
> Trying to write u-boot-rockchip.bin to eMMC fails with:
> 
>   => mmc write $fileaddr 40 5000
>   MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
>   0 blocks written: ERROR
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: rockchip: Fix eMMC write on RK3528
      commit: f8cb3fde935ed003ad1d7cf6a06d59586fe65cd5
-- 
Tom


