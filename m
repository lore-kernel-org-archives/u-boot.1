Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D78DE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B91D789710;
	Mon,  9 Dec 2024 19:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dKSzkXoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25FDE89251; Mon,  9 Dec 2024 19:20:13 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F00EF89466
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a7deec316aso16027395ab.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 10:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733768409; x=1734373209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0lQgN2d4E+YzMh/uQDIrBiIGdMcBDsgCE7bDqFw4OE0=;
 b=dKSzkXoiacS2L1yI7hDv+3gllEoqzmRvm1AMSmCD/sL0ShBwgcqGkJiBOOhjxl2Cub
 IkFeiBZ7WP7bd1sqVJKXl0oM1lJSBm8H1nMDXrtbAr3OfwhvigfJkXNiFxGJK0GJNtp0
 8Xa4MR8pDbl62iSVvTwIUbtuXG5DsxLw6s7Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733768409; x=1734373209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0lQgN2d4E+YzMh/uQDIrBiIGdMcBDsgCE7bDqFw4OE0=;
 b=syQrLr3XdjalzBdhlMgKLF3LY7VP/3iFJjQ48fM7cQ0jPvwZHd8PcfUcVSmWGgIx+C
 NVFwL7lQXTqjQLo7RnvmdE2+lFQ9Xla3f6vlLsL0JhI47ucruHmly+yk2crjxTdJ6JIi
 urozit2LcpC50JTy0V02VOHNwt4co1MNomrt5Czmb7nb+RRjeMwGHirBVny9oPDnPhb2
 IN/VMgdaj0QIUV3/xHV4IGHT4/+iuyJ9DTV4Oq5XcCKhaq+F/kpeUVga+JJ9vusv4bhR
 3ECSnW2+bEMG0GX0GUvPPrjXZG8OIVnOKF94J7IFXm5OLfQWckmTHiSV5ise8Lun/N2B
 pcYA==
X-Gm-Message-State: AOJu0YyiYGkwB6KkfsXqbRLnF+Gt5ZKZ/BtJ3XoNKlJmlOo9KYztBaFI
 pi8heAf0vaCCkUQ6W8p93RsBw85zxjZZci5ZjKtnEz5NrU48Q4SbFRKLhrv1700jvuf84c8VZII
 =
X-Gm-Gg: ASbGncuXpw57B+NuK9aU3jFNo3S7+TmcGdYtw7JcMug2ZEdQquXx5g4HEhxi+jv0v8J
 o5QecfMJtFy7bPj67/Gq8WP+i+cznCODl0RIVeMGcyyQenzmpZjObZ5GWtJai4jQuNwDCsHBdax
 rlmxiDeWFR1icFXB833uz/hdJDm9QnPUZYj+fk88aNqL0uxvTZMzZCDcibmOFI4Kq5UnCDRywDJ
 qp8E0yo5FVjwH7AlEc7KimTP2TNZ2FxTIv0EygpAzYWqrhjZV7hm22zVMzcR4qopAISfla8diQp
 sZEt6TXDZdw=
X-Google-Smtp-Source: AGHT+IHBVaJoHOImVz1fYxPxe72AW4Nicb82XYWrLjcWUp5IbsM1JaGigZcfB5+E9AVNMC7QR99sjg==
X-Received: by 2002:a05:6e02:b4d:b0:3a7:9533:c3ac with SMTP id
 e9e14a558f8ab-3a9dbabbb0bmr11346145ab.4.1733768408684; 
 Mon, 09 Dec 2024 10:20:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d8845sm2390429173.83.2024.12.09.10.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:20:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/5] rpi: Tidy up booting
Date: Mon,  9 Dec 2024 11:19:56 -0700
Message-Id: <20241209182002.671953-1-sjg@chromium.org>
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

This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
ramdisk, by expanding the available space.

It also tidies up some strange behaviour with the provided FDT, where a
separate pointer is maintained to it, even though U-Boot has copied it
and placed it in its own space. This avoids strange bugs where it
accidentally gets overwritten when loading a file into memory.

The patch to expand the devicetree was dropped, meaning that people
should be careful to unset fdt_addr in the environment.

Changes in v2:
- Add new patch to make myself an rpi maintainer
- Add new patch to set bootm_size
- Add new patch to drop fdt_high and initrd_high
- Drop patch to allow expanding the devicetree during relocation

Simon Glass (5):
  rpi: Add myself to the list of maintainers
  rpi: Set bootm_size to 512MB
  rpi: Drop fdt_high and initrd_high
  rpi: Update environment to support booti and large initrd
  rpi: Use the U-Boot control FDT for fdt_addr

 MAINTAINERS                   |  1 +
 board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
 board/raspberrypi/rpi/rpi.env | 24 +++++++++++++-----------
 3 files changed, 22 insertions(+), 23 deletions(-)

-- 
2.34.1

