Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D9ECDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 05:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D82786F9D;
	Thu, 19 Oct 2023 07:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XqBxVH6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 468698715C; Thu, 19 Oct 2023 07:08:54 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C42A86F9D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53d82bea507so12955606a12.2
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697692130; x=1698296930; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmF1kkRrTxwir/68MN587t3BPGLAPyjzv8Pd/d89RG0=;
 b=XqBxVH6UkoOYFbwofpCEouke0Djb/3+4LxwLEXUyC4NOH8ngcKzxSVmG99R9+QIA90
 jIYIWTIspe8ViVTrc59QeobAphSVbYe+qN030oYDQDX9DLrxnzTZz8XstetANKWXRRvV
 iL6tyM4xbEoEaln+1WupjlECtSXWz4u0XlSy77FMIdy19/YymonT3BhN0KZ6gtg6Efea
 PU5qCia8FgwCBBdBb8lARBMNugy1RfCR5dBK+asNJJWf9dC6kEl/1jdUcu0PXnRr/u0t
 kBO5xDIJllaxC4B9J8DgBtGqFzs0fpD6JlAkt4gQ4qm79s8CWCNX+5h84vBJwPPhI9C6
 fVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697692130; x=1698296930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmF1kkRrTxwir/68MN587t3BPGLAPyjzv8Pd/d89RG0=;
 b=iWM1VBCtJeBeidrn8qpQJF/ld50maBZXguxOJevkK++cTMG5UvEmldC8XLisb2kUsJ
 jIDupjot7qtSVVt78dAo8OLqD+eGDDYFA7DIkivmQtqJcobi5JZfH6CFcZNOd/i4J9T6
 jruacC+A0QImzBn7JEuTc3OiwCHDtkdjyZY+/hkWFJsicBxsVmuOR/aibudiqJ0TCl1q
 t79pbab1OMbTl5V851j6pI72Q4TEjpJaA4leDgtjMazev716jTzGwqtQXqmr2d6wfkeT
 ire/lxKDefp+MYc3XHS7b1wEgSjBRYeQyH97MYzHoQt/WUBjqvHqc9CejIXq8dfxRLF6
 DdHQ==
X-Gm-Message-State: AOJu0YwmKtz4wdPzpFy3AVAmHQAAM/JZQTYJ1Pi1LLQnIfuFWxdwyPD5
 CoLKrEGfVA8duNrO3h8Gr4Rke8tPvOq0lY/68B4=
X-Google-Smtp-Source: AGHT+IEWMHC8gsgzStur13EuW1dWQiUQk+JxuiZleJzvRMsNlmufanEA9uPSHwv43f4zlmJeeCSHuvI9fNWhX1WoP1o=
X-Received: by 2002:a17:907:2ce6:b0:9a3:c4f4:12de with SMTP id
 hz6-20020a1709072ce600b009a3c4f412demr875891ejc.37.1697692130451; Wed, 18 Oct
 2023 22:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-1-bmeng@tinylab.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 19 Oct 2023 13:08:38 +0800
Message-ID: <CAEUhbmXzgjRkzKq=TSQJADkCm75H-HugMz=4+g0ccNL2WWNWRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ufs: Add a PCI UFS controller support
To: Bin Meng <bmeng@tinylab.org>, Marek Vasut <marex@denx.de>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

+ Marek,

On Wed, Oct 11, 2023 at 9:16=E2=80=AFPM Bin Meng <bmeng@tinylab.org> wrote:
>
> This adds a PCI UFS controller support and enables the support on
> QEMU RISC-V for testing.
>
> Requiring QEMU v8.2+.
>
> This series is avaiable at u-boot-x86/ufs for testing.
>
> Changes in v2:
> - fix a build warning
>
> Bin Meng (9):
>   ufs: Correct the UFS terminlogy
>   ufs: Add a line feed to the end of some dev_xxx() messages
>   cmd: kconfig: Make ufs prompt look similar to other commands
>   cmd: ufs: Correct the help text
>   pci_ids: Add Red Hat vendor and device IDs
>   ufs: Allow mmio registers on the PCI bus
>   ufs: Add a PCI based UFS controller driver
>   ufs: Handle UFS 3.1 controllers
>   qemu: riscv: Enable UFS support
>
>  board/emulation/qemu-riscv/Kconfig |  2 ++
>  cmd/Kconfig                        |  2 +-
>  cmd/ufs.c                          |  2 +-
>  doc/board/emulation/qemu-riscv.rst |  8 +++++-
>  drivers/ufs/Kconfig                | 11 ++++++++
>  drivers/ufs/Makefile               |  1 +
>  drivers/ufs/ufs-pci.c              | 45 ++++++++++++++++++++++++++++++
>  drivers/ufs/ufs-uclass.c           |  2 +-
>  drivers/ufs/ufs.c                  | 31 ++++++++++++--------
>  drivers/ufs/ufs.h                  |  1 +
>  include/pci_ids.h                  |  7 +++++
>  11 files changed, 97 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/ufs/ufs-pci.c
>

Ping?
