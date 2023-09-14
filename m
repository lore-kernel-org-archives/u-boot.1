Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD5CA0ECD
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 04:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AEE86A28;
	Thu, 14 Sep 2023 06:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eX3BdVjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF1886D76; Thu, 14 Sep 2023 06:54:08 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA87586A28
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 06:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52e64bc7c10so529880a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 21:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694667245; x=1695272045; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OIFiUUbuvE/FDXzEI7BQZ7k2LTaWlt9ZjRid3nMATU=;
 b=eX3BdVjTTec8urKSZsK0uUwbsHs4y1JHp5Wg9q7qulaNMANB8XupoSOcCIkwuFyeP0
 rksuuD4xJYD/A76uCyQydU3vcXxatxPNcAMsoE3JswhqqX3t1Hdhmbf7yxQ2jSx5NN6D
 MMLIUe6X03iG4hWEzeNQxFuWszAgw7AJxBOCmcfo18SL86BSsk9CFeDesDPqbuaEjNia
 0bssUlPgRvY/FgNr1E8bMCipEfvo7nJgcbiV7brruELnWNnfLoRFACod7yYT05e3QApf
 C4sxY8QTchy42cCLUgKkiiSJo+1B3AWhId/uoe7FyHwsYDx1nakcY3GOWJB1wflXeycO
 FieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694667245; x=1695272045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OIFiUUbuvE/FDXzEI7BQZ7k2LTaWlt9ZjRid3nMATU=;
 b=bDjChvPGsRop2VVr7YH6rmfWEYxMDcDuC7kloeQ84w718YevwC/lrP4KEekpiYp9+E
 lXhCXDUUFJ9qBlWPVD+ExxCbbz4tbjlea9rVfvZl97LGDpOYeYWnlYpTL/5XfbCgfVo9
 Cs4eu5pkXV/W3qIhCoHyEQUBNFCeReQFffb3vxof+khu50b6QO6EnqVNZS4bVcbVfOhm
 b/ET9gMMld6vpSNUGr+nbOBLnwwXzrSjo2TDWARWH3b6cp7NoZxyokyK8fC+yfw/leG2
 AEc0ImammXKz2CKCfASa2lUs9hRddT3EuMd4/3rM+UJKHp2AN4Be1KePm8K9L9b3UTi7
 1KeA==
X-Gm-Message-State: AOJu0Yy7lkNtKReeq5XgAnSydxcZy3pqHlkZZzNjy14rhee49/woxG69
 qxcrhx04XU3n/mnJLAreFSg8HjK+aCBdEQfoFdzo2QHNLEg=
X-Google-Smtp-Source: AGHT+IFo423hyogBvf/rD1jA5O+7nUU0w0xB3Sl1KHsKuHtHA+FiECapbylcwuq8d9aYxHYvE6G3g/cYKkpK4YeFOWc=
X-Received: by 2002:aa7:d5c6:0:b0:522:3a89:a7bc with SMTP id
 d6-20020aa7d5c6000000b005223a89a7bcmr3118877eds.42.1694667245105; Wed, 13 Sep
 2023 21:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
 <20230913162217.GN305624@bill-the-cat>
 <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
 <20230913201355.GR305624@bill-the-cat>
 <CAPnjgZ3rMLpRh_uEjsvipeTp92UEXDrO98q7e8M7f-Hh60NpYg@mail.gmail.com>
In-Reply-To: <CAPnjgZ3rMLpRh_uEjsvipeTp92UEXDrO98q7e8M7f-Hh60NpYg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 13 Sep 2023 21:53:53 -0700
Message-ID: <CAJaLiFze0mRf4m06MUc7=B5ADxFo=qYUzjbCDGzBbZ7tv7tiLA@mail.gmail.com>
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

Hi Simon,

On Wed, Sep 13, 2023 at 8:38=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tom,
>
> On Wed, 13 Sept 2023 at 14:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Sep 13, 2023 at 12:56:53PM -0700, Tony Dinh wrote:
> > > Hi Tom,
> > >
> > > On Wed, Sep 13, 2023 at 9:22=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:
> > > >
> > > > > I've been testing the boostd for a few Marvell boards and seeing =
this
> > > > > error on the Thecus N2350 (Marvell Armada 385, dual-core CPU). Th=
e
> > > > > "bootflow scan scsi" command triggered the "CACHE: Misaligned
> > > > > operation at range" error. However, this error did not affect the
> > > > > result of the scan, i.e. the bootflow for scsi partition was crea=
ted
> > > > > correctly, and u-boot is running normally.
> > > > >
> > > > > Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogether.
> > > > > Perhaps this is a case where the DCACHE is not required and shoul=
d be
> > > > > turned off?
> > > > >
> > > > > Please see the log after the break below.
> > > >
> > > > Can you please try -next ?  There's at least one SCSI related cache
> > > > alignment fix there that's not in master, thanks.
> > >
> > > Unfortunately I got the same errors. This time the ranges are
> > > different, of course.
> > >
> > > master:
> > >
> > > N2350 > bootflow scan scsi
> > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x=
3fb99f88
> > > ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3=
fb9a388
> > >
> > > next:
> > >
> > > N2350 > bootflow scan scsi
> > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x=
3fb80388
> > > ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3=
fb80788
> >
> > Can you debug to where these calls are so we can align these buffers?
> > See 02660defdc8a ("scsi: Cache align temporary buffer") for an example.
>
> I wonder if we need to use memalign() when allocating memory to read thin=
gs from the media? But I am not sure which file time is being read, or whic=
h bootmeth it is.

Looks like we probably need to align the buffer tempbuff.

/drivers/scsi/scsi.c
static int scsi_detect_dev(struct udevice *dev, int target, int lun,
  struct blk_desc *dev_desc)
{
unsigned char perq, modi;
lbaint_t capacity;
unsigned long blksz;
struct scsi_cmd *pccb =3D (struct scsi_cmd *)&tempccb;
int count, err;

pccb->target =3D target;
pccb->lun =3D lun;
pccb->pdata =3D (unsigned char *)&tempbuff;
pccb->datalen =3D 512;

If you look at the log I posted previously, this error shows up during
"bootflow scan scsi".

All the best,
Tony



>
> Regards,
> Simon
