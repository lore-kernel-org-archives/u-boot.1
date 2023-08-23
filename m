Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AB8EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C3A98645B;
	Wed, 23 Aug 2023 17:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fmMOB9xJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAFE864C1; Wed, 23 Aug 2023 17:57:18 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B51486422
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E4C7E3FA97
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692806235;
 bh=NQIFa7zt6Q04gapXY4Yulb0k0BlUL2Y6i2ZVyKjYvYk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=fmMOB9xJfr24+rPM7RgF4QqWukqb5pGn28CTfX442Ph03zRe+YdtZ+voJZWpDU65L
 AyKuHX38SXOQje0YWNajBDIaTlAdNICsAjYBMRt1BkeXWOH5aI1Fx/zQpTg90P8Iw2
 kWBNG80a7bor9nLE66oHRHgsqK2xMbWmt2ZMMtYLznhJ5I5WyrPzCs1poDAmh5FlPC
 La5zF+KqD+X4R8VOPlqLndO+hZFN6dYyFHtEssUiygFeGSIHXwp8yVaoYn5BpPsZz9
 XQGhKnNkyAVsQtTBAQqjhEXoT/ykMo5khdHImOINyrwqz3iBDtFRUP3Uldv1BbgY5D
 Y4mXqWAS0Ytkw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c5adb698aso1955360f8f.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692806235; x=1693411035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NQIFa7zt6Q04gapXY4Yulb0k0BlUL2Y6i2ZVyKjYvYk=;
 b=FcLknHXLK0dugTdcJk/N3VYLIdB59BdcADW2Q9JGKJ/dqMJHchRZIxK0KVymTrn5CM
 uahX2WnbMRx3lLok+7XQkfIddqP9QO0o1NxdRjMHZsKnK0uBfURgJMGe2OQWV7ORG9a9
 YvJI1DMVsCf/DyvkGZQWYyuSg2l+4ZycA7Ol3nHJYbyczI0+1v5OuHUtzeJlFuu1jAJY
 DgSOZda4Yh8c4V+2bIpIV28+q/+ZNnCaed4rCq0WjiQpClK4QcbgCL1kUwEDDc3EBjqy
 5GVhRiTPkQkiQq35J1+UW8DF95/bPxnyC1bYEuKw5xtvyGsoNKOKfnKRi8KrImioes4M
 PdNw==
X-Gm-Message-State: AOJu0YzqKUJNbbDPxN/GsKbWmGx41hVRLYf9oIFrY/Jkb69WY+MyfYSz
 flG7f403MPI/WMKaB/rTxXUxTwUHvN9tDC+pmGCOzLtxnDtzKBsg1i7tX/oY5bbh4ToxVknmJxU
 NQrDuHvBiXkIiC9lbBXNkQ/VhlTqk0fU=
X-Received: by 2002:adf:e78f:0:b0:319:84dd:4596 with SMTP id
 n15-20020adfe78f000000b0031984dd4596mr10839262wrm.5.1692806235568; 
 Wed, 23 Aug 2023 08:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkzyJP9dKsGI2J8Cqm6j9SPz9Gof0EK4AqxuA3iI/XsJgOkzo747HM/79Wb7lLQ56z2wUgzA==
X-Received: by 2002:adf:e78f:0:b0:319:84dd:4596 with SMTP id
 n15-20020adfe78f000000b0031984dd4596mr10839246wrm.5.1692806235206; 
 Wed, 23 Aug 2023 08:57:15 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 x8-20020a5d4448000000b0031432f1528csm19511189wrr.45.2023.08.23.08.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 08:57:14 -0700 (PDT)
Message-ID: <40e50527-0408-da17-9d33-194f9b71366f@canonical.com>
Date: Wed, 23 Aug 2023 17:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Config fragments
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neha Francis <n-francis@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 23.08.23 17:30, Simon Glass wrote:
> Hi,
> 
> Up until 2023.04 it has been possible to build all the defconfigs but
> with 2023.07 that changed. Tom mentioned this to me recently.

Could you, please, explain why there are defconfig that can't be built. 
The CI should have thrown an error in this case.

Why don't we delete defconfigs that don't build?

> 
> Up until 2023.04 we can enumerate all the board configs that can be
> built. We can build any of them using a single name and a single
> defconfig. The boards.cfg file which buildman creates contains a full
> list of things that can be built.
> 
>  From 2023.07 this changes and we now have random .config files
> sprinkled about the place. I say random because they are not connected
> to anything. For example, here is
> board/ti/am62x/MAINTAINERS:
> 
> AM62x BOARD
> M: Dave Gerlach <d-gerlach@ti.com>
> M: Tom Rini <trini@konsulko.com>
> S: Maintained
> F: board/ti/am62x/
> F: include/configs/am62x_evm.h
> F: configs/am62x_evm_r5_defconfig
> F: configs/am62x_evm_a53_defconfig
> 
> BEAGLEPLAY BOARD
> M:     Nishanth Menon <nm@ti.com>
> M:     Robert Nelson <robertcnelson@gmail.com>
> M:     Tom Rini <trini@konsulko.com>
> S:     Maintained
> N:     beagleplay
> 
> In most cases the MAINTAINERS file tells us about each board and until
> [1] I had assumed that was the case. With that patch reverted, these
> are the only 'orphaned' MAINTAINERS entries (buildman
> --maintainer-check):
> 
> WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> ending at line 8
> WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending at line 44
> WARNING: orphaned defconfig in
> board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at line 6
> WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at line 15

Why should we care about the maintainer status when building a defconfig?

> 
> But Tom advised me that MAINTAINERS is not intended for this purpose,

Enumerating configs/*defconfig would make more sense to me.

Best regards

Heinrich

> so the check has been dropped. I am not suggesting we bring it back,
> necessarily, but if we did, we could use it to specify the .config and
> defconfig files which are used by each board.
> 
> *Failing that*, I suggest a new 'name.brd' file in the board directory
> to contain this information, e.g.
> 
> # Contents of board/ti/am62x/beagleplay.brd:
> beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
> beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config
> 
> This could be parsed by buildman and other tools, to produce a list of
> available boards and to build each using a single name (e.g. make
> beagleplay-r5_defconfig)
> 
> What do people think?
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230803185144.1760729-2-sjg@chromium.org/

