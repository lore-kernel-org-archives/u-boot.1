Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5360BC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 08:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA9687B2F;
	Thu, 26 Oct 2023 10:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MU7CsiN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE2887B2A; Thu, 26 Oct 2023 10:07:21 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9017C87B03
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 10:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507a55302e0so664800e87.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698307639; x=1698912439; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lhOlHuzQgmtnC7EGO5yRu9vwoBL+5uNHE0AvEMnwPJ8=;
 b=MU7CsiN4SeEwMkPDDmrhWOZEcJCFWiRNAboeCS0aq1zzmz24+IBK02+KvrG92ZIKVk
 RHzl4cXZcg7YiNCE5VKan+ZqArp9BnkkkuH0Dzh5pmXzCOsX+DX+BxttoVFDw5xAxvdc
 hDLdeM6HQXONHe3EwM6SxLA3vgTcrpt3CogYqM0JM7+FOQUGDCiS5c2hFZyL9JAeHXcT
 MksnGBdBfoO9VVwCO1UM/ek9ZKWDvj/Ju/Gk+SC7XJZGIMZKrUwo94xT2bBGq6AwdoJg
 4A5e6TCEwsFs7D56D2uBb9z2bjj1p9Ojp0dRHbGMlks6BLOkrmtGEptaNU3ymnedhZlY
 nojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698307639; x=1698912439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhOlHuzQgmtnC7EGO5yRu9vwoBL+5uNHE0AvEMnwPJ8=;
 b=XMWyI2VnrQSpD9DyscaErw75vfRprJAf0ZKG7x6/VUw70FG9CSt6Zf7sb6aAddewqe
 cuxDzlJW+i5qhKk4UYH+V7AbVvzyoCSCSjPfP6xSAfJgLkGJhuKiAwXWaEA805fnFraC
 VUNoBKgNpRnUhCiW0yoKGrP/rGH33MAlU/eRlmM2jAzH/WGXpU26CuHV8PoQcxUTHszf
 hGeBnJRTsFcb7FGCeWueVqkDMCfoLvkfj+qeYSKdo4BuLwxj665DrjPaahLI3LFNq50H
 WVqBjjeC6ZYssEL+nAc6fJXrnd8m83HMCTwfAGDQNoJ7PAHHMT+Jzn5euVnF78bIAo4r
 SwHw==
X-Gm-Message-State: AOJu0YzT6ttAu5WULDMTmaBnE4B0zmDizCldH1b72VtJIGY9VFN9pKku
 8OubU19C3IAP4nCKArkyd54svT78MwG3t5JG4EooeNNCTlQRbQedE8U=
X-Google-Smtp-Source: AGHT+IEB40ZB9iU8x0Hm0EqNdzZPiQf7wVrpU2zOq6hGP1MtcWo7o72dx+GVHHtF0YTFurjo+38l1Esymv31Q8aIxxM=
X-Received: by 2002:ac2:5456:0:b0:507:b074:ecd4 with SMTP id
 d22-20020ac25456000000b00507b074ecd4mr11990719lfn.7.1698307638695; Thu, 26
 Oct 2023 01:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231025072525.3960316-1-ilias.apalodimas@linaro.org>
 <CAPnjgZ0swsWDbxCNMURdkRoby1tDLK5LT4aRGNBCNnOKCNyJ1Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ0swsWDbxCNMURdkRoby1tDLK5LT4aRGNBCNnOKCNyJ1Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Oct 2023 11:06:42 +0300
Message-ID: <CAC_iWjJL_taKWWEi4kancnQ6Dsg1V5+4hMSvTifcdr_aCH-Ykg@mail.gmail.com>
Subject: Re: [PATCH] test/py: always use autostart on tpm2 selftests
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
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

Hi Simon,

[...]

> > ---
> >  test/py/tests/test_tpm2.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> > index 47392b87a98f..1d654cd4a23b 100644
> > --- a/test/py/tests/test_tpm2.py
> > +++ b/test/py/tests/test_tpm2.py
> > @@ -61,7 +61,7 @@ def test_tpm2_init(u_boot_console):
> >      skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> >      if skip_test:
> >          pytest.skip('skip TPM device test')
> > -    u_boot_console.run_command('tpm2 init')
> > +    u_boot_console.run_command('tpm2 autostart')
> >      output = u_boot_console.run_command('echo $?')
> >      assert output.endswith('0')
> >
> > @@ -100,7 +100,7 @@ def test_tpm2_sandbox_self_test_full(u_boot_console):
> >      """
> >      if is_sandbox(u_boot_console):
> >          u_boot_console.restart_uboot()
>
> We should not need this. Can you please take a look at what reset is
> needed in the TPM code to get the TPM back into its original state? We
> have dm_test_pre_run() which could call a tpm_reset_for_test()
> function, or similar.

We do need this once I land Eddie's patches [0].  The problem is not
related to reset sequences or what's needed on the TPM. Before this
patchset, the sandbox TPM lacked a bunch of capabilities and we
couldn't test UEFI measured boot.

Eddie added those missing capabilities and since the EFI subsystem
comes up, it also initializes the TPM.  As a result 'tpm2 init' will
see the device in open state and return -EBUSY, but that's *not* an
actual error.

So instead of playing around with ordering of tests and failing if
someone initialized the TPM early or whatever we should just use
tpm_auto_start which
- Does the right thing and gracefully handles that -EBUSY
- Still allows you to run the remaining sequence of a TPM
initialization -- tpm2 startup TPM2_SU_CLEAR && tpm2 self_test full

[0] https://lore.kernel.org/u-boot/20231024154354.197524-3-eajames@linux.ibm.com/

For reference here's the sandbox output, compiled with
sandbox64_defconfig with Eddie's patches applied

U-Boot 2024.01-rc1-00043-g3ecf75343640-dirty (Oct 26 2023 - 10:57:54 +0300)

Reset Status: WARM Reset Status: COLD
Model: sandbox
DRAM:  256 MiB
using memory 0x1b513000-0x1f515000 for malloc()
[nvmxip-qspi1@08000000]: the block device blk#2 ready for use
[nvmxip-qspi2@08200000]: the block device blk#2 ready for use
Core:  260 devices, 92 uclasses, devicetree: board
WDT:   Not starting wdt-gpio-toggle
WDT:   Not starting wdt-gpio-level
WDT:   Not starting wdt@0
MMC:   Can't map file 'mmc1.img': Invalid argument
mmc1: Unable to map file 'mmc1.img'
Can't map file 'mmc1.img': Invalid argument
mmc1: Unable to map file 'mmc1.img'
mmc1 - probe failed: -1
mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argument
mmc1: Unable to map file 'mmc1.img'
, mmc0: 0 (SD)
Loading Environment from nowhere... OK
In:    serial,cros-ec-keyb,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: sandbox
Net:   eth0: eth@10002000, eth5: eth@10003000, eth3: sbe5, eth6:
eth@10004000, eth8: phy-test-eth, eth4: dsa-test-eth, eth2: lan0,
eth7: lan1
Can't map file 'mmc1.img': Invalid argument
mmc1: Unable to map file 'mmc1.img'
No EFI system partition    <-------- UEFI subsystem init
No EFI system partition
Failed to persist EFI variables
EFI using ACPI tables at b746000
Hit any key to stop autoboot:  0

Thanks
/Ilias
>
> > -        u_boot_console.run_command('tpm2 init')
> > +        u_boot_console.run_command('tpm2 autostart')
> >          output = u_boot_console.run_command('echo $?')
> >          assert output.endswith('0')
> >
> > --
> > 2.37.2
> >
>
> Regards,
> Simon
