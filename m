Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831B7C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 15:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96ECE81760;
	Mon, 16 Jun 2025 17:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vxlyTjzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA5B81E18; Mon, 16 Jun 2025 17:16:05 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0B480E9A
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 17:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e4043c5b7so40146197b3.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750086961; x=1750691761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U8GrwW9JH1lezHOwvSVYUIJ5c149ep8QAI8onRdK7Tg=;
 b=vxlyTjzOOsTg0pgOmEbiNh+NXgUW8mmotT3DZ6JoYQ/kb67gnd56NoiQRFr2dK0anx
 zVWfn6rZsuMOtQyHw37EclC8xBIQSuZd5NVLKzK8ify2DDWdEiwDrmw9tRj8CTHzPVra
 XmF+wu1tmZ3E0N0fRhpwfWKZda1YLWhXTwW74AOEtYaa60yLHankwhfwd/+VNLFfHbLL
 PXS4N1S/O3zbShYp4sl253Fng3lgDMLRPg+NKusYnqsDTi3uQvq69Th7CRoEe4qFg7+W
 G5B+ogZ543QU8ZRcMzS8psbK0yTds1kjZS06khowe2j5j75GLgf6MSQ4V1GrwilMtBOF
 a89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750086961; x=1750691761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U8GrwW9JH1lezHOwvSVYUIJ5c149ep8QAI8onRdK7Tg=;
 b=NQmtzLewjPApMfQCupal/xcW8d32t7Hj0+gw5N776uwc8Wr2KtLEPZSzDuPoUG2jKu
 HpE4PUA/7huhKpiwkNus86QCK6vK6z9e8IqLBuxwMY06mmS1QYJ8FCSZbekLFO+ShS4d
 k8GN5kMUqycBODTtGMUJWpZSfifSXg8vyrnAL5b8AuEdHmWEjXTAUAKxl0UY6PXDHYR8
 kfOsOfkdMXdNDfK+9Q79A2jYqeWR/889MmH2W+J5u133FPIkyfJa3mmZQhfbY6sgLbWD
 LTgAmPDHoez+Wx2iLEBI5UDCPgSmfE1cPcpE8sL2OPHzjEhSOm7KZL90JJB43gQj8Aj8
 qWRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhvGHDAQg9qFi9d2X7hO5ffeUFkgo+ZH3pRK88vWLSGlZLkT7zwFhNLlnTBMkEBGmYeZ5ncL4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu7vDcX/eqpabrHu1aQ8tXK6FEU6uzMuRnI6z761rc2Wb0NM8P
 UIs/IP2Y3kZtxv1DMQEU3R1kYymSruWDxItHCs+qDucRs+LpQDJrGVoQZbH2jsuBp2F+FuWM9L1
 It7pKpP6mV7oidHlrQGRCAq6XS9UzSHQnAztDI+HbxQ==
X-Gm-Gg: ASbGncvXROTlwJ9GgXvspIY5P9BUzNFJakSt0B2qHJ3Iy4C+GALV65DZYVj+rzGcGRk
 91Z2+X1L1Lm1U41k6Vf7jTV9uha/dcvVfa5f2nqWiPfk1QBURGNdzwJn8CJUMu0uyFycZi7aq7G
 vWdFClmwO9+p+uQdHfbMGrsJD8BxHgDElF1gEh6oMaKU72
X-Google-Smtp-Source: AGHT+IGL8E3iYL1akl0P6D2zmsLrxYWvsW+HzcXG3kA7AySQ4GXwehNJ+PB5oatA5jXX5c6Omm4/8p1IGuQw/6Mn0wA=
X-Received: by 2002:a05:690c:60c4:b0:70e:16a3:ce92 with SMTP id
 00721157ae682-7117542ab8emr126115407b3.17.1750086961577; Mon, 16 Jun 2025
 08:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-2-javierm@redhat.com>
 <CAC_iWj+YfdT=6nazVJQEuYH_RuWbXNL_FmOL57i35Z4rmOi6Sg@mail.gmail.com>
 <5d30ed64-cffc-4db0-8e92-986771e024ca@gmx.de>
 <87o6un7p95.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87o6un7p95.fsf@minerva.mail-host-address-is-not-set>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 18:15:24 +0300
X-Gm-Features: AX0GCFsI8bSEK33CXIEvJ7pBG1FUIBCsMGnuIDtZ2AHOtsJAGpbRoR_ClZdsJAw
Message-ID: <CAC_iWj+cqadHgabnWFXXFmzYBpXs+sgbCGHu3eB9dANmcrYfCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] disk: efi: Move logic to get a GPT entry into a
 helper function
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 mkorpers@redhat.com, 
 mskrivan@redhat.com, eballetb@redhat.com, mripard@redhat.com, 
 alexl@redhat.com, Casey Connolly <casey.connolly@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Mon, 16 Jun 2025 at 17:08, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
>
> Thanks Ilias and Heinrich for your review / feedback.
>
> > On 16.06.25 15:32, Ilias Apalodimas wrote:
> >> On Fri, 13 Jun 2025 at 11:58, Javier Martinez Canillas
> >> <javierm@redhat.com> wrote:
> >>>
> >>> Factor out the logic to get the Partition Table Entry (PTE) of a given
> >>> partition into a helper function, since it could be used by other code.
> >>>
> >>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >>> ---
> >>>
> >>>   disk/part_efi.c | 67 +++++++++++++++++++++++++++++--------------------
> >>>   1 file changed, 40 insertions(+), 27 deletions(-)
> >>>
> >>> diff --git a/disk/part_efi.c b/disk/part_efi.c
> >>> index 932d058c184c..c7d79e253958 100644
> >>> --- a/disk/part_efi.c
> >>> +++ b/disk/part_efi.c
> >>> @@ -216,6 +216,34 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
> >>>          return 0;
> >>>   }
> >>>
> >>> +static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
> >>> +{
> >>> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
> >>> +       gpt_entry *gpt_pte = NULL;
> >>> +
> >>> +       /* "part" argument must be at least 1 */
> >>> +       if (part < 1) {
> >>> +               log_debug("Invalid Argument(s)\n");
> >>
> >> I think this should be a log_err an match the comment above
> >
> > Screen output during a running EFI application like GRUB should be
> > avoided as output will no longer match the expected cursor positioning
> > for the EFI console.
> >
> > Please, stick to log_debug().
> >
>
> I agree. This allows to have for example flicker-free boot output. But
> also, I tried to follow the convention I noticed in this file and AFAICT
> most messages printouts were using just log_debug().

Ah yes, Heinrich is right, I forgot that this is going to be plugged
in an EFI protocol

Thanks
/Ilias
>
> > Shell commands like gpt should write a message based on error codes.
> >
> > Best regards
> >
> > Heinrich
> >
>
> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>
