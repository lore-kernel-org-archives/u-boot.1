Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20F6CD37B1
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 03:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58C286501;
	Sat, 16 Sep 2023 05:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QabTQ9ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC4B86489; Sat, 16 Sep 2023 05:40:32 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B322086501
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 05:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52eed139ec2so3184295a12.2
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 20:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694835629; x=1695440429; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaOy3oLIXTjFOkCnua/wIQyRVrPwgyH773KneZsBpQo=;
 b=QabTQ9axVZ/J7Woo9GpiMxbKFCcfBF/r2l0G8mKvBrUijifaoZSqs3NMgU7njwVIQx
 n2cdD079jYwsQeps6eIITlAc7OS35EwfcvRMjWYZx1hzS6xUCxJfPh0G345zQb9MyzL+
 aJVfheRAcY/G5OLm18b1wj3M6O2aSrvkG2S4r4sUNdi2+42m5VrFU8JjbD1BP6W65H0j
 G9SFa4byGOLuXCW+R2eg0isLui0xtDqtnJcGxngIPiiZJaQkxSQBWML202I8UGB35NI9
 c97IlBFMAYmxcJdeuTkW9MNaa7beKZXtExOnuBqi/uO+yAjQAGPomJqN7Xdz5tju6BtM
 alXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835629; x=1695440429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IaOy3oLIXTjFOkCnua/wIQyRVrPwgyH773KneZsBpQo=;
 b=HZSUtaoQePiKcmkU7F53mwpTznsHZRF5GrT0u7xdpe8NFOdw0QghTFPVXSF3YMJbc0
 PGFrcmf40KIj/TjjLEGo/NKdcoauiGhWKBJnXx+TtJuo6vXgK4INHCBB2c/rqNB5wKsv
 dnLW1Ts2l7jrjqSJBbhoEQAv2HO3KDXoCVuWc1IJQp90Aw3r0Fl8kEfARefIj2fW+fLr
 Me6+XTAhxYXuiS0LjQpntAYnr1ZWBdufcfvM7PRh3id0rMKVP1qUSwD4ThXsuI5t0JIV
 VcrjBLYnYkRf7JqNs16ExNk2i3t6mdH2GVTO2ekn6W8zUWb9sRHS2SaWfyZpHeFw+vux
 HlaQ==
X-Gm-Message-State: AOJu0Yx4KqanZIPfmigyUTeXduUpDRZhqBC0b3ykKCuuxqysWxUub7Hb
 gPKJXnsP5IDnPGHz+5iuKVCLbk5re+uVKzcGgRiPOu3pDyE=
X-Google-Smtp-Source: AGHT+IFht0CZiCPy5WZFixhNoF4o8GaaDijBxIcLqmu5zwhbC430RCK0Tv9AQRz00BY1F03DhiQvpuuGdxSRcSUeeyM=
X-Received: by 2002:a05:6402:5304:b0:530:b1ff:4762 with SMTP id
 eo4-20020a056402530400b00530b1ff4762mr1276344edb.17.1694835628974; Fri, 15
 Sep 2023 20:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
 <20230913162217.GN305624@bill-the-cat>
 <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
 <20230913201355.GR305624@bill-the-cat>
 <CAPnjgZ3rMLpRh_uEjsvipeTp92UEXDrO98q7e8M7f-Hh60NpYg@mail.gmail.com>
 <CAJaLiFze0mRf4m06MUc7=B5ADxFo=qYUzjbCDGzBbZ7tv7tiLA@mail.gmail.com>
 <CAJaLiFxX+XQNKfda5rrRhA+8Q9p2kEuzdJi=UK1N=y3LsMXjTQ@mail.gmail.com>
In-Reply-To: <CAJaLiFxX+XQNKfda5rrRhA+8Q9p2kEuzdJi=UK1N=y3LsMXjTQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 15 Sep 2023 20:40:17 -0700
Message-ID: <CAJaLiFxbtt6i-nwLOvFwX9aDwCGeaZY=m3=e2rH6QNz13EjAHg@mail.gmail.com>
Subject: Re: bootstd: CACHE Misaligned operation errors (Marvell Armada 385)
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
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

On Fri, Sep 15, 2023 at 6:32=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi Tom, Hi Simon,
>
> On Wed, Sep 13, 2023 at 9:53=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wro=
te:
> >
> > Hi Simon,
> >
> > On Wed, Sep 13, 2023 at 8:38=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Tom,
> > >
> > > On Wed, 13 Sept 2023 at 14:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Sep 13, 2023 at 12:56:53PM -0700, Tony Dinh wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, Sep 13, 2023 at 9:22=E2=80=AFAM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:
> > > > > >
> > > > > > > I've been testing the boostd for a few Marvell boards and see=
ing this
> > > > > > > error on the Thecus N2350 (Marvell Armada 385, dual-core CPU)=
. The
> > > > > > > "bootflow scan scsi" command triggered the "CACHE: Misaligned
> > > > > > > operation at range" error. However, this error did not affect=
 the
> > > > > > > result of the scan, i.e. the bootflow for scsi partition was =
created
> > > > > > > correctly, and u-boot is running normally.
> > > > > > >
> > > > > > > Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogeth=
er.
> > > > > > > Perhaps this is a case where the DCACHE is not required and s=
hould be
> > > > > > > turned off?
> > > > > > >
> > > > > > > Please see the log after the break below.
> > > > > >
> > > > > > Can you please try -next ?  There's at least one SCSI related c=
ache
> > > > > > alignment fix there that's not in master, thanks.
> > > > >
> > > > > Unfortunately I got the same errors. This time the ranges are
> > > > > different, of course.
> > > > >
> > > > > master:
> > > > >
> > > > > N2350 > bootflow scan scsi
> > > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > > ERROR: v7_outer_cache_inval_range - start address is not aligned =
- 0x3fb99f88
> > > > > ERROR: v7_outer_cache_inval_range - stop address is not aligned -=
 0x3fb9a388
> > > > >
> > > > > next:
> > > > >
> > > > > N2350 > bootflow scan scsi
> > > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > > ERROR: v7_outer_cache_inval_range - start address is not aligned =
- 0x3fb80388
> > > > > ERROR: v7_outer_cache_inval_range - stop address is not aligned -=
 0x3fb80788
> > > >
> > > > Can you debug to where these calls are so we can align these buffer=
s?
> > > > See 02660defdc8a ("scsi: Cache align temporary buffer") for an exam=
ple.
> > >
> > > I wonder if we need to use memalign() when allocating memory to read =
things from the media? But I am not sure which file time is being read, or =
which bootmeth it is.
> >
> > Looks like we probably need to align the buffer tempbuff.
> >
> > /drivers/scsi/scsi.c
> > static int scsi_detect_dev(struct udevice *dev, int target, int lun,
> >   struct blk_desc *dev_desc)
> > {
> > unsigned char perq, modi;
> > lbaint_t capacity;
> > unsigned long blksz;
> > struct scsi_cmd *pccb =3D (struct scsi_cmd *)&tempccb;
> > int count, err;
> >
> > pccb->target =3D target;
> > pccb->lun =3D lun;
> > pccb->pdata =3D (unsigned char *)&tempbuff;
> > pccb->datalen =3D 512;
> >
> > If you look at the log I posted previously, this error shows up during
> > "bootflow scan scsi".
> >
>
> Taking the hint from Simon. I turned on log_debug and can see where
> the alignment is not correct. It is fs.c fs_read_alloc(). The
> memalign() call here probably needs to be revised to take into
> consideration ARCH_DMA_MINALIGN somehow? It is 64 for armv7.
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 2b815b1db0..b70281532e 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -1019,9 +1019,12 @@ int fs_read_alloc(const char *fname, ulong
> size, uint align, void **bufp)
>         int ret;
>
>         buf =3D memalign(align, size + 1);
> +       log_debug("aligned buf addr 0x%x\n", (unsigned int)buf);
> +
>         if (!buf)
>                 return log_msg_ret("buf", -ENOMEM);
>         addr =3D map_to_sysmem(buf);
> +       log_debug("aligned buf sysmem addr 0x%x\n", (unsigned int)addr);
>
>         ret =3D fs_read(fname, addr, 0, size, &bytes_read);
>         if (ret) {
>
> Please see the log below after the break.

Actually, it looks like the fix should be in bootmeth_script.c.

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 0269e0f9b0..68e77aa50a 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -99,7 +99,7 @@ static int script_read_bootflow_file(struct udevice *boot=
std,
        if (!bflow->subdir)
                return log_msg_ret("prefix", -ENOMEM);

-       ret =3D bootmeth_alloc_file(bflow, 0x10000, 1);
+       ret =3D bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN);

All the best,
Tony

> =3D=3D=3D=3D=3D=3D=3D=3D
>
> Log:
>
>    bootmeth_try_file()    /boot/boot.scr - err=3D0
>           fs_devread()  <2, 0, 1024>
>           fs_devread()  <8, 0, 32>
>           fs_devread()  <8216, 256, 128>
>
> bootmeth_alloc_file()    - script file size 4b7
>
>        fs_read_alloc() aligned buf addr 0x3eb4b608
>        fs_read_alloc() aligned buf sysmem addr 0x3eb4b608
>           fs_devread()  <12312, 0, 8>
>
> <snip>
>
>           fs_devread()  <551551112, 256, 128>
>           fs_devread()  <551592072, 0, 1207>
>
> scsi_read buffer addr=3D0x3eb4b608
> scsi_read_ext: startblk 20e0a88a, blccnt 0 buffer 3EB4B608
> scsi_exec pdata=3D0x3eb4b608
> ahci_scsi_exec
> ahci_scsi_exec cmd =3D 0x48
> ahci_scsi_exec pdata=3D0x3eb4b608
> ata_scsiop_read_write
> ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3eb4=
b608
> ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3eb4b=
a08
> ata_scsiop_read_write exiting...
> ahci_scsi_exec exiting...
> scsi_read exiting...
> ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3eb4=
b608
> ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3eb4b=
a08
>
> All the best,
> Tony
