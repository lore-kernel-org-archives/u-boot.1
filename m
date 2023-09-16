Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6932C2BA12
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 19:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA724833F5;
	Sat, 16 Sep 2023 21:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UFVDyqYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E26E2833F5; Sat, 16 Sep 2023 21:36:47 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84824833DE
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 21:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4e6so3921605a12.0
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694893004; x=1695497804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1S/r+URo22jl/SotTbH85pmDFpo+PNNv27wAxk13Xo=;
 b=UFVDyqYPBSy5ITz9xScwWZVi6KO84U2csQJRDE41PqqZjmb8yJHlTF/8zUVQya6E2v
 T9poc1QoH82frpYUIleM9h1pg+8Ta+f1dlbsExXqrPQzH0U2Y7WbNm5WQqoHfNuof3FW
 AwMwex7QFyXFn9g3Kp7HtobCfkfJKe8Z3969mFJTm0s1HL8FASZcbAxCAl6LmIqkfIi5
 GCXZ/zoruU77k6Rqn3j1jIlK7vaY2WJcB90MTzAcxig58MYi41Y9Y6MZlfopX2fNgj6y
 DuFVMoojARQWomE1Ju0ut9BnBNcVtOq9H7sg8sNje87PcaH+iSbxi+wTWxNm/ea8Sb5r
 uVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694893004; x=1695497804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1S/r+URo22jl/SotTbH85pmDFpo+PNNv27wAxk13Xo=;
 b=czml+14Ht/bQQi95iZIjc6HfTTEEh6NPYuGolhBvFPSs0S0FVHgn6/Gn1DC+6zOcoP
 zs7kfEwa+OvvMEmHicceXwohKzmHmSycJSGY3zIZ14u7qL59UOisNF26T8HQGHyRbynI
 vn3wOA3hFsuGSCMGdYfYuOmn1eGRtgH1xU1e4aAVKvnOyhcgQwstVB13v8ZATx6/e8/x
 jMDUz+pqNJfU0l8V/HiWzk85JCVLXX/iYXJLJ7EH+EhqkcjhBh06rfn8WyzHOuSZUiOC
 JO99VmNWVtY+2775u9oHTgSOFwrimoDaFu32SMhovASfor5J/NwCoUDwxbRbcfSat3aV
 vR3w==
X-Gm-Message-State: AOJu0YzSpcZdlQ1XMUUbGTtsPNJAyG8E2kiVKZ7q4kv+tA2l3hvVJCoB
 NnYIKdotmPIgeDMSMW+vVBd50MIjt7zsT/W5ChRqM75wOcc=
X-Google-Smtp-Source: AGHT+IELTtAUtBjBYOKI1qZEar0AXEQNvvUt1q5DKNhmLk6Wo7gAwvXZcpxh/CpJFBXOV2Vn6JwpGHPq2QG5l0lWodw=
X-Received: by 2002:aa7:d394:0:b0:525:691c:cd50 with SMTP id
 x20-20020aa7d394000000b00525691ccd50mr4953917edq.24.1694893003716; Sat, 16
 Sep 2023 12:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
 <20230913162217.GN305624@bill-the-cat>
 <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
 <20230913201355.GR305624@bill-the-cat>
 <CAPnjgZ3rMLpRh_uEjsvipeTp92UEXDrO98q7e8M7f-Hh60NpYg@mail.gmail.com>
 <CAJaLiFze0mRf4m06MUc7=B5ADxFo=qYUzjbCDGzBbZ7tv7tiLA@mail.gmail.com>
 <CAJaLiFxX+XQNKfda5rrRhA+8Q9p2kEuzdJi=UK1N=y3LsMXjTQ@mail.gmail.com>
 <CAJaLiFxbtt6i-nwLOvFwX9aDwCGeaZY=m3=e2rH6QNz13EjAHg@mail.gmail.com>
In-Reply-To: <CAJaLiFxbtt6i-nwLOvFwX9aDwCGeaZY=m3=e2rH6QNz13EjAHg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 16 Sep 2023 12:36:31 -0700
Message-ID: <CAJaLiFy05F3Cr4X4G2mVkppXnBEFZrHQ+5CngYN8eJPg8ENWkg@mail.gmail.com>
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

On Fri, Sep 15, 2023 at 8:40=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> On Fri, Sep 15, 2023 at 6:32=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wro=
te:
> >
> > Hi Tom, Hi Simon,
> >
> > On Wed, Sep 13, 2023 at 9:53=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> w=
rote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, Sep 13, 2023 at 8:38=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Wed, 13 Sept 2023 at 14:14, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Sep 13, 2023 at 12:56:53PM -0700, Tony Dinh wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, Sep 13, 2023 at 9:22=E2=80=AFAM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:
> > > > > > >
> > > > > > > > I've been testing the boostd for a few Marvell boards and s=
eeing this
> > > > > > > > error on the Thecus N2350 (Marvell Armada 385, dual-core CP=
U). The
> > > > > > > > "bootflow scan scsi" command triggered the "CACHE: Misalign=
ed
> > > > > > > > operation at range" error. However, this error did not affe=
ct the
> > > > > > > > result of the scan, i.e. the bootflow for scsi partition wa=
s created
> > > > > > > > correctly, and u-boot is running normally.
> > > > > > > >
> > > > > > > > Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altoge=
ther.
> > > > > > > > Perhaps this is a case where the DCACHE is not required and=
 should be
> > > > > > > > turned off?
> > > > > > > >
> > > > > > > > Please see the log after the break below.
> > > > > > >
> > > > > > > Can you please try -next ?  There's at least one SCSI related=
 cache
> > > > > > > alignment fix there that's not in master, thanks.
> > > > > >
> > > > > > Unfortunately I got the same errors. This time the ranges are
> > > > > > different, of course.
> > > > > >
> > > > > > master:
> > > > > >
> > > > > > N2350 > bootflow scan scsi
> > > > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > > > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > > > > > ERROR: v7_outer_cache_inval_range - start address is not aligne=
d - 0x3fb99f88
> > > > > > ERROR: v7_outer_cache_inval_range - stop address is not aligned=
 - 0x3fb9a388
> > > > > >
> > > > > > next:
> > > > > >
> > > > > > N2350 > bootflow scan scsi
> > > > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > > > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > > > > > ERROR: v7_outer_cache_inval_range - start address is not aligne=
d - 0x3fb80388
> > > > > > ERROR: v7_outer_cache_inval_range - stop address is not aligned=
 - 0x3fb80788
> > > > >
> > > > > Can you debug to where these calls are so we can align these buff=
ers?
> > > > > See 02660defdc8a ("scsi: Cache align temporary buffer") for an ex=
ample.
> > > >
> > > > I wonder if we need to use memalign() when allocating memory to rea=
d things from the media? But I am not sure which file time is being read, o=
r which bootmeth it is.
> > >
> > > Looks like we probably need to align the buffer tempbuff.
> > >
> > > /drivers/scsi/scsi.c
> > > static int scsi_detect_dev(struct udevice *dev, int target, int lun,
> > >   struct blk_desc *dev_desc)
> > > {
> > > unsigned char perq, modi;
> > > lbaint_t capacity;
> > > unsigned long blksz;
> > > struct scsi_cmd *pccb =3D (struct scsi_cmd *)&tempccb;
> > > int count, err;
> > >
> > > pccb->target =3D target;
> > > pccb->lun =3D lun;
> > > pccb->pdata =3D (unsigned char *)&tempbuff;
> > > pccb->datalen =3D 512;
> > >
> > > If you look at the log I posted previously, this error shows up durin=
g
> > > "bootflow scan scsi".
> > >
> >
> > Taking the hint from Simon. I turned on log_debug and can see where
> > the alignment is not correct. It is fs.c fs_read_alloc(). The
> > memalign() call here probably needs to be revised to take into
> > consideration ARCH_DMA_MINALIGN somehow? It is 64 for armv7.
> >
> > diff --git a/fs/fs.c b/fs/fs.c
> > index 2b815b1db0..b70281532e 100644
> > --- a/fs/fs.c
> > +++ b/fs/fs.c
> > @@ -1019,9 +1019,12 @@ int fs_read_alloc(const char *fname, ulong
> > size, uint align, void **bufp)
> >         int ret;
> >
> >         buf =3D memalign(align, size + 1);
> > +       log_debug("aligned buf addr 0x%x\n", (unsigned int)buf);
> > +
> >         if (!buf)
> >                 return log_msg_ret("buf", -ENOMEM);
> >         addr =3D map_to_sysmem(buf);
> > +       log_debug("aligned buf sysmem addr 0x%x\n", (unsigned int)addr)=
;
> >
> >         ret =3D fs_read(fname, addr, 0, size, &bytes_read);
> >         if (ret) {
> >
> > Please see the log below after the break.
>
> Actually, it looks like the fix should be in bootmeth_script.c.
>
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 0269e0f9b0..68e77aa50a 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -99,7 +99,7 @@ static int script_read_bootflow_file(struct udevice *bo=
otstd,
>         if (!bflow->subdir)
>                 return log_msg_ret("prefix", -ENOMEM);
>
> -       ret =3D bootmeth_alloc_file(bflow, 0x10000, 1);
> +       ret =3D bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN);

Yes, it is working with the patch above. I don't see the misaligned
errors anymore.

All the best ,
Tony
