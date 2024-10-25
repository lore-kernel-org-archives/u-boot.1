Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F299D0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C2A88CD9;
	Fri, 25 Oct 2024 14:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC4F88DEA; Fri, 25 Oct 2024 14:16:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 54BD488C10
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40D8F339;
 Fri, 25 Oct 2024 05:16:34 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E67E43F71E;
 Fri, 25 Oct 2024 05:16:02 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, love.kumar@amd.com,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] Add generic function for computing ram_top
Date: Fri, 25 Oct 2024 17:45:45 +0530
Message-Id: <20241025121547.181633-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The board_get_usable_ram_top() function is used by boards to compute
uppermost address of RAM(ram_top) that is to be used by U-Boot -- this
need not be the highest RAM address of the platform. This computation
happens before U-Boot relocates to its final destination address in
RAM. Certain platforms, like the Xilinx boards were computing the
ram_top value in an indirect manner, through some LMB API's. Thus it
is no longer possible to use these LMB API's to compute the ram_top,
as the LMB module gets initialised only after relocation, and the heap
memory has been set up. Add generic functionality to compute the value
of ram_top which can be used by platforms.


Sughosh Ganu (2):
  common: memtop: add logic to detect ram_top
  xilinx: use get_mem_top() to compute ram_top

 board/xilinx/common/board.c |  25 +++++
 common/Makefile             |   1 +
 common/memtop.c             | 186 ++++++++++++++++++++++++++++++++++++
 include/memtop.h            |  22 +++++
 4 files changed, 234 insertions(+)
 create mode 100644 common/memtop.c
 create mode 100644 include/memtop.h

-- 
2.34.1


