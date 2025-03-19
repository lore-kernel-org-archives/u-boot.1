Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D6CC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 19:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EFC810F2;
	Wed, 19 Mar 2025 20:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d24vMQ2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65060810F4; Wed, 19 Mar 2025 20:11:31 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8917A80FF0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22349bb8605so163447655ad.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742411487; x=1743016287; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gP+qD/IizZc46LX/YmyayDUK6A+ApaPIXDK4ghhP4ok=;
 b=d24vMQ2lO2BbmVcn3c8QoCVs3MutHScu9Vgq3Mu6Y1MDPti5bNZJpdZ68uFHYdmU4g
 6ztEKHJ3HcAUNLx+R00NKnNnooF89Nvzid0NlrgtGU8y+LFAviJmCLO+n9KkhKlEhWFG
 TVL63RKa5I6sRESswtDA6ujtkEa/yfJeevXBB5WThOMJV9/iUKuflg9+GvS3ZunX+1Bq
 o0rziA/8KZB7+lYYgt5/5C7fgBV+LZyvhckOSCruJLnuYqBUly9lzImfB/oGQ0sATTCe
 5VjN4Z8Ew2iMSZXSul9kAQxGNOiWIXUfx5CeD9G4zDU3MCj4+pY08SxlVx3zD8qYDplL
 BvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742411487; x=1743016287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gP+qD/IizZc46LX/YmyayDUK6A+ApaPIXDK4ghhP4ok=;
 b=fq2I/+VN8wZUIMFkLivkYMagzSk1fTaoQzKgwjk9wFvEKKyGuUWqSnCRu6zwTtm41D
 0xAm1vkM9emrKIgzxPE5bavDLcXCKjiSsInz9oqWec5fFHO4YKCygfpz2cS5nlWgJBrf
 pNTRXx2GbnvA2CWnA96cZfZ+LtZ0jyMnoZMHimcmgKMjWQLVwBDih7PqNVanf71FHrP/
 SNbtHN6OYvwJn34NfOxTAhrNjZrMBiL8LZplqHWPLG55WnZYMaItcgGm1XFyq1YIFIW/
 V6k+IA0ByCFKEf4kfLR7PdivSjKbDstGaNKYRfDF9cutAeIMe+BLUZy1PJn5mLTfQCUL
 Z0LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmq4nVLowAskancbt6oVTQSsgDcD+UNrlw63ANDO7DX8sETZaZQMeYlERM/SRaCNHpBAW1j94=@lists.denx.de
X-Gm-Message-State: AOJu0YzaY7b5tyYG4xF6uN80yajwmQa1MNOwtB7ui5hWAzSI/Njo4Y5G
 1TGQHzn/YTL181LjSDzY4rcK+IGZVHuH0gj/sM+2lcLNZ5+T/NVh7WVBKUdFv01aH8SiQn1Twbr
 Xn3nGOb1NLIPxiXYBtpSGAIEVEFTB0sirZfA=
X-Gm-Gg: ASbGncvldyLvo4uXC/GksYimeX9dw3NaMo3pqmFAlOjDPT23ETztu3CZ5eO6/y3l+1S
 SWdu0iMQsZ3e35LCibljbf7aRZrVMrrOL8/GwuGUJ6a4s87NoDiZ06HYFmZgf1Aul4AdpjcB/5B
 qFr6xBBBHpPMYcwKxo6Ntgt9YFgbE=
X-Google-Smtp-Source: AGHT+IE81Tya0FJWYe/Clvf+NIp742gLaBoa73ZNEgZL8WVYhW5UvdEfDZS3GdEPgR3p2lthwEg6Hx7Y5YmUkypSxMM=
X-Received: by 2002:a17:90a:e7ca:b0:2fe:ac91:4667 with SMTP id
 98e67ed59e1d1-301be21fe92mr5739043a91.29.1742411486822; Wed, 19 Mar 2025
 12:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-3-adriano.cordova@canonical.com>
 <CAC_iWjKA8tzKdcRSUPWVdDkRNf2GEiz6dzbM6J6A+f788QqyJQ@mail.gmail.com>
 <CAMGU2hXE2gzQs7iibLMB66jJAL5qXm9CGpx5cvJ7AGP5vg8nFw@mail.gmail.com>
 <CAC_iWjJUjpDR_jAKVBg0We9=s=2hvxp7f6Yh8C+KVWs099AL=Q@mail.gmail.com>
 <CAMGU2hUV1Ats4H56Tzqd0+RhOzB1i2BRLh5oCx8CNZrjbGRnSQ@mail.gmail.com>
 <CAC_iWjJyj8pqCwzf0UOOYwoYmgrErmNyidqXtegDXrchdFgPBA@mail.gmail.com>
In-Reply-To: <CAC_iWjJyj8pqCwzf0UOOYwoYmgrErmNyidqXtegDXrchdFgPBA@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 19 Mar 2025 16:11:37 -0300
X-Gm-Features: AQ5f1JoOWyUb943x0MGexKj8n3JPpz03gxNM-wWKOxtP04kG07KbwcQNdIYXTaQ
Message-ID: <CAMGU2hVPeWM_3k375yD_QHqOBQyWjEx7zPgXvsdpERZ5ifcoAw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: binary_run: register an initrd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Understood, thanks! v2 sent.

Best,
Adriano

El mi=C3=A9, 19 mar 2025 a las 12:30, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> On Wed, 19 Mar 2025 at 15:02, Adriano C=C3=B3rdova <adrianox@gmail.com> w=
rote:
> >
> > Hi Ilias,
> >
> > Ok, I will change that in a v2.
>
> Ok i'll have a look at that
>
> > As a question: in here it is a U-Boot routine the one that is doing the
> memcpy of the initrd, the one implemented in the load_file2 protocol, the
> OS never knows about this dp explicitly, could we technically use reserve=
d
> data in here then?
>
> Technically yes, but what are you trying to achieve with the reserved
> memory?
> The loadfile2 design from the kernel does not include a device path to
> the initrd. The basically kernel tells the firmware "Can you give me
> my initrd now in this buffer which  I allocated" and the firmware is
> supposed to know what to copy in that buffer.
>
> Cheers
> /Ilias
> >
> > Il mer 19 mar 2025, 09:37 Ilias Apalodimas <ilias.apalodimas@linaro.org=
>
> ha scritto:
> >>
> >> On Wed, 19 Mar 2025 at 14:07, Adriano C=C3=B3rdova <adrianox@gmail.com=
>
> wrote:
> >> >
> >> > Hi Ilias,
> >> >
> >> > El mi=C3=A9, 19 mar 2025 a las 6:32, Ilias Apalodimas (<
> ilias.apalodimas@linaro.org>) escribi=C3=B3:
> >> >>
> >> >> Hi Adriano,
> >> >>
> >> >> [...]
> >> >>
> >> >> >   */
> >> >> >  static efi_status_t efi_binary_run_dp(void *image, size_t size,
> void *fdt,
> >> >> > +                                     void *initrd, size_t
> initd_sz,
> >> >> >                                       struct efi_device_path
> *dp_dev,
> >> >> >                                       struct efi_device_path
> *dp_img)
> >> >> >  {
> >> >> >         efi_status_t ret;
> >> >> > +       struct efi_device_path *dp_initrd;
> >> >> >
> >> >> >         /* Initialize EFI drivers */
> >> >> >         ret =3D efi_init_obj_list();
> >> >> > @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void
> *image, size_t size, void *fdt,
> >> >> >         if (ret !=3D EFI_SUCCESS)
> >> >> >                 return ret;
> >> >> >
> >> >> > +       dp_initrd =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> (uintptr_t)initrd, initd_sz);
> >> >>
> >> >> Why do we need reserved memory? What the EFI stub does, is allocate=
 a
> >> >> new memory buffer which you later copy the initrd to.
> >> >> I think Boot Services Data is enough.
> >>
> >> I meant to write loader data*
> >>
> >> >
> >> >
> >> > dp_initrd is freed when the efi application returns in
> efi_initrd_deregister. Do you suggest to change it to
> >> > Boot Sevices Data and when the efi application returns just assume
> that it is freed?
> >>
> >> You will still have to free it on failures which is what
> >> efi_initrd_deregister() will do once we return from efi boot manager.
> >> But if you define it as reserved memory, it won't be usable by the OS.
> >> Since linux will eventually copy that memory in a buffer it allocated,
> >> you don't have to preserve it. So you can just define it as
> >> EFI_LOADER_DATA
> >>
> >> >  I took the usage from:
> >> >
> https://github.com/u-boot/u-boot/blob/8bc3542384e3a1219e5ffb62b79d16dddc1=
b1fb9/lib/efi_loader/efi_bootmgr.c#L514
> >>
> >> This is a different use-case. In this we download and run an EFI
> >> application from memory and I guess the assumption is that the EFI
> >> application will return so the type doesn't matter that much as it
> >> will eventually be freed. This obviously is not the case if the EFI
> >> application is a kernel.
> >> That being said, I think we can switch this to LOADER_CODE as well.
> >> Heinrich any ideas?
> >>
> >> Thanks
> >> /Ilias
> >>
> >> >
> >> >>
> >> >>
> >> >> [...]
> >> >>
> >> >> Thanks
> >> >> /Ilias
>
