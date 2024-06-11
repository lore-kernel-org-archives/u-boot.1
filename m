Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE0EC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0E68861A;
	Tue, 11 Jun 2024 11:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xy7tc9lp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B89048861A; Tue, 11 Jun 2024 11:20:47 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD708862E
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42165f6645fso7585175e9.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718097645; x=1718702445;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TerKkpc17sbXbAp2r4AkLlmuAMuXHEffVhzgg4rmrUQ=;
 b=Xy7tc9lpIqGdGUpuxgbuCS4tTvfCGk1PJiqk7sAdL9OaS8G7WdEMYcb5pyQN8PHuKJ
 gpriUlP+4spNn7bjNq0WurhVsntSr5Odr8t+oA5tkU+CsPTLedItEltI8s9QuBuFf8v7
 ni9r6JU2nbQbRwDXWf3oYu9lfkvBalMR8ru3rWSEX2fWO0Tt/BiCncggAYFM9T3dvzef
 ENi9LxUNifFVTW2j6j63GkCXS9gMVqQK+bAxKEHunrQ2LT6BUAqVLEpkVrf1W/Xv4xUW
 myjJm8lD25qozR1YTWPIhWTjcqd6JLIdRYKHtUlcbpF4aCISqImX5IDFllFkjPjmkOix
 L8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718097645; x=1718702445;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TerKkpc17sbXbAp2r4AkLlmuAMuXHEffVhzgg4rmrUQ=;
 b=bZLbAd2cYbRL9ED+M05lAUQulF8djPXiKvysj7rNmTBEXNOms9bGDASZLGHlE6bzkU
 DlMizRPegr0kOCxB8C5gXkf5SOOONvpveYBarKW5XYJRbuGcGm6TVJ74pKVYlmfQOwn+
 9mGXXn3kWsUAdQq/POJKTYve2k8PYS6wtpgGFHgsE7HiOSI+fSZmwI0DvZLC7G6TVNJk
 LODDvGEgYoXXt7fKmVMVHCqVCOjqxmeYIkzI2Qua/xl74bFCLiZPMrW8KCrbiZAWuOvH
 bDH7le397pgCmSltWU1UDjV14wgB8YZEEm7GcCSeZSdvN7ko+4Ogn8c6zjolAabCQfpA
 DrZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmcpfVOLmznpF7dJBrN5HeWPNtqCWFmtr/2zFuXv9CxLM0i7dThARUwiGY6c38oCBORcbt8NR8q/WRPf6CV6xgW15E+A==
X-Gm-Message-State: AOJu0YwAw4Fs/NcHBFTG0MynUoBkIavMF9QPX/VMmJBVvSuH/yqeArV4
 VCIwVY3ep3FYeFBAGc9tBqUre1E33SZoI0B1qHG6xbm0NBJokjorJTzdvL/u5Co=
X-Google-Smtp-Source: AGHT+IH3OAvNtuBBxGK0di2HsRiYJ+cExDeH2QW5aqybsfsCm33YxrhSiC+id6czQmnViEgDppXSiw==
X-Received: by 2002:a05:600c:3108:b0:422:e8d:e554 with SMTP id
 5b1f17b1804b1-4220e8de8bdmr30849115e9.1.1718097645072; 
 Tue, 11 Jun 2024 02:20:45 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4217ff85ca6sm92573685e9.14.2024.06.11.02.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:20:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 3/6] usb: gadget: Drop usb_gadget_controller_number()
In-Reply-To: <20240611105127.3ab8cc38@wsk>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
 <20240609213449.194762-3-marek.vasut+renesas@mailbox.org>
 <877cew0wu6.fsf@baylibre.com> <20240611105127.3ab8cc38@wsk>
Date: Tue, 11 Jun 2024 11:20:41 +0200
Message-ID: <87msnrzvh2.fsf@baylibre.com>
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

Hi Lukasz,

On mar., juin 11, 2024 at 10:51, Lukasz Majewski <lukma@denx.de> wrote:

> On Tue, 11 Jun 2024 09:20:33 +0200
> Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

[...]

>
>> > -- 
>> > 2.43.0  
>
> FInally..... :-)
>
> Thanks Mattijs for this cleanup.

You should thank Marek, i've just reviewed his work :)

>
> Reviewed-by: Lukasz Majewski <lukma@denx.de>
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
