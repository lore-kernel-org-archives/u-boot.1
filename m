Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EEDC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D0988137;
	Tue, 18 Jun 2024 16:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TFIQXtGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B9388204; Tue, 18 Jun 2024 16:16:31 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D930E8812C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57c83100bd6so6765220a12.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718720189; x=1719324989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RKRpLna+c8R4215FuZJCDD5au4BHlAycL6mLGRPfdeo=;
 b=TFIQXtGhhT/YLLP0H1ZGivmP6ZqkVK2Z9JSVv2ae77vv5wp0cVO6L9R7PpU+kuym6w
 CyGumhkL/c+MdURNWDwkrijm8dwdCUlX9rjUZVEQEfGS6NWV9KeTi/PoejJ4xkmINxqi
 D4tAOgO3/Y/GspN5G9SExAXsuKUQHNZaLo5L03Nv1dAFNVCRUTXMwCxBD8CLmSgUayji
 IRMOyBhBJaZT0s1bkk4CBk3KebUOXe87VPVpntF8nOSDcP1xrfxaV8pwuUhV8lPEs2Kx
 XxP8f4ZEpBM7yVFyg4TMlFntvvm+shM1zRhXKBNCEMiIWdRWN4Mv43/KP2mN+BuHrnYx
 zY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720189; x=1719324989;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RKRpLna+c8R4215FuZJCDD5au4BHlAycL6mLGRPfdeo=;
 b=UKVfX9NsWuSMeQx2uUJfZ1AqCw4D1lSIYy/T0xR12sqmCR2RYGHm49kUi/4wV6dRbD
 rVP75RuH9drfCjOFNaDauyrcqB2wi2Hmw99iGsA3w/bN2m5ESSrBsIHFLnhtXLWl3nH+
 XHsoZmXYQuDNJcnZR0wC4ERPlwu5dZx0F5igdkqPOYsosEcUS/9RGleLk37DMHxlANpN
 7Gn30yAT0IMQwFqSQfMBNuecgEj65XVuD+/z2yfGr7n7tJ1laf39/S5Low0gVx5idOx9
 4dLUugDMRDsd0bIXkjiQ1iaSY2p7VbNclRuEghOoifAHymUtB2E3VfYnM11xiTN6+Rtx
 77GQ==
X-Gm-Message-State: AOJu0Ywb55YRXtcxgtUrGfS2W+ArV2mlqvJ2iJxppS+eJ9JvAmOT8mmE
 KhDHYBqEjaRcTz/fyGskXJ3kqsMsCFXnbgvFKXGLYojijY+wRJYd
X-Google-Smtp-Source: AGHT+IEHlptWrwMJFNIP/Ux52qqTNoSMyuoGNggRYRHGxJF9heLUAsJ+r93tBpE0sJv0rFaClWSqTg==
X-Received: by 2002:a50:a402:0:b0:57c:d4e9:4a03 with SMTP id
 4fb4d7f45d1cf-57cd4e94b6emr3681811a12.41.1718720188943; 
 Tue, 18 Jun 2024 07:16:28 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.147.150]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cbc852bf5sm6991950a12.58.2024.06.18.07.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 07:16:28 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:16:28 +0300
From: Svyatoslav <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 =?ISO-8859-1?Q?Jonas_Schw=F6bel?= <jonasschwoebel@yahoo.de>
CC: u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_include=3A_configs=3A_tegr?=
 =?US-ASCII?Q?a-common-post=3A_make_usb_first_boot_target?=
User-Agent: K-9 Mail for Android
In-Reply-To: <D2351R7O6BQT.1TQPPLXS6F5AL@nvidia.com>
References: <20240618120030.41502-1-clamor95@gmail.com>
 <20240618120030.41502-2-clamor95@gmail.com>
 <D2351R7O6BQT.1TQPPLXS6F5AL@nvidia.com>
Message-ID: <634429E0-0747-400D-8457-2BA066B18FE4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



18 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 15:23:09 GM=
T+03:00, Thierry Reding <treding@nvidia=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Tue Jun 18, 2024 at 2:00 PM CEST, Svyatoslav Ryhel wrote:
>> This ensures that the device can boot from a USB device prior to MMC=2E=
 Useful
>> cases are when installing a new OS from USB while MMC still has a worki=
ng OS
>> configuration or if the OS configuration is broken in late boot stages
>> (kernel boots but the system does not start)=2E
>>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  include/configs/tegra-common-post=2Eh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>What's the implication of this if no USB mass storage device is found?
>How does this behave when USB cannot be read or booting from it doesn't
>work?
>
>I vaguely recall that boot order doesn't always proceed, though
>admittedly I haven't tested all of these edge-cases in a long time=2E
>
>Thierry

If no USB mass storage is found bootflow will continue with the next
device in the list (mmc1) with co-responding info that booting from
usb failed=2E I have tested this on lg p895 which has only mmc0 and
with asus transformers which have usb, mmc0 and mmc1 in all
possible configurations=2E I did not have booting issues whatsoever=2E
ATM, transformers use boot order which I have proposed in this
commit=2E

Best regards,
Svyatoslav R=2E
