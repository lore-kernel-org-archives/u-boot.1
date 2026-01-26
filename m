Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65333D19501
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5EB583CB5;
	Mon, 26 Jan 2026 17:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WLW7YOrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76C383C6C; Mon, 26 Jan 2026 17:15:13 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E4F83B03
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ozndrgt@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so26754715e9.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769444111; x=1770048911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CqkTpd2BLWwgSqoEOPM0ih7EL+CAy98eMIX5Msqrj3I=;
 b=WLW7YOrQUGNARE361Bp+Mai+ItCmuKLwKR9jP81CxJ5/QY4uKvKqQZYgT8hs705sjm
 qkQ/x/LO0Fsd/kmiRymX+2SiewiUI0K6JyeOy16iwe9SPL0mLpDO0JeVL8Mo/LIRs/8J
 mmqRp5LsABNTxIfJ0iW6sJL4PlzS/mPBiHQPMPgheFbAegtrSArtTSsRaTW5fkO5tdK4
 QtEkW7fBSAa7DGO5f2bbL+SeYp5LAM1kcVBjY071rzZ0l5G5c2gs7W1cbHsBe7GCcfn9
 hBXGexwrU0vhqv+qllK74j8V9UxQWsxfh0svPLOUFVVpHyTYEEWpEL/RLCvRcV13ilb9
 SU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769444111; x=1770048911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqkTpd2BLWwgSqoEOPM0ih7EL+CAy98eMIX5Msqrj3I=;
 b=KORfbWMpJKf9KgmFI0eYi0q9MDykFhoJUXMhML24l9OAawO4g+LYETjOtA/mN6kdRh
 yN8abkjy6OYiufHKL+Is8sx7Xb2IiRnABg/j9adW3H52ySkAX58R2v+M1TXewrQHrVZI
 QVZkgKsYOOyBL7zoDneLubJpLIyK/Vyz5xK+Iv0omJ+FcQyAkmThqmRNG6FhjgHZFh1b
 cIvQn5lqWEKTaqcGh9MEXbSjHIX5iPn9NJV+F9B7xb/CkHVBXHUtyG+MdU/hZhQvYBRe
 uZXU5qQOVoDXMnjdCZiekZCKeRgEW0AbWXQWV0nvFj0TXhxulLDwWmnQxlh2KqmAqoJq
 ++ZQ==
X-Gm-Message-State: AOJu0YzNKOUoHhRTvDS5lpsJdBoEa6yYTNUqrGY/ZxZw3qrZUPHEut3J
 UGUZ5QG71cyCrqFqvNtK4FTs4CdfpOkSCG9cNw9kHHJoMixm4jMdfkRb3xpMaQ==
X-Gm-Gg: AZuq6aJK0/sg0+X78ln3xd+CxK6NwbApNurTfXiNRel8MkvMvRqufP7KmUxljLZq4d2
 DaImKDHA27vE3ve/D4IiCYUDLo226Sgdnd/PLpvO8BuSzWsew6VylzX6WWZmpHB30yEcohEQfPx
 huu86jbMm3sIBnBcOiX1dHeAaH099nTscwhYy6CTQ08NZvUMio6OG0qwu+03glaymmZC7JwcbGP
 b4fVnrCMsq3qWmfllyYDbVkFNFfHHpaAcJtrUNcGdUP6LivAST1FNlOu3iyctLzB8b2MwgRY7kY
 mjWguxxg8LqDsLvF//u1qCU1uxlT7sLcOYip66Iogago7ZJryJ2RjgwKxrZNIrNd6x0z9XUqxv6
 takgMctQEiNOs7nY0mJkqiQ1tdyMDKyFOLHmkwNc4fiHJB0EO52snX8N/5zn/VidvDz1Pu8X5hZ
 ag0J9lGtUMMoHVAokgyCyqMig=
X-Received: by 2002:a05:600c:154e:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-4805cd405eamr83173805e9.7.1769444110728; 
 Mon, 26 Jan 2026 08:15:10 -0800 (PST)
Received: from odurgut-Precision-5570..
 ([2a00:20:c361:3985:cfa:b5c2:f360:f511])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d5ffe12sm107368615e9.3.2026.01.26.08.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:15:10 -0800 (PST)
From: ozndrgt@gmail.com
To: u-boot@lists.denx.de
Cc: linux@analog.com, malysagreg@gmail.com,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH 0/5] arm: dts: sc5xx: device tree updates and fixes
Date: Mon, 26 Jan 2026 17:15:00 +0100
Message-ID: <cover.1769439596.git.ozan.durgut@analog.com>
X-Mailer: git-send-email 2.43.0
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

From: Ozan Durgut <ozan.durgut@analog.com>

This series introduces updates for Analog Devices SC5xx boards.

It cleans up device trees by renaming GPIO expanders and removing
incorrect SPI flash definitions from the common include file.

For the SC598, this series updates the EZLITE board to the latest
Revision E hardware. It also adds missing GPIO hogs and enables
additional commands for the EZKIT configuration.

Ozan Durgut (4):
  configs: sc598-ezkit: enable additional commands
  arm: dts: sc598: add missing GPIO hogs for Rev D
  arm: dts: adi: rename GPIO expanders
  arm: dts: sc598: update EZLITE to latest revision

Philip Molloy (1):
  arm: dts: sc5xx: drop SPI flash from common dtsi

 arch/arm/dts/sc573-ezkit.dts          |  4 ++--
 arch/arm/dts/sc584-ezkit.dts          |  4 ++--
 arch/arm/dts/sc589-ezkit.dts          |  4 ++--
 arch/arm/dts/sc594-som-ezkit.dts      |  2 +-
 arch/arm/dts/sc594-som-ezlite.dts     |  2 +-
 arch/arm/dts/sc598-som-ezkit.dts      |  2 +-
 arch/arm/dts/sc598-som-ezlite.dts     |  4 ++--
 arch/arm/dts/sc598-som-revD.dtsi      | 32 +++++++++++++++++++++++++++
 arch/arm/dts/sc5xx.dtsi               | 11 ---------
 configs/sc598-som-ezkit-spl_defconfig |  4 ++++
 10 files changed, 47 insertions(+), 22 deletions(-)

-- 
2.43.0

