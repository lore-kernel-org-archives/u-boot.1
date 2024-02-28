Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC419C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 19:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD95B87F95;
	Wed, 28 Feb 2024 20:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T9PLvSi/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D096A87E78; Wed, 28 Feb 2024 20:11:57 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA61987F95
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 20:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2D0F03F6B0
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709147514;
 bh=ua5Qp0etmOt0504qT5LfoPeKQpVzsyxVTtW7zJizNDY=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=T9PLvSi/PHz86/xbSYGbuwM+IUZ925OHoQIzRuA5zWmBLUC3jZeFVslhdx15gDieM
 aGT4ze3Qrb62qTck6f7LjVim5G7WPH8QLIeLxEyVT5wJxYTHisBtrBvKYnaM4pz7HT
 64MRnIjk73ub7PeBB5b4M13LkM2IIDGrveo6rcsY9h6ScSf3ZeXQLgd70YEpaPapXZ
 h0Cb5YX2H+0ycGr2JFfqFszjsIkeILSakOPtf6YUkXjKor19l18WLEo3yau5ufa/Ne
 eZQTtAogp6aHCufocX34JQSE/+hNuDK/pcgg4aHnFhHZGRoI12QWV0u8dzkT0LFRJd
 SMXrGXwCPfdbQ==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a35ef7abe08so8673566b.2
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709147514; x=1709752314;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ua5Qp0etmOt0504qT5LfoPeKQpVzsyxVTtW7zJizNDY=;
 b=Fpmvfz2OyH9k4bQwWhPCKciJ9Pb8Ws+ADNR1/bnnMrEMno3cIKn/mfLwBMMP/Rl9DS
 SD/j9NT2sLZOhTJD96Qi962QbzVuuqtIysCN1RvviVIOE/rCKmJ87nAP67UnHfScskGE
 +hWT5l7Mt7NuF2aTRNRc1G+I0xRPMh1YZ1n7TQHmq7CruOrlk+wF7g8WkzYtyGf1gJQM
 4JW4Ir2GwOZG/v4HB6WxdfNwjmeLMJ1F1gZfpTI0DxxjiFuIJUaO5VERpVLesKzIfzP0
 nK7CePt57nkfcahJ6gTiQV8WXi/17eDSpfSwkad4xpbNO1pvSJ3AVcqhw0egPDiy19af
 m5OA==
X-Gm-Message-State: AOJu0YyvAAixfcR/b2kVU4UjLi1fsYvVuSI6zDeZaBdy4Xr0i3HUEcqI
 f+xSuOYyzG3fJbyMsN9kFoww7SOCjlbhT7k1H1sHHi0x0ADKC5/i1Fs2/jCWzrpwEay5QLQzcRI
 MN54Ct+npqx591CIUzMimDtz+nbmnIe7Dg2b7p0DR2SpVkpNA4GKbFz2jl1Krya0VA1M=
X-Received: by 2002:a17:906:f249:b0:a44:fd7:3850 with SMTP id
 gy9-20020a170906f24900b00a440fd73850mr448495ejb.66.1709147513848; 
 Wed, 28 Feb 2024 11:11:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTqdTCQVwRMeyksV6y6txoA9srkLrRt42NmkT6qxoI0M0OkhXp4m+p/EX4f4NKSO/41ykAYQ==
X-Received: by 2002:a17:906:f249:b0:a44:fd7:3850 with SMTP id
 gy9-20020a170906f24900b00a440fd73850mr448483ejb.66.1709147513516; 
 Wed, 28 Feb 2024 11:11:53 -0800 (PST)
Received: from ?IPV6:2a00:20:10:8f6:59d8:16c:6bf7:73e4?
 ([2a00:20:10:8f6:59d8:16c:6bf7:73e4])
 by smtp.gmail.com with ESMTPSA id
 ty17-20020a170907c71100b00a43e5f4750dsm1220664ejc.23.2024.02.28.11.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 11:11:53 -0800 (PST)
Message-ID: <476bc3dc-ac10-4915-a598-5e61280d862a@canonical.com>
Date: Wed, 28 Feb 2024 20:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [NEXT] Pull request efi-next-2024-02-28
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Dear Tom,

The following changes for the *next* branch since commit 
d49fa3defa50c6d3f04acbb52fd486c13c14ab6a:

   Prepare v2024.04-rc3 (2024-02-26 21:23:36 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/efi-next-2024-02-28

for you to fetch changes up to 97da9aea78ab71e92778649bf9d1071f30e260f0:

   arm: separate .data and .text sections of EFI binaries (2024-02-28 
14:39:27 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19761

----------------------------------------------------------------
Pull request efi-next-2024-02-28

* set IMAGE_DLLCHARACTERISTICS_NX_COMPAT in EFI binaries
* provide SBI based runtime system reset
* page align EFI binary section on ARMv7
* separate .data and .text sections of EFI binaries on ARMv7

----------------------------------------------------------------
Heinrich Schuchardt (4):
       efi_loader: set IMAGE_DLLCHARACTERISTICS_NX_COMPAT
       efi_driver: provide SBI based runtime system reset
       arm: page align EFI binary section
       arm: separate .data and .text sections of EFI binaries

  arch/arm/lib/crt0_aarch64_efi.S  |  4 ++++
  arch/arm/lib/crt0_arm_efi.S      | 48 
+++++++++++++++++++++++++++++++---------
  arch/arm/lib/elf_arm_efi.lds     | 28 +++++++++++++++++------
  arch/riscv/lib/crt0_riscv_efi.S  |  4 ++++
  include/asm-generic/pe.h         |  3 +++
  lib/efi_driver/Makefile          |  1 +
  lib/efi_driver/efi_reset_riscv.c | 29 ++++++++++++++++++++++++
  lib/efi_loader/Kconfig           |  2 +-
  8 files changed, 100 insertions(+), 19 deletions(-)
  create mode 100644 lib/efi_driver/efi_reset_riscv.c
