Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC7AE81A3F
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 16:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B28DC8063E;
	Mon, 16 Feb 2026 17:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hPo/+zYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231AA80FA1; Mon, 16 Feb 2026 17:37:55 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D71B280325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 17:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 69EF23F048
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1771259872;
 bh=49C3rYPCxJdzJN0OaZ35MpXsBnO95CmRB/q6PtE4a8M=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:References:Cc:
 In-Reply-To:Content-Type;
 b=hPo/+zYbC/TEu9n0olD7BmM29U4CmFu/PQ5jvZCArlxJQ7sHoJWKPKiiU266LQReh
 ZGUe8b6GZFGaDjvE0ynuewo4LiCxH0LjXoXn7hPJg3eUiJZnLjNTHRDs9WrSnw+/1M
 nAmm7hbJpNVT3d38WV3ITSfLfMKF1bsyHqzUUJA4ZsA82LDg7/T6dQGj5ewEa0qiap
 fxaQKKQDv5mmqXwzrXT1A9WU7YQE8RRQsSy4MGO1tk5bEtdafBaDwwNbuUp4LsAsAr
 YZZnZvUiL7rnZk/ctb6pCVe4QhilnCnw+BjSrHCLZJRWhsSxERcxa/ARKWKPVckRiL
 DWPtcMIvjvZGd5NdAPRZqK7CKLJloe/5NuemnPYf3GmTpqSENyZ16QWZQEtE8Y7lD0
 kJqGbuwZmHb6fI5Ck2bYlimxIC47Xwl8fkNevtOlddiYfgkJMrXtrbTya+ZiaVZeYO
 QCShF/ygMoupNrNMgKsKzQT8cX7Go/KZjkN1Vo5qp6GUSkNCPeliWGoKzwF3D8sZ7W
 qzihiBR025Hnz4aTFESEU6FiRmkJhTkQxcJxh78+3ZxEK/LAC0flVlbNV+qb2WncvT
 hNatwHUvl0srVScvM72Lr5zoaluV3tVQrjzGMt74uO25tyv0v2EvxVpdX319S8Bpcv
 DMQqwRVOHu77vQwxldYC7Jys=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837b9913c9so16546405e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 08:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771259872; x=1771864672;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=49C3rYPCxJdzJN0OaZ35MpXsBnO95CmRB/q6PtE4a8M=;
 b=agwdvljZ+/DEh3HTXQMiNd50UDjMZnNiT5QEWtIYDHUwZhzGCVjj6rptH3nxh0JG0V
 TuA1P9VDWBIovmk0Ebsm8CnM2ydBOhQ2vl8wzfGW9tVDnebgqjB6WBzKgPBak60ItM4w
 Dp0lMmW65WToPIKIU8HLMKQjcQlcxu+NsiIs+58+S9LJgodZ5h/3j1KOYEjyV5Qi5MEX
 pcUvo+ItvtiugWooSPgmJZYuyLwfjDB6wmGt7inWwNNQl/FrvpJ5CqPC40sSSiOhubY5
 WrhYPSV0cRnWkljIhQhDf5SMzz/xkki+kKn7Gl1x/Z6vKFndFwFYAYFGqBtl8+9H/oJO
 OTJw==
X-Gm-Message-State: AOJu0YwhyI96ni4M7gSYiMfoyefp2wiCphkMw6MxqgBFvexfMHiR/G9O
 S7xgDEj3hRbYHpkTz67rjidlfiHK0HNdWcd/VnbVyYkgcdXfQ2ASruVwACWYaqaj2YaiyTcnEAv
 xg9MgXNWSqvJn8hStoVyjy3IrC4mDH8vK6eYqMYGv2YQqFi3RY4eoVbJTMpzCuOJuXFKOgyASQ2
 nvj2g=
X-Gm-Gg: AZuq6aIAZ/t9FHTrfC9Ourc2xfe9RrmghzZImc8yF9OOwd6/FhH3PPREW+foz/r2+n9
 HpbnztFf3l2XX22CiR5akvOEgyWLKzhu9iW53KN1yk5UsenMGkyJOB+OzdhEV8Sj8zxgaHRaJ+N
 C/SGWyWuxBZomjRZM2QdYsYLNRsYvWQJY1wctB58124tzi13QRvzYmAsYe42Lw5RLHnmy298/l/
 qTSPQwrO+kT0C0WOGrp3cseqzTveHfoaJyIQqPlBFZuTqXDTek3EHw5o1smIlvm6bsPiHdx26l9
 x1QZd4IbSAkwNlaqrJNTKNjIj60BTD/3q7LpzZi0p8cYADYSLFLvTQCDSzn0DXqQKblsNHIkQkv
 4+X+7Q0k5DglaVxFe1OB4Q/ggcnCVAh0tzSu9qbbtZRnAFUZqVHyjf2YG/XSwN8ieIERbnpDWEu
 E+lQ==
X-Received: by 2002:a05:600c:4688:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-48373a37a1dmr165339625e9.19.1771259871994; 
 Mon, 16 Feb 2026 08:37:51 -0800 (PST)
X-Received: by 2002:a05:600c:4688:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-48373a37a1dmr165339305e9.19.1771259871537; 
 Mon, 16 Feb 2026 08:37:51 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc8b1sm29492529f8f.23.2026.02.16.08.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 08:37:51 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <d8948f29-33d4-43ac-a487-96978c8cdd7d@gmx.de>
Date: Mon, 16 Feb 2026 17:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: U-Boot
To: Shakhrukh Shakirov <ShakirovShM@hotmail.com>
References: <DB8P192MB0712F704088804328C117F95AA6CA@DB8P192MB0712.EURP192.PROD.OUTLOOK.COM>
Content-Language: en-US
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
In-Reply-To: <DB8P192MB0712F704088804328C117F95AA6CA@DB8P192MB0712.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/16/26 11:31, Shakhrukh Shakirov wrote:
> Hi guys,
> 
> I need consultation regarding U-BOOT, how to realize following on Raspberry pi 5:
> We have 1 SD card which stores: U-BOOT, OS1, OS2, OS config
> So UBOOT starts OS1 with OS config.
>  From OS1 I can upgrade OS2, and change boot orders (so it will run not OS1, instead will run OS2 with OS config).
>  From OS2 I can update firmware of OS1.
> In case of failure of OS1 or OS2, it will run other OS version.
> With who can I consult and what would be the rate?
> 
> Thanks  in advance.
> 

Hello Shakrush,

The Raspberry Pi has a firmware that supports A/B booting without 
needing U-Boot, see

https://www.raspberrypi.com/documentation/computers/config_txt.html#example-update-flow-for-ab-booting

E.g. Ubuntu 26.04 uses this when updating the Linux kernel.

If you don't have any specific requirement that needs U-Boot (like 
loading the kernel via HTTP), I would go for the Raspberry firmware 
solution.

Best regards

Heinrich
