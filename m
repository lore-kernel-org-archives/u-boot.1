Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885ECF436BF
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 17:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DA08422D;
	Fri, 17 Apr 2026 19:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GXKkD2V8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 980C884286; Fri, 17 Apr 2026 15:42:37 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41F48427F
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so6530755e9.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776433355; x=1777038155; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a/wYDDUUflfV50gYTvWWMv6fAuN4E8goX/+qp6HPlGM=;
 b=GXKkD2V8Ljyz5mjLZjdGSYIMsdTQOGzcB3R1TOVR+6EsfAMnIOy2Jupt2pGid8oyL6
 HX0EGSxM+6lRKnK+6dkgTvHGfZtu1CoAqT+Ed7zB00ewT0bCoIuvTKnuMBjetMY/C/2R
 poQdRjqK9mE1BU3rj5yqPTM4ZfzPun95XrDY13uzTL91fBPeZJN07CAsfjbgCWo4w5tB
 tO5P5hypjaBgl111gS8LVjLKugJ6LLRRSLQdAeg6nowWKQywEE+PDfkqlEuGP4KNP/iO
 FoWytoe1GZ6JktFXSTzsubU26wcOKm4j9e1j2syKh7SWiEwbsRFRX9rv7V2gLsFPOgBz
 4QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776433355; x=1777038155;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/wYDDUUflfV50gYTvWWMv6fAuN4E8goX/+qp6HPlGM=;
 b=dGgwJc1NH1CsATAuIM9dWatLYKkNC1s45bnq78A+7szBlUNRdrNedKo+LrJStxrLyq
 FdL7/KIKb6XyUMXpeDGTMQx1oKtXDxkxC7EAJJ/77XOyYq+10op/nTQ0AUyzsilFmQNL
 znETXZN5lL4/VUxE6SmxbJ7XDHV2qdxwLmdv8f+7eibNfk/UZhTPCBEizctyY9W+QLcL
 lYECuvgjLvVKqJIACGTJ7ulSeZ3SnEn9ucCUHYEsgn7HQxMws2E+t8xHSJO3Q7iSlY8M
 6AxBK0WNk4/r+t4A/HdG4dHM6cty7TSvBB0SOSPqovp7uCWUN2ZNJNuP38pOWUGEH+vU
 lrBg==
X-Gm-Message-State: AOJu0Yzu9cTAIGZFoqlsQb1iTjDCvMCqr2uljE0ZVy4ouAWa66A6u9Mp
 6sPux/c+ukH1wyMFqBi7M+QTnes7twjIU3KqEw7RTiYJHKlQaUY5Qs0Y59n+uXFE
X-Gm-Gg: AeBDies467wyfRySuId/FQEpqxV6YCQo6NRj95TZxzIJCj86IEEJfNGPtUqjwHDX/4d
 779lKXmsJVq0bBtmXQ7s7EanmOvoWnzJ7e3PFgK3/Mm+oyOYYmJKIcmf50WEPCF3DIksAQCaxod
 0ksTG7COVTJOjQtR//lcbptV51py3LbI8QNpLTa7hDbWqprO5cEhJdtEWRXMD0upYfHushR2JIX
 pdNVfyVVH+7HEgL/2ZR3tSxp3D0HApypHM3mM5d0r4pw6I02tdNbHL5rXpz6UcTSHhV3mdI9Ho1
 B2Ze1yE3+5ftxND33LrX8IXQeyL33d+7URd34TGBWIaE7J35qjw2n73EJ5tHcxVbIZApR1BJmvG
 J1sSQPz7Fp7NUa6x1OUQqYYB96R0kIIwdYm6gUrVUZ2YBFpTe1eone/IRaJI6waD0R1ZEyUgYQE
 pk0s6SMyo7ZcJAU9IEEu/xGJHIQn58kJlbmjtcvlJUYpgnxqq4TPSgD8zvjy6DutOsiQyuDTAR1
 vMcOhEnNp5ykPNN6M9nURmh5ceqM6eAzu+yRA==
X-Received: by 2002:a05:600c:3423:b0:488:fd7e:1063 with SMTP id
 5b1f17b1804b1-488fd7e1253mr13650215e9.29.1776433354671; 
 Fri, 17 Apr 2026 06:42:34 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a0b60sm16729095e9.17.2026.04.17.06.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:42:34 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Subject: [PATCH 0/2] k3-am69-aquila: Migrate to OF_UPSTREAM and add
 remoteproc FW pre-loading
Date: Fri, 17 Apr 2026 15:42:02 +0200
Message-Id: <20260417-elb-6911-aquila69-ofupstr-v1-0-400d93db3747@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKo44mkC/x3MywqDMBBG4VeRWTuQEZtUX0VcRPvbDoiXREUQ3
 93Q5bc456KIoIhUZxcFHBp1nhIkz6j/+ekL1k8yFaawphTHGDu2lQj7ddfR24rnYV/iFlh6g/c
 LJVznKPVLwKDn/9209/0Az0WEe2sAAAA=
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Apurva Nandan <a-nandan@ti.com>, Vitor Soares <vitor.soares@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Fri, 17 Apr 2026 19:42:59 +0200
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

This patch series migrates the Aquila AM69 to OF_UPSTREAM to receive
automatic device tree updates. It also adds remoteproc firmware
pre-loading to the environment.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
Ernest Van Hoecke (1):
      arm: dts: k3-am69-aquila: migrate to OF_UPSTREAM

Vitor Soares (1):
      board: toradex: aquila-am69: add remoteproc firmware pre-loading

 arch/arm/dts/Makefile                       |    3 +-
 arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi |    2 +-
 arch/arm/dts/k3-am69-aquila-dev.dts         |  576 ---------
 arch/arm/dts/k3-am69-aquila.dtsi            | 1837 ---------------------------
 arch/arm/mach-k3/j784s4/Kconfig             |    1 +
 board/toradex/aquila-am69/MAINTAINERS       |    2 -
 board/toradex/aquila-am69/aquila-am69.env   |   21 +
 configs/aquila-am69_a72_defconfig           |    3 +-
 8 files changed, 26 insertions(+), 2419 deletions(-)
---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20260417-elb-6911-aquila69-ofupstr-1c0e85e4e7b7

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

