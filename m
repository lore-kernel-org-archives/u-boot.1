Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA9FCF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D592089202;
	Thu, 19 Sep 2024 16:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O2A2N1Ve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780FE89202; Thu, 19 Sep 2024 16:11:58 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377488920F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso626686a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755115; x=1727359915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=84xmllLzcNWq6sR2aesI/kmuvgMCEaVimg6P8MHvCbk=;
 b=O2A2N1VeeTwCNti6Wpv2/w9CYyF3B94wm9Sloe6Y2OqXojPesI+siykZG6dHv4VpPJ
 y5knmgEj0Qhz4KkhjYF1W300Q0pAYo0bmWBrADwLwxCwzf1ewMjfr7szyy04IvU6YV+x
 oUmkn0mXLr+CT/euFfrOfSwGKeNv9e3qRFj4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755115; x=1727359915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=84xmllLzcNWq6sR2aesI/kmuvgMCEaVimg6P8MHvCbk=;
 b=e5E2cPzdJovpyvc1B529RAQapL+Qrbx702Z2axDwWLRPwHOwyT9JZzIvhQVNmHiOGA
 eCrgzlba28daefkhfrNucDAreF62zVXqdabZLSLDcQGTVKjM6PyjVLNo0EEvpZHTe6MZ
 0qstG+sfnc+jIfkDAUVZ2Qikeb9ymjN5jwSMpc6RtE/f79Y4XnvnAT/w6cNJ5xtbbbp8
 D+Rp/EtTLvIkEmtJu16H0LXAkTUu/Qg14cvJNK+hSiWtW3g3ZE6rPgCFWiRQuz9Cr2or
 YGCVbPCAw4Wd4uAgs3MlHi09X1TW2/Aml3HtwrTONw02F7Z5RimAG1mUx6WbJKnnN9I/
 nxaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRA4cOjZwfIUIs2mR0qGbulnVcDriwMTpOutv5riK6yr3HB7fnuvviljeJ8oGw6ivaCLYpQ9I=@lists.denx.de
X-Gm-Message-State: AOJu0YxpcEBZ7JoCRQYJXEWrQp1HYTl0haHxVDlCfk1zNGx8ohcEmWCk
 /ViLGUP3x3G/e1yKlNKwiVbwVrtq/CVjFT9D3qJx6++aP6Hw4iQEKQsdusiZn/0pZSFdEsgIRTe
 Fzy+8IJGgiC/8ky9VPNOW1hFr4ii6Qr+52nwe
X-Google-Smtp-Source: AGHT+IEmM4wOwPpFxmcNa5dtidH1h/ByC5Gba+xKb2hg+x+dgofAM6uRLeZO7bc0jjcsu9Fseh65hWKh6uWpl2TnFEw=
X-Received: by 2002:a05:6a20:c888:b0:1cf:4102:9762 with SMTP id
 adf61e73a8af0-1cf76244cbemr31981253637.42.1726755114820; Thu, 19 Sep 2024
 07:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240902190459.13783-1-herman@rimm.ee>
 <c56191d9f088cc52844d3cb1c7eec0f413745b2d.1726507300.git.herman@rimm.ee>
 <87jzfbl371.fsf@wireframe>
In-Reply-To: <87jzfbl371.fsf@wireframe>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:43 +0200
Message-ID: <CAFLszTgMRRFiLVMq8YAHFc355LoT-Jmk77E1CweYUzoJffd4vw@mail.gmail.com>
Subject: Re: u-boot: rpi: Enlarge space available for kernel.
To: Vagrant Cascadian <vagrant@debian.org>
Cc: Herman Rimm <herman@rimm.ee>, 72987@debbugs.gnu.org, 
 Efraim Flashner <efraim@flashner.co.il>, u-boot@lists.denx.de, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
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

Hi,

On Mon, 16 Sept 2024 at 23:06, Vagrant Cascadian <vagrant@debian.org> wrote:
>
> On 2024-09-16, Herman Rimm wrote:
> > --- /dev/null
> > +++ b/gnu/packages/patches/u-boot-50M-kernel.patch
> > @@ -0,0 +1,51 @@
> > +This patch configures the U-Boot for Raspberry Pis to reserve 50 MB for
> > +linux kernels, because the 6.9 and newer linux-libre-arm64-generic
> > +kernels can be larger than 36 MB.  It was created by Herman Rimm
> > +<herman@rimm.ee> in August 2024 and is not submitted upstream yet.
> > +diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> > +index 30228285ed..54a8e9e5ae 100644
> > +--- a/board/raspberrypi/rpi/rpi.env
> > ++++ b/board/raspberrypi/rpi/rpi.env
> > +@@ -43,22 +43,22 @@ dfu_alt_info+=zImage fat 0 1
> > +  *   text_offset bytes (specified in the header of the Image) into a 2MB
> > +  *   boundary. The 'booti' command relocates the image if necessary. Linux uses
> > +  *   a default text_offset of 0x80000.  In summary, loading at 0x80000
> > +- *   satisfies all these constraints and reserving memory up to 0x02400000
> > +- *   permits fairly large (roughly 36M) kernels.
> > ++ *   satisfies all these constraints and reserving memory up to 0x03400000
> > ++ *   permits fairly large (roughly 50M) kernels.
> > +  *
> > +  * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
> > +  * conflict with something else. Reserving 1M for each of them at
> > +- * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> > ++ * 0x03200000-0x03300000 and 0x03300000-0x03400000 should be plenty.
> > +  *
> > +  * On ARM, both the DTB and any possible initrd must be loaded such that they
> > +  * fit inside the lowmem mapping in Linux. In practice, this usually means not
> > +  * more than ~700M away from the start of the kernel image but this number can
> > +  * be larger OR smaller depending on e.g. the 'vmalloc=xxxM' command line
> > +  * parameter given to the kernel. So reserving memory from low to high
> > +- * satisfies this constraint again. Reserving 1M at 0x02600000-0x02700000 for
> > +- * the DTB leaves rest of the free RAM to the initrd starting at 0x02700000.
> > ++ * satisfies this constraint again. Reserving 1M at 0x03400000-0x03500000 for
> > ++ * the DTB leaves rest of the free RAM to the initrd starting at 0x03500000.
> > +  * Even with the smallest possible CPU-GPU memory split of the CPU getting
> > +- * only 64M, the remaining 25M starting at 0x02700000 should allow quite
> > ++ * only 64M, the remaining 11M starting at 0x03500000 should allow quite
> > +  * large initrds before they start colliding with U-Boot.
> > +  */
> > + #ifdef CONFIG_ARM64
> > +@@ -69,9 +69,9 @@ fdt_high=ffffffff
> > + initrd_high=ffffffff
> > + #endif
> > + kernel_addr_r=0x00080000
> > +-scriptaddr=0x02400000
> > +-pxefile_addr_r=0x02500000
> > +-fdt_addr_r=0x02600000
> > +-ramdisk_addr_r=0x02700000
> > ++scriptaddr=0x03200000
> > ++pxefile_addr_r=0x03300000
> > ++fdt_addr_r=0x03400000
> > ++ramdisk_addr_r=0x03500000
> > +
> > + boot_targets=mmc usb pxe dhcp
>
> I would really like to hear comments from the upstream u-boot
> maintainers on adjusting these values...

It is fine to adjust them, so long as the memory is actually there. I
don't know of anything special about the current values.

Regards,
Simon
