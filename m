Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1A3C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 12:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C8284C25;
	Wed,  1 Jul 2026 14:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aCkhV95C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC15D84C2A; Wed,  1 Jul 2026 14:02:06 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E43841F2
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 14:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c128c8c7a76so133835066b.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 05:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907319; cv=none;
 d=google.com; s=arc-20260327;
 b=MMZ9A2ZaPongStQbAmqPzqZbd0KeuUCq5+Q/CKsTgtyBL5VocA5KLKOc7DFvJViTX/
 m/fqrkVTqSMbVo0ke6ZrV5v0kW63U8oYx0dF+zeLFpntb6Of9I1NE2uiCrpzef/Lux2I
 un97HVHTfy0HJRg9+eaivnjd1hcgy4jGVAxs58F1impfOgvQeMcdufExC8ADC5NnfCMF
 6lAJUtVoDMF2AlENJaZlbDa+66f1PEtYC1AalYQvU0sgWRyiHbGTrGt51rzTcreX8xvB
 4dt5XWXhJ/ub4XGSgksAN+Bk2C5rgj88fBtdWXLi7NqmY1DQTDWCOk0n0RIF5wir/Eiz
 1TBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Kh/NR2WNo4HCfMvXa5kg1WRBl2+RiWa3tj16+XMazmI=;
 fh=wDL1NfW7zzg5qpgye/Ktwxz7TnAFJj5iu/DjyntF5CM=;
 b=remVSWd/E69Cr+WeVr5uVI2uLUKgs7ad2aMpIqfYjWScXIMHscBW3pvrq38YpIB6gw
 3KDQkkjHn43irgMey8g1XQrasbzJrXS8Xy/dl2E223w9w66dbpzeQB/DFA+TjHynnf5h
 c0T/0R+BwOElNDxyugE0MPwCU3RJp4qF6Qn3IS8IwIXfrPvmF1nJJxLY6oAg9jXChCwR
 /1AMG/SVuRYc7zAJL1deMZZWURYx99QBIitr05vWvvyQVo5Qxlu9X1ACCHFKtFxNa/3s
 LTO2ZgUreWZjuhld+UUJrsabNSZpsCutz8E70ZbI68RAP9dAVll0fA815OSAeJkVl5ka
 bVcQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907319; x=1783512119; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kh/NR2WNo4HCfMvXa5kg1WRBl2+RiWa3tj16+XMazmI=;
 b=aCkhV95CIlCzjjWJRCXiy5SEDMaEW0oL0qCF6B5A+fh7ed7WQBgZHgsN9028MgAqRR
 BNS9+zdN0Dxty+zBjPPFTJ0MSs6tBpxR66QWKRRrXdfuE9VpK20urqPEbdMDzdg4AVOs
 nvypn5aOd+DYiHh+loefDvEq5mM/3Y+Cr4caM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907319; x=1783512119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kh/NR2WNo4HCfMvXa5kg1WRBl2+RiWa3tj16+XMazmI=;
 b=ENZBxQH+aU13AxS5H0EaYKNcl5PJhpt9iai8Actw26oczaYvJ13w3trvVKjoS7RS37
 LS2XQZQNFXLstDQQAWGo0YviY2E7OsOYl00DsukxbF+FGn81ixJWdeHesRyXkZKbq8z1
 48BrxWw/3UevrkpyGsJG1GT/exUWdpLSVfYD25oO8HgfaPgY4jlwhyo0ip7rof8MlDy3
 ZTZDIIBrZj+SGkmRGsxfNLytgI7imgUM72Jv7jq2FxaDPQ7L9KzGqBN+uiI1dqZCzVZH
 UdHi/SbKInXKFSEhqxhEfbw0qop4bzRwUNQESZWmStwEMnTJMJXEsd6l0zowjwdIpBUG
 KlaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZ6aZ+HtWqh8pj6srdtWEbxAktxqnVkn0wsEV0jZmq2XbjtjJ9Rz01gVBJ/MRK7tEl2w7a5UE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+5fySxkZCXVlG9yKKKep/cVUMZ0NA1l8I7jVVq8UP7iyBAHeM
 wUfZ/hi9x5TIsz9UGVMdasLdLrTnACV0zJpvDyR5R1u7XxDqrofkdQfskiYwPPxtjV9hRJNAXKT
 SnU2KTezEDiEqhtPtGOMZneuuoSHzJcGS3Xa3utYP
X-Gm-Gg: AfdE7cnrqMagEmJpxUN7H8veF3CCS/FOkYz4KEvL0FZWxxX3IlDK/IJfsaGtnGGDdj8
 R4JF6+KjGxM3NNL5BatUpjRsaAcdn0LeHAo1tjXyvrW2xTa2ad7kfkWar7lVorW5KmtrJP5BrjW
 95L1qZAoLmzFftreE91yKmzaexJOEU0T4OuWlcITWiK6nbDnsH8K33pov3bnKo4ey4oRXXquRSG
 ZsZusyIjAiBt9caHgmyZylnbNMSyf7UvujJkF7lp4ylZiH197mR+xVR3QrKHoOYiQcn5o5d9w==
X-Received: by 2002:a17:907:d40d:b0:c12:7f28:bfd9 with SMTP id
 a640c23a62f3a-c1290536698mr293151466b.25.1782907318245; Wed, 01 Jul 2026
 05:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-12-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-12-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 13:01:44 +0100
X-Gm-Features: AVVi8Ce21TovxCOz8f7JPgAYPacwrqoKLfTK4Fh0SnUsK0dZPVchubUcRslUPB8
Message-ID: <CAFLszTjSeUs=iysEo5-ty+utMR4mJnW4BQjWPiTGB4QndnP_zQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] efi_loader: add ACPI table dump EFI app
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On 2026-06-28T08:27:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: add ACPI table dump EFI app
>
> Provide an EFI binary that can dump all ACPI tables to files
> <table_name>.dat. These can then be further analyzed by decompiling
> with iasl.
>
> The DSDT and FACS tables are identified via FADT.
>
> The following commands are provided:
>
> * check - parse ACPI table list\r\n", do_check
> * write - save one file per ACPI table\r\n", do_write
>
> The file names are constructed from:
>
> * 4 character ACPI table name
> * number if there are multiple ACPI tables of the same type
> * '.dat' extension
>
> This matches the output of the Linux acpidump -b command.
> [...]
>
> lib/efi_loader/Makefile   |   3 +-
>  lib/efi_loader/acpidump.c | 566 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 568 insertions(+), 1 deletion(-)

Did you see my comments on v2?

Regards,
Simon
