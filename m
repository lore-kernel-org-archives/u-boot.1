Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F10D16810
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7257583F56;
	Fri,  9 Jan 2026 12:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ELeBhDoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D5D84132; Fri,  9 Jan 2026 12:32:04 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B55B83CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so824882166b.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958322; x=1768563122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mDosEqCjMfY4yIYFYCIZzYFR3No5U1emlWYwQTGdIzk=;
 b=ELeBhDoWC4l/QBe78FzZUEsWIQr6Ge9RH9fwu3kfXzzoba6IdW7+aUiSb5RHYPn0Pq
 CaZr98rJLSvU5ZqvucMWB9s4pFmwG6CL+vIe+1z1YV50KDJmZOAmQMPjrJKrUTdsH4CH
 PvvLvoCie0p3GFjFWvKkKgQhOt5dV8iHQpcIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958322; x=1768563122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDosEqCjMfY4yIYFYCIZzYFR3No5U1emlWYwQTGdIzk=;
 b=r3bb7jKGwWxxAmy63VbpP64XlSNSS72MHlnr1PtNp4WYe8dKHnDSthvQ7ieXBd9WF3
 XCLTjLbt99IDLt6WuttdF6AnjTxA1pF66raq1PugUFZceyy7aNVkF0Z25ZJdk54kTlyA
 gMaTZOJ9zTcrMmuFi1NCEqPL2p4uiTfCTgVAH+yu6Q9Q0Os59V8Nt8YbYkcWAtpkLxKa
 tdaRu9KJjc9pn3kMK3hGDIDuAGzF8l1HfL1ayaNyRgKPJ3RSeX6ZY1T0V61SWoptuZXA
 joz4rkYwW34kpuBq1odHvR8CePo6bJ+h7AzbgsCwovLB7Ct2fXrdpjKFmiqMRujOmnlX
 3n4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY78GJoCSWC1J+1qbeqAqldd1yvXYxNvnecYiJ4DvluvHMzminloMJCy8yPtVPEyzP9XnQUDw=@lists.denx.de
X-Gm-Message-State: AOJu0YzD2f4c/0ZSxYwejOvFdGPye9s5W9k8T8VLwciEbUc2JcbPXvlr
 Gjq5j9AfJXDILuokTYSgeNtnBC5kXz6AriUF8Y0jy6T4/yMlIQuyG/q+60p+g25FttOprAUMpuc
 pCM2GfgLTkPAkzFiBIlhUcJUSuGaxK5yo7xuJl4sw
X-Gm-Gg: AY/fxX52oeA/pVQgEITCtxCnUxwhqsPtpH6oPDgCaoK4ZoBLCByLSyjEj0cZ8B1wp1j
 iiLWcakvlhJHUhuYmLnRGM4J9rcYr1EfME+yHKpfLMVlFPcRFrwGII0l3bG62FKYncYg20+GTPV
 pcgpTMUMv+7vnZ9QDCQKeL7154hflkGGm3TaCdnMoB6BG1Kdlzit1tf4PYK2f7UhJuKGh6ut3b1
 NXucupa77seWYulujF5CXGiVV9YWilXYk0cnfOOzgtEGhcF9NhJX+kWai93M9+ixBEjSg==
X-Google-Smtp-Source: AGHT+IErwbWvrd2vp/57C7vNTJYIIu6BPG/BErpji78HE6+BLUE9ru+NeS0X4A8K/791ut81QLBtVrveb+heB/WSGvA=
X-Received: by 2002:a17:907:94c3:b0:b76:74b6:dbf8 with SMTP id
 a640c23a62f3a-b8444dc4880mr981292366b.14.1767958321603; Fri, 09 Jan 2026
 03:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20260107201838.3448806-1-visitorckw@gmail.com>
 <20260107201838.3448806-5-visitorckw@gmail.com>
In-Reply-To: <20260107201838.3448806-5-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:31:49 -0700
X-Gm-Features: AZwV_Qh0v3T7OPGDtT2Jcdw2Jbklm3nUhXHXqa1H-y3O1QbdW0o40qcmXPDEaE0
Message-ID: <CAFLszTiibRObaaC3yx=MtX_tkO_n-qQ-uon1QX5eL13H8PdBVA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] sysreset: Add QEMU virtual system controller driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

On Wed, 7 Jan 2026 at 13:19, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Introduce a new sysreset driver for the QEMU Virtual System Controller.
> This device is found on QEMU "virt" machines (such as the m68k virt
> target) and provides a mechanism to trigger system reset and power-off
> events.
>
> The driver maps U-Boot sysreset types to the corresponding controller
> commands:
> - SYSRESET_WARM / SYSRESET_COLD -> VIRT_CTRL_CMD_RESET
> - SYSRESET_POWER_OFF -> VIRT_CTRL_CMD_HALT
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v6:
> - Introduce new driver to replace board-file reset implementation.
>
>  MAINTAINERS                                |  6 +++
>  drivers/sysreset/Kconfig                   |  8 ++++
>  drivers/sysreset/Makefile                  |  1 +
>  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 55 ++++++++++++++++++++++
>  include/qemu_virt_ctrl.h                   | 13 +++++
>  5 files changed, 83 insertions(+)
>  create mode 100644 drivers/sysreset/sysreset_qemu_virt_ctrl.c
>  create mode 100644 include/qemu_virt_ctrl.h
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
