Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C228EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EDE890E8;
	Tue, 10 Sep 2024 20:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YLLLZcO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A82890E8; Tue, 10 Sep 2024 20:41:15 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426B689037
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-846cfc2f010so1483534241.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725993672; x=1726598472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LGftHqyaoM/9XbBsJI8xgkXp+OwOpck19eST1REM1lE=;
 b=YLLLZcO1zUWnjFEls/utH7wjClV76jtC5Ch4dKGC24X+MuzLtq4wIV3bgvct+wubYX
 RYKbCkohIu01FdMkMUJKhHIwyXi4aXggDTwHIYAXeT+RN7hXF11mVVhCZIDuS1pQ6NSn
 qozorsbk7HJ1s2QIGnrM7+uKGEF5WTNdcieeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993672; x=1726598472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGftHqyaoM/9XbBsJI8xgkXp+OwOpck19eST1REM1lE=;
 b=AokLXnNXBOSZM9im1A9sQ8KW6ovmZiOPruqemsn0QDh8GI2rG0k+37kfRKSNNCrJCS
 ia5CUSGmTUI/dHtOgGR0c7gKn5EiSvdNKDpV0zBxq1oUN4ZftYPt3ymMoaiG+Y2Rpttz
 MdV1Sa8hEN7ZMui8PoQpRJrozOfA0HDKOzqJtM7eL+LXsd2jXEqIp3CFPoZy9NBSO5Vy
 AfS/zwyakQd70KSMe5RoZyjdeSZoRhVOuU4riUC72wlmzRSgmiSF9ngyA9QarzSkWt1w
 Gpa8aidL7Slf0h53QufS2ONORLt/4vDp/kSthYGitqacrNU2SRPQ2cNRiETmrDfOj81F
 m7xQ==
X-Gm-Message-State: AOJu0YwbYS0jACA5Jhr+w8HfIPTVZi11o5fgRs1C4NkK07CDYSVBWA8Q
 GisNs/0Q14pT0tDb9BLiKmpMYZYZCok1cEs7FGsgia1V9asl8HAE4oael7VkVx3eQy/APls4TA8
 4xcOLJKlO+uKHf/SFT80cotkBoKW7D9vN5djS7KLTvzpDjeI=
X-Google-Smtp-Source: AGHT+IGS8ebW9S4UE5RWALLuk29a6ROuiBj8A+7+gCXRgYNPvkcNuDg8xWKFabwpf/Egtq3wMim5YxhSXk4W+B0YIhI=
X-Received: by 2002:a05:6102:f0b:b0:498:9c0a:af1a with SMTP id
 ada2fe7eead31-49bde13565dmr13241216137.4.1725993672061; Tue, 10 Sep 2024
 11:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240907222013.10298-1-trini@konsulko.com>
In-Reply-To: <20240907222013.10298-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 12:41:01 -0600
Message-ID: <CAFLszTgo2m7a+xwP_1PLEOgx8ny4r9AmebHR3sxDmwDuQ6rtew@mail.gmail.com>
Subject: Re: [PATCH] arm: Remove ethernut5 board
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Harald Kipp <harald.kipp@egnite.de>, 
 Eugen Hristev <eugen.hristev@collabora.com>
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

On Sat, 7 Sept 2024 at 16:20, Tom Rini <trini@konsulko.com> wrote:
>
> As per the maintainers at egnite GmbH, they are no longer interested in
> supporting this board. Go and remove the platform here. Furthermore,
> this is the only AT91SAM9XE platform in-tree so remove supporting code
> for that as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Harald Kipp <harald.kipp@egnite.de>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  arch/arm/dts/Makefile                         |   2 -
>  arch/arm/dts/at91sam9xe.dtsi                  |  60 ----
>  arch/arm/dts/ethernut5.dts                    |  96 ------
>  arch/arm/mach-at91/Kconfig                    |  24 --
>  arch/arm/mach-at91/arm926ejs/Makefile         |   2 -
>  arch/arm/mach-at91/arm926ejs/eflash.c         | 255 --------------
>  arch/arm/mach-at91/include/mach/at91_dbu.h    |  37 --
>  arch/arm/mach-at91/include/mach/at91_eefc.h   |  47 ---
>  arch/arm/mach-at91/include/mach/at91sam9260.h |  12 +-
>  arch/arm/mach-at91/include/mach/hardware.h    |   3 +-
>  board/egnite/ethernut5/Kconfig                |  12 -
>  board/egnite/ethernut5/MAINTAINERS            |   6 -
>  board/egnite/ethernut5/Makefile               |  10 -
>  board/egnite/ethernut5/ethernut5.c            | 198 -----------
>  board/egnite/ethernut5/ethernut5_pwrman.c     | 323 ------------------
>  board/egnite/ethernut5/ethernut5_pwrman.h     |  51 ---
>  configs/ethernut5_defconfig                   |  87 -----
>  doc/board/atmel/at91ek.rst                    |   4 +-
>  drivers/bootcount/Kconfig                     |   1 -
>  include/configs/at91sam9260ek.h               |   6 +-
>  include/configs/ethernut5.h                   |  88 -----
>  21 files changed, 6 insertions(+), 1318 deletions(-)
>  delete mode 100644 arch/arm/dts/at91sam9xe.dtsi
>  delete mode 100644 arch/arm/dts/ethernut5.dts
>  delete mode 100644 arch/arm/mach-at91/arm926ejs/eflash.c
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_dbu.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_eefc.h
>  delete mode 100644 board/egnite/ethernut5/Kconfig
>  delete mode 100644 board/egnite/ethernut5/MAINTAINERS
>  delete mode 100644 board/egnite/ethernut5/Makefile
>  delete mode 100644 board/egnite/ethernut5/ethernut5.c
>  delete mode 100644 board/egnite/ethernut5/ethernut5_pwrman.c
>  delete mode 100644 board/egnite/ethernut5/ethernut5_pwrman.h
>  delete mode 100644 configs/ethernut5_defconfig
>  delete mode 100644 include/configs/ethernut5.h

Reviewed-by: Simon Glass <sjg@chromium.org>
