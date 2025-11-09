Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DCDCD1297
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946F083EC0;
	Sun,  9 Nov 2025 11:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZSmXUjuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DAAE83EDC; Sun,  9 Nov 2025 11:10:28 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7B683E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 27A33408CF; 
 Sun,  9 Nov 2025 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683024;
 bh=R/fb7zlJ5ZGJH07qTWo927FCCe6gCFSWi3yXmm0hTbA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZSmXUjuXmi1OMt1EAG8cyTL+gPMcyOEzkH9Pf+ClCRGuxB4goyhlxK/u4cJWDw9Qk
 PkUJBdlcRNPSVoxv120SnmuZPS9F8mIapleh+trE9L04rEOr5SJYocMxyvlIWlHnKn
 IBqe175wiN+nWsN6Oebo3EFmVSdaCZsRURUsWujmj2P9UHplXfCkjdSXva5YIrgCaX
 Psw83hia07UMfxu7GGAWxO6dLzZ4rolAS3tr76T6JSPyimXAhiWHAPWZAgyJ3m4H8m
 KqsiQ2Y+nEUoh6dP44JvQRwvnxP6cLlW65L97xwl/MxQhAN9qpkrj8LCb/2eLq8tS0
 2eaXea8EXZ+VBvqBnj3LI+R07KooSr1eVWgfArCuPfEf4hYLVDusT/d2GFl9mj51N0
 6C/C6PhoF3np3NbDuMeo2YAT7jd+mKw7VPEgEqujcnf4WkEMTMmnbSdXR002x+XOF2
 pqiHU1qmit8kFfwHRylK8aUUtxMMjJEaegPgVyMhxxACLo5xwaEMs57n0XMT1OntjY
 yMvZ1elSllJ3e8/usNcKBN5Es0zV6nQWkJlEbeE5a17KQosVT7VesL5mEojM89R1pa
 5Z+ZlzXtjwTXO5ebCdtq5JTUPnDeIWF30zlJ9DGee+9o8ocNa1ucP2ix0gaocqBEIm
 TQ7SpanoJTC+83f47AgJ2Qm0=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/9] CI: test qemu-riscv64_smode[_acpi]
Date: Sun,  9 Nov 2025 11:10:01 +0100
Message-ID: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

ACPI via QFW was broken since the 2025.01 release and we did not observe
it due to missing CI testing. This bug has been fixed in the meanwhile.

This series

* introduces prerequisite corrections of unit tests
* provides the necessary console record size for command line tests
* enables CI testing for qemu-riscv64_smode and qemu-riscv64_smode_acpi

The following patches are just resent to show how all belongs together:

* test: fdt_test_apply requires CONFIG_OF_LIBFDT_OVERLAY
* CI: test qemu-riscv64_smode[_acpi]

Heinrich Schuchardt (9):
  test: fdt_test_apply requires CONFIG_OF_LIBFDT_OVERLAY
  test: cmd/fdt: do not assume RNG device exists
  test: cmd/bdinfo: make no flash assumption
  test: cmd/bdinfo: consider arch_print_bdinfo() output
  test: common/print: do not use fixed buffer addresses
  test: cmd/fdt: do not use fixed buffer addresses
  common: default CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
  configs: CONFIG_CONSOLE_RECORD=y on qemu-riscv64_smode_acpi
  CI: test qemu-riscv64_smode[_acpi]

 .azure-pipelines.yml                      |  6 ++
 .gitlab-ci.yml                            | 12 ++++
 common/Kconfig                            |  2 +-
 configs/qemu-riscv64_smode_acpi_defconfig |  1 +
 test/cmd/bdinfo.c                         | 15 +++--
 test/cmd/fdt.c                            | 31 ++++++++--
 test/common/print.c                       | 71 +++++++++++------------
 7 files changed, 91 insertions(+), 47 deletions(-)

-- 
2.51.0

