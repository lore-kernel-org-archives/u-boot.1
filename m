Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBBFC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7316380C33;
	Thu, 20 Aug 2026 07:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vfSk9HJ97EvO; Thu, 20 Aug 2026 07:15:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210117;
	bh=iGUSTLFNjnija2J0AfumMl4W3Ly4DKGC19bteh9GLl4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HWfNwnw89tClFauCPxUahlpvAxE1GZki8TbPywBldy7ZaX/A+CAPLlpbcGgngNKJR
	 qjfQAHJQ7rUvZhobD3GEXxokcd5cro4Df8cGacmqNFv6Ui8EQZRsty/Kn2dX41xaTD
	 lsWKLhTcaDFD2ikc9hejR+2KafeDlJKeGGiQjTJoXOMFJpQ3KVtYsk3pNEXBKmpl7Z
	 HRJoWAewqOv9txbcloq27MbcYRR09eKUEr1AfOhs3mRVDsu0wwCA609YLWQrGVryhj
	 II4ht7H9Njk227pL63hAnKz7Fox65z6XZOoKirJiF3tfIqRKuUPGpHkSjZbUuIv/Mc
	 FLUJf3IgGWEKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9329380C10;
	Thu, 20 Aug 2026 07:15:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80A33323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6682C404C9
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j_G2Lz3mwjI1 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:15:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YpEyowHq
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4853240483
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:14 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4998590d392so17210215e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210113; x=1787814913;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iGUSTLFNjnija2J0AfumMl4W3Ly4DKGC19bteh9GLl4=;
 b=YpEyowHqpJUkf8hUGid0YwCUBnbHs4ZfUTtYBFGrjZVP4koUgdqZT7aEVqmztAcwiT
 njkXg7xUXpYyrSSS4PIceTiEGvaK+wzLG660C2ZnxtxoR/MFRRzjkapa5431tStioYB/
 Zi2HLEbuwbGwbwy89AVUaJ4L903EbEcdxOJfprGYh8/Jeo2cCuODV2qVi7uGSRUbP/2j
 LKDXzGJTkbSWeBw2wp5bT0Y1/zJBT/k10bECFbzKdLrf0pzi9d6mVGsaf7Uf1SoxB9gj
 CDT997/eG+cyvUIh6OM+8jjb8zzhfNONnB2wWUgnjnY5BkqH9x6X7BOscDVhEJW/jNIV
 qSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210113; x=1787814913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iGUSTLFNjnija2J0AfumMl4W3Ly4DKGC19bteh9GLl4=;
 b=hNmZCRC0TLSuPnf9M9h3zmIMhVDRqIPF3tcELUURM5SNmIYfxBijIGvYFzWtA6lRrG
 34U+HXVN0gAa1MlPOIMdW9YLnMBlcyZbxDz/TVwNTG4SCOUtg9KpSoHDeQNNjnegGXjd
 XKDWlNRz6hx7yATe7hM2RBh/BV7wyFruASY8OxFLg7h/2HZ59+lblseJREhsNrvK6G/E
 II6kN+PL/AlaZF0KcUrgD65FK+oCyYrA3BrRy0ARk9jQF+vMZOoUgpcUqErGm0QY8qIZ
 uRa2vUok3qizoF35U92oUxLktc40xdKdO8OvfnQ4qlbYxfbLkpVPJRQDUP/bT/418LV4
 jEuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3fTNJd1XQhVza9BLme9glH4U2ryi0K1vOks4QscZPbq0n0uo1UaFf5fB3TlTc4R/3ki6oDq8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxn4rF8zAHTMErLrCWCNxDvZd/Ww1SZq3nu1DSdeOFKsLnUNUdL
 4pj4EIDMeXXA0kzL3sx+QW0hZhvKCFXhrO/o9G4dLkYfa3N0QZ3QA1CQ
X-Gm-Gg: AR+sD12jyVRxVOrDWtz6Rjo1sruqnYqeJkr+jLxSVAF/GGr+rL/6OJ89AF0mZSqbxGl
 vYhGtw5xKfG66QNib0M7e3CLMGD+PAO/uf1jHlxmLcsRfh/i6BcpSc0vAE6OVs0jzrY5r3ZeD9z
 VKQHMgU4SPqnhLRBl/Uwuz09GIn4dLSc8cKhAjS3QTrqBWnVi1Md/HRt6jONucMaKgu/OuUq3Zv
 trYGcEtq/cAILD6tarz/CGiX6vzCAuVm5mJmpEyCKcT5lFS0QBJUYTL2DXcSgsevbnUsGyWq+y+
 hKg4wFkaywvaFylSJqtOpYjcus2NFlOClLychwYfRZucR2ag2P/X2xkOLPAKwttdpqWBqEhzqAP
 B1yKatXgpEGzHBAnwby9kLLFADF3g4Ko1N7KAeUPVN/7DFw5lTOJroxHjSL1cH+HYd6gqibhcYC
 Z4KL/g5TT58CeJVc8OyVwTM1zySI1nQvkWHWs9rI6vvYNpWNvArUdvlqjMYJDQdb64eA==
X-Received: by 2002:a05:600c:4713:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-499aa1e247emr147186135e9.9.1787210112832; 
 Thu, 20 Aug 2026 00:15:12 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm158151475e9.11.2026.08.20.00.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:15:12 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 0/4] usb: ehci-vf: take the register bases from the device
 tree
Date: Thu, 20 Aug 2026 09:15:07 +0200
Message-ID: <20260820071511.1036506-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Review of v1 asked for three things and they are all here.

Marek asked whether the code path removed in patch 1 is used in SPL
without DM_USB. The question is a fair one, because the select of DM_USB
that USB_EHCI_HCD does only covers U-Boot proper: in an SPL build
CONFIG_IS_ENABLED(DM_USB) reads CONFIG_SPL_DM_USB, so a board could take
that path there. No build can, though. The driver depends on ARCH_VF610,
five boards select it, drivers/Makefile builds usb/host/ for SPL only
when SPL_USB_HOST is set, and none of the five sets it or CONFIG_SPL at
all. The path also does not compile, which is how it stayed unnoticed.

Patch 2 carries the two Fixes tags Marek pointed at.

Patch 4 no longer uses fdtdec. v1 did, because that is what ehci-mx6
does in mx6_parse_dt_addrs(), but the livetree calls are what review
asked for and the driver now has none of the flat tree API left, not
even the include.

One piece was missing for that. The alias of a node reached through a
phandle could not be read with the livetree API at all: dev_read_alias_seq()
wants a device, of_alias_get_id() wants a live tree and these boards run
a flat one, and ofnode_get_aliases_node() answers the other direction.
Only fdtdec could do it. That gap has stood because the need is rare -
ehci-mx6 is the only driver in the tree that ever asked for the alias of
a node it does not own, and it reached for fdtdec. Patch 3 moves the body
of dev_read_alias_seq() down to the ofnode level and lets both of its
variants call it, so patch 4 has a livetree call to use. It is a pure
move, no functional change.

Testing. test/py on sandbox, before and after patch 3: 11 failed, 414
passed, 210 skipped, 1 xfailed, 20 errors, the same failures both times,
all of them from tools and images missing in my environment.

On a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from NAND:
"usb start" brings the host controller up and enumerates the root hub,
and Linux still boots with Ethernet, SD card and USB working.

v1: https://lore.kernel.org/u-boot/20260819093705.4143509-1-mehmet.fide@gmail.com/

Mehmet Fide (4):
  usb: ehci-vf: remove the code path for a build without DM_USB
  usb: ehci-vf: drop the empty bind hook
  dm: core: add ofnode_get_alias_seq()
  usb: ehci-vf: take the register bases from the device tree

 drivers/core/ofnode.c      |  20 +++++
 drivers/core/read.c        |  20 +----
 drivers/usb/host/ehci-vf.c | 178 +++++++++++++------------------------
 include/dm/ofnode.h        |  14 +++
 include/dm/read.h          |   8 +-
 5 files changed, 102 insertions(+), 138 deletions(-)

-- 
2.54.0

