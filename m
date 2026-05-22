Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB60FCD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 07:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A7184673;
	Fri, 22 May 2026 09:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bizOKG64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DCD846D0; Fri, 22 May 2026 09:11:19 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED4F80287
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65890a6ca20so7799282d50.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 00:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779433875; cv=none;
 d=google.com; s=arc-20240605;
 b=NgN3hr3Qqwi1nfy1fhznKs4DuEEo+4RwyYrXoQOJgPDOsHT8Le6MtJT1GojWhIiUoc
 s+yXEYcLsCNwgyOElkTF30WdSC67yMsySL/WS3ILxsqnDoSqiPVGLgKykzNToRhTPkKw
 0pAubObq92oEbGBadmdQ0qiPan6v6H58c1Yy3+wwIXjBAY0KeeNRr8/MHHTpmOVGCa6l
 +qkN/1qUxQbuRb4SYEkKIcyLa/tJJLlQ6CizSxiQxkb2iL2Ckz92IgSCsEbSPBtoOGqH
 eHbgDBko2HJBF29zZUkR4LP9gyc+NmKhhKdZ+9pt4Fpi2N7U0D3IkV0alZRMCzVMTuGh
 yQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1vwsmpfbo7OriJfdHfqDvo6rwOLqURmGLAdmDXl3NF4=;
 fh=67Z3bffMgNy2NOnIcV3TPWJqsCgDIn69+1zvOyVwu7I=;
 b=Zh3kVLw2p7zNaMCasMGgqPCEpVF6uP4JHs9y9izGxVj5B1drY5q3ugzipTh5efYnvr
 WFxtducaZ3tCtHNPw2/9rf1bh6tXSfbUps+NDAZBk0XpjeeoXs+REXhlJiakBe8SZoiz
 ufbrUw5EYkKUk7jda+7CLx74/z9QEVA11VCKxzFYxxGTWOTRX+vYXbKwKUtYV9b6hJtG
 rwhYK6jM7iboqi2ypr0SVeyxwLlfUatqBN9avfP8azp/7iRwDSdnBAOUCOZQgq20PbSQ
 fuwzehRvt0y9sgxm3hJmdO3kMQsj9NPrdWXo7vw23j8ZowalOOKaL9SFmT6ahhPjqBl5
 7u4Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779433875; x=1780038675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1vwsmpfbo7OriJfdHfqDvo6rwOLqURmGLAdmDXl3NF4=;
 b=bizOKG645xWLdMkGtA62icnb93wzkEps6ucOsgsomAFMUk6Qp1IE8p9fJIMNJTPsYA
 xLrHx+3Ubx0Zr4mi+NpSbMoglqMG1q497LPLv/JwUZ5GvpGLyrX/gOiGZyg0Gnh+DL8y
 7isNJGloeLoTOxuVqqpmPgGwn5eprVknKkWd5ssjI1h3Ah1vLzDw+SbZU7NfvuRK9EeW
 xrxHoDD/xd43ZreGOykkW199sbxBngI9Ld6icuwx953gROazr093gdZdhCQmTPLNspT+
 k8uWmqu5NPLXw/Cs99li/Qn83MgqZGsjvsT3JEQAVFkB27Z7jwUbM7YBI7iE04RQNMdP
 KNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779433875; x=1780038675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vwsmpfbo7OriJfdHfqDvo6rwOLqURmGLAdmDXl3NF4=;
 b=G4SM9aY519fJjzNP7jPr+vZ6OC8lzmupXx+Xj/ZQmMe/FU8zkUCZvQmOJatKbmhWli
 F5snde10dRKVBNcrLIDpYzQInYAC6jKCErT1GJaBTp8kCdBAN/b3XDhSK3FSS7M4LNbt
 Qvta7q4qxZjDkhX+Ynmnu3ufREW0HFRHRZjhzdR0kwLF4E6ieL6NQCSXTXCbmJz2+KbI
 i1wWCRmGQ2QnhiQo5Gs3G0IdCaFRorvbnjl0tfPfEMjFvSScdTyZTY2zwmbaS33YANk3
 vk2EqEiNeBm0bsDMNfsCdeMJhHLxortePMaE+5ZetVdPgjiICVL8CS/H4mOoOOtIUIfY
 S5hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Y190X3BAB7dTQqsKGN59WG1KXGgaYBFt3brrLKbkveibOQoBcwfFHRY2yh3UzFbvpLM23Xfg=@lists.denx.de
X-Gm-Message-State: AOJu0Yztb2d1UTfi/2PKa+BqEdU3dIzJiNE1uuSWYGLmWgrsgQ+3CstU
 6oMyBSsVLWNW2h9ahkPlQpEVS1GfC7w5bBPuLOyziEeXRJj1+k+1LoHCbe01EqamwVFM1TRYy97
 ssMLZ7KMRESxmD2TnP38Z1URUukSW4PQ1adDgowN6yQ==
X-Gm-Gg: Acq92OEOlPeHVeaeLyKkI2KyK/Dpv1JTXDQf5b++DJ5+MtRf0n1hcVZFT+he6WKcPiz
 vvP3DOmtAF0rGnMKifZ1JdMlW8+ibCB/g+TRNAK4oEdnqJDi/b6HvO3R1fEBlOSAhOZWrLiqlbN
 3b8H5UkKKAXOp4Q5JFxAgZ2copv+RFkDXL7BwE2nGQxXRruDFYavUeM9eYEzTvpe4FbaSvGb1Me
 vILfPnyrfSxP5v0rTt5fPXpNmzFXt2+rFbRgZfpyuBTbJ3qGujVrzXx9K/M+HlfggtuS14B769U
 iypwb4pFmPNn82KBiOAQ9iAS2YkZAfo2fFG/lZAfvgFIDaalT75LUJVIqqSiaqCHqnv/0SJJnf8
 klhrnRRr0+JZZlbpQ0CTfSqcbY7ehhyyXNcZ3+InbopXg1fZkQTcSUd/RT7scxFqOeJOJlXp/Ub
 YDpm8XY0l6Pxre55C5vKpQyH9Adtdjc2Tf2OE5TeJSe4iDqZqF+FYfZtiChlI//TmRkGGHRbdS7
 yy/wubnm1ZGJI2BdyhlCmNACkxqYlvP24MoA929c2MhllUEV0TZQMK7W/W9eVSRUN2FJljeBCEY
 4Nf0UX/bnGFg8Fym+HW0hP1JELQ9wm7QusBqKLje+55jUD4h5Tlr3kPMDi3Ho7ACIhC7laHeMIu
 Gyyb0ECaeYOosNkP1
X-Received: by 2002:a05:690e:169e:b0:65d:d299:2aa9 with SMTP id
 956f58d0204a3-65ec98a3f91mr2583208d50.30.1779433875580; Fri, 22 May 2026
 00:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260521185025.30857-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 May 2026 10:10:39 +0300
X-Gm-Features: AVHnY4KrT-KDXoAxgMRWZQ2Obz7O3qH1eUbx50y669uJgIoN88DwZUIB4EgkvRk
Message-ID: <CAC_iWjKxnCoMwF8W0aqdtja4=6chomCHQM774un7vsqA_iYXYw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_selftest: add ACPI configuration table test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>,
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

[....]

> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_acpi.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * efi_selftest_acpi
> + *
> + * Copyright 2026, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> + *
> + * Check ACPI configuration table availability and root table presence.
> + */
> +
> +#include <efi_selftest.h>
> +#include <acpi/acpi_table.h>
> +
> +static const efi_guid_t acpi2_guid = EFI_ACPI_TABLE_GUID;
> +static const efi_guid_t acpi1_guid = EFI_GUID_EFI_ACPI1;
> +
> +/**
> + * efi_st_acpi_execute() - execute ACPI selftest
> + *
> + * Return: status code
> + */
> +static int efi_st_acpi_execute(void)
> +{
> +       struct acpi_rsdp *rsdp;
> +       struct acpi_table_header *table;
> +       u32 rsdt_addr32;
> +       u64 xsdt_addr64;
> +       uintptr_t rsdt_addr;
> +       uintptr_t xsdt_addr;
> +
> +       rsdp = efi_st_get_config_table(&acpi2_guid);
> +       if (!rsdp)
> +               rsdp = efi_st_get_config_table(&acpi1_guid);

Isn't having both RSDT and XSDT a valid case?
IOW the test looks fine, but wouldn't it be better to check for both
unconditionally?

[...]

Thanks
/Ilias
