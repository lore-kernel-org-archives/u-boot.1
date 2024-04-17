Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4223C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 13:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DCC78835E;
	Wed, 17 Apr 2024 15:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="guxClz24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B308842A; Wed, 17 Apr 2024 15:21:24 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E172B87E75
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 15:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516d3776334so7077321e87.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713360081; x=1713964881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3W84USv6siUVoJ0B90ESUfqeJtS9WPTWefKIVO3pg38=;
 b=guxClz24V4AqvyWfMJuhCn8Mo4+zuu2vgl7iSJurwL+G3nXF2quCXsA4n5biU42J1B
 s6sSqs2PLaPzodtzxCY9YlSYv8KO7/0imQUlBRA/e/jg4J84E8utQD88YHNFemgA2Blp
 0QgF+MKAH3XXoA4VH1OOPYnpshOjDcrHRBmAW95rJgQej6i/xy/S+PxKiWe1yhPhngIP
 5OEtrfdyB4ybxBlN6HLfcrKfz+JlGFLHGNXFgsTDhGKvfYYW8axj9M+52MhQTuSfB5/3
 KJtEeFX45hCfpyGVnlorDiDNSAECRrTmEK0uqIQKK7qgr7aLxeo84LR+trIsPt5sdoIT
 gwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713360081; x=1713964881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3W84USv6siUVoJ0B90ESUfqeJtS9WPTWefKIVO3pg38=;
 b=inkeetvQh4QSjP7cHGfeiFTXQetVupOHCsrErbB1KB2Bbc6SZZVrHR1BIYYo2SZdcH
 XpUYzEBF/rCnkCnvxgWf22wqiP3t8SS94QdI2OqhDflq39swWVgGMmW/2MP4ipNAv63R
 vX8Z5VPleoF8Q5WNovU3rWppq8MYsMHl3YF5K20tymoIYHsa6a1KhK7TfFFtBQPfyB/o
 XWbr2ruViiVHmXls6LUF5WRysQOkN6gHfD9ri1zu01Q6n07sDZ/LRnhMtiJLyVu42cYM
 dlNSo3MuDY1IIJiGK06MIALVoMh57RIjl+As3DxGX00F2lqvuwVzrGmy3Zux0/B7kCGU
 GSMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5TD/l4g4Tl3+1SJ3dXVvaNA7jVtGiDftrEgjScf0fhVXlur5cfxIXd1eYTANxym9r0Lf+q8gd13PGrb9sQDuQXTppVQ==
X-Gm-Message-State: AOJu0YyZmdMQKnOARHMD1CXrC8MDguveGZx4okMszxeeOcBahMshmue3
 oGaAyb+Ez3oeioyXmxFfOqbJHLQUO0KeQkXgZL0JjoBaw+JCJtqvzSiGpaZOJB9qdmWxNL8laRP
 fM+4tuieJhXBkczS/lxFQioMsHmDfCTPahcGYgA==
X-Google-Smtp-Source: AGHT+IG7/qI01p4fbI6v4SZEJxrlSYVXdC2dCTPaVEwsO1KwHm2yzJCDlHG/yE62+LCJsEywRK1TP8thxKpi1T+BKbc=
X-Received: by 2002:a05:6512:1386:b0:519:813:7f5c with SMTP id
 fc6-20020a056512138600b0051908137f5cmr6496511lfb.0.1713360081110; Wed, 17 Apr
 2024 06:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
 <20240417101928.119115-4-ilias.apalodimas@linaro.org>
 <9d352b5f-f190-4363-89fa-0b70bc938900@canonical.com>
In-Reply-To: <9d352b5f-f190-4363-89fa-0b70bc938900@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Apr 2024 16:20:44 +0300
Message-ID: <CAC_iWjKzDQCXFj817LOgkYHz21gciga1gfonDGgPtXzV+a7MKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi_loader: add an EFI variable with the file
 contents
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com, 
 pjones@redhat.com, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, 
 Janne Grunau <j@jannau.net>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de,
 kettenis@openbsd.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Heinrich,

[...]

> >   {
> >       int ret = 0;
> >
> > diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> > index c8f7a88ba8db..99ad1f35d8f1 100644
> > --- a/lib/efi_loader/efi_runtime.c
> > +++ b/lib/efi_loader/efi_runtime.c
> > @@ -130,6 +130,8 @@ efi_status_t efi_init_runtime_supported(void)
> >                               EFI_RT_SUPPORTED_CONVERT_POINTER;
> >
> >       if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> > +             int s = 0;
>
> u8 s = 0;
> should be enough.

Sure,

> >               }
> > +             ret = efi_set_variable_int(u"VarToFile",
> > +                                        &efi_guid_efi_rt_var_file,
> > +                                        EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                        EFI_VARIABLE_RUNTIME_ACCESS,
>
> Why is the variable set here? A comment would be helpful.

We need to set it so it shows up in the efivarfs, fo linux, and the
variable list in general for other OSes. Otherwise, people won't be
able to read it, unless they specifically search for it. I'll add a
comment though

> If you set it for protection, shouldn't it be EFI_VARIABLE_READ_ONLY?
>
> An alternative would be to return EFI_INVALID_PARAMETER in
> efi_set_variable_int for any attempt to set a variable with GUID
> efi_guid_efi_rt_var_file.

It's not volatile, so it will be treated as RO at runtime. But I'll
add EFI_VARIABLE_READ_ONLY as well. I prefer using the existing EFI
APIs instead of treating GUIDs specially

[...]

> > +/**
> > + * efi_var_collect_mem() - Copy EFI variables matching attributes mask from
> > + *                         efi_var_buf
> > + *
> > + * @buf:     buffer containing variable collection
> > + * @lenp:    buffer length
> > + * @mask:    mask of matched attributes
> > + *
> > + * Return:   Status code
> > + */
> > +efi_status_t __efi_runtime
> > +efi_var_collect_mem(struct efi_var_file *buf, efi_uintn_t *lenp, u32 mask)
> > +{
> > +     static struct efi_var_file __efi_runtime_data hdr = {
> > +             .magic = EFI_VAR_FILE_MAGIC,
> > +     };
> > +     struct efi_var_entry *last, *var, *var_to;
> > +
> > +     hdr.length = sizeof(struct efi_var_file);
> > +
> > +     var = efi_var_buf->var;
> > +     last = (struct efi_var_entry *)
> > +            ((uintptr_t)efi_var_buf + efi_var_buf->length);
> > +     if (buf)
> > +             var_to = buf->var;
> > +
> > +     while (var < last) {
> > +             u32 len;
> > +             struct efi_var_entry *var_next;
> > +
> > +             efi_var_mem_compare(var, NULL, u"", &var_next);
>
> On IRC you suggested to make u16_strlen __efi_runtime_code to replace
> this efi_var_mem_compare() call and avoid the modifications of said
> function. That might be more readable.

Yes it will, I'll change that on v3. That function will also help us
clean various open-coded sequences of length calculations.

FWIW I just managed to run FWTS over this -- and I also fixed
QueryVariableInfo at runtime
We had 22 tests passing and 1 failing. I am still trying to figure out
what failed, but I'll fix that as well for v3

>
> Best regards
>
> Heinrich
>
> > +             len = (uintptr_t)var_next - (uintptr_t)var;
> > +
> > +             if ((var->attr & mask) != mask) {

[...]

Thanks
/Ilias
