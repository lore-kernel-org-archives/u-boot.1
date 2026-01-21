Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D63CC44502
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 09:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DC38341A;
	Wed, 21 Jan 2026 10:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EjDz0nsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1BC83A1E; Wed, 21 Jan 2026 10:28:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A71182A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 10:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768987712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HnV6rL8DYxHFmrgS4skvtEThybgK/SXQweAuwgFuImA=;
 b=EjDz0nsEH4Zvp+mHqe9mppw71fRBQHwXXT4xiW4X1wlaaMSdwtnjc5F5KUFzUBPT9YnNrV
 k1fwomP/1DY8550DrkAkB2wFWRj416C+DUP1Ev99v5zjoNIqC6LmCAPE7aijq1BmAAaGgu
 kZ5hYCaoryL4r2D137sls/2qzZe3tY4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-KCzyg5IkOgOidvl06XQJnQ-1; Wed, 21 Jan 2026 04:28:31 -0500
X-MC-Unique: KCzyg5IkOgOidvl06XQJnQ-1
X-Mimecast-MFC-AGG-ID: KCzyg5IkOgOidvl06XQJnQ_1768987711
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47edee0b11cso35726695e9.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 01:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768987710; x=1769592510;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnV6rL8DYxHFmrgS4skvtEThybgK/SXQweAuwgFuImA=;
 b=SsxEsXP/YXZbnbpyUNAN+zgY4+0eT53tRnKWYfp9umQanxBcuV4VJIXFxP0ckIHiwf
 Dv311sO+AySE13Em0GX8RWGDxeVFvC0j1REv7bQkWs6QEwL3VA2oZEbnYT4wD6OGje2i
 zKXOV4xcg5UtXNLPHux4UxB2jTyh8WhLjwySdJYqrY/TWkIX0pFEkh2P8BYNikf+DPRP
 at4qvU8UT+g31HUsMSeV2ixSniEYFlK89hmE3V8HJzeyZa/FT0VGVO3PowhV6FZlzQFK
 MM2pLGfIohYHZ+q9WTZsdxVVm1VoQioCj2sxyGzpLwLXU/iyrRnK8kUW2m5TPBBUdTaz
 QRNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+BCevHHustYLcCTo4zTO7KoSppNqOe48LYNI3b6dbQsRduLcMJDapYU3bfx7yAjxW860Fnrc=@lists.denx.de
X-Gm-Message-State: AOJu0YysXjlXj+sDeLz0JNrawehtE8Ufe884pEdXDudq6UJcpLpHFjJH
 SIO11UCSmJrtblCBg4/xhUqlq+7FOdaif+3ZZpQnWwY7Rv7f7HP8xDE+UpE2Xw7gJdyBA4KjqMr
 +Fp7KCI+rikaSeuRPen2fh9r57KGRkveCk4eyOO2bHE0TPo6a/P+IZLOGoIFRJ7E=
X-Gm-Gg: AZuq6aKJiDAc2nDHqvXembjKVBmXLu489pLA3E47ODKP3+oErj5925FfyLe7n0Ilhb0
 meiMwt4kPpPtldWQyDOKpvs+Kam7oPQgHtM9ze4wW/wWziYDV79xBW3iRBug85ngl8NJ9oJdwGU
 BLj+w3TJ8Ru4KalbXGnmIwwDAKunPEI3+0RZ4Wf3gcxVE/Svt5sGeH20J3n2HCb8Gx/Tk4AJm69
 w+yEHWEsxzqvZ1vSaXLRyBfBwX3h36QSaCGtNBShMphATHpp5mVNs7pQWaWnS3daBJtTlvYQK2k
 KOjqfN+FjLzEOnbJAOx3JfORrulcfkZp59qA6lrhImQHwrVORVPQ1g0/ROMGftPtEkcZAJK+SWh
 KEo6ZCcaKbh644mXqkJNKIeSdjUuCXCh9TTFG7nV2CjGDv+s0xSh6LuafFdsMX35+TENL
X-Received: by 2002:a05:600c:45d1:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-4801eab5602mr221054285e9.5.1768987710187; 
 Wed, 21 Jan 2026 01:28:30 -0800 (PST)
X-Received: by 2002:a05:600c:45d1:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-4801eab5602mr221053875e9.5.1768987709786; 
 Wed, 21 Jan 2026 01:28:29 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c57504sm16024825e9.16.2026.01.21.01.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 01:28:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>, Tien
 Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH 4/5] efi_loader: disk: Extend
 EFI_PARTITION_INFO_PROTOCOL to support MBR
In-Reply-To: <5c6c0fbc-4560-4a88-b52d-97c66341ed30@siemens.com>
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-5-javierm@redhat.com>
 <5c6c0fbc-4560-4a88-b52d-97c66341ed30@siemens.com>
Date: Wed, 21 Jan 2026 10:28:27 +0100
Message-ID: <87zf67e2mc.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -kp2Dc0Ey_IaPaFb-gASaFxC6uzZHbtI9S548Jd2FLk_1768987711
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

Jan Kiszka <jan.kiszka@siemens.com> writes:

Hello Jan,

> On 20.01.26 14:36, Javier Martinez Canillas wrote:
>> The EFI_PARTITION_INFO_PROTOCOL provides detailed information about
>> partitions. The UEFI specification mentions that both GPT and MBR
>> partition schemes are supported, but the U-Boot implementation only
>> supports the former.
>> 
>> This can cause compatibility issues for platforms whose boot ROM only
>> supports MBR. This change adds support for MBR partition tables to
>> the protocol, making U-Boot compatible with systems that require a
>> legacy MBR table.
>
> Normally, this is simple to address via hybrid partition tables. I've
> done that already for two different SoCs (TI AM62 and Altera Cyclone V),
> and this allows to use all the nifty features of the modern GPT without
> upsetting the ROM loaders. Do you have a SoC where this does not work?
>

Yes, I know that could be worked around by using hybrid partition tables
but IMO using that could be fragile.

> That said, adding this feature may still be valuable.
>

Indeed and as mentioned in the commit message it is something supported by
the EFI partition info protocol according to the spec, so it makes sense
for U-boot to also implement support for MBR.

> Jan
>
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

