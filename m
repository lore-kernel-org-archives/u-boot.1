Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E93ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB1888CBD;
	Mon,  9 Sep 2024 13:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lN5GwEwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D3E88CE4; Mon,  9 Sep 2024 13:24:54 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49D088C7F
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2068a7c9286so37730155ad.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725881090; x=1726485890; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r3L/1TfdHg3cGl2Y9PDESq03q65uNx/UNP631GBwC60=;
 b=lN5GwEwnh6KvsnHzCE6QK7BJS04nsN7kWK88f/G1GcQkoWSdZxCN0r3XURuFPZvsJm
 tj+ByLflhdIDDEQ2BQUdAradH6OE1oIcUDvPTMnsxCY4cYnaTIUb2JRfsBcrn+ry6ps8
 zHxMc4LcE1qdZOKPPb3xyN9Ifzav3ZqsaSpexHFf2b4OD1cmZ6QNS7C9MB7VSI3iWVqf
 DRks+ByBB2rqIC3RCkRyWYtZzqWrJN6Qc5kYUC40Iv8kUA/Nos8BKmPQj4gt0WxO1Adk
 xjiHS+SE5m/RVv5CYz7dYBRFuPgfjvTQ5kp8kqELtU0I5+uzTTut8U+zu68sC+PUvdNc
 RSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725881090; x=1726485890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r3L/1TfdHg3cGl2Y9PDESq03q65uNx/UNP631GBwC60=;
 b=fgrsD5LKuDVxUcblHv6N/cEZEpB5XPFpu9KStDGd3etkYjNWj4us2f95FLoTiAs3mz
 4Cebg0edMjRTmUgK+goDQEo+uZUyn6pUZhF/upxnR+2g18dlEnxrbOalzVJXB2WPHhMs
 CdKd/NYHuEO7XDiqDIJnvbe/dHFz/2/3YWRgJ3Djq2uvZphaNxQiqrxFq8qZuZH+rcQA
 8YOLyHPyYgvp/qjxiKUiH2HOHx+PlspVxxbEjmUdMH31EXuyOdQntv1BratXUbg9isnF
 TQlaD4HRLglFW51paBPI/+/3Kzmx7NfvAV5nPmF/o8vEMgOVfc8jLCqLzgXUIJBCNDLu
 i/Ow==
X-Gm-Message-State: AOJu0YzApSTX97jKgFLcAae16OR/HT3SKwl2H+V9bGk/vAu0l91fjJDC
 IYCOW9Vnfg/Xsxt45aPNNBZ8lEutc5K/N+ffl+FekguNW0ibPTlaoNzU0IwPiL2pr6M8MCX/iM5
 MYBmU08asz4jjlJXn6mGpQX9wcj7JtNLyq52U6A==
X-Google-Smtp-Source: AGHT+IHIhdvZ5GrVt+tVpIUdhCq2jHZs6Q6tKgGDJUTyUvYUT16ORz1y6JPd+IqE+wnWulOyfaDjo8bfTcWOqxIwhkQ=
X-Received: by 2002:a17:902:cf04:b0:202:2d:c87 with SMTP id
 d9443c01a7336-206f04a10e6mr154989915ad.12.1725881089929; Mon, 09 Sep 2024
 04:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR10MB52445073A01A8668C66ADAA0E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
 <ZqefQTOIwKSl1YzC@hades>
 <DU0PR10MB52446E962D0972A948FD376BE1882@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DU0PR10MB52446E962D0972A948FD376BE1882@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 9 Sep 2024 14:24:13 +0300
Message-ID: <CAC_iWjJ40w4twuV-boQuwb4cLugWpx8_QS1OxVcLa=0Wpn2svA@mail.gmail.com>
Subject: Re: [PATCH 1/3] tpm: update tpm hash algorithm according to tpm2.0
 spec 1.59
To: Benjamin BARATTE <benjamin.baratte@st.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "eajames@linux.ibm.com" <eajames@linux.ibm.com>, 
 "sjg@chromium.org" <sjg@chromium.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, 
 "trini@konsulko.com" <trini@konsulko.com>
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

Hi Benjamin

On Fri, 23 Aug 2024 at 15:25, Benjamin BARATTE <benjamin.baratte@st.com> wrote:
>
> Hi @Ilias Apalodimas,
>
>
> ST Restricted
> > -----Original Message-----
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Sent: Monday, July 29, 2024 3:55 PM
> > To: Benjamin BARATTE <benjamin.baratte@st.com>
> > Cc: u-boot@lists.denx.de; eajames@linux.ibm.com; sjg@chromium.org;
> > tharvey@gateworks.com; trini@konsulko.com
> > Subject: Re: [PATCH 1/3] tpm: update tpm hash algorithm according to
> > tpm2.0 spec 1.59
> >
> > Hi Benjamin,
> >
> > Apologies for the late reply, but I wasn't cc'ed in the series. Did you use
> > get_maintainer.pl for the recipients?
>
> I have tried but due to the corporate setup, I'm not able to use the script to format and send the message automatically...
> >
> > On Mon, Jul 15, 2024 at 01:33:16PM +0000, Benjamin BARATTE wrote:
> > > The hash algorithm structure shall reflect the TCG specification for
> > > TPM2.0
> > > With vesion 1.59, the SHA3 algorithm has been added and shall be
> > > reflected in this structure.
> > > The fact that U-Boot does or does not support SHA3 algo yet is not
> > > relevant for this structure.
> >
> > It's not, but I don't see why we should add more algorithms if we don't plan to
> > support them. Any plans of adding actual support for the SHA3 family?
> >
>
> The main issue here is that the new version of hardware TPM are now using default PCR configuration with SHA256 and SHA384 as per the TCG specifications and U-boot can't support them and generate error at boot time.

Why? e7505b3b8bcd1b introduced the errors but sha256,384 are already
supported. Unless you mean sha3-256?

>
> For the SHA3 family support, they are supported in the Linux Kernel already, therefore, this should be supported in the U-boot to ensure consistency in the full boot chain


You are just adding the defines here. The commit above has the
reasoning of why we block measurements, and just adding the defines to
bypass the check is not the right thing to do.
>
> Also, TPM API offer hash interface, therefore if the PCR is using SHA3, the hash calculation could be done by the TPM regardless of the software support in U-boot.

I am not exactly sure what you mean here. Is that part of the API in U-Boot?

Thanks
/Ilias
>
> Best Regards,
>
> Benjamin
>
> > Thanks
> > /Ilias
> > > It's up to the end user to configure the active PCR bank to supported
> > > hash algorithm by all boot chain component.
> > > Also, by default, TPM2.0 shall support at least SHA256 and SHA384, in
> > > practice dTPM support 2 actives banks with this 2 hash algorithms
> > >
> > > Signed-off-by: Benjamin BARATTE mailto:benjamin.baratte@st.com
> > > ---
> > >
> > >  include/tpm-v2.h | 35 ++++++++++++++++++++++++++++++-----
> > >  1 file changed, 30 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/tpm-v2.h b/include/tpm-v2.h index
> > > 4fd19c52fd..9848e1fd10 100644
> > > --- a/include/tpm-v2.h
> > > +++ b/include/tpm-v2.h
> > > @@ -253,6 +253,9 @@ enum tpm2_algorithms {
> > >         TPM2_ALG_SHA512         = 0x0D,
> > >         TPM2_ALG_NULL           = 0x10,
> > >         TPM2_ALG_SM3_256        = 0x12,
> > > +       TPM2_ALG_SHA3_256       = 0x27,
> > > +       TPM2_ALG_SHA3_384       = 0x28,
> > > +       TPM2_ALG_SHA3_512       = 0x29,
> > >  };
> > >
> > >  /**
> > > @@ -271,11 +274,15 @@ struct digest_info {  };
> > >
> > >  /* Algorithm Registry */
> > > -#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> > > -#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002 -#define
> > > TCG2_BOOT_HASH_ALG_SHA384  0x00000004 -#define
> > > TCG2_BOOT_HASH_ALG_SHA512  0x00000008 -#define
> > > TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> > > +#define TCG2_BOOT_HASH_ALG_SHA1     0x00000001
> > > +#define TCG2_BOOT_HASH_ALG_SHA256   0x00000002
> > > +#define TCG2_BOOT_HASH_ALG_SHA384   0x00000004
> > > +#define TCG2_BOOT_HASH_ALG_SHA512   0x00000008
> > > +#define TCG2_BOOT_HASH_ALG_SM3_256  0x00000010 #define
> > > +TCG2_BOOT_HASH_ALG_SHA3_256 0x00000020 #define
> > > +TCG2_BOOT_HASH_ALG_SHA3_384 0x00000040 #define
> > > +TCG2_BOOT_HASH_ALG_SHA3_512 0x00000080
> > > +
> > >
> > >  static const struct digest_info hash_algo_list[] = {  #if
> > > IS_ENABLED(CONFIG_SHA1) @@ -310,6 +317,24 @@ static const struct
> > > digest_info hash_algo_list[] = {
> > >                 TPM2_SHA512_DIGEST_SIZE,
> > >         },
> > >  #endif
> > > +       {
> > > +               "sha3_256",
> > > +               TPM2_ALG_SHA3_256,
> > > +               TCG2_BOOT_HASH_ALG_SHA3_256,
> > > +               TPM2_SHA256_DIGEST_SIZE,
> > > +       },
> > > +       {
> > > +               "sha3_384",
> > > +               TPM2_ALG_SHA3_384,
> > > +               TCG2_BOOT_HASH_ALG_SHA3_384,
> > > +               TPM2_SHA384_DIGEST_SIZE,
> > > +       },
> > > +       {
> > > +               "sha3_512",
> > > +               TPM2_ALG_SHA3_512,
> > > +               TCG2_BOOT_HASH_ALG_SHA3_512,
> > > +               TPM2_SHA512_DIGEST_SIZE,
> > `> +       },
> > >  };
> > >
> > >  /* NV index attributes */
> > > --
> > > 2.34.1
> > >
> > > ST Restricted
