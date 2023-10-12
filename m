Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A17CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4038A86F41;
	Thu, 12 Oct 2023 05:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JHcz5Qkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3540886EE6; Thu, 12 Oct 2023 05:46:28 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A6F86ECF
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59e88a28b98so4168627b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082385; x=1697687185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V0JZ06a3RIJjh5gHd2pziip2BP922nCA592Rh8dLJ4k=;
 b=JHcz5Qkq1QzqtWKTCi1FTbUf7ZW4R0uDDKEy9HczC5IdbpQor3eKglgSYU/DgwMoNE
 Lo++T69vIufdAC3nPIfBRlKo6x4V+lLocZdaSOZjb2MB45vLfibbU5L38V4dtPgCQkwu
 UxKkvWHBVPF931pl8YbfBC7G3MmGKx0Ftb/sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082385; x=1697687185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V0JZ06a3RIJjh5gHd2pziip2BP922nCA592Rh8dLJ4k=;
 b=heiEV3uDcy8LGnykeDpsMjIZdrw4FQ4lsXCHZQ6Rj1Ts30ZamE2ESBWl4u8hkGP3aD
 ycu++yR1ly6hx7Sl6zYRrMSVhpCbiXAEIeDONN074HPJX6pRIyoplzH7TcGAMUAmW7Kt
 /Mef+O6IxfIplZfPMwc1s+015K/wflqV7Npye+xr3Bt0D3KivYZzfMPNXt+msfC6Usqf
 Orp9+gLtJRf1ki14Ld6v5aYFh80IumdmdGzYfMUcmhIy849yMYEVKuDW4Kfp2u0vIXXb
 dlZ8BJ1WyuEubIRP6wY3rqTKwb23JizIWXcBlceH41m/yf1wHVmylSgS0mjGd1b+srcN
 sB9Q==
X-Gm-Message-State: AOJu0YyN8641F5ZCz/qrdQkRJCJ7/OLG7INTeq6m5iX4V9S/Z4pl54/A
 McUpUI3iSymEofVXWI0ZC8OmtQ/xFzXV+K/1W/GYmg==
X-Google-Smtp-Source: AGHT+IEtnL7vXXAfsOOGRjL71AYGEMD40gF5oTvK2xp+vWOcLXe9/WS5pHF0GyicrDvmibOv5w26yQfk+i4V300olus=
X-Received: by 2002:a05:690c:88c:b0:570:2542:cc9b with SMTP id
 cd12-20020a05690c088c00b005702542cc9bmr13673434ywb.18.1697082384595; Wed, 11
 Oct 2023 20:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231011202643.9194-1-mibodhi@gmail.com>
In-Reply-To: <20231011202643.9194-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:45:21 -0700
Message-ID: <CAPnjgZ23Wv5Y4TqYm7Lyb5fVvsGSv+nhCaFA4-g1A5uZUA8hzw@mail.gmail.com>
Subject: Re: [PATCH v5] bootstd: sata: Add bootstd support for ahci sata
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
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

On Wed, 11 Oct 2023 at 13:27, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Add ahci sata bootdev and corresponding hunting function.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
> Changes in v5:
> - In bootmeth_script script_boot(), it's unnecessary to check for ret so
> remove it. While we're here, also initialize ret in declaration.
>
> Changes in v4:
> - Revise logic in bootmeth_script() to set devtype to sata for non-scsi
> SATA device
> - Rewrite sata_rescan() logic to properly remove all devices before probing
> - Add description to sata_rescan() header
>
> Changes in v3:
> - Correct drivers/ata/Makefile to compile sata_bootdev only if
> ahci sata is enabled.
>
> Changes in v2:
> - set devtype to sata in bootmeth_script for non-scsi SATA device.
>
>  boot/bootmeth_script.c     | 16 +++++++---
>  drivers/ata/Makefile       |  2 +-
>  drivers/ata/sata.c         | 32 ++++++++++++++++++++
>  drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
>  include/sata.h             |  6 ++++
>  5 files changed, 113 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/ata/sata_bootdev.c

Reviewed-by: Simon Glass <sjg@chromium.org>
