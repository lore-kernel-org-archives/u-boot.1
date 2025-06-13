Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4F1C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 16:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E5B82D34;
	Fri, 13 Jun 2025 18:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LfnR3p3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B38AB82D39; Fri, 13 Jun 2025 18:52:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4026882CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 18:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749833543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i4wURqT9bmfFsrgf6W2f3+LSvQDYpgWBNU5iGvPwy6Y=;
 b=LfnR3p3lhPrf/6k6segXMVp45+G37VkAUGfYfA6/RpHOee08BzHPWSJBE25ae8IWD39EcE
 98L/w0NwqItryhSCQY9C2LZG60Vx+vfmJd/HbM+T+geBDrxWE0TZF/inKZiwaxZRM7mhyC
 eiydp91/SLjxWq0sJfy4wK3fz3JFRHc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-nQ_0EQcBPOuwxHCPtVfMHg-1; Fri, 13 Jun 2025 12:52:22 -0400
X-MC-Unique: nQ_0EQcBPOuwxHCPtVfMHg-1
X-Mimecast-MFC-AGG-ID: nQ_0EQcBPOuwxHCPtVfMHg_1749833541
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so1526375f8f.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 09:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749833540; x=1750438340;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i4wURqT9bmfFsrgf6W2f3+LSvQDYpgWBNU5iGvPwy6Y=;
 b=h/e43pTQKTeI7jDNF53YrtZqEWPag6tYfpVhFtdXNn9kYW9zZqIUlzSM1aQt5EqA1p
 O11c2xyTxWyn5MDv5G9g+VOPLh23FTzEbmWLuvsAFcIDfCg1i3bhbWRYbZI6kKX/Mahr
 P0pEJpLUbKH+KIJFl63/qXm2TqGmb/ohWUdeAtsihX8+ikTGRCKnsgnkhbaXujUEKHCg
 oydvn+QLJE7582DmBtiw+hMVqb7Wcgqza6uqcyp3NbgiAgnmgO6xFHny68uCctMOJWl/
 TMUSaA/op4vkzZ7UVlq7DWabU5swC3jCX0tVLNyBCrlP38siKZE4u44UoPXenCmPPUxO
 e3Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXayCyzunUmxPqIWvqe4W0h/EpMG/QUoOU0UvAJJu9Jq77UbekJscCWoX1V/2fbc+iONxpweYo=@lists.denx.de
X-Gm-Message-State: AOJu0YxjYpyFkXSgmCFqj9gJIL/ZyBU+tlryfX+j/TnAatsdq6JV/Q0X
 Q7KdmNYE0VUF5hln+3QHT0drORNgk8O2kIaw55NqnNZBJxB4LHauaVTIFWZKrEeqM0Ah+Ar2Of8
 iHkcXG6s9uTOuUvrJ3/YN5klbzp/HnPlPcWwFSnugrK/N3PbE6lxQa7w=
X-Gm-Gg: ASbGncv73bLqLOUCjb6YCrsn6HExmkvAQZ7jYvjqnUOZ2poNUR1hsSaeEZtu32o0+FV
 lxc6NaxzBTs5FQqV9M3U8YhKi68TPN8h5O3SLHr1lr2XJ2CvW/mVA+VDHkURQVciQ0TDnw68BfP
 AXt8T1GR92X53ZJOmVPhJBBCp8hUZ19VcLat8oxexmz8pmxa7+SO6hzHIjDLOLNjiFlx+cJpg2W
 A54gIsh3W6Pe83P4abjL11qcZQSMmeJPmyjeyUl5VoPJSkXZa9xeLqOiyEKjwFpQnAR9qHIqQ6t
 F+Cq1K8mrTlKQgVLwBA17Mx1timc6tndcQTm4AtydMkHw0jF8zzMLsSCE0/8SbPEzUiQTFtRT94
 V/Bti
X-Received: by 2002:a05:6000:18ac:b0:3a4:f6fe:5244 with SMTP id
 ffacd0b85a97d-3a572367b13mr505644f8f.12.1749833539692; 
 Fri, 13 Jun 2025 09:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhdWGrt5n51JOKaXMKzH3v0NAap2ekf4E9hC4Gtu/uOq5ssd9Hf7S4pUH5GuaCpETuD10hxA==
X-Received: by 2002:a05:6000:18ac:b0:3a4:f6fe:5244 with SMTP id
 ffacd0b85a97d-3a572367b13mr505611f8f.12.1749833539281; 
 Fri, 13 Jun 2025 09:52:19 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532dea1c27sm57299365e9.15.2025.06.13.09.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 09:52:18 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/3] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
In-Reply-To: <975875C4-8B41-4228-AF6C-6090DE1B68DE@gmx.de>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-4-javierm@redhat.com>
 <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
 <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
 <975875C4-8B41-4228-AF6C-6090DE1B68DE@gmx.de>
Date: Fri, 13 Jun 2025 18:52:17 +0200
Message-ID: <87frg3vb26.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wyCbn4aksoHtsh8BG0X4lZaSThnu_FI63BaMtM_X9Ho_1749833541
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

> Am 13. Juni 2025 16:54:48 MESZ schrieb Javier Martinez Canillas <javierm@redhat.com>:
>>Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
>>
>>Hello Heinrich,
>>
>>Thanks for your feedback.
>>
>>> Am 13. Juni 2025 10:57:38 MESZ schrieb Javier Martinez Canillas <javierm@redhat.com>:
>>>>The UEFI 2.10 specification mentions that this protocol shall be installed
>>>>along with EFI_BLOCK_IO_PROTOCOL. It provides cached partition information
>>>>for MBR and GPT partition types.
>>>
>>> U-Boot is targeting the EBBR specifcation which defines a subset of UEFI.
>>>
>>
>>Interesting. I knew that the u-boot EFI implementation was to support
>>SystemReady IR (what is now called SystemReady DeviceTree) and EBBR,
>>but I didn't know that meant to only implement what's required by EBBR.
>>
>>I noticed that EFI_PARTITION_INFO_PROTOCOL is not even required by SBBR
>>and only EFI_BLOCK_IO_PROTOCOL is required there just like for EBBR.
>>
>>> Which application needs this protocol?
>>
>>We are experimenting with a new A/B boot protocol and an EFI binary that
>>implements it. It's inspired on what the Android Boot Loader does for its
>>A/B booting too.
>>
>>The project is https://gitlab.com/CentOS/automotive/src/ukiboot and reads
>>UKI (https://uapi-group.org/specifications/specs/unified_kernel_image)
>>images from raw data partitions. Just like ABL reads Android Boot images.
>
> Linaro already implemented A/B EFI Boot in U-Boot. (https://docs.u-boot.org/en/latest/develop/uefi/fwu_updates.html). What are you missing in the existing solution?
>

Maybe I haven't explained myself clearly but we are talking about different
things here. The solution you mention is to support A/B *firmware* updates,
while I was talking about A/B *Linux kernel* updates.

ukiboot already works on platforms that use an edk2 based EFI firmwares,
since these provide the EFI_PARTITION_INFO_PROTOCOL. I just want to make
it work on platforms that use u-boot instead.

> Best regards 
>
> Heinrich
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

