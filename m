Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E53CA0FE1
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 23:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBB58670E;
	Fri,  1 Sep 2023 01:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="GB8t30s0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EE886590; Fri,  1 Sep 2023 01:07:11 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F9A865A0
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 01:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:mime-version:to:cc:content-transfer-encoding:
 content-type:cc:content-type:from:subject:to;
 s=s1; bh=saplxNz4TIG/WMfhNVwIa9aYsx8vo/Rhnk4vK3QYiR0=;
 b=GB8t30s0bkqU47KEHNFQ//2q5LMKT39/tnYW3DPXemecwM7xobPF3covF5dAXtnupGps
 YscjDtZd64DAFWj8XLNa0LQbqQyKD4CKH07n08dxnjoOKTC3RtZBq3dl2waXMDGPNneACe
 5s+0Qn5uAVwDknZ2vDwa7XvywVh9q88P7J9w4vdt46jgdhJrwPl4bOA3wS7f7fBF5wN23Y
 fH7kgwVJi3ayiRGfRiGANmVnA+d/xoXA56kPET7SR3REKJ84WS8lsChuykhbWPXpwLAdJE
 Ud3sjgk2t5l99jVKC6OkH4gLmJ4hzsGzz2ixg3eCJjot3F2aMGieX4iykfIiHFzg==
Received: by filterdrecv-65f68489c8-twq2m with SMTP id
 filterdrecv-65f68489c8-twq2m-1-64F11D1B-1E
 2023-08-31 23:07:07.560352601 +0000 UTC m=+9761458.394211776
Received: from bionic.localdomain (unknown) by geopod-ismtpd-4 (SG) with ESMTP
 id Sc_UUjOpQ3mHIcNFXOBX2g Thu, 31 Aug 2023 23:07:07.251 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] phy: Fix generic_setup_phy return value on power on
 failure
Date: Thu, 31 Aug 2023 23:07:07 +0000 (UTC)
Message-ID: <20230831230705.1040105-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hyVOFM2G4KWKNMves?=
 =?us-ascii?Q?CiHSuYLzEDNTmAemMSeoX89X1xSNcY01dORpRm0?=
 =?us-ascii?Q?ml0KwrI6eq51Mj6CabQBsopKcaaEHnbqrpW32iv?=
 =?us-ascii?Q?8v6NRtLQU9TpQBJpKFEv1ain7rMCkXahaaYyYT+?=
 =?us-ascii?Q?C4TKaBjgPvGcS5t=2FzmvuTIeY7rLpni=2FeJ6oSqT?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

This series fixes two issues related to the return value in case of
error from generic_setup_phy().

Patch 1 fixes that the error code from power_on gets returned.
Patch 2 fixes an regression so that success is returned instead of ENOENT.
Patch 3 refactor generic_{setup,shutdown}_phy() to improve readability.

Changes in v2:
- Split patch in two
- Restore old behavior for ENOENT
- Add unit tests

Jonas Karlman (3):
  phy: Fix generic_setup_phy() return value on power on failure
  phy: Return success from generic_setup_phy() when phy is not found
  phy: Refactor generic_{setup,shutdown}_phy() to reduce complexity

 drivers/phy/phy-uclass.c | 41 ++++++++++++++++------------------------
 test/dm/phy.c            | 29 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.42.0

