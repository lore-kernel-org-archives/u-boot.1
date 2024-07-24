Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26602C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 914F588959;
	Wed, 24 Jul 2024 16:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RXcd7adr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C56F288955; Wed, 24 Jul 2024 16:37:26 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FDBF8895D
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b78c980981so37542406d6.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721831843; x=1722436643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EWktEUI5FlxP4TVw1Kgz5TPJyBVPMDWJm2BnIrKklhw=;
 b=RXcd7adrp5l47LsP0n/MNeVUDWmG56PUxXAbyOGHkXmSL06p559L70hy4UaNrKaxfY
 SK0MBP11QOHMw4mg6kv4exKp5nr5bstTFunb5dbcL9Q48nofojk9Qgg2BuoHgZy3GV/c
 SR9kqorH9crYgGNztAvIrzpOoUdzudhi3O6KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831843; x=1722436643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EWktEUI5FlxP4TVw1Kgz5TPJyBVPMDWJm2BnIrKklhw=;
 b=nK//HjtRMpURFzkTL1G0k3pqBVI4+/fuoFkTde9Wh7MjXlw18VEFH4wfowwPNqEwqN
 QPfE71WFXa7EgC4OIfZ9hejOmgTeNFYyXIyDYIPCVvaJHhS0vA9wk95xTJj//sKJ+Jdk
 FmJGdqhZUUPygxZVpr9lVrmf5OFJzpTnhwmZKo0PiDTI1V57yHcoF1GJg5t6QzBD/FYP
 ekgWYCXTPhK2ydhXTzxmZEAX60Fhn+UTDvJjq0lSQk75EyxQ71HOWM/t5rs+8xPTyEV/
 eqrzp/X4Ajz5mmgBk3SlZxHObldwEDanm9QPfMaGpCmWs1/ON77mpLgbeBW5GLAFiRJX
 i6xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC0kjSEuFX/2HLCdPnZxq9wxBIDf6Zl/oZSa7YhVrBs7P/UY/suhTEnumV4eR4Tnzsk79W58lSdkNSYtn8VqVxqIt0Kw==
X-Gm-Message-State: AOJu0Yzx9q1ROMtC+pc1XmJXdTj44ySg7p7X/2uOTKIg8xLbgy2MC4Zt
 FpK6Z8APPo7tesvmtCBDEXSsIwTNiFHvspaX8+hVZpU9OqpR0evYCrvP/bTcziyYbYwj6ovR1wW
 uivjZmcwx9034e8F9QUsOr29YQGo3nuTG1VDG
X-Google-Smtp-Source: AGHT+IEJr6LbTAqKDVGFCctBj15DS3n/3iN/6hfLscrErIsQBbioUwOqkRJZnKpY+6VkMXKTL2BPIA23JVyLyN+Q0tE=
X-Received: by 2002:a05:6214:2622:b0:6b9:5bbb:108d with SMTP id
 6a1803df08f44-6b99074202cmr23253186d6.5.1721831843430; Wed, 24 Jul 2024
 07:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240724073448.710197-1-lukas.funke-oss@weidmueller.com>
 <20240724073448.710197-2-lukas.funke-oss@weidmueller.com>
 <CAC_iWjL1dE_KQRiz-3RwztZPt-C9V4=836obQ3PmkC1NrzgX6w@mail.gmail.com>
In-Reply-To: <CAC_iWjL1dE_KQRiz-3RwztZPt-C9V4=836obQ3PmkC1NrzgX6w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 08:37:12 -0600
Message-ID: <CAFLszTjvHTnz+xcss2Kk+ERLX9G5zr6iU+rRwFYaEtS_CBc_rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 24 Jul 2024 at 02:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Thanks Lukas,
>
> On Wed, 24 Jul 2024 at 10:35, <lukas.funke-oss@weidmueller.com> wrote:
> >
> > From: Lukas Funke <lukas.funke@weidmueller.com>
> >
> > tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
> > initialized in tpm_tis_init(). However, the init-function is called
> > *after* tpm_tis_wait_init() introducing an uninitalized field access.
> >
> > This commit switches both routines.
> >
> > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >
> > Changes in v2:
> > - Call tpm_tis_wait_init() from tpm_tis_init()
> > - Use phy_ops for bus access in tpm_tis_wait_init()
> >
> >  drivers/tpm/tpm2_tis_core.c | 28 ++++++++++++++++++++++++++++
> >  drivers/tpm/tpm2_tis_spi.c  | 29 -----------------------------
> >  2 files changed, 28 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
> > index 680a6409433..1fdf8cfa319 100644
> > --- a/drivers/tpm/tpm2_tis_core.c
> > +++ b/drivers/tpm/tpm2_tis_core.c
> > @@ -419,6 +419,28 @@ static bool tis_check_ops(struct tpm_tis_phy_ops *phy_ops)
> >         return true;
> >  }
> >
> > +static int tpm_tis_wait_init(struct udevice *dev, int loc)
> > +{
> > +       struct tpm_chip *chip = dev_get_priv(dev);
> > +       unsigned long start, stop;
> > +       u8 status;
> > +       int ret;
> > +
> > +       start = get_timer(0);
> > +       stop = chip->timeout_b;
> > +       do {
> > +               mdelay(TPM_TIMEOUT_MS);
> > +               ret = chip->phy_ops->read_bytes(dev, TPM_ACCESS(loc), 1, &status);
> > +               if (ret)
> > +                       break;
> > +
> > +               if (status & TPM_ACCESS_VALID)
> > +                       return 0;
> > +       } while (get_timer(start) < stop);
> > +
> > +       return -EIO;
> > +}
> > +
> >  int tpm_tis_init(struct udevice *dev)
> >  {
> >         struct tpm_chip *chip = dev_get_priv(dev);
> > @@ -436,6 +458,12 @@ int tpm_tis_init(struct udevice *dev)
> >         chip->timeout_c = TIS_SHORT_TIMEOUT_MS;
> >         chip->timeout_d = TIS_SHORT_TIMEOUT_MS;
> >
> > +       ret = tpm_tis_wait_init(dev, chip->locality);
> > +       if (ret) {
> > +               log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
> > +               return ret;
> > +       }
> > +
> >         ret = tpm_tis_request_locality(dev, 0);
> >         if (ret)
> >                 return ret;
> > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > index b0fe97ab1d0..7909a147c2d 100644
> > --- a/drivers/tpm/tpm2_tis_spi.c
> > +++ b/drivers/tpm/tpm2_tis_spi.c
> > @@ -188,29 +188,6 @@ static int tpm_tis_spi_write32(struct udevice *dev, u32 addr, u32 value)
> >         return tpm_tis_spi_write(dev, addr, sizeof(value), (u8 *)&value_le);
> >  }
> >
> > -static int tpm_tis_wait_init(struct udevice *dev, int loc)
> > -{
> > -       struct tpm_chip *chip = dev_get_priv(dev);
> > -       unsigned long start, stop;
> > -       u8 status;
> > -       int ret;
> > -
> > -       start = get_timer(0);
> > -       stop = chip->timeout_b;
> > -       do {
> > -               mdelay(TPM_TIMEOUT_MS);
> > -
> > -               ret = tpm_tis_spi_read(dev, TPM_ACCESS(loc), 1, &status);
> > -               if (ret)
> > -                       break;
> > -
> > -               if (status & TPM_ACCESS_VALID)
> > -                       return 0;
> > -       } while (get_timer(start) < stop);
> > -
> > -       return -EIO;
> > -}
> > -
> >  static struct tpm_tis_phy_ops phy_ops = {
> >         .read_bytes = tpm_tis_spi_read,
> >         .write_bytes = tpm_tis_spi_write,
> > @@ -256,12 +233,6 @@ static int tpm_tis_spi_probe(struct udevice *dev)
> >         /* Ensure a minimum amount of time elapsed since reset of the TPM */
> >         mdelay(drv_data->time_before_first_cmd_ms);
> >
> > -       ret = tpm_tis_wait_init(dev, chip->locality);
> > -       if (ret) {
> > -               log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
> > -               return ret;
> > -       }
> > -
> >         tpm_tis_ops_register(dev, &phy_ops);
> >         ret = tpm_tis_init(dev);
> >         if (ret)
> > --
> > 2.30.2
> >
>
> I'll manually add the fixes tag on merge. Other than that
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Simon Glass <sjg@chromium.org>
Fixes: a5c30c26b28 ("tpm: Use the new API on tpm2 spi driver")
