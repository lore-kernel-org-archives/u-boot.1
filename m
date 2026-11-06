Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B09A606A33F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wG4C6oVn;
	dkim=pass (2048-bit key, unprotected) header.d=monstr-eu.20260707.gappssmtp.com header.i=@monstr-eu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tAabN+em
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67E2940963;
	Fri,  6 Nov 2026 10:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sWHbh8aY9TUw; Fri,  6 Nov 2026 10:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1EC6E40958
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793959690;
	b=qdGsftSE+u+jrbPzFIGdF+vcKAaCIo4ZSOpdpjlYmTZuEBS2onzUB7X7yezaWMmY2mkj
	 ce+HvLza6rY9Xk3r/DFI9filRloWgXcrG5DBNpvEmR328Gu944+qIDP66D9E2pp1ZW3qm
	 bASAgcCyp1VkivcRn/TlsCtIGNmkehkj/OVI/u4jjvPLzYSvekM5fiMZjAh7nsh4Z5vnq
	 tA/Kj6eehcHR7cc9jndV/nrr2goonUsM3TLpi5PU1BvJ+1U/GGsabc1avgCa4D5T6tfno
	 VlBbjICydIZ/L7Jg0UUmNVMdIMSrhP/0opuKhPW9i/wOBMeWh6FlddAS0uFNsaGX2HA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793959690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=shtx1ZoXpLhqYTI35s3VY/MlGEAmb3AbNLEHpxqzqxc=;
	b=gOBbyBTpchr7cc4lKv3dN2wSnOWqp43Jw/NHfwPX6fy8FYB3+WE5//sjcjtmpVVIfzII
	 7IQz6lzgoR4wyriUDbcLfrqFj9Il0VDD4K88qQE2uVobTTH17rBr96K793m7jJU7vBU6B
	 EO5xsSLzXGXopQkGsEnPtSZqhZ1qkWrY4RG3eN6Z1oz0N9XlcNmSBXNQoCjEjwJXJSTIt
	 Op6D4yb589vrlgcFqnLL7Et6xwWoCNgOQIUjHMjZTGMgjzizxnyV8cwNHz0lrUnM2eE1Z
	 tXhEDCPl0+R95IjgVNUQ/LjCvYj83YOP6BT+cXnQPVWRZVk6LmwL7XvsnMUJpfzbv1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793959690;
	bh=shtx1ZoXpLhqYTI35s3VY/MlGEAmb3AbNLEHpxqzqxc=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wG4C6oVnb9/oa0cCeQxQXaKVqRLe1qXpTNQ6trXev0omDTaIEFSYHAPrGRRqgjAYa
	 2J5jizNOVffICi44uAAnbDmByTRoi1pF1Hbjnz9sV5xHOb9MUt1UdaFtHMO/BCnB04
	 2P/LUAlwYdfUo7loujm/d5BtXQSkjS9zvZUr5W1CwGSq4H+flcLQclx8DNOG7NYXKv
	 mhIV4SewJE0CV5LiNuf5eMid6GF1htOStuzKouB884jY9P7/JJuoAc9dghTF/1IoK4
	 YMHhusiGVIwAx47h+x2T/yujFz29dnz+OI2BDaC3MBhqPR0V68tSM5aa1NfN1aC3S/
	 ZgK3yH2xqdYfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EC6E40958;
	Fri,  6 Nov 2026 10:08:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A0BF31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BC67809E7
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4mAVQ3xk60s for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 10:08:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08FEE80A50
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20260707.gappssmtp.com
 header.i=@monstr-eu.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=tAabN+em
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08FEE80A50
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:08:03 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c4d28f75d62so52446166b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 02:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20260707.gappssmtp.com; s=20260707; t=1793959682; x=1794564482;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=shtx1ZoXpLhqYTI35s3VY/MlGEAmb3AbNLEHpxqzqxc=;
 b=tAabN+emCovqsU7YwVNC3Qg+ieCQzvGfkqRHPRw26GfvmGjQJRNJgxRsLYyQFh8FOf
 e+xJKvGT39ubkBYgec6GZ09ul0VZ7rnpZ32Q7TII2j5WACaBe4fXoStueSw+tWKYIxhr
 J/t8C4mqxE5w9b2KrwsKvJW3esxO9RFmK2EatoLRXRtOl28N2y+NYUQCsmZx9KProEM0
 7wNPO4HjQE4fWt68BOS6ish9QpPmP+TMsfhPQXuUf4vQLudIqPYBOLhLUEQRuptifRyC
 gbHUraN3W7MREFTw5xx7vWyCfjrxKZrqtDK09WMiR0YIBGQV2IL4q2vcaAezqg5NbCZg
 TSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793959682; x=1794564482;
 h=content-transfer-encoding:content-type:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=shtx1ZoXpLhqYTI35s3VY/MlGEAmb3AbNLEHpxqzqxc=;
 b=IJd2+Wg9MjPtCSL+6CnXanUIPfxkWPFuFNFsBiLvX7Pu/qGlSZhc6cBKMQzEHwZc4x
 LaqEp+y2AdszWl3cbxB4YjU16YsiUZx+itqXncsBKyxnj+OrPyyl8hw8XZwdDqOQ8NTP
 AZIySFuUtq62pSnnhU1z/lK6nz3+W1OCuM8K711j/EYspkdmrBi+V+NmHBWncC84hWyq
 fTh8U10lBoMEZbD4d23Y92B51ZqQl5iu6/OdxtcAAfqRTkEL9GNfVuNWpr7uaoHXql+g
 L/8W15nXdTQsMP5oKq2E4Ni4jsVLuV6ZsU7rkLOucLpb5RaN89zrEEortJ8jumm7lJo0
 ZKmw==
X-Gm-Message-State: APuU4Z+EwxS+WVQdqdkE+6zx3FHu9X1NW/fzBQH2cbwUMfeXg1hDTQru
 fLBZMkEFG+bC2aM9KLSwDFj9uelQPk77eeb5Cjx+zIPKvoS0MokIuvxAZ2sCACzBRVdiGyxriDd
 OqNCjXmwH
X-Gm-Gg: AYBFou2UQ6NWgdgrxbHpmAwyd/M3IjrDVJgajJ4JyTVKGesvWJP38+i7yzkmXeTU2+2
 +B2NN7pws2PDD6iA6y1WVhFR3C/+OLegZVUGLD/aYwP/QRtrcQ8IowIjPo9GbJMwt9kbgD8q0Ss
 p1KPFgVGM3aqzsDdGH4H56rV7gwwEppS9J8QOKZIHWtOZsWpxIOPTv8SGHs2xc5Up0POjH/BQPl
 0QHnlsjdg8NB3pMhREiHMukRBcCHihVWf/ER0hLDM8ddjAbKRiOvbAYJoqOXL1GlQP9Ne7cfDIb
 R6hMvQKtBe/12tIYjENpX/lwCEbsgkAiE12sWN2K8RvjRpGttyPYNLDZiskmyNQWDSt3TM+Thq2
 rJT30Du4Ei7SSbSD/xZjLLZdpF7o82LxJfzSYjkEqfhAW4SbWwByCHKKGjeukkLLRiZ3ECKpH2S
 B1j1vKHQq/0LyNDsS4ZDf+7lF0tqrBtyuYQgOth8Eo78wvt0v1aJtknwY7CuVwIVWskmP7cfkGP
 IONhKq6Oc0QojMY1621qlMHG2PaO/vNMuK9f4n537l2Mv75NQNCtAGtC8fkmzR0h5FDOTO3SQQQ
 O6iCTS/qOvnDbdsWe5ZEY49JeDWGQKBX+u5QQCpyQhteyS6AdTr9J7Nindf5kQS2+Z422jGgZJI
 /OdD8oz6efLph3hyDRjUM90mjiRF34YDPO8q0vH3Avz2wTJH7yEfsrJodzA==
X-Received: by 2002:a17:907:2d92:b0:c2e:7da8:f54f with SMTP id
 a640c23a62f3a-c4d34c8b118mr173237366b.38.1793959681009; 
 Fri, 06 Nov 2026 02:08:01 -0800 (PST)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562eaf9sm65964566b.29.2026.11.06.02.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 02:08:00 -0800 (PST)
Message-ID: <544a283d-2fde-454e-9240-af6f05f09d9d@monstr.eu>
Date: Fri, 6 Nov 2026 11:07:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx/fpga patches for v2027.01-rc2
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

please pull these changes to your tree. I have run CI yesterday
https://git.u-boot-project.org/u-boot/custodians/u-boot-amd/-/pipelines/1833
without any issue.
But I found that one patch wasn't taken via b4 that's why I have rebased it on 
the latest&greatest and pushed it.

There are also some SPI changes pending but they should go to next version 
because we are going to rc2 and I would like others to test them on their boards.

Thanks,
Michal

The following changes since commit 709a97a05df66e394f40d249105d0baade46f107:

   Merge tag 'efi-2027-01-rc2' of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-11-05 07:58:42 
-0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git 
tags/xilinx-for-v2027.01-rc2

for you to fetch changes up to 087f6651756cd90053e6766cbe5dc36cd741be1d:

   board: zynqmp: Remove 1 second delay in psu_uboot_init (2026-11-06 10:43:39 
+0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2027.01-rc2

mbv:
- DT updates
- Defconfig updates with spi fragment
- Update memory layout

pcie:
- Add support for CPM6 host1

fru:
- harden FRU parsing against malformed data

fpga:
- zynq: fix bitstream header scan length checks
- zynqmp: fix pointer arithmetic in zynqmp_align_dma_buffer()

zynqmp:
- Defconfig updates
- DT updates
- spl: Remove 1s clock delay

versal2:
- Defconfig updates

firmware:
- Fix PM_REGNODE_PMC_TAP node ID

versal:
- mini: Skip relocation

spi:
- cadence: Fix double reset assert

----------------------------------------------------------------
Akshay Belsare (1):
       firmware: zynqmp: fix PM_REGNODE_PMC_TAP node ID collision

Michal Simek (8):
       riscv: dts: mbv: Update bootph-all in xilinx-mbv64 DT
       xilinx: mbv: Enable GPIO driver and command
       xilinx: mbv: Enable CMD_EXCEPTION
       xilinx: mbv: Add support for using bigger boot images via bootm
       xilinx: mbv: Enable MTD command by default
       arm64: versal2: Disable FF-A
       arm64: dts: xilinx: drop bias-high-impedance on SDIO CD/WP pins
       arm64: zynqmp: Fix DTOVL warning about graphs in kv/kr260

Mike Looijmans (1):
       board: zynqmp: Remove 1 second delay in psu_uboot_init

Padmarao Begari (6):
       configs: versal: Skip relocation for mini OSPI
       spi: cadence_qspi: Fix double reset assert
       xilinx: mbv: Enable Ethernet support
       xilinx: mbv: Update stack, heap, and OpenSBI memory
       xilinx: mbv: Disable SPL raw image support
       xilinx: mbv: Add SPI-related board config

Pranav Sanwal (1):
       pci: dw_amd: Enable CPM6 host1 and quiesce interrupts on init

Pranav Tilak (3):
       xilinx: fru: Add bounds checks when parsing FRU data
       xilinx: fru: Fix wrong argv index in do_fru_capture() addr check
       xilinx: fru: Use sizeof() for board header size

Prasad Kummari (1):
       amd: versal2: Disable EEMI clk reset power and switch to SCMI

Sandeep Gundlupet Raju (2):
       riscv: dts: mbv: Update mem size to 2GB
       xilinx: mbv: Add sys prompt for mbv32 and mbv64

Senthil Nathan Thangaraj (1):
       amd: versal2: Enable SCMI power domain support

Shaikh Mohammed Suhan (1):
       arm64: dts: zynqmp: Add post-init provider for USB424 USB3 hub

Suraj Kakade (4):
       fpga: zynqmppl: fix pointer arithmetic in zynqmp_align_dma_buffer()
       fpga: zynqpl: use actread for bitstream scan in zynq_loadfs
       fpga: zynqpl: stop header scan once a full header can't fit
       configs: zynqmp: Enable Xilinx AXI Quad SPI driver

  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso    |   1 +
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso    |   5 +
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso    |   5 +
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso    |   6 +-
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso    |   6 +-
  arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts  |   4 -
  arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts  |   2 -
  arch/arm/dts/zynqmp-zcu100-revC.dts       |   1 -
  arch/arm/dts/zynqmp-zcu102-revA.dts       |   2 -
  arch/arm/dts/zynqmp-zcu104-revA.dts       |   1 -
  arch/arm/dts/zynqmp-zcu104-revC.dts       |   1 -
  arch/arm/dts/zynqmp-zcu106-revA.dts       |   2 -
  arch/arm/dts/zynqmp-zcu111-revA.dts       |   1 -
  arch/riscv/dts/xilinx-mbv64.dts           |   8 +-
  board/xilinx/common/board.c               |   7 +-
  board/xilinx/common/fru.c                 |  14 ++-
  board/xilinx/common/fru.h                 |   5 +-
  board/xilinx/common/fru_ops.c             | 103 +++++++++++++----
  board/xilinx/zynqmp/zynqmp.c              |   3 -
  configs/amd_versal2_virt_defconfig        |   5 +-
  configs/xilinx_mbv32_defconfig            |  24 +++-
  configs/xilinx_mbv32_smode_defconfig      |   2 +-
  configs/xilinx_mbv64_defconfig            |   1 +
  configs/xilinx_mbv64_smode_defconfig      |   2 +-
  configs/xilinx_mbv_spi.config             |  14 +++
  configs/xilinx_versal_mini_ospi_defconfig |   9 +-
  configs/xilinx_zynqmp_virt_defconfig      |   1 +
  drivers/fpga/zynqmppl.c                   |   2 +-
  drivers/fpga/zynqpl.c                     |   4 +-
  drivers/pci/pcie_dw_amd.c                 | 116 +++++++++++++++++---
  drivers/spi/cadence_qspi.c                |  10 +-
  drivers/spi/cadence_qspi.h                |   1 +
  include/zynqmp_firmware.h                 |   2 +-
  33 files changed, 280 insertions(+), 90 deletions(-)
  create mode 100644 configs/xilinx_mbv_spi.config

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
