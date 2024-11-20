Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8530FD711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 251D987042;
	Wed, 20 Nov 2024 16:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V8JQnjif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F7187042; Wed, 20 Nov 2024 16:36:05 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D0288FAA
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83ab00438acso30972939f.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116960; x=1732721760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ng5Ot02Yi1s651zsMA69MhLTfP36562dYzsuWfXkwUY=;
 b=V8JQnjiftuXmdPj8+QIuljkJitIm4DpPKofzvCXC/eoLU8A+k7vBhaRhIVwBbkoZlu
 2ANM0LVE8Doiw2W88gIp7wxB2C54a+nS7xTKwdFUQuXFdrcQ08aSplnJgzRP+SYhNuak
 YFZHs6v8xRPmN/NBEJ6QVFoHcOtGQI5Kz0wX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116960; x=1732721760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ng5Ot02Yi1s651zsMA69MhLTfP36562dYzsuWfXkwUY=;
 b=wRINVZdgOYaNigfXjYnYhe4sLTaw+qnRxdmAGutFiZe7O3y4OtpOBiamofw9FWP0nX
 3MoNbibWY4j+2ADU27JkM/h0fKlCkY4fDdDmtTb+dY0Qr8lsJiXlwFUx77d9fesZdAwT
 NYoeABcJhZYNIGtqxb+xLoLT9NFX8ntkVR1PhRO+dBkiSJkpuBHUljf0f3I+8FuJMeum
 17M0MYxUF70MUf6h4xQy6ZzFxsH30enW9V18jEXjKq9JKPtq8vtOADThJ74/9oTPFf3h
 WT86LJAaeTcl47v2cV6qR6wnEWrEh7Nbfd8/ErWbRppYSk/5s/RiAXNpkKFV3KAmJIVP
 y3WQ==
X-Gm-Message-State: AOJu0YwnFDzoJUYEDVvVbtvsGC6inuxb/fWLhfXEVoxFEcPbLJehOC+O
 OwiakbFNhptaqxalyKKptRXw3QA/TiODLILiegDSl27yM3mR5cgs4t6KyOdCwnbcc6bwrRY9Hj0
 =
X-Google-Smtp-Source: AGHT+IHg00mNXan4EC625At59beR1PWt9pWB1GzOx5pMTOYtsx9hMVdj++dvcpMnpmSR8wliD8OYqQ==
X-Received: by 2002:a05:6602:29c4:b0:83a:ae9d:9300 with SMTP id
 ca18e2360f4ac-83eb604c39amr274673939f.3.1732116959783; 
 Wed, 20 Nov 2024 07:35:59 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6dffd678sm274395139f.23.2024.11.20.07.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:35:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>, Robert Marko <robert.marko@sartura.hr>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/3] serial: Support a disabled serial port
Date: Wed, 20 Nov 2024 08:35:51 -0700
Message-Id: <20241120153554.860710-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series provides a way to tell a serial UART that it can't actually
work, at runtime. The main motivation is to deal with a coreboot feature
where it does not provide UART details in the sysinfo structure unless
the UART is also enabled in coreboot.

Attempts to introduce a way to enable a silent UART in coreboot have
lead to a large amount of discussion but no result, sadly.

This series reworks a patch sent last year, which was not quite ready to
be applied. A coreboot user (on irc) hit this problem, so it needs to be
resolved.

Link: https://patchwork.ozlabs.org/project/uboot/patch/20231101180447.99361-1-sjg@chromium.org/

Changes in v3:
- Put the feature behind a Kconfig
- Move the feature to the serial uclass, so any serial driver can use it

Changes in v2:
- Drop RFC tag since there were no comments

Simon Glass (3):
  serial: Allow a serial port to be silent disabled
  serial: ns16550: Avoid probing hardware when disabled
  x86: coreboot: Make use of disabled console

 arch/x86/cpu/coreboot/Kconfig    |  1 +
 drivers/serial/Kconfig           |  9 +++++++++
 drivers/serial/ns16550.c         |  3 ++-
 drivers/serial/serial-uclass.c   | 19 ++++++++++++++++++-
 drivers/serial/serial_coreboot.c |  2 ++
 include/serial.h                 | 25 +++++++++++++++++++++++++
 6 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.34.1

