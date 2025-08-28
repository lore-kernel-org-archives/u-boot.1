Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57329CA0FF9
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 07:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7447983192;
	Thu, 28 Aug 2025 09:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="w1yaYqLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB5C831B4; Thu, 28 Aug 2025 09:05:28 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D25983106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 09:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-afebe21a1a3so106044066b.0
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1756364725; x=1756969525;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRLTbd5iVQG2yZ/z8IWPcyCR7G6Po/hw3D5pp855lx8=;
 b=w1yaYqLXUOStw0iVYWmh65ymqvaQaF4T3el37AWLK9b2ZlnybvtFRSMTzFnFnY7ts3
 M/INjh1MhDdOnNm/iWfrzTDxNLmOy8WaHV/9bYQQAxytv4QBEIGXYG0JoUqmBoGprSXY
 zm8akJ+wQQjhlzc/J9D7SDemn70eqiaIL4b87jbPX1RehB3F4rvjEpjqiXChWUxYipOc
 EfumPkgbvoeiMPRpA4r6msxeXTQ2wx4xaktSvN0XQ+QhernNU14Nhw+dAZ5dqbQra2AE
 rxf6DzmcrG4aLnaEhxzc5BZlLLx39Iy2E2gsf6R6DucgHHcCEw3c1UjuB32hCejAqCz3
 eW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756364725; x=1756969525;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FRLTbd5iVQG2yZ/z8IWPcyCR7G6Po/hw3D5pp855lx8=;
 b=nnblVZ5vXrrc+XDJ+4SgseqKuGUEeMy35r6daN/N9JEVsAX8LpPCHdqjj/1CeWFBp1
 0YnecBQMxmoDQ4xUoafw/K25QWVQXJTrDtHObBXQaCl4lvcBIZouikTOtZmx66jnnABu
 Lh+zKViG9SflfTLi75DGjikL2K3y9JQKb2G7N41xz2ulAv7fA1x8qFlUDpcfYdwBV2fs
 BjiwaT1ubGP0RVwSJC6tpqvt6Sl05cQTVgk9QkxYs1DV8R8p9Zu9slViPaK6+GPYuSoO
 CxuThJ4YvDo13NdtN5vF1bKC2+G+JAogKG3lkJ3XjwdoA0pWZHXGEhufRezhx7ga+NZ3
 QWcQ==
X-Gm-Message-State: AOJu0YzKrYK5uZUTeMzqxVeX6CnIidIVst/1+/CrcW0NdIp+C2IvZvkq
 CvKPxuXgtukbnjCd1LkiqqpFT/kS59d07mZA/f8KiZFHX319IUrWqPJy/YiBnRzDe64s9c0BYqk
 QKG6ZAESt
X-Gm-Gg: ASbGncuBFG5sfj+367DGhM82mXI7w9gk5/BeHXtsRbcWw1aQSY0ut3Xo6r+iBJ7C5F/
 pnlGOwIg2OPaLT6GOz80l4Vvm1fFeRsre2/463cIxOg+STXr2rRnTIGTt+sdCJU0LR8pX+qSZjx
 /kRqfc4J5Nwic23i9CP2i0cZ/ZYEltp2cA6ZVMXk1s8IPgevW0ol+9IwAHC7TQSRx5UpAbMPxog
 mNqJdmY1ZvsPQbtjYqFRr4bjziU9cPSP3BPkI6lBrquIf9FwCcxKZwHXpB4l+eBjMuiSsmJEP85
 XfHDLHIktd6ITCMVEZwJET3uO/MiTMVDjF6DgXdiRT9V36Lb9u+CHeP9LP/U1vT1caL7yG1zlEw
 jqrPa6bPJkZW/OlVRsky5M/qc0+m5w8nTy9g9gKCATgur5StI+O8=
X-Google-Smtp-Source: AGHT+IE0iLjAu0XZOXrr/SYfoDmXkFYuNCDCP3FAP8PLCGYr6+o5Y+uSSspmbEcJabZw0VV6SLS98Q==
X-Received: by 2002:a17:907:3f1d:b0:af9:21ed:6ebe with SMTP id
 a640c23a62f3a-afeafec8143mr696500266b.21.1756364725421; 
 Thu, 28 Aug 2025 00:05:25 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afe7b335575sm849937766b.14.2025.08.28.00.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 00:05:25 -0700 (PDT)
Message-ID: <f08d1d44-2bbb-45be-8eee-d81233e73c77@monstr.eu>
Date: Thu, 28 Aug 2025 09:05:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] AMD/Xilinx changes for 2026-01-rc1
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

please pull these patches to your next branch. The biggest patch is around UFS 
which has been acked by Neil. I hope that mbv in azure CI will just work fine 
because I am not running it. Please let me know if you see any issue.

Thanks,
Michal


The following changes since commit fceb37d802b65beb4713f17e9167e7ecc4dbbe67:

   Merge tag 'v2025.10-rc3' into next (2025-08-25 13:28:49 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.01-rc1

for you to fetch changes up to a51b7dfc6fec0aa76367114af59a7114b040b090:

   ufs: amd-versal2: Configure RMMI and M-PHY registers for HS mode (2025-08-26 
07:30:10 +0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.01-rc1

mbv:
- Add it to CI loop

versal2:
- Wire UFS driver

serial:
- Add support for OF_PLATDATA in uartlite

misc:
- Mark some structures as const

----------------------------------------------------------------
Michal Simek (7):
       xilinx: Make XILINX_OF_BOARD_DTB_ADDR depending on OF_BOARD only
       serial: uartlite: Use private data instead of platform
       serial: uartlite: Add support for OF_PLATDATA
       clk: zynqmp: Mark zynqmp_clk_ops as const
       mailbox: zynqmp-ipi: Mark zynqmp_ipi_dest_mbox_ops as const
       dm: core: Mark root_info as const
       CI: Wire mbv32 combinations

Venkatesh Yadav Abbarapu (1):
       ufs: amd-versal2: Configure RMMI and M-PHY registers for HS mode

  .azure-pipelines.yml              |  20 +++-
  .gitlab-ci.yml                    |  32 +++++-
  board/xilinx/Kconfig              |   2 +-
  drivers/clk/clk_zynqmp.c          |   2 +-
  drivers/core/root.c               |   2 +-
  drivers/mailbox/zynqmp-ipi.c      |   2 +-
  drivers/serial/serial_xuartlite.c |  39 +++++--
  drivers/ufs/ufs-amd-versal2.c     | 112 ++++++++++++++++++++
  drivers/ufs/ufs.c                 |  15 +++
  drivers/ufs/ufs.h                 |   3 +
  drivers/ufs/ufshcd-dwc.h          |   3 +
  11 files changed, 217 insertions(+), 15 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
