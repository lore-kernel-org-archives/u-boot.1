Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEE9C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A18587186;
	Wed, 17 Jan 2024 08:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Yowr9wmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B6E878B3; Wed, 17 Jan 2024 08:43:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25E986F67
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705477393; x=1706082193; i=xypron.glpk@gmx.de;
 bh=ILeeJRHk15DJ95CoHv5ydFmdSaLYa+xjEKT8q0aLntk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Yowr9wmdTX8zZNBUOWewNhPitBLMmupsRzVP3feQt/rz/p1060Z9RBg0q0QZZ1VM
 OrZdFDbdc/720gmnOu0DUWagNHvD2bLcCG97HKAqICrRe+Z9zMM6oKG+svXDRAdbr
 8N7g+/ow7jUVxVNR+6/xyJllQAQ8qA8obbGppz7cuJICi+MFohVUzt3sdokiiPkIL
 7wBhOBRdVNhBpj0Nbw1TaLMUWyCDbMRNeMYx9c4lal3afDHUCInkMPYPvyLBGPNky
 /lILxGIUp9wAhINz+QBKi+wbqvYwhfjf1ned8P8JkcTBTJBzbww57l8A5GlMnmx9w
 ywQueTZphRnG7efPxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1rcVKE0QKp-00Vd6W; Wed, 17
 Jan 2024 08:43:13 +0100
Message-ID: <ad091ee1-a4ff-4329-aa73-e67f96a2bca8@gmx.de>
Date: Wed, 17 Jan 2024 08:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] cmd: bootefi: refactor the code for bootmgr
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
References: <20240117043944.477358-1-takahiro.akashi@linaro.org>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240117043944.477358-1-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NeB8ALfRy5SHnMx/TijMaseet9mMbK0qn58HOVjJLJVfNeCjpG0
 OexSxiEIzw+biSf4iDi664Q9sGn+4ZF14gMeT3b3hHm1VO8qdoj9JUOY3TSmMfvJOSHeZUx
 dJVmsH2S4nTZt41J5IbfV4RqM9qOWTrGYsA0SrhmBSsyaHaKbCa+jDywxeErZ2nLpfr2JtP
 1RmCe25YK7S8FqPTAxZCQ==
UI-OutboundReport: notjunk:1;M01:P0:oMb+KXhv1iQ=;UPitt0acC7G18IlMX1YLCZr00HJ
 kDVS5/niZo1Fyw7jvoI2KGhrgHIRKa4LMtTQDMY4vkvpbUjJ+RUMwIqSJSwMl7LgWsWqRdTHR
 YAMaMytp7Vw8UIBMQogSb/mRcR0CqNKP0fhqJm6x0jHKiKcjakeY7fChqkPDK/2Tom1HU02iW
 EI1m6JzSlfvfniR8Hf1bPVAO/bTavfUGSvWqCOaiQV20nXl/h6pnpabzFyXjbeC5bIA//t2Vj
 8382PUBpa8MlrgkOKv5w99pqnUzNylWnpcCtM+DBW1YcVgoEJL1gfvf8BBaHI3TGM1W6pbD/e
 H99bMt47yJyuXYpQFY8bJ1SCM9aIqXJum8SI4hcFS6cTeiqXtGB8/QNu7Q+amHD14oJesidt1
 a99X/bb5qG0uiG0rZIl2tTxPD58InCa3avYw4bdQcUdne23sxlGfezBJT5uoZweX5Lzx6dN8G
 ay07cRV9g+ye08lpNPI2yXQY84TFFWhUB+klQxo5vy39TvkEOFx9m0vGD+s3d3FhLoyiEdaZy
 5NhWGArCWpweGjja7bGzAEbMhZJVWOSWkDw2doNkJYPhEIZ8WSsB3FvjFBRQS1bAlJxwUWvrd
 fPMcV/x8XNkKHllO9dD6AWYzfUI7f24QXaXERwo15uhc3tSgNV0oWBQeHMdHGrEd3LkJnxlWN
 iEsmjSHNZJeYBaUX53mR6EmSVOf7cQ6Y2hTwfn6cTL9Q8tmO7LzPknW4WVRX6xDKBPm1f4j41
 0FGbakisQxW+oNrhX+Dn+r0D9Ge6Zr2LgTK6hEbtLBRvlT4oRISGBHLka+jfkkRz9eNtg9kLB
 KfAwKT1SrrvgHw3PorYwggV4Gd4uqMF0QXfx+MlWHjswAigGKljWYeLQuytj68tLYZlJKwjZl
 Bi3hKJgl/BzmiWfTXPGpUAVU8qqSOjQWn3xufETcuk0FJ1m/qFF2CmMkLtAif4VY5laFvj50k
 eBdH7GT7XsrGNd0gnku4eKyvYQY=
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

On 1/17/24 05:39, AKASHI Takahiro wrote:
> This patch set is motivated by the discussion[1] regarding
> CONFIG_BOOTEFI_BOOTMGR option.
>
> # This version (v5) contains only the remaining commits.
>
> At the end, bootefi.c will be decomposed into two parts, one for
> providing the command itself and one for implementing helper functions.
> EFI_LOADER will now be available without CONFIG_CMDLINE or specifically
> CONFIG_CMD_BOOTEFI if invoked via bootmeth/bootstd.
>
> Then, EFI_LOADER library side will be further split into two options
> for fine-grain control:
> CONFIG_EFI_BINARY_EXEC: execute UEFI binaries which are to be explicitly
>      loaded by U-Boot's load commands/functions or other methods
>      (like a jtag debugger?)
>      It supports bootmeth_efi as well as "bootefi <addr>|hello"(/"bootm"=
?).
>
> CONFIG_EFI_BOOTMGR: provide EFI boot manger functionality
>      It supports bootmeth_efi_mgr as well as "bootefi bootmgr".
>
> As such, We will no longer need CONFIG_EFI_BINARY_EXEC if we want to onl=
y
> make use of the UEFI boot manger for booting a next stage OS.
>
> Prerequisite
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This patch set is based on top of the latest "master" branch.
>
> Tests
> =3D=3D=3D=3D=3D
> * ran and passed py/efi_selftest on sandbox locally
> * ran and passed py/test_efi_bootmgr on sandbox locally
> * passed CI check (github pull request[2])

Thanks for rebasing. Testing on CI
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19342
looks good.

Best regards

Heinrich

>
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> v4 (Jan 17, 2024)
> * rebased onto the latest master branch again
>
> v4 (Jan 10, 2024)
> * rebased onto the latest master branch
> * moved binary execution portion of code (EFI_BINARY_EXEC) to
>    a new file, efi_bootbin.c, instead of efi_helper.c (patch#1)
>
> v3 (Dec 18, 2023)
> * rebased onto Tom's latest next branch
> * remove already-merged commits
>
> v2 (Nov 21, 2023)
> * rebased onto Tom's next branch
> * remove already merged commits
> * revise commit messages
> * add patch #5 which was split from ex-patch#5
> RFC (Oct 26, 2023)
>
> [1] https://lists.denx.de/pipermail/u-boot/2023-October/534598.html
> [2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D7760&vi=
ew=3Dresults
>
> AKASHI Takahiro (4):
>    efi_loader: split unrelated code from efi_bootmgr.c
>    efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
>    net: tftp: remove explicit efi configuration dependency
>    fs: remove explicit efi configuration dependency
>
>   boot/Kconfig                     |   4 +-
>   boot/Makefile                    |   2 +-
>   cmd/Kconfig                      |  10 +-
>   cmd/efidebug.c                   |   4 +-
>   fs/fs.c                          |   7 +-
>   include/efi_loader.h             |  28 +-
>   lib/efi_loader/Kconfig           |  11 +-
>   lib/efi_loader/Makefile          |   3 +-
>   lib/efi_loader/efi_bootbin.c     | 211 +++++++++++++
>   lib/efi_loader/efi_bootmgr.c     | 488 -------------------------------
>   lib/efi_loader/efi_device_path.c |   3 +-
>   lib/efi_loader/efi_helper.c      | 286 ++++++++++++++++++
>   net/tftp.c                       |  10 +-
>   test/boot/bootflow.c             |   2 +-
>   14 files changed, 546 insertions(+), 523 deletions(-)
>   create mode 100644 lib/efi_loader/efi_bootbin.c
>

