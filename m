Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DCDCA0FE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 11:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0251788AB2;
	Fri, 30 Aug 2024 13:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA74088A9B; Fri, 30 Aug 2024 13:41:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B027D88A10
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 13:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6A0339;
 Fri, 30 Aug 2024 04:41:36 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C8DF3F66E;
 Fri, 30 Aug 2024 04:41:08 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 0/6] Miscellaneous FWU fixes
Date: Fri, 30 Aug 2024 17:10:51 +0530
Message-Id: <20240830114057.891069-1-sughosh.ganu@linaro.org>
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


The following set of patches are miscellaneous fixes and some
hardening of the FWU update logic.

Sughosh Ganu (6):
  fwu: v2: perform some checks before reading metadata
  fwu: v2: try reading both copies of metadata
  fwu: v1: do a version check for the metadata
  fwu: check all images for transitioning out of Trial State
  fwu: add dependency checks for selecting FWU metadata version
  fwu: do not allow capsule processing on exceeding Trial Counter
    threshold

 include/fwu.h            | 11 ++++++
 lib/fwu_updates/Kconfig  |  1 +
 lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
 lib/fwu_updates/fwu_v1.c | 18 +++++++--
 lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
 5 files changed, 99 insertions(+), 42 deletions(-)

-- 
2.34.1


