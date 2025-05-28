Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8F7C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 07:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A849983906;
	Wed, 28 May 2025 09:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZWMRxGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641028390C; Wed, 28 May 2025 09:36:00 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166D583158
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so247451566b.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748417757; x=1749022557; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K9/tffdnu5SQFb5kqOCkL398NRyou+EAs49Da9tCxY0=;
 b=oZWMRxGoUuErPQH4l2a7J5hJ8BsqIej/6pIK7MtCyHNZp1V4zadHQVwDkMF0xfvj2G
 hrL2LNWrgnHqNzZmhz3LJL7mfpf47yGe04remFFOSshbZv6gDkap0VEyK/dyrwiwO5bf
 Sl/h2e02bTO5WSdrnh6Vi7ySc3gffoMiJasLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748417757; x=1749022557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9/tffdnu5SQFb5kqOCkL398NRyou+EAs49Da9tCxY0=;
 b=pNgPIhTB7wJ5W49/NR+TV2xdHM0qQbNAfldvPjyeSaQ4Fr09shTp0illWwVWyyYBBr
 8S6s4GmMNgXDFEvee1AtRzOg5zCbBlJbWcHz6e5bPKPp1L1+aijKGsezXKvkTFDAwga0
 3qjam+CQzdh+pZr5B15RcctYQrRamIvVRKXzeRcjQ021a++QPtFgpgme0NnHmUUJ3EMx
 wNoFzX68kRHDrX6sz5ohW/ncckac/fYamlZWsWQ9w0CgvYy24fqK0yRPSLvKh264atVp
 glJkK68fpY53DP+C6flIN55c01kNp6PWpSLhCoTz82Qxb12ZZk1Vs0+P7J/mN+yzz4kC
 C5Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULsGUt4Ch2d3XuF9vIn+ThUHOyxfdHVrEjSbG4XvbaEe1/LrySbzSF0FAWj4gJ44tL8yvFNZA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzz7YhzvJk5EGrtQK+ZZFesjbGOv2a61abEgY2hUlkWtLgWqNwf
 1uBSq9cJN/vGwOAPgsdtrsetbFlHrTmMKcgkJzh0GwN/7OWdUMBjNd8oOclrtvG3w/hkBuh5s3A
 8INLxdPWpdxe7IouqYNqt1xZ5v0YslV/FUW/CIddz
X-Gm-Gg: ASbGncuPJeIus6a4ZGNaDC1cUeTjfYiOAt+gFfy+q5iTZ3kbmLZKjjhvc+kzSBl7W9q
 VY/oHe4MuHzmLbZJwL7tPRRZOjloYe8kcZSK0ik3e/89y8ZuQkMoG7XPG/BNWTfqM+UT+iDsjbP
 eTgIZLPk2/sVFtlmdZ6d2Jue3Hz66VtO6FWITZK/2dJA==
X-Google-Smtp-Source: AGHT+IGMm+O54qQ8YkLc8GKlgn46l4V9DtwvqhvkYqkDn5gGTd6PqreWqpVul9LuhT4LF6Baa00yNfM91Jskoshk4XA=
X-Received: by 2002:a17:907:9619:b0:ad8:8efe:31fa with SMTP id
 a640c23a62f3a-ad88efe3d04mr490539866b.58.1748417757481; Wed, 28 May 2025
 00:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250522011749.3498970-1-paulliu@debian.org>
 <20250522011749.3498970-4-paulliu@debian.org>
 <CAFLszTjBDedSGTOLGy4w41+sG2H9yDBCSPcYwUhmWi52myjBoA@mail.gmail.com>
 <CALG-KHwgrP-e1phxqA6GqEtfAZuh3mcF5GiZZsw_NZho+3YL=A@mail.gmail.com>
In-Reply-To: <CALG-KHwgrP-e1phxqA6GqEtfAZuh3mcF5GiZZsw_NZho+3YL=A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 08:35:45 +0100
X-Gm-Features: AX0GCFvHEvFmwJnughYGbL5zoCWjRkl-Qvg-H00N_DUxSpZuyUOgPxGeJRw4p3M
Message-ID: <CAFLszThKrwG1O240xAKTgGGYWh_b3zcF96MZEbjAw0_dubxJSA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] lib: efi_loader: efi_memory.c: add efi_realloc()
 for realloc memory
To: Paul Liu <paul.liu@linaro.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Paul,

On Wed, 28 May 2025 at 01:24, Paul Liu <paul.liu@linaro.org> wrote:
>
>
>
> On Fri, 23 May 2025 at 14:44, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi,
>>
>> On Thu, 22 May 2025 at 03:18, Ying-Chun Liu (PaulLiu)
>> <paulliu@debian.org> wrote:
>> >
>> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>> >
>> > Add efi_realloc() for realloc memory that previously alloc by efi_alloc().
>> >
>> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> > Cc: Peter Robinson <pbrobinson@gmail.com>
>> > ---
>> >  include/efi_loader.h        |  2 ++
>> >  lib/efi_loader/efi_memory.c | 52 +++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 54 insertions(+)
>> >
>> > diff --git a/include/efi_loader.h b/include/efi_loader.h
>> > index d0c72d0bc58..ff7ca5a0480 100644
>> > --- a/include/efi_loader.h
>> > +++ b/include/efi_loader.h
>> > @@ -878,6 +878,8 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
>> >  #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
>> >  /* Allocate boot service data pool memory */
>> >  void *efi_alloc(size_t len);
>> > +/* Reallocate boot service data pool memory */
>> > +void *efi_realloc(void *ptr, size_t len);
>> >  /* Allocate pages on the specified alignment */
>> >  void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
>> >  /* More specific EFI memory allocator, called by EFI payloads */
>> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> > index 0abb1f6159a..4c76df642dc 100644
>> > --- a/lib/efi_loader/efi_memory.c
>> > +++ b/lib/efi_loader/efi_memory.c
>> > @@ -666,6 +666,58 @@ void *efi_alloc(size_t size)
>> >         return buf;
>> >  }
>> >
>> > +/**
>> > + * efi_realloc() - reallocate boot services data pool memory
>> > + *
>> > + * Reallocate memory from pool for a new size and copy the data from old one.
>> > + *
>> > + * @ptr:       pointer to old buffer
>> > + * @size:      number of bytes to allocate
>> > + * Return:     pointer to allocated memory or NULL
>> > + */
>>
>> Should go in header file
>
>
> Hi Simon,
>
> I look into the code. It seems other functions in the same .c file put the comments in the .c file instead of the header file.
> Should I move the comments to the header file? I'm a bit confused.

Normally we use the header file for exported functions and comments.
Sometimes people don't like to convert everything, as I did with [1],
for example. So a middle path is to just make sure you add new
exported functions in the header file.

Regards,
SImon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250524172827.1243975-2-sjg@chromium.org/
