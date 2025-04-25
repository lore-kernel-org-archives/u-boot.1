Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D9CC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 23:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C1E82A31;
	Sat, 26 Apr 2025 01:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="luIR4lde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A01C82A3B; Sat, 26 Apr 2025 01:26:23 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF278209C
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 01:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54b09cb06b0so2822849e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745623580; x=1746228380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n5nOmateXuvgNSNLx2YSQJ/1OoSA7qiztjaZzn59Ibo=;
 b=luIR4ldenxHeOpDqKJEea3sJQRjR6U8Cv0YlcFbl1vwBqFtyziz5fVY0vISvjfnZTt
 32RLPp91KUi6XaHXe1s+XQF/gehBPWjdlCxlAexwjzV8461xoZR6+2rtq4LNeHdYSDnr
 wSrfFaeGlgzYUXDLo/Q/WQVPnp3HpD7xf7p4Xu1Az7c3zrK73+/IkKh7JH58dN1mdsdQ
 L7gp1CUXR65i50G8Ww/Y0XyL35dY6b7MwoEUQAwOAl6lGIq3qy+0hCPnUdU7TSjmzGIc
 ubepSFPepO3DgjjHuRa9bqH4mjNUuw9IH1nzuS5B6XG+UegVnkfZ1gUN6szvCpGvG5Lu
 IGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745623580; x=1746228380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5nOmateXuvgNSNLx2YSQJ/1OoSA7qiztjaZzn59Ibo=;
 b=UB+dC9nYbaNRUsz7/AHqlLdBpw03HnapDFjpo7zqsB0LQX7y7i7l5U0jpARTe4UWyZ
 RUPDin8UevCfGy25sCOQcHJFmcstoQEYRL+Dxw/5mnofcxG0zC+INOjx76hMHYuaLBnl
 6ZvzNCTuNYDrdJahDfxyVRAdI94EFQ1GAEX6nMhOOkpMn4difYixhBpDqPCBtH7vAqvu
 XXAf5mvmliYnou0smsVIEHMmQ0AhprANJlhclh5Ov9XqeArCZ1HtBMxXY1sXesGNoTVd
 sQ9p9d4HnhkLt7F25kTtwQVhnsIYaNNnX/vfG3BxHCBBMcIwtvUBA2Zf8ZNm5IA4lu42
 /l3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyAPW7TRhDFmymtQZKTnQvrbSDzReUeVwocQ2r1O6E2gELHuzSlgdyMXNd1xNRZbNaTciKF5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyxR9A3lpG/RciThE8tvRjnDm3alDWop4fbKcwCzEOfqiQRoQtA
 b73OuPUa51/3PEcPOz/rfNWA1VTIKrylDCjDWjMQ1D6YvpyBIfiLHgTTWiu9ydrMgeQQ7SntpGD
 hypkoYtj77kNZiAp4BlBMQMSyZxJ4z1y36nesQg==
X-Gm-Gg: ASbGncvpvKUwK2JstwqxY8wq95HpHPDC4JxOmvNpgOt4Z/pSw8UIigGoStPDkn4FO7Z
 kRNY6+ARt6a4YfLimXzstPR0AHR8u1STP+NoO/Yw/cOJIvjNII36pzsZl2UdU+SwVIENijcDbM/
 7R12QXY8R5IeFPKmp0SfTtiswim8QUYpo+VBDbaSdB8RFzeI7YkkATF+Y=
X-Google-Smtp-Source: AGHT+IGXwBPfPsSxw8cg0ro6nEHLE7BKClSYNd43pXT0QDV4rkmUHQhSk7PXBlF1XTKB2hZL48+yvKFQ6ACSzND1+A0=
X-Received: by 2002:a05:6512:1319:b0:54d:6981:4b83 with SMTP id
 2adb3069b0e04-54e8cbce641mr1262384e87.24.1745623579853; Fri, 25 Apr 2025
 16:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250424201927.2027257-1-paulliu@debian.org>
 <20250424201927.2027257-3-paulliu@debian.org>
 <5b1181bf-1398-409c-b710-dc07e4eaa9d7@gmx.de>
 <CALG-KHz+spRA68RyzCUhWM4m_D2VoVLmiKJz85thuUbKyu6gOA@mail.gmail.com>
 <ff4da769-1b8f-4c53-a311-12eeecc859e1@gmx.de>
In-Reply-To: <ff4da769-1b8f-4c53-a311-12eeecc859e1@gmx.de>
From: Paul Liu <paul.liu@linaro.org>
Date: Sat, 26 Apr 2025 00:26:08 +0100
X-Gm-Features: ATxdqUGF4A_Lz1rWiZSe_ch6GzRHSPTSEnTPhrSSVZPU5XiGg4CsF_jFAEHsaNA
Message-ID: <CALG-KHw1HsY3HqwWi2y5v3N4s5965Hf8mBX1mZTyYgOCBvbuLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 25 Apr 2025 at 21:31, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 4/25/25 21:05, Paul Liu wrote:
> >
> >
> > On Thu, 24 Apr 2025 at 23:02, Heinrich Schuchardt <xypron.glpk@gmx.de
> > <mailto:xypron.glpk@gmx.de>> wrote:
> >
> >     On 24.04.25 22:19, Ying-Chun Liu (PaulLiu) wrote:
> >      > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org
> >     <mailto:paul.liu@linaro.org>>
> >      >
> >      > EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
> >      > debug purpose. This commit adds the table to the
> >     EFI_CONFIGURATION_TABLE.
> >      >
> >      > This feature is described in UEFI Spec version 2.10. Section 18.4.
> >      >
> >      > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org
> >     <mailto:paul.liu@linaro.org>>
> >      > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de
> >     <mailto:xypron.glpk@gmx.de>>
> >      > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org
> >     <mailto:ilias.apalodimas@linaro.org>>
> >      > ---
> >      >   include/efi_api.h             | 24 ++++++++++++++++++++++++
> >      >   lib/efi_loader/efi_boottime.c | 16 ++++++++++++++++
> >      >   2 files changed, 40 insertions(+)
> >      >
> >      > diff --git a/include/efi_api.h b/include/efi_api.h
> >      > index 5017d9037cd..0f4245091f1 100644
> >      > --- a/include/efi_api.h
> >      > +++ b/include/efi_api.h
> >      > @@ -238,6 +238,10 @@ enum efi_reset_type {
> >      >       EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
> >      >                0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
> >      >
> >      > +#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
> >      > +     EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
> >      > +              0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
> >      > +
> >      >   struct efi_conformance_profiles_table {
> >      >       u16 version;
> >      >       u16 number_of_profiles;
> >      > @@ -564,6 +568,26 @@ struct efi_loaded_image {
> >      >       efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
> >      >   };
> >      >
> >      > +#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
> >      > +#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
> >      > +
> >
> >     All structures and unions and their elements should be describe
> >     according to
> >     https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-
> >     and-enumeration-documentation <https://docs.kernel.org/doc-guide/
> >     kernel-doc.html#structure-union-and-enumeration-documentation>
> >
> >      > +struct efi_debug_image_info_normal {
> >      > +     u32 image_info_type;
> >      > +     struct efi_loaded_image *loaded_image_protocol_instance;
> >      > +     efi_handle_t image_handle;
> >      > +};
> >
> >     What are the assumptions about alignment?
> >     Should this structure be marked as packed like most UEFI structures?
> >
> >
> > Not aligned. This structure in EDK2 is not aligned, not packed. And it
> > is really not packed because the size of this structure is larger. 4
> > bytes are padded in the 64-bit environment I think.
>
> All other structures in EDK II are packed. Did you look at the structure
> in a debugger?
>
> The compiler will assume that a pointer to "struct
> efi_debug_image_info_normal *" points to a sizeof(uintptr_t) aligned
> structure if no other indication is made.
>
> Best regards
>
> Heinrich
>
>
> Hi Heinrich,

Yes. All other structures in EDK II are packed. But this one is not packed.

And yes, seems it is aligned to sizeof(uintptr_t) in edk2. How do we
implement this if we want the alignment? I plan to just remove that union
and use "struct efi_debug_image_info_normal" directly.
But maybe the alignment is not important here? I'll do a bit of research on
this.
Because we are not searching for this structure in the debugger. We just
read it from EFI_DEBUG_IMAGE_INFO_TABLE. Which will be in the Configuration
Table with specific GUID.
The only search in the debugger is for the SYSTEM_TABLE_POINTER structure.

Yours,
Paul
