Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA309C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 19:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6BD82C2F;
	Wed, 18 Jun 2025 21:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="btyJDieW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD7882C55; Wed, 18 Jun 2025 21:49:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BAB82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 21:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750276141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJh/HqXcDebEy/om3rmGAUBVQ7pwCi2cM/6awawqf38=;
 b=btyJDieWWnpmJpCP8KrgSAjcMKlirpoA2jDc2V+y7/QIpf/fFsv9WU9XPDN4q0GqXkek7N
 BZltgea0QLVoy/zKKFQ7s7QkSswjVJwNkC8KEQhFmQK7bTc1NHcKW/Y6WuarwYhct7BQRc
 8hiJYDr96SfvI/UiuEk8EwDNU0OIL7g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-GwGXP9tdPBGG9d6nbfTKNg-1; Wed, 18 Jun 2025 15:49:00 -0400
X-MC-Unique: GwGXP9tdPBGG9d6nbfTKNg-1
X-Mimecast-MFC-AGG-ID: GwGXP9tdPBGG9d6nbfTKNg_1750276139
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso26970f8f.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 12:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750276139; x=1750880939;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJh/HqXcDebEy/om3rmGAUBVQ7pwCi2cM/6awawqf38=;
 b=g4pPaGX9MB6nhBtnHeV38XsIJoVrJZAsJu+TaM5NRQYWRdrKk9MfdRL1LZstRhstNc
 FJsi21g+vmi9KFTnu2IKJXt4DUG719gmRf+JKG8DocrvOqm7QLPFuSEfbKIT/T97kFLN
 ai14pJ9cPMBLR1JWTH8uhoowlkVW5vug2Soy0oxrYbeK5d8ZDv12fVqrknvlLkPUMdOx
 z1D+HNw8l8Xx/Ey/RUeYcLhhFWNMl4dLdVkon8r9St2LQrNpfSScuYWrxj56WVTudpAr
 KljE2pfVyF5ozXmnN8yZzuDxtyN24VBqgb+PYhxOv/MBn5WL0nLvHthOFsZcvYxYZT/r
 eGbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYsud8yhlpeL3Lej0ecQDVQqYB5j6U+7IYyVvmD85a8OFuonFo2EAc8SNIGhJZCnquYZnvKT0=@lists.denx.de
X-Gm-Message-State: AOJu0YxbYtmg/s8WkABFIRAybfCGJ8ft0K1jpL9z/5LQ/P8lJxgcfXMx
 qppIxFB3yr2tFAWEwTzmgOxrnh3k6MUIDN6hn3Hq0B08TE2qVXcYrxgH3zFvZm84W9KI06ygv65
 6FJmKGAqI4r5TsurRAfIV7MildDKkPeFb5o1npf+rtxn8obIvQU7eoU4=
X-Gm-Gg: ASbGncsP9AS9XP1HaX81To0yYnCF7ZcdPc5ka6ZVNSiTqmqAWxS4zA5RS6SUbE7AGln
 dqs5zPutEVbcav4CWG61VmMqlaXJBAzmhU0UF+3Gx8yqO8A5U3cuWmNx5kn8TBQhWYZo4TQzNQA
 jnpcK8rqh+1V+1bwz8aq+7p4z2UdGkvAlmGuAyEDdOV7fZFQ0bo/v3P5kkLj0q2M3mSnrpqAHsO
 WOWdBmP7Ui9+NKZr3IBFPDTj3r5vUXjhoDNgYCjeERo4DZnUeCF3ActCebjanIYnPvJ3NtMbzvC
 v5SPPzWE7NpvYg3UjxdmFJSAnPr/H6/aBnQ1D1bTfA+EJgD0z8qQXLYrgFbA9CiYX0cEvE/m1Iw
 rzrEN
X-Received: by 2002:a05:6000:178a:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a572366706mr15314276f8f.8.1750276139292; 
 Wed, 18 Jun 2025 12:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYNUJsm6POUDLuaceMM1kvT1O8VKj0ygnihzwvyVhCVSW/t3Jd5SluVR/XHUyeULrJwaYCwQ==
X-Received: by 2002:a05:6000:178a:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a572366706mr15314259f8f.8.1750276138870; 
 Wed, 18 Jun 2025 12:48:58 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a60f5asm17466060f8f.25.2025.06.18.12.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 12:48:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, mripard@redhat.com,
 alexl@redhat.com, mkorpers@redhat.com, eballetb@redhat.com,
 mskrivan@redhat.com, Alexey Romanov <avromanov@salutedevices.com>, Casey
 Connolly <casey.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Maks Mishin <maks.mishinfz@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2 0/4] efi_loader: add EFI_PARTITION_INFO_PROTOCOL support
In-Reply-To: <CAC_iWjKnLXYUEiJ-B_vxjCaoMpcPazT4HijAsdtA+PCKfCQXKQ@mail.gmail.com>
References: <20250618080056.1973311-1-javierm@redhat.com>
 <20250618145016.GF6521@bill-the-cat>
 <875xgt3x2y.fsf@minerva.mail-host-address-is-not-set>
 <CAC_iWjKnLXYUEiJ-B_vxjCaoMpcPazT4HijAsdtA+PCKfCQXKQ@mail.gmail.com>
Date: Wed, 18 Jun 2025 21:48:57 +0200
Message-ID: <8734bw4yqe.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7d4Gfeww3nZgR3qbkp1ReRD33Ty3HsQIXe7AVhZ_o9I_1750276139
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

Hello Ilias,

> Javier I reviewed the patches but I probably missed something.
>
> I am getting a compilation error with the selftests applied.
> #include <part_efi.h> seems to be missing.
>

Sorry about that. What's the command you are using to build so that I can
replicate the issue. I tested with the following build command:

make qemu-x86_64_defconfig && make -j8

> Thanks
>
> /Ilias
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

