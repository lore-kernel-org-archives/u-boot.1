Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34A3CD342F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 07:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 205BD888C2;
	Tue,  3 Sep 2024 09:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g7WvU29c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6512888A27; Tue,  3 Sep 2024 09:42:20 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F40885A0
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 09:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42c7856ed66so23492475e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725349338; x=1725954138;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bSo7wPFr31kW34M+DkuiN5n5elYQ9XRGVElF1IpbxhE=;
 b=g7WvU29cVgCUOwhWOZHtxHVEK/5VTr11SE/EQJaI40GO9/JZK+lzVGBZRCVHzEC8eA
 MmIcZpTyn34LnMiGwBTF/R+pU1KoKntQ32rMUpUBxuKTme3b+oDVqoYIld64qHVlmwAV
 Kxa0gx1//IHNLKRl0vFgaJJ34ax9ru6AF4RwGT3fRB+tjNNF0oUdrgArE36nTBMttKz2
 qOXkZMFnoQ4CzathtcpUXsKhfu8ZYjd5/p7FjjD86adnA9w2ArfLTUjletVJ4Yyhry7S
 CDCKHREBoKtwhJyNAN73rqwg3OwWukbXnQdgNC2fQVtXGOpNNWwErXfoB2xMLL7pe9nQ
 eMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725349338; x=1725954138;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSo7wPFr31kW34M+DkuiN5n5elYQ9XRGVElF1IpbxhE=;
 b=o3cXNuup+hF7uRwc4b10UrooB9P2jxTpGe3aZo7KI5sBHc2DZ0pNTuLhQL9oMzQ0VT
 w/DvsIj3IgpHNc0M7QR67levFjEXdvOYopTji0UYSTeBm5YbeX6dR13Z5YLDfV6pnhTz
 ihGE7mxXTW85C3KIkXqSxux7OlO3+CaRDgrslRtBavbOv19lu2XAJdRr3kaiOE67IpfM
 HHnS/rk0X+hfArY7Cl4iRE3/55e53bFzHX8rWKPBTmBaalXxOIWbVTP6h+gXKBq1y/Gt
 X9aWySnGUHtLlzByeJBhJYJp0iXthtRHhU3f5UCwe6pPoYVWxqBH6vPljj3AlXX+Eryu
 qVXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW12Ihjydcu/SMgfzYZKT3GO1LZbgU99YD1jl4ArtKb4J9ZZMfEsO2I9SHGYIlPjyiQlaaBTRM=@lists.denx.de
X-Gm-Message-State: AOJu0YwYVze/gPXBC82LDfvFlLEzZn3ZviCZcQxvQ/Foq8WztdP8DgL/
 Kr5nofy/QtRbv464kT/7w1JDXyizW8tZWVWKHb3e7rRBvAa1PmnBX+6DfdGXT0g=
X-Google-Smtp-Source: AGHT+IEzmWuX4WYa+sg7ZvnGdvbUjL1sKzy/nvHmBk/k2o2QacINlX4vBTdN/MvCsPTEuseFbbzV8w==
X-Received: by 2002:a05:600c:444c:b0:427:ff3b:7a20 with SMTP id
 5b1f17b1804b1-42bb27a9c9dmr130966715e9.27.1725349337002; 
 Tue, 03 Sep 2024 00:42:17 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c6543ee3sm6386662f8f.12.2024.09.03.00.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 00:42:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] mmc: Hide mmc speed command under mmc command
In-Reply-To: <26339e14-1d8a-4471-acdc-902d0ef2ed54@cherry.de>
References: <20240902133721.18938-1-marek.vasut+renesas@mailbox.org>
 <26339e14-1d8a-4471-acdc-902d0ef2ed54@cherry.de>
Date: Tue, 03 Sep 2024 09:42:14 +0200
Message-ID: <87v7zd6v55.fsf@baylibre.com>
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

On lun., sept. 02, 2024 at 15:41, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Marek,
>
> On 9/2/24 3:37 PM, Marek Vasut wrote:
>> The mmc speed command configuration option keeps showing up in
>> Kconfig directly in 'Command line interface'. Move MMC_SPEED_MODE_SET
>> under CMD_MMC to make it show up alongside the MMC command.
>> 
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
>> Cc: Francis Laniel <francis.laniel@amarulasolutions.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> V2: Rework the commit message
>
> Better, thanks :)
>
>> ---
>>   cmd/Kconfig | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>> 
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 43f78a5aeb1..953e1f0ef2a 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -1406,6 +1406,15 @@ config CMD_MMC_SWRITE
>>   	  Enable support for the "mmc swrite" command to write Android sparse
>>   	  images to eMMC.
>>   
>> +config MMC_SPEED_MODE_SET
>
> I'm wondering if we should prefix this with CMD_ maybe? It's used in 
> drivers/mmc/ though.
>
> Anyway, not a blocker for this.
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> (You forgot Mattijs's Rb from v1 BTW)

Giving it again, thank you for noticing :)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> Thanks!
> Quentin
