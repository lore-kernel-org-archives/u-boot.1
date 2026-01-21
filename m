Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2D6C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C30C583A1E;
	Thu, 22 Jan 2026 00:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nWNv9XSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BBF783A6A; Thu, 22 Jan 2026 00:24:15 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2625C8313B
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-5eef115c781so155010137.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 15:24:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769037852; cv=none;
 d=google.com; s=arc-20240605;
 b=IGpEUBztMIrwSzMuXOx45VZnn53Y7nfyfJqZFrXujKaUUqiDkW2C5Ed83QZapQ2AUb
 Qqihq+tfxDdpdA0qknl5J5rxEj+MHT5HyShvYBZbefVf3DJDG0eXPjUlpbtPoTWXNkqL
 e/kTrSRjnZwEfxzhcCBlV9TOuZkkGjK3MHE737ssOeTEziYkZkYZO4DcbhsakrZU5At4
 UYCK159Eu/OyiB4aODiWg4zPrJ38QSPqAACVaHsKEpu0pe7S0xDIX5eoudBFp3pZVO/i
 n7t1vnaba00WFLEiTeTdksh6xMzaXWHadQUDfx+TNUD3930rfCKHRzlzkFOxV9CJkbGj
 9RLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cCDcSDydTLXOlZ3TA5qTZYd0Nv+S/77Xj6414PPERZk=;
 fh=GS5XrplfQdUIvoEGSgbap2KiZDVxNyY+j4cdU/9iaBs=;
 b=MqplwgxxcigcSfveLCQwodCfrr2suREKGUTfQecrJGwHULbscC4l8SO1spYcf/paUP
 eA9qdQ5APLhQtdBmsdNID3l0mRhKqyqzAI5TjCDA96DjYjnozM8KJll1X3trk4qG7dTn
 WsdLZIyC7pieGPxsOUrUhmjX1Yuf9Xgl+pl3cfuD57bro/Sntfv6+lBJ5xfCymaYjRGa
 35nkX1zS038CAqC6oRS0gsXGIaGW2Hyfv3yCmgJEiSD5HEy1Wma6ySbz4iYbqudM4Tc8
 UwKab0mJ2sDcbQbVg/SkKZKZ7SRxlbZ84Lp8DeLWoDnqP5lGc4+WzWAh2xr9opoHQpyQ
 cZYg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769037852; x=1769642652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cCDcSDydTLXOlZ3TA5qTZYd0Nv+S/77Xj6414PPERZk=;
 b=nWNv9XSd0qkQHpIGd/4oq2UkKNaeNm3dOaX+iZRnW9jMPrTZf+Lf40uZUnnXjW97v3
 7Nwn/SBphfF31TZUSnsDZDckflugmpKnr8rI6TY9YGs3yVk7UiJEJxsmgHLM9z3ZlKi4
 Z2HP/Cnrv8QXqPdHYcB20hkJ5p+sLElXwrIyyG0BI0i6Ikn6kXzOOpgnijAFvxmHZZdd
 PmVHVgOMO/cy8edChimX8DkmkjSgq7mi9p4rA1ynhnftx/CQteyyGVc+FGLIB214bOCW
 RVF1qwSLfVkP5MBYV2CLZzMg1+Lrn0HTs1gdlmOPgw5OW8wk2p5qtUJnQN15vUAohNr2
 m9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769037852; x=1769642652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCDcSDydTLXOlZ3TA5qTZYd0Nv+S/77Xj6414PPERZk=;
 b=QbczflihpGCBnZLbtlPgLAyQQkOsVLzwxvLC/VgBOKU6JQ16S/2rAgVNGgZ1eS+ScZ
 Z7QehVthcjOQu2oyFcj9MDxsRCh0hzZu56zXWstumaO6KeNY/dgw4AC3n//Ofm6YiQzK
 KwFS2jbLy2BtKVlRfms3dZbXNntTW5bVTGuFzbMw7j7BJdTY5klsm8Rwrb0bejH2UDoV
 T+3T+nz217ytTn7B3FZ4HmQriwk1yS8uWxMIC/M6TX8acTORkPgzLaw6m7nAAmz0uJwq
 0MDMZl8cNKsYbXS+V3Qtr1RjQRqL87K4etb1ZgFn352R+ASYEB9s6NEn0+LlJstHGu3A
 R+Fw==
X-Gm-Message-State: AOJu0Yz6nb3C4hLU7SyCEgJUmfqn1YF/GXLlEMmjR7uxVECCnkAv90hC
 iiGWNw/q5tSCoQPGIkrh88R1tZI/qFbsPyZwrW7ms/NEVk4HnKBZBj6aMsDiejCn6iNc4eRYKyS
 VCITKBv6b0n8np38QWHyT2dnDVMY1kDE=
X-Gm-Gg: AZuq6aKn2w48msgdWv/LVNewmyJr5rKselQZxkCehkEHzyX9qOlvq/xVEXLj65V4IHW
 OIZQrmwkWOpzY13QgNh7C6WPcVvcAb+SX1qicvM+0KQWRkfnD1hsEtdkB9JLKHSg6zJevUeP68c
 R3/hoZnaUAm9BBNjHZfLyili8bgMC0MeP9pN8qcy/YHuj8Mbhqq6LslJOFR6B8En6Ig6yP8VBgp
 HpEEBFJ1YoSqlhST0rTsJzcvFirUg1wgQdBNMUl8cFrW3xF528khq0e9vaiY98Oum4fup68
X-Received: by 2002:a05:6102:370c:b0:5db:fce3:af8b with SMTP id
 ada2fe7eead31-5f1a5381ff0mr6019896137.12.1769037851864; Wed, 21 Jan 2026
 15:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-15-raymondmaoca@gmail.com> <aWyryi4ZPNgNIejE@pie>
In-Reply-To: <aWyryi4ZPNgNIejE@pie>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 21 Jan 2026 18:24:01 -0500
X-Gm-Features: AZwV_QjPZ1kfG-oYVKvb60SDcboPugetPerNAoSh7YWyNHxKVLQCmN7kp_yng9E
Message-ID: <CAMDkj5yGNxL0Hkw5k0Kae=SjPb51Bu9T0M60Dpaj5OVckN3R1g@mail.gmail.com>
Subject: Re: [PATCH 14/17] spacemit: k1: Add DDR firmware support to SPL
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, Yixun Lan <dlan@gentoo.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Yao Zi,

On Mon, Jan 19, 2026 at 4:41=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:

> (My mail provider complains about the huge list of recipients, so I
> reduced it a little.)
>
> On Sat, Jan 17, 2026 at 02:01:48PM -0500, Raymond Mao wrote:
> > From: Raymond Mao <raymond.mao@riscstar.com>
> >
> > Include DDR initialization firmware in the SPL image. The firmware
> > path can be specified via the DDR_FW_FILE environment variable. If
> > the firmware is not found, an empty placeholder file is created to
> > allow the build to proceed without DDR initialization support.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > ---
> >  arch/riscv/dts/k1-spl.dts      |  34 ++++++++++++++++++++++++++++++++-
> >  board/spacemit/k1/Kconfig      |   8 ++++++++
> >  board/spacemit/k1/Makefile     |  19 ++++++++++++++++++
> >  board/spacemit/k1/spl.c        |  30 +++++++++++++++++++++++++++++
> >  include/configs/k1.h           |   3 +++
> >  lib/vendor/spacemit/ddr_fw.bin | Bin 0 -> 19416 bytes
>
> It's unusual to ship binary firmware in U-Boot repository. Please place
> the firmware somewhere else, and give a clear instruction in the
> board/architecture documentation explaining how to obtain/build it.
>
> >  6 files changed, 93 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/vendor/spacemit/ddr_fw.bin
>
> ...
>
> > diff --git a/board/spacemit/k1/Kconfig b/board/spacemit/k1/Kconfig
> > index 9f9c806d00d..a5fa788f660 100644
> > --- a/board/spacemit/k1/Kconfig
> > +++ b/board/spacemit/k1/Kconfig
> > @@ -15,6 +15,14 @@ config SYS_CONFIG_NAME
> >  config TEXT_BASE
> >       default 0x00200000
> >
> > +config SPL_DDR_FIRMWARE_OFFSET
> > +     hex "DDR firmware offset in SPL image"
> > +     depends on SPL
> > +     default 0x20000
> > +     help
> > +       Offset where DDR firmware should be placed in the SPL
> > +       image.
> > +
> >  config SPL_OPENSBI_LOAD_ADDR
> >       default 0x00000000
> >
> > diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
> > index 7bce47bac8c..ebe6e55867c 100644
> > --- a/board/spacemit/k1/Makefile
> > +++ b/board/spacemit/k1/Makefile
> > @@ -5,3 +5,22 @@
> >
> >  obj-y :=3D board.o
> >  obj-$(CONFIG_SPL_BUILD) +=3D spl.o
> > +
> > +DDR_FW_SRC ?=3D $(DDR_FW_FILE)
> > +FW_TARGET =3D $(srctree)/lib/vendor/spacemit/ddr_fw.bin
> > +
> > +DDR_FW_HEADER =3D $(objtree)/include/generated/ddr_fw_info.h
> > +
> > +$(obj)/spl.o: $(DDR_FW_HEADER)
> > +
> > +$(DDR_FW_HEADER): $(FW_TARGET)
> > +     @echo "/* DDR firmware info - $$(date) */" > $@
> > +     @if [ -f "$(FW_TARGET)" ]; then \
> > +             SIZE=3D$$(stat -c%s "$(FW_TARGET)" 2>/dev/null || echo 0)=
; \
> > +     else \
> > +             SIZE=3D0; \
> > +     fi; \
> > +     echo "#define DDR_FW_FILE_SIZE  $$SIZE" >> $@
> > +     @echo "/* Note: Update ADDR if binman layout changes */" >> $@
> > +
> > +clean-files +=3D $(FW_TARGET) $(DDR_FW_HEADER)
>
> Please make use of existing binman[1] facibilities to avoid the extra
> Kconfig and Makefile pieces. binman_sym() could be used for obtaining
> both size and offset of a binman entry.
>
> It doesn't work at all in SPL. I checked the binman symbol table
that was totally empty.


> > diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> > index 6fe064bd430..54bad9000fe 100644
> > --- a/board/spacemit/k1/spl.c
> > +++ b/board/spacemit/k1/spl.c
> > @@ -6,10 +6,12 @@
> >  #include <asm/io.h>
> >  #include <clk.h>
> >  #include <clk-uclass.h>
> > +#include <cpu_func.h>
> >  #include <configs/k1.h>
> >  #include <dm/device.h>
> >  #include <dm/uclass.h>
> >  #include <dt-bindings/pinctrl/k1-pinctrl.h>
> > +#include <generated/ddr_fw_info.h>
> >  #include <i2c.h>
> >  #include <linux/delay.h>
> >  #include <log.h>
> > @@ -115,6 +117,33 @@ void serial_early_init(void)
> >               panic("Serial uclass init failed: %d\n", ret);
> >  }
> >
> > +/* Load DDR training firmware */
> > +int init_ddr_firmware(void)
> > +{
> > +     void __iomem *src, *dst;
> > +     unsigned long size;
> > +
> > +     src =3D (void __iomem *)(CONFIG_SPL_TEXT_BASE +
> > +                            CONFIG_SPL_DDR_FIRMWARE_OFFSET);
> > +     dst =3D (void __iomem *)(DDR_TRAINING_DATA_BASE);
> > +     memcpy(dst, src, DDR_FW_FILE_SIZE);
> > +     size =3D round_up(DDR_FW_FILE_SIZE, 64);
> > +     flush_dcache_range((u32)(u64)dst, (u32)(u64)dst + size);
> > +     return 0;
> > +}
> > +
> > +void ddr_early_init(void)
> > +{
> > +     void __iomem *addr;
> > +
> > +     init_ddr_firmware();
> > +     addr =3D (void __iomem *)(CONFIG_SPL_TEXT_BASE +
> > +                             CONFIG_SPL_DDR_FIRMWARE_OFFSET);
> > +     // verify DDR firmware header
>
> However, you don't verify it, but only print some of the information.
> The comment seems misleading and extra.
>
> OK. I could remove the print and use checking instead.

Raymond


> > +     log_info("[0x%x]:0x%x, firmware size:%d\n",
> > +              (uint)(u64)addr, readl(addr), DDR_FW_FILE_SIZE);
>
> Regards,
> Yao Zi
>
