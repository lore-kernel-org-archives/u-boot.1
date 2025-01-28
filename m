Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CC7C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 13:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B864281DCD;
	Tue, 28 Jan 2025 14:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xMDVD5/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 429AF81DCF; Tue, 28 Jan 2025 14:54:04 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B8581DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso59996315e9.2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072441; x=1738677241; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfFLnqtrtjxD7UP8FQYlERzsgSsyK/LwppcipKGVeec=;
 b=xMDVD5/rlqq8ao9/pnwtGJ3tF9v2kYthGPeg9VxHsa/NYbgo3xYRWuQYlZ7MrvLz0C
 MBpIzE3r0oCetyP7grlgKVy5WcBKcmenw/RAz3aCW5eW1Tg0fGJWHUz2rACWy4PoedXB
 zov0bWbtZfQ8qMcg4GkYmDS4XBHesmw5+P/THzrCsyO0ECxd56XtDbPKufxX1O4I//sH
 Y4AfNuQujEfv2JRlfaTDOFlccMHi8bG7J+B2lqeGzTYVPBafIH37aH8zbSXuHuUf/U/k
 fitt2mZXQDxZF1PHaUtjJu51MfG/qZgYDUPWXxeKFRqfAtKpDJaLW2sD0YBruh5lJ2Oh
 Cn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072441; x=1738677241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfFLnqtrtjxD7UP8FQYlERzsgSsyK/LwppcipKGVeec=;
 b=ldXVqrZoEATTyaUN2AC6Tgh8PFRX2WdHDf7qRwRgnSkx2miJnUgZr2FAzadSPaznjI
 JyQ04qXRgqS7WR/4iH/f4AWyAkM/i6J1tjTQbmdi+A9z4xc94WmQQWD4RxWnUr+sybGr
 pKQxPfGVpJc208SkO/1uEqmB3U5NbZGN0AwxvAYrUSjIXeFtgbBAt6GXNuWA4GMvK8e2
 A3/me7QrNqxMDmkBuZ+W/zuBb2VvngxClxHo9dtkF//t+pJkupxkSODxxgeAYE5pHXRC
 st1PdQgCKYtbBvcMt2Pr++l2eD904llVnW6m/ac0++GJ5+8qLJLQHMvlgiNMdaVrKCnU
 bh8g==
X-Gm-Message-State: AOJu0YyZtyO5JlTl2jQdvOFjnzrMRDpMjU/lw5Z5nbceMD7tBLw5tmzu
 0PobhLmOLULUZEdJparN2wClqTPvFfo7UcYeL5AMh1sfYlbHNNjs4UVt2pl30D3NMTiGQldsC8F
 pL8dicA==
X-Gm-Gg: ASbGnctvDDYZkUiRgfwyvNI4GUTgjXDoXrAvqeGMVIvrToCyhMyc/diltI/QyDlwV4N
 GxgBK1hK3UjnXeKYxDGPSqCyom+2GRUjpmzs/My3I7GMjvSHLzXN7tvu6A/N8W6Db0IgjceJeto
 87qLGlx3b29ktKBsCfa3w84lc/xwddSjAUvpHmNj1rcFdYfiby2ZNTN6dw24LOH7YR/sVQ6oVZt
 RbyxmULvfvnck2C98byRaNd2zeDU84C6ri7CJffA+gTkwFTv0Vfrz8tY4n5J/d5pTlosuaJbzHC
 5yABfcnGNpRFExLSTbCSEKs8Fg==
X-Google-Smtp-Source: AGHT+IEaxE2kCq4blkrfV9knTfz3MvXjhC+P3AtkuLuzUc/N4yRvr5vyTYF75vvAK+B/duFkanchvA==
X-Received: by 2002:a05:600c:4713:b0:436:9227:915 with SMTP id
 5b1f17b1804b1-438913caa3cmr349094495e9.9.1738072441312; 
 Tue, 28 Jan 2025 05:54:01 -0800 (PST)
Received: from [10.100.0.2] ([45.84.137.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd485695sm168555055e9.14.2025.01.28.05.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 05:54:01 -0800 (PST)
Message-ID: <f5237f0f-c66c-4d20-b11c-af77d49460a5@linaro.org>
Date: Tue, 28 Jan 2025 14:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/3] usb: scan multiple buses simultaneously with
 coroutines
To: Michal Simek <monstr@monstr.eu>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dragan Simic <dsimic@manjaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <cover.1738059345.git.jerome.forissier@linaro.org>
 <58d6721203ea81b9c20f162ef40f79bc73243a42.1738059345.git.jerome.forissier@linaro.org>
 <CAHTX3d+-oy8h=Y1u5iQz-O5fSAEqaKezd3_sTwajgoWedWX9UQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAHTX3d+-oy8h=Y1u5iQz-O5fSAEqaKezd3_sTwajgoWedWX9UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 1/28/25 12:58, Michal Simek wrote:
> Hi,
> 
> út 28. 1. 2025 v 11:20 odesílatel Jerome Forissier
> <jerome.forissier@linaro.org> napsal:
>>
>> Use the coroutines framework to scan USB buses in parallel for better
>> performance. Tested on arm64 QEMU on a somewhat contrived example
>> (4 USB buses, each with one audio device, one keyboard, one mouse and
>> one tablet).
>>
>> $ make qemu_arm64_defconfig
>> $ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>> $ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin \
>>     $(for i in {1..4}; do echo -device qemu-xhci,id=xhci$i \
>>         -device\ usb-{audio,kbd,mouse,tablet},bus=xhci$i.0; \
>>     done)
>>
>> The time spent in usb_init() is reported on the console and shows a
>> significant improvement with COROUTINES enabled.
>>
>> ** Without COROUTINES
>>
>>  Bus xhci_pci: Register 8001040 NbrPorts 8
>>  Starting the controller
>>  USB XHCI 1.00
>>  Bus xhci_pci: Register 8001040 NbrPorts 8
>>  Starting the controller
>>  USB XHCI 1.00
>>  Bus xhci_pci: Register 8001040 NbrPorts 8
>>  Starting the controller
>>  USB XHCI 1.00
>>  Bus xhci_pci: Register 8001040 NbrPorts 8
>>  Starting the controller
>>  USB XHCI 1.00
>>  scanning bus xhci_pci for devices... 6 USB Device(s) found
>>  scanning bus xhci_pci for devices... 6 USB Device(s) found
>>  scanning bus xhci_pci for devices... 6 USB Device(s) found
>>  scanning bus xhci_pci for devices... 6 USB Device(s) found
>>  USB: 4 bus(es) scanned in 5873 ms
>>
>> ** With COROUTINES
>>
>>  Bus xhci_pci: Register 8001040 NbrPorts 8
>>  Starting the controller
>>  USB XHCI 1.00
>>  Bus xhci_pci: Register 8001040 NbrPorts 8
>>  Starting the controller
>>  USB XHCI 1.00
>>  Bus xhci_pci: Register 8001040 NbrPorts 8
>>  Starting the controller
>>  USB XHCI 1.00
>>  Bus xhci_pci: Register 8001040 NbrPorts 8
>>  Starting the controller
>>  USB XHCI 1.00
>>  Scanning 4 USB bus(es)... done
>>  Bus xhci_pci: 6 USB device(s) found
>>  Bus xhci_pci: 6 USB device(s) found
>>  Bus xhci_pci: 6 USB device(s) found
>>  Bus xhci_pci: 6 USB device(s) found
>>  USB: 4 bus(es) scanned in 2213 ms
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  drivers/usb/host/usb-uclass.c | 152 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 149 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
>> index bfec303e7af..3104efe7f9e 100644
>> --- a/drivers/usb/host/usb-uclass.c
>> +++ b/drivers/usb/host/usb-uclass.c
>> @@ -9,6 +9,7 @@
>>  #define LOG_CATEGORY UCLASS_USB
>>
>>  #include <bootdev.h>
>> +#include <coroutines.h>
>>  #include <dm.h>
>>  #include <errno.h>
>>  #include <log.h>
>> @@ -18,6 +19,8 @@
>>  #include <dm/lists.h>
>>  #include <dm/uclass-internal.h>
>>
>> +#include <time.h>
>> +
>>  static bool asynch_allowed;
>>
>>  struct usb_uclass_priv {
>> @@ -221,6 +224,40 @@ int usb_stop(void)
>>         return err;
>>  }
>>
>> +static int nbus;
>> +
>> +#if CONFIG_IS_ENABLED(COROUTINES)
>> +static void usb_scan_bus(struct udevice *bus, bool recurse)
>> +{
>> +       struct usb_bus_priv *priv;
>> +       struct udevice *dev;
>> +       int ret;
>> +
>> +       priv = dev_get_uclass_priv(bus);
>> +
>> +       assert(recurse);        /* TODO: Support non-recusive */
>> +
>> +       debug("\n");
>> +       ret = usb_scan_device(bus, 0, USB_SPEED_FULL, &dev);
>> +       if (ret)
>> +               printf("Scanning bus %s failed, error %d\n", bus->name, ret);
>> +}
>> +
>> +static void usb_report_devices(struct uclass *uc)
>> +{
>> +       struct usb_bus_priv *priv;
>> +       struct udevice *bus;
>> +
>> +       uclass_foreach_dev(bus, uc) {
>> +               priv = dev_get_uclass_priv(bus);
>> +               printf("Bus %s: ", bus->name);
>> +               if (priv->next_addr == 0)
>> +                       printf("No USB device found\n");
>> +               else
>> +                       printf("%d USB device(s) found\n", priv->next_addr);
>> +       }
>> +}
>> +#else
>>  static void usb_scan_bus(struct udevice *bus, bool recurse)
>>  {
>>         struct usb_bus_priv *priv;
>> @@ -240,7 +277,81 @@ static void usb_scan_bus(struct udevice *bus, bool recurse)
>>                 printf("No USB Device found\n");
>>         else
>>                 printf("%d USB Device(s) found\n", priv->next_addr);
>> +       nbus++;
>>  }
>> +#endif
>> +
>> +#if CONFIG_IS_ENABLED(COROUTINES)
>> +extern int udelay_yield;
>> +
>> +static void usb_scan_bus_co(void)
>> +{
>> +       usb_scan_bus((struct udevice *)co_get_arg(), true);
>> +       co_exit();
>> +}
>> +
>> +static struct co_stack *stk;
>> +static struct co *main_co;
>> +static struct co **co;
>> +static int co_sz = 8;
>> +
>> +static int add_usb_scan_bus_co(struct udevice *bus)
>> +{
>> +       if (!co) {
>> +               co = malloc(co_sz * sizeof(*co));
>> +               if (!co)
>> +                       return -ENOMEM;
>> +       }
>> +       if (nbus == co_sz) {
>> +               struct co **nco;
>> +
>> +               co_sz *= 2;
>> +               nco = realloc(co, co_sz * sizeof(*co));
>> +               if (!nco)
>> +                       return -ENOMEM;
>> +               co = nco;
>> +       }
>> +       if (!main_co) {
>> +               main_co = co_create(NULL, NULL, 0, NULL, NULL);
>> +               if (!main_co)
>> +                       return -ENOMEM;
>> +       }
>> +       if (!stk) {
>> +               stk = co_stack_new(32768);
>> +               if (!stk)
>> +                       return -ENOMEM;
>> +       }
>> +       co[nbus] = co_create(main_co, stk, 0, usb_scan_bus_co, bus);
>> +       if (!co[nbus])
>> +               return -ENOMEM;
>> +       nbus++;
>> +       return 0;
>> +}
>> +
>> +static void usb_scan_cleanup(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < nbus; i++) {
>> +               co_destroy(co[i]);
>> +               co[i] = NULL;
>> +       }
>> +       nbus = 0;
>> +       co_destroy(main_co);
>> +       main_co = NULL;
>> +       co_stack_destroy(stk);
>> +       stk = NULL;
>> +}
>> +#else
>> +static int add_usb_scan_bus_co(struct udevice *bus)
>> +{
>> +       return 0;
>> +}
>> +
>> +static void usb_scan_cleanup(void)
>> +{
>> +}
>> +#endif
>>
>>  static void remove_inactive_children(struct uclass *uc, struct udevice *bus)
>>  {
>> @@ -289,6 +400,7 @@ static int usb_probe_companion(struct udevice *bus)
>>
>>  int usb_init(void)
>>  {
>> +       unsigned long t0 = timer_get_us();
>>         int controllers_initialized = 0;
>>         struct usb_uclass_priv *uc_priv;
>>         struct usb_bus_priv *priv;
>> @@ -355,10 +467,40 @@ int usb_init(void)
>>                         continue;
>>
>>                 priv = dev_get_uclass_priv(bus);
>> -               if (!priv->companion)
>> -                       usb_scan_bus(bus, true);
>> +               if (!priv->companion) {
>> +                       if (CONFIG_IS_ENABLED(COROUTINES)) {
>> +                               ret = add_usb_scan_bus_co(bus);
>> +                               if (ret)
>> +                                       goto out;
>> +                       } else {
>> +                               usb_scan_bus(bus, true);
>> +                       }
>> +               }
>>         }
>>
>> +#if CONFIG_IS_ENABLED(COROUTINES)
>> +       {
>> +               bool done;
>> +               int i;
>> +
>> +               printf("Scanning %d USB bus(es)... ", nbus);
>> +               udelay_yield = 0xCAFEDECA;
>> +               do {
>> +                       done = true;
>> +                       for (i = 0; i < nbus; i++) {
>> +                               if (!co[i]->done) {
>> +                                       done = false;
>> +                                       co_resume(co[i]);
>> +                               }
>> +                       }
>> +               } while (!done);
>> +               udelay_yield = 0;
>> +               printf("done\n");
>> +
>> +               usb_report_devices(uc);
>> +       }
>> +#endif
>> +
>>         /*
>>          * Now that the primary controllers have been scanned and have handed
>>          * over any devices they do not understand to their companions, scan
>> @@ -388,7 +530,11 @@ int usb_init(void)
>>         /* if we were not able to find at least one working bus, bail out */
>>         if (controllers_initialized == 0)
>>                 printf("No USB controllers found\n");
>> -
>> +out:
>> +       if (nbus)
>> +               printf("USB: %d bus(es) scanned in %ld ms\n", nbus,
>> +                      (timer_get_us() - t0) / 1000);
>> +       usb_scan_cleanup();
>>         return usb_started ? 0 : -ENOENT;
>>  }
>>
>> --
>> 2.43.0
>>
> 
> I have tested it on kr260 which is using 2 usb interfaces and there is
> an issue with usb hub initialization.
> That board has two hubs connected over i2c and only one of them is
> initialized over i2c.
> It means there is some work which needs to happen and likely some
> locking should be in place.

Hmmmm... I was kind of expecting that :-/ Do you think the kv260 has a
similar problem? If so I can use mine to troubleshoot.

Thanks,
-- 
Jerome

> Thanks,
> Michal
> 
