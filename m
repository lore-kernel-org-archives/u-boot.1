Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9219CCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFCA0800B6;
	Tue,  4 Nov 2025 22:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FuCgayAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB998391B; Tue,  4 Nov 2025 22:12:04 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA308004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c5333e7099so3649008a34.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762290720; x=1762895520; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tyxiGEezzPQJne/Sqn2uD6ssURbCRESyzMG71jg9wx8=;
 b=FuCgayAwC6vpGvSxbSnNPEc2UvKbY0jcVm9a6CgKtMm5s3LnnZeUUp8QxawIMneU+x
 3l7C9JzRooEfu3nMYl4kmHbr5Ggr9W7x3JUwqnzCbRzFJ9IU2mtAdrCdgZyrK/o9/C6q
 MML/YXO70bCEx+G1sO+KAJToOZ0gxT3zHH+4118Df3EeFINfW0eBSLzbXgr6FKY135zC
 8LOB/um0lGNdqB7CWZRMe/vyRR5ZWZxqUDrvwTv33QIOZiQrdfIe455Vw+wpRoCkJrVy
 gf/R9UvYhvsFJbIsEHK8c62CDpjuOmD//rCXAxaeyuNZO2RoUY6tZtYz94wUjekwnMAL
 mASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762290720; x=1762895520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tyxiGEezzPQJne/Sqn2uD6ssURbCRESyzMG71jg9wx8=;
 b=rSpuDRI0U2fyWa43KlZwJWgKVAaseY5CyOaUhNa4yBJvFpAFUa1b3z8xGNbtdenNR4
 oYA/rIaY0DCY7T98rj0M6ADgihgVN1WnkmuFkzWnk0m9lmUusxSUHWxwkTSHIuajiCJ5
 /QW47JxAjHVZhtSJsoOj2XiQdGxtrZ8aKUwtjawmtPwB3nOKBMRDJlJPsJebzJZYG9jd
 TmRES6dhGYhbJ9qBZblZanpqne0Tnl++kn1ka2i5zcI0I77fPCUQJIQ5VLGFfDO/WcMK
 RbfAuqomFdVbhqke1k3LF+iAFlGCTtHmswi5ya0wtonyX6xlx1Z6ycFEOSeZK8qISi32
 TwcA==
X-Gm-Message-State: AOJu0Yx6CzkeUqKrp3BdCYi/LVRuCsraU/R/MowS5Ejg1UPTmMgWZka1
 o7EAfXF+JvUvrxn8DIe/Z79yqw3HiOHv2MMAxlhUWny86RHFTt7a2MUHgEcj24hOZNOLTPNtjON
 d9DTg6gzHlqnG5xG/xqiHj3kFZyzzbs3LmDoAIWI=
X-Gm-Gg: ASbGnct1H8S4SuXJhbFgM6cs90McL+ZGIceVAfGtk8R6vDfLMRfTJ2OXiyLMbkEyYh7
 bZfFJMIXMPf/tEqwe/4+4t2FfKIfrPe8Z5vMAVIyeEgSuxgUeie0mV6XrSXidgABazX6nVmGIx5
 fcyGefhzRy5U83aUE2roxQqWseL7RUTwAvEk51BnoYUflByYybDHRK6VR12F374n6hIXKIRAWpn
 MHr75rBvl3rYTk0eWOMCnO8nYaftzYGh+LIyUqDASvXhiIHWpWkO1eZDfG2
X-Google-Smtp-Source: AGHT+IFe0PMsMZr9OLKpAz9yMJwjqZV0OyTtyQuVGd0xgI0+rMIqjEvZtTh4hRSj7xA5fGoWmN7rvr5vk/kH9lc9R+4=
X-Received: by 2002:a05:6830:4989:b0:746:d4cf:b480 with SMTP id
 46e09a7af769-7c6d12f95ecmr709618a34.6.1762290720428; Tue, 04 Nov 2025
 13:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20251104010003.525-1-briansune@gmail.com>
 <20251104175123.GE6688@bill-the-cat>
In-Reply-To: <20251104175123.GE6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 5 Nov 2025 05:11:48 +0800
X-Gm-Features: AWmQ_bnudL8V-14xsy4kg5GsPwnghIpxaV4dBJbNuk_nORKdRyvvALtnJtRlHww
Message-ID: <CAN7C2SAz828i4a4u5N7BO46H0c+hZprshM9J51duY5V_wPu-gg@mail.gmail.com>
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> currently. I also don't see that you tested this "make O=/tmp/somedir"
> (which is not the HANDOFF_PATH thing) and I expect it doesn't work there
> as it references ".config" and not "$(objdir)/.config".

Do you mean the handoff not generating?
For normal build it is still functioning, and with this config.mk
should also have
this trouble.

```
make prepare O=/tmp/test
HANDOFF_PATH=/media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0
make[1]: Entering directory '/tmp/test'
  Using /home/intel/u-boot as source for U-Boot
  GEN     Makefile
  UPD     include/generated/timestamp_autogenerated.h
[INFO] SOC family detected: cyclone5
[INFO] Using manually specified handoff folder:
/media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0
[INFO] Found hiof file:
/media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0/ddr3_5128x4_hps_0.hiof
[INFO] Running BSP generator...
python3: can't open file 'tools/cv_bsp_generator/cv_bsp_generator.py':
[Errno 2] No such file or directory
[WARN] BSP generator failed, continuing...
[DONE] SoCFPGA QTS handoff conversion complete.
make[1]: Leaving directory '/tmp/test'
```

Build capture.

```
make clean && make mrproper
  CLEAN   scripts/basic
  CLEAN   scripts/kconfig
  CLEAN   .config

make O=/tmp/test socfpga_cyclone5_defconfig
make[1]: Entering directory '/tmp/test'
  GEN     Makefile
#
# configuration written to .config
#
make[1]: Leaving directory '/tmp/test'

make O=/tmp/test
make[1]: Entering directory '/tmp/test'
  GEN     Makefile
scripts/kconfig/conf  --syncconfig Kconfig
  CFG     u-boot.cfg
  GEN     include/autoconf.mk
  GEN     include/autoconf.mk.dep
  CFG     spl/u-boot.cfg
  GEN     spl/include/autoconf.mk
  Using /home/intel/u-boot as source for U-Boot
  GEN     Makefile
  UPD     include/generated/version_autogenerated.h
  UPD     include/generated/timestamp_autogenerated.h
  UPD     include/generated/dt.h
  ENVC    include/generated/env.txt
  ENVP    include/generated/env.in
  ENVT    include/generated/environment.h
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o


~/u-boot$ ls /tmp/test/
arch    disk     examples             lib       source      u-boot
 u-boot-dtb.bin  u-boot.map        u-boot-with-spl.sfp
boot    drivers  fs                   Makefile  spl         u-boot.bin
 u-boot-dtb.img  u-boot-nodtb.bin
cmd     dts      generated_defconfig  net       System.map  u-boot.cfg
 u-boot.img      u-boot.srec
common  env      include              scripts   tools       u-boot.dtb
 u-boot.lds      u-boot.sym
```

Brian
