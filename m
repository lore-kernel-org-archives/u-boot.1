Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1EAC4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E718684E19;
	Fri, 17 Jul 2026 15:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FdfgLe9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3044384E14; Fri, 17 Jul 2026 15:44:04 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2522684DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-698562f10e7so11093595a12.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295841; cv=none;
 d=google.com; s=arc-20260327;
 b=Aepkv40XnCOFKVL4h3qRrBZLAq9edi9hM9jkSZZgKKx3GLojQZzKd3pq/r4hEW05xL
 f0YqabE2ZvjGHKjKCAIBXJVRSqXJ4uXR4IwXeNu8C/w/aYT+k3mh0HaO8fFgt85EzJ7S
 7AIrJolW8sQUCQ+AtfnCeGi664cQLcYXnPYMSqpoip8E2/p5astY6ucrb21UG+mD6Yy2
 TZnquf5c7baVbUrLw8HRHiGY7uKWm515u9sZJ0Vtx2BzCLZkkcHI0awsBIE7Yz6d+i41
 VzuWEzUK88Uk7h9sEQD8QzAZCGKbKkH9U7iwgvAFce9YqTAfxTsHa2F3Z/pI7gh8MB+k
 lHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5znpbXX65fPKYFBAdhSghHHU6iZDoJZDz4maRQHJiPs=;
 fh=qHa850ovVjAtfVU23qe5yJqKRNIxbDpMobE0SARZN/g=;
 b=Ezn+lfbpY95qBm1oQKtdIcR/643HSiCtJiDYpkK1WaGDyGOki88ZwUYzRtPvr/fygE
 AExK9oMO2fHNA9r7Cu8NtAARRmxZAJnF732DiPblMkkCqZ6s6Oc/zdXU6RLgMioGfvnG
 XKGL/rILpqHcvp2RvFO0+fmgIZR5o76ZSB1dRLPfucXqkzLkVXXC6DI6bq2gm0m8XP9Y
 ZlaFhhCYj0ji4hrCYqbigH7esIWOUK1X4RLoSUZXDu267V56164RTYjblUqIQXKtxxsk
 TPP70TUf25i2g8mlJCIKyNhfTIItk25W0+YFTZm++m2mgwKkFyvdpge6bHEk9PVXdrMV
 wxgQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784295841; x=1784900641; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5znpbXX65fPKYFBAdhSghHHU6iZDoJZDz4maRQHJiPs=;
 b=FdfgLe9jB0+HojvYuaWeyLqv55w4ffeRDK/z8ohzsMn7WReON/nkVNsw0MpdZUIrjw
 YeOFdXxMhfxJVSyCXkoLMkLO1S/5aSLPH2DMK4dCH6frNjp2VyG/QAdjNXqzTI9qiIcJ
 WkUTJtcl3yG7XU9YB8hSL/Fp1VV6vECD86xQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295841; x=1784900641;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5znpbXX65fPKYFBAdhSghHHU6iZDoJZDz4maRQHJiPs=;
 b=Vf7B84AVZ/Z4O4AOrnPV4KJA/XtGu+zlkB4zGXRFhDMDuyrzttbWTH92TgbQWtQcD/
 JQt1IEwa4v/3Fz0jkCdwtD+wiLn6rZxgUg0UtYkXrrmGnqXPQLdAxYAyFa3HTevfbc8P
 EiZomM4IA2FLLDtoYzRfDMy8SqRdEB2vXYg3UqX7BtgSVRG5kKM8ZScZ0K1xoYH5qBFr
 zw05SQ5kowUw7JTBcZE/b4jrM55zMUxamduvDzGsUvuplvThJOVYbYcbbzVmpJvf2KnJ
 PZblk3CA89OseSRDmlWy1LBy7qENq5oiSRLPXEvcapGJZRL1GlMTiYQ9bgK273DIfys/
 FUSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RokYFzQqb28zsaJYI33YWT3Rik4cltVKFuSideuWgO21PxdFDmXp/DSXl7oDap03C0FQZ/TNNc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2h7yVptHbsu/cZ1yHTJcL98Sn6DShgKi6eFvrwTCI+NnoPq9E
 Fwhkf92QWncohWoo+uwydTe2p+ykoBa6wDbtbi1E5/+AP0TDRU/rkOkdY8ykbRdnJiTwSRNfAhb
 F7rX2/b5pIuF5u/3EDxw7LRvWmJIaRz4ezP15Lly4aGkjmZGiyhg=
X-Gm-Gg: AfdE7cmG7QrgIZjvwSEJFLpUb32yx54T4Ipqrhh0rSOGv5FQKZDWW2/Os4hNaIC8rW2
 nc7tOYbGYokwaP/1wiVPZ8zP3eCIbcJJqnSz79sOjmqaFfT5NneqQIs7ZNXk5rRy4RcYY1FqaCS
 c4yz4c2eYbTEfJS0R1q/zRI+wbELSwg5g2RH3s4eJiKB+M0i92lHrTxM76sknLOtQPjw8W97qZk
 nxnYycrcQpb9Ic4xcak1ieDtuija4cjPxUy4M8U5uNJUa3pbXGRos5fJRgI
X-Received: by 2002:a05:6402:a0c4:b0:69c:769d:6edd with SMTP id
 4fb4d7f45d1cf-69e6527205bmr922366a12.11.1784295841051; Fri, 17 Jul 2026
 06:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-2-jonas@kwiboo.se>
In-Reply-To: <20260711160808.2022242-2-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:43:45 -0600
X-Gm-Features: AUfX_mwMPIaqLAGmU_lEOKBDjljpHEFbBcdl8ho0nEmCC9R-MMpbkXbmy0iXZv8
Message-ID: <CAFLszTjfMdC31xK3t8-QtrGgzkPgAwZpcA+xD34uYuWfnucxKQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] usb: Import USB_DEVICE_VER() macro from Linux
To: jonas@kwiboo.se
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On 2026-07-11T16:07:58, Jonas Karlman <jonas@kwiboo.se> wrote:
> usb: Import USB_DEVICE_VER() macro from Linux
>
> Import the USB_DEVICE_VER() macro from Linux to make it less verbose to
> describe a specific USB device with a version range.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> include/usb.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
