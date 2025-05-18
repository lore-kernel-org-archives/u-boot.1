Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1B5C3ABC9
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 12:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B8080FA8;
	Sun, 18 May 2025 14:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OtQ+6CxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B11780584; Sun, 18 May 2025 13:16:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DC78004F
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 13:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7141D49E0D;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41CC8C4CEEB;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747567002;
 bh=okd2bvwfGMtJalyB489MmYbnJIYdDdZIfl2S0cbVj4w=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=OtQ+6CxC/GD/zDCoQPteHvYIxRITG4yVZPwsXIdB6lXIVsLNVlDlNancRqGFiy2Fa
 ypqN/LzDmFNy4lwIpr7kDgONjsQtBx9Y7mmjIFW0aQ3hywmCNaP+1kAyp7ChUkNsCO
 48E0P+OW16yI1g8Ako6zDsj9l3wgJF7BscP1oWerx96m4SRqvelGEuku/u2BfJRHH8
 JOozNWMHVKYdGqMFYIvuNYAKkwflr1lw67s1ozGY4ARtf7PiZJAHBDWw0YOHvjcJ5y
 7FtwSX5h7cubMYCJ6dfqcf72I0B4h4MgLHIVpJoBVmSxIYnu6D2ITXSGpkZus+KmcT
 1avOfygaMTLFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA71C3ABD8;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] u-boot chain-loading LineageOS bootimg
Date: Sun, 18 May 2025 19:16:17 +0800
Message-Id: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHBKWgC/3WMwQ6CMBAFf4X0bA0US6kn/8N46G4LbCLUtKTRE
 P7dwkVjYt5pXjKzsOgCucjOxcKCSxTJTxnqQ8FwMFPvONnMTJRCliehuJls8GQ5eD9zhwCqadE
 aJVhWHsF19Nxz11vmgeLsw2uvp2p7/4RSxUsO0ECtUKPuqks/Grof0Y9sCyXxkfN+ZJFlLSyCh
 E5qbL/ldV3fnyYbPOUAAAA=
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747567000; l=2455;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=okd2bvwfGMtJalyB489MmYbnJIYdDdZIfl2S0cbVj4w=;
 b=eUeoQlVe37jcqoWyIGbVVi1QNrckIj/8RpE4/F8APtcQMFbo0fIrF5tlrptEg+uqxcWSL1xEg
 YqIF6ikeGXBDF84S/86c6EEIW/NLCJjkQaJ9kOQ1nhXBHohkB8qiOZZ
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sun, 18 May 2025 14:45:03 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This is a series of patches to enable chainloading LineageOS on qcom SOC.

Patch #1 introduce kconfig to ignore those default value and use loadaddr
instead. That workaround some androidboot image have invalid kernel/ramdisk
loadaddr.

Patch #2 enable #1 for snapdragon machine.

Patch #3 override qcom soc loadaddr with fastboot_addr_r as a band-aid.
Casey confirmed loadaddr and kernel_addr_r are purposely set to same
address for memory-constrain case. A proper fix is far from get ready so
this patch can work as a band-aid for maintainer atm. 

Remain as unchanged to make it conditional on CONFIG_FASTBOOT is because
that also imply CONFIG_ANDROID_BOOT_IMAGE set y.

To: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>
To: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io
Signed-off-by: George Chan <gchan9527@gmail.com>

Changes in v3:
- Rebase to origin/master
- Drop optional patches, leaving those acked patches.
- Gone through checkpatch.pl
- Link to v2: https://lore.kernel.org/r/20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com

Changes in v2:
- Revised patch #1 to control by kconfig, suggested by Casey
- Split old #1 into new #1 and #5 for maintainer to choose.
- Revised Casey's approach for #2 and make it as band-aid atm.
- Revised Casey's approach for #3 and leave user to bake their own param set.
- Introduce example for #1
- Introduce kconfig default for #1 with snapdragon soc, suggested by Casey
- Link to v1: https://lore.kernel.org/r/20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com

---
George Chan (3):
      boot/image-android: Workaround kernel/ramdisk invalid addr
      mach-snapdragon: Enable workaround of ignoring androidboot addr
      mach-snapdragon: Enhance android image handling memory footprint

 arch/arm/Kconfig                 |  1 +
 arch/arm/mach-snapdragon/board.c |  8 ++++++--
 boot/Kconfig                     | 11 +++++++++++
 boot/image-android.c             |  9 ++++++---
 4 files changed, 24 insertions(+), 5 deletions(-)
---
base-commit: 126a88d49bcae04bbfc0d6723097cd6341355ade
change-id: 20250427-android-boot-ecbb768cda72

Best regards,
-- 
George Chan <gchan9527@gmail.com>


