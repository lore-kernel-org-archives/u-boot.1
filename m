Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BACC001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B19C86386;
	Wed, 16 Aug 2023 15:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ReH26xdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3626869DA; Wed, 16 Aug 2023 15:56:02 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB91A847D3
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe8242fc4dso56941175e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692194159; x=1692798959;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kq0M2d8QB7t5JpQWKOTHH3v3ZZwIL1tDxklUVgqTgH4=;
 b=ReH26xdjmwvhTcIWudGeVBIQbHX5CO3I12BMYYcchl1ghHIOdXz0I2DO3takpIe81D
 yWe0ogvS3ASJyYUjFeTVUSsCAu8DYAKr4I4Jy57qHsNeVkYbLCpXShJl5PAb0cikZeAl
 0bk7JDdOMQLv91eCzedTx9Odu2fO4b3IVZkkNILhdxoC7PESgyGmEn5ae0nH0CJvlqLz
 WMwFOZRCeD1FxVAu8pZROcgciez3HK3RcQY1DE0EJoEDTYdZJ6U5Q0WkbhqGxzKFCINh
 O7iOM2BHYyRNiYSMhTuRQmAdhsr2VBZM4mokkkoDzm60VGsjWxjvRlB99qYOIYuJb+sa
 vKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692194159; x=1692798959;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kq0M2d8QB7t5JpQWKOTHH3v3ZZwIL1tDxklUVgqTgH4=;
 b=G5Yi9bAGzLUU1caHy5dJrD9fKQSS2PqazD/TteyLX0PhM+TXN5+i0RPFv1PqsCruCn
 UWBbETrwNuTbiakykKMFTiPiy4S02eEL65mAe+UBUElSstSgHegK1vXKrq4ug3BAhnfT
 Kf6lejb/L5UpTljGmfp81LROR7USXp5Ml+act6OTsFQc+NPSsbi6rHxJJ+yUrabxB7IQ
 d6IvRumZt3pvQD5hwW6grk8SF81ZYMnpHBceXUvywQsHZAdL1gg6Tn/GEWmlhe/TqK5W
 dR1Dag4+ccUaZWFmwZ1ZDOfPXzcgVNJymd6Hih83YasK1B6iwQOAGBlZckgK3G6Mwzqw
 eESg==
X-Gm-Message-State: AOJu0YzXSEFoxAkE4JaAIdV1Vmi44jV2wrMsYlE1MGTYioTmuuNFn6SE
 FQHJawUDEbYyWo4KExdZnJu59yK0QXkEX45D6FU=
X-Google-Smtp-Source: AGHT+IHggRmjM2IiMfDPjgSI8PVTEWt7IpPMgU9CRvjnikjV/fHs0zv4UoXpqfXp5SC1wpCZZc1qnA==
X-Received: by 2002:a7b:c445:0:b0:3fb:b56b:470f with SMTP id
 l5-20020a7bc445000000b003fbb56b470fmr1553206wmi.14.1692194159226; 
 Wed, 16 Aug 2023 06:55:59 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 22-20020a05600c231600b003fc015ae1e1sm21655966wmo.3.2023.08.16.06.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 06:55:58 -0700 (PDT)
Date: Wed, 16 Aug 2023 16:55:56 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Sean Edmond <seanedmond@linux.microsoft.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, stcarlso@linux.microsoft.com,
 abdellatif.elkhlifi@arm.com
Subject: Re: [PATCH 2/5] drivers: security: Add TPM2 implementation of
 security devices
Message-ID: <ZNzVbGEloIVE6WCP@hades>
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-3-seanedmond@linux.microsoft.com>
 <CAC_iWjL7sx6F4d2VtvjksJ04z00bxjGGoefCdAUU+_0t598h8g@mail.gmail.com>
 <af88b677-77ff-0245-a76a-901b9d9ac998@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af88b677-77ff-0245-a76a-901b9d9ac998@linux.microsoft.com>
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

On Mon, Aug 14, 2023 at 02:23:22PM -0700, Sean Edmond wrote:
> 
> On 2023-08-14 1:39 a.m., Ilias Apalodimas wrote:
> > Hi Sean
> > 
> > On Sat, 12 Aug 2023 at 03:28, <seanedmond@linux.microsoft.com> wrote:
> > > From: Stephen Carlson <stcarlso@linux.microsoft.com>
> > > 
> > > This implementation of the security uclass driver allows existing TPM2
> > > devices declared in the device tree to be referenced for storing the OS
> > > anti-rollback counter, using the TPM2 non-volatile storage API.
> > > 
> > > Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
> > > ---
> > >   MAINTAINERS                     |   1 +
> > >   drivers/security/Makefile       |   1 +
> > >   drivers/security/security-tpm.c | 173 ++++++++++++++++++++++++++++++++
> > >   include/tpm-v2.h                |   1 +
> > >   4 files changed, 176 insertions(+)
> > >   create mode 100644 drivers/security/security-tpm.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > [...]
> > 
> > > +
> > > +struct security_state {
> > > +       u32 index_arbvn;
> > > +       struct udevice *tpm_dev;
> > > +};
> > > +
> > > +static int tpm_security_init(struct udevice *tpm_dev)
> > > +{
> > > +       int res;
> > > +
> > > +       /* Initialize TPM but allow reuse of existing session */
> > > +       res = tpm_open(tpm_dev);
> > > +       if (res == -EBUSY) {
> > > +               log(UCLASS_SECURITY, LOGL_DEBUG,
> > > +                   "Existing TPM session found, reusing\n");
> > > +       } else {
> > > +               if (res) {
> > > +                       log(UCLASS_SECURITY, LOGL_ERR,
> > > +                           "TPM initialization failed (ret=%d)\n", res);
> > > +                       return res;
> > > +               }
> > > +
> > > +               res = tpm2_startup(tpm_dev, TPM2_SU_CLEAR);
> > > +               if (res) {
> > > +                       log(UCLASS_SECURITY, LOGL_ERR,
> > > +                           "TPM startup failed (ret=%d)\n", res);
> > > +                       return res;
> > > +               }
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > There's nothing security related in that wrapper.  It looks like a
> > typical tpm startup sequence.  Any reason you can't use
> > tpm_auto_start()?
> 
> Good suggestion, I'll make this change.
> 
> > 
> > > +
> > > +static int tpm_security_arbvn_get(struct udevice *dev, u64 *arbvn)
> > > +{
> > > +       struct security_state *priv = dev_get_priv(dev);
> > > +       int ret;
> > > +
> > > +       if (!arbvn)
> > > +               return -EINVAL;
> > > +
> > > +       ret = tpm2_nv_read_value(priv->tpm_dev, priv->index_arbvn, arbvn,
> > > +                                sizeof(u64));
> > > +       if (ret == TPM2_RC_NV_UNINITIALIZED) {
> > > +               /* Expected if no OS image has been loaded before */
> > > +               log(UCLASS_SECURITY, LOGL_INFO,
> > > +                   "No previous OS image, defaulting ARBVN to 0\n");
> > > +               *arbvn = 0ULL;
> > Why aren't we returning an error here?  Looks like the code following
> > this is trying to reason with the validity of arbnv
> On the first boot (before ARBVN has been set in NV memory), it's expected
> that the NV index hasn't been initialized/written yet.  In this case,
> TPM2_RC_NV_UNINITIALIZED is expected.  A value of 0 is returned to ensure
> that the anti-rollback check always passes (which it should since there's
> nothing to check on the first boot).

Ok then I think it's better to add an 'init' function which will talk to
the TPM and try to read the value.  If you get an error or
TPM2_RC_NV_UNINITIALIZED(), we can then create the NV storage and
initialize it.  Note here that blindly returning 0 isn't correct either.  
When you define a TPM NV counter index it will hold any stored value (and
reuse it) even if you delete it and re-add it. 
I think doing it like this will make _get() a bit simpler, since you just
have to talk to the TPM and return whatever you read. 

> > 
> > > +       } else if (ret) {
> > > +               log(UCLASS_SECURITY, LOGL_ERR,
> > > +                   "Unable to read ARBVN from TPM (ret=%d)\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int tpm_security_arbvn_set(struct udevice *dev, u64 arbvn)
> > > +{
> > > +       struct security_state *priv = dev_get_priv(dev);
> > > +       struct udevice *tpm_dev = priv->tpm_dev;
> > > +       u64 old_arbvn;
> > > +       int ret;
> > > +
> > > +       ret = tpm_security_arbvn_get(dev, &old_arbvn);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (arbvn < old_arbvn)
> > > +               return -EPERM;
> > > +
> > What happens if they are equal ?
> > 
> If they are equal, then we are booting the same OS that was previously
> booted (we are not moving the OS version forward or back).
> 
> Note the actual "anti-rollback" check is in fit_image_verify_arbvn().  If it
> make things more clear, we could remove the value checks here completely and
> just write the value.
> 

Ok, I think adding another statment would be a bit easier to read then.
Right after reading the stored TPM value, just return 0 if arbvn == old_arbvn

> > > +       if (arbvn > old_arbvn) {
> > You just check for this and exited
> > 
> > > +               ret = tpm2_nv_write_value(tpm_dev, priv->index_arbvn, &arbvn,
> > > +                                         sizeof(u64));
> > > +               if (ret) {
> > > +                       log(UCLASS_SECURITY, LOGL_ERR,
> > > +                           "Unable to write ARBVN to TPM (ret=%d)\n", ret);
> > > +                       return ret;
> > > +               }
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct dm_security_ops tpm_security_ops = {
> > > +       .arbvn_get              = tpm_security_arbvn_get,
> > > +       .arbvn_set              = tpm_security_arbvn_set,
> > > +};
> > > +
> > > +static int tpm_security_probe(struct udevice *dev)
> > > +{
> > > +       struct security_state *priv = dev_get_priv(dev);
> > > +       struct udevice *tpm_dev = priv->tpm_dev;
> > > +       u32 index = priv->index_arbvn;
> > > +       int ret;
> > > +
> > > +       if (!tpm_dev) {
> > > +               log(UCLASS_SECURITY, LOGL_ERR,
> > > +                   "TPM device not defined in DTS\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       ret = tpm_security_init(tpm_dev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret = tpm2_nv_define_space(tpm_dev, index, sizeof(u64), TPMA_NV_PPREAD |
> > > +                                  TPMA_NV_PPWRITE | TPMA_NV_PLATFORMCREATE,
> > > +                                  NULL, 0);
> > How secure is that ? Is it protected by a locality? We dont seem to be
> > using an auth value when creating the index
> On our platform, we're using a different security device driver to provide
> our secure storage (we aren't using this TPM backed driver).  I'm not an
> expert on authorization for NV indexes, but I'd welcome feedback on how we
> could make this driver more secure (and publicly available) for others.

IIRC we can use a 'NV Counter Index' for the counter.  That's only allowed
to increment and even if you delete it and reinitialize it, it will retain
it's (lost) value)

> > 
> > > +       /* NV_DEFINED is an expected error if ARBVN already initialized */
> > > +       if (ret == TPM2_RC_NV_DEFINED)
> > > +               log(UCLASS_SECURITY, LOGL_DEBUG,
> > > +                   "ARBVN index %u already defined\n", index);
> > I'd prefer returning 0 here. The rewrite the code below as
> >   if (ret)
> >     log().....
> > 
> > return ret;
> > 
> > > +       else if (ret) {
> > > +               log(UCLASS_SECURITY, LOGL_ERR,
> > > +                   "Unable to create ARBVN NV index (ret=%d)\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int tpm_security_remove(struct udevice *dev)
> > > +{
> > > +       struct security_state *priv = dev_get_priv(dev);
> > > +
> > > +       return tpm_close(priv->tpm_dev);
> > > +}
> > > +
> > > +static int tpm_security_ofdata_to_platdata(struct udevice *dev)
> > > +{
> > > +       const u32 phandle = (u32)dev_read_u32_default(dev, "tpm", 0);
> > > +       struct security_state *priv = dev_get_priv(dev);
> > > +       struct udevice *tpm_dev;
> > > +       int ret;
> > > +
> > > +       ret = uclass_get_device_by_phandle_id(UCLASS_TPM, phandle, &tpm_dev);
> > > +       if (ret) {
> > > +               log(UCLASS_SECURITY, LOGL_ERR, "TPM node in DTS is invalid\n");
> > > +               return ret;
> > > +       }
> > > +
> > > +       priv->index_arbvn = (u32)dev_read_u32_default(dev, "arbvn-nv-index", 0);
> > > +       priv->tpm_dev = tpm_dev;
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct udevice_id tpm_security_ids[] = {
> > > +       { .compatible = "tpm,security" },
> > > +       { }
> > > +};
> > > +
> > > +U_BOOT_DRIVER(security_tpm) = {
> > > +       .name   = "security_tpm",
> > > +       .id     = UCLASS_SECURITY,
> > > +       .priv_auto = sizeof(struct security_state),
> > > +       .of_match = tpm_security_ids,
> > > +       .of_to_plat = tpm_security_ofdata_to_platdata,
> > > +       .probe  = tpm_security_probe,
> > > +       .remove = tpm_security_remove,
> > > +       .ops    = &tpm_security_ops,
> > > +};
> > > diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> > > index 2b6980e441..49bf0f0ba4 100644
> > > --- a/include/tpm-v2.h
> > > +++ b/include/tpm-v2.h
> > > @@ -321,6 +321,7 @@ enum tpm2_return_codes {
> > >          TPM2_RC_COMMAND_CODE    = TPM2_RC_VER1 + 0x0043,
> > >          TPM2_RC_AUTHSIZE        = TPM2_RC_VER1 + 0x0044,
> > >          TPM2_RC_AUTH_CONTEXT    = TPM2_RC_VER1 + 0x0045,
> > > +       TPM2_RC_NV_UNINITIALIZED        = TPM2_RC_VER1 + 0x04a,
> > >          TPM2_RC_NV_DEFINED      = TPM2_RC_VER1 + 0x004c,
> > >          TPM2_RC_NEEDS_TEST      = TPM2_RC_VER1 + 0x0053,
> > >          TPM2_RC_WARN            = 0x0900,
> > > --
> > > 2.40.0
> > > 
> > Thanks
> > /Ilias
> > 
> > 

Thanks
/Ilias
