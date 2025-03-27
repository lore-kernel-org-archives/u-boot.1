Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AABAC36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 13:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD3081B42;
	Thu, 27 Mar 2025 14:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SFLXuYR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 334CD81B4B; Thu, 27 Mar 2025 14:46:25 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8DC781273
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 14:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so547561f8f.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743083182; x=1743687982;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=S9jENNee9txmVirSMPxaV+q8jpNfHyrTSUbHI/B/PvE=;
 b=SFLXuYR5T1CjEymt/W3R0hfW2k200p9CbyaHdMopD1K+UKZ/FyGToMhANZf2YTEKkw
 H7bL2TrJWG5juV4uyuLte64TklAKpNw2dSYVz1zKQOrLw/+WEeafhFEp1Wlgv9WiPPCE
 CKL6sT//6OCO+8Dwt5wxoren9OUHE5B9nSBEcUy/B0tDfdfBklQe6vbRd+W2MFCRy31/
 PcBd7ru+37mzJzy4y1afTAVFkeio5c6L/T2/i2KywMxE/i5J5VXnJsQfyIzz88IskARC
 dsxB/9xpIuifXiFUcjH8y+JdYF1tPsHPfJYcqm76NXgOU0aUakMjIdzx5nO6Rn0Hwv41
 wR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743083182; x=1743687982;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S9jENNee9txmVirSMPxaV+q8jpNfHyrTSUbHI/B/PvE=;
 b=ILb6fqTFG6qSMIdQFNQGcXUVli2dZl8N1DrGiZ1cDKYxOcy8lOyroa/476R8rWMtnl
 oC0PAZacR5cag03KQixLmf8DUmVQhWryPlMt7PuZs/XsIR18GGQOqOsNIfTI/JNinAZ8
 aAwT3JsIS13CIM3k+Dn+O3K8gKartRJLiBM8DwNBUK+S73zA8tQlLzA6uJbfxpasgc9u
 HVI1B8XMDnV49ASyXhZtaG3Wzjt3i8qtoOCHa2Nxn8gpxcyajP2c0UL9gVWn3Jbhuhi9
 3dXMKBoqXkYsbS1kdXDptNtQyyeO+XeZho05KkC+JHgom4VJi7T0hNq+87Jko/P/57oR
 W/yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz4DQtXg+puHmljmvuOodt842InCc5M7IWDFHrkdnao9qdUMPyW/eP/LvIFuzkCS4F57GoJ9o=@lists.denx.de
X-Gm-Message-State: AOJu0YxJFIQ6cvJ//cWc4ng9fCtp7gh/uKUs3zbH3Ad0H4vUMA78TqLV
 kpCGRZ26BcmXXEsd2IrQ7RCwbE/y1hQzhCh6ld+S81lwzeKW6cquPl7UoFaO1VF09upJgCRUoc9
 z
X-Gm-Gg: ASbGncvQIiMvv93jEQePZN0DzuqxyKsBjk/nMjhnyHNkuR20EfmYnutqCXvQpUUA9Dx
 xRvVRONNaTCiEWa2yAdnrgPgcfjdZPztx8r41TCKMWvbEBDF4d3TwMNbeZjQrxGdS5b+noIJS36
 fmF9IRdON6MeKgw40qa/6fJQ82Fy73EIs4sJ2Kvcu2UsZNjBXtJ3FAkeDfLmIZchtzDihIW+jIe
 KvvDFMTT2503YxozodSxLd51JGwHn7GLTIJOSdZllHPv0rkif+dFTw81dWDRcWUF3GhNF1oXj8/
 IgLNa9FvYX9QFjtH8evMUFBjsG11+CNLYpotc720bwTDIwxr
X-Google-Smtp-Source: AGHT+IFdB8qWgfxxv7JJ4Ny7Z/qLhPwYjqHQQ5MH3x6WeLAbzkVub3PVx3489urqzLzeu3t+/6b/Sg==
X-Received: by 2002:a05:6000:2ca:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-39ad1770526mr3573242f8f.40.1743083181787; 
 Thu, 27 Mar 2025 06:46:21 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65e0sm20353034f8f.61.2025.03.27.06.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 06:46:20 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: usb:composite: data abort on second ums launch
In-Reply-To: <87sen2pbsl.fsf@baylibre.com>
References: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
 <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de>
 <87v7rypcoy.fsf@baylibre.com>
 <CA+GyqeaFbV3BM-1YFW4iJ3nYSL5jXfRS+_Gg7AEUg9d1yxjSjA@mail.gmail.com>
 <87sen2pbsl.fsf@baylibre.com>
Date: Thu, 27 Mar 2025 14:46:19 +0100
Message-ID: <8734eya8no.fsf@baylibre.com>
MIME-Version: 1.0
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

Hi Zixun, Marek,

On lun., mars 24, 2025 at 18:40, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Zixun,
>
> On lun., mars 24, 2025 at 18:33, Zixun LI <admin@hifiphile.com> wrote:
>
> resetting ...

[...]

>
>>
>> Each time when ums is called 2*FSG_BUFLEN, 256kB buffer is allocated
>> and it seems not
>> freed as fsg_common_release() is not called.

There are quite a few things that are wrong in
drivers/usb/gadget/f_mass_storage.c

1. The "Synchronous Abort" exception happens because we call
   kfree(common->luns); and common->luns is not allocated via
   malloc/kmalloc.

2. We use a kref member that's unused and can be removed

3. There is a memory leak (as reported by Zixun) when unbind() is
   called. We should call fsg_common_release().

I will send a series to fix this.

Zixun, thanks again for reporting this and helping me reproduce!

Mattijs

>>
>> Zixun
