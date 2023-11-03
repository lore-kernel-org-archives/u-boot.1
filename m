Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD87C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 18:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA4887438;
	Fri,  3 Nov 2023 19:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D/kOkGnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A72587243; Fri,  3 Nov 2023 19:38:53 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 5E91B86CF7
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 19:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0737520B74C0;
 Fri,  3 Nov 2023 11:38:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0737520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1699036730;
 bh=2GuESeYTboyv0F9/v4P9XEqtUUhlTCqwvc7Pdt7eEbo=;
 h=From:To:Cc:Subject:Date:From;
 b=D/kOkGnKYFB1bU6kenMTGabDRHSJK/Q2jELk4R7ysPREqGi5lYuANiFLDZoAR+Nlp
 sXosRdXhywbEU85ytPW35GXLfJ1oXmI3kPmtzEFgcaSloTuQ99dzyzIhejST37ga0T
 rSS3nDXSrlQKr9fHc3hmu/NuPKGoqLawMrpLKt2s=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com
Subject: [PATCH v4 0/5] Populate kaslr seed with RNG
Date: Fri,  3 Nov 2023 11:38:39 -0700
Message-ID: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
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
the RNG.  This can be enabled with CONFIG_RNG_TPM_SEED.  

changes in v4:
- Fix compile issue when CONFIG_OF_CONTROL not set

changes in v3:
- Populate with RNG device instead of TPM device (this is a more generic solution)
- Use event spy to do the FDT fixup
- fix compile error for sandbox for !OFNODE_MULTI_TREE

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
  fdt: kaslr seed from RNG device

Sean Edmond (3):
  cmd: kaslrseed: Use common API to fixup FDT
  dm: core: Modify default for OFNODE_MULTI_TREE
  fdt: Fix compile error for !OFNODE_MULTI_TREE

 arch/arm/cpu/armv8/sec_firmware.c | 39 ++++++++--------------
 boot/fdt_support.c                | 55 +++++++++++++++++++++++++++++++
 cmd/kaslrseed.c                   | 22 +++++--------
 drivers/core/Kconfig              |  3 +-
 drivers/core/ofnode.c             | 29 ++++++++++++----
 include/dm/ofnode.h               | 12 +++++++
 include/fdt_support.h             |  9 +++++
 lib/Kconfig                       |  7 ++++
 8 files changed, 130 insertions(+), 46 deletions(-)

-- 
2.42.0

