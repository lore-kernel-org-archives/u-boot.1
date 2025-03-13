Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122ABC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 18:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02BCC80F9C;
	Thu, 13 Mar 2025 19:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qW/aLc/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B610B80FF7; Thu, 13 Mar 2025 19:11:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9148080756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 19:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ardb@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7D21D5C630D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 18:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3136C4CEDD
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 18:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741889475;
 bh=YGQo7fPt9SkzkmcG7toi5crkktbRfYgw2d9MxilKUI4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qW/aLc/zpSMNN+yUQMHX0m/tYv4LJBQ9VNMipxyRzHTEjCy7MwkOLR1HQKy02ViEt
 j/PTkH+nVQ3hSH4lmABm1fvPkcArf0U4Og+XQipQtEu3v2koemuqgbXgiC3vGd/On4
 p0iEWYM8r3eDRwFY7JLxgUjRHiH10TV5HN2k6GfcD9YN8RTEXIaKPGFcq5FZt64XI4
 dzYgtc4kiNkD7arGXt52tymJmViCCmmT/663cSrZ3pTU+4lx6e6NJ95fnvKZdP8pPC
 5se8PufAyWvlREvyZgiF31yrceF+OvAvrRhklqc4/RZBBKqeTBZZoip9S+ElWNiahK
 PVdCgzJImBccw==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-54954fa61c8so1173429e87.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVgkEN85MPNB89eI9fnnQQAPnz6AMiSVE8y0dE1G+qCHsLxCYbVZgJgqRDp40X5tsd7TDWWkb8=@lists.denx.de
X-Gm-Message-State: AOJu0YxYp7QQE9lL2qdpfXe3aa9/2pPNIEoX+4wl/gwQh8mvcnjv+EGP
 3STrh97Urbyv6bmqtaal3d/vkm3m72urvft3Nk9ppKLJP4WZFLGCV6FMl3g/E/ej9DKU8Y7ZTnB
 TeI/0Lt/5Ngtlf/5XH5InWktwzYk=
X-Google-Smtp-Source: AGHT+IFmmYlU4edrRTmyAGXQ0nWLkAq8dmYUU2EN5alwvRa1GZoDO8gW6zqrEss4ds/fYzk8WyclKiKiEwi/AmOhElY=
X-Received: by 2002:a05:6512:238b:b0:549:5b54:2c77 with SMTP id
 2adb3069b0e04-549c0a5883cmr387437e87.32.1741889473365; Thu, 13 Mar 2025
 11:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
 <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
 <09712f67-51aa-4db5-bb7b-e1305c08d5f1@gmx.de>
 <i0EZ5kRllpIYtHd8QhvzuyTJDkJ2ZrHvCYibVvyxWKY6H-Z1m94rb8AmxFnzDCkq3qRgpj0B1k9S2ozXIb0wW5opuRORg-jS6tAskSfAihE=@bens.haus>
 <CAC_iWjJKO4Dkbd_x9==Cq=Kb4Cy9S4PQqz7d714U9ErWsdW81A@mail.gmail.com>
 <CAC_iWj+R9VA9vNGM=R-UwJCDJ=t9Wa1A28Om4tAX48MmpnKcxA@mail.gmail.com>
 <si98ZC92YWJExsBQWbCusXzfn_jNmQuszo7DUC1pjA6gx-9vhr2Viu07oL9sdNDBWAYMFKEW_MQyCZqLpLWiU6q90_afofYyie74RiJhFCM=@bens.haus>
In-Reply-To: <si98ZC92YWJExsBQWbCusXzfn_jNmQuszo7DUC1pjA6gx-9vhr2Viu07oL9sdNDBWAYMFKEW_MQyCZqLpLWiU6q90_afofYyie74RiJhFCM=@bens.haus>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Mar 2025 19:11:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH9=4dk94SKy38AQWpSiJZPRMxrZ6dGzo6b1XWiV7Qrdw@mail.gmail.com>
X-Gm-Features: AQ5f1JqlSe_17mHeXWgDSqUm9sY1qSGlbYuORkPUT4YI9UBlXvB_Rb5JEnIkGKg
Message-ID: <CAMj1kXH9=4dk94SKy38AQWpSiJZPRMxrZ6dGzo6b1XWiV7Qrdw@mail.gmail.com>
Subject: Re: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Thu, 13 Mar 2025 at 18:27, Ben Schneider <ben@bens.haus> wrote:
>
> Hi Ilias,
>
> On Thursday, March 13th, 2025 at 2:35 AM, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >
> > Can you apply https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/b04e708c615c15423ffc80d73430bf2d36fb7c21
> > and see if it fixes your problem?
> >
>
> With this patch applied, efi_zboot_entry() appears to proceed to
> __decompress() using target = 0 (first entry on my device), but
> then I get the following messages:
>
> EFI stub: ERROR: EFI decompressor: Out of memory while allocating output buffer
> EFI stub: ERROR: EFI decompressor: Decompression failed
> efi_free_pages: illegal free 0x0, 0x1140
>

Seems like the compression code gets confused by a buffer residing at
memory address 0x0.

Could you try the below please?

--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -75,6 +75,9 @@
        if (align < EFI_ALLOC_ALIGN)
                align = EFI_ALLOC_ALIGN;

+       if (alloc_min == 0)
+               alloc_min = align;
+
        size = round_up(size, EFI_ALLOC_ALIGN);

        /* count the suitable slots in each memory map entry */
