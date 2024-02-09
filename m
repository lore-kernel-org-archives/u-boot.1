Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E71C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 10:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3D487E52;
	Fri,  9 Feb 2024 11:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k3dKysPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803D287E58; Fri,  9 Feb 2024 11:30:10 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF0DC87E50
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 11:30:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4101eb5a115so6958905e9.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 02:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707474607; x=1708079407;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y6NhDSlO7BZANAcyIK/SGtGVvG0St5xGPmOs1XMYRn0=;
 b=k3dKysPoOUY9mGbYclAI7EfYrufj3AY3PUWO7elhGQXuY7PbjnrcHk3YBLOZ+uImoH
 7+ZRJ/vdOfKQwRpH15doR032MuFA0At+/RGhoO84Q0XoIBpLpXVnvPfY5YxuoNV1UIA3
 60ANc0vATDgyn9kusvgltsP+G5uHeZITuj6qvYh6TUKUEkWOc8R+RBTHy/YRzM39IGGu
 BYkYIC02eR+d15ERPLnxa7Qxj5GsQSWv5J6Bj180F40lOJAHHDcGyqKPYe7/hup7D54j
 F8k7l+5TankqCPCz8UCKyhQ+1dpgE19gH//CgsXzAAskyEmpRx1HY+1NAsLsnzRS2/ej
 3vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707474607; x=1708079407;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y6NhDSlO7BZANAcyIK/SGtGVvG0St5xGPmOs1XMYRn0=;
 b=JHEoSTKoIkOR1+Oyq5JGajZgROWWmnksqlyx0EnZl36xQhx7M2y4l7hD3RTJrh9VzA
 TFTvpEYgslCovxkx1yFFdpk7CqdpCPrdPPxn1omzlxuAT9Yf+eH2gc67ODMvFzcLTAfJ
 tp4bQ/F8ieICpR0pbUwr5ePZtdyYWq4p/uuAJvAKGKwChu6GOjtpAgKimQCtW+86h9sO
 +dfkgg6sVYyD08TtxyKK/kJ1kjpYEz2/zVZuZLracMOuBCQDMSoid5Uz9A5uKtSRyhhe
 ac9cXdHsvi3FOHJ683/8fjnAzxriR3zsSznSWheWWvES7K+25m7CekpLGyLLRAtoLRVT
 wmuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcJbFy2MMulR7mhvVLSsgnMXTY1ZzK3wrKBxbWhJ/LlYnFK7T7ei/Tdd29c3DL/Ywi8pKoIEip35wNVOp7qOwvstKBDg==
X-Gm-Message-State: AOJu0Yx1NGiHQs4wOjj5QN9vqE5QRiM3FfimX+oIWUM5RO7aFFPEYHF1
 6JOBYDNtts95uIaly0XEKX57Mr0UZFyy24P9haUwG/aeQEu3wHVdyEoOuFEw2Xg=
X-Google-Smtp-Source: AGHT+IFMI1ZYeMOHYaXqsAZPgO2y7+pF2OyWQ9FxhbBo1A03hrc9LnYeSNTxvV/YXNYL72hM34Ieqg==
X-Received: by 2002:a05:600c:45c7:b0:410:27e7:f6e with SMTP id
 s7-20020a05600c45c700b0041027e70f6emr904423wmo.39.1707474607266; 
 Fri, 09 Feb 2024 02:30:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUvMfNkrYJAUBwJd3JJO4NkNxJKZmdaWXd3MkPybFZjNX0F5V978udpLUyaE9Irw0khazQmOEVPjI4Aq78S9hKv0lKWRA==
Received: from localhost ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a7bc4d1000000b00410141aa57csm180780wmk.15.2024.02.09.02.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:30:06 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Subject: Re: [AVB/AB] Overhaul plans
In-Reply-To: <CAByghJb633bMqVhQ+zFzU-tR_hM88EFFhr7mXhj6nWDUhHhHYw@mail.gmail.com>
References: <CAByghJb633bMqVhQ+zFzU-tR_hM88EFFhr7mXhj6nWDUhHhHYw@mail.gmail.com>
Date: Fri, 09 Feb 2024 11:30:01 +0100
Message-ID: <87wmre2amu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Igor,

On ven., f=C3=A9vr. 09, 2024 at 11:14, Igor Opaniuk <igor.opaniuk@gmail.com=
> wrote:

> Hi everyone,
>
> I'm currently planning a big overhaul of the current implementation of
> AVB/AB in U-Boot during the 2024 year, which I have barely touched since
> 2019. I used to believe that it was stillborn, but looks like it's
> being actively used
> now by some SoC vendors and Google folks [1][2].

This is great news! I am not aware of any development related to the
above but I'm looking forward to this.

I can't speak for all vendors but I know that TI uses both the AVB and
AB implementation on their AM62x Android solution.

>
> This is what I have in my todo list:
> * Backport latest libavb from AOSP upstream and add support for
>    Verified Boot 1.3.0 version
> * Sync include/android_bootloader_message.h with AOSP upstream
> * Check and backport fixes for AVB in AOSP U-Boot fork if needed [1]
> * Get acquainted with a current state of A/B support in AOSP and
>    backport all needed changes
> * Re-factor libavb, switch to U-Boot existing implementation of
>    rsa/sha256/sha512
> * Add SHA512 implementation that leverage ARMv8 CE
>    (pull it from Linux)
> * Enable hw acceleration of SHA256/SHA512 that supports ARMv8
>    Crypto Extensions to speed up verification process on ARMv8-based boar=
ds.
> * AVB support for NAND storage

I know that this has been send but I don't think Alistair has send any
follow-up on this:
https://patchwork.ozlabs.org/project/uboot/patch/20220926220211.868968-1-ad=
elva@google.com/

>
> If someone is already working on anything from the above list -
> please feel free to reach out to me, so we can avoid duplication of effor=
t.
>
> Any comments/suggestions are welcome! Thanks!

From my understanding, the AOSP version of U-Boot has quite a different
bootflow since it relies on the (out-of-tree) boot_android command [3]

[3] https://android.googlesource.com/platform/external/u-boot/+/refs/heads/=
main/cmd/boot_android.c

Please keep me in the loop with your progress. If you want, you can
reach me on IRC as well (libera: #u-boot, nick: mkorpershoek)

>
> [1] https://android.googlesource.com/platform/external/u-boot
> [2] https://source.android.com/docs/devices/cuttlefish/bootloader-dev
> [3] https://android.googlesource.com/platform/bootable/recovery/+/main/bo=
otloader_message/include/bootloader_message/bootloader_message.h
>
> --
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> http://ua.linkedin.com/in/iopaniuk
