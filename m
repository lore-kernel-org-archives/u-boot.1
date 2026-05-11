Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493EFCD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A55DC846BD;
	Mon, 11 May 2026 11:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="abhCbj6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63855846B0; Mon, 11 May 2026 11:15:40 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974E3846BD
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67e9e343b22so4572068a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 02:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778490937; cv=none;
 d=google.com; s=arc-20240605;
 b=HNxxwM6o5gO7kOx9bI4Zne6y/Xl5Qc8MaEDoJIgEVXxwHL0MniYm1wJ2DPqwTFH4DE
 PNFsHlDumwo0hcr2h95fbFKl4SuoqMXbhUdmdae8AWw++wqE14y6F8f1qpfQ91mBM0UT
 pfaXWlz86DWDa6QuJaXrpTSAs/eF2vt8DjdgFnkvPibEcWGiDlTOJToRLqSocjRGG8py
 jMohOUrL583ifD1NjTxLI21poINujFKMnNWmgcJfh9G1QA+91CwqGsKdJIHPQMUNHhGX
 LRVJZ1puO6otLveOdqVXZT4UNWJdaC7xTwEdy5Zc7z6RT5n+oNLr9jbEYWfoiVbHqXK6
 LDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4hF/fZ7BU9dWU3D2Rd79S32vhLJQcnz6dYg2YJWGA08=;
 fh=2K8JEZe89Cg9mIn12L3R2Gvj32qUAuMJvPugKb6ns28=;
 b=HndANBoHlHlHb6NX6jl0QF2V1BsRBfuaGyjhpEV5Y7pO98TGKkDCvSauEDwQv8yISx
 y93Yh5GH11gMVzVw+Is/KzYa81GRpz3qY8nh6MAMOFSfaRJUuIkI7Pe4KRv1D6+ZkK21
 NxAy+RGrRmeBjf+DY+6Qm6mjZZh8ZlcB2yx5lWVo+7GsAVEgRItcpakPqoUlpw3W2+o9
 x8yaIHn3MFIk2xrCcQ3exX4EHWLm3hV+ToldfjyzwLJ8v5cZCJYFy8jopQLTQl1R68nL
 mTJ8qcBw+erD8BN+kq8NUwJ5OtbwIvhnn4GAiggVIJmGczpPeiPC/8IaI0JnV4VQL44C
 7GVg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778490937; x=1779095737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4hF/fZ7BU9dWU3D2Rd79S32vhLJQcnz6dYg2YJWGA08=;
 b=abhCbj6Af/2QkHDj1tmR4W3Mcau9HJkO5cGPEB3lmpFGUdKyAd0s825czGarrpWkkU
 t5IaIuDy6dCE3ZoJm1n6O74ICihz9IeeLED/MIDd3ZGAM2pm1+HXRZ/TG0U0J0L35Rdi
 586b9hn3nnZRFdrM9rtr4EuajnoaZW3Now2RLRjP3GgZip4sDV2bREmy5oafyuCbq206
 Wi6bsz4/jPLg0ot1E18+rpo1PSwaLvmTSAKb9nP2oUJMWzQAx99uFSzRUUfMzakv/w8/
 FeAEAbqW/+2xjg4OZ2JOkWcKJMqwF1mSs+66zg5j27QtqrugbrZ8lllcMGOo/a7oWPf7
 17Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778490937; x=1779095737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hF/fZ7BU9dWU3D2Rd79S32vhLJQcnz6dYg2YJWGA08=;
 b=oLneMueZ3ahCzYvgIAq/Q8tiC7r3R2E/YLltnsnFqOyNigN7ADJB8m7Nk33LTEkD+o
 WwXiVGnRxU3FWIfgIjbTsxGRfLkuptvYj4QdGegvVGS/d5t94d0CTCFVVdqKTQJF07C3
 2rgDi17k6dPshCS9+anlmZy9vTV1A7EpjkO8R2UNbKbEZ1s8EUc1Urevt4GZC6r+SEY7
 XEbunIHKB0l2tUZqzlTiYfgfyhFn/jFZht+c2zmMSuTzcDE2HKZaXS3LH4bYBkqlaVDq
 nVNaMLAqd2C5gq/ooutUmsDOwHAmkadq9Cjq0MKECKAmkz9KoAwDHbohUo/FshPXaNno
 JkkA==
X-Gm-Message-State: AOJu0Ywd3uQpEGvhAzi1nv2lrL19FMDXs4ZEIsaXeRE1L4kbVjN8KUsu
 UJmmng43t9aeX6Y+vKctAY/MysY4ckBL/kCw8P1FM8Iuka3bgzq2ZA7lTdL32iAIbMtR4fHhFVq
 TlfI141A03X7rRMnhUnh3SZLeBJUF2JsxFb2NOY4=
X-Gm-Gg: Acq92OHpUe4q4RnUYfqyaObeugfHskow7z5tHRF/dI/ttT1VMRAPvNql5Vnqrzc13BC
 UnRnO0p3UsllftLAPBN6siYr0efQ5ncykaFbsCWZgpwqmc2db29lDYJtSsmS/JZHwayP8gEOgs9
 PZURFUsvCY8jva3TK2BhuW6ilmozyKi/d47ShJ1NDSyj6Q/r+nNX76A6VFQ2VTgNqCukVRzwjJR
 eduJ7NbZVR1lfuNsN5DvifasC0CWqLgRoOcCZYBUpsED0+VJCKzMN+LjpNy52Gq15IHQ/kJjoFy
 kIfpuo26TNk9HUszm0URHVflC5aYYiz+rinIk5MEhL0NZmkFoiC5veu5qlp6wqy579iz4u9ujZr
 YzU84RgYBMoNbQaAmtq0rWoIdYKLwElvEmloOTFMLp4R7442in972nPv9K/SGNfg0/fOGbI0S6s
 ghxs7jlFQr6x8=
X-Received: by 2002:a50:ec87:0:b0:66a:19bd:5cb8 with SMTP id
 4fb4d7f45d1cf-67d642c0a63mr8578195a12.18.1778490936702; Mon, 11 May 2026
 02:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778277334.git.aidan@wolfssl.com>
In-Reply-To: <cover.1778277334.git.aidan@wolfssl.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 May 2026 10:15:25 +0100
X-Gm-Features: AVHnY4Jr4mldyk-sLKIMS7t1lP3eZTDzKXry7OBT2BT6Wev-_uKussfmbzPP5QM
Message-ID: <CALeDE9MRtntqBo1cK+AyhuVXC-D7tM7djHzmNBSU65KB8PC=og@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] tpm: Add wolfTPM library support for TPM 2.0
To: Aidan Garske <aidan@wolfssl.com>
Cc: u-boot@lists.denx.de, David Garske <david@wolfssl.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Aidan,

> This is v3 of the wolfTPM TPM 2.0 stack integration for U-Boot.
>
> wolfTPM (https://github.com/wolfSSL/wolfTPM) is a portable, GPLv2 TPM 2.0

I go to the github link and it says  GPL-3.0 license so which is it?

IANAL but I'm not sure if the GPLv3 is compatible with GPLv2 in the
context of U-Boot because it would make the whole output a GPLv3
application

> library that provides a full TPM 2.0 command set, an SPI/MMIO HAL, and
> firmware-update support for Infineon SLB9672/SLB9673 hardware.  This
> series wires it into U-Boot as an optional backend behind the existing
> 'tpm2' command, alongside support for QEMU+swtpm, sandbox emulation, and
> real Raspberry Pi 4 + Infineon SLB9672 hardware.

So that provides the technical detail, but what value does it provide
to U-Boot? We already have a relatively complete TPM stack, do people
do firmware updates in the early boot process, why else would someone
choose to use this over the existing implementation?

One part of what I want to know in a cover letter is what value this
provides to the project, what are the pros/cons etc, like what
maintenance looks like.

Peter

> Branch (full 14-commit history including the subtree squash + merge):
>   https://github.com/aidangarske/u-boot wolftpm-v2-patches
>
> Note on the subtree commits omitted from this email thread:
>   The branch above contains 14 commits; the email series is 12 patches.
>   Two commits are deliberately not sent to the list:
>
>     * "Squashed 'lib/wolftpm/' content from commit 664db130d57"
>         - the parentless squash commit produced by `git subtree add`.
>           Its diff is ~3.4MB / ~90k lines and would be rejected by the
>           mailing list on size.
>     * "Merge commit 'd42fd7b146...' as 'lib/wolftpm'"
>         - the corresponding subtree merge commit. Merges have no patch
>           form and are routinely omitted by `git format-patch`.
>
>   Please pull from the branch above (or wolfssl/wolfTPM @ 664db130d57)
>   to inspect the imported wolfTPM source. Subsequent updates will go
>   via tools/update-subtree.sh, matching how mbedTLS, lwIP, and
>   dts/upstream are maintained in tree.
>
> Changes since v2:
>   - Replaced the lib/wolftpm git submodule with a git subtree import
>     (squash + merge), matching the convention used for mbedTLS, lwIP,
>     and dts/upstream.  tools/update-subtree.sh is updated to know
>     about the wolftpm subtree (path lib/wolftpm, upstream
>     https://github.com/wolfssl/wolfTPM.git).
>     [feedback: Ilias Apalodimas]
>   - Reverted the changes to include/linux/byteorder/generic.h.  The
>     redefinition workaround for cpu_to_beXX / beXX_to_cpu now lives
>     on the wolfTPM side: include/configs/user_settings.h pulls in
>     <asm/byteorder.h> up front so U-Boot's macros are defined before
>     wolfTPM's #ifndef-guarded fallbacks in tpm2_packet.h.
>     [feedback: Ilias Apalodimas]
>
> Testing:
>   - QEMU arm64 + swtpm Python test framework
>     (./test/py/test.py --bd qemu_arm64 -k "test_wolftpm and not ut_cmd"):
>     19 passed, 2 skipped (matching doc/usage/cmd/wolftpm.rst).
>   - Manual QEMU arm64 + swtpm walkthrough per
>     doc/usage/cmd/wolftpm.rst section "Building and Running wolfTPM
>     with U-Boot using QEMU": tpm2 help/info/autostart/startup/
>     get_capability/pcr_read/pcr_print/caps all return expected output.
>   - Raspberry Pi 4 + Infineon SLB9672 (real hardware): all wolfTPM
>     cmd tests pass, including firmware update path.
>
> v2 thread:
>   https://lore.kernel.org/u-boot/?q=PATCH+v2+tpm+wolfTPM
>
> Aidan Garske (12):
>   tpm: export tpm_show_device, tpm_set_device, and get_tpm
>   include/hash: add SHA384 hash wrapper declaration for wolfTPM
>   spi: add BCM2835/BCM2711 hardware SPI controller driver
>   dts: add TPM device tree nodes for RPi4, QEMU, and sandbox
>   tpm: add wolfTPM build rules and Kconfig
>   tpm: add wolfTPM headers and SHA384 glue code
>   tpm: add wolfTPM driver helpers and Kconfig options
>   cmd: refactor tpm2 command into frontend/backend architecture
>   tpm: add sandbox TPM SPI emulator
>   test: add wolfTPM C unit tests and Python integration tests
>   doc: add wolfTPM documentation
>   configs: enable wolfTPM in rpi_4_defconfig
>
> --
> 2.47.3
>
