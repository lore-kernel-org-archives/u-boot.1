Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8E9C0218A
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 00:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A892581101;
	Wed, 29 Jan 2025 01:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YBLXZiZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C0181111; Wed, 29 Jan 2025 01:23:37 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D93810FE
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 01:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso8753464a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 16:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738110214; x=1738715014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5qvx4126eME5ZeBrkiNShBll57SG8EXBa9k99CTtbms=;
 b=YBLXZiZFF4jGYIuNluWEaQmrEMCYs9KQ/BrA209P2t7BiNqpcAAZmjUoqUWtP7qV6I
 DPDDOMzUUlw9DSsGaPvfyRjCDppo2FGRejTbfp7Oz3JsKPdpZmiFgZV7LEitU0OLWgFc
 QKQGo78sWkiO74Czu2zZJJCnSv8tWVLs7c9Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738110214; x=1738715014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5qvx4126eME5ZeBrkiNShBll57SG8EXBa9k99CTtbms=;
 b=RO6hdiRkh3IKPwL/d0Whef2Z4miEAG4li+YKkCmtzhW6hbXua9yJK9ZXCn0nN/NC6a
 ax5D6QzKENnemJbcTBKQ61l+EZ1VGwYeG999rUEkWFsN6WSoVpCh1o+NRlVQNq2Tm3Vu
 5DGEH2HdjMC9mUcCa1SHmKKk50Xqp8CcH4B8U4QWdkm67dM95456OdDlKg8uK8mbA66Z
 Cu92YcTrURHcYp6K0GKjlxeu8iq8PtlR5sRauYAnG0ddvyE9qziBj3Y5tK/BdzCBVW6i
 iJIg2yJCqauRH0oP+lnCyn6qgafV1YNGtDZWD8NzByz/LuhoY0ash3ANxjl1uKR1O+rn
 mhew==
X-Gm-Message-State: AOJu0YyEAM7PBOLKJm0/uuXNCb3MienP1N7AEAdhVRNCYJyu2U5NfS9N
 ql/mmQ1b+Pj1NLiU55KjrDNpqIKOyzmH2GFWKBUGr3EoklFF45vUv5sDLA7thISx0EzammCsdCA
 Jx8efvlyQcvmvOjEXTy1bvkiYhtSt7wLqOrNt2RaezATRwR7jiQ==
X-Gm-Gg: ASbGnctbfEaftAbGjLyGQ8Xv6od9Fc5h90FHykkpCqSgWwUH0+KkSgfIKwe17gRjVS8
 5TsJvzsgHJI6x7XyV/HyCRU2/Syxfvj6g3eYcxSnW7i2fRMmxCcYTSa1DW3OerYliMQJYaL8tfw
 ==
X-Google-Smtp-Source: AGHT+IEHouvQz3j++Lq+te6w7hkBgMnr+7VjSYEUaYMpQHU13DoDxcKz7dA3gbjOnnvUcGDc0eWFYaqU2DpaYSHEIrU=
X-Received: by 2002:a05:6402:5022:b0:5dc:57a5:c414 with SMTP id
 4fb4d7f45d1cf-5dc5effc37fmr794579a12.30.1738110214518; Tue, 28 Jan 2025
 16:23:34 -0800 (PST)
MIME-Version: 1.0
References: <CH0PR18MB5484C3C43C708D756817728ACBEC2@CH0PR18MB5484.namprd18.prod.outlook.com>
In-Reply-To: <CH0PR18MB5484C3C43C708D756817728ACBEC2@CH0PR18MB5484.namprd18.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jan 2025 17:23:22 -0700
X-Gm-Features: AWEUYZkxjJNDqi388HcN7LtoJLpHCZ3DkaQRZywjt0ildyoQuj54CvrlMHil9G0
Message-ID: <CAFLszTjL9i1jLDs6=vvq_nmNHadXaU49h4Cj8sDoX1J__qN12A@mail.gmail.com>
Subject: Re: Current u-boot crashes on sandbox build
To: Scott Franco <sfranco@axiado.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Scott,

On Mon, 27 Jan 2025 at 12:24, Scott Franco <sfranco@axiado.com> wrote:
>
> scott-franco@scott-franco-ThinkPad-P15-Gen-2i:~/projects/u-boot$ ./u-boot
> Bloblist at b000 not found (err=-2)
>
>
> U-Boot 2024.10 (Jan 24 2025 - 17:24:46 -0800)
>
> DRAM:  256 MiB
> Core:  28 devices, 14 uclasses, devicetree: board
> NAND:  0 MiB
> MMC:
> Loading Environment from nowhere... OK
> Warning: device tree node '/config/environment' not found
> In:    serial
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Net:   No ethernet found.
>
> Hit any key to stop autoboot:  0
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------  ----------------
> Scanning global bootmeth 'efi_mgr':
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> Missing RNG device for EFI_RNG_PROTOCOL
> Hunting with: simple_bus
> Found 2 extension board(s).
> Hunting with: mmc
> Hunting with: nvme
> Hunting with: qfw
> Hunting with: scsi
> scanning bus for devices...
> Hunting with: spi_flash
> Hunting with: virtio
> Scanning bootdev 'qfw_sandbox.bootdev':
> Segmentation fault (core dumped)
>
> Host details:
>
> Ubuntu 24.04 LTS
> scott-franco-ThinkPad-P15-Gen-2i
>
> Build:
>
>
> make sandbox_defconfig
>
> The failure was seen on release versions back until v2024.01, which worked.

Thanks for the report.

Are you definitely using this source?

f919c3a889f (HEAD, tag: v2024.10) Prepare v2024.10

I am not seeing the crash on Ubuntu 24.04:

$ /tmp/b/sandbox/u-boot
Bloblist at b000 not found (err=-2)


U-Boot 2024.10 (Jan 28 2025 - 17:19:42 -0700)

DRAM:  256 MiB
Core:  28 devices, 14 uclasses, devicetree: board
NAND:  0 MiB
MMC:
Loading Environment from nowhere... OK
Warning: device tree node '/config/environment' not found
In:    serial,cros-ec-keyb,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Net:   No ethernet found.

Hit any key to stop autoboot:  0
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
----------------
Scanning global bootmeth 'efi_mgr':
No EFI system partition
No EFI system partition
Failed to persist EFI variables
Missing TPMv2 device for EFI_TCG_PROTOCOL
Missing RNG device for EFI_RNG_PROTOCOL
Hunting with: simple_bus
Found 2 extension board(s).
Hunting with: mmc
Hunting with: nvme
Hunting with: qfw
Hunting with: scsi
scanning bus for devices...
Hunting with: spi_flash
Hunting with: virtio
Scanning bootdev 'qfw_sandbox.bootdev':
loading kernel to address 1000000 size 63a1 initrd 2000000 size 7ffd
  0  qfw          ready   qfw          0  qfw
** Booting bootflow 'qfw' with qfw
Booting is not supported on the sandbox.
Unrecognized zImage
Boot failed (err=-5)
  1  sandbox      ready   qfw          0  <NULL>
** Booting bootflow '<NULL>' with sandbox
Boot method 'sandbox' failed and will not be retried
Hunting with: ide
Hunting with: usb
No USB controllers found
Hunting with: ethernet
No ethernet found.
No more bootdevs
---  -----------  ------  --------  ----  ------------------------
----------------
(2 bootflows, 2 valid)
=>


Could you please try running with gdb to see where the problem is?

Regards,
Simon

>
>
