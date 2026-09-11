Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533EDC88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 123058122F;
	Fri, 11 Sep 2026 10:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oSHOexHckkkf; Fri, 11 Sep 2026 10:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AE38481224
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789121392;
	b=cQlDdgKoin20P+0aQra2d791C02pNPwEOE90osAYQwkVlbsp65+2H4L15FxJJALHq0Xv
	 7KLAzAWjgcq02zi0mDzU17dKZP3d6YeZpYnrAIOZdsMpbsA3o/qdA6fhSAYg3JjFnviW4
	 L0nSrUHX2uBIYibfhAX7jRVzyO9JBj7m1L6xJj0V7e6ZoG50RmQWvqpUtDYP98t8Tnqjh
	 EfpS6rr+ZxDqnJ/Goskk4H7g9E+fY4EZQDAsehTfYXjbmyT2G+g9Xu5fHmcwgr5YBRF3x
	 EA4Mg85T9WgU9qLB3TquPudD2IN2Fg2jh9h7Tywi3a3J0fXu+NyDHDM93q3CSmFN+eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789121392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ft5ECzuUhSkzh7d3FkbvLS3Gp0Rg3vG4PJY5BBoQ7fk=;
	b=P1fJ/yL1y39Q85p0s4pMvKsjmHPL9mfAHMfJC2M/b84piWI00WTLbZ9eaGhr7wEC0+BM
	 UPfpKzZ7307WxOA7grJgn3/UqXzcX3OcPEyfLMIZ7p/SKxL7nwKZ2uSonAa/B/7a/LCEK
	 Y8FFbahLwG5quZ0TxBQ2q7KIbwMoNQZR6xv9Du+0OHPTATqUpjLD/+H1OTs04pbMCd96y
	 7A+VFZTQ5G2iTQy9IX2keOJCE0nLzV3KiyfSMSDFqcOxSRl9zwQRw8FUfgTn9vl9e75pK
	 uQADgaf8sXSgGWY9v8+jw6FFLHTY8qOO4sb0VPiabPo2pLwky2fWP9So7d4GHPwNlmA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789121392;
	bh=Ft5ECzuUhSkzh7d3FkbvLS3Gp0Rg3vG4PJY5BBoQ7fk=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bDqnrH7xWaHMORq4oRhT5343AfTHI39f0QddloJTx15fazCwkcShCiRlxqaglIdqA
	 fsI2okv+6+LJfLqnq5hZXzlsj9LbfiNWpnnPTi9xOiChTb2HhgpEZSA4hdjBJlRWGr
	 hUGluuT0cMszAlhEJk0Fak2BBXsWUJB+UM8MVEEabGmTE7ADkjg4XkDjx/3wAAN70C
	 9sziJJyIEAfROL8yYRPpYosR/pxNYDBn9x36lcQwK5pvKp27n4Nq7DRHic7ndxabVm
	 qVvPuOKy9GEdtF+3aicIO4P0vKGzP3yYARDC8uTfPqOKZzf42M5q54wjbDp5PrWYGJ
	 hqA8TQ7jHZMag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE38481224;
	Fri, 11 Sep 2026 10:09:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1F3E701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2AF160BE0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TeZX95Lp9a9w for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:09:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D323A605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789121390;
 b=bhbPF3N4ui/H7oLIoAkZtcHvcqU3EbY/vknJPf4ENjjEhsZbPvGwYsZGZIdP/wHIuCgd
 qEiPnIrWuLbcI7gcsWwmdZD6aEbN1fhUFEidi0K9iz/CWbicrp2FDBr7I2x6qzQg2WTLv
 sW3/Sc7nrx8LIiCXIVji7DDpbz/YyGU0nJBvsRAIgaKQSIVi1pn3WbPIzAIMSQEZ4s36E
 Fpg6DjJ4ZDSlpx/3sQFMK2dJVbb/mNNT/YnQIOjZLPtnxXhMUrWJlJHy9LDu5l5A4BJVe
 JDKi8A2lcPS/+cWuH3VJwnuJvZcB0r9ufQhCDbI9tmOqbnm5mAiW5thYg9a5Icy3+ZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789121390;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding;
 bh=Ft5ECzuUhSkzh7d3FkbvLS3Gp0Rg3vG4PJY5BBoQ7fk=;
 b=ZTVlEOHN9Qmuyn+w+wg9zN00VA9/3hpSAxIJWAssfcE43RhJ6fY1metPYLpHJehoGI7W
 fW+jLur/NfkhNgv2qrkh99T60Sm8AO3GRXERlnv14E57hz4GJCVj8oAIVamXlAdXiTF6u
 V2U9rAZjvrJwjEmyOB1TSYPJqSphT3YKFdPgo22sHDfYzFI8NgyqKTXf6soa1tSjk8Vyd
 +tWseikQa5PVpjVauFFWNKZJphVpr10asplSz7o/G12QvVOYZCnoBRkO+ZuI9ZnWisDcr
 P/Gr73V1IT4hpghjwyQHGTCimbFuByDBqCUoyUIJ5+WwsI5wvpa1EtEtc71ohhuHfIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=monstr.eu; 
 dkim=pass header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=iJi5QB0s; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=iJi5QB0s
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D323A605ED
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:09:48 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c25b661d37dso118703166b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1789121386; x=1789726186;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ft5ECzuUhSkzh7d3FkbvLS3Gp0Rg3vG4PJY5BBoQ7fk=;
 b=iJi5QB0sD8AtNoL1lntkJugY4rD443bL1xnsy9wsFDpE9Qdn2LBGyV865FWnQklloy
 iYClCcnZ4QvHs0lJIp7/dl0mj/wyxMjrqY3i3/ou5vFPuNIeyipOYIQziqkeXPo9xs9H
 AHP4vrGi2XpLPjM87JYcDqCPVYj7ZWvUYbhss6nHSa9D//qH1hlB0FZ//2J7VQcsQTJr
 QlW1ugMU7doQoscc8l5q0KiTHYHIgFQnxkrUV249l2QyCJbPofU8DRW5k5L/Ewd6anEC
 LB421CiH1nP5qsF+RVLocxZ8zEA0nnbieDqES70xo4wxl8zZ0aKZPharupUWFmKEb1Av
 pENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121386; x=1789726186;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ft5ECzuUhSkzh7d3FkbvLS3Gp0Rg3vG4PJY5BBoQ7fk=;
 b=bIYjInzLEVZgkEw8QVIRyWpupWr1edLIuQDFu/LvtzpwYXKNc7IiIqLwfreJs4ZC6Z
 h5A0OMCShsRDdqdi4OPXmAa4VCUsWBx69bdoptBIwj2e6yJH/EJq0FRZJeeFgUEPh2ub
 S+BxcdBcbirwQ0LFo+hFhVSt0BAeSEbPH3BcfXjNK8g+M6hd8x+z/IlwLhdehamgrpnN
 Vzirn4XxkdUBTi1ZuCpr94m2hiN/7atCaPiME9uW17pM8o8BRCgKqfW4iyTj1s75SSPt
 9ya8T3AYORcpYcwNsmPe4vHPgJa+G88WHAEg6HcKFwwP8DD875vSJG/WqbdLJn13cLsr
 ndbQ==
X-Gm-Message-State: AFuF++nhqstRgTU2v9yeNiCLqPVAqjzAu9VcJzMqzNk+/JFXv44gJ48S
 lkw7vPEeHwpw1ZkQh3hI7dzNsc8ZuDkst7tlNaVb/pTJhU5htzt8gXdUzhL+21qcGRl/zkis2o+
 P3hxxxwDs
X-Gm-Gg: AYBFou3F/Cjrjw5bygL4Q+i8OZiK21KvXIZmALZsRV6YAvmWnNsgefste39XD5U9upl
 nh0LdcrnGxu+2PyrVerhJI06SgYs+de3KI8OEhDTUJKjLamozAXu2p5kxfAZCX7/YyrnccyhRSB
 XE+lbCuvBTuNNGF99NjBprmsvJJju6rqEqjl0BlRXnhDfP2DYiukpeDBaSisXK2Ju/2CM6moStb
 vX2gzX1ATeR4s7eHCAwMB8Xv9hWy4k/IMoT5lWCzUB6jX+xtc4QtE0M3GjC8HKb6x1lNClN5E8i
 sN51qB3T1+eqV8j6meFow+vRchkI3WSFO5W6l7ZIplk+BWewDAf81vpzahZ2hPWueXxXk72sbYm
 z8WwLp0StyQ0P4RNwiQqT4HPCoWOLXdzqmpZjycPbc7LHKfJXa5JA5qwdUO3gk4B/pgqnA7j+vY
 n57F+HNsC9JGjJ35fN6BxHFI+VzNyUwyG9514N+CVVaCrPEf7hFoEHpP0ntqeaS5ak0xeijKMCk
 7ovq9j1VtrdEqXBkea2PyL9m+Eu8QwpgGivFrSuswPeHSA=
X-Received: by 2002:a17:906:6a28:b0:c25:91bc:ff55 with SMTP id
 a640c23a62f3a-c29667457bcmr160417366b.23.1789121385856; 
 Fri, 11 Sep 2026 03:09:45 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29660da0a1sm63908166b.47.2026.09.11.03.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 03:09:45 -0700 (PDT)
Message-ID: <a0602787-993c-40e0-aa29-08d36142ea6f@monstr.eu>
Date: Fri, 11 Sep 2026 12:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx/fpga patches for v2027.01-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

please pull these patches to your next branch.

I extend timeout to 4h in CI and build passed here
https://git.u-boot-project.org/u-boot/custodians/u-boot-amd/-/pipelines/1218

Thanks,
Michal


The following changes since commit d4152edb50356338af994d1c0483f65b717b4c15:

   Merge tag 'u-boot-imx-next-20260906' of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-imx into next 
(2026-09-08 11:48:35 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git 
tags/xilinx-for-v2027.01-rc1

for you to fetch changes up to af3599b6007ada93167036f4cd9670232aae997b:

   configs: versal: Enable AMD DW PCIe controller for Versal Premium Gen 2 
(2026-09-09 07:50:59 +0200)

----------------------------------------------------------------
AMD/Xilinx changes for v2027.01-rc1

MAINTAINERS:
- have one fragment for all AMD/XILINX SOCs

firmware:
- reset driver, chip ID, TAP, PGGS fw cleanup

net/mrmac:
- Enhance MRMAC driver and fix RX packet loss

pci:
- Add AMD Versal CPM/QDMA PCIe support

versal:
- Add support for Versal Premium 2 with DW PCIe

zynqmp:
- DT updates

----------------------------------------------------------------
Akshay Belsare (5):
       reset: zynqmp: move reset assert helper into firmware driver
       board: xilinx: zynqmp: use reset assert helper in reset_cpu()
       soc: xilinx: decouple chip ID retrieval from direct firmware calls
       soc: xilinx: route PMC TAP register access through firmware
       board: xilinx: decouple PGGS boot index read from firmware

Michal Simek (1):
       MAINTAINERS: Put together AMD/XILINX platforms to one fragment

Mike Looijmans (1):
       zynq-topic-miami.dts: Use fixed-partitions binding for QSPI NOR

Padmarao Begari (8):
       net: mrmac: check memalign() return values
       net: mrmac: use a driver-owned RX buffer pool
       net: mrmac: switch to max-speed property
       net: mrmac: use contiguous BD arrays
       net: mrmac: initialize the Rx BD ring in a loop
       net: mrmac: write CURDESC after ring setup
       net: mrmac: fix Rx packet loss on back-to-back frames
       net: mrmac: increase the Rx BD ring

Pranav Sanwal (8):
       configs: versal: Add amd_versal_premium_2 config fragment
       pci: Add pci_generic_mmap_write_config32() helper
       pci: Add support for AMD QDMA PL PCIe root port
       pci: Add support for CPM4 and CPM5 PCIe controllers
       arm64: versal: Add MMU mappings for CPM5 ECAM config space
       arm64: versal: Enable PCIe/NVMe support and add NVMe boot target
       pci: Enable AMD DW PCIe (MDB) controller support on Versal Premium Gen 2
       configs: versal: Enable AMD DW PCIe controller for Versal Premium Gen 2

  MAINTAINERS                                       |  80 ++---
  arch/arm/dts/zynq-topic-miami.dts                 |  21 +-
  arch/arm/mach-versal-net/cpu.c                    |  34 +-
  arch/arm/mach-versal-net/include/mach/sys_proto.h |   8 +-
  arch/arm/mach-versal/cpu.c                        |  38 ++
  arch/arm/mach-versal/include/mach/sys_proto.h     |   4 +
  arch/arm/mach-versal2/cpu.c                       |  39 ++-
  arch/arm/mach-versal2/include/mach/sys_proto.h    |   8 +
  arch/arm/mach-zynqmp/cpu.c                        |   8 +
  arch/arm/mach-zynqmp/include/mach/sys_proto.h     |   2 +
  board/xilinx/common/board.c                       |   6 +-
  board/xilinx/versal/MAINTAINERS                   |   1 +
  board/xilinx/zynqmp/zynqmp.c                      |   7 +-
  configs/amd_versal_premium_2.config               |   7 +
  configs/topic_miami_defconfig                     |   2 -
  configs/xilinx_versal_virt_defconfig              |   6 +
  drivers/firmware/firmware-zynqmp.c                |  64 ++++
  drivers/net/xilinx_axi_mrmac.c                    | 235 ++++++-------
  drivers/net/xilinx_axi_mrmac.h                    |  20 +-
  drivers/pci/Kconfig                               |  23 +-
  drivers/pci/Makefile                              |   2 +
  drivers/pci/pci-uclass.c                          |  42 +++
  drivers/pci/pcie_amd_cpm.c                        | 363 ++++++++++++++++++++
  drivers/pci/pcie_amd_qdma_pl.c                    | 205 +++++++++++
  drivers/pci/pcie_dw_amd.c                         |   1 +
  drivers/reset/reset-zynqmp.c                      |   7 -
  drivers/soc/soc_amd_versal2.c                     |  25 +-
  drivers/soc/soc_xilinx_versal.c                   |  23 +-
  drivers/soc/soc_xilinx_versal_net.c               |  25 +-
  drivers/soc/soc_xilinx_zynqmp.c                   |  21 +-
  include/configs/xilinx_versal.h                   |   7 +
  include/pci.h                                     |  26 ++
  include/zynqmp_firmware.h                         |   7 +-
  33 files changed, 1098 insertions(+), 269 deletions(-)
  create mode 100644 configs/amd_versal_premium_2.config
  create mode 100644 drivers/pci/pcie_amd_cpm.c
  create mode 100644 drivers/pci/pcie_amd_qdma_pl.c

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
