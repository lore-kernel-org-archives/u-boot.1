Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB53ECAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 12:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E88835B9;
	Wed,  1 Oct 2025 14:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="POPmSiLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E4B6835C6; Wed,  1 Oct 2025 14:03:04 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1DB800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 14:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so1805320f8f.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759320182; x=1759924982; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZ/3gt5UXplUWqedkAU+Sq7YTxpeQQ7siv2MIHSSWxQ=;
 b=POPmSiLsWHh5Sa4+J+oWRmVNSLRy+rieemWPRvrAaQVG6VdTuLcdQWeIqh7ciSoYrT
 /mP7JmawqT/I11ge7aLsh+Mf4rkK+Ze4tzBE6nncEChVYb+DCNolPCqXc4uRALCKuGSw
 woj1puMDxe9f5WQs8jJND3q7WTNq2W5L1w5GSTC4jqWDHm+TGJ6hzRp0rewdv0pL/dw8
 iB6nR9mSSWlZU/kAMoa5QodhnUOc9+/4FHCQYXiZmpo9Q5AUWSBOScgTZEAsnfGxBBrI
 wz7kUn4XkZY67hzc/vxhFM0IbkRfO9xEjUDx1SUHOPaQbmkCEsDUtY9mxPaSJvHFGVIf
 a9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759320182; x=1759924982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZ/3gt5UXplUWqedkAU+Sq7YTxpeQQ7siv2MIHSSWxQ=;
 b=Zq8Kylu7usFCYkcIBxVNMV6kWb8HwEigAnK3HQpsNI+QzbcDzo5OnP0TnAAt9E4IGd
 1QZozkgZTGYISSoG5f3wVbqpybSz3RpaiuiDvsuniqti2+OubW1+WUoOLCxj9lr1U6HQ
 d4fuRfEtVSXAJi/VE08eP2VdVt4CAZ3C138VBhmoZSTcvWjePq0HYbLLa31uWzXyRgRh
 7bKA4Mu6oyKm4qDUr2vs+Lw+ti/BuFxJgGfqNfhm1t43+vTWNvTB1y8nldmTrzEAdaL7
 vO/Y5umRGkJFIFFyXrAbnkAxSnnKrzsaJg01k/Hn3/O2F8Qz9hxzhpfZuBqvyoSWSCz6
 xZKw==
X-Gm-Message-State: AOJu0YzTc5JPcUxJGCCIqDO15S90E8xwpJzItK53yyBzDqNUhPrttOYG
 JoVdbSw4TuygtHZrYQgF0Z+/ZVDUGJTaZPbA8mAAqwZyZ9UzLjryKW2sHBMm3RfVO61SLrhGaP6
 C09GGX4fiW2NwfEZVPpDES2h5QWpiQYs=
X-Gm-Gg: ASbGnctwRT7DysKVjawxgyEJ6h2hOkm+GqH3SHbFyqhHbVJFNJqZ2rA2e+d/FiBsOcZ
 uX7epOVZUPLFAjdsYd+f2BRDy05sLv0tX4F/xGADr6sZR+kHrmJVL3pP9fzdIhOENhtripNQWe0
 jToZDmbl33tYnaHLIcxS0bkKI8HTLYVAAgi00GAwkY5W6i/+arOCCFU5RSVnjHLtHEUuwQCrigj
 +lsWJexUh/h5qqFH/AbpJZbVHxUmevq
X-Google-Smtp-Source: AGHT+IFgRGiwZ0F7BlT51HKh+Q8au5o/j5sTgd27ToR3ElzOlj6YEKlCzD4lrKKU+ixLBIdPnjM3nRPnAZJ+J1JZEXg=
X-Received: by 2002:a05:6000:200d:b0:3c8:d236:26bd with SMTP id
 ffacd0b85a97d-425577ee8dbmr2576649f8f.11.1759320181606; Wed, 01 Oct 2025
 05:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251001-video_tegra-v1-0-faaf48dad062@linaro.org>
 <20251001-video_tegra-v1-2-faaf48dad062@linaro.org>
In-Reply-To: <20251001-video_tegra-v1-2-faaf48dad062@linaro.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 1 Oct 2025 15:02:49 +0300
X-Gm-Features: AS18NWB1tF9DRrGOQVlWpmfSPa5BLIpVnGqih5tCrTPJycDuamof-S06nEhvSEc
Message-ID: <CAPVz0n2F_E2RjSfe2YB4OiiW0dfESK-wP=1VBguNpcooAPegXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] video: tegra: Incorrect operator used
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Thierry Reding <treding@nvidia.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=81=D1=80, 1 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:55=
 Andrew Goodbody <andrew.goodbody@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Combining two bits into a mask requires the use of the binary 'or'
> operator not the logical one. Correct it.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/video/tegra/tegra124/sor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>
