Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53000C54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D84786EEE;
	Fri, 17 Nov 2023 22:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PzaJ7acH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCDD686F89; Fri, 17 Nov 2023 22:15:19 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1E68004E
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1f4e17c1edfso1277510fac.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700255711; x=1700860511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Ub2QePyAd1SXbWGSvN0ylot2lKtk41PaMZw0Ozcqws=;
 b=PzaJ7acHKULvbbA4pmjDoAIFrBJzSFNjyCy/VXSVO8ydusOdxixstBHmt5v2gJADmj
 6QO8kyQR/wZK+UBkZ9BH0M4nBUggQIn8N34dnw5dOkDsmHrhxvqiM3GEo2ZoooMvuLFG
 fkbx3X+VXmqdW5CUkj4LZkhZXRvE51OF6tj9QpJ+wi3t2iPR2m36Oqm+e+wq4cd7IfPN
 tgxKCdy2H9uMEc4jALR2xcWKKSuoTAIeEKF47UQJsB2/7DRlHFKVZII8JSZVAJuHvyqg
 CfxF5br5SHx7+dWFdKJ/GYZtHP0ewOsuztxUm2/QdeCww65JqOvdQbXkDatTDoF1e9/t
 o3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700255711; x=1700860511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Ub2QePyAd1SXbWGSvN0ylot2lKtk41PaMZw0Ozcqws=;
 b=U55W97tSvUVq1RR4RkltzF894fMT/rARusLy9pytjzegQm5IAwk8+oka3nN8fEB/ks
 SbVG4nu0HJb6k6jVUPrDnJyh2+QidhzwRSEDhK6tGoR+B2z+3e/unXTkCdZW3j/08jJL
 qeijH7DCOAI6xvcugdh2lrrHEOZNRh8WLBA7bp6LCdPA7LJXRLN91Mh7kXK8leUEeWV2
 Tk1W1mqJ1Imq3/6K5MaSsU2gqbwF42F6uKQRZBANI/flflZ242H7NnisqvBt0qkvNV/t
 IKa1ghqGV8WKIBsg97yNp16NhhVgueqgzfaQqr5o/XdwVDSKOh0qdwVg86pfRblroy8k
 4tSQ==
X-Gm-Message-State: AOJu0Yyev05iQIg0vg0AUMMdelvzw0V6RCcQoEoB2FL4rJzgZYeAZpl6
 MGz6FlzFodVOaJyFrpfsLq3NahMDg0s=
X-Google-Smtp-Source: AGHT+IHuQLOsGaccpWL9Zeurw4jV05kIRSE7cUU5Z+scikVBpm33gMPKLwN+ZjBwLYsie4FWUWE9wQ==
X-Received: by 2002:a05:6870:e2cd:b0:1f0:c3c:cb02 with SMTP id
 w13-20020a056870e2cd00b001f00c3ccb02mr411087oad.32.1700255711167; 
 Fri, 17 Nov 2023 13:15:11 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 zl3-20020a0568716d8300b001d6e9bb67d2sm415378oab.7.2023.11.17.13.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:15:10 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 0/4] Add Additional Boards and Features to RGxx3
Date: Fri, 17 Nov 2023 15:15:02 -0600
Message-Id: <20231117211506.1396929-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Chris Morgan <macromorgan@hotmail.com>

The RGxx3 is a pseudo-device for U-Boot that works for every Anbernic
RGxx3 series device on the market. Add support for another series of
very similar devices from Powkiddy.

Changes since V1:
 - Update verbiage around function button to say "recovery" mode
   instead of calling it "maskrom" mode, which has a specific
   meaning. Also note that recovery function was done in a board
   specific manner to ensure it can run early.
 - Update board level documentation for the RGxx3.

Chris Morgan (4):
  board: rockchip: Refactor panel auto-detect code
  board: rockchip: Add Recovery Button for Anbernic RGxx3
  board: rockchip: Add support for RGB30 and RK2023 to RGxx3
  doc: board: anbernic: Update rgxx3 to add new boards

 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 195 ++++++++++++++++-----
 doc/board/anbernic/rgxx3.rst               |  18 +-
 2 files changed, 166 insertions(+), 47 deletions(-)

-- 
2.34.1

