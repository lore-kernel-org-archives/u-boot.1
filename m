Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22519CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 10:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3C0847F6;
	Mon, 11 May 2026 12:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4Gik2Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DBA84860; Mon, 11 May 2026 12:09:45 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4841846C7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso6080197a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 03:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778494182; cv=none;
 d=google.com; s=arc-20240605;
 b=W6QksjOomK3UoXrTQ1ktYnXcP5by+B/h5TcCEz5hVj4Yb0wnlycmYc9iqAzOMujfZM
 KLKkP7LdKdG2vccykbrZPSJJGfaWiC32QpPgiQraL0wlm5iUhUpOIJ1S3J2Rd3pfS0fg
 MFMx10inykLWJjSBdqXrlaaVDvCKW/BW8gGafVszT8AODVhlQk09uhXDUDXg8HA8FE8H
 yvgwCGyHYYzjpQ67jkpTIIU8MoTfWgo9gwJPhZkWAuX8Q5W9bzmyMZaNu7A1qgKa/cQ7
 hk+BhgBVHFWdIVGzR/NqfSr6cT9wjFZnJYxU8n6Y30wl4b2IbtxplTmS/wSJBvbaPU74
 P3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8r20cNjJJZFC7l3E0ZzFiP93YY6tHBCl5VSAoqNh9Sk=;
 fh=2K8JEZe89Cg9mIn12L3R2Gvj32qUAuMJvPugKb6ns28=;
 b=NRNHlBKK0Vl+XEU+CPeENYD/PF1IUP7solSOhpS0Pr+YEbkEKORAFoON2QlabWotqo
 a1zUnT2+HBAlEEsXajql+OyrvfivlK65YpbP4j+v/JSjkd/7yi//B+tsV6RSLFL2DRE5
 gyErnV63gdZGYcnjfa6MGz6wcW20eDKjCWALVm/TUcxDK7/Ao6eV+yfbyOT70SrvOsBa
 uaomyqIkLxzgSwUYY07hFsOglfErnuLNpT/R6D2bH/9mJeU0bcBeFU+Wvt7dwnOk0b+z
 tPzyWI3zwfQ/P0PpGwn2Zuj9KoUF2KcKIwneknFmpoQnj6/ZtgiBN6pmEkI8rvAUZErB
 dnPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778494182; x=1779098982; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8r20cNjJJZFC7l3E0ZzFiP93YY6tHBCl5VSAoqNh9Sk=;
 b=U4Gik2DgrBx9BgX7DUenTH6JnJD0bf4NAsKAj9AfTqJIj067205yPX0wSzP0EgCD9s
 txqYyumCKpKrDFaVdTQreMCdmcB5R30ZX3BvSW88FyfbuF0pqFg4zGGAYiMY5oz2opCz
 TLPzXgNCZlbNdIoQ0cSUZtpC1QuQGuId0y/oMrJjGqu9B4VjHBe1yzBfXWFDl6rA297D
 0sEt4G2RiWF50z8C6exhCkVcO/IXB4aunzwxPdLcpgEf0zX74QNfUVDacjMfRm6dfhUm
 ckBdfcolQzaTY77sNqS4ffL/hnPBe2Z0fcDfJowNc1OLslzAyTI/qDkm8Ov8k+WTFDmU
 Wgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778494182; x=1779098982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8r20cNjJJZFC7l3E0ZzFiP93YY6tHBCl5VSAoqNh9Sk=;
 b=ReC6D5zdUs8p9WcgGE+YNftziAwR7LbTpsVhvde+ZUi8V8y7YUnUrjbcUH4pZrEURl
 BqTQJUGe44t5EPBZp/2X5C7C09sAdPmJZsEgjnuHU4BF1tkBeOjiBohKvkRq876l7Sqo
 Q3kHvlJ6VNtlxueLQgbpL0VaOYRfKc2iOoiBOVrn8SsmwTDi492MYTHrvunIQAqqN6xi
 ZVqyrW/p/SCiSdzKgdWZ8SLOo02d60MqPmrVw1dJuirtO2RcXmwwWBLVKNzrjUcqTT8r
 n5SVZi4rizcq6rVeRsISbieUv1a4IRiNegdqvt6JWpXRtW3uSmJCrTKO/2/g+lPGJ/OQ
 RO2A==
X-Gm-Message-State: AOJu0Yyg11Eq+C4EK0198v+bhV1O96es1CF7Hoc2TpGYcrAJxB9goxIz
 xHQyd8dX+kBGhK2aBFNU7MnAUFZtSl4Yr2uJaht3q+n4jQ4l7injG7tUhExc9JvO+RBBB+Zy7pv
 cUsMM9w8PbpEVafz5Pm3d9ZZsqktpnn4=
X-Gm-Gg: Acq92OEJ2GVOtNOToTODVZep2vqKW00ZsKzgDeZan16tzzzhBbBg14OAf6eQKfIsMSb
 8LsLMYXcpZ3naqsX9NDNRRdnkEEXPmp6kCzTSqrUar8e3VL6e0irAeloxiBuXfvcSK9TL/m+4hw
 SuPRiEMgo13DzxJLiDFSf90pETlTccpwtl/jXZjx7aepaZeRyV4k8z66Q5EZSL0TEc6nQCsIvu3
 p8Ef4NAcTI2bGAq7g69E8SMqVBavdjOFiSyxsneJ5k7Nz0aGcMsoCNa4EQXxegVd0swmf8H2Sk0
 VMxljqJ1OMRDsA4dTVdZ/koff/aIOT3J4OHTNvc/MOfM2Tm+RpdpWxxM3iXfjtss78KKB9FAxmF
 2alrXHdVM7Kg6qUNthgFtb9742XDcbvxLSSpH/naHneMOsZmIH6lXzx82OwDxbH+9OZ2Vgar6ui
 r4
X-Received: by 2002:a05:6402:428e:b0:67e:2498:f0d3 with SMTP id
 4fb4d7f45d1cf-67f704fe64bmr4578527a12.2.1778494181614; Mon, 11 May 2026
 03:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778277334.git.aidan@wolfssl.com>
 <CALeDE9MRtntqBo1cK+AyhuVXC-D7tM7djHzmNBSU65KB8PC=og@mail.gmail.com>
In-Reply-To: <CALeDE9MRtntqBo1cK+AyhuVXC-D7tM7djHzmNBSU65KB8PC=og@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 May 2026 11:09:28 +0100
X-Gm-Features: AVHnY4I3qfPX7uAKnt9WztTT_0pZ2VN90fSs-W5JzG_5OyYUP44kyhIH2qwH6sA
Message-ID: <CALeDE9N-UDKDscCgGJ6Xsw=zesTRMhU=NSNxbvyZi-Dx+3NJCA@mail.gmail.com>
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

On Mon, 11 May 2026 at 10:15, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Aidan,
>
> > This is v3 of the wolfTPM TPM 2.0 stack integration for U-Boot.
> >
> > wolfTPM (https://github.com/wolfSSL/wolfTPM) is a portable, GPLv2 TPM 2.0
>
> I go to the github link and it says  GPL-3.0 license so which is it?
>
> IANAL but I'm not sure if the GPLv3 is compatible with GPLv2 in the
> context of U-Boot because it would make the whole output a GPLv3
> application

In fact the majority of U-Boot code, like Linux, is GPLv2 only, not
later which makes this directly incompatible with U-Boot.

> > library that provides a full TPM 2.0 command set, an SPI/MMIO HAL, and
> > firmware-update support for Infineon SLB9672/SLB9673 hardware.  This
> > series wires it into U-Boot as an optional backend behind the existing
> > 'tpm2' command, alongside support for QEMU+swtpm, sandbox emulation, and
> > real Raspberry Pi 4 + Infineon SLB9672 hardware.
>
> So that provides the technical detail, but what value does it provide
> to U-Boot? We already have a relatively complete TPM stack, do people
> do firmware updates in the early boot process, why else would someone
> choose to use this over the existing implementation?
>
> One part of what I want to know in a cover letter is what value this
> provides to the project, what are the pros/cons etc, like what
> maintenance looks like.
>
> Peter
>
> > Branch (full 14-commit history including the subtree squash + merge):
> >   https://github.com/aidangarske/u-boot wolftpm-v2-patches
> >
> > Note on the subtree commits omitted from this email thread:
> >   The branch above contains 14 commits; the email series is 12 patches.
> >   Two commits are deliberately not sent to the list:
> >
> >     * "Squashed 'lib/wolftpm/' content from commit 664db130d57"
> >         - the parentless squash commit produced by `git subtree add`.
> >           Its diff is ~3.4MB / ~90k lines and would be rejected by the
> >           mailing list on size.
> >     * "Merge commit 'd42fd7b146...' as 'lib/wolftpm'"
> >         - the corresponding subtree merge commit. Merges have no patch
> >           form and are routinely omitted by `git format-patch`.
> >
> >   Please pull from the branch above (or wolfssl/wolfTPM @ 664db130d57)
> >   to inspect the imported wolfTPM source. Subsequent updates will go
> >   via tools/update-subtree.sh, matching how mbedTLS, lwIP, and
> >   dts/upstream are maintained in tree.
> >
> > Changes since v2:
> >   - Replaced the lib/wolftpm git submodule with a git subtree import
> >     (squash + merge), matching the convention used for mbedTLS, lwIP,
> >     and dts/upstream.  tools/update-subtree.sh is updated to know
> >     about the wolftpm subtree (path lib/wolftpm, upstream
> >     https://github.com/wolfssl/wolfTPM.git).
> >     [feedback: Ilias Apalodimas]
> >   - Reverted the changes to include/linux/byteorder/generic.h.  The
> >     redefinition workaround for cpu_to_beXX / beXX_to_cpu now lives
> >     on the wolfTPM side: include/configs/user_settings.h pulls in
> >     <asm/byteorder.h> up front so U-Boot's macros are defined before
> >     wolfTPM's #ifndef-guarded fallbacks in tpm2_packet.h.
> >     [feedback: Ilias Apalodimas]
> >
> > Testing:
> >   - QEMU arm64 + swtpm Python test framework
> >     (./test/py/test.py --bd qemu_arm64 -k "test_wolftpm and not ut_cmd"):
> >     19 passed, 2 skipped (matching doc/usage/cmd/wolftpm.rst).
> >   - Manual QEMU arm64 + swtpm walkthrough per
> >     doc/usage/cmd/wolftpm.rst section "Building and Running wolfTPM
> >     with U-Boot using QEMU": tpm2 help/info/autostart/startup/
> >     get_capability/pcr_read/pcr_print/caps all return expected output.
> >   - Raspberry Pi 4 + Infineon SLB9672 (real hardware): all wolfTPM
> >     cmd tests pass, including firmware update path.
> >
> > v2 thread:
> >   https://lore.kernel.org/u-boot/?q=PATCH+v2+tpm+wolfTPM
> >
> > Aidan Garske (12):
> >   tpm: export tpm_show_device, tpm_set_device, and get_tpm
> >   include/hash: add SHA384 hash wrapper declaration for wolfTPM
> >   spi: add BCM2835/BCM2711 hardware SPI controller driver

While I understand why you would put the above patch in it should in
fact be sent on it's own as a standalone patch because it's really
nothing to with this series.

> >   dts: add TPM device tree nodes for RPi4, QEMU, and sandbox
> >   tpm: add wolfTPM build rules and Kconfig
> >   tpm: add wolfTPM headers and SHA384 glue code
> >   tpm: add wolfTPM driver helpers and Kconfig options
> >   cmd: refactor tpm2 command into frontend/backend architecture
> >   tpm: add sandbox TPM SPI emulator
> >   test: add wolfTPM C unit tests and Python integration tests
> >   doc: add wolfTPM documentation
> >   configs: enable wolfTPM in rpi_4_defconfig
> >
> > --
> > 2.47.3
> >
