Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CC8C2FC08
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 21:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D08869F1;
	Wed, 20 Sep 2023 23:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EaSfxM5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06640869F4; Wed, 20 Sep 2023 23:55:38 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EE6869D8
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 23:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50325ce89e9so626642e87.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695246935; x=1695851735; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kdAirj+pyDPrjwIjjWS54ox1zwATZmJq41Takmmy6Qk=;
 b=EaSfxM5Q2hdmtUNCtYzMlUXkxjNXZQBUEY4mEINDe5ng77x0GV3PkRtVSvyP5CTO/t
 uGS22u3AqaMlDryq2qKaGGJP0KxIims9ZeDXeICRL8e7CVJPjEIE714gMeOqJNjzWxJw
 ozZBXVzLm+HKLXkvYCvQfmZddsGPzCSNsWDyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695246935; x=1695851735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdAirj+pyDPrjwIjjWS54ox1zwATZmJq41Takmmy6Qk=;
 b=ue/TtFNxPc29H0IY4MCrnHNFgDGTHCevLc5TmNWgYacNe6MdN43xVU7W/EzuYsIObz
 xCr+iOixDRFf9NpNesS6fZ31BCk0sWrvtdTNHrxRszpGhc3CGEnUkWehJZBsMt6XQ1h+
 vDV7UJpSdLwmw7mf/jJ30LtE8XlRAn7jD2Q2QUlRd8nBni1Or7Fip5+ouyAYLx2DZuin
 w27O3u8ipsUvq5IDranDYt0ODklmKu8YqAVsYzIcVhYV3vCKWMEqH5eqsKI1KFOwowBN
 ZMn3CXlrSgS0hheKuRztsjHRWRkpF1LPSC4tcP1Q8GA3fxXPFLTnIUBSPIlA1aERz9pr
 YFuA==
X-Gm-Message-State: AOJu0YziBAG5JA7GPOd/AoimkBg7vjl8sbaeIS7BnzKV4/SJUSkKvphP
 GeEvuXswDsl3j5OrtHBmFeZyT8cldSOnlPSJMYomgQ==
X-Google-Smtp-Source: AGHT+IE5gcBr68l5ByMNOzV4XdjU6+2lsmPMrojbeVS/cbZW49IuF27cILHi1NYjGvnZStF/Ef7gvojf7DiIntKKzpA=
X-Received: by 2002:a05:6512:200c:b0:4f8:71cc:2b6e with SMTP id
 a12-20020a056512200c00b004f871cc2b6emr2773180lfb.33.1695246934411; Wed, 20
 Sep 2023 14:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <77e477a1-e880-4954-b7de-a71b53fa16a6@gmx.de>
In-Reply-To: <77e477a1-e880-4954-b7de-a71b53fa16a6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 15:55:23 -0600
Message-ID: <CAPnjgZ14y4HW67UBRbyf7aU_LTXM29S43vMVcRaVO_YWTx-mkw@mail.gmail.com>
Subject: Re: [BUG] sandbox_defconfig u-boot -T crashes
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 20 Sept 2023 at 10:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Hello Simon,
>
> I have built sandbox_defconfig using origin/master
> (b9b83a86f0e8 ("Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sh"))
> on Ubuntu 23.10.
>
> Running ./u-boot -T leads to a crash:
>
> #9  0x00007ffff7a28189 in __libc_start_main_impl (main=0x555555591540
> <main>, argc=2, argv=0x7fffffffd918, init=<optimized out>,
> fini=<optimized out>, rtld_fini=<optimized out>,
>      stack_end=0x7fffffffd908) at ../csu/libc-start.c:360
> 360     in ../csu/libc-start.c
> (gdb)
> #8  0x00007ffff7a280d0 in __libc_start_call_main
> (main=main@entry=0x555555591540 <main>, argc=argc@entry=2,
> argv=argv@entry=0x7fffffffd918)
>      at ../sysdeps/nptl/libc_start_call_main.h:58
> 58      ../sysdeps/nptl/libc_start_call_main.h: No such file or directory.
> (gdb)
> #7  0x0000555555591e19 in sandbox_main (argc=2, argv=0x7fffffffd918) at
> arch/sandbox/cpu/start.c:557
> 557             board_init_r(gd->new_gd, 0);
> (gdb)
> #6  board_init_r (new_gd=<optimized out>, dest_addr=dest_addr@entry=0)
> at common/board_r.c:818
> 818             if (initcall_run_list(init_sequence_r))
> (gdb)
> #5  0x00005555555d961e in initcall_run_list
> (init_sequence=0x5555558e1860 <init_sequence_r>) at include/initcall.h:46
> 46                      ret = (*init_fnc_ptr)();
> (gdb)
> #4  0x00005555555e695d in stdio_add_devices () at common/stdio.c:332
> 332                     for (ret =
> uclass_first_device_check(UCLASS_KEYBOARD, &dev);
> (gdb)
> #3  0x00005555555f9e4f in uclass_first_device_check (devp=<optimized
> out>, id=UCLASS_KEYBOARD) at drivers/core/uclass.c:644
> 644             return device_probe(*devp);
> (gdb)
> #2  0x00005555555f7235 in device_probe (dev=0x1ac9c800) at
> drivers/core/device.c:583
>
> 583                     ret = drv->probe(dev);
> (gdb)
> #1  0x000055555560ae09 in input_stdio_register (dev=0x1aead870) at
> drivers/input/input.c:674
> 674             if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
> (gdb)
> #0  strcmp (cs=0x1 <error: Cannot access memory at address 0x1>,
> ct=0x1aead879 "ros-ec-keyb", ct@entry=0x1aead878 "cros-ec-keyb") at
> lib/string.c:217
> 217                     ret = a - b;
>
>
> env_get("stdin") returns NULL here and should not be used without checking.

Something else is wrong though, since env_get() should return the
correct value here, not NULL.

Regards,
Simon
