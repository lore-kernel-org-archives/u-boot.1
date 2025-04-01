Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFC4C3ABAB
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BE882105;
	Tue,  1 Apr 2025 14:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CXasWERw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E2B782107; Tue,  1 Apr 2025 14:43:35 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884E0820FE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 14:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e60b75f8723so3953368276.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743511411; x=1744116211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=clRLVyGy01FdvvRCVw7fQaQ6FmpprEkWQs8+2e3qyVs=;
 b=CXasWERwE9SSxJZb5zNJwis1Ejj2bIpjt3K0ldnHs1IYlALZuxnk+yllwW8JkxSfwy
 Pg8Usmaha5ZddSmk59JUbN2BVMhxJSD2JuzoHJxDLZgG4RMASRiRdOi7HkG3dsbcHa27
 i0AbtPEYezZphSEgJwPTXG3dVJCLLyq3vMbJUiiaCCxjaKzsVTa/L7UM5C/6SYHeD4B+
 vY3MLdQqG+0ZSmpQka41ZEZ4Gfo9NOnaQDGAQE3TV0213T/2oFXC7TrtIf7Y5bspit3n
 Vcaep0nI/0Ob0ilrZ66w+pFFm5nsArPacO49XFdS5QUCv4yGLKaHXEk7Rns7YGVPF2vv
 F1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743511411; x=1744116211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=clRLVyGy01FdvvRCVw7fQaQ6FmpprEkWQs8+2e3qyVs=;
 b=K2km0DNVatJnbCfhT3azJYitowLTp+6C/EvV7b7CqHRacPoM/VIPsoUo/2Onwjelf1
 janBFG+xnLkS4NcpgXrWaYsnq9Sc0KkjfAd7p9J6+D4U+8A/uumhqAc2XHFunMUOtefT
 vdeH/DI2R0F8y9WU1yMkJ7bCzbWvM6sObMKOungSuK0TS4PeZJsgoogaF1x41coKJeIn
 anPRvI1j1vLESRvTLO/X55GCXFEyBSbI8JnTBjlyyebYm6cfQzlyanTj+u/o8E1gn5GN
 zcxLWLh0fS/A3jt2aj3fNqZrx+aQYIAKNI35QxxVh9Ke/NDhczgYi2lICq6Bsbud1SKx
 kt9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6FYLZweSQvxzkBlaNR+RXDoYEaKrGvcpCOT3NkUsO+YaS+m+VsiiGyhKoCgMqg1McxfApcF0=@lists.denx.de
X-Gm-Message-State: AOJu0YzPHZ5tY39c0ZCFcEVm7l88GvLrkiHAm9tg7l2KNNkWDAkS5/eX
 AFGX+kY2k4/lVovMvdsKG2sVNWKyr8+80U6c0LrMjpzDsKvcroxyEDg/SXuhfDjpEiHL0aQqE2R
 Tx5S9QGdMQd7lhWFfJ98p8PkATth2glFT5HxTQQ==
X-Gm-Gg: ASbGncsPCvwazAQkAgcC7pQLM4G0hiln3kMfLfIlEd0/d7RQVYAmYc2UXizFW8tEkdJ
 O/894+CRRlPM7mMBbYwiHUVQJdfUML9K4JnuP3LOMHy6VsEWckdEkJkStG8rMTC/+zYm2uFUrk5
 5j4HUnEfhep5tCXIYIi8eXCwAy
X-Google-Smtp-Source: AGHT+IGenybDjOLUn2QMbre6Yg3eAufuHG7iFBpNq/CtOU0aWbois66VJ2wLSaERt2iO17EOAw3TblxFIFwhiukaoVs=
X-Received: by 2002:a05:6902:160f:b0:e5d:d11b:a073 with SMTP id
 3f1490d57ef6-e6b83a5db64mr16106490276.27.1743511411372; Tue, 01 Apr 2025
 05:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-2-afe2e3696675@linaro.org>
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-2-afe2e3696675@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Apr 2025 15:42:55 +0300
X-Gm-Features: AQ5f1Jqhr_wF7hoL1mm7RgtrYWh1qpOR7feu0QLAYHMv7o_LgPPAvgFNAxycX3M
Message-ID: <CAC_iWjKSFkuHCBFHcd04m7mz+33EbsmPWvSX6+u2Pvo=3nwy5w@mail.gmail.com>
Subject: Re: [PATCH 2/4] mach-snapdragon: CapsuleUpdate: support all boot
 methods
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb

On Wed, 26 Mar 2025 at 19:41, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Expand capsule update support to correctly identify which partition
> U-Boot is flashed to (between xbl, uefi, and boot including A/B
> variants).
>
> Use qcom_boot_source to determine if we were chainloaded from ABL,
> meaning U-Boot is on the boot partition, otherwise we assume uefi if
> it's available, finally leaving the xbl partition.
>
> Set a different fw_name based on the target partition to prevent GUID
> collisions, since a board may support U-Boot flashed to boot or XBL we
> need to differentiate them since the U-Boot binary must be built
> differently.
>

[...]


> -               if (!strncmp(info.name, partname, strlen(partname))) {
> -                       log_debug("Found active %s partition: '%s'!\n", partname, info.name);
> -                       strlcpy(name, info.name, sizeof(info.name));
> -                       return partnum;
> +               desc = dev_get_uclass_plat(dev);
> +               if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
> +                       continue;
> +               for (partnum = 1;; partnum++) {
> +                       ret = part_get_info(desc, partnum, &info);
> +                       if (ret)
> +                               break;
> +
> +                       slot_status = (struct part_slot_status *)&info.type_flags;
> +
> +                       /*
> +                        * Qualcomm Linux devices have a "uefi" partition, it's A/B but the
> +                        * flags might not be set so we assume the A partition unless the B
> +                        * partition is active.
> +                        */
> +                       if (!strncmp(info.name, "uefi", strlen("uefi")))

since it's a static string, use sizeof() to compute it at build time.
I get what you are trying to do here and automatically detect the boot
partition, I'll have a closer look in case we can somehow make this
loop shorter.

{
> +                               /*
> +                                * If U-Boot was chainloaded somehow we can't be flashed to
> +                                * the uefi partition
> +                                */
> +                               if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
> +                                       continue;
> +
> +                               *target_part_type = TARGET_PART_UEFI;
> +                               /*
> +                                * Found an active UEFI partition, this is where U-Boot is
> +                                * flashed.
> +                                */
> +                               if (slot_status->active)
> +                                       goto found;
> +
> +                               /* Prefer A slot if it's not marked active */
> +                               if (get_part_slot(info.name) == SLOT_A) {

SLOT_NONE only applies to non-uefi partitions?

> +                                       /*
> +                                        * If we found the A slot after the B slot (both
> +                                        * inactive) then we assume U-Boot is on the A slot.
> +                                        */
> +                                       if (uefi_partnum >= 0)
> +                                               goto found;
> +
> +                                       /* Didn't find the B slot yet */
> +                                       uefi_partnum = partnum;
> +                                       strlcpy(ptn_name, info.name, 32);

sizeof(ptn_name)

> +                               } else {
> +                                       /*
> +                                        * Found inactive B slot after inactive A slot, return
> +                                        * the A slot
> +                                        */
> +                                       if (uefi_partnum >= 0) {
> +                                               partnum = uefi_partnum;
> +                                               goto found;
> +                                       }
> +
> +                                       /*
> +                                        * Didn't find the A slot yet. Record that we found the
> +                                        * B slot

[...]

Cheers
/Ilias
