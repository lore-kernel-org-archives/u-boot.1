Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5758EC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB7882B00;
	Thu,  8 May 2025 14:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7254C828A2; Thu,  8 May 2025 12:56:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 516BF82162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 12:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jayanthdodderi.chidanand@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C1D106F;
 Thu,  8 May 2025 03:56:02 -0700 (PDT)
Received: from e134675.cambridge.arm.com (e134675.arm.com [10.1.28.77])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 190163F673;
 Thu,  8 May 2025 03:56:10 -0700 (PDT)
From: Jayanth Dodderi Chidanand <jayanthdodderi.chidanand@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, oleksandr.tarhunakov@arm.com, artem.kopotev@arm.com,
 manish.pandey2@arm.com,
 Jayanth Dodderi Chidanand <jayanthdodderi.chidanand@arm.com>,
 u-boot@lists.denx.de
Subject: [PATCH 0/1] Enable bloblist support on Total_Compute
Date: Thu,  8 May 2025 11:55:54 +0100
Message-Id: <20250508105556.2205022-1-jayanthdodderi.chidanand@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 May 2025 14:50:08 +0200
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

This patch enhances the total_compute platform by enabling bloblist
support. This facilitates information passing from TF-A via the firmware
firmware handoff framework.

Jayanth Dodderi Chidanand (1):
  board: total_Compute: enable bloblist for SPL handoff

 arch/arm/Kconfig                             | 2 +-
 board/armltd/total_compute/Makefile          | 2 +-
 board/armltd/total_compute/total_compute.c   | 5 ++++-
 board/armltd/total_compute/total_compute.env | 6 ++++++
 configs/total_compute_defconfig              | 3 +++
 5 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.34.1

