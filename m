Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68E7EEA860
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D9F83015;
	Fri, 13 Feb 2026 10:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QnR0+cuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE39183936; Fri, 13 Feb 2026 10:52:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5155B80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770976371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WjM0E3YKwjPBRGUdo71AE7iV11idlP0W1b/vtXjAGmQ=;
 b=QnR0+cuBXIVDIl0dUpnS2iAnBcARR3a9CIntSpkC5q2ayXL9YnH4dWqtxA0ISkpZ9IN4Al
 5UzMyCG89ktHwnKvON088IrUCoQRGPe74Wq9v/M5wl0nUsyO8Ge3B1ufrAkChQlkxZP4lZ
 Vdml4L0GNYcnWLfs/HMhjv9s+t3LYW4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-VvmdEl8DONCKh_xUmojA9A-1; Fri, 13 Feb 2026 04:52:50 -0500
X-MC-Unique: VvmdEl8DONCKh_xUmojA9A-1
X-Mimecast-MFC-AGG-ID: VvmdEl8DONCKh_xUmojA9A_1770976369
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435aadfaf4eso459128f8f.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770976369; x=1771581169;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WjM0E3YKwjPBRGUdo71AE7iV11idlP0W1b/vtXjAGmQ=;
 b=iatsC4dvJbt2Gvgn/awYgKGNrDqCUTH7JRdsseyGwpaLQr8Lx9c6PJauQHDB0+1Wnl
 a5lIJhZt1DBrccPgjvQKR6b737/XUu1QEli9VAd9prygLtoNQPLNXWacKyCin9kBPzkg
 uH/npl96QHgK6BxCAXKaYkPYy7uaPDXIi+slHjIqe0ZH0eZN3uAK2z3tRiJEjgqz4YZI
 N+48D5z5iKngUMGfPXzmZl+y0f8xoaPO5bTbYK/LjJ/relXI9eBAJ+M09Cf/N0hbY0NW
 CP8xaRYGCbJP60equsb5qBXjavrVUUKqJBGV/qZH5EzV7h8JLfzlIxfgvQkS5K5KtiFG
 zQnA==
X-Gm-Message-State: AOJu0YzSTvP4R24UfvE0AzWeULnG3tHJizLDh48TB0fa6s1SoVckU/9o
 O+BV4gQ12xydyXiodCMPAY0ZfagMYdElfRsCTVdOdV25mNsR+G1N2EzSTsi3cLgOY5WNAfmPEo9
 W2dt4P7080QXY1XWOg8Mlc1ZqdZxuXDISoLV2+7wb7vCgG41AYKIYRxI=
X-Gm-Gg: AZuq6aJE4VBKCKM7u3LPZ8yKyiG1bVUx9WRjphPfyPx0d1szG+NofT322M1s4jrp1wp
 v08rJqLgfKKLBd+y42u63zKhZY24NbYGgfZNiB6+Q2zZA/5wyqBlcJbsokaCHU6GqaaAFbrvzvk
 4cu6H/kvuVQoqKWwwcs1YrVqeIeDsBNXsk7MPSx+Q9D3ZMupqcMFTbpd89SjWtaYLBPtKR7Dgrm
 wdD98DXnO2mqiqh+7hl3PiyJgG1wytLT6bAVyKOJ9/RCcm6QR1IJ/A/cvMrYWkwp0tpNdOObuxa
 vz+z4aRigKQQP0VwYAa6pI7YBLVmSH1+lm+/Cw677kwZdXRL8ZYPi5d3DDQxoVx80qXK+/yz5VC
 CJJHAWz5VCzLBUTqyhRKEcSIT++mHAButcBvUEO4J3WQJP6eXUH7TasoTFieSPHl8N8qmM5aZhU
 w+u/g7
X-Received: by 2002:a05:6000:22ca:b0:437:7050:b5bb with SMTP id
 ffacd0b85a97d-437978cd852mr2405665f8f.14.1770976369336; 
 Fri, 13 Feb 2026 01:52:49 -0800 (PST)
X-Received: by 2002:a05:6000:22ca:b0:437:7050:b5bb with SMTP id
 ffacd0b85a97d-437978cd852mr2405630f8f.14.1770976368868; 
 Fri, 13 Feb 2026 01:52:48 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6c1b4sm3941420f8f.14.2026.02.13.01.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 01:52:48 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/7] disk: part_dos: Align dos_partition_t with
 struct partition
In-Reply-To: <CAC_iWjJysPTkCTJ10qR8FmNxSBYT6mK7YWoqvxxwez+6H8Yf1w@mail.gmail.com>
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-3-javierm@redhat.com>
 <CAC_iWjJysPTkCTJ10qR8FmNxSBYT6mK7YWoqvxxwez+6H8Yf1w@mail.gmail.com>
Date: Fri, 13 Feb 2026 10:52:47 +0100
Message-ID: <87ldgx6kcw.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YBocqedTF0UwTVRP_VZzS2fVKil_uF9HmRbZuf8f0Ek_1770976369
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

Hello Ilias,

> Hi Javier
>
> [...]
>
>>         unsigned char end_head;         /* end head                             */
>>         unsigned char end_sector;       /* end sector                           */
>>         unsigned char end_cyl;          /* end cylinder                         */
>> -       unsigned char start4[4];        /* starting sector counting from 0      */
>> -       unsigned char size4[4];         /* nr of sectors in partition           */
>> -} dos_partition_t;
>> +       __le32 start_sect;              /* starting sector counting from 0      */
>> +       __le32 nr_sects;                /* nr of sectors in partition           */
>> +} __packed dos_partition_t;
>
> This always has to be packed and the part_dos.h definition had this
> wrong all along?
>

I wondered exactly the same when working on these patches and did a bit
of code archaeology, so I'm glad that you asked!

It wasn't wrong because it was using unsigned char arrays for the start
and number of sectors struct fields, instead of __le32 types.

Given the alignment of a char array is 1-byte (and all the other fields
are unsigned chars), the structure was naturally aligned.

But I agree that using __le32 and __packed is preferred, and in fact is
how Linux defines this data structure in include/linux/msdos_partition.h:

struct msdos_partition {
        u8 boot_ind;            /* 0x80 - active */
        u8 head;                /* starting head */
        u8 sector;              /* starting sector */
        u8 cyl;                 /* starting cylinder */
        u8 sys_ind;             /* What partition type */
        u8 end_head;            /* end head */
        u8 end_sector;          /* end sector */
        u8 end_cyl;             /* end cylinder */
        __le32 start_sect;      /* starting sector counting from 0 */
        __le32 nr_sects;        /* nr of sectors in partition */
} __packed;

The struct_partition in disk/part_efi.c is said to be taken from Linux's
linux/include/genhd.h, which was the old location before commit 1442f76d4317b
("1442f76d4317 block: move struct partition out of genhd.h").

My guess is that the old data structure defined in part_dos.h was copied from
Linux, and that at the time of the copy it was using unsigned char arrays too.

But the struct definition has been like this since the original Linux git
import, so I couldn't check if my guess was correct.

In any case, now this single data structure definition is aligned with how
both  the Linux kernel and edk2 define it.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

