Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C251AD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2C3891B8;
	Fri, 18 Oct 2024 01:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f2XHx3PA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166D189121; Fri, 18 Oct 2024 01:12:22 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A37289143
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbe8119e21so10520876d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206738; x=1729811538; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J5rOyK2lk5fSEtvVVXrj5DLV6m+k/VU7JMMHPAEQCR0=;
 b=f2XHx3PAD5zBD5N91fA8H070vWcn/+Hhy5J+VUM6LiHYT4CUS6qDIws0dL7yiGhK6T
 /kKMSeITMyHfqQhbDjnWm+meJHQMvGWTAwVdyVAZ4rMFX26KjEE2pKK0I8+6ALvBYCjU
 cciMwhXK6CfHY6Q642X5PkP44r8LyPagJaFOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206738; x=1729811538;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J5rOyK2lk5fSEtvVVXrj5DLV6m+k/VU7JMMHPAEQCR0=;
 b=fuTwl6GiQzSFqRbSSet/22QA7nWde7am+dN75qhOf//6VyIb/4PrmQA8F45n5UzCbr
 MZL/OpToWCKi9c3C1uwLoHgIg//WXh5dw8vMmqJyfTGaop6yhI1ad8AevtzSf9oufOph
 TmEcWjCGadlHGdlc6cWlduc6zw1tDWZaoLNzpDtF/ThcmUImNvSEZRYX/5EODyCI6gxT
 7rxYJIsAk+2a9QNLfRq15Qshryrf6kqiaBqnXKXOoOzKaWjl7fCeG/XdWGkJy0NOsdID
 Vu7Db1iYPpWiTy5UGfQSrnhUrS2S0p1ShzdFQ3BzMd9IdvZ0+bSjMRhAOPo9V8esaq8z
 bgcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+//yZpqOlKQJlvOrniBIXNw7Ih6BTJmia4mvUxvHULKtTctm2FS65+cnHiaCoVu3PKtf5mSs=@lists.denx.de
X-Gm-Message-State: AOJu0YxaDjUOjNLOqRb9j58htV4QmQ1n4e7HAaI6LnT0kFd8hNfqAUFz
 5XXptqNBl7ZGqA5Qd0fbRuXUrU3ARb5GYkM6MQdk7U3+f5DFIq3JRuuWZEEZlxe0VAu3Qlr07Z7
 Eri9ewk2QWftKmcwkW3BODY+8UMLIF53ZHVF7mvweFoh01qE=
X-Google-Smtp-Source: AGHT+IH73b6/ecGK0Fr9oStz+wXVy0kuclVIwDIqVR6zRjI5xJ7GcVlV5MSxAlxC0jgVlCUMZGnz8dJG88zM3wqz93E=
X-Received: by 2002:a05:6214:3f93:b0:6cb:fb94:d435 with SMTP id
 6a1803df08f44-6cde15d8888mr9526286d6.36.1729206738511; Thu, 17 Oct 2024
 16:12:18 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:18 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <87wmpcffeb.fsf@baylibre.com>
References: <87wmpcffeb.fsf@baylibre.com>
 <20240306185921.1854109-1-dimorinny@google.com>
Date: Thu, 17 Oct 2024 16:12:18 -0700
X-Google-Sender-Auth: BcdCzpkJU7yVQPUece-epoHpKC8
Message-ID: <CAFLszThkvvbK-BmjnO+0rAyq=sSZ8vgz=ZvSASiAA6V5pwoKfQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio: blk: introduce virtio-block erase support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, 
 Cody Schuffelen <schuffelen@google.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Ying-Chun Liu <paul.liu@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

Hi Dmitrii,

Thank you for the patch.

I'm not the virtio maintainer in U-Boot:

/mnt/work/upstream/u-boot/ $ ./scripts/get_maintainer.pl drivers/virtio/
Bin Meng <bmeng.cn@gmail.com> (maintainer:VirtIO)
[...]

I've added Bin to the Cc list, please include him if you re-submit.

On mer., mars 06, 2024 at 18:59, Dmitrii Merkurev <dimorinny@google.com> wrote:

> Co-developed-by: Cody Schuffelen <schuffelen@google.com>
> Signed-off-by: Cody Schuffelen <schuffelen@google.com>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>

I'm not super familiar with virtio, so I've not reviewed this.

However, I tested the sandbox unit tests:

uboot@db354723333a:/mnt/work/upstream/u-boot$ ./u-boot -T -c "ut dm virtio*"
Bloblist at b000 not found (err=-2)
sandbox_serial serial: pinctrl_select_state_full:
uclass_get_device_by_phandle_id: err=-19


U-Boot 2024.04-00137-g075feb52299 (Apr 05 2024 - 07:12:35 +0000)

Reset Status: WARM Reset Status: COLD
Model: sandbox
DRAM:  256 MiB
[nvmxip-qspi1@08000000]: the block device blk#2 ready for use
[nvmxip-qspi2@08200000]: the block device blk#2 ready for use
Core:  286 devices, 101 uclasses, devicetree: board
WDT:   Not starting wdt-gpio-toggle
WDT:   Not starting wdt-gpio-level
WDT:   Not starting wdt@0
NAND:  4100 MiB
MMC:   mmc2: 2 (SD), mmc1: 1 (SD), mmc0: 0 (SD)
Loading Environment from nowhere... OK
In:    serial,cros-ec-keyb,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: sandbox
Net:   eth0: eth@10002000, eth5: eth@10003000, eth3: sbe5, eth6:
eth@10004000, eth8: phy-test-eth, eth4: dsa-test-eth, eth2: lan0,
eth7: lan1
Test: dm_test_virtio_all_ops: virtio_device.c
Test: dm_test_virtio_all_ops: virtio_device.c (flat tree)
Test: dm_test_virtio_base: virtio_device.c
Test: dm_test_virtio_base: virtio_device.c (flat tree)
Test: dm_test_virtio_missing_ops: virtio.c
Test: dm_test_virtio_missing_ops: virtio.c (flat tree)
Test: dm_test_virtio_remove: virtio_device.c
Test: dm_test_virtio_remove: virtio_device.c (flat tree)
Test: dm_test_virtio_ring: virtio_device.c
Test: dm_test_virtio_ring: virtio_device.c (flat tree)
Test: dm_test_virtio_rng_check_len: virtio_rng.c
Test: dm_test_virtio_rng_check_len: virtio_rng.c (flat tree)
Failures: 0

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # sandbox

> ---
>  drivers/virtio/virtio_blk.c | 91 +++++++++++++++++++++++++++++++------
>  drivers/virtio/virtio_blk.h | 47 +++++++++++++++++++
>  2 files changed, 124 insertions(+), 14 deletions(-)
>
Applied to u-boot-dm, thanks!
