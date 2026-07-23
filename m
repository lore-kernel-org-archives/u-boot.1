Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB37C531D0
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 18:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC07D60AD6;
	Thu, 23 Jul 2026 18:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8gYfSGcvcmZi; Thu, 23 Jul 2026 18:50:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D08D660ACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784832658;
	bh=dGilVmPvuv3UsgK4qb6/mBS8+HrfzSiDepK1RNnLIA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=00mjHLvOpJ8tU1FY5Gyv84dgQzEiCIXVIS9sWHRG3/Vb13esaYeiN64KtzBdUJLjp
	 OVMxwLGxyaIog/XL7hdD+zeGc52JVNSbteYyEEW2gW1j6aKxOYIn/2Ys7AokTi9E1k
	 2lip74z+4feX7Yrb5XtkYHrX8GAaKB1U1jEDT+ZSMb5+P1rKF7n+bCMr9vV2pTdImh
	 K2vDNDMt2ZoXkfI50qG4ZVvuyjIvvQWMp5jDRa1tUoLy7b9pyJPWPvFg70XYxlik1c
	 KN2mygIMN2GjKZQ6YgpuwATqzHGaSaUpBnzBQwz2pTEcUGg2lwZCgxJ2M8nex0MrPd
	 hqhqTnDriIoWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D08D660ACE;
	Thu, 23 Jul 2026 18:50:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B07F42A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0D4460ACE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zY5DPSKLPBu1 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 18:50:56 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 98DC660AC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98DC660AC9
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98DC660AC9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:50:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2213C80398; Thu, 23 Jul 2026 20:50:53 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BDE5800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 20:50:50 +0200 (CEST)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6685001353fso839764d50.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 11:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784832649; cv=none;
 d=google.com; s=arc-20260327;
 b=QFo9DvMaND7J9asNxqGdVxTYtNY8+C344xUcD0Ho3JEXfbeqiuX/nnl428Dqv1qcqS
 c3FieI8Dav3mr42CAmHPmtqk/IMROUV97j4v92Bq3OlZKz4766fA+EG9gCdSjyNA4xBA
 2VJlwuFIovmtudTdiCL2hS6bUtKGN/kZcVQ41Tg/ty+PWm+Eb6TMzzC6AXVNCskTlE9b
 VKr367jvkoI7PgqA6puNAxvvrf+2zmS+1FyGzRWVfP2D+e1RUfkVKMD8fV39Vh/siBcA
 OLtvfxCR1m5kkWpmUC878tfIfLxqEPXrfGZiNKrYL/+dnTZ0uSV4KE1wzFFDHdjb5FSN
 RkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AkZOCQ/lz0cJrQSR5vRmAG6ZarHrYuoiahGhJQ7eWcQ=;
 fh=DG0vC9xYMfPMPCdWMOrewvIZ3JtemwQ6JIsQFuoxmZI=;
 b=K+yEfDqIj+aYaaw/29hVzeEng8FEsXfRbjsYECa5qvaGzimG9DYZ65QYJ6aQ8UC32g
 86+KetxmzVPAieuHD88g1JNEU9QXstT2R/FW8/sMLw95Vm9AGgrQwEsT8C+Z6faP0Noc
 nUfCqHD8TtwRA6wEgzL3KJYBwLn7nYCeByld+TUHTkRNIlai7fmU5181BrUwP4DvYwdL
 4K+xazX4+0hyzRplnumJjLbKD0qhUA2PokpOeSdXwO7pRJvTAAZbDKMXrPxR4XazImHY
 66eKg/G4JC0WrLW+0EY5grdSy5vs5uaQqOkvtFRnJKIOUhov5TFCp4tNybp3qf00+ZGD
 J7cQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832649; x=1785437449;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AkZOCQ/lz0cJrQSR5vRmAG6ZarHrYuoiahGhJQ7eWcQ=;
 b=rM27crhe2sAvumYxjGOgUtJcrNHzxrOVejw2GTxIe4ieBYKkx7lxEzWJfMyYfN2fJ9
 5waFb78sO5kZjZlczc/MD6PGh2CUulSpufRBXsF0ZIsEKC4V0j+YXg9O3dQwbojKApcd
 ogUbVR7EHBqnayYHY0COv806EdaeowpJ5u8v71yiMv7p9Vg70Mnzw49+6ZmU8JDgPEzN
 O8gOWGOGxpRKROrw3fF9SGfGaaEwr4S33C0s/i3WttxK1p/an0AlkPPg1VIi7o4daEJf
 CsA5hccmksYmMI4O4IZyYp11867Z2WEM6LYEMqjUjLWDkwaVQiD3NvZPdnVqe3SYXvZ2
 4MIA==
X-Gm-Message-State: AOJu0Yy9RICBsR5cPYoEm/aD3Ulu/hHxB8uHxEOKqXqk0wNPBLK18MFO
 KSfI9LvlzcXiwBMzZUwkTALp1yKwB1iddPKLycnCXAD9y/WMHtb99WS7AvF3kFNs8D0mPpk7vxe
 Ql16v84zGctN2FTKvn5I5hx0NJQnyjYjaWY/Nuh/Qxw==
X-Gm-Gg: AR+sD12M2+h0U5zaL1k5JJP6iZwgNZhMmaDTMv6P5/4CmWFTk+aCQ/8oYlgPmF/+geW
 DxahR4eR9v4QwY25Rp0Tr27KXsami9Dk7tsA687BpRYmvW+T7wAtYQnXVBOa4slZzJ+RnpjUso/
 klcrpWiZ20g65eL9IhumvFZjz8rEsnQ27vHDSkGBqpR9Ck1XK0cFaCKYRyXe0bDKQCrUyc8SbfM
 smKgZ9wsypp3S6IUcn61HKwGyLEamaXRZMIFV/5Y4WMp4T30Y1r9lnGwFbpBtpuazZ9rbesqn2J
 9yEB5V0vwKVlWMQdoLdJHLL8ujD03yApPIGwhiYY/2o5O5AKqNAsz+vJmJ4q+8LxZfpQuEQWi3T
 twJ/QEjeAKOyNX7WbiMizeOkhq6pEdT9be+Nj8V7g7ULyCsX+HkHCHZK8MFEdA33vHcuHYc167g
 SS8Mrpn5U03lwNzgr9YkwCcP98CgoL51Fp9Y2xyyhzojlJuE25AdsW6xDf989DuvJBIxmiTFjal
 F8k7SXZ2yeyOhTcCtsQjEeU/MEG21ze+ofG424rn4HyiLBOZMdTi0ju0/BIWkf/UN0PbIJtBF5L
 TaHVdqe9xCocfOqdRCwn1+0VllffVxPpBOV95qLHhV5d5FDF0NR4CKfMRk0=
X-Received: by 2002:a53:acdc:0:20b0:667:bd13:2f54 with SMTP id
 956f58d0204a3-668a5006179mr1005615d50.88.1784832648571; Thu, 23 Jul 2026
 11:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
In-Reply-To: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Jul 2026 21:50:11 +0300
X-Gm-Features: AUfX_mxitEsRoGRoE2AY3x4jOxhuxJMx-kCmr_gkkWB-0A17NjOT0vvUsQca8L8
Message-ID: <CAC_iWj+sHzAbQ79Osr2TiX_S=qo_kJPC=QPdqKU+x5BnMHiaRg@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi: Implement EFI Security Architecture protocols
To: Ian Mullins <imullins@redhat.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Enric Balletbo Serra <eballetb@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Udit Kumar <u-kumar1@ti.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784832649; x=1785437449; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AkZOCQ/lz0cJrQSR5vRmAG6ZarHrYuoiahGhJQ7eWcQ=;
 b=luecxtEYfOR3S68Fl3ujC6IeTKgvz4MyDVKIHFEOa4kytSRchwucfB7B1t18JnfFTF
 R3Rt7kFiB8PjdAkU6OR5fqHBA9mEm2EVZr7wi+rG8ZJc2ovYSPp3ag1W/hOcQqhlbdyM
 4wfhv4PgecA1x/rIUHXoSbFpTQ/JICGq8MMyi/abq88N7BnxyiEtz1tSDhzdHrCCCgST
 w1ph2P3YQ5MqY1GjRqaYT9ppUAWto7nMeg1HDmhzz6AnR1oq4lvNEmuqCfC7Teavu2tx
 gzSabB9A3U0Zt8F8ZA3j6pnOeJCvjCRWlZysJxEt81LbYn8/A1yvFd63dM7+K8LoQBaZ
 VOXw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=luecxtEY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ilias.apalodimas@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="luecxtEY"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Ian

Apologies for the late reply.

I am on PTO, I'll have a look next week

Cheers
/Ilias

On Fri, 10 Jul 2026 at 16:24, Ian Mullins <imullins@redhat.com> wrote:

> This series implements the EFI_SECURITY_ARCH_PROTOCOL and
> EFI_SECURITY2_ARCH_PROTOCOL. The primary motivation is to support EFI
> applications like systemd-stub in Unified Kernel Images (UKI) so they
> can temporarily override authentication for embedded payloads.
>
> Note: This work was originally authored by Enric Balletbo i Serra.
> I am submitting it upstream on his behalf with additional testing.
>
> ---
> Testing Performed
>
> I have validated these patches across various secure boot scenarios on
> both physical hardware and emulators to ensure the new overrides work
> without regressing standard secure boot enforcement.
>
> Hardware: Renesas R-Car S4 (EBBR UKI boot)
> - [PASS] Unsigned image, Secure Boot disabled, without patch
>   (Boots)
> - [PASS] Unsigned image, Secure Boot compiled (not enforcing),
>   without patch (Boots)
> - [PASS] Signed image, Secure Boot enforcing, without patch
>   (Fails to boot as expected)
> - [PASS] Signed image, Secure Boot enforcing, with patch
>   (Boots successfully)
> - [PASS] Signed image (wrong keys), Secure Boot enforcing, with patch
>   (Fails to boot as expected)
>
> Emulator: QEMU (qemu UKI boot)
> - [PASS] Unsigned image, Secure Boot disabled, without patch
>   (Boots)
> - [PASS] Unsigned image, Secure Boot enabled, without patch
>   (Boots)
> - [PASS] Signed image, Secure Boot enabled, without patch
>   (Fails to boot as expected)
> - [PASS] Signed image, Secure Boot enabled, with patch
>   (Boots successfully)
>
> Signed-off-by: Ian Mullins <imullins@redhat.com>
>
> ---
> Enric Balletbo i Serra (2):
>       efi_loader: implement EFI Security Architecture protocols
>       efi_selftest: add tests for security architecture protocols
>
>  include/efi_api.h                                  |  30 +++
>  include/efi_loader.h                               |  15 +-
>  lib/efi_loader/Kconfig                             |  11 ++
>  lib/efi_loader/Makefile                            |   1 +
>  lib/efi_loader/efi_boottime.c                      |   3 +-
>  lib/efi_loader/efi_image_loader.c                  |  31 ++-
>  lib/efi_loader/efi_security.c                      |  99 ++++++++++
>  lib/efi_loader/efi_setup.c                         |   7 +
>  lib/efi_selftest/Makefile                          |   1 +
>  lib/efi_selftest/efi_selftest_security_arch.c      | 110 +++++++++++
>  .../py/tests/test_efi_secboot/README.security_arch | 208
> +++++++++++++++++++++
>  .../tests/test_efi_secboot/test_security_arch.py   |  73 ++++++++
>  12 files changed, 580 insertions(+), 9 deletions(-)
> ---
> base-commit: 913fedc816570c07bfc7f9c4046dc2a3a55e4099
> change-id: 20260710-efi_security_protocol-6b9fb0e8da41
>
> Best regards,
> --
> Ian Mullins <imullins@redhat.com>
>
>
