Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326EAD3C92F
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 07:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604B488FE8;
	Sun, 20 Oct 2024 09:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Enwmqlyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5128901A; Sun, 20 Oct 2024 09:23:03 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D7088FC7
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 09:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C8D0C3F1C9
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 07:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729408976;
 bh=6bw8Ava74TexEfC5oUGO04G+P/AYKnhrAq2+BlLDPSA=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=Enwmqlyn+348/P3cZ+36BRsw83cK/3Yc9hetOxhoDGYuQNy3Q2MxgYvPxS1E2wX0e
 fY+sy/B4rogJs+IWJ49ajgNI8glc3XdxTd+aFXG850Cyp2DSzyIdhGXKOBNdQ640nf
 FI3gmIJcUxzngxZuK565NrsXiS1YGOjdTP9NUcRrd7x0qQwxypd3X+7xZRGmTBDNEn
 FU+RsFdZuFI7sDRQpyVExnaKgQwxcd+YmC/LvHpFLXb9EZ+f0HY+hV6I1NoQmKUOXr
 u0GJ3zhZCqUWopcYnr8sreS1ylkosi0Us+4jK07BZrUgDQk1jVE6lxsitY1G/Hh8EC
 uHE2KV0boPvvw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315544642eso26034225e9.3
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 00:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729408976; x=1730013776;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6bw8Ava74TexEfC5oUGO04G+P/AYKnhrAq2+BlLDPSA=;
 b=G1bUb77xnfJbdFfXWBAGYkGr0Ww+xxicvJYgE9uZmaZQWpnBaw51Phm3aMmTgYBLJx
 0YV08ppWlwEsyYnJJTpzt+hzrPQnHFlBtNzI8g2LBq4khWu0W/kmrl+R1aIP9WQGfZRF
 ucnZZj7b5xmEhRGsVED7I6xkY4PMkWJyrT6SnluwDKt3qYU4ERCnp0oZAG0d8jopoG5N
 oMBGTQg3wU3sZgFAMNl+5M39jC/eERd1T1ijDHID9L8WzxS2N1m+YMTjLzf9pjUP9LWV
 xPt9C+v67C6eIaYSCiYAaeBU6EyCepnR+15wL87W6GPArdi9yaBZKRqBuvfsqhxC5n1+
 LpyQ==
X-Gm-Message-State: AOJu0YzPmvZwX8gjd275xx77WHMndYdKnFbxcn1uOD+ZTeuNU66TVz9v
 3H20TNYRkiQE5ri5iTeZYpmB1F6eOL9AikZHGQreuuBKsO/4PcLma0vn74bBUwhyPgx0ht8rkLd
 k35dW4eiEuNWvY/dG3dpNJMIfNtIGbeFSli2GYkof1MYnRH8RdRQskyqk/L+Mzao8/iI=
X-Received: by 2002:a05:600c:4687:b0:431:4f5e:1f61 with SMTP id
 5b1f17b1804b1-43161637703mr66762295e9.14.1729408976132; 
 Sun, 20 Oct 2024 00:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkeKJlQva7QJm9sXE30gKU7swb3xzPUG8tMwYXQSflN5fCAwn6ZbwfIdlL4/5sGomykFWYLw==
X-Received: by 2002:a05:600c:4687:b0:431:4f5e:1f61 with SMTP id
 5b1f17b1804b1-43161637703mr66762135e9.14.1729408975736; 
 Sun, 20 Oct 2024 00:22:55 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:2078:811:73f:9fa1:af4c?
 ([2a02:3035:6e0:2078:811:73f:9fa1:af4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f50b15csm16094585e9.0.2024.10.20.00.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 00:22:55 -0700 (PDT)
Message-ID: <5b347d0c-65a2-400d-b7d9-470b1dd3fb41@canonical.com>
Date: Sun, 20 Oct 2024 09:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chintan Vankar <c-vankar@ti.com>, Ken Kurematsu <k.kurematsu@nskint.co.jp>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request efi-2025-01-rc1-2
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

Dear Tom,

The following changes since commit f1de0b97d1cbfd982b7a507962bb21b12a024b2f:

   Merge patch series "Cleanup dma device in spl and move dma 
channel[0]" (2024-10-17 18:21:20 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/efi-2025-01-rc1-2

for you to fetch changes up to 640c6c6cbaafa1b049118d431cf218d9dce3cdd8:

   efi_driver: use blk_create_devicef() (2024-10-18 17:05:19 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22810

----------------------------------------------------------------
Pull request efi-2025-01-rc1-2

Documentation:

* Add document describing Ethernet boot on AM62x SoC
* Fix typo in blkmap command example

UEFI:

* Avoid #ifdef in efi_setup.c
* Reduce message noisiness if ESP is missing
* Remove ERROR:, WARNING: prefixes in messages
* Use blk_create_devicef() in block device driver

Others:

* Let CONFIG_CMD_WGET depend on CONFIG_CMD_NET

----------------------------------------------------------------
Chintan Vankar (1):
       doc: board: ti: am62x_sk: Add document for Ethernet boot on AM62x 
SoC.

Heinrich Schuchardt (6):
       cmd: wget: CONFIG_CMD_WGET must depend on CONFIG_CMD_NET
       efi_loader: avoid #ifdef in efi_setup.c
       efi_loader: reduce noisiness if ESP is missing
       efi_loader: add missing lf in error message
       efi_loader: remove ERROR:, WARNING: prefixes in messages
       efi_driver: use blk_create_devicef()

Ken Kurematsu (1):
       doc: blkmap: Fix typo in command example

  cmd/Kconfig                       |   1 +
  doc/board/ti/am62x_sk.rst         | 196 
++++++++++++++++++++++++++++++++++++++
  doc/usage/blkmap.rst              |   2 +-
  lib/efi_driver/efi_block_device.c |   8 +-
  lib/efi_loader/efi_helper.c       |  20 ++--
  lib/efi_loader/efi_memory.c       |   2 +-
  lib/efi_loader/efi_setup.c        |  25 ++---
  lib/efi_loader/efi_var_file.c     |  22 +++--
  8 files changed, 236 insertions(+), 40 deletions(-)

