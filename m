Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC1DC46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 22:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29EA587A01;
	Sat,  6 Jan 2024 23:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbqlOC6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4254787A03; Sat,  6 Jan 2024 23:46:07 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C198743A
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 23:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-427ca22a680so7594931cf.3
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 14:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704581159; x=1705185959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7vgwox/jv50PVTP+hWEVcjK3mLYJ1iRYBIgMNwbA+Ps=;
 b=QbqlOC6PpUKcw4+aO8r2y+pxApXviRBi5Xnxm6jbUZloAxqIciXHPdK74+r9MDpc7+
 IZ3s6N8RSAHTpVjdsd5wREuTQcmwzLHldaX9hqz3l6lxvWvqIKto1xKDpQDPM0cVRlMN
 XwDNld8C4gxvgnOqX/2j7/QM1Cg+iKthhGXmp1IR9h3A37+lPdzoyTAcBEukuDsB8w9s
 piAA8LUEbWTuFS4N3HZ8GzWudh5l7UkO0TEMGs3esZfV4CJHzvfyxZaGN7eGQe1vZ9zT
 XnXK3d+VNF/Xm8tvlTihwwvOBOW+DkUQdVrQvAGR5iaQPPK0bbZXa5rnKNozdkvOgcC4
 HieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704581159; x=1705185959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7vgwox/jv50PVTP+hWEVcjK3mLYJ1iRYBIgMNwbA+Ps=;
 b=eXcSCeAfsBpb7Bk+zmbvOS8SGu1guDSB7Z4Am0g/OrivrZQlkXdftoDS1Iyw/QZ0sV
 G4vn15EwLt154U9It+pfkzknOoXbrJpk0hCEG6pxRywpBFXCOx+2rG57LcnG3ZcfqnAZ
 ktO7pmeBYxZgGA+4zcdheuAwtKvLvmdD7mHXLmnYulCFLOIgWnOwME7JFFu+2GUu/FTg
 EqPKjIaFrQ5FNojexPdYxplw5SOLwBw/2HExpmG7RrcKplEYmlVLRekqQCkjKuwy55dS
 idCFGZGKb7vddrekzx2+tiwWiw6xbzRrN5JLOzsKm/gIWSHwLKaURk/K99J2nXOa2PFy
 xAqA==
X-Gm-Message-State: AOJu0YwYIeZM0mKCATmdm5As1eVsJRrKw4EGtdXcsFCpIBvkM+xRxXAY
 GNWv+aN/wUsYUWGOqXo6BwSGWWEICk+9jJ4vu30=
X-Google-Smtp-Source: AGHT+IGMmxpFcqgnvvrxCMy5vWtuhiXYHgakvYj6ZjjZfMQKfycLD4oFSexqt9NzpzTCC2+5fdXIN6Ts0TJ9mtAvI+8=
X-Received: by 2002:a05:622a:1a8d:b0:429:8bdc:d024 with SMTP id
 s13-20020a05622a1a8d00b004298bdcd024mr803052qtc.95.1704581159336; Sat, 06 Jan
 2024 14:45:59 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTOD+cY55ES5HDrSZuGjqee3fvfXKORWg8bJFT64mFdg8A@mail.gmail.com>
 <CAFLszTiEfCDGTRHiVQDzb+9KqpKi-EQuS77bOK-LYThZxTTb4g@mail.gmail.com>
In-Reply-To: <CAFLszTiEfCDGTRHiVQDzb+9KqpKi-EQuS77bOK-LYThZxTTb4g@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Sat, 6 Jan 2024 14:45:47 -0800
Message-ID: <CANV2PTPXDfZ84PGxEvwqRHnScMcwwy-Amgmg-eJxq0R_b4Gn=w@mail.gmail.com>
Subject: Re: booti usage offset requirements for compressed kernel and initrd
 with dtb
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
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

Hi Simon,

"If this [fdt_high environment variable] is set to the special value
0xffffffff (32-bit machines) or 0xffffffffffffffff (64-bit machines) then
the fdt will not be copied at all on boot. For this to work it must reside
in writable memory, have sufficient padding on the end of it for U-Boot to
add the information it needs into it, and the memory must be accessible by
the kernel. This usage is strongly discouraged however as it also stops
U-Boot from ensuring the device tree starting address is properly aligned
and a misaligned tree will cause OS failures."

https://docs.u-boot.org/en/latest/usage/environment.html

"The device tree blob (dtb) must be placed on an 8-byte boundary"

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/arch/arm64/booting.rst

No mention of dtb alignment requirement at the similar documentation for
riscv64, but there is this mention:
"The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned for
rv64 and 4MB aligned for rv32)."

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/arch/riscv/boot.rst

Perhaps then it is both a dtb alignment issue (not mentioned in the
documentation?) and the spurious extra requirement after the transferred
data length?

If yes, how much is enough to pad after the end of devicetree blob?

Thanks!

E Shattow



On Thu, Jan 4, 2024 at 8:02=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:

> Hi,
>
> On Thu, Jan 4, 2024 at 5:19=E2=80=AFAM E Shattow <lucent@gmail.com> wrote=
:
> >
> > Hello,
> >
> > There is data corruption when using booti on a JH7110 (riscv64) board t=
o
> > load (over tftp or ymodem) a compressed kernel, compressed initrd, and
> > device tree blob, when the data are too close together (even though not
> > overlapping). In the adjustments I have tried it seems to be consistent
> but
> > not clear "why?" by how much for each adjustment is needed to observe t=
he
> > failure versus success.
> >
> > My question is simple enough, what are the intended offset requirements
> for
> > loading these data into memory for use with booti ?
> >
> > For example:
> >
> > setenv ip 192.168.2.216
> > setenv loadaddr 0x60000000  # default from Milk-V vendor for Mars CM
> product
> > setenv kernel_uncomp_size 24193024  # uncompressed size of
> > vmlinuz-5.15.0-gpu117 from file command information
> > setenv kernel_comp_addr_r $loadaddr
> > setenv kernel_addr_r 0x61712800  # $kernel_comp_addr_r +
> $kernel_uncomp_size
> > dhcp $kernel_addr_r
> > $ip:mars-cm_debian-desktop_sdk-boot/vmlinuz-5.15.0-gpu117
> > setenv kernel_comp_size 0x$filesize
> > setenv dtb_addr 0x62e25000  # $kernel_addr_r + $kernel_uncomp_size
> > dhcp $dtb_addr
> >
> $ip:mars-cm_debian-desktop_sdk-boot/dtbs/starfive/jh7110-visionfive-v2.dt=
b
> > setenv initrd_addr 0x62e31d7f  # $dtb_addr + 0x$filesize
> > dhcp $initrd_addr $ip:debian-installer-netboot/initrd.gz; setenv
> > initrd_size 0x$filesize
> > booti $kernel_addr_r $initrd_addr:$initrd_size $dtb_addr
> >
> > Waiting for root device ...
> >
> > (and nothing else, this is a failure)
> >
> > If 0x62e31d7f is replaced by 0x62e31ec6 then the boot is successful and
> > dmesg from debian-installer shows the additional information:
> >
> >  Freeing unused kernel image (initmem) memory: 2196K
> >  Run /init as init process
> >    with arguments:
> >      /init
> >    with environment:
> >      HOME=3D/
> >      TERM=3Dlinux
> >
> >
> > So in this the kernel boots and all works normally. Even if that addres=
s
> is
> > 0x62e31ec5 one byte earlier it is a failure.
> >
> > In other attempts I would change the ordering i.e. so the initrd is fir=
st
> > at $loadaddr and then kernel and DTB, or DTB and kernel. If I learned
> > anything it is that compressed initrd must be loaded to a span of memor=
y
> at
> > least the size of its uncompressed length, and this is also true of the
> > compressed kernel vmlinuz even though booti documentation vaguely infer=
s
> > that there is an area of memory specified for decompression - so a
> > compressed kernel needs two times its uncompressed size is that correct=
?
> > Also there's no hint anywhere if the device tree blob has special memor=
y
> > constraints but if it is not starting on some 16byte aligned address at
> > least my superstition from observations in testing is that it is not
> > successful... and now, where it ends (in the above example) and initrd
> > begins seems arbitrary.
> >
> > Sure I could pad things out, they tend to work that way, but I would li=
ke
> > to know "why?"
>
> I don't know why, but I imagine that Linux finds the initrd in one
> case and not inthe other...does the kernel log give you any clues?
>
> Also, can you use U-Boot's 'md5sum' command or similar to check that
> the initrd and DT are the same in each case?
>
> Also, you could use a FIT [1] rather than booti.
>
> Regards,
> Simon
>
> [1] https://docs.u-boot.org/en/latest/usage/fit/index.html
>
