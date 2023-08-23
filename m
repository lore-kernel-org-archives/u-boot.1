Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77679EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182D2864B3;
	Wed, 23 Aug 2023 17:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VOyaO1EL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798EC86451; Wed, 23 Aug 2023 17:30:54 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD0C4864AD
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d656d5e8265so5661539276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692804649; x=1693409449;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DQYwGfvwIIIULX7w0/N9iCciZVcRv6FKwzIJIrWRtiE=;
 b=VOyaO1ELh1rG2X5UPRAUTIzpEpeUEvLjP3Qp2E/k59Mu9xa6hMyaafeCIgwkpFlrYF
 kbKqddfWqrclFFQQTaNkMsAWIqnh4yL6ftyxbspOZ/Afj1/VGynMZ8G9MfUJyNoHPpre
 jkv6pVBOglIem8JnH7I1GG9OG5x3tp6EAmgY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692804649; x=1693409449;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQYwGfvwIIIULX7w0/N9iCciZVcRv6FKwzIJIrWRtiE=;
 b=B+IP3eKifOpPayYjLlyS25kCmf7YVWSxfkVTHGpiSzmr/v8/1MeR8kHQWfNqMpSGtc
 DmkMcph+sgPdklPaFS+FJLKlruUCdh/IMx7duMhUXElN87+gHIl9DnXZJCkrnqie9em4
 C5nXsIln0ybKpfBV0jU+HSO496OK7n/1KmLM90oxJCZR84Z9mEnSPmDcyu8e4puHLbos
 qUvlergnKwreDaSYC3sJP8KYDPwwTkPRqV8hB23zAbb1Y9SQIONUSexTznJSuvcMxKMj
 dBsbF6OeI8hiwmhUp0Rqt7Itcdkeq4GWHwFMe31uwdf4Bc49Y2+wo4mblYTI+yGu4Oq6
 SnQg==
X-Gm-Message-State: AOJu0Yyrtd1qNm8BvF6GWzj/9vX44BmxuMAj2RqpwM5QA4vEbuoQe9O/
 ln+UXvUy8Uz47cuMvQIGxr2YqJI1YruCtZ1vPDk0DLtnpoV/+BI8cVPkcg==
X-Google-Smtp-Source: AGHT+IEPFdSHu7Qn5cYXl5MHj9qgcsRXxtmEHRqeNQF2g44nSvL0/wIjM7WJKmDBGZaBd0BypJ+5gRhHLXH5xiEVKzI=
X-Received: by 2002:a25:b291:0:b0:d11:c89:4256 with SMTP id
 k17-20020a25b291000000b00d110c894256mr12181916ybj.31.1692804648767; Wed, 23
 Aug 2023 08:30:48 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 09:30:31 -0600
Message-ID: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
Subject: Config fragments
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Neha Francis <n-francis@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh <vigneshr@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi,

Up until 2023.04 it has been possible to build all the defconfigs but
with 2023.07 that changed. Tom mentioned this to me recently.

Up until 2023.04 we can enumerate all the board configs that can be
built. We can build any of them using a single name and a single
defconfig. The boards.cfg file which buildman creates contains a full
list of things that can be built.

From 2023.07 this changes and we now have random .config files
sprinkled about the place. I say random because they are not connected
to anything. For example, here is
board/ti/am62x/MAINTAINERS:

AM62x BOARD
M: Dave Gerlach <d-gerlach@ti.com>
M: Tom Rini <trini@konsulko.com>
S: Maintained
F: board/ti/am62x/
F: include/configs/am62x_evm.h
F: configs/am62x_evm_r5_defconfig
F: configs/am62x_evm_a53_defconfig

BEAGLEPLAY BOARD
M:     Nishanth Menon <nm@ti.com>
M:     Robert Nelson <robertcnelson@gmail.com>
M:     Tom Rini <trini@konsulko.com>
S:     Maintained
N:     beagleplay

In most cases the MAINTAINERS file tells us about each board and until
[1] I had assumed that was the case. With that patch reverted, these
are the only 'orphaned' MAINTAINERS entries (buildman
--maintainer-check):

WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
ending at line 8
WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending at line 44
WARNING: orphaned defconfig in
board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at line 6
WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at line 15

But Tom advised me that MAINTAINERS is not intended for this purpose,
so the check has been dropped. I am not suggesting we bring it back,
necessarily, but if we did, we could use it to specify the .config and
defconfig files which are used by each board.

*Failing that*, I suggest a new 'name.brd' file in the board directory
to contain this information, e.g.

# Contents of board/ti/am62x/beagleplay.brd:
beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config

This could be parsed by buildman and other tools, to produce a list of
available boards and to build each using a single name (e.g. make
beagleplay-r5_defconfig)

What do people think?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230803185144.1760729-2-sjg@chromium.org/
