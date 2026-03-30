Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7987D1061B05
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8AA83DBF;
	Mon, 30 Mar 2026 16:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBu6Owqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216B683E7A; Mon, 30 Mar 2026 16:41:43 +0200 (CEST)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com
 [IPv6:2607:f8b0:4864:20::1236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3BC83D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so5422797c88.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 07:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774881699; cv=none;
 d=google.com; s=arc-20240605;
 b=cFRXPdVQu3z+oYvGfu1ABXUy8SOhnAXCPqYHxXTCIfpaLf4/u0Ge1Rb63VTZ/+x1uU
 5NNWRNeMfZN56Sn7uBfcgFtTKBCY3c2KMOzkB9RjZuNvqGFVt88lNxnfWnsPo8j8Kj1R
 5KOTnZxXykjk9RZq5aq/d45vRmWjtt/F7tmshsmnctInrffZcBUq/IAjUqOtAp5IZtbi
 gVaN5O+q0Dx6MKlLya7G4g7BT7UCReZJ/R5NteT7L6hQ4uiONAQYt+EldgwLU0RF2uY3
 gb6wk0rJBw//4yFoUX0CteNMOsbrhF5OJeZFX9LVBB03I+cZH/X9iI/8uL8ALcYRmYjR
 FNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nCzH6YFhcZlIlUwu4/3cAQl/0E6G0EWmUj2Q/vw9NUU=;
 fh=mA3mb/7aL0bWx13o6E+mvTaMg5//dmhLzW/tLoVxT9E=;
 b=Eq03BG6MD4XaWuT0DV6e4jDEPfbcO5wPWWXh1KPuB20HvHURoveVYB70KQvlbKhLei
 aLcIpNq5xvfQ5PbPSfqvPdkLi7iwJscoT5N3hBR+8r6/MjpKVwYcyAiJqE4DrSfeLRR3
 aloUxtKUiVBpq1ZxccnyvXP/F6/uHzgENxpQPxlz4NIflphtXVu+u38wx6RY1awpqaEK
 Dsg2RiE3Ftu7F9xeeA2gdK5ULX9YYM8m/2TKbfN2dp4FC/3lvdxTZaoUzSiqdBIMhEda
 Z9InO1HU3WgOAN8f3rpR5In3It7UtPytNb5kCP+afBYiRqSy/DZvpD1qOkwdQMaQdgax
 Nlhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774881699; x=1775486499; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nCzH6YFhcZlIlUwu4/3cAQl/0E6G0EWmUj2Q/vw9NUU=;
 b=BBu6Owqbqsad1TkmitW127i4P4fbpBbCMsgVZroWVQVi87C4VAFMCuyr1f/112f4c3
 XPxsw6BdIUHuBxG1z6aVS0EJ0xOTacJeKMQLuFO0htGWDAHFIuWmemcxg/4pRvHye0wg
 AzSpWnrBZAdN82TvAdOUc4Qqr9vGbOSjYV2V2kPEor58/swalrEcyMkZBf1iw8dnf3QC
 Oh/QBy7kpVELdpjPjTUnogImk1yC83GiXKpHHEjhSFG9cTZWSEd/3cZpiUIevUZ9cZeR
 OcxmGl14CZQeu5vMNgVL3NWlU6tXrjJ39SSW+5yMrCrvhvs2ktG1a063tcO8Kabjoc9x
 Ophw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774881699; x=1775486499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCzH6YFhcZlIlUwu4/3cAQl/0E6G0EWmUj2Q/vw9NUU=;
 b=kwYXP4kEvIe4oNG/IuMnannvtLqzgft3GT1y06vJ18r0bSgqaD4BE0bvOzcRcwsXyQ
 vBjJk6EsC7Vr2pKVkgupHUwgNOxGlEzcBprPrfzPEiTi0NN3izIDWmMYSQB0UaC3rSOV
 w8S4baUjQDhRz0bwsPUVUkhhPK6LwAmJHbpxcLIPnVcm+3ks2gufSSZVcTJPr6JVVRMr
 QijgIPFf5VKJNp3tShXoVy1cUUTMgdsIpK6ycTFPvwDaHHr2esdsPPiwvIpE5n67PV8D
 /+tm8OpVDOokxCt/FSBkryJHDYzIzLExzlyi+4MrBBOYNvdH8VN/5xHJSmk2KrV0Lu00
 Fz7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBLgM4lP/Imdg2jFKjtuLze/VN9qHU2ClbmFX+5QOrTdo246RBMIepYkZDCMqbdFcl4MUkcIs=@lists.denx.de
X-Gm-Message-State: AOJu0YxWNOdV6QG6OJeLyg2W3z5WuwiyysmyR1s3hbpnXHRt3Ju45LiU
 uZQlE5hm6Z49EHqUxAvB3VZ1tBLClWIRbsbUZteW6HBiV9ueLtep3d8NVHGyLeoNZzE2A5FG9Ic
 9PkhSw4RAyGYJZPSzL47z9ymEk+nda4hiYZ7+np0=
X-Gm-Gg: ATEYQzw43kfDksd+JizpfP9YAYZoEeNxxtZWGwQ7uUmoCMlgRQAMcI2xdReWaAsxmSj
 B5jJHJVv0wupdi8u/KX6ZfzcXijfExM07/rrGQIe5YRsDtp5N7CHhsF0K+1RtKuGaEk5OLzNTLM
 4coHTy2MKD+cKoNl+3fTQa35xJ/wX088lSZ+UQpbaC3YhB8HD6nM5GobZf9mzhCq6abuBjIhku1
 ZI/rqkhUlFtpMhZGZMyZ9w36nO/xVcAA9yMrCUW/PUKNbAiHY7f3+RJskkCAbimZNTI9z4i5NzS
 9LnvtSCa1MZOMvH8kFKR0drfDG1reYnJfKZKtHV3BCrLObmsnL0nGtIomRn4U/Z3lDAMDTh1gHN
 8T75XTXeY+XBSRLa4pCwkS9PQes608N0heNMYxQ==
X-Received: by 2002:a05:7022:458d:b0:128:d715:b717 with SMTP id
 a92af1059eb24-12ab285a8demr7077828c88.13.1774881698818; Mon, 30 Mar 2026
 07:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com> <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
 <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
 <acld1cniWiqp9dxB@kehys.lan>
In-Reply-To: <acld1cniWiqp9dxB@kehys.lan>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Mon, 30 Mar 2026 09:41:11 -0500
X-Gm-Features: AQROBzAisk5nMsyYLSqnNJobaDu5pxPPqPBP4SIM5gRCOWS9odDgkbXBMUrYol8
Message-ID: <CAOCHtYhvK6PZCUPNRM+xhfg-L+AaCVu=1pgDDcc8irJeG-hJmA@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>, 
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com, trini@konsulko.com,
 afd@ti.com, u-boot@lists.denx.de
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

Add the magic numbers i got from Bryan at ti..

> Here are the git revisions that I used of the above directories:
>
> u-boot: your ef03e35488377a32cdd4f76d1a03ef7f60c798ef
> trusted-firmware-a: 8dae0862c502e08568a61a1050091fa9357f1240 (Mar 23)
> optee_os: 1c0c7c06563e9be0ebc55b47cdb71422b02906a6 (Mar 23)
> ti-linux-firmware: 12.00.00.07 (Mar 20)

I'm just on tagged releases, will bump later..

>
> For podman run, I am bind-mounting the source directory tree using the
> :O (overlay) option. So, even though I appear to run "in-source" build,
> the original source directories outside the container will remain
> unchanged. The files tiboot3.bin, tispl.bin, and u-boot.img are
> generated by running the following commands inside the container:
>
> make -j$(nproc) -C trusted-firmware-a CROSS_COMPILE=aarch64-linux-gnu- \
> ARCH=aarch64 PLAT=k3 SPD=opteed TARGET_BOARD=lite

TFA: add: `K3_USART=0x6 BL32_BASE=0x80080000 PRELOADED_BL33_BASE=0x82000000`

>
> make -j$(nproc) -C optee_os CROSS_COMPILE=arm-linux-gnueabihf- \
> CROSS_COMPILE64=aarch64-linux-gnu- CFG_ARM64_core=y CFG_WITH_SOFTWARE_PRNG=y \
> PLATFORM=k3-am62x

optee add: `CFG_CONSOLE_UART=0x6 CFG_TZDRAM_START=0x80080000 `
CFG_WITH_SOFTWARE_PRNG can be removed

>
> cd u-boot
> make am62_pocketbeagle2_r5_defconfig &&
> make -j$(nproc) CROSS_COMPILE=arm-linux-gnueabihf- \
> BINMAN_INDIRS=$(pwd)/../ti-linux-firmware &&
>
> make am62_pocketbeagle2_a53_defconfig &&
> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu- \
> BINMAN_INDIRS=$(pwd)/../ti-linux-firmware \
> BL31=$(pwd)/../trusted-firmware-a/build/k3/lite/release/bl31.bin \
> TEE=$(pwd)/../optee_os/out/arm-plat-k3/core/tee-raw.bin
>
> Based on reviewing your build script, I revised the above by adding
> TFA_EXTRA_ARGS=K3_USART_0x6 to trusted-firmware-a and
> CFG_CONSOLE_UART=0x6 to optee_os, but they made no difference.
> Furthermore, I replaced tee-raw.bin with tee-pager_v2.bin: no change.
>
> What am I doing wrong here?
>
> With best regards,
>
>         Marko



-- 
Robert Nelson
https://rcn-ee.com/
