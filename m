Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32628C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70763808AF;
	Fri, 13 Jun 2025 16:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WSjmmcGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A479182C4D; Fri, 13 Jun 2025 16:54:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32065800C1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 16:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749826493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YxPBX4YyHuz6RAPp1R5Ljyhkg1vn223rAyGL1MQ4APw=;
 b=WSjmmcGe50r6bP1k57vw+ICRG8xrvTjgJM66Rb4IzLnD401y8bfOpzbwO5p8ib2DzxyiA5
 XLtuKaiBHZHXCmzvU4C4YimYGwTVR/YaxX6ujih+DH34bQb4NUs37kbUeGh1nfaHjizuaJ
 LdTTy8v/3Mce3tx4bCv+7ysQO4gyyKg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-381dr22iMIeMXRE_xrO3yg-1; Fri, 13 Jun 2025 10:54:52 -0400
X-MC-Unique: 381dr22iMIeMXRE_xrO3yg-1
X-Mimecast-MFC-AGG-ID: 381dr22iMIeMXRE_xrO3yg_1749826491
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so11816695e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749826491; x=1750431291;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxPBX4YyHuz6RAPp1R5Ljyhkg1vn223rAyGL1MQ4APw=;
 b=emXz2kahg7TANN3OGPPeUYI7xp5iN7JCr2klngCfLg3hJDNXcX2ewLFib+EquVC2gQ
 gE3CSwj45zgXj0JYJXcEFrPdlm8ErBkbNQbxF2Avu3qDw5tCmAxHP81VawHupg6aCN0n
 XZr48N4ItTGGmDfMhhINXZOdKPdPaIi2A04qYNRh+9DGTSsTV0Cat3wup8AHARmhFjt4
 2P4rGV6BtcO9V33cowcjqDdN13X2Wdlysf0ceovgeRA4wrDVyqnP0Nfv8uXQ9sTM6rnp
 j8RBvKq/HsoFiFtKFe1YZd2PdodLX2ZmsVo9MO9RbbWYtzb7e4nJGux3NPa7snRGg4rc
 wF2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv1ZUHGzlw6KlbJrCUnOK9Gnk8YWwJ9omXxIeuExxQhJE5QdUg4Nemd4ywaPg8liY/rA1cpd0=@lists.denx.de
X-Gm-Message-State: AOJu0YyP+QWq7IuM1QtthcZz7yfZLKCkhvY8x5fDKwseH2kJw3Rdd+Zz
 BAUJ/oqwbUMYop4+SHKVQfdekD86gFL5irSvt8C8+oxRIB+udcUPubNqRLVchS8IeLJA5ARf8uP
 DyDFrY6ycsNJZAOkFQP9QfjQqz3D1ivAZQLH3rXvgi7Mt7S3ymIIiM0A=
X-Gm-Gg: ASbGncv5b5FRA8OayFDJUorB4fW7qtk78gc6OyAFB689hEOjx+313JUJ6/rLgu7ttSD
 nP2G+Ryqu9Pm5pl7NS0cRwMV+tbUdmbPPWDrGGiWJ5q6bIg3oD2Ri39wegCDyWGVzeHAUz+x2YT
 0QGhziDHoBuosh2pszZmFIvflSWiPyMwQ4NU0NLUltWgSa450vInRADVTLcs6ZqPWNMTMU7pgV/
 5IBCNyBKMHeaHqXn4L3mXlejEhQcDXJjony0KmkOkmqhJw5917pupyL8tccva7oGVnCdHQNOG1L
 aSBvh0w/WKOov2MO5WXSDxEPMWAqMoGqYoXCBLJbvfZh2gCnizfM8kp1mPiOsRH350Cm9m2Aduv
 HQMLE
X-Received: by 2002:a05:600c:4fd6:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-45334ae6432mr38493045e9.16.1749826491208; 
 Fri, 13 Jun 2025 07:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBrlPHRUNQWIJtM4JfFDm9vcyLM0VDqBGP2m0zzHQ9blirr9J3t4WuE0957RXv1ryVzyg+3A==
X-Received: by 2002:a05:600c:4fd6:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-45334ae6432mr38492635e9.16.1749826490755; 
 Fri, 13 Jun 2025 07:54:50 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e254396sm56388705e9.28.2025.06.13.07.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:54:49 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/3] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
In-Reply-To: <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-4-javierm@redhat.com>
 <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
Date: Fri, 13 Jun 2025 16:54:48 +0200
Message-ID: <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CHPH238hgV04Rkc5LFuFhXx38_n456skoacEfs7oLHo_1749826491
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

Hello Heinrich,

Thanks for your feedback.

> Am 13. Juni 2025 10:57:38 MESZ schrieb Javier Martinez Canillas <javierm@redhat.com>:
>>The UEFI 2.10 specification mentions that this protocol shall be installed
>>along with EFI_BLOCK_IO_PROTOCOL. It provides cached partition information
>>for MBR and GPT partition types.
>
> U-Boot is targeting the EBBR specifcation which defines a subset of UEFI.
>

Interesting. I knew that the u-boot EFI implementation was to support
SystemReady IR (what is now called SystemReady DeviceTree) and EBBR,
but I didn't know that meant to only implement what's required by EBBR.

I noticed that EFI_PARTITION_INFO_PROTOCOL is not even required by SBBR
and only EFI_BLOCK_IO_PROTOCOL is required there just like for EBBR.

> Which application needs this protocol?

We are experimenting with a new A/B boot protocol and an EFI binary that
implements it. It's inspired on what the Android Boot Loader does for its
A/B booting too.

The project is https://gitlab.com/CentOS/automotive/src/ukiboot and reads
UKI (https://uapi-group.org/specifications/specs/unified_kernel_image)
images from raw data partitions. Just like ABL reads Android Boot images.

> Are you planning to add it to the EBBR specification?
>

I haven't thought about it before but I also didn't know that u-boot had
this requirement. Probably it should be documented somewhere to make it
more clear? Maybe I didn't look enough but didn't find a doc in the repo.

> Best regards 
>
> Heinrich 
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

