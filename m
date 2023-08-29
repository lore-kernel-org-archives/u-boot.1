Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D183C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 20:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B218651C;
	Tue, 29 Aug 2023 22:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IYwcXFuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE05386507; Tue, 29 Aug 2023 22:32:17 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 4284086508
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 22:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2A5E22129BF4;
 Tue, 29 Aug 2023 13:32:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A5E22129BF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1693341132;
 bh=yx8+WTRPtUUMfnaCHOkSuVJeFCuT7J/zya/QyT1shUI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IYwcXFuXPZ+pGZI8R45CQ1U3miMDg2wzBkOT7RIKCWuvTimbkeQgqTMdhKqmNQ3js
 thTnu+h+5fAhGBezmY655elZhLaAhRLg2EGAc7ABoCsrL7OVpCSB6LrAYMQzgf6Ye/
 AE+/rhFfrlabXrq8qvF85NxxwCqY6w9TIp0PRwGU=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: dphadke@linux.microsoft.com,
	macromorgan@hotmail.com,
	sjg@chromium.org
Subject: [PATCH v2 0/4] Populate kaslr seed with TPM
Date: Tue, 29 Aug 2023 13:32:06 -0700
Message-Id: <20230829203210.83914-5-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230829203210.83914-1-seanedmond@linux.microsoft.com>
References: <20230829203210.83914-1-seanedmond@linux.microsoft.com>
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

From: Sean Edmond <seanedmond@microsoft.com>

This patch series creates a common API (fdt_fixup_kaslr_seed()) for 
populating the kaslr seed in the DTB.  Existing users (kaslrseed,
and ARMv8 sec firmware) have been updated to use this common API.

New functionality has been introduced to populate the kaslr using
the TPM interface.  This can be enabled with CONFIG_KASLR_TPM_SEED.  

changes in v2:
- fdt_fixup_kaslr_seed() uses the ofnode API
- Add root_ofnode_from_fdt() to get the root node from an FDT and
  perform error checking on the oftree
- add comments to exported functions
- Add error checking in image_setup_libfdt() for return from
  fdt_tpm_kaslr_seed()
- uclass_get_device() -> uclass_first_device_err()
- Change default config for OFNODE_MULTI_TREE (y if !OF_LIVE)

Dhananjay Phadke (2):
  fdt: common API to populate kaslr seed
  fdt: kaslr seed from tpm entropy

Sean Edmond (2):
  cmd: kaslrseed: Use common API to fixup FDT
  dm: core: Modify default for OFNODE_MULTI_TREE

 arch/arm/cpu/armv8/sec_firmware.c | 39 +++++++++---------------
 boot/image-fdt.c                  | 15 ++++++++++
 cmd/kaslrseed.c                   | 22 +++++---------
 common/fdt_support.c              | 49 +++++++++++++++++++++++++++++++
 drivers/core/Kconfig              |  2 +-
 drivers/core/ofnode.c             | 17 +++++++++++
 include/dm/ofnode.h               | 12 ++++++++
 include/fdt_support.h             | 17 +++++++++++
 lib/Kconfig                       |  9 ++++++
 9 files changed, 142 insertions(+), 40 deletions(-)

-- 
2.40.0

