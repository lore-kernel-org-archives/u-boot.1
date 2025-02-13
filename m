Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D971DC0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 13:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7B280A55;
	Thu, 13 Feb 2025 14:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B8880C98; Thu, 13 Feb 2025 14:11:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C9CC1806FE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C548916F3;
 Thu, 13 Feb 2025 05:11:52 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38ED3F58B;
 Thu, 13 Feb 2025 05:11:29 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] lmb: miscellaneous fixes and improvements
Date: Thu, 13 Feb 2025 18:41:00 +0530
Message-Id: <20250213131104.186663-1-sughosh.ganu@linaro.org>
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

The patch series contains some fixes and improvements in the lmb
code, along with addition of corresponding test cases for the changes
made.

The lmb_reserve() function currently does not check if the requested
reservation would overlap with existing reserved regions. While some
scenarios are being handled, some corner cases still exist. These are
being handled by patch 1, along with adding test cases for these
scenarios.

Patch 2 is handling the case of reserving a new region of memory, but
that region overlaps with an existing region. The current code only
handles one particular scenario, but prints a message for the other
scenario of an encompassing overlap and returns back. The patch
handles the encompassing overlap.

Patch 3 is an improvement whereby we allow coalescing a newly reserved
region with an existing region. The current code exits this check
prematurely.

Patch 4 is putting an ifdef in the lmb_map_update_notify() so that the
function contents are compiled only with EFI_LOADER. Reasoning for the
same is provided in the patch commit message.


Sughosh Ganu (4):
  lmb: check if a region can be reserved by lmb_reserve()
  lmb: handle scenario of of encompassing overlap
  lmb: check for a region's coalescing with all existing regions
  lmb: build lmb_map_update_notify() only with EFI_LOADER

 lib/lmb.c      |  40 +++++++++++++++-----
 test/lib/lmb.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 10 deletions(-)

-- 
2.34.1


