Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D56E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 21:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66EE89572;
	Thu,  5 Dec 2024 22:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fb2+/1bL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 113D789572; Thu,  5 Dec 2024 22:30:58 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBBD89574
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 22:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee990ba9d5so1021804a91.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 13:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733434254; x=1734039054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bUjg5QXuPVhbY0VarXxlgU78mltramXV51c5CijLD4g=;
 b=Fb2+/1bL5vVCF8elPvpYVoOiFOI4oG+TAn0zcdSA5ngRJ5roCvUMEJhseP+tFO3piK
 UBpTxaZRvFnjoIegcA939zkkAZp+HdznV7wbRHGzBKyuT2e9bygLJhR3Oop4c6xS8xf1
 cN3FY3XLce5+Kf3AZGWAhYOIwOxHtIKqVVXvkwDrr2ny1w2OOLyiBG/fIBsRwFXG+IUH
 CkV4OD0hS/UKplEGqvNh0b05ZrgojUuNHwuvpV2ohLHt1UkLTqkmKktxJuz1Q6RU+6c0
 NQrJkq9dfsiEkKtR/xGkQwUWMmlOpeYjmAA/9+3vO+WyFerDmLSeOhV4EZ4sIIlaOhjA
 7oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733434254; x=1734039054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUjg5QXuPVhbY0VarXxlgU78mltramXV51c5CijLD4g=;
 b=ZinWq+Mxu65ag72C03Irx02621RLJVjDGnUnzRSZFx7r52DtS/KYxoOqHib6HdhQBS
 /uKbKKVf1eN1uGoRQF3ERHilZPu87ZJwkMVydUUcbdnMKi8CuWNUKj8nwEj+L/pMKqHP
 Z+Lq2yhHV829CX6ycQN3TBwidTfzC17co2VdQRfBqphpZIM5/3wDSbqHcavsl3zFg6QM
 QE4+g9J0xe+P1Z5GxMG3up2OvRAD+xsqUasXavbYFRWkUdudWBgbPv+Wf1y2f7CLfcNX
 gpjnaWRvi8zLMLpYu8w1nbw9XlWIlRJRhl2mRG7WvBslz019PQ7d1BpAw5ex0QZZF0kZ
 69uQ==
X-Gm-Message-State: AOJu0YzmL5+xSStzYhkLbMeRnq1+l5AWaZi3Kw6zyrNRPvLHGBAdfJeV
 WlVyQ5gVRQ7jMtZZY20meRu3Yc48Y38+/VaJyFnvLuhcppdGL7zsrCy4/KDwqrQS4Mq+q7lpxDD
 y4zOyt8uX5eaMuJC7zI35GkQR8r8=
X-Gm-Gg: ASbGncucsuLQWvn97fLOAotoOduQ1wjCqsZR5pnVGyRSyKKJ8b0WwkhAyr6KraS6UgU
 XEW21PRoinzhfmzg2iaY98yN6ufsqfg==
X-Google-Smtp-Source: AGHT+IHdn+4NgyIc8ThIC5CcAx+CUO3jt/29amekZFr6kssMF+20paPkPmcc7xY2KoMsdn6vzhXf/20K+7l2lqkbV2Y=
X-Received: by 2002:a17:90b:380f:b0:2ef:316b:53fe with SMTP id
 98e67ed59e1d1-2ef6a6baf26mr1011504a91.22.1733434253722; Thu, 05 Dec 2024
 13:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20241204030530.2099776-1-adrianox@gmail.com>
 <20241204030530.2099776-8-adrianox@gmail.com>
 <20241205013018.GA1377816@bill-the-cat>
 <38d341ba-7690-496e-bace-60604219f174@gmx.de>
 <20241205151924.GL2457179@bill-the-cat>
 <a6650f01-b3c5-4a16-863f-33e441ef6e44@gmx.de>
In-Reply-To: <a6650f01-b3c5-4a16-863f-33e441ef6e44@gmx.de>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Thu, 5 Dec 2024 18:30:42 -0300
Message-ID: <CAMGU2hUW9JKUjvnMWg6BVxwjr5x06d24r-fzygETqZFjjeWyqw@mail.gmail.com>
Subject: Re: [PATCH v7 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich and Tom, thanks. I reproduced it in qemu too, there was a
mistake in the way I was setting the network device path.
I will send a patch.

Best,
Adriano

El jue, 5 dic 2024 a las 15:06, Heinrich Schuchardt (<xypron.glpk@gmx.de>)
escribi=C3=B3:

> On 05.12.24 16:19, Tom Rini wrote:
> > On Thu, Dec 05, 2024 at 10:00:11AM +0100, Heinrich Schuchardt wrote:
> >> On 05.12.24 02:30, Tom Rini wrote:
> >>> On Wed, Dec 04, 2024 at 12:05:23AM -0300, Adriano Cordova wrote:
> >>>
> >>>> Set the device path of the efi boot device to an HTTP device path
> >>>> (as formed by efi_dp_from_http) when the next boot stage is loaded
> >>>> using wget (i.e., when wget is used with wget_info.set_bootdev=3D1).
> >>>>
> >>>> When loaded from HTTP, the device path should account for it so that
> >>>> the next boot stage is aware (e.g. grub only loads its http stack if
> >>>> it itself was loaded from http, and it checks this from its device
> path).
> >>>>
> >>>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> >>>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>
> >>> I know this is applied now, but after re-checking some things in one =
of
> >>> my labs, this breaks test_efi_helloworld_builtin on rpi_3 at least (a=
nd
> >>> possibly others). There is no output from "bootefi hello".
> >>>
> >>
> >> Hello Tom,
> >>
> >> None of the Raspberry Pi 3 related defconfigs enables bootefi hello:
> >>
> >> rpi_3_32b_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
> >> rpi_3_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
> >> rpi_3_b_plus_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
> >> rpi_arm64_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
> >>
> >> Which configuration have you been testing?
> >>
> >> Please, supply the .config and the related test log.
> >>
> >> I just tested pinea64-lts_defconfig with CONFIG_CMD_BOOTEFI_HELLO=3Dy =
and
> get
> >>
> >> =3D> bootefi hello
> >> Card did not respond to voltage select! : -110
> >> Booting /MemoryMapped(0x0,0xbdfbe9b0,0xbdfc1b60)
> >> Hello, world!
> >> Running on UEFI 2.10
> >> Firmware vendor: Das U-Boot
> >> Firmware revision: 20250100
> >> Have device tree
> >> Load options: <none>
> >> File path: <none>
> >> Boot device: /MemoryMapped(0x0,0xbdfbe9b0,0xbdfc1b60)
> >>
> >> So there seems to be no generic problem.
> >
> > For testing as much as possible, I do enable a number of additional
> > options (as well as building them with clang). In this case, please try
> > also enabling CONFIG_CMD_WGET. I've narrowed my config changes down to
> > adding both CONFIG_CMD_BOOTEFI_HELLO=3Dy and CONFIG_CMD_WGET=3Dy to
> > rpi_3_defconfig which results in:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > platform linux -- Python 3.11.2, pytest-6.2.5, py-1.11.0, pluggy-0.13.0
> > rootdir: /home/trini/u-boot/u-boot/test/py, configfile: pytest.ini
> > plugins: forked-1.6.0, xdist-2.5.0
> > collected 478 items / 424 deselected / 54 selected
> >
> > test/py/tests/test_efi_fit.py s
> [  1%]
> > test/py/tests/test_efi_loader.py .....F
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > _________________________ test_efi_helloworld_builtin
> __________________________
> > test/py/tests/test_efi_loader.py:208: in test_efi_helloworld_builtin
> >      assert expected_text in output
> > E   AssertionError: assert 'Hello, world' in ''
> > ----------------------------- Captured stdout call
> -----------------------------
> > U-Boot> bootefi hello
> > U-Boot>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D short test summary info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > SKIPPED [1] test/py/conftest.py:620: .config feature "fit" not enabled
> > FAILED test/py/tests/test_efi_loader.py::test_efi_helloworld_builtin -
> Assert...
> > !!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures
> !!!!!!!!!!!!!!!!!!!!!!!!!!!
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 failed, 5 passed, 1 skipped, 424 de=
selected in 27.01s
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
>
> Hello Adriano,
>
> The following command sequence reproduces the problem on my Raspberry Pi =
3:
>
> U-Boot> setenv autoload no
> U-Boot> dhcp
> lan78xx_eth Waiting for PHY auto negotiation to complete...... done
> BOOTP broadcast 1
> DHCP client bound to address 192.168.1.83 (109 ms)
> U-Boot> setenv autoload yes
> U-Boot> tftpboot 192.168.1.2:/arm64/helloworld.efi
> lan78xx_eth Waiting for PHY auto negotiation to complete...... done
> Using lan78xx_eth device
> TFTP from server 192.168.1.2; our IP address is 192.168.103.83
> Filename '/arm64/helloworld.efi'.
> Load address: 0x1000000
> Loading: ##################################################  4.4 KiB
>           198.2 KiB/s
> done
> Bytes transferred =3D 4480 (1180 hex)
> U-Boot> bootefi $loadaddr
> Card did not respond to voltage select! : -110
> Booting /\arm64\helloworld.efi
> Hello, world!
> Running on UEFI 2.:
> Have device tree
> Load options: <none>
> U-Boot> wget 192.168.1.2:/hweb/arm64/helloworld.efi
> lan78xx_eth Waiting for PHY auto negotiation to complete...... done
> HTTP/1.1 200 OK
> Packets received 7, Transfer Successful
> Bytes transferred =3D 4480 (1180 hex)
> U-Boot> bootefi $loadaddr
> Booting /\hweb\arm64\helloworld.efi
> Hello, world!
> Running on UEFI 2.:
> Have device tree
> Load options: <none>
> U-Boot> bootefi hello
> U-Boot>
>
> I was not able to reproduce the problem with only TFTP or only wget.
>
> qemu_arm64_defconfig shows the same issue.
>
> efi_install_multiple_protocol_interfaces() called in efi_run_image()
> returns EFI_ALREADY_STARTED.
>
> With a debug message enabled we get this output:
>
> Path /MemoryMapped(0x0,0x7f762d10,0x7f765ec0) already installed
>
> We have to these things to check:
>
> * Why do we miss to uninstall the memory device-path when executing
> 'bootefi $loadaddr'?
> * Why do we generate a memory device-path for either TFTP or wget?
>
> Best regards
>
> Heinrich
>
