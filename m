Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5664EC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 13:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B2481FEE;
	Fri,  6 Jun 2025 15:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="A54XCcxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AAC282B0E; Fri,  6 Jun 2025 09:22:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B677582A8D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749194527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tWLZT94yPuz+JF7rNWtnAOp/at8tUuNz2U6Jujlk4Y=;
 b=A54XCcxZEnv2bvSz1sH2bkHskdc8MNRTLgQC9Cf/JNc56EK+ebhr/8g/c5uAyDM+27Iq5e
 HIRNUvhpnik8Rw+kNiRNCozYapnlRWvRu0GyzczFl2tsTpD8liCBvn/7fyN1dYM9FFEgJJ
 rZEkRzpyC7oerD0DkRtzA4RTVFzBH+E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-9YQ7q2grMbe1b6TFqDJ6KQ-1; Fri, 06 Jun 2025 03:22:05 -0400
X-MC-Unique: 9YQ7q2grMbe1b6TFqDJ6KQ-1
X-Mimecast-MFC-AGG-ID: 9YQ7q2grMbe1b6TFqDJ6KQ_1749194525
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so13902915e9.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 00:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194524; x=1749799324;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3tWLZT94yPuz+JF7rNWtnAOp/at8tUuNz2U6Jujlk4Y=;
 b=M67QjMEbplFPNnqgPnrdIwU4ByqtKiIPvyuveKPmBmmYQy/LXR7wGJ2TA3FkxiWy0k
 Sz3HMJoZNwNlXIXjGdIozJZR9Zy3vdshiaKOsuGwwqOD4itE4ojzW/6sTdPTWXxodZNf
 06U7NW2qa5qEknJPuboOrVb1jTeXmGhbCLOf/v86XZsonLGN0UGskHfiRc9XNmxocryB
 mE7lf7Ji03wjgISO4obhKhdIQIZB7LlM28KLsYsO3YH1vw59DnKNh+a9Ec9x75XeH+cS
 KQ5SpZFuHqu6XIlcRHZItFa2nEeGPzozoifKUa04d/p1WLjx/RMQ69wqaqc+XNIRv1zK
 vrlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC0P+XuP7MSUfZl7BpLkguI8eC4hc8ljqwmLSfn0l2cSp6TrsY8AG2XLU3COCRam9aEA+7h7w=@lists.denx.de
X-Gm-Message-State: AOJu0YwDBGx8lg8XPoek1zjuNU08Wte+5r8VEEepFcHFcgnBFzE3bank
 wwlKeknCmB1Q3MpkuqkpxoAC1BiHRGeswiAgkvXab8hJ0ztmIJzMFU0foEXDJkp72OWiaNl/oe/
 8kEDQOMvYYr+MRE+NAvwL01EUlJEUmUzh7ER4UyhAP8XOlJoIcQIn34s=
X-Gm-Gg: ASbGnctce2i/6HhjllgHqk3en5yW3J0SY0sPihDRX5ilxteKuqOy64GYxhtqWb6iecs
 5Kz89l5n2GYYH3N/IA76SgvoF/Y3WV7/V5RZAp9SCxtCNR89cVa7cfyiFnT6t+AxqgwBVQ/unAR
 mHutQRYQcARicOZetfIbvzoqdKKv50/E7/huVqaS6hCmcuWr2lQYZetU8QLDzyYlBXjD3RmjuGX
 ChWEj8+8xyLMy6j/vEB8x9K//BXbzEDVlZ5TI9rMvvhOPOiVtDmsDOVYet/jny+SzKf4KPT5Lt2
 EXOPsIje18GDRHu7ayA=
X-Received: by 2002:a05:600c:8b43:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-45201427c5amr21506635e9.32.1749194524506; 
 Fri, 06 Jun 2025 00:22:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVxH8JdbLaPbirCQTc6nLlUlOtC0bgGBEKBrAVdvEmt2XotbGglHHwYULGmH23KOd6txpbBQ==
X-Received: by 2002:a05:600c:8b43:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-45201427c5amr21506375e9.32.1749194524016; 
 Fri, 06 Jun 2025 00:22:04 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532435fa6sm1037748f8f.48.2025.06.06.00.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 00:22:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v4 3/3] fastboot: integrate block flashing back-end
In-Reply-To: <3d86cf5f-028c-4858-b292-5233b7194c60@linaro.org>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
 <20250522143958.GJ100073@bill-the-cat>
 <b83cfc3a-39e6-4710-a6ac-c24c878052cc@linaro.org>
 <20250605142126.GV1382132@bill-the-cat>
 <3d86cf5f-028c-4858-b292-5233b7194c60@linaro.org>
Date: Fri, 06 Jun 2025 09:22:02 +0200
Message-ID: <877c1ptjvp.fsf@kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _3sWSaPU1Q3L5tuncDz7PBxlsIlCL9jM5GBPDuEuxy0_1749194525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 06 Jun 2025 15:23:41 +0200
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

On jeu., juin 05, 2025 at 19:48, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 05/06/2025 16:21, Tom Rini wrote:
>> On Thu, Jun 05, 2025 at 10:16:54AM +0200, Neil Armstrong wrote:
>>> On 22/05/2025 16:39, Tom Rini wrote:
>>>> On Thu, May 22, 2025 at 02:37:07PM +0200, Neil Armstrong wrote:
>>>>
>>>>> From: Dmitrii Merkurev <dimorinny@google.com>
>>>>>
>>>>> 1. Get partition info/size
>>>>> 2. Erase partition
>>>>> 3. Flash partition
>>>>> 4. BCB
>>>>>
>>>>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>>>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>>    drivers/fastboot/Kconfig      | 29 +++++++++++++++++++++++++++++
>>>>>    drivers/fastboot/Makefile     |  1 +
>>>>>    drivers/fastboot/fb_command.c |  8 ++++++++
>>>>>    drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
>>>>>    drivers/fastboot/fb_getvar.c  |  8 +++++++-
>>>>>    5 files changed, 63 insertions(+), 5 deletions(-)
>>>>
>>>> I know this was posted before I replied with more feedback moments ago.
>>>>
>>>> [snip]
>>>>> @@ -193,6 +197,31 @@ config FASTBOOT_MMC_USER_NAME
>>>>>    	  defined here.
>>>>>    	  The default target name for erasing EMMC_USER is "mmc0".
>>>>> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>>>>> +	string "Define FASTBOOT block interface name"
>>>>> +	depends on FASTBOOT_FLASH_BLOCK
>>>>> +	default ""
>>>>> +	help
>>>>> +	  The fastboot "flash" and "erase" commands support operations
>>>>> +	  on any Block device, this should specify the block device name
>>>>> +	  like ide, scsi, usb, sata, nvme, virtio, blkmap, mtd...
>>>>> +	  The mmc block device type can be used but most of the features
>>>>> +	  available in the FASTBOOT_MMC will be missing.
>>>>> +	  Consider using FASTBOOT_MMC on a MMC block device until all
>>>>> +	  features are migrated.
>>>>
>>>> A default like "" in order to un-stick configs that are now here and
>>>> enabling the option is wrong. If we're enabling new functionality for
>>>> platforms, it needs to be configured correctly. This leads to building
>>>> code on platforms that won't be used on the platform so we've likely
>>>> added run-time bloat for no benefit.
>>>
>>> I agree but what's the solution ? I'll prefer having no default as it was initially.
>> 
>> No defaults is correct here, yes. It's just that the primary
>> dependencies need to be fixed so that platforms don't get stuck on the
>> prompt on features they won't actually use either.
>> 
>> Seeing what boards get stuck, and then having an idea on what
>> dependencies trip them up is tricky. What I usually do in this
>> situation, to see what platform is stuck on the prompt is:
>> - In one terminal, fire off tools/qconfig -sC. Then wait for it to
>>    seemingly be stuck with just one or two platforms left to finish
>>    syncing.
>> - In another terminal, 'ps uxwwww | grep make' to see what the build
>>    directory of one of those stuck platforms is, then manually save off
>>    the .config file, begin investigation.
>> 
>> That should provide what platform is asking this question and not having
>> a reasonable answer. Then it's a matter of seeing if it makes sense for
>> this platform to be here and so just needs to be migrated to this
>> functionality or if it's here because of some dependency problem, for
>> example what I was talking about in the previous part of this series.
>> 
>
> Ok I can't reproduce the crash with the last version, somehow v4 fixed it,
> and the changes I did still work:
> https://source.denx.de/u-boot/custodians/u-boot-ufs/-/pipelines/26523

Hmm, maybe v4 "fixed" it because we have:

default 0 for FASTBOOT_FLASH_BLOCK_DEVICE_ID

If you drop that, do you still not reproduce? (note that we don't care
as much since we agreed upon using "default 0" for device id, but it's
odd that the build issue is no longer there.

>
> Neil

