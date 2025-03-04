Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CA2C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AEBA807EE;
	Tue,  4 Mar 2025 17:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2052680805; Tue,  4 Mar 2025 17:52:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ED14A8004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E071D2F;
 Tue,  4 Mar 2025 08:52:36 -0800 (PST)
Received: from localhost.localdomain (unknown [10.1.25.152])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B6073F5A1;
 Tue,  4 Mar 2025 08:52:22 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 0/2] vepxpress64: disable CRC32 by default and add FVP with
 TF-A guide
Date: Tue,  4 Mar 2025 16:52:00 +0000
Message-ID: <20250304165204.53097-1-harrison.mutai@arm.com>
X-Mailer: git-send-email 2.46.2
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

This patch introduces two updates to the vexpress64 project:

- Disable CRC32 by default to prevent aborts in a standard FVP setup.
- Add a guide for running FVP with TF-A, providing a clear starting point for
  users.

Harrison Mutai (2):
  vepxress64: disable CRC32 by default to prevent aborts
  vepxress64: add guide for running FVP with TF-A

 configs/vexpress_fvp_defconfig  |  1 +
 doc/board/armltd/vexpress64.rst | 54 +++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.46.2

