Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19221C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 10:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5656081F30;
	Mon, 21 Apr 2025 12:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WdpOOA7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 784CA81F0D; Mon, 21 Apr 2025 12:01:23 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9E881F44
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 12:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so6387355a12.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745229680; x=1745834480; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bj1WRoyFFv3opfgWBxCPuwaCKis8IQDxyVFYDXsDkvc=;
 b=WdpOOA7zHBlC0bSeEkPJQIfdKIXm02BIn3mi9FtmVBKsYklU9Lr4yA7hMVfBmhDCX/
 jfLaHVuRYtsUM8fyRPZC7hCsN90kozj3rbKEPVEdMnFpLRyHKto81yNU6r1PWgRUhWmI
 47/kyjCZQf+rPp/DM2WpeiEXLTRjMllvQ3YqpOu8SO8GXVNNYdAnZASi8YP1lFmjqPsi
 PZ/QcoSQuKBxHwDMP/q9E91+XI5aXJOGR8/FteA5h8UhjwS5hFtGjqq9Dhx9vG8nlhf1
 lh8fjWlFc0IZt3Gvo9jY/SyMKikgUdf86POXpVBzwIPGOpMcL6iYJXQEMjfZTNn4Dg/O
 eAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745229680; x=1745834480;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bj1WRoyFFv3opfgWBxCPuwaCKis8IQDxyVFYDXsDkvc=;
 b=baDoEwZDnsYMnAcY4Si3XOgIfo5RW4VMk/LFF2gXY4tInD0rmQ1cSRcDQNk2haQU1F
 aSSrCXqVXRu2c4Mmfdd9d+2TLWUaW6xPqaKmGy1pCLun2OQZcSxz6hyuqzGgDMn6Ac/1
 ciX7M1mpRoiJlSrRFFVcj3kBGDp8wjHObEmcthvVzcfcUOmUEFcMJxFOTlkgbKFooNBI
 E70HhGNNOg5zGuCz2DEtoAxOd4lsKdPJWcJqHSOtXEkH5pgtw8SC0EQhr/UhRAkwtpr2
 SJn2UQ7PIv3YQpjt5Z5PiTDhKbTBZ+sALdLkRnyOseW2FU1K9cBvIiXfzkZLjUYe8aRU
 /HSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEQKQsFagn/8f3rpIqkKBBoFIg+WaDet1pV4gWBscKbDaMGQexeKyhXVpfu6Z47p+Qkn7yaWE=@lists.denx.de
X-Gm-Message-State: AOJu0YxCOasAmCRHi6O+4PqczWCh0ea5B0XuyvcctHjX1Sf70OoH9rzA
 tW80ujixLH3tPHxB2ti8LsvXDbfqUltN3k7G3jkK9G79h8CcuEFhyqBOSPsh0yVLDM6wJQ9YIuL
 hxdCWaTQXRpmNuV49FUBg8ZsbF+D19uoF
X-Gm-Gg: ASbGnctYYApzajsAbkR0jEE4DJ+sL+8kMQCOgEB/XdgHsgxakOdRID85u9JCN/C9tH+
 0BdOnTglNha6gcmkW4+RTtrmodNeQYQm795v6NyBXF6HQ4GKjMrH4z0gy5NM0kbM8ss0p0pb8X1
 ZynNwRkbVe5Ehm1tGJvNUyAI3m7yD4H6H8unmnAan9LVl0p2CnXQ==
X-Google-Smtp-Source: AGHT+IGhdIgRteK2S8Rjhkw0V7Cu8o9KRrWiCpQnmpQAJ3XGmutUJkPvTVENkKF88/NmSy2KNMrJ0EQJ5R79obLVWPA=
X-Received: by 2002:a05:6402:50c6:b0:5e0:9959:83cd with SMTP id
 4fb4d7f45d1cf-5f6285d4649mr7070862a12.21.1745229679815; Mon, 21 Apr 2025
 03:01:19 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Apr 2025 11:01:08 +0100
X-Gm-Features: ATxdqUGKxe8cE4Bu-vgGO1eKe5aDFHbq3kmlPHls31wT4itICrcq0CTcrb0hpPI
Message-ID: <CALeDE9MCh+ZT7eZYJwGwn-mWnDFDBE653c+7fHT-gpJnrXgjdw@mail.gmail.com>
Subject: [GIT PULL] rpi: updates for v2025.07
To: tom.rini@konsulko.com, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

The following changes since commit: a08425586799374ccded78eb5fdef6e2235e1ad9

   Merge tag 'tpm-master-14042025'

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2025.07-rc1

for you to fetch changes up to 5f9cff14beb7b16ba799c8f43a7cca11c821929a

Updates for RPi for 2025.07:

- copy over uart clock-frequency in DT
- always set fdt_addr with firmware-provided FDT address
- Set bootm_size to 512MB
- Drop fdt_high and initrd_high
- Update environment to support booti and large initrd
