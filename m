Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8D2CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 23:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBCA384834;
	Sun, 10 May 2026 01:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cs1HuBEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18ED2848BC; Sun, 10 May 2026 01:06:33 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15CC884711
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 01:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so3068569d50.3
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 16:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778367990; cv=none;
 d=google.com; s=arc-20240605;
 b=MAezPiwsVMHkmev+QOllROFc0t3FW6rgzRkMJIebLd9UqC8eonpcvC16I8DXXDNlVu
 8GYEs7C1CXkiXh0uEzT3Of8xGKuspfhHC15hiFfsLYl8kcizo6puSJQCookCPbTi/xMN
 QJGnJ9/7G4GVYFbpOENaLgppGUoNo9SzYOiEOY4AmadmQWQ5ltnjlk1uBlThjc3abJpf
 J3bUehyT/3WJiEI7nnYaDvAA4VKZ/QuxSrn3A/47h9Vvym+5Qmls5M1hJcJKDwxvTW4E
 QtUmNUr61bKTUc/EYPoARcwYw845SHB4ULyZXfGZSJQcyaVcdjK6x96HpefyP+WyVAfS
 pSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oLcujl6tP3WqbBMaaB/wpbRTgrDmyJZ1d1KgENKk5cs=;
 fh=ISiQsfwo8d03NHQXniFCSKIjOUxBA62ngxIVH1Rb/yw=;
 b=R2WiAQz9yu13ht1qE74EcgvsBHvOD4MX55HaqyKPnqqChYhDVCPyk14wv0RZCw+X0g
 ls+tqq60Dg2ujjGyvlG1LEiuIowfbcWUBhwPCRBmn8d1fBi+8VrXhHldISaxW90dpAfs
 BRW3nG7Bggs+GOOBblrOdcRElUg+1I+p5WoKs+ebkb+/J3pm2Txb8gZ8m8rXmLSYgFJL
 NzpG/rPxQ40nEeMW9tLEh0hezZeZF7s2923HwcXHeMHzs5JpTiVIxd8gOlh07NlMQrKh
 6h501ngg9d4BtIH/7uX5WU6F5rjIGpr06sW6X4l5Hguo64l8Hz27ePZ8wDm3GRp+CNZZ
 RK6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778367990; x=1778972790; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLcujl6tP3WqbBMaaB/wpbRTgrDmyJZ1d1KgENKk5cs=;
 b=Cs1HuBEvUuZPHi75J2s7i1vtt2Q7mtGv4PXKczZ7jiPpgdSviFA7jo9ArmNCnnxYL9
 ux5Eg+g65gvEvBJK7kFelCRfVGfwLlAHF/PbWJdkxCqvLRl2ZMueYYXFgO67lp7uNx//
 iRWuAo66HYKiGY+zCYuir4FlpYdAiAWNFsgjc92c2nUc3iHywQve4eAUiNF6wBHVfsVJ
 GdBqMQ1R42D6BZBOuFQda5dgruZAQ3cfKQ5ZeZmmPJ0/UoFiPdq2x0uGlAEUlt6wdkRE
 H0Njd91DeVrMb4xYx9z2svW9asdWbqRb+BVElsUq/DMXMJlDiBIbp2iX5KN6oeJn1CNT
 BeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778367990; x=1778972790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oLcujl6tP3WqbBMaaB/wpbRTgrDmyJZ1d1KgENKk5cs=;
 b=gT04J7N0yXv+nliBYQGFfKp/OLGMFbipreWmcEjXVzxcmMSeBcYhGN9Kfe3juZi/1C
 1kCEEFttNFaG5yUje1UY2RRUZfg83yMEgmX6OFqKIpBN2+IB7lpC8a1NxOYKk1vFBn4/
 aFD4ORqlkjr1ar6Jo4VMc808JSQM4K1ZduQwxsK1uiOGTH0bJowhna3/RrYv6aPycG0o
 doToWcznfWIdy4aimq7Xgb9a3o0oGNXlW0PfzLQAKuh5iLOouU7JSYI01Kn5DwUPXTvs
 nTdgD0AH5+l8aPTF83Q3gmkZzKhQfBvOtkOTQRy3YFCqHlLGSy3C1wWM0MpQeqjA0w2U
 FXIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+h6iwgaU5YP/xMAeftk2IXpg5Vn22KKB18AUi75DIYQxNeQpYZ7JPnSNSubPZjhiExfobMqz0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9gQ2pF3hcyxxwzRwIGi1ywzUbhv63RViVAbiSKK/JanEwhEm+
 CV+t4WHR7M3MqI1l2vt88pwnGxJ310nTxHtuXxwjDfeW9QoU4RlmKdL5YM1H/WUSusCEZKvbah6
 M+ifE95FgDiT7g5rQByuhLrigWhsKZqI=
X-Gm-Gg: Acq92OHin2CSj5tcJUmK1OFxIpsT4AyeSYtEC4P+D4+wRY6GpmvQ2dOJMBTeAPUX9rE
 51OGBynV2kE01egbfhc94ZfZCtBEQZYZy+GSOw3yWR0QRQRaLOjtpA4rR0CSEMVwIWo+8Endtp5
 eg9ks2LhwputX+UGHYYIfadc94ShWOSFOQt5mE3vcJYxrlgLpZzz1HsKdsAnL2gfKdTNt1HdpEu
 6z95lVJDitfxeO2fz2i/aHrv71mAN1G3dy/j04IgcWjiWKaKgXSqwl5UZt4Tg0+hIMlXUASUzv3
 iwi+Vlj3
X-Received: by 2002:a05:690e:d8a:b0:650:1bff:602c with SMTP id
 956f58d0204a3-65da8526b5amr3743639d50.53.1778367989742; Sat, 09 May 2026
 16:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
 <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
In-Reply-To: <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 9 May 2026 16:06:17 -0700
X-Gm-Features: AVHnY4Ih3qG2H7Nb3_nmPC_r5oyUNgAZ2RFJ3TiFcP5lQC9No8ashANMYWM50kg
Message-ID: <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
Subject: Re: v2026.04 crashing on Marvell Armada 3720
To: Ben Schneider <ben@bens.haus>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, May 9, 2026 at 12:03=E2=80=AFAM Ben Schneider <ben@bens.haus> wrote=
:
>
> Hi Quentin, thank you!
>
> On Thursday, May 7th, 2026 at 2:58 AM, Quentin Schulz <quentin.schulz@che=
rry.de> wrote:
> >
> > It'd be super helpful if you can pinpoint which commit between v2026.01
> > and v2026.04 releases is the culprit.
> >
>
> Git bisect led me to 284e1a0 x86: Increase SYS_MALLOC_F_LEN to 0x1000. I'=
m really confused. This board is ARCH_MVEBU--an arm64 device, not x86. I ch=
ecked the good commit twice to be sure. Any idea why this would cause probl=
ems?
>

I believe the SYS_MALLOC_F_LEN for ARCH_MVEBU should be 0x2000 (system
wide default value). Please try that.

But indeed, it's strange that commit 284e1a0 would affect ARCH_MVEBU.

All the best,
Tony
