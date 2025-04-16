Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F971C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 09:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41FD82CF6;
	Wed, 16 Apr 2025 11:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744794269;
	bh=UcWK0Xg/aS58mCt0AevIWaAFH2IjGBm6ORUXcw16KpY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L/woPoW8mJgepxijbl0BGEK69anB1QFp1HeeEZua/rgADtetVwobBWGiJeYfgIBPN
	 l4D3yk7iQIUmWHkuwdCoDAMMm+6t80lXEWRH0PdVovrX76/naa2ARsdPDhRJH6faav
	 wk1eK0aaddXfCEan7Q4XupKZjev3cUbLeoGXa9DAPElgWvTf5kI5F+myyH2svD+Rw/
	 VJX4Dlj29k3Z/czWO5hGWpc2N5ly+THq+rMY8HqOHqr5rnq/5arX+862T63MAX+1qG
	 1KM2HrF30kSWH2kx0IpntpU59oCTNDNFIPQfL/oWrJ/DZOkooIOSlez0tTpG8B/8lk
	 uUoPOtUa+KIZw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E91082CF6; Wed, 16 Apr 2025 11:04:29 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C2881F45
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MzylVDCI"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A868E1039EF29; 
 Wed, 16 Apr 2025 11:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744794266; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=UcWK0Xg/aS58mCt0AevIWaAFH2IjGBm6ORUXcw16KpY=;
 b=MzylVDCIztrIN8TWB22bpJJ+Ti1cuzePr45nhw1M1VV2HnI9P2tz51OIAwIpAIr6gde24t
 2K1ZLLjiWjGefoU0lAv1oan2Dr6ta0LIrtH5dqI2K6mE7W4gPDd92kAgbuP3JlJbAj7JrM
 kBqZeP9GJ1hY0+yg11ftuYsZQVN2JyWj3BLy5oqngJSlOJgmkqMtw3av2MvsDB5KyW1xrl
 IhNWHjA19k7/bZxVtjsl9Dw/EJsTOZVWInF3uuS1jbaimQ9kklR2FDhUnb+DtPAKL9VsUw
 i4iuIWqLW67bo2S8lmZlSdmzI/xtpFvpkwOyCk22sI5ZXpMK+LzFW4K5iR6GPA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v1 0/3] Updates for the siemens cxg3 for 2025.07
Date: Wed, 16 Apr 2025 11:04:16 +0200
Message-Id: <20250416090419.54781-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

some small updates for the cxg3 board:

- collect common Kconfig options in an include file, which
  makes syncing downstream defconfig files easier
- Move the U-Boot Environment setttings in a txt file
- minor defconfig updates
- base is
  407d68638fe - (origin/master, origin/HEAD) Merge patch series "Switch to using $(PHASE_) in Makefiles"


Heiko Schocher (1):
  imx8qxp: capricorn defconfig: collect common Kconfig options

Walter Schweizer (2):
  siemens: capricorn: enable text based default environment
  siemens: capricorn: add ahab command and enable watchdog

 board/siemens/capricorn/MAINTAINERS           |   1 +
 board/siemens/capricorn/capricorn_default.env |  51 +++++++
 configs/capricorn_cxg3_defconfig              | 133 +----------------
 configs/imx8qxp_capricorn.config              | 136 ++++++++++++++++++
 include/configs/capricorn-common.h            |  52 +------
 5 files changed, 194 insertions(+), 179 deletions(-)
 create mode 100644 board/siemens/capricorn/capricorn_default.env
 create mode 100644 configs/imx8qxp_capricorn.config

-- 
2.20.1

base-commit: 407d68638fe32418d61681407effba2a303bb9ee
branch: feat/capricorn-upstream-hs
