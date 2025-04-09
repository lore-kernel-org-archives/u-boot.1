Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4037BC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 14:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95184829E2;
	Wed,  9 Apr 2025 16:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="NymGBRAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33995836C3; Wed,  9 Apr 2025 16:52:19 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72EDA81FC6
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 16:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e702cffe590so878693276.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1744210335; x=1744815135;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPPoEVDu2lSjXUvIQrBvJIVl/6YILLeBFR/Z9zIagmc=;
 b=NymGBRAFN8DRaK/sst/e5U4mA0XelAnsTfZHXn+Ydg8yT1If4541Xuf3B/RIomBmhB
 KiAqMxydIEqkvXOCgWnUe/ojgo/qmAB5Gg3SXflu6/63NKmiPdMKLNnpNDemLX07iyZl
 7Uud3WmwvvonQSnK0t4EfAc3ott0i18tanW6W72sT4rH+wf9vmDFmlOpy21L487nwDvY
 h3z2N+1aHFtMBL5eq3IWaQbovBOFclY9nXpNUQL3bioK0IkBA9wPhH9g43+Fu/9Undg2
 jQMXNc6BADEoICPHI2Z4RGUONMJm91oflZjtGrjvpPglYZgQr/NPfe93rwO48aEf9E+p
 ovIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744210335; x=1744815135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPPoEVDu2lSjXUvIQrBvJIVl/6YILLeBFR/Z9zIagmc=;
 b=Bt66SJyTvCQ43PLP0O446QulxwVQp+OABLkACHv1sO29RsCP8aUuvPI0C6YKklfvf2
 DcJhDek4uDT+hYQGxSqXpXnIj0qPj53ca0bDx6vsQcWhW6T1/fUyKkdKbT30QHOTiEG/
 SCGms4oG+KGCfF6d7aXWTSSnEIOM/q5GdN1QGBR8ZH7hmR2Q468usAE7oK9zyzt6qTnQ
 G2bjDR9b5EbCXNw37zM/eR/c8Ys3bGrGVSDWFlaoJMLWYiNqAWVT3SORiL/9a77wUsRM
 lsD/g5022Bc3LbetM7spA6SQtNegL+hnaBYPJIM46UUaarb5/OgOQ6rNS1zwp67NqlrX
 qwXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDj+/CKBt3eotdr/qnwCzCH9W77ra97FCtv8+2akrmP6sZuAofFLlvnbHwp0WPi90QV87vFww=@lists.denx.de
X-Gm-Message-State: AOJu0YziOdKs98xp7mn+LZHmlGOsOqtXezbvlgUDnVwX2TNo+AWNQOn0
 bP3SST/yCmcko8tooW8y09EwYlMFGp9SsrCI6mOOD/8m1akT87m0qQ9lXzdVffCsiR8qlUHAly0
 DTw7/m5eQo8ZDOc6cFgXkzxjUoa/8aJtzA7Uw
X-Gm-Gg: ASbGncvYtjgC7OXBpd8NXK3g/hq+uLz8XinII5GD+Q2wqR9vki09RwLBZlZVi/Ydq2g
 nWXEkV1hu6FsjBI8irqwEVNjupp0CB1QhEpWm/mB+K/dxvQfiTb/WNyEPWrURLHBCpABOwi7urd
 +bboPPNXZ0fiDt+exin3wxghI=
X-Google-Smtp-Source: AGHT+IFH6SU3aWwVVOTfaWzgFSMFpWaeRDfZlVtPE4S+OwJICYKGDsDVFbuS5sd6/qd/rdIXdbJ8hIXKy5guKLXSqL0=
X-Received: by 2002:a05:6902:250:b0:e6d:f8d3:5ee3 with SMTP id
 3f1490d57ef6-e702f079bb3mr3702386276.39.1744210334779; Wed, 09 Apr 2025
 07:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250226223547.393611-1-j-humphreys@ti.com>
In-Reply-To: <20250226223547.393611-1-j-humphreys@ti.com>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 9 Apr 2025 16:52:04 +0200
X-Gm-Features: ATxdqUHp0ngAEfZiVN6ND4FplX3qBkLq0xCi5pYoliK_wdSlz8VNprLh-CCM1pQ
Message-ID: <CAHTX3dJ2cCVZC1ph6PMbrTNOSTg9RFabn4+y_g3RxuZo=YSgew@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] EFI Capsule update explicitly sets dfu_alt_info
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski <lukma@denx.de>,
 s-vadapalli@ti.com, u-boot@lists.denx.de
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

Hi,

st 26. 2. 2025 v 23:36 odes=C3=ADlatel Jonathan Humphreys
<j-humphreys@ti.com> napsal:
>
> For capsule update, explicitly set the dfu_alt_info environment variable
> before the DFU operation, and then restore it to the original value.
> Previously, the dfu_alt_info environment variable was set with the
> set_dfu_alt_info() function.
>
> The problem with setting the capsule update's dfu_alt_info setting in
> set_dfu_alt_info() is that set_dfu_alt_info() lacks the context of what D=
FU
> operation is being performed (eg, capsule update, DFU boot, listing the
> alt_info, etc) so the capsule update setting was overwriting the setting
> for other DFU operations.
>
> Changes from v1:
> - use log_err() instead of pr_err()
> - create a local copy of the original dfu_alt_info environment variable t=
o
>   be used to later restore it, rather than just a pointer to the stored
>   value, because changing its value to the EFI capsule update setting wil=
l
>   cause the original string location to be freed.
> - even in the case of a DFU operation error, restore the dfu_alt_info
>   environment variable to its original value.
> - return EFI_EXIT based error codes if setting environment variables fail=
s
> Link to v1: https://lore.kernel.org/r/20250203215351.2840144-1-j-humphrey=
s@ti.com
>
> Changes from v2:
> - add patch for xilinx boards to set the dfu_string member with the creat=
ed
>   dfu_alt_info string for capsule updates
> Link to v2: https://lore.kernel.org/r/20250206154719.3032322-1-j-humphrey=
s@ti.com
>
> Changes from v3:
> - in case that the dfu_alt_info env variable is set and we save a copy
>   using strdup(), check that strdup() doesn't fail
> - separate the reporting of an error due to the DFU operation from failur=
e
>   to restore the dfu_alt_info environment variable. In the latter case,
>   just emit a warning and return success for the DFU operation.
> Link to v3: https://lore.kernel.org/r/20250213195351.3518305-1-j-humphrey=
s@ti.com
>
> Tested-by: Michal Simek <michal.simek@amd.com>
>
> Jonathan Humphreys (2):
>   efi_firmware: set EFI capsule dfu_alt_info env explicitly
>   board: remove capsule update support in set_dfu_alt_info()
>
> Michal Simek (1):
>   xilinx: dfu: Fill directly update_info.dfu_string
>
>  board/beagle/beagleboneai64/beagleboneai64.c  |  8 ---
>  board/beagle/beagleplay/beagleplay.c          |  8 ---
>  .../aml-a311d-cc/aml-a311d-cc.c               |  2 -
>  .../aml-s805x-ac/aml-s805x-ac.c               |  2 -
>  .../aml-s905d3-cc/aml-s905d3-cc.c             |  2 -
>  board/phytec/common/k3/board.c                |  8 ---
>  board/ti/am62px/evm.c                         |  8 ---
>  board/ti/am62x/evm.c                          |  8 ---
>  board/ti/am64x/evm.c                          |  8 ---
>  board/ti/j721e/evm.c                          |  8 ---
>  board/ti/j784s4/evm.c                         |  8 ---
>  board/xilinx/common/board.h                   |  3 +
>  board/xilinx/versal/board.c                   | 16 +++---
>  board/xilinx/zynq/board.c                     | 16 +++---
>  board/xilinx/zynqmp/zynqmp.c                  | 16 +++---
>  lib/efi_loader/Kconfig                        |  2 -
>  lib/efi_loader/efi_firmware.c                 | 56 ++++++++++++++++---
>  17 files changed, 72 insertions(+), 107 deletions(-)
>
> --
> 2.34.1
>

Is anybody going to take this series?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
