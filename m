Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BACE9E31E
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC91783B64;
	Wed, 11 Feb 2026 16:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gPnRZaQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3E883CB5; Wed, 11 Feb 2026 16:20:10 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FFA283A47
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7947cf097c1so52208947b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770823206; cv=none;
 d=google.com; s=arc-20240605;
 b=gGhNbssZiPuPiw4slxNjm6bxBCM0D7DjvT0zHUSnTQdDOmHHREpDrdbEmpG5334513
 hvozvXNYaEvcj/qn97PtejJNns0WkWNMiay9XhIdX9EBnO051L5Xekdjdli0KYzDgg6c
 7ipGTxEffhl3fdL7UUfenmGUEqIt7ryP15yvnMPEELHPRMnDXfXNLGc43OBXBPsashRr
 aTrzmzVRcd1+5v0OqWWAKMgIm4nHmX0OQaD6x7jo0fERDX0ArYlQyQoL75Q0qgzDaZQp
 NalYCIAouW7kwo4W9gYPN1zBgftfp00c0LJbaw81OSQS39rzCUg8/G09RPVK0GbuXDBV
 01dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kEfgTAbpG1+Ea1TPsuMV7GEglvQq4l5kxdmiZEURMq8=;
 fh=PXrU59RQyK3u+kIJulIDJ/Va5SJK4BLRjXgyGXp4J3o=;
 b=aqIHw1SJpeAr93zVnlaUE03O1tP2wwdd0bWk7GFWVofQni10ycvZNtq2/jvdFmZpRe
 erbLKfRomPdrxeLTml6IdJLUnsP5aQQ8Eoyv24KKLfXiVE8VJcPW4PypD4fybGr5lUNH
 awdXNRwtLcLE0NsPZY/Vz53V/x8qljrt5wOzkHBObhx+BWg/Qr2us8pGkJPwN6WvGo3i
 4HmZwif3EKQW+TGQD1iHumIjLM3ahvVAaYqUtSD0d6vxdKOC4mwZjAi7Xxz/lUKdpY27
 BP0DbmMqGqWXRAwlsHLWR67esY9IuqqpPf7V+d1aLQ82j8AevGqJTAPt0FECtENSm3yu
 BKTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770823206; x=1771428006; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEfgTAbpG1+Ea1TPsuMV7GEglvQq4l5kxdmiZEURMq8=;
 b=gPnRZaQEwu29FL4fxw864k55Hv5zFurFLAqPxYcEmkZ8emOSq5w6zDFiZNPiEhIRgp
 wZDOPzIw05ICSY1eN7k2NcLa8+imBRLqjk4gmivmb8s3bVHEBocpyLw0+UXcDwN3HSVG
 wc1gQmFF7Jo2c6czu/7psnhoboemjSt2mx8z+jimGkABg8iJaOPcUchC+doU9PA3XeQU
 VTIk2uMXTYiBcNDBce7Dp/eYIAhKsIVZ2HMdACy63+zPJVOFW9fXqwT9lHwqabENt/PG
 vd9Mkq0Kh9NFhGkwM1Zpxw7S/RX4UrBtwdj3+Usb+VZPbAmXHRocPzx2ffqwyjnVwxp9
 lFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770823206; x=1771428006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kEfgTAbpG1+Ea1TPsuMV7GEglvQq4l5kxdmiZEURMq8=;
 b=AxDHK+Y9FCLpz2gOleiozSIwZqNkHjxcZE3j6cpGua/OM4F0F+CxcD+sZ+ufvXC0sP
 jX0EVULDvtdRqD1NNVp+Ffox6V9NBGdK+5FiqjPbBrLq4LgB+BkViHSiWfChySfZ9bkQ
 GeE4O+1oCy8wor+48xq1Os+kPkKvEbRz/Em7CcA8wHEgXXYrmNlgX3R0aRsINQev1TGl
 sBS4Eei39afEkKQOJEokOB3WPLSeZHkBJrMCG71l3jiJS5IhpoAFpk2TXLj7op0x0P2U
 a4OT6lnUSyNScBadxUX7/aP2wmdaYL+K+2giIEOi2Gksjd1NrtA47ScwftWYpe3QdzoD
 CSsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyoSq7FwBNx/tDqNigQJM6Hji5ejXWJ/RUg/yCUUJmwkQjVjWaPSRdD8fIaC/vzbEUwWADN4g=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4TeIvn6SsyX+qh9f2ytVeRLXzzf4EJ4zSPl5e3kCRjLVcI83f
 9Wc7RG2UsJyDf89u/0c7gVvtaLqzaEUj8b/s4Zo8mywV4C1Vh9hrJ1C2x3uULrbPvc+ZYy7CICr
 5MnV6oL5eVxGbutTQaYMfQrBm1+Y0mfcjmZWCkZyGew==
X-Gm-Gg: AZuq6aKsVzrCjNlga3xBAevYGjdS9AdeA1N7rKlQZhDAwCmOTKZIgqMOHMdq9IrG8AI
 1ZmHS0h57OezhQQK+LDHbTzH5L+Wedx8jTr00Vrec9HKtj98YPWqGey3+CAYf/5Dii4l522gvcs
 YeRPU68Dt+/+dOIg6jOIVJpP3g+ITgLiFiQfh16DS4h4Qs+Ga7TQrOiavDwa8NRbhx8VdTX6v7P
 VYUmHD5gFKrZNHZ/KXCwYf6uBGooNHzRMEQKlb/W+onhIHmT6eVK1IFGB3SnKecKCtKZI06n8Hz
 kwd91pX/bRj/jwVSSxEJmPcNLLFA6iMOSKg2uwJ1A2+Womo6sDByfc9+zgO/93nixHtqlQDCV1m
 HojO0voz60JgwcaRw0yuUCuXocmeIVfori3GrcPBGewupF5HxUK+ScgJgIZXHWF4uFTjaRe5j5C
 2xMXn8wG3bIgxWW9TznVhh3rsauSH/sgHYDPDITd4FD9qVCc5HThOQjPDVaOvujeFUG+QDfr6Nl
 e4oko7DkIcTRoWbbDo6QS90+9KsdB6ZfIC0TKEEvfAo/ojKfsrwPN9ipEnrqydvaH1CSqpQX76i
 xPd9PqvuSWSCfoKYd8h+ZcGwscbwkmYdAj/g/EZ/id/4
X-Received: by 2002:a05:690c:6211:b0:796:210b:f31b with SMTP id
 00721157ae682-7966ab140ccmr22944037b3.59.1770823205586; Wed, 11 Feb 2026
 07:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
 <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
 <20260204161345.GY2603314@bill-the-cat>
 <CAC_iWj+qEmxNeGVBcLcrzNM=BkVj0QW2VYW6ZNGTKD6BeRTNHA@mail.gmail.com>
 <CAMDkj5yg24MwQz4G8Y62S7mB_6D=p+0Qrooe77RKQ+C4CPwA1Q@mail.gmail.com>
In-Reply-To: <CAMDkj5yg24MwQz4G8Y62S7mB_6D=p+0Qrooe77RKQ+C4CPwA1Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 17:19:29 +0200
X-Gm-Features: AZwV_Qj6o_3hE9NVPiIA9szsLrYQr9OsrJ9grTaiFXtiy1ydxoxrokP1k2Quyrs
Message-ID: <CAC_iWjKUqkjOFsk7+dj+7tn_hrbngoq4CyjCxg0xLbU=-X+GXA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 11 Feb 2026 at 16:30, Raymond Mao <raymondmaoca@gmail.com> wrote:
>
> Hi Ilias,
>
> On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all,
> >
> > Apologies for the late reply.
> >
> > I did test the patches but I see something weird on smbios type 17.
> >
> > Handle 0x0008, DMI type 17, 104 bytes
> > Memory Device
> >         Array Handle: 0x0000
> >         Error Information Handle: Not Provided
> >         Total Width: Unknown
> >         Data Width: Unknown
> >         Size: No Module Installed
> >         Form Factor: <OUT OF SPEC>
> >         Set: None
> >         Locator: <BAD INDEX>
> >         Bank Locator: <BAD INDEX>
> >         Type: Unknown
> >         Type Detail: Other Unknown Fast-paged Static Column
> > Pseudo-static RAMBus Synchronous
> >         Speed: 512 MT/s
> >         Manufacturer: <BAD INDEX>
> >         Serial Number: Not Specified
> >         Asset Tag: Not Specified
> >         Part Number: Not Specified
> >         Rank: Unknown
> >         Configured Memory Speed: Unknown
> >         Minimum Voltage: Unknown
> >         Maximum Voltage: Unknown
> >         Configured Voltage: Unknown
> >         Memory Technology: <OUT OF SPEC>
> >         Memory Operating Mode Capability: None
> >         Firmware Version: Not Specified
> >         Module Manufacturer ID: Bank 3, Hex 0x04
> >         Module Product ID: Unknown
> >         Memory Subsystem Controller Manufacturer ID: Unknown
> >         Memory Subsystem Controller Product ID: Unknown
> >         Non-Volatile Size: 16383 PB
> >         Volatile Size: Unknown
> >         Cache Size: Unknown
> >         Logical Size: Unknown
> >
> > Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> > I tested this in QEMU
> >
>
> I just retested it by below qemu cmd after I rebased it to the current ma=
ster:
> qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu cortex-a57 -m
> 2G  -nographic
>
> Below is the type17 I got:
> ```
> Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
> Memory Device:
> Physical Memory Array Handle: 0x0000
> Memory Error Information Handle: 0xfffe
> Total Width: 0x0000
> Data Width: 0x0000
> Size: 0xffff
> Form Factor: Unknown
> Device Set: 0x00ff
> Device Locator:
> Bank Locator:
> Memory Type: Unknown
> Type Detail: 0x0004
> Speed: 0x0000
> Manufacturer:
> Serial Number:
> Asset Tag:
> Part Number:
> Attributes: 0x0000
> Extended Size: 0x00000000
> Configured Memory Speed: 0x0000
> Minimum voltage: 0x0000
> Maximum voltage: 0x0000
> Configured voltage: 0x0000
> Memory Technology: Unknown
> Memory Operating Mode Capability: 0x0004
> Firmware Version:
> Module Manufacturer ID: 0x0000
> Module Product ID: 0x0000
> Memory Subsystem Controller Manufacturer ID: 0x0000
> Memory Subsystem Controller Product ID: 0x0000
> Non-volatile Size: 0xffffffffffffffff
> Volatile Size: 0xffffffffffffffff
> Cache Size: 0xffffffffffffffff
> Logical Size: 0xffffffffffffffff
> Extended Speed: 0x0000
> Extended Configured Memory Speed: 0x0000
> PMIC0 Manufacturer ID: 0x0000
> PMIC0 Revision Number: 0x0000
> RCD Manufacturer ID: 0x0000
> RCD Revision Number: 0x0000
> ```
>
> If you didn't use smbios_generic.dtsi to insert new nodes, or add new
> 'memory@' / 'memory-controller@' nodes into your DT, you should get
> the same result as mine by default.
> If you still can not get it, can you give me your build instruction
> and qemu cmd for reproducing?

I used qemu_arm64_lwip_defconfig

qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
          -machine virt,secure=3Doff -bios u-boot.bin -chardev
socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
          -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device
tpm-tis-device,tpmdev=3Dtpm0 \
          -device virtio-rng-pci -drive
id=3Dos,if=3Dnone,file=3D../debian.qcow2 -device virtio-blk-device,drive=3D=
os
 is the command line

Cheers
/Ilias


>
> Regards,
> Raymond
>
>
> > Regards
> > /Ilias
> >
> > On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote:
> > >
> > > > Hi,
> > > >
> > > > Anyone have a chance to review this patch set? It is the last piece=
 of
> > > > work to support all required SMBIOS types in U-Boot.
> > >
> > > I've been waiting for Ilias or Heinrich to have time to look at this.
> > >
> > > --
> > > Tom
