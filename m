Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0483CCD37B0
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 01:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0B5864BA;
	Sat, 16 Sep 2023 03:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V55Au2VM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E5A864CD; Sat, 16 Sep 2023 03:32:41 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B627A8648D
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 03:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52f3ba561d9so5866155a12.1
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 18:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694827959; x=1695432759; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0k7jc9V3p/ykw+lN7c5HVQiRLjMUu2ZpjsV7EhhDork=;
 b=V55Au2VMXJ9y6b4N4kTIIAhW3h9a1p0q2MzM46c9Ccm+RMAj/GdZynpC4631A9HDA4
 H/6/e+Vy2pRdjOv61szk4aWIjPcL3MJupbvfxTM/rO3iaBO0/KISnaSu5bJc2VVkR/7Y
 siC+lV2L+jNVU0Kue5gwdsJlhcluFZKKKGT2EISmjq96+LU6ZvCEqLrdhFaT+BB/6SYO
 BbDbkrf5CbJxBkmYwtAr5WBX3ctSOOZlYAjOFWmJ6tV9/tDYSCwq9CW0mWnq5I+b6x+p
 v03/en29nrMA7373H7o/KkCbRZV9XQrI3Vwc5XBAv6gv/GN0Xs5YPJYShsgiDPIO2ZCX
 yLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694827959; x=1695432759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0k7jc9V3p/ykw+lN7c5HVQiRLjMUu2ZpjsV7EhhDork=;
 b=HFlZc4J2uCc/lSm1ncKSGhq8dxa3s/U86TnM7jP7aSXuZRcL9beSb+jzkjeTzyzW/v
 2nG3owXbrrtsO+aKsndWG8namjsjPnTvKYQoZ+WmfN+d3Bh0XCGR3yh+kQ3hdLl3k4ju
 rKXU1U9P20OBdnpmj5xXm/96edEGGiJ9im3oMAyVrkH9cEAaAjmibVTrii85hgBrfdfi
 ypWj1WIudyRkgI/pPPj4RGuKLV+XecR8bfiL7OTWEJtpOlItpTtFNwIWjwMTnyLdi/zT
 2lRBHINWhrW9/xRYH+KLWX/WRjMgIPkY5yEZMexSxnbr4NwO2RqntlUU+Wu8BnOF0e+p
 8xpg==
X-Gm-Message-State: AOJu0YzETXwm1BRE4yEsqViO9WRN0/fu3wMY08G8HRevvKsvLYF+lPLF
 AUQJ7rilUvJ6K1afDwOZhb8XbdKlafwMq9iKQYQ=
X-Google-Smtp-Source: AGHT+IHGeyRHuXF6PO5NvTSLiCYYjliwmZKafrL6iolgqRYoTOonwlgK3juyfD4FuYkq3t3pnyL53uxQh3o9zGAYwHY=
X-Received: by 2002:a05:6402:2788:b0:530:493:359f with SMTP id
 b8-20020a056402278800b005300493359fmr9355813ede.12.1694827959024; Fri, 15 Sep
 2023 18:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
 <20230913162217.GN305624@bill-the-cat>
 <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
 <20230913201355.GR305624@bill-the-cat>
 <CAPnjgZ3rMLpRh_uEjsvipeTp92UEXDrO98q7e8M7f-Hh60NpYg@mail.gmail.com>
 <CAJaLiFze0mRf4m06MUc7=B5ADxFo=qYUzjbCDGzBbZ7tv7tiLA@mail.gmail.com>
In-Reply-To: <CAJaLiFze0mRf4m06MUc7=B5ADxFo=qYUzjbCDGzBbZ7tv7tiLA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 15 Sep 2023 18:32:25 -0700
Message-ID: <CAJaLiFxX+XQNKfda5rrRhA+8Q9p2kEuzdJi=UK1N=y3LsMXjTQ@mail.gmail.com>
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

Hi Tom, Hi Simon,

On Wed, Sep 13, 2023 at 9:53=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi Simon,
>
> On Wed, Sep 13, 2023 at 8:38=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Tom,
> >
> > On Wed, 13 Sept 2023 at 14:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Sep 13, 2023 at 12:56:53PM -0700, Tony Dinh wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, Sep 13, 2023 at 9:22=E2=80=AFAM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:
> > > > >
> > > > > > I've been testing the boostd for a few Marvell boards and seein=
g this
> > > > > > error on the Thecus N2350 (Marvell Armada 385, dual-core CPU). =
The
> > > > > > "bootflow scan scsi" command triggered the "CACHE: Misaligned
> > > > > > operation at range" error. However, this error did not affect t=
he
> > > > > > result of the scan, i.e. the bootflow for scsi partition was cr=
eated
> > > > > > correctly, and u-boot is running normally.
> > > > > >
> > > > > > Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogether=
.
> > > > > > Perhaps this is a case where the DCACHE is not required and sho=
uld be
> > > > > > turned off?
> > > > > >
> > > > > > Please see the log after the break below.
> > > > >
> > > > > Can you please try -next ?  There's at least one SCSI related cac=
he
> > > > > alignment fix there that's not in master, thanks.
> > > >
> > > > Unfortunately I got the same errors. This time the ranges are
> > > > different, of course.
> > > >
> > > > master:
> > > >
> > > > N2350 > bootflow scan scsi
> > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > ERROR: v7_outer_cache_inval_range - start address is not aligned - =
0x3fb99f88
> > > > ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0=
x3fb9a388
> > > >
> > > > next:
> > > >
> > > > N2350 > bootflow scan scsi
> > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > ERROR: v7_outer_cache_inval_range - start address is not aligned - =
0x3fb80388
> > > > ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0=
x3fb80788
> > >
> > > Can you debug to where these calls are so we can align these buffers?
> > > See 02660defdc8a ("scsi: Cache align temporary buffer") for an exampl=
e.
> >
> > I wonder if we need to use memalign() when allocating memory to read th=
ings from the media? But I am not sure which file time is being read, or wh=
ich bootmeth it is.
>
> Looks like we probably need to align the buffer tempbuff.
>
> /drivers/scsi/scsi.c
> static int scsi_detect_dev(struct udevice *dev, int target, int lun,
>   struct blk_desc *dev_desc)
> {
> unsigned char perq, modi;
> lbaint_t capacity;
> unsigned long blksz;
> struct scsi_cmd *pccb =3D (struct scsi_cmd *)&tempccb;
> int count, err;
>
> pccb->target =3D target;
> pccb->lun =3D lun;
> pccb->pdata =3D (unsigned char *)&tempbuff;
> pccb->datalen =3D 512;
>
> If you look at the log I posted previously, this error shows up during
> "bootflow scan scsi".
>

Taking the hint from Simon. I turned on log_debug and can see where
the alignment is not correct. It is fs.c fs_read_alloc(). The
memalign() call here probably needs to be revised to take into
consideration ARCH_DMA_MINALIGN somehow? It is 64 for armv7.

diff --git a/fs/fs.c b/fs/fs.c
index 2b815b1db0..b70281532e 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -1019,9 +1019,12 @@ int fs_read_alloc(const char *fname, ulong
size, uint align, void **bufp)
        int ret;

        buf =3D memalign(align, size + 1);
+       log_debug("aligned buf addr 0x%x\n", (unsigned int)buf);
+
        if (!buf)
                return log_msg_ret("buf", -ENOMEM);
        addr =3D map_to_sysmem(buf);
+       log_debug("aligned buf sysmem addr 0x%x\n", (unsigned int)addr);

        ret =3D fs_read(fname, addr, 0, size, &bytes_read);
        if (ret) {

Please see the log below after the break.

All the best,
Tony

=3D=3D=3D=3D=3D=3D=3D=3D

Log:

   bootmeth_try_file()    /boot/boot.scr - err=3D0
          fs_devread()  <2, 0, 1024>
          fs_devread()  <8, 0, 32>
          fs_devread()  <8216, 256, 128>

bootmeth_alloc_file()    - script file size 4b7

       fs_read_alloc() aligned buf addr 0x3eb4b608
       fs_read_alloc() aligned buf sysmem addr 0x3eb4b608
          fs_devread()  <12312, 0, 8>

<snip>

          fs_devread()  <551551112, 256, 128>
          fs_devread()  <551592072, 0, 1207>

scsi_read buffer addr=3D0x3eb4b608
scsi_read_ext: startblk 20e0a88a, blccnt 0 buffer 3EB4B608
scsi_exec pdata=3D0x3eb4b608
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ahci_scsi_exec pdata=3D0x3eb4b608
ata_scsiop_read_write
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3eb4b6=
08
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3eb4ba0=
8
ata_scsiop_read_write exiting...
ahci_scsi_exec exiting...
scsi_read exiting...
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3eb4b6=
08
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3eb4ba0=
8

All the best,
Tony
