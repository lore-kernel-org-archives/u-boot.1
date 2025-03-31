Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59260C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 08:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72BC81DE3;
	Mon, 31 Mar 2025 10:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qryOavhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9827C81E47; Mon, 31 Mar 2025 10:52:39 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EFDC8144A
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so955695e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743411157; x=1744015957;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XFcG0bEYDx6H2GGZuliIBSyhQAHYx+z4re0sp7+nRX4=;
 b=qryOavhn1T4puML2hrJuRQ1N+4+KRShu94bD7ZJlzx1sCnxzVrb4I0B/mLF5K4sEkz
 7/EWe5choiuH/jcHZKUaaq/iBL/JiAsFIzph7mNzPF1pibZd6Yt1kjX956DmCRhn2wo7
 nzgoTu2fQqQmD+AskUHspzDPREanKqSVowgRZADxspB1Uo6cnKeyR/0RgQBdf0f9q7p0
 MMYA1TiHB4ocBJSxFDNygzlnB4aIPbfM20FuPD5LiJvPcsDBkPp2AKj+5qeDJCpsVRtj
 02YoLCywoKr1XLs9TN4hvT9kdV+Hz0j+P9JUWhGTf1y9Rt6iQ5AC6JCOVxYLAdpCfPjG
 M/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743411157; x=1744015957;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XFcG0bEYDx6H2GGZuliIBSyhQAHYx+z4re0sp7+nRX4=;
 b=n6VDEb6N07RGRmjvvQephcPuVqP1246Ro5zzLBLUQ9DBnRueqKJljCzKfJKVq7R4X4
 lvDZfKqhAmvL8K6Row3FXxWvhfRyUbKLdQ0cIje+hTgxa7NlQq9BrnZvsr5jivG4FTpk
 SdEIh+YRt4nr20J+P4JFjvhPFQimErQDUR6X/x3N3Npeg0EkzYQCwSnhc5aTBSHmqPEs
 y+4zCLDcVIO9NUDpI0AmyU1VWb6fiQ+3IHCEOS5Jihp7T2gRJpoCSWdkXN7xssQGl6nd
 YCasIeCOltYi5Q4mEsi6zH+gzjDAFnV00/lwu4O8N/E6wk09LEyD2QLuv3z6icP4bVyT
 PrOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2A03wHOgUlBAx5JzzK33cci8fIPOlORx8VsewhLT8geuc2DgW9fdgOfAyf1FS+0ugWDstupY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8BF6rd34qMKmdrszAACSAY0G78CBORgQcUxZsvZGIBpdaDlPx
 siPbaxEhsLUXTAwmbvbi1JL5acE2t0ucxVK1jOCfDHZIMpsa1C9b6n47RLagLqE=
X-Gm-Gg: ASbGnctj5wIQqIZIxHk2noKWUOlM2tSCwBnPh3unbU8al0fyICKSOv89Gx40kz8P1JK
 QkXaeNAHCKKGdgCd8WJqHJRqHDscksj8I0F+lqkB2+BmW54+JlRTPibYGBTczIIKtbk8xpztrvO
 S87K++1BQRD8xU0R3dBhbFgr4FFO3Gt6JcLAMOttZiT5rsemNVj+IJPVhfQJSw0ophTA93t0HPX
 1eRUN0Tr2pI4HVbqLAw+8s3MnM6FKrw4kimkWupY1vmZnUU3Zheb+vHMAOWUOQCOniBH115k+9P
 zo3eS1V6p6yG4aqtXeb9U20j3tKG1jXByRYhYabNeHlAxymmOQuM1l0q/iLVCaRlFSTo6ope/yt
 RsGBsypIZI44rzmf69Q==
X-Google-Smtp-Source: AGHT+IE1pwR3NkN0zt/Hzz0RZEVVAph80eM6OwOWy2MVSOkEmqYmiqpCsWP666KJfkDwn69mVhtihg==
X-Received: by 2002:a05:600c:1da1:b0:43b:c284:5bc2 with SMTP id
 5b1f17b1804b1-43dabe23d8amr70955865e9.0.1743411157073; 
 Mon, 31 Mar 2025 01:52:37 -0700 (PDT)
Received: from localhost (lfbn-tou-1-752-68.w86-250.abo.wanadoo.fr.
 [86.250.199.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f9csm116217515e9.26.2025.03.31.01.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 01:52:35 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Daniel Schultz <d.schultz@phytec.de>, w.egorov@phytec.de,
 trini@konsulko.com, u-boot@lists.denx.de
Cc: B.Hahn@phytec.de, upstream@lists.phytec.de, Daniel Schultz
 <d.schultz@phytec.de>
Subject: Re: [PATCH 2/3] configs: phycore_am62x_a53_defconfig: Enable
 remoteproc cmd
In-Reply-To: <20250328055824.3849523-2-d.schultz@phytec.de>
References: <20250328055824.3849523-1-d.schultz@phytec.de>
 <20250328055824.3849523-2-d.schultz@phytec.de>
Date: Mon, 31 Mar 2025 10:52:34 +0200
Message-ID: <87bjthpood.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Daniel,

Thank you for the patch.

On jeu., mars 27, 2025 at 22:58, Daniel Schultz <d.schultz@phytec.de> wrote:

> This enables the 'rproc' command, allowing users to
> start, stop, and manage co-processors as well as load firmware
> images.
>
> Useful for systems with auxiliary cores, such as the M4 core
> in the AM62x soc.
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  configs/phycore_am62x_a53_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
> index 03d4618df38..c1a46bc40a9 100644
> --- a/configs/phycore_am62x_a53_defconfig
> +++ b/configs/phycore_am62x_a53_defconfig
> @@ -76,6 +76,7 @@ CONFIG_CMD_DFU=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_MTD=y
> +CONFIG_CMD_REMOTEPROC=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
> -- 
> 2.25.1
