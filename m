Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99B8C5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 12:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F292E82AE1;
	Sat, 31 May 2025 14:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="D/LF7UZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9ACE81F32; Sat, 31 May 2025 12:40:58 +0200 (CEST)
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90DF480F0E
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 12:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bogdan@kde.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) (Authenticated sender: vatra)
 by letterbox.kde.org (Postfix) with ESMTPSA id EDE2332C37E
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 11:40:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1748688056; bh=dOwcbFZXbjTTLtTgPdbgDKpTKxwZzhaGlnG+l4e9rGM=;
 h=From:Date:Subject:To:From;
 b=D/LF7UZr1CCPVzFPjMCBHgVL3W2uXjoHiV36tnxy9LYLt7+cU9ZK/xyW2P2nwCLv0
 dZUoYgNipdiNqWfEkatyS9QoohpiOoNrVUsJzvGnVy2PSp6DP98Hl/GBAqRJbWkiCQ
 aFhyMJRPHPVJZcWI5KwuDd5sS6ugR3mexWU54KlEu4yM9zmn6jwuQxxY0lYoPqtgkg
 Ilcb7BOkTBsc4RwDTURrT9+/Kur92EwgjQzd2XB+C3zayX4B0N0vKhDJGgbsFOCeGB
 QBYR6yeN80egongubV6pTUfMhS/3MIAFSNp7u+MfS+u8XuTkljwePdOtEKy9mgYJW8
 4OEBtynlPSO9A==
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-60497d07279so5722179a12.3
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:40:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzk83voV+5G1LOiB1AWga45wSXX4AG+fnoIaRYvQKKtpWq7yMlQ
 Yo1zt/tGTcQWKCb3nX71U3Sbwg+Ut725VZ4OQwCrjsHd1qdozyY8ZYj+1HLftoAxDDCB7TDawaQ
 g7IC4nEP/+TUWtweYGabhNzb5bDhwHK0=
X-Google-Smtp-Source: AGHT+IHs8a2QaGJsYgdAhQcykLmwHSiBLwV+UvL0a/Yy6EvQVa6jwouJo1k00OOYun9Lcv3GhMcquRRFMTwyPk4x0yc=
X-Received: by 2002:a05:6402:520e:b0:602:1337:43fd with SMTP id
 4fb4d7f45d1cf-6057c1c1ec6mr4763828a12.13.1748688055521; Sat, 31 May 2025
 03:40:55 -0700 (PDT)
MIME-Version: 1.0
From: BogDan Vatra <bogdan@kde.org>
Date: Sat, 31 May 2025 13:40:19 +0300
X-Gmail-Original-Message-ID: <CAG9QW4GCbF1ctRXkcm0zvf3MBCRUaep7qdP2+4348xLhHRL=dg@mail.gmail.com>
X-Gm-Features: AX0GCFu3uTRnP3bPPsEiHYdvmoQne-itM2VaFxZ80fuVSlc2blu-ByHl46emq-A
Message-ID: <CAG9QW4GCbF1ctRXkcm0zvf3MBCRUaep7qdP2+4348xLhHRL=dg@mail.gmail.com>
Subject: Adding AMD GPU support via Linux ATOM BIOS emulator port
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 31 May 2025 14:51:08 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello there,

  I'd like to *try* to port the Linux ATOM BIOS emulator to U-Boot to
enable AMD GPU initialization and basic display support across all
platforms, eliminating the dependency on option ROMs.
  Linux already successfully uses this approach on platforms without option
ROM support. Newer AMD GPUs work on older PowerPC Macs (like the G5) that
lack OpenFirmware GPU support, demonstrating the viability of ATOM BIOS
emulation for cross-platform GPU initialization.

The goal would be to provide:
 - basic AMD GPU detection and initialization.
 - simple framebuffer/display output capability.

Before starting this effort, I'd like to get your input on:
 - feasibility: Does U-Boot's current PCI subsystem provide sufficient
support for tasks like mapping and reading the VBIOS from an AMD GPU, and
accessing its BARs for register I/O, which would be essential for an ATOM
BIOS interpreter? Are there any architectural limitations that would
prevent this integration?

 - prior work: Has anyone already started working on AMD GPU support in
U-Boot? If so, what's the current status and are there opportunities to
collaborate?


Any guidance, concerns, or suggestions would be greatly appreciated before
I dive into the implementation.

Best regards,
BogDan.
