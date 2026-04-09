Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CF2F364B6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C26084118;
	Thu,  9 Apr 2026 22:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="rsJ1m8Me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9122084118; Thu,  9 Apr 2026 22:31:53 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B5883CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4670676ba03so513449b6e.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766710; x=1776371510;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wJJO0D4SqsPpaJewsyOuSxPcYh6Dh3dvCucz9NS3/YQ=;
 b=rsJ1m8Meh0iSzrL7sn8nfH2f6rfA7AdclyrHHC1xk1kKansbvd0ccG0TneAedP0qP5
 0n7O9HgRMF4OIRGq+hdNJD6gw5uymlkFha6HIziOuRHoahbzK+NOXoSaySshr+Ir/Im/
 hpmYEiij5KJeHIx3APzraGEvNk6VLf9MT4/BKr1+mqgLVYgajDry5GSDfKuLYPH7N1Ve
 SokjBf/N2KL6b5d2lLu1CxHAiOAvvNbDrMnDRYb7RKl5gdoIHVgycOIHZ2w/eC6ZRh9W
 EXCDTfy0Ebq2glERnEL/AFoC5wDYRNId/exT77BeowkexLzPHkwDF8dLjZkCzt82KnI3
 l1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766710; x=1776371510;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJJO0D4SqsPpaJewsyOuSxPcYh6Dh3dvCucz9NS3/YQ=;
 b=oiX5qpveszb7BLYdscm6hXs6gUdlZH+6ZNJRaTgd0/xI8QZe+UkHl+knsiOCLTL7i2
 x4ZDIVO3hCvXSOVe8mWW2SyxHT1DiaFC3ypiTeJj+jtF/QjaH23gLZ9E2Aaxfl//tlaA
 I5zECNfWc60dxKpKIV62QBYjKLiqYZccAYWcxAwZaC2+cshumAPFSfKF80bDuq0917Uy
 1gKtrpx6fxfTwMUWVHwnz17ZqhFbkt5gDyK2ArzdRZfA/YjA66+4qNWALYhpPqEVXdU/
 2EEiYrjEZZaC4F4UAjGGwO1GjajuGjrCLM9vjGogS7Qlnf3Xi0scxKAaa1GNFfPcGvjv
 bWzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEJH7PxhyIU9BSame/79lUxk9x5WkHCY8Ciq+4c8yWsIBH4Xag07hPalzzzYvLd98Fafin8gw=@lists.denx.de
X-Gm-Message-State: AOJu0YwEBrUn3TmkhQuTA8iiD6H35Go6UHgfO3X+JncFsRFBuzc3Bwgl
 FJzWfJSydTNKexiKHFmSQ2VL3NZzqgoc8yZSn4ShazgZUGq4YGudIyrjvS9QY8jKNeo=
X-Gm-Gg: AeBDietH5KsiUzUQwGRqSjQYQ7UbECpGRjh4+k3P0KKBDwfe95ksef7IulN9/rn9MdN
 4jUpqsNHGYO9akR7TyZuJBYGrOSCrOkjb00vBMj0LJqfmHtCXykmNqsBuIFByTEvlNjQSynvaVZ
 n3xQ08Jo4tp8QjS6ZkkY5x8mx39Mlvow9OwWAziGIsJP1qqVItrYn5/iDHnK+zCB1g9ZFhdyTGQ
 f2SyXAIj3ybvYfCutUJ0sWkGSZAI4itc98sT9H2xi44V6Fe6AqkkyT7pvoXFgB0hKhxdN6/Yyrb
 Y9/ikdF5uxAS8s5LHg+z8qu7ROxmHzX+ecCrXAVBruv7ZAjRmtC6OwxlWkD7+2p1OCrYTUiYHqJ
 WOzvj18FAsepKwj2v6JCkki307XpS73KKgDkRZ/pPweNhTen/4D2/BbrZ5qB3UZZLUKp1ZFZ6aM
 ObcKBUfRuNLdh5VbSb+RBUjrMrMg0v
X-Received: by 2002:a05:6808:1b2c:b0:466:f3a2:dc39 with SMTP id
 5614622812f47-478a04fe897mr361637b6e.37.1775766709601; 
 Thu, 09 Apr 2026 13:31:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/8] power: pmic: mtk-pwrap: add more capability flags
Date: Thu, 09 Apr 2026 15:30:32 -0500
Message-Id: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOSxKCMBBEr0LN2mgS8MfKe1gskjDiqAFMAiVFc
 XcDuHP5arrf9AgeHaGHPBnBYU+emjqC3CRg7qqukFEZGSSXB56KI7PhyVpLht3og54ZsZepFpq
 XqoRYah0uh9i5Fiv7Tj/QhNnySzh8d/FTWGOglUdmGmsp5EnjqKJ6Z5UP6GBW3MmHxg3LxF4sj
 XWN/FvTC8YZ3k7HzKiTzPj5otXwIu1wG/1QTNP0BSCZYy3yAAAA
X-Change-ID: 20260317-mtk-pmic-fixes-c1523b1b0dad
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fdVJD22zm2AhvBZz1WXR5QaZoH+aOq+5yCyeKFBetiw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2Axv1Puglt6ALKNN83waMQvzaP1n0+MQHe176
 VXsRNxkpkSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMbxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGyMH/2yUsC2JS1df0s/XOMxXXftCyTs9CggWNIc/vTf
 7XYXKcuqWKcYO+p8vtcxDkSqiJuPn6CQMzmdAgtoYrcHNUGzuTss8OqJzvQQIli2eF+B5+KY7FR
 2g2rvPLWUAv26Kws4r1Wdja9a81S3LzoosUHo8A4JZVaneQxQR6jsQIw5NjuG89v0DCPbXTvNk/
 J+c27gS9rXkdsaMvpkBlyodj+yqVkMW50hp2zG8qtrTWVa1sJioZe/bVOQFVspvxR2hEpGpAN2g
 cpTTLQEeBD1Aj3AnOK3wYOPqR5p3CSKfSytd0UPyD6H/hWtSvj/Piyi9/J13C9ck9tCyaYJlhRl
 lQtE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

After using the mtk-pwrap driver a bit, we noticed that there were a few
places where it was writing to registers that were not defined on all
platforms. The undefined registers are treated as 0, which is the DONE2
register on the affected platforms. This could cause the DONE2 register
to have an incorrect value, which could cause Linux to re-initialize the
PMIC unnecessarily.

To avoid this issue and ensure that we only write to registers that are
defined on a given platform, we can add some more capability flags to
conditionally call any register writes that aren't common to all
platforms.

There are also a couple of other cleanups that we do along the way. And
in v2, I've picked up Julien's patch to add support for MT8195 and
rebased on top of this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Use EOPNOTSUPP.
- Reorder patches to reduce churn.
- Added new patch to fix driver description comment.
- Added new patch to drop chip type enum.
- Picked up Julien's patches from [1] and rebased on these changes.
- Link to [1]: https://lore.kernel.org/u-boot/20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com/
- Link to v1: https://patch.msgid.link/20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com

---
David Lechner (6):
      power: pmic: mtk-pwrap: fix file description
      power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
      power: pmic: mtk-pwrap: add init capability flag
      power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on mt6359
      power: pmic: mtk-pwrap: remove interrupt related code
      power: pmic: mtk-pwrap: use pmic compatible to select child info

Julien Stephan (2):
      power: pmic: mtk-pwrap: use tabs for alignment
      power: pmic: mtk-pwrap: add MT8195 support

 drivers/power/pmic/mtk-pwrap.c | 115 +++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 55 deletions(-)
---
base-commit: 2a1bcefce835b827bbf88a9e112d646c5c4af9c1
change-id: 20260317-mtk-pmic-fixes-c1523b1b0dad

Best regards,
--  
David Lechner <dlechner@baylibre.com>

