Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F51C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 12:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC45287728;
	Fri, 27 Oct 2023 14:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Gg23CykN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A7287728; Fri, 27 Oct 2023 14:51:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A1387620
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 14:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698411081; x=1699015881; i=xypron.glpk@gmx.de;
 bh=KYR0nhtq196JoLBLHIwlMp/d7dK53fl+IXQTxKcH8CU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Gg23CykNXiaNZdQAD1S7dMQHLYmwWIs2LomoMaNTTTERxToHCqdkDbcxWUx6rbjt
 ngoW4+gI4BetVP0PFqY1megA4nZ4ejOfU+7TTnc6qzI7ekjmZgqcpqHcEnBjtBtbK
 0OwjmOSrcfVsU0laMhEUo+mmU4qOObetMh9B4/GHmHFa5UwIpJ4Zt/As612ZtuC0P
 nNeCMhpSM4v2EgSttf3vpYOg8EJef4R2brJo89YVo0gZotrDdjvG9gljRWvrp0N2e
 qRFWOM4JH/nfW3uqSWCxZt58FzaM/G3I6aarETkeKiFtep52qeIuJyPjxONklm8SR
 eCdamisc0VRbCC6CTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QFB-1qxBmu0Xtl-001R3z; Fri, 27
 Oct 2023 14:51:21 +0200
Message-ID: <521edcca-d067-4d9a-a9ae-2fd9325ae3b7@gmx.de>
Date: Fri, 27 Oct 2023 14:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request for tpm-next-27102023
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: sjg@chromium.org, u-boot@lists.denx.de
References: <20231027112616.112555-1-ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231027112616.112555-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kr2TT5T/jFa4XlOwB9LYlQ+cYgcAD6X8vh5EmWH6cEG2rJF3i1r
 YNgQZo4BLh4McuIRdFFWoO1WptnQBH+pok3BIAIu1Vqyl6iWuQlfsrm3dXNrVE5yG88MVN8
 TI4SjH2Lbt4QQnn5j4oTRpxFg2Igil2sHELOlXRyjA7W90pzy99ErHCokAvZHg1WyyglNZD
 reWUNaDQfUmsKxsIClwgQ==
UI-OutboundReport: notjunk:1;M01:P0:d1gUu+Wdyqw=;xinebVnZ49Nm86nYnEiotIEkerA
 fOWBp5g6pi+k9nhFXnFqkF9qQkjGnij4zKgnTBwb9J/hlkYwQOk6Cmq1BVeX3TZbvSnm/0Ekl
 VpxEbNhy3GIsXrQBcyId8HHLSTRmjOF+kBJ27KZ5H/w1dA7Tk9lrla5IzToKn0EyeqrYChEbd
 HCyqsJ12WoIgkLrIiMQ+R7Pkain2tZdODLAu3rzY5+qEA4nsY0Fw6JTDdEOTJr9KNShi7r7st
 VRhltMrbl3mtoedHBuKrhZTJRPXKBoyd72axg7Hj2dgzGRudcsgNwWkVIsxy+Ze6ddK7/Y8MB
 eixk+o6uV2FJkhmxmPJxA50yoy+yLLAAHniCRU0nT4bebHktCuWxuekLdAI7PZzgbBRehfM+y
 i/aOgSSmACCeg/qpf0R+0nMwY04sHLZ7DDlk1bc729AXyKNnKbX2g6V2BxnN4eTGN2GJqw2Wq
 rDN9R0A7voo9GChN9iXDvcqprOGRWX6AdWTrlMghMDVEL6tzsG8ZkBUz6XrtN1JWLd0DUuWRz
 XXIdy9n5SsCq74X+o10DUb6m8NUmKiA3aq4HqcqZzAzZcAaBV1x5UgvR3HVMf4dOQKHp2OA4W
 WyhgEhe8zx46AokkLLZ6tMf6ZAsG+bdG07uD1G81rz1bRLFQSCTAqm3urdF6XcijycQKIVhC3
 F54WnQS1a6CqDfG84ovWIeZ1djim65XWDYN7snyqMeXRZSCscLe4cWsJye0SDZCVMUmc2mnQp
 4V5XHRA1JSADOHDKhAVyPg5xsifz3A+PZSFCmah3k5szyxdi8G08SLzb52PoKHhCmWAcfFCkz
 Sv
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

On 27.10.23 13:26, Ilias Apalodimas wrote:
> Hi Tom,
> The following changes since commit e29b932aa07fa0226d325b35d96cd4eea0370=
129:
>
>    Merge branch '2023-09-30-Kconfig-updates' into next (2023-10-01 11:54=
:31 -0400)
>
> are available in the Git repository at:
>
>    https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-27=
102023
>
> for you to fetch changes up to 4fd7d27ccb763ce8b836a0e4c5dd005392d38e18:
>
>    test/py: always use autostart on tpm2 selftests (2023-10-27 13:17:21 =
+0300)
>
> The pipeline https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipel=
ines/18327
> showed had no red lights.
>
> Heinrich I did not ignore your reports and I agree with both of your
> observations.  The doc needs to mention EFI and the DT Kconfig options
> can be squashed in the future.  However this is a big patchset with
> a time consuming test procedure.  The changes you requested are
> trivial and we can send them later.  I hope that's fine.
>
> Simon there's one patch you haven't acked/reviewed yet, but I've
> responded to your concerns in the ML.
> The response is here
> https://lore.kernel.org/u-boot/CAC_iWjJL_taKWWEi4kancnQ6Dsg1V5+4hMSvTifc=
dr_aCH-Ykg@mail.gmail.com/
>
> ----------------------------------------------------------------
> Up to now, U-Boot could perform measurements and EventLog
> creation as described by the TCG spec when booting via EFI.
>
> The EFI code was residing in lib/efi_loader/efi_tcg2.c and
> contained both EFI specific code + the API needed to access
> the TPM, extend PCRs and create an EventLog. The non-EFI part
> proved modular enough and moving it around to the TPM
> subsystem was straightforward.
>
> With that in place we can have a common API for measuring
> binaries regardless of the boot command, EFI or boot(m|i|z),
> and contructing an EventLog.
>
> I've tested all of the EFI cases -- booting with an empty
> EventLog and booting with a previous stage loader providing one
> and found no regressions.  Eddie tested the bootX part.
>
> Eddie also fixed the sandbox TPM which couldn't be used for the
> EFI code and it now supports all the required capabilities. This
> had a slight sideeffect in our testing since the EFI subsystem
> initializes the TPM early and 'tpm2 init' failed during some
> python tests. That code only opens the device though, so we
> can replace it with 'tpm2 autostart' which doesn't error out and
> still allows you to perfom the rest of the tests but doesn't
> report an error if the device is already opened.
>
> There's a few minor issues with this PR as well but since testing
> and verifying the changes takes a considerable amount of time,
> I prefer merging it now.
>
> Heinrich has already sent a PR for -master containing
> "efi_loader: fix EFI_ENTRY point on get_active_pcr_banks" and
> I am not sure if that will cause any conflicts, but in any case
> they should be trivial to resolve.
>
> Both the EFI and non-EFI code have a Kconfig for measuring the
> loaded Device Tree.  The reason this is optional is that we
> can't reason when/if devices add random info like kaslr-seed,
> mac addresses etc in the DT. In that case measurements are
> random, board specific and eventually useless.
> The reason it was difficult to fix it prior to this patchset is
> because the EFI subsystem and thus measurements was brought up
> late and DT fixups might have already been applied. With this
> patchset we can measure the DT really early in the future.
>
> Heinrich also pointed out that the two Kconfigs for the DTB
> measurements can be squashed in a single one and that the
> documentation only explains the non-EFI case.  I agree on both
> but as I said this is a sane working version, so let's pull this
> first it's already big enough and painful to test.

I am fine if with adding those changes in a future merge request.

Best regards

Heinrich

>
> I prefer pulling into -next, although as I said, a big portion
> of the changes consists of moving the API around from the EFI
> subsystem to the TPM subsystem.
> ----------------------------------------------------------------
> Eddie James (6):
>        tpm: Fix spelling for tpmu_ha union
>        tpm: sandbox: Update for needed TPM2 capabilities
>        tpm: Support boot measurements
>        bootm: Support boot measurement
>        test: Add sandbox TPM boot measurement
>        doc: Add measured boot documentation
>
> Ilias Apalodimas (3):
>        efi_loader: fix EFI_ENTRY point on get_active_pcr_banks
>        test: use a non system PCR for testing PCR extend
>        test/py: always use autostart on tpm2 selftests
>
>   arch/sandbox/dts/sandbox.dtsi  |   13 +
>   arch/sandbox/dts/test.dts      |   13 +
>   boot/Kconfig                   |   32 ++
>   boot/bootm.c                   |   74 +++
>   cmd/booti.c                    |    1 +
>   cmd/bootm.c                    |    2 +
>   cmd/bootz.c                    |    1 +
>   configs/sandbox_defconfig      |    1 +
>   doc/usage/index.rst            |    1 +
>   doc/usage/measured_boot.rst    |   31 ++
>   drivers/tpm/tpm2_tis_sandbox.c |  100 ++--
>   include/bootm.h                |   11 +
>   include/efi_tcg2.h             |   44 --
>   include/image.h                |    1 +
>   include/test/suites.h          |    1 +
>   include/tpm-v2.h               |  263 +++++++++-
>   lib/Kconfig                    |    4 +
>   lib/efi_loader/Kconfig         |    2 -
>   lib/efi_loader/efi_tcg2.c      | 1055 +++-----------------------------=
--------
>   lib/tpm-v2.c                   |  814 +++++++++++++++++++++++++++++++
>   test/boot/Makefile             |    1 +
>   test/boot/measurement.c        |   66 +++
>   test/cmd_ut.c                  |    4 +
>   test/py/tests/test_tpm2.py     |   20 +-
>   24 files changed, 1492 insertions(+), 1063 deletions(-)
>   create mode 100644 doc/usage/measured_boot.rst
>   create mode 100644 test/boot/measurement.c

