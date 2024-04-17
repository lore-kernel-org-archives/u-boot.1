Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C231EC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0434088343;
	Wed, 17 Apr 2024 14:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vt+ejIwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1647688343; Wed, 17 Apr 2024 14:33:40 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5BF8844A
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 14:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5194a4da476so699290e87.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713357217; x=1713962017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6jYWjkyjUZrDfSlzws1MkRH75w/5rknb/+E49eDadRY=;
 b=Vt+ejIwv+RkpHKqf5wve8EVWf7EE3QlDtXc1clibNv2pt9rDuFgc+pXToJME8vW5D0
 t/zjkJODxw66xqUsxFMqMzJYHIzkykdgqcpB5FbexDBqeBahyZeP9zbZLbLFNYuwN9NL
 0jqUpbT217+vXUkq5DP0ZSWEwUNu9DIPi6HAHKGjXg6xfucPdrm63G3CKAUhSF53+Q+R
 TMvDJk6gvCSFqwwu8qTbYGqIuFduwWnHuNNelKqK0k4HQDgd/JmNHlPsceE1n4+jg9nK
 pscPUiW5O/vuKpf358IjQ6MZVtGsJ53LpJDStC5rNUVB+oREkwK+mBukLTXyEBRnHbsD
 iU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713357217; x=1713962017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jYWjkyjUZrDfSlzws1MkRH75w/5rknb/+E49eDadRY=;
 b=w8CfPdvO0oXCHD1RN6WzpWflK8Tb2/xoUM2WUKGo7YzPBVJbhRi4VpWTG4gbotXJI1
 INC0UQPkSTrhtKQTLAQdV9c8tPPQI6UwnRbsl0qSSLMzoYFXqE1gaP/yWfya5ITGgLWP
 j/HyX3AMEbQ1y44p5IqFgJVOboFJ+GANFduJ+PVikf81aPdNXzb5auyog4/BXtK+2Egu
 pdGUB/6B3x7pO2s6VbrwaNovZuy5X/Iv1gdbpKvDcTMjuvkFWjzh1J5BT1R1ZL0i8kh4
 x/t4WeaIJBdbMzH0yc/lnR/8TGFLbB1cCi+An0kiHf99q9mAIscPb5s5ZD48jmAKH/qc
 WbcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHJWDxvQ9byTqtNFLioHn3JADHXyswcCmtqeJBViwb5vl43qJ/roKYWICBzJ4nsBVCtodZNLp0TEPVOYGy+/6FiDRReA==
X-Gm-Message-State: AOJu0YyelG/BjA0gOXZGuptK9+O9J2snWPB4jXXvqSuLp0DQVQ+qRiwE
 9q6Xcs07NDM6R1c7K87m022GteuumBPyBOluXL8OY8IBE8obELmAlEvr26NwFOvYyPbNxlfIRIp
 5PIzhfHpqgIgan5euciRTBJgLbEHGZs9sMBj6fg==
X-Google-Smtp-Source: AGHT+IG4vXigieXn/sJ2ZZghGY98Z35KXx/BjHQzfmLvwZE1Uz0UMlcYKF+SDc2GfAHxLCxMqbi7y4OvH1u01po/cP4=
X-Received: by 2002:a05:6512:3901:b0:515:a8c9:6e99 with SMTP id
 a1-20020a056512390100b00515a8c96e99mr11085642lfu.5.1713357217002; Wed, 17 Apr
 2024 05:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
 <20240417101928.119115-5-ilias.apalodimas@linaro.org>
 <21bbc05c-bf07-406f-a16a-e7655f8958ea@gmx.de>
In-Reply-To: <21bbc05c-bf07-406f-a16a-e7655f8958ea@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Apr 2024 15:33:00 +0300
Message-ID: <CAC_iWjLXW3t_kxu8XGDHLvov6baHU7NgiAjamAQxTjMhMRLxOA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi_selftest: add tests for setvariableRT
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com, 
 pjones@redhat.com, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Janne Grunau <j@jannau.net>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de,
 kettenis@openbsd.org
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

> >
> > +     memset(v2, 0x1, sizeof(v2));
> >       ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> >                                          &max_storage, &rem_storage,
> >                                          &max_size);
> > @@ -63,10 +69,107 @@ static int execute(void)
> >                                   EFI_VARIABLE_RUNTIME_ACCESS,
> >                                   3, v + 4);
> >       if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> > +             efi_uintn_t prev_len, delta;
> > +
> >               if (ret != EFI_INVALID_PARAMETER) {
> >                       efi_st_error("SetVariable failed\n");
> >                       return EFI_ST_FAILURE;
> >               }
> > +
> > +             len = sizeof(data);
> > +             ret = runtime->get_variable(u"RTStorageVolatile",
> > +                                         &efi_rt_var_guid,
> > +                                         &attr, &len, data);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("GetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             len = sizeof(data2);
> > +             ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> > +                                         &attr, &len, data2);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("GetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +             /*
> > +              * VarToFile will size must change once a variable is inserted
> > +              * Store it now, we'll use it later
> > +              */
> > +             prev_len = len;
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         sizeof(v2),
> > +                                         v2);
> > +             /*
> > +              * This will try to update VarToFile as well and must fail,
> > +              * without changing or deleting VarToFile
> > +              */
> > +             if (ret != EFI_OUT_OF_RESOURCES) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +             len = sizeof(data2);
> > +             ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> > +                                         &attr, &len, data2);
> > +             if (ret != EFI_SUCCESS || prev_len != len) {
> > +                     efi_st_error("Get/SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /* SetVariableRT updates VarToFile with efi_st_var0 */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         sizeof(v), v);
>
> It is fine to test with variable name size (24) and variable value size
> (16) both being multiples of 8. But this does not cover the generic case.

We already test SetVariable with a non-aligned variable at the start.
I'll keep this as is and add append 1byte at the last test as you suggested.

>
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +             len = sizeof(data2);
> > +             delta = 2 * (u16_strlen(u"efi_st_var0") + 1) + sizeof(v) +
> > +                     sizeof(struct efi_var_entry);
>
> In the file all variable are stored at 8 byte aligned positions.
> I am missing ALIGN(,8) here.

Ah yes

>
> > +             ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> > +                                         &attr, &len, data2);
> > +             if (ret != EFI_SUCCESS || prev_len + delta != len) {
> > +                     efi_st_error("Get/SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
>
> We should check the header fields of VarToFile (reserved, magic, length,
> crc32), e.g.
>
> struct efi_var_file *hdr = (void *)data2;
> if (memcmp(hdr->magic, EFI_VAR_FILE_MAGIC, 8) ||
>      len != ALIGN(hdr->length + sizeof(hdr), 8) ||
>      ... )

Sure, good idea,

>
> > +
> > +             /* append on an existing variable will updateVarToFile */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_APPEND_WRITE |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         sizeof(v), v);
>
> How about just appending 1 byte when using EFI_VARIABLE_APPEND_WRITE and
> checking that the delta here too?

Yes, I'll change this

[...]

Thanks
/Ilias
