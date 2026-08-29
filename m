Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874E9C61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 22:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D9AF4068B;
	Sat, 29 Aug 2026 22:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hESyUgNvgIXh; Sat, 29 Aug 2026 22:44:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788043496;
	bh=0OZQDol4XT5zGx1AVAhTnwMv/xF3sKgbYYBSBQofzIo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xodVGjuxQQ2JP0O3hl1y3JtQYeN+a7UIdSno4EPBhW+OdUDNteKFU2a9E/ym3ceaM
	 b68LapQOH/3hHzPsjSR5EgmyQrfJF+0AKzu+H8QzSFD+gggLkCb8YQb0+v5XyBPHBS
	 rym7rpqkPct/M+wejCRBA5mZzEO5XK7nvB/rEcZjTTIrYOezv6Tc3KM6i7iUkkMA17
	 aBRxryZdbNj7cc8zkh3YoVVKM3xlWtA52RTJBQBmEu55MrSKJytlhePhdtIIa7ljEG
	 5cZjwgtA30I8/ejFqZdujdaDM3C7ciRsVpg8rSlmbXAJMDT/ipSXEN8eK55KWJB/Rc
	 LGrKpXge+XqKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FE194068F;
	Sat, 29 Aug 2026 22:44:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 210F1355
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1276A4009A
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpaxBb06Aodi for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 17:03:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jqxXjHtO
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1868040052
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:31 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-482e067e908so1431630f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788023010; x=1788627810;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0OZQDol4XT5zGx1AVAhTnwMv/xF3sKgbYYBSBQofzIo=;
 b=jqxXjHtOHwtVBskQW7Byry0qVgyWH+UAZM9cVHheEmSi/e+aIRC/Vz4Dkpgw5PIGR+
 /MP4Y7kPsgFIp2HDyuGrp8jjoIxNw2KdSgMJTOZCWW3Ql5YndyeQ701pgRRm7Gtmhoh+
 pR6Z2yHTb4DZBwrf7GUFTyCWnHR2iZ/c/veaQ7XMCigi0I4AX+DZGb4w6uPgVujhFJMW
 12eKc9Ba/SHmtOwvb044hD11Fz9ndVDJKpsIZ/IEgaU34GTb1yWomt0reHEr+o3MxgiO
 R1BS/JC8cxWua2/VQXWgV2nLC9Zws6nXsy7/+5AzC8LqBu7zq26JKKu0ON+Lbv1LXa4O
 nAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788023010; x=1788627810;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0OZQDol4XT5zGx1AVAhTnwMv/xF3sKgbYYBSBQofzIo=;
 b=hweS1r2FSI+XgcC4IwB8uoB+omcdaIat7DLV8iaBFo9+ELYZQizHtHL5mVxrPpcEk8
 mVLP+oelgZugdzXdnQbl8xRNjwWH8DFmIVU7IISQkbgIZWEi0Bn7mw71PJLvWtZKBcYm
 SOZ6soBa4a6ZKmPFbJ82sz72+xFzD1HdE1ppQkhPu8/RZU9kFzyk7N4GVZHazs/tWT/g
 bF65loZ2g2q8M7ipkgg3yHoFqSvx0M+I52ygKr9Q0omFE7wquwUqdcVkJmdxivWCikCL
 PHksoMdlirXUULfWG6O1Zof3F+fY54v792fhWib04MovQT5Xp/UkdMpwSOYylkyFoVcj
 FoFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJxn41xE5mL28uNxABdv6+8tTEbf2LbJWg1hKCXUBD5IpsrupesHZ4c5orgCmnZPfi5YksTdc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kpg85UJyRSZw5AxMa24fZnzh2rsj69859Rt0W6PQ3OrTdA3yZ8
 D/de6JkAoQL1za2MyQ2douFvlQKpuMBmGBliijbH0PZXC6s5Nn5sguKv
X-Gm-Gg: AYBFou046OqcKdEzv34GGTxQ90zOTiq2U/lwg0pEFmJr4C2gyjrDTPD5EaN+Q9nPprc
 tzK9xd/HjZqsD654pAkRCBBSNMR+aLe7OqiBGphbMBqf3+jKGoQQSXrDXOLeqUyBm72Y3I0oEWF
 aMCE/QqBFQ1jdsFG/MI6qm3hOfr28Vaa5n3MPoqV7FpFs/3+xvH3rjKEZ01azGUmNkOTWZv5rjg
 W9rmAArJXLAtb0lmwIh6cvdLKEU82zXPm1p88rBE6Plgwip2JnBPhJv0REqhhEsdyH0ktkf4CYJ
 3iNCcas7bS7Dm50dayKNDcBuBJuWPpFwvDunG61CRkwjtcm4/aUeZj2w7c8NfRGMIn85atZlSvy
 gIMIaYKcZ0yGNcd2FeUlAbySgritrItflDspGIfPgx7tYtH+cIcUp2bI60k+F0XCb7ASiUzFJoK
 AdiLGh5w+nDA6aRc1W7BiGfgrA7SM2d6TMdfk0OSMNz2uHhK6XoyOzGyriXC5mGd5cybnzvMVNG
 LX8VVK1NA==
X-Received: by 2002:a05:6000:2403:b0:484:3310:f394 with SMTP id
 ffacd0b85a97d-4843310f432mr4717993f8f.23.1788023009638; 
 Sat, 29 Aug 2026 10:03:29 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.168.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb32ce2sm12163133f8f.33.2026.08.29.10.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 10:03:29 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/2] Support multiple DDR configs in PX30 TPL
Date: Sat, 29 Aug 2026 19:03:10 +0200
Message-Id: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4Qk2oC/yXM3wpAMBSA8VdZ59qKWVpeRS7YDo4Y7Y+UvLvh8
 ldf3wUeHaGHml3g8CBPm00oMgZ66uyInEwyiFxUuRKKG+P4GpdAXGg5mEqWUmoFqd8dDnR+r6b
 97WM/ow7vAO77AZgaoxRtAAAA
X-Change-ID: 20260828-ddr-multi-2c4fd64344c8
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 29 Aug 2026 22:44:54 +0000
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

TPL max size for Rockchip PX30 SoC is very low, but 10240 bytes are
enough to store in two DDR configuration parameters sets if option
CONFIG_RAM_ROCKCHIP_DEBUG is deselected.

The approach is trivial: apply supported DDR config sets in a predefined
order (DDR4, LPDDR2, LPDDR3, DDR3) stopping at the first one that makes
SDRAM initialization function to complete with success. If a smarter
cleverer or more reliable approach exists, suggestions are welcome.

The patches have been tested on two boards, one equipped with DDR3 and
the other with DDR4. All possible sets selections have been tested,
even with orders different from predefined one (e.g. DDR3, LPDDR2,
LPDDR3, DDR4). It would be useful if further tests will be run on other
PX30 based boards.

The patches does not affect binary code of TPL for any of the existing
U-Boot configurations.

The first patch improves clarity of DDR type support selection for
Rockchip SoCs at Kconfig level. Not all the DDR type config options
named in the Kconfig are supported by each one of the Rockchip SoCs.
Moreover, the LPDDR4 option has a different meaning in the context of
the RK3399 SoC than in the RV1126 one. Thus, split options with ad-hoc
specific help sections and use depends on conditionals.

The second patch splits RV1126 options (at most one should be selected)
from PX30 options (more options can be selected), and adds DDR3 option
for PX30. The PX30 sdram driver includes all of the selected DDR type
sets or just the DDR3 one if none is selected: not like it too much but
I preferred to preserve default fallback behavior (include DDR3 support
if no option is selected) to avoid modifing boards configs relying on
it. The parameters sets are applied as already described.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Massimo Pegorer (2):
      ram: rockchip: improve ddr type configs selection
      ram: rockchip: px30: allow multiple DDR types selection

 drivers/ram/rockchip/Kconfig      | 78 ++++++++++++++++++++++++++++++++++++---
 drivers/ram/rockchip/sdram_px30.c | 35 +++++++++++-------
 2 files changed, 93 insertions(+), 20 deletions(-)
---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260828-ddr-multi-2c4fd64344c8

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

