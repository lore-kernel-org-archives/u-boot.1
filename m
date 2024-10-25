Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9F6D149EB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 20:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D49589020;
	Fri, 25 Oct 2024 22:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 101DD89024; Fri, 25 Oct 2024 19:18:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 17AF387F7D
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E55C9339;
 Fri, 25 Oct 2024 10:19:08 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 268973F71E;
 Fri, 25 Oct 2024 10:18:38 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Jackson Cooper-Driver <jackson.cooper-driver@arm.com>, u-boot@lists.denx.de
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 0/8] U-boot: arm: Refine the booting on Total Compute
Date: Fri, 25 Oct 2024 18:18:13 +0100
Message-Id: <20241025171821.624702-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Oct 2024 22:14:52 +0200
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

This patch series is to refine the booting on Arm Total Compuate
platform.

It changes to use the info passed in DTB for initialization DRAM info,
and dynamically initializes the booting envoironment variables.

Another big change is to use an envoironment file for boot commands,
based on it, the series extends to support multiple block devices
(MMC and virtio). And the env file is extended for booting Debian.

The last commit is to update memory mapping info based on the DRAM info
passed via DT binding.


Boyan Karatotev (5):
  arm: total_compute: depend on TF-A for hardware description
  arm: total_compute: Initialize environment variables
  arm: total_compute: Remove unused bootm_size
  arm: total_compute: move the boot command to an env file
  arm: total_compute: Minor improvement for boot arguments

Leo Yan (3):
  arm: total_compute: Dynamically detect block device
  arm: total_compute: Support Debian boot
  arm: total_compute: Update memory mapping info

 arch/arm/Kconfig                             |   2 +
 board/armltd/total_compute/Makefile          |   1 +
 board/armltd/total_compute/lowlevel_init.S   |  12 +++
 board/armltd/total_compute/total_compute.c   | 102 ++++++++++++++-----
 board/armltd/total_compute/total_compute.env |  39 +++++++
 configs/total_compute_defconfig              |   2 +-
 include/configs/total_compute.h              |  31 ------
 7 files changed, 130 insertions(+), 59 deletions(-)
 create mode 100644 board/armltd/total_compute/lowlevel_init.S
 create mode 100644 board/armltd/total_compute/total_compute.env

-- 
2.34.1

