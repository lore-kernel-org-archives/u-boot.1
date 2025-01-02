Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5943E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 14:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C604380196;
	Thu,  2 Jan 2025 15:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=munisense.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=munisense.com header.i=@munisense.com header.b="A16ynL2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F008034E; Thu,  2 Jan 2025 15:07:50 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C0C8007D
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 15:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=munisense.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gijs.peskens@munisense.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso508988066b.3
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 06:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=munisense.com; s=c12e0d22-ac12-44f1-aa93-b49ab5265a0e; t=1735826867;
 x=1736431667; darn=lists.denx.de; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dthfmb+h5Ocfkd7TK3dcyolC8MtjTlMgg3LkbG+gktg=;
 b=A16ynL2+GyMUR6VnItVl7CZSQ6Ji3GxsNF5rObT90kqWpTU5WJ/V+mRv/2yO1OnxzH
 JybN3aDJVQjhPkL6UjsBT3tWOw1vFcruqUcFVbi+quwiF5A6OXbBix2krPHSRJrmMRP7
 ZxzaEyFH5HFBdih7kwmQs3GW3cQ233TWg+Wk7MMRbEG2eSIlyTCJJVi3mgiQ0ZIOJw7Y
 OSHauVQtr2EOMrHjcV3UZDz9pQcQr6VhQR9RY2h7xx+Mgv+JgZ+YXJTbOgMnS3oWHGCG
 w3qW5aBTYTMj0ORfCjN6cjVN5WKC+93kXSzujr0m882AFF4XZQg2Ovio9/bKDQy/RVcK
 BiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735826867; x=1736431667;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dthfmb+h5Ocfkd7TK3dcyolC8MtjTlMgg3LkbG+gktg=;
 b=XEMsfYcPPgDKuksZfCGkBNKhu8SmVCxhuVFgUJJRCRfepWQbZ4wEvCI2iul0BCQaWb
 4Yf15BptsUrT+2mNljkeN9TUvYnXjSNfmgniN2F7Lwbczj72O7eWiZ4k6CKsOskH8+M4
 gSzZtYzQABr+AiVXPxOGWpmEAAC+3tljpBdz96kT7hZz1Rvmcc7P30PiJSQQN4977ZPm
 BvSQKC1VLI4VXNOYmatu3zCvw/PLsr5zSVGk0rkUsmk19k2je5LJuy5mLLYeugHwgJ07
 JGt0kXbKV2LW8ksv1mWKqyvb3W59G15PDPcBVoRHuWTn8ktQhT6LZ3mpNteLUzmo+75v
 CLAw==
X-Gm-Message-State: AOJu0YyrvTzKvaYJyVozJCe0OV+FNj00T6XEN0U8dCOgNEHAoNP7ERKE
 yXwCNysYw3g2CHnQD+Cuvu9Y3YXxgSnpJmbSEMLMVNJyB9KbzI6I/Z0koI7m7Tc=
X-Gm-Gg: ASbGnctngapyZapT55fPVAGc4NJsFjcPNIhRylEtY+7EithzRBTT/vSSIgYDIwhwMEa
 xuTOaCcT2W+WDnho4Wp1N9wWgOb56Ht6WLJD9A+qocKLdlc7AtuLZZ0uWuGGhgYa0LXvxR/mDfh
 rjttvCTSAJxzxUwuaFxlH7ZA+a/yY7sVLkK8z/JpPbloO+ocSAja89Fnlx0XI7WqaLymqvDJYtE
 wW6s6SqN8k44Okrx8kT3ykWkbgco3DH9a003gaMWyhEgfaAdUJ3hl3a7l5FVCTby0nE9IF+R9Wv
 yBl1iNpaQZSblJWHCZOUmsjz/GkVeqqPuJ0jIg==
X-Google-Smtp-Source: AGHT+IFFjDw0drA79uhBvUXUCnkaOdhMvWp1WPfGVuLx8GMEhmLjP5Lb1GimlRJlOdgP/DCZAf/mWg==
X-Received: by 2002:a17:906:dc89:b0:aa6:af4b:7c89 with SMTP id
 a640c23a62f3a-aac3446dd7cmr3634755966b.61.1735826866958; 
 Thu, 02 Jan 2025 06:07:46 -0800 (PST)
Received: from ?IPV6:2a00:1708:3ba6:500:3a2e:f088:8edc:f165?
 ([2a00:1708:3ba6:500:3a2e:f088:8edc:f165])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80701c822sm18374241a12.77.2025.01.02.06.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 06:07:46 -0800 (PST)
Message-ID: <42465da7-7616-4e31-a610-3d127ff1141c@munisense.com>
Date: Thu, 2 Jan 2025 15:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rpi: Compute Module 5 doesn't autoboot without debug UART
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <cd71682e-33c9-4e38-829a-a540a53bacad@munisense.com>
 <CALeDE9P45GvLagdkkC-8FuT5Ee3ZWpMPa4+F_eizoPHFtJFSjA@mail.gmail.com>
Content-Language: en-US
From: Gijs Peskens <gijs.peskens@munisense.com>
In-Reply-To: <CALeDE9P45GvLagdkkC-8FuT5Ee3ZWpMPa4+F_eizoPHFtJFSjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 12/31/24 15:53, Peter Robinson wrote:
>
>
> On Tue, 24 Dec 2024 at 14:00, Gijs Peskens 
> <gijs.peskens@munisense.com> wrote:
>
>     I'm working on getting a compute module working with Yocto using
>     U-Boot
>     as bootloader, which mostly works thanks to previous work to get
>     RPi 5
>     working.
>     However I'm running into a strange issue: if I turn on the CM5
>     without
>     the debug UART (which requires soldering a header onto the CM5)
>     attached, the Pi doesn't boot beyond showing the submarine splash
>     screen, if I boot it with the console attached it autoboots correctly.
>     If I attach the UART after the boot halted and press enter I get a
>     U-Boot console, and giving the boot command boots it normally.
>     And setting bootdelay=-2 in the env allows it to correctly boot.
>
>     Which leads me to believe there is perhaps a spurious input
>     registered
>     by U-Boot which interrupts autobooting.
>
>     Is there a command that allows me to extract why U-Boot didn't
>     continue
>     autobooting?
>
>     And anyone have a hint how this could perhaps be fixed in a more
>     elegant
>     way (allowing interruptable autoboot).
>
>     The hardware I'm testing on is the CM5 devkit, I needed to make small
>     changes to yocto to get it working:
>     https://github.com/agherzan/meta-raspberrypi/pull/1397
>
>
> I don't think this is unique to the CM5, I've seen it on other RPi 
> models, I have a RPi4 8Gb model that exhibits the same behavior, yet 
> other RPi4s I have don't exhibit the behavious. In the case of the 8Gb 
> I have a USB serial TTL on it, it boots if the USB is plugged in, 
> doesn't if not. I have other v4s, both with and without the TTL and 
> they boot fine, I've never been able to get to the bottom of why.
Can you try by setting the bootdelay to -2? That did fix it for me, 
though autoboot is no longer interruptable.

As stated, I suspect my CM5 is generating spurious signals on the debug 
uart when it's not connected. Is there a config option that changes 
autoboot interruption to only happen on a specific key combination? i.e. 
control+c ?
That might fix it sufficiently for me.

Gijs
