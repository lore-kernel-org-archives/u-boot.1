Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB29C71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 14:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB2B82B0F;
	Mon, 16 Jun 2025 16:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aKCCpGu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47DC48070C; Mon, 16 Jun 2025 16:08:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4638070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 16:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750082932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53isGTbgIlmsoO7OfAQWlmYYFjqI+IcpaJ8ualkcGpg=;
 b=aKCCpGu6QxNLQ5L3A1hYHnDdIT9QtpzishPbgjnPGg8prwoJp+5Ef3o0wJ8Lzm1af2TK3d
 7SQMu7w45uHBGLUfgJhqHJ7u7PRD+Em3s+4r3sTjbp4bT9VTdJvlOeVGy2Y2Hfl7T5YwU/
 SzkSmayWkGH9F+eL4p89zH8L5KxpLtU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-O2AQoLRSP0W-H-qFsj2dKw-1; Mon, 16 Jun 2025 10:08:47 -0400
X-MC-Unique: O2AQoLRSP0W-H-qFsj2dKw-1
X-Mimecast-MFC-AGG-ID: O2AQoLRSP0W-H-qFsj2dKw_1750082926
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b1442e039eeso2793981a12.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 07:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082926; x=1750687726;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53isGTbgIlmsoO7OfAQWlmYYFjqI+IcpaJ8ualkcGpg=;
 b=JjZHcTLKIUt4DwFxHWhlAZr1S5G14wIJApL1RK/HQcCFEq3uvMJsUtyZSog7vsuaoo
 BMZdiKi8zWaGNHyY/RopSnVmcjN/6VGUZ4CPBxRMo7zhcREMaSqG0z7WveoTNIbmcu1D
 OVZMXTWuUG9IeS2pqlbknF38By4F3vOOX4TCo2B8JRTr1Sq2huoa80y/hJbdXpiswJMR
 24ByrGD+WPXRavL5QiGGMjWrMY7xj5XjPB3bNyrUr3EaX37GBE/5dsSqnRqc9eK2jjqm
 y2l49uL849Fmw7QZhjD/yxxUAmZmSVbGZJdUOHSG1fDCbMlmye1rra4Nk93FI8+3nqUN
 Go8g==
X-Gm-Message-State: AOJu0YyebXp4Qp6O0NHUiaP9S4SaKX3uDtHnWysjkhZKCytnw6IKrRf4
 Ukac/+Gb6yFuwO9MUaOO7usFlaCQK1YBEoiPML4GWi0u2VS3grIXwSgHqiB0+q4hk/lzAuhWHKA
 YuhGL5dH8U9D8jaMUF0imwcXRd6Xgs/w9+DoWEHa+Ls09EW1JzIdlmZs=
X-Gm-Gg: ASbGnctEcVsVrgk5CmMChD44Xd6QFfsCvc4VzxU9qZRY7mCnL/p7Pm+YH2nvmr3RQ0r
 6botNVzOhsryolGm/37kUXq4cBeNIPQENdn5kNi2sUrDrUgWNKP9k6yhNzlLV/Ys+Me09PGs/pL
 S+VdrDYYuBbwpCA7G4t6PLnwLHmHMbjizveUktrMtyoVPijI33RnHPU0Cn+NId6uIjjfHXoAkgq
 Z0QShlMtjBecg1KdfYrnxpyxeJjwcKagpcfcMSzDVnajB5w00j6ZkLEs6stdiF9fgKQfX3XsJgP
 4lrcGpQk2kueQ21PX+oRyy5tbXFDjrj/bGejik732ybefLBY2yC2
X-Received: by 2002:a17:90b:3806:b0:313:f6fa:5bb5 with SMTP id
 98e67ed59e1d1-313f6fa5d2bmr14346804a91.18.1750082925760; 
 Mon, 16 Jun 2025 07:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHinJAyxB+zq/UrVrqLwW0bRb9lMNSYo9q1M8Kd5o+X8vNbZjSuMUYIZN1gXAyGRFj1qRsJVw==
X-Received: by 2002:a17:90b:3806:b0:313:f6fa:5bb5 with SMTP id
 98e67ed59e1d1-313f6fa5d2bmr14346766a91.18.1750082925300; 
 Mon, 16 Jun 2025 07:08:45 -0700 (PDT)
Received: from localhost ([195.166.127.210]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365deb4f85sm61587095ad.183.2025.06.16.07.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:08:44 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, mkorpers@redhat.com, mskrivan@redhat.com,
 eballetb@redhat.com, mripard@redhat.com, alexl@redhat.com, Casey Connolly
 <casey.connolly@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] disk: efi: Move logic to get a GPT entry into a
 helper function
In-Reply-To: <5d30ed64-cffc-4db0-8e92-986771e024ca@gmx.de>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-2-javierm@redhat.com>
 <CAC_iWj+YfdT=6nazVJQEuYH_RuWbXNL_FmOL57i35Z4rmOi6Sg@mail.gmail.com>
 <5d30ed64-cffc-4db0-8e92-986771e024ca@gmx.de>
Date: Mon, 16 Jun 2025 16:08:38 +0200
Message-ID: <87o6un7p95.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K_SJZ9aDi-va9AAXnNiRod2X2aEp4P6N6yVDjtSf950_1750082926
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Heinrich Schuchardt <xypron.glpk@gmx.de> writes:

Thanks Ilias and Heinrich for your review / feedback.

> On 16.06.25 15:32, Ilias Apalodimas wrote:
>> On Fri, 13 Jun 2025 at 11:58, Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>>>
>>> Factor out the logic to get the Partition Table Entry (PTE) of a given
>>> partition into a helper function, since it could be used by other code.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>> ---
>>>
>>>   disk/part_efi.c | 67 +++++++++++++++++++++++++++++--------------------
>>>   1 file changed, 40 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/disk/part_efi.c b/disk/part_efi.c
>>> index 932d058c184c..c7d79e253958 100644
>>> --- a/disk/part_efi.c
>>> +++ b/disk/part_efi.c
>>> @@ -216,6 +216,34 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
>>>          return 0;
>>>   }
>>>
>>> +static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
>>> +{
>>> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
>>> +       gpt_entry *gpt_pte = NULL;
>>> +
>>> +       /* "part" argument must be at least 1 */
>>> +       if (part < 1) {
>>> +               log_debug("Invalid Argument(s)\n");
>> 
>> I think this should be a log_err an match the comment above
>
> Screen output during a running EFI application like GRUB should be 
> avoided as output will no longer match the expected cursor positioning 
> for the EFI console.
>
> Please, stick to log_debug().
>

I agree. This allows to have for example flicker-free boot output. But
also, I tried to follow the convention I noticed in this file and AFAICT
most messages printouts were using just log_debug().

> Shell commands like gpt should write a message based on error codes.
>
> Best regards
>
> Heinrich
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

