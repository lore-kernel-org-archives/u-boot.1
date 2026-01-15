Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A50D41159
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 10:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF9A880325;
	Thu, 15 Jan 2026 11:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LSd7Gvxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2CB83015; Thu, 15 Jan 2026 11:09:32 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E689A80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 11:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-78c6a53187dso6779437b3.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768471769; x=1769076569; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/U/LLGI+9SniwLuAqN8ajA6OzTeGIvIark8JmxcPtgE=;
 b=LSd7GvxzbehTgLca1iKCbbWauEesvCdP4xE/MHi57jx5yELTGlj2y2ZZ9ittMVZpAY
 vZTgNu8tbWI0HaR5Fq0I34kq8DLDW3GUau+mQaon3qObG1CL2NuLJ7c3uk5ZoOlwwgNg
 hTDS5Xyl0a96Jxdth+CEBGfYYAc2bGdy9p97LImrY+t39B0fggXJr9lGuCRjwy7fmv76
 6r6+M+ymfouXmqEgzQ489e+IVbaUvj7RFjQ+vLmndN94A8rSclITbqioeY2DNOW77ehN
 Z2dOenIHxnvdHAIKGRYkaE9rtJk8GE8mlahrC/hxNn/N4sreC9OmqZURLX26ByUcK/vt
 e3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768471769; x=1769076569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/U/LLGI+9SniwLuAqN8ajA6OzTeGIvIark8JmxcPtgE=;
 b=ta+6eASPyirCSFHC/9kM2LD7DUHhyxQBfqFQJ49PDcQPL95zsloZw8HJUSgg7l357u
 V8rtYjHyV1nvAT7yMyVP9Rad/BWX5UlbFnn90vdUbYwWp+4egJ3PVJAZNJWYFevu6kgn
 u7pCXnFh0QHCZ2G0jKwbB/DWBYHk5k8s8HGLsed7M663tvWWE7BCacZPzPFvppgYqVkh
 qymXxDeuC2T4rsviSzsS0ZrDjAafpj+uibFub+GObPKR3L0HK65/7N12zmQSpis5ej1W
 vSFOfm6udArd7aFFypeFYlbJZmioKBIN6TeXfB9/t5v1LWg1xUJOspswAj9Y4sG7Y4fS
 4vQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHx5+JkSnUBwjGOxgTNzelvi0RVecFNPlSirgif25xkE2hwCGRcdt8zm2XB2KpUJKr2kVn97c=@lists.denx.de
X-Gm-Message-State: AOJu0YygT23n7FGlXzyaF1oS4NnmOuVuHAaOvQqvy2xmTOWbvhlsj14z
 K/ikSlCNTveZHzrzdYPzTET3tuIho3y8bv9XoNknOFHhKlNzW986Gp26R66VMc9PRll4WwHLnF4
 HmHdqCxvi2Cbhisb2rwryrKCovHgYyIwv7cB1knQUpQ==
X-Gm-Gg: AY/fxX5Xw7IyCgv8NtOqCGF0xIx51jTq5BrDwfwTvfkmAqziqL8sKV1ZkCE1V8Vljbr
 1WX9FFiQY2147a1aB0VZeI5Vpwd/aEZ7w6LncIvKJFvn9wp5ftdBipq3mK3nX0ufI9RIKodGtrg
 U+LEljVahEAfjFiC5fvNlcy0+tC6Y1RIEQvv63f+XSIz+R8/IFmbwImxU6YFgRBbl/bhCZ5bOpp
 td0VUq3Xub5Dt8UBGKmPGSyhshwGGE9qRmFli8mpu2pMySjkPGhriesHO5yM/EJT3dM7Ct/KeQ9
 BrpkYfyGvHbzsv0+MjtODwBFpS7dM9GTAStCYEGE1jIaw5VJkyN/Ndaz6XNfdo9A7n0FcFkHkDM
 IxG8mOfd3Clw4oMveOuUvlCvbvugHnWU2xD5u7C2IBcSdFyPTvKGb3ZiLxvWAAlNSQUvH1NCtXr
 VJNRLUG6nSqEdUR4WQzLWsJC0UNtdvYoO8r5YUs9l7Qcm4TZXR2UnahjEfypTz7bMjG1K8WyaHi
 63XIrPGICjJn80qnIUC20ghDHjC4aByuBXDllr2+ZS4nnNrV+7ZKGyt9e+9kvhxR1Ol9UxkkpKv
 3oS6UjptLyvDEjnvJ4jXWXX3obCCNPtd60VNuJHGRmQ=
X-Received: by 2002:a05:690e:1689:b0:646:7c80:d20 with SMTP id
 956f58d0204a3-64901b1de5fmr4084791d50.75.1768471768673; Thu, 15 Jan 2026
 02:09:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
 <CAC_iWj+_VfEAE3NRr9QxJHtR0oq3JdqrO3vj583TxBDetH6QkA@mail.gmail.com>
 <CALeDE9NbsotYjk7RdUmu4OPO71_cN9_TuoFwUmJD8Zuff49XnQ@mail.gmail.com>
In-Reply-To: <CALeDE9NbsotYjk7RdUmu4OPO71_cN9_TuoFwUmJD8Zuff49XnQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 15 Jan 2026 12:08:52 +0200
X-Gm-Features: AZwV_QiXITYF3ldGTbW1rcMR6MqFwMdBf1tksFg1Mq7mmKTvDnAdwvDGhMyhn_o
Message-ID: <CAC_iWjLuxh416tFSz_aaHZihbbdC14htYFJdQvDSQQbFGeQLLQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com, 
 Shantur Rathore <i@shantur.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Thu, 15 Jan 2026 at 12:02, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Thu, 15 Jan 2026 at 08:05, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Michal
> >
> > Thanks for taking the time.
> >
> > [...]
> >
> > > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > > index be670a8e7c25..feab212b245b 100644
> > > --- a/lib/efi_loader/efi_variable.c
> > > +++ b/lib/efi_loader/efi_variable.c
> > > @@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> > >                 ret = EFI_SUCCESS;
> > >
> > >         /*
> > > -        * Write non-volatile EFI variables to file
> > > +        * Write non-volatile EFI variables to file or SPI Flash
> > >          * TODO: check if a value change has occured to avoid superfluous writes
> > >          */
> > >         if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> > > -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> > > +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> > >                 efi_var_write();
> > >  #else
> > >                 return EFI_NOT_READY;
> > > @@ -599,7 +599,7 @@ efi_status_t efi_init_variables(void)
> > >         if (ret != EFI_SUCCESS)
> > >                 return ret;
> > >
> > > -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> > > +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> >
> > So I think this is might to come back and bite us in the future.
> > The name of the file is a bit misleading, but efi_variable.c is
> > supposed to handle the variables with a file backed storage and
> > efi_variable_tee.c is handling the variables when the storage is
> > isolated in the secure world.
> > The problem is that each case defines the boottime and runtime
> > services. The functions that are common across cases live in
> > efi_var_common.c. That files defines the boottime and runtime calls,
> > by calling the *_int() variants.
> >
> > The file backed and SPI flash storage seem to have a lot in common.
> > e.g they both use the memory backend to expose the vairables the the
> > OS, query the available storage etc. But I am not they will end up
> > being 100% identical. If they do this approach is ok. But ifthey don't
> > it's better to expand the efi_var_sf.c you added and add code for
> > efi_variables_boot_exit_notify(), and any *_int() functions that are
> > different.
> >
> > Heinrich any opinions? I'll need to think through the SPI case
> > inclduing runtime support before taking this in
>
> Do we also need to consider the case where the SPI flash remains owned
> by the firmware/secure world, and the case where it's handed over to
> the OS?

No, we dont have to care about this. If the SPI moves to the secure
world, then efi_variable_tee.c will take care of it. This file is
basically a glue layer between U-Boot and StMM running in op-tee. So
the majority of the works to support this is in OP-TEE & StMM -- add a
spi bus driver, spi flash driver etc. I dont expect to change the
u-boot part substantially

Cheers
/Ilias
