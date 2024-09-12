Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13988EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863EC88D54;
	Thu, 12 Sep 2024 02:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CSGig6Iq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC11F88CFA; Thu, 12 Sep 2024 02:59:13 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89AD788D54
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-718a3b8a2dcso235410b3a.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102750; x=1726707550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XhmwHefiKO9HBdL54/wW90C2Xv35m/NE8EnbYRH34/o=;
 b=CSGig6Iq7sjN44F2+2NTx+F+r0Gx5NfP6GMflNbCWVHFaQ0RmnFMxF6BMO6BG/KCoa
 B73kpmHH9PoGzZnPss2W7E4WIsKYl3NIR050ELX9w9CrlGB67dMbmATkhK87oGIbvwRp
 BomIzkpXN89yRjrZssKEWgOSkcXoxzDnXjh7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102750; x=1726707550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhmwHefiKO9HBdL54/wW90C2Xv35m/NE8EnbYRH34/o=;
 b=HRr2xDXjfIdJk7N9KJTDqDqWvHF71C1N6lPtCk5CkrZ/p8gZHha91TmwSK/J5JRy/L
 7ujr/TTMlPLxbhrghQOCsMA5hYJ/f/Mi0NEa8D70mJKPgexBGXRg45vFZUghm44Jtcxz
 Pz/5Ed1kHB/1tuJ+jRVyLHUNJfoex3QbBSKhK7um4msFIch5fOOxcL6mLUncMkFlGM27
 EKAP+qLyAxcpw5qyO1r0uT1WuKsFgC/9OsbjN6QaEsK0knBs7sbHoTTIfhVh2Bp1Crdv
 LYEodd/Gz5qYtuRd5AeTXYUQhFU6Ue8Peo76ViS5ZtOSVcIKaGFoBrFfLgIIZlBLVl3G
 WgmA==
X-Gm-Message-State: AOJu0YzcvanY+mCucObSgWL1a6M2hmN89lfoowtnj7zpfhtu1OMBsOYl
 iZ557tihKfdDMqO2utauYELMyXeTQRJBhKGgObZcUMbZcpk5n2vjvI0/dnqngMkQCXxi/ef8h7m
 4J+/zl78wMQQH6JAKsUaEMRR34uDeWZO8F0A9
X-Google-Smtp-Source: AGHT+IFJkZd4NXCFNYJQOC/n5qSoAFFc1pDJVOmh5EG3FUkgWBwcU8P5x/TNvSi08eo6jYNRmKWuUNSrXm0E50RTIq4=
X-Received: by 2002:a05:6a00:228b:b0:718:da4e:5577 with SMTP id
 d2e1a72fcca58-71926091dc5mr1939141b3a.14.1726102750081; Wed, 11 Sep 2024
 17:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-27-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-27-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:25 -0600
Message-ID: <CAFLszTgsbt69nSR8OwVXPoRdY_aFfw4EK7qzS45bSi4rH2EsWw@mail.gmail.com>
Subject: Re: [PATCH v3 26/30] board: raspberrypi: Add ASL files from tianocore
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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
> Add the necessary DSDT files copied from tianocore to boot the RPi4.
> In addition generate a board specific SSDT to dynamically enable/disable
> ACPI devices based on FDT. This is required to support the various variants
> and boot options. It also allows to test the code on QEMU 9.0 without
> modifications, since it doesn't emulate PCIe yet.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  board/raspberrypi/rpi/.gitignore   |   3 +
>  board/raspberrypi/rpi/Makefile     |   2 +
>  board/raspberrypi/rpi/acpitables.h |  90 +++++++
>  board/raspberrypi/rpi/dsdt.asl     | 290 ++++++++++++++++++++++
>  board/raspberrypi/rpi/emmc.asl     | 136 +++++++++++
>  board/raspberrypi/rpi/gpudevs.asl  | 372 +++++++++++++++++++++++++++++
>  board/raspberrypi/rpi/pci.asl      | 177 ++++++++++++++
>  board/raspberrypi/rpi/pep.asl      |  90 +++++++
>  board/raspberrypi/rpi/rhpx.asl     | 195 +++++++++++++++
>  board/raspberrypi/rpi/rpi.c        | 183 ++++++++++++++
>  board/raspberrypi/rpi/sdhc.asl     | 111 +++++++++
>  board/raspberrypi/rpi/uart.asl     | 208 ++++++++++++++++
>  12 files changed, 1857 insertions(+)
>  create mode 100644 board/raspberrypi/rpi/.gitignore
>  create mode 100644 board/raspberrypi/rpi/acpitables.h
>  create mode 100644 board/raspberrypi/rpi/dsdt.asl
>  create mode 100644 board/raspberrypi/rpi/emmc.asl
>  create mode 100644 board/raspberrypi/rpi/gpudevs.asl
>  create mode 100644 board/raspberrypi/rpi/pci.asl
>  create mode 100644 board/raspberrypi/rpi/pep.asl
>  create mode 100644 board/raspberrypi/rpi/rhpx.asl
>  create mode 100644 board/raspberrypi/rpi/sdhc.asl
>  create mode 100644 board/raspberrypi/rpi/uart.asl
>

Reviewed-by: Simon Glass <sjg@chromium.org>
