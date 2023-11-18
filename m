Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6979EC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 15:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEFE86C47;
	Sat, 18 Nov 2023 16:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QiSB3sSj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SA63JCRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0045B86C83; Sat, 18 Nov 2023 16:24:03 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC40186BFA
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SXcxS34CJz9sjr;
 Sat, 18 Nov 2023 16:23:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700321036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cv7bxHhcyKfFDkeZqWapacrGlE7XQsPTm+HYkYb7Xqg=;
 b=QiSB3sSjWDlMoSbkga55zm9mRufFy3lYqNZp7Vre/1ITnn7dr78k4Upi0FY9K0G37tm+cz
 /ybVdoz6O7qRZh2FbyqpOB9nfJB3HsuQSqWDf9oAg7t7zzb73AmZMaxCrDOskaAketUYw3
 E1N/bWjjAgfkRUQeSbzAnxLYJ9AMZk02sYnRjO/+nFW/hlcJZEnt7eCYvEdn9ZaGbEcAtp
 NU+lZN4u4UlP+KEurTUzxzTu76KwCXiR7IPdK0b98WFbXLNpQte2RDZojuFkJKBIlrgVLF
 3DFvrHKrcjzoHfgWdk/4NJJgta94jJOqvpeWig9N6hbFMpbZYOiqo+kHjxCI8w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700321034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cv7bxHhcyKfFDkeZqWapacrGlE7XQsPTm+HYkYb7Xqg=;
 b=SA63JCRqJnjcAV2CsfZWWeSQ4NS/7x3/lvwHvMO0KfN2vVXv/orYsi4x9k5eZHYVu8vhyY
 M+mJCFs/TrXqRppFRZVwaOA/B3WQiYpmoB3BtclFLEYQsQC+GJXgW47VF08nXAMpLFSwuD
 MnowCcr3j/GJTbd+jW+4BZUoIFduOR9dJmokYwrIUybPs0YRDbsEUoygjmaT5o3G6EniNd
 FTnFTN8TQTQ1C+ULJhzIxAuGAXtiQx0LRpYdzWfoPldSNlRtRK9q+UIn9WSl/JRiOH+pPC
 3CO/CVVWkWwBzE7AEh0A2BpbIEwUXatFfrMNSbuslNuSPPrt4edXc63Zc69IhA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master-mmc-clock
Date: Sat, 18 Nov 2023 16:23:17 +0100
Message-ID: <20231118152341.63823-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8f76ea3e4b02612d30e
X-MBO-RS-META: 8pfkxor74u8gzepswd1zejckamjy7zun
X-Rspamd-Queue-Id: 4SXcxS34CJz9sjr
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

The following changes since commit 17e9db18f17b6cad278694d4a61df95e96bdf4f5:

  Merge tag 'doc-2024-01-rc3' of https://source.denx.de/u-boot/custodians/u-boot-efi (2023-11-11 09:22:54 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-mmc-clock

for you to fetch changes up to 70d2c9940e54ada6bf9e1e538c958f13ccc97c38:

  mmc: renesas-sdhi: Disable clock after tuning reset when possible (2023-11-13 04:12:47 +0100)

----------------------------------------------------------------
Marek Vasut (1):
      mmc: renesas-sdhi: Disable clock after tuning reset when possible

 drivers/mmc/renesas-sdhi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)
