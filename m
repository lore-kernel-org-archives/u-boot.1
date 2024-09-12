Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C136FEE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C818988D83;
	Thu, 12 Sep 2024 02:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P84EPFKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE31888D7E; Thu, 12 Sep 2024 02:59:10 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C186D88CFA
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718f28f77f4so334495b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102747; x=1726707547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C6g3voaE0sy7kgnP1N/NuWOD5ksHhW96h3ew8XdguEY=;
 b=P84EPFKQcnQjsJ1DUCyH0HSfmXE/PejcznpV+HffVgjhR8FH7wmVqwwWEc3T2x6p6s
 xfYdJ98WO1lfVA7zgHKEknpgTduPD1dFCvac2FKm3Vd61O8/iEXTg2Raqy5TSy7jkaFg
 mOR6SPcVw9lJcahDedxKAU0xbWw6rPDaqPSL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102747; x=1726707547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C6g3voaE0sy7kgnP1N/NuWOD5ksHhW96h3ew8XdguEY=;
 b=o1TDGuqPDPVa1kKio5QQZh9rRkQVylxbpBCRSXgLbiDYNKam9P4mmDeo0dNa22SCO6
 R+O1hHOaVtUl3LwFgD2MdL/uA4T+u8CE34e0xzTRJ89qxPGoAYpKMRb3UTJgy6oPlCtk
 rWEvUImfiexnQfpV194LdsVGBwn+n6NPDD6ngT4xeq2MF2VEBWLhuUXoen9j1CKRf1fU
 FpvFu211AyIW+ATy+DI7U59aZOQy0MVAXb2QCXuozRRVits41J81PB+O3/v1LtlrgOgj
 C/011IHDA2VvYalNPc6/2lbwtjHArSlr5cQ5ujid6x7sHgX0O+mfWspZH2nK+otKJgDa
 OIXA==
X-Gm-Message-State: AOJu0YxEPaGZ8bwcyg5tywUxcZ/7XyUoKHcCXyqEokrjV3tEY8fHoMOa
 9fX5wkXWww1T03PwPwVZyzn/2CLI4fwBRDVKUIz4pZRoMZV4yNndVDpIlMBOJPcgEV0keoM5HJn
 /c+qasr2f1dOjxmM9QTiBsp/7oOtbmLDh0jes
X-Google-Smtp-Source: AGHT+IGPjrQb11ArWIze3a9NUSvBK83x+4lyFvRUzKqBHPs72PiOn3L4zo8Rx6lNqIjZ29pgUH5Wdf9Mn85Ez50E59I=
X-Received: by 2002:a05:6a00:3392:b0:713:f127:ad5f with SMTP id
 d2e1a72fcca58-719261e77cemr1928879b3a.22.1726102747279; Wed, 11 Sep 2024
 17:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-25-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-25-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:23 -0600
Message-ID: <CAFLszTj01iHxq4zgDkER4oNZtUZvBTO+qTykb1ok5fwB_QmBFw@mail.gmail.com>
Subject: Re: [PATCH v3 24/30] arm: mach-bcm283x: Bring in some header files
 from tianocore
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> These header files presumably duplicate things already in the U-Boot
> devicetree. For now, bring them in to get the ASL code and ACPI table
> code to compile.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 ++++++++++++++++++
>  .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 +++++++++++++++
>  .../include/mach/acpi/bcm2836_gpio.h          |  19 +++
>  .../include/mach/acpi/bcm2836_gpu.h           |  47 ++++++
>  .../include/mach/acpi/bcm2836_pwm.h           |  33 ++++
>  .../include/mach/acpi/bcm2836_sdhost.h        |  18 +++
>  .../include/mach/acpi/bcm2836_sdio.h          |  21 +++
>  drivers/pci/pcie_brcmstb.c                    | 101 ++----------
>  8 files changed, 427 insertions(+), 91 deletions(-)
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
>

Reviewed-by: Simon Glass <sjg@chromium.org>
