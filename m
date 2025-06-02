Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DFBC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 10:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77809820EB;
	Mon,  2 Jun 2025 12:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n67KjldQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536B98212B; Mon,  2 Jun 2025 12:28:44 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1BA782045
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 12:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-55329bd977aso5296514e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748860121; x=1749464921; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eZdwMTCOnYHESSt2W7ityqntdOkwLvMaMXx3F/rHI1M=;
 b=n67KjldQhWWgbaIuI44pJ+dhyDMydqz0+1CZ+2em2K/izDKsC+nPZGa4HvoeZ5F2xm
 I7eUPXr65BA0l84fxC2gCs2nOsC6WaOgtX0DPJCdc6H8J5pACcR0L5zqiilNOuVr87TD
 aDc7DujD/HrrBDJELrmaMD4wUD21FP+G1ZsI7lZV1EQFMriXcnnqTp8edz+jb5B1RCwh
 oaDnHAd5xhX9InX7956Jol02pLlhHZTcPcEFdnumdbmE3PcxbbZ2puxW3IGqvtSRdcJn
 h4lDpDBz8FKQwIM/n/kfe7iYKU18H0MVMRQ2eBRjrS0ncl2ffuzED3VtOggiuEJC9naU
 g/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748860121; x=1749464921;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eZdwMTCOnYHESSt2W7ityqntdOkwLvMaMXx3F/rHI1M=;
 b=faPWvAX/I/CfHy6eC/m/t0vKD2yFwvW8poVWCD4pHr6ukVQu5m+1jBLim/v8V2bbO3
 Xs2lEuvMR8tNtuWWQu3lbge2W87HtoQJodzeNzvwV77tPlsESpcgIbEZxEbrEAmO1ZYl
 ECPkh/wAwSAEitKFBkl5QWfB1/Izpo0p3AoqcE9kxqFbs/gkA8y7QIT1hcelPV3TxED+
 w8fwME/pMRAbZkDvi73ZOsUEA0DapKAnbX9I72wU6sKWkv0h+mFjUZdpWnjyNAu2duYD
 IYZ64SDZiIXsiTJTLp108R3q1DoE6MNNuTkVL7g7KxjiO4S6fBxytcnq6bAMwSZ+Oe7p
 MOzg==
X-Gm-Message-State: AOJu0YyFk3TX6kePSXot2TlvAAAjQjAxZlBhZoJmjkcvxm3Brzi5SAoW
 oUDrezKoTU6/tFAwJnQvZ84E7DBHGvbUZeUzbmPRp/uu87zuSs8Se3EDt8kiuxXI4j5viwMfxe6
 ZSCQ3KxQ=
X-Gm-Gg: ASbGnctMzppT0OhclOQ5YDmBYXDSxLYr7qKZ/roAFfkHWp1rfyFlC5MSMyT6sPMbcYw
 s3oexyeK446Tp7+beYYmhr8p8M6q/qAIs10GECgC5X0RVlQOiZTZjylIurpsoP+4S9dEJROccz/
 CT/GzzOi+5TxIXAxsWDFajOtmZh6Rov/H2oAe9BIm8ZJ9EsAa6U8Vxu7KDSygDglEITLuaInlcd
 vrQhAGM67LtCZJFi3g5wtz0sAiDUhLCIzSIPl0HQeRi0IAW38YPFu+h07AgzQoTA4OJEIQmYSx9
 glGLYGKFQ4omEZ2NNr6re7oJYtF5LtHL7vejgTBRz6bJP+DLdDYRBLi63+zQQwYNXguUEFSPv/Y
 zUba4v6Jev8R/OjNFUAM=
X-Google-Smtp-Source: AGHT+IHBs8sEoVxBMEvsUVXS1wVdfwPvMj2r942eqboZt4Mw4yOn6AnN4BiOEJWZEUqJ08SBQvfIHQ==
X-Received: by 2002:a05:6512:6c5:b0:553:2760:e82c with SMTP id
 2adb3069b0e04-55335b468b8mr5606621e87.25.1748860120883; 
 Mon, 02 Jun 2025 03:28:40 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5533791cfc3sm1537502e87.201.2025.06.02.03.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 03:28:40 -0700 (PDT)
Date: Mon, 2 Jun 2025 13:28:38 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?iso-8859-1?B?Suly9G1l?= Forissier <jerome.forissier@linaro.org>
Subject: aarch64 u-boot reset loop with qemu USB and KVM
Message-ID: <aD181pYGA_0AqWdz@nuoska>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hey,

As was discussed over yocto/OE-Core mailing list
https://lists.openembedded.org/g/openembedded-core/topic/113306017#msg217258
qemu machine with USB and KVM enabled goes into reset loop with
u-boot. I've tested u-boot 2025.04 and latest master branch 2025.07-rc3
( b22a276f039f818d5564bec6637071cfc8a7e432 ) with qemu_arm64_defconfig
from tree and CONFIG_BLOBLIST disabled since that to has issues with KVM
( https://lists.denx.de/pipermail/u-boot/2025-May/590101.html )-

To reproduce:

 * qemu 10 or 8.2.2, version does not seem to matter

 * aarch64 native machine with KVM support

 * qemu-system-aarch64 command line:

$ qemu-system-aarch64 -machine virt -cpu host -machine gic-version=3 -smp 1 -enable-kvm \
  -m 256 -serial mon:stdio -serial null -nographic -vga none \
  -bios u-boot.bin \
  -device qemu-xhci -device usb-tablet -device usb-kbd

U-Boot 2025.07-rc3 (May 30 2025 - 19:44:05 +0000)

DRAM:  256 MiB
using memory 0x4e662000-0x4f6a2000 for malloc()
Core:  51 devices, 14 uclasses, devicetree: board
Flash: 64 MiB
Loading Environment from Flash... *** Warning - bad CRC, using default environment

In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Register 8001040 NbrPorts 8
Starting the controller
"Synchronous Abort" handler, esr 0x96000010, far 0x10100040
elr: 000000000005a360 lr : 000000000005a344 (reloc)
elr: 000000004f6fc360 lr : 000000004f6fc344
x0 : 0000000010100040 x1 : 0000000000000001
x2 : 0000000000000000 x3 : 0000000000003e80
x4 : 0000000000000038 x5 : 000000004e66fed2
x6 : 0000000000000000 x7 : 0000000000000000
x8 : 0000000000000000 x9 : 000000000001869f
x10: 000000000000000d x11: 0000000000000006
x12: 000000004e561a68 x13: 000000004e561dd0
x14: 0000000000000002 x15: 0000000000000000
x16: 000000004f6ee774 x17: 0000000000000000
x18: 000000004e661dd0 x19: 000000004e670480
x20: 0000000000000000 x21: 0000000010100040
x22: 0000000010100000 x23: 0000000000000000
x24: 0000000000000000 x25: 0000000000000000
x26: 0000000000000000 x27: 0000000000000000
x28: 0000000000000000 x29: 000000004e670360

Code: d5033fbf aa1503e0 5287d003 52800002 (b8004401)
Resetting CPU ...

resetting ...

With KVM disabled, or the qemu USB devices disabled, boot with u-boot prompt and
to full target system works.

Cheers,

-Mikko
