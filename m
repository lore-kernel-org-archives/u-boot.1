Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800CAD6A25C
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9114896A5;
	Fri, 15 Nov 2024 15:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JHtp4jpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A731189358; Fri, 15 Nov 2024 15:21:27 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2EAA896AA
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso238118866b.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680485; x=1732285285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QF74F5sLUcvIym87ChDdrd+W5c5iVBLCq8RmJuM39AM=;
 b=JHtp4jpC5QwWlrxAR1w/Pylz3xMVCRBXqAwb0F5dsF62WbUgncPS7RTGa4gAVbQNY7
 zHHSqHLj40kXA2zMTAvnoR7q0qMqcMrZBogWKQ6D/CKCxrNxHtLk30uABhZhBj8hBPPT
 HHm3k4PPspx/K99Wq+yvbITBGf9ekAfjASsxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680485; x=1732285285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QF74F5sLUcvIym87ChDdrd+W5c5iVBLCq8RmJuM39AM=;
 b=t9E3HzHXwLJn9XRuxl6SLT3FqsgNHMqIooivAiGNKF6jLY5cbXfkKJ9kcehxBAR2cl
 kVm8H7yciYs1UkDvsBqiZfKtMcwNrH4VnMGPMhBHoyjSp+2InFTqwjzKngaW+KBaswsh
 upd9TpsbqRAu9K7mFnngSp+Yu6vx76NxwoS4h9zRypWnVJLEPAX660ByxZxLzKlKwyzs
 eKvNqWbzK3owqJAgGIc+0ttv3qiogiuiz/S9rmReuzTNbePMTal4EPVsVYPVXZbeiY8Y
 8UvVmNAQqWIc9wjtauRp3sAiPqFShsfBJkepv21xtnSIB1Rcn5F7q5H02hDnPoJCbAcp
 LWcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVentWWgeKGkPYNdHEGm6LEmjCrlseDki9c/1ynXk1pIZOG7zJPzs3iWdJzNfSe88VaXRFVvT4=@lists.denx.de
X-Gm-Message-State: AOJu0YxZaVNMLono9zLTDaVlem70KGoLQhMDHz3+S8eYq6o+eGwA/PQS
 OHk4WhYijxbihvDwQYXVHaqZfOuW0tOs7cCD6EL4gw4tFyLbGBnDmEUsvL00lNHk0MNdIEEHq4/
 OqPUQnpkpRPhBjDAXSsXI/TidjPtBS0FUlYMf
X-Google-Smtp-Source: AGHT+IGSYJkFY0V/I1u+9/unbSxUQq2XJqdOJzt1jHyfwXunQ6fbA/1QFfZ6RH3oNXF9mXUb8LDYulFawaS2+23Abpc=
X-Received: by 2002:a17:907:7f1e:b0:a99:4615:f58c with SMTP id
 a640c23a62f3a-aa4833f6697mr247445066b.2.1731680485132; Fri, 15 Nov 2024
 06:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
 <80ee6e68-cfb5-4144-aa99-88e52420cba9@kwiboo.se>
 <CAM=mAOk4ZeF5wuNNmOZYwFL8Bhb64otKKnKkiGZyZZkXQywdfA@mail.gmail.com>
In-Reply-To: <CAM=mAOk4ZeF5wuNNmOZYwFL8Bhb64otKKnKkiGZyZZkXQywdfA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:21:11 -0700
Message-ID: <CAFLszTgVWKUhVrBNT5bEUMwKUX5sTKmGDwYGQxk7VJDSikiwjw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Thu, 14 Nov 2024 at 14:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Jonas Karlman <jonas@kwiboo.se> schrieb am Do., 14. Nov. 2024, 21:26:
>>
>> Hi Heinrich,
>>
>> On 2024-11-13 20:55, Heinrich Schuchardt wrote:
>> > Some hard devices need specific routines to scan for block devices,
>> > e.g. NVMe (nvme scan), SCSI (scsi start).
>> >
>> > Invoke bootdev_hunt() to find all block devices.
>> >
>> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > ---
>> >  lib/efi_loader/efi_setup.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>> > index aa59bc7779d..8e0ff16f3eb 100644
>> > --- a/lib/efi_loader/efi_setup.c
>> > +++ b/lib/efi_loader/efi_setup.c
>> > @@ -7,6 +7,7 @@
>> >
>> >  #define LOG_CATEGORY LOGC_EFI
>> >
>> > +#include <bootdev.h>
>> >  #include <efi_loader.h>
>> >  #include <efi_variable.h>
>> >  #include <log.h>
>> > @@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
>> >        * Probe block devices to find the ESP.
>> >        * efi_disks_register() must be called before efi_init_variables().
>> >        */
>> > +     if (CONFIG_IS_ENABLED(BOOTSTD)) {
>> > +             int r;
>> > +
>> > +             r = bootdev_hunt(NULL, 0);
>> > +             if (r)
>> > +                     log_debug("No boot device available\n");
>> > +     }
>> >       ret = efi_disks_register();
>> >       if (ret != EFI_SUCCESS)
>> >               goto out;
>>
>> This is causing significant slower boot when trying to boot using
>> extlinux (or script) from mmc device on Rockchip, this will cause all
>> slow devices to be initialized before a quick mmc boot, e.g. pci init,
>> usb start and dhcp due to efi_mgr being the global bootmeth.
>
>
> Specifically DHCP is very slow and not needed here.
>
> Maybe Simon has an idea how to filter it out. We should filter on UCLASS_BLK related here.

Each bootdev has a prio field which indicates how slow it is, so you
could have something which only runs the hunters for a certain
priority. bootstd does this automatically (going from fastest to
slowest), but bootmgr would need to handle that itself.

Perhaps call bootdev_hunt_prio() with just a few priorities?

>
> Furthermore I don't know if global bootmeths are always have to run first or if you could customize this.

They run first, but we could change that.

Regards,
Simon
Regards,
Simon
