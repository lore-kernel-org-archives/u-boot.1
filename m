Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD2BE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC06806FD;
	Tue, 14 Jan 2025 14:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eq9bo8C8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF5868069A; Tue, 14 Jan 2025 11:49:07 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4188060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 11:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166651f752so118299605ad.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736851744; x=1737456544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6CBVz5021LfmNYPPOCpoOCJxOPZ0KxEsd/n+moihRM4=;
 b=Eq9bo8C80sUeD2w364rK1Zmj/U83eog/nc8PVZ1SqV3UbR1+ejP3JCLbDwatplHu/s
 mLFCHPLDWElEJe83ICSA2L2ilgHfMDqmiUHaXBblbetIepDYYA+UafOiO8jhi0OvL+OE
 UqgnWKs9/b75HdDX0kS+InEFGeP2Whr64sRJ1n5dFOdObVWkKsF+JjSppPE+SZQyup/y
 USAaWPbKFYcvpDnJ93hFvUZsgAmdLSzyu4odXJa74u2QdWDQ4mY1CSNFUfYChUFwx9lo
 3HPe2Wb4Yr2yHqB9Ar8qjZlshf4i/O+4jqDP7JoWEBg22M8EnOpJ8JEUYRvLcaMhCWL5
 Qqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736851744; x=1737456544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6CBVz5021LfmNYPPOCpoOCJxOPZ0KxEsd/n+moihRM4=;
 b=J00eS+3ibSFY2nrvLjU2TQZ698pn1BXVtogBRu/puze0F6e635x9ZGk0tFNWRbWd1p
 tt7JX3WxJeOeYUc4bWizTIJ90BEeqPN+emTgo1Fp83Yt2ilYBEiB1VmMLbmuVCEVrcfo
 aBZZvsWi1nr/ZPqhEBuVDlqtWjtD7WaGACv7VGfFAEBr+2+dj5mHISrPdhMjnMEOurtN
 UGWHp+0GMUo4czXch6z+ZvM+qXPhn8BhTjQfN4cZdMjgmZA3U0EBzzfy37xldCkkW9Ww
 Pi4gt+m3DtDZepcsHNN00oLDIV3u4IpIYhajwnaA20BZ/otM/FrdArAOgzo7E7rbfVoU
 ZNjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRF98rhRokpsAC4ow0UCwo5/KGMoK1DmGXacg/kSzHb91b9kj+r0Aln+SpRf/2z3/2GJHned0=@lists.denx.de
X-Gm-Message-State: AOJu0YwHUBHMTv4fxY30ORVMiFwyuHN/QhtAX2l7SR0J27g8ZF4IabHy
 NYNdh6GKVemxnkj1W5tixlWU5Bsz5uUgPlggoyeb9cef619/Bx1e
X-Gm-Gg: ASbGncugWABzd6aiS+RewlQTlxO9IUinuhPeu0HQZnq/Rw5EK0YSHRt6wP7BTpZU4am
 38WeYr+wSnOEH3WG34zaeIENsE1IkRqEVgz6y/FwdhCeV3ig7SfOevFUmCexf5EEbuQxP6lVpX8
 L/o/TLqKSTunE4atkstVtV8PmddmOX4sR/8xXBmGfOE3I83aNz+sl8ntCJyqdEH0Axg6LyeIplj
 zIB+jgLW9pph6LVOG3Cge/oRr8aoYVM/g+Uop8R7cqn4dFGmDGKbM8hVKuCCgw2IiaoppwiIJxp
 x/HLy4yBWxwneECtSF5ZHs5/LVot
X-Google-Smtp-Source: AGHT+IFwMbY7CNp6DUtjRpm1wboQRiyL2Xv0GW4rz9GkRYLo7cA/baubtc5KrtyYsD3a98OAeojvoA==
X-Received: by 2002:a17:902:f644:b0:216:48f4:4f3d with SMTP id
 d9443c01a7336-21a83f56bdfmr349751225ad.13.1736851744068; 
 Tue, 14 Jan 2025 02:49:04 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22e542sm65429805ad.173.2025.01.14.02.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:49:03 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 zhang971090220@gmail.com
Cc: JJLIU0@nuvoton.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 0/1] net: designware: Add bitbang feature for designware
 driver
Date: Tue, 14 Jan 2025 18:47:41 +0800
Message-Id: <20250114104742.1478096-1-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jan 2025 14:25:27 +0100
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

Changes for v3:
	- Support multiple buses for multiple Ethernet interfaces.

Changes for v2:
	- add bitbang delay dts read
	- modify printf to debug


Michael Chang (1):
  net: designware: Add bitbang feature for designware driver

 arch/arm/dts/nuvoton-npcm845-evb.dts |   1 +
 drivers/net/designware.c             | 111 +++++++++++++++++++++++++++
 drivers/net/designware.h             |   6 +-
 3 files changed, 117 insertions(+), 1 deletion(-)

-- 
2.34.1

