Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79DFC282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 13:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2929D811DF;
	Mon,  3 Mar 2025 14:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A0D811DF; Mon,  3 Mar 2025 14:32:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DAA60811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 14:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5762F106F;
 Mon,  3 Mar 2025 05:33:07 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F048E3F673;
 Mon,  3 Mar 2025 05:32:50 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/6] lmb: miscellaneous fixes and improvements
Date: Mon,  3 Mar 2025 19:02:25 +0530
Message-Id: <20250303133231.405279-1-sughosh.ganu@linaro.org>
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

Patch 4 is removing a now superfluous check for overlapping regions
with flag other than LMB_NONE. This now gets handled at an earlier
point in lmb_reserve().

Patch 5 is clubbing the functionality to check if two regions are
adjacent, or overlap, allowing some code re-use.

Patch 6 is optimising the lmb_alloc() function by having it call
_lmb_alloc_base() directly.


Changes since V2:
* Add more description to the commit message on the logic behind this
  change (patch 4)
* Change the print for allocation failure into a debug message as per
  suggestion from Heinrich


Sughosh Ganu (6):
  lmb: check if a region can be reserved by lmb_reserve()
  lmb: handle scenario of encompassing overlap
  lmb: check for a region's coalescing with all existing regions
  lmb: remove superfluous address overlap check from
    lmb_add_region_flags()
  lmb: use a common function to check if regions overlap or are adjacent
  lmb: optimise the lmb allocation functions

 lib/lmb.c      | 140 +++++++++++++++++++++++++++++--------------------
 test/lib/lmb.c | 114 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 194 insertions(+), 60 deletions(-)

-- 
2.34.1


