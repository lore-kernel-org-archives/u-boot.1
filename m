Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBAEE63F33
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 07:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0AF68063E;
	Mon, 16 Feb 2026 08:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="mDPayeqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B079E80B98; Mon, 16 Feb 2026 08:37:23 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6100E80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 08:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8f992167dcso341801266b.1
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 23:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1771227441; x=1771832241;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQzKzGJA7rLMrP5ZqZV5V/8vJCAbHs+l4xNI93sD7W8=;
 b=mDPayeqxb6yKtzVQRxsMymxVFqATfkhsB/rtsFEJq1ThpQxIOYEE4YWWht6NbNhiae
 v87kOBtrDdONDUFq0pr4pVv92XWtilTicsLRXqBcarHV9kWOlXGWfQBiNiTFpBToplcq
 ilqZgvwqaU/O/nBt5OccnYL5ZEewr8KUrBOAGBWpz0o7l6EdXemOMAdNOobfmEUehu/5
 z55XPL60xk7LiRevI3ZTCnX/DlBttyLm3UE4mNeDkVpwt+PzKs53EHuFcMMvL2jkb75A
 0FNec7Q3KXOo18kzQNjiY2rHQyRJBR1DELcg8A/HX2PyoCKG4biNP1vPfafibRFbNW24
 Q1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771227441; x=1771832241;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YQzKzGJA7rLMrP5ZqZV5V/8vJCAbHs+l4xNI93sD7W8=;
 b=B5Wg9Ueh1YHM2YYCVAA8PSYjWwP0u5a8+xplZovZQmFpQb8O8xBEf7Sx6qz6B7JEj6
 fpw0rKI1wlcuR0lI5HkA66ZaJGXbY9iKtT8HwupsyK5lQuKAi38L+ZOO86n7RlugtewA
 ybTark891XSg3SE/K8rLpEFAEi+T9MX1X1WnzR8KSVOVj/ONl0glwy5WR3m0bUXsFFWi
 r9U2HjEGKhBUiCAUZXsO7l4mfeWXoORKKxsTmLGR0cNdlkF6+UgnckzVP1ZFt7LWh18H
 GiyAf6070tpwmXB4DCvOYWm0ZYrTK3MI/vheHgQe/T+OkJx21J0UFM5q9PaFn1VUM00B
 SJWA==
X-Gm-Message-State: AOJu0YxqEoRYlF4BC6c50AjGFS7II41mQuau4C9m3qsCqLod5Kw77ZPt
 MUXZHaSQX0a1p/a6pqJRO5KSLpgv56jHVUh6MMasi7AMLk8Eddn8LjC3e0ZYUvkgUOpnrer9yvz
 4It4Vzg==
X-Gm-Gg: AZuq6aJBVHgWgm1grBn9jzRYPkgn+cHJgxGdb/9r43rS0IJT2/bZwQbpmQSMdS/jUzQ
 MOQIccGOZ0TOy3aNb4/YyJdmxW78X+xdgLcvL+VvqM8lc6oX8aHyvcnlvPNNE+NsGHLoQqGl6Vs
 GNP4dyCPJ4ZU4q2DicI6fFA2B7wJ/b+udfJojtPOGzmdCLKw5OzfQaUEcgZsZWW23lHXmqtEW3d
 nVDWWMjGyP097WW4ZHHaefn/AqIQ67uOM9O8N3umZ0uff/IJ6nUjug1guJzLfGqGpBZTYpzX7wn
 C1wZE/wjbMZz8Wl9ZYxzWEaUh72Rz/oqhClJNjPD633H0YXjnsG+l7hUg17OXAlArR6I+gBrt5t
 OFdNezs7OIVDbTXCIskqvIBoNycLsBvVPMpgtiHd3hzqznZPxRZYKdOd41UFoM6VRD8tPUKG7FB
 aoYemPnPcEJMWItXmT/tlvJSFIPkgLVjiW0p7x1QA+
X-Received: by 2002:a17:907:1c21:b0:b7a:1bde:1222 with SMTP id
 a640c23a62f3a-b8fb4672866mr492769266b.63.1771227440567; 
 Sun, 15 Feb 2026 23:37:20 -0800 (PST)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc7691f0esm234585666b.60.2026.02.15.23.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Feb 2026 23:37:20 -0800 (PST)
Message-ID: <aa956239-7433-41f9-9189-10a95e5633b9@monstr.eu>
Date: Mon, 16 Feb 2026 08:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] AMD/Xilinx changes for 2026-07-rc1
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

Hi Tom,

please pull these patches to your next branch.

Thanks,
Michal

The following changes since commit 9e6b66409a3235ae73f1937929fe025911165bbb:

   Merge tag 'ab-next-11022026' of 
https://source.denx.de/u-boot/custodians/u-boot-tpm into next (2026-02-11 
10:42:18 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.07-rc1

for you to fetch changes up to 601e08e0b7abd15784d19daa05692fae350e5027:

   arm64: zynqmp: Wire gpio-delay driver for USB hub reset (2026-02-13 08:16:25 
+0100)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.07-rc1

gpio:
- Add gpio delay driver

zynqmp:
- Wire gpio usb delay
- Enable SPL pinctrl per pin

xilinx:
- Enable NFS support

versal2:
- Extend DDR initialization

zynqmp-rtc:
- Use clock framework for calibration value

----------------------------------------------------------------
Michal Simek (4):
       xilinx: mbv: Disable EFI loader
       gpio: Add GPIO delay driver
       xilinx: Enable GPIO delay driver on Kria platforms
       arm64: zynqmp: Wire gpio-delay driver for USB hub reset

Pranav Sanwal (2):
       fdtdec: Add declaration for get_next_memory_node() helper
       arm64: versal2: Populate DRAM banks before page table size calculation

Pranav Tilak (2):
       rtc: zynqmp: Add clock framework support with calibration fallback
       xilinx: Enable NFS support for all Xilinx platforms

Sean Anderson (1):
       pinctrl: zynqmp: Add SPL support

  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso         |  13 +-
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso         |  16 ++-
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso         |  16 ++-
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso         |  13 +-
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso         |  11 +-
  arch/arm/mach-versal2/cpu.c                    |  55 ++++++--
  arch/arm/mach-versal2/include/mach/sys_proto.h |   4 +-
  board/amd/versal2/board.c                      |  75 ++++++++---
  configs/amd_versal2_virt_defconfig             |   1 +
  configs/xilinx_mbv32_defconfig                 |   1 +
  configs/xilinx_versal_net_virt_defconfig       |   1 +
  configs/xilinx_versal_virt_defconfig           |   1 +
  configs/xilinx_zynqmp_kria_defconfig           |   1 +
  configs/xilinx_zynqmp_virt_defconfig           |   1 +
  drivers/firmware/firmware-zynqmp.c             | 101 ++++++++++++++
  drivers/gpio/Kconfig                           |   8 ++
  drivers/gpio/Makefile                          |   1 +
  drivers/gpio/gpio-delay.c                      | 139 ++++++++++++++++++++
  drivers/pinctrl/Kconfig                        |   8 ++
  drivers/pinctrl/Makefile                       |   2 +-
  drivers/pinctrl/pinctrl-zynqmp.c               |   8 +-
  drivers/rtc/zynqmp_rtc.c                       |  64 ++++++---
  include/fdtdec.h                               |  24 ++++
  include/zynqmp_firmware.h                      |   5 +
  lib/fdtdec.c                                   |   7 +-
  25 files changed, 508 insertions(+), 68 deletions(-)
  create mode 100644 drivers/gpio/gpio-delay.c

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
