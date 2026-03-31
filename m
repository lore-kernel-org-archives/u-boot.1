Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0E7FF60D9
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 08:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E2A83DBF;
	Tue, 31 Mar 2026 10:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dwQV5XvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0758405B; Tue, 31 Mar 2026 10:01:34 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9B483A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 10:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so45084845e9.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774944090; x=1775548890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q0jmWFb8kYEGW6uRdI3HDRIBSMmwvpkaB0JZ8W0D4MM=;
 b=dwQV5XvK5SNEMsc45Tb/as9AEfz2cMeEI76KHy1jIWoJcUv6/jey3MjWTWuF74+ZrV
 UYE460kaDOuc0N19hAUxfaofqqgHb6ycfv0AzWSFkIfh5QwvBtw/8nNkEuftxxvA8cRG
 UFA7Nr0INs2DCeYmqahP8vPH32Sf1Tt4tlYRZQHelF/y9aw9WON51ij3iHtYunv4SsVw
 eEiClKngMNBNbcmxbNzn7xvUYFCwZJqpaI4Y1ge4a3l1knrhE06KApnQ2HNy7S/x7v3i
 xT+nWHUKQ/cEIPF5qjlqP8mHdnWvexElkt/e4JSNnZJZHoO+gbJIl15ESGKI4kjvqTir
 yxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944090; x=1775548890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0jmWFb8kYEGW6uRdI3HDRIBSMmwvpkaB0JZ8W0D4MM=;
 b=QSg+nUR8aA4pYIreRPUr7681OcuILMBO/fRILNzSYsaDtbb8XQF+dQh/TzKQPkZ63F
 XNnbbJKVkEkhRzs93eIdeRS7LPNYrDYSNWMPwTS/eHI2i4X7OSc4YV6IKRKg2m185Fzx
 sdNSet4P5T3nC/00NxOxau0lu/8rAZL5Xpz4cBO89lEWZ5MIK41hclWxDnJwAeq+/jOj
 WCFsEdlJ9Yq0gBHDhjAnXMHHN6G0neAe4hE8+4D4kH+ofbjyOtc+/6ITEUBH3v4YnOz3
 FMJ5QfqQh+ogkrfIhEp6lM+/xLAaZ2/cmcqZDwRSsirQIOALp9++i59bP4sYs1Bcbztv
 4KLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5LAT1XXcihp3EBqv2KrGlzEs+9/Sxsqi59WrYNAt5qM6UPqO97e2X7uPs9Nme3AAzJysaoaU=@lists.denx.de
X-Gm-Message-State: AOJu0YzVJudDqafgO0f3jdvXl6bjUuFcmFVL0IKhgoktP2q/AoEkcrLS
 ARtMjmHQUf2qbyUOtYSvBpYdWEuB04/JdhFzXx/pzTQV2Dy1PsNQ4/LAktkBzHlygScinCAB46m
 zZKSQ
X-Gm-Gg: ATEYQzwFjHrSU8+BimxSqGw+zqUJKxC0I/TEy1Ns2plGWiY7ueakWOOaZgsP2QIT8lE
 dl5rJMoXE9f98xaRduJMaiSUd7h/dBQVfRF+oSkKUlGO4sQnGJscFm/wf+V1GD/nHZ3VNGjzMGq
 MCWuLoM+diDXecKe4F9yCSNiQnRXuCuLh/SlZAwSXITTLv5RQ3sAJeCOhuEXvl7T4H9m3unC2js
 Cz0AibLYpGBMQOsjFVj8Ls56q91O91kLb2b4zpJckha02WfoxAAmjFY+KQgAz8HvJzFyfV2cVwk
 CnR43Xjf5WAct3Wps4YuhNWmVrRdhavEqlT6whvIZ4PAARpGhA/oe3PbegyZblLoa8GO+WMQV6H
 SmaPNboP6kDGRMjOEzdwO7H0Q2PwConLx8mOpR8eY3Qn0gIt48gSiTT6VwlYi+UA3wEjelN3tNQ
 rKTnJ2yDKqUt3rizhjobalRiM9XlhWx3QzUCJLcksyd+cGKc6CLLzkslH+AMwcwfu/lf2uaMg6m
 NlmXNgUgyM+9ltFedvyUz1DYbd2PQcuxZN5fBoNSqmDkLwgGaEFDPC2XNPVVSQIqcvaToBI+cgI
 Fjzqyr86IxKMpMt/WSOh97Fi04gfi/IfZEPdazkrM+qQjEdp3CfO89mJqVwIgfYHWCBcyUWM7/r
 KDIJcycV7MFTgJ+YX0Cn7RZHxH3vokpJoB8AMfDZ9Pu8TodbGkCuaqF50DP4nS8Jv5KQbsLoKal
 /g4L8VTV+uZbFb6zmfqDI0lyaVWd7DoBUI9RQN5KBvjzvQMkwIIbEG8v3qskvns4aFc8VEVmc=
X-Received: by 2002:a05:600c:1d86:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-4872807470fmr251941425e9.24.1774944090076; 
 Tue, 31 Mar 2026 01:01:30 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c9250afsm10087065e9.36.2026.03.31.01.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 01:01:29 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/4] Relocate U-Boot in the last bank
Date: Tue, 31 Mar 2026 11:01:10 +0300
Message-ID: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
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

Hi,
This is v2 of [1]

There was a discussion recently on the mailing lists regarding our
management of memory above ram_top [0]. The tl;dr is that we have two problems.

The first one is that U-Boot always relocates to the top of the first available
bank unless there's special board code to sidestep that. The second is we don't
successfully deal with devices that can only do 32-bit DMA.

This patch series deals with the first problem by adding a Kconfig option
allowing platforms to relocate to the top of the last discovered bank.

It's worth noting that this is easily testable with QEMU

qemu-system-aarch64 -m 8192 -smp 2 -nographic -cpu cortex-a57 \
    -machine virt,secure=off \
    -bios u-boot.bin \
    -device virtio-rng-pci \
    -drive id=os,if=none,file="$image" \
    -device virtio-blk-device,drive=os \
    -object memory-backend-ram,id=ram0,size=4G \
    -object memory-backend-ram,id=ram1,size=4G \
    -numa node,memdev=ram0 \
    -numa node,memdev=ram1

# RELOCATE_LAST_BANK not set
Hit any key to stop autoboot: 0
=> bdinfo
[...]
relocaddr   = 0x000000013f66c000
reloc off   = 0x000000013f66c000
[...]
lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
 reserved.count = 0x2
 reserved[0]	[0x13d507000-0x13d509fff], 0x3000 bytes, flags: no-notify, no-overwrite
 reserved[1]	[0x13d50aff0-0x23fffffff], 0x102af5010 bytes, flags: no-overwrite
devicetree  = board
[...]
TLB addr    = 0x000000013ffe0000
irq_sp      = 0x000000013e50aff0
sp start    = 0x000000013e50aff0
Early malloc usage: e88 / 2000
=>

# RELOCATE_LAST_BANK enabled

=> bdinfo
[...]
relocaddr   = 0x000000023f66c000
reloc off   = 0x000000023f66c000
[...]
lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
 reserved.count = 0x2
 reserved[0]	[0x23d507000-0x23d509fff], 0x3000 bytes, flags: no-notify, no-overwrite
 reserved[1]	[0x23d50aff0-0x23fffffff], 0x2af5010 bytes, flags: no-overwrite
devicetree  = board
[...]
TLB addr    = 0x000000023ffe0000
irq_sp      = 0x000000023e50aff0
sp start    = 0x000000023e50aff0
Early malloc usage: e88 / 2000
=>

[1] https://lore.kernel.org/u-boot/20260326115111.1631261-1-ilias.apalodimas@linaro.org/

Changes since v1:
- Adjusted the commit message of patch #4 and explain potential
  breakages
- ram_size recalculation is now split in its own function
- Slighly better description of the Kconfig option
- error checking on fdtdec_setup_mem_ram_top()

Ilias Apalodimas (2):
  fdtdec: Introduce fdtdec_setup_ram_size() to determine the memory size
  common: Allow relocations on the top of the last bank

Marek Vasut (2):
  fdtdec: Deduplicate iterator function
  fdtdec: Introduce fdtdec_setup_mem_ram_top() to determine end of
    topmost DRAM bank

 Kconfig          |   7 ++++
 common/board_f.c |  15 +++++++
 include/fdtdec.h |  31 ++++++++++++++
 lib/fdtdec.c     | 105 ++++++++++++++++++++++++++++-------------------
 4 files changed, 115 insertions(+), 43 deletions(-)

--
2.53.0

