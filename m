Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AE8F364DC
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 11:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBF784099;
	Fri, 10 Apr 2026 13:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="rDAoU0VD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDFF08412A; Fri, 10 Apr 2026 13:04:35 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8B383DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 13:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43cfb723793so1288210f8f.2
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775819073; x=1776423873;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ALhuSc9suXHScvFf+MEKmuYry3RWREFf7/732iZe9do=;
 b=rDAoU0VDZxbNLvQSwph0482HKpn2jC7kwLAb6/OeKsWtixloH+oU4MAD1XL2YXDZ9R
 QuXx543fFTG0i8WvcExp8ZgjmprlFssikMSA4qEmMIaopS0V8pTT0sg0cRhe3AjwVVM5
 dfo9C0BvQjhnIXBY+azF7yuTHCvHk2sSWt6ORK/klBGULe8ZE/1+kifGCyPLg/QLJFtk
 Ql29cbtzRX2kQl5v3/56TGFOr4jMG8srwmtj5lAmfVqLxt1+vlFxFqkn/gJe6HVA5OlZ
 EcA47VgCAVrVg2QYu0kATuObKvMKLdfXKOrRwqlr4PhhCkqUY5PkpUbFN98sgmFTrkbh
 Yehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775819073; x=1776423873;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALhuSc9suXHScvFf+MEKmuYry3RWREFf7/732iZe9do=;
 b=JoRZlsbt1pKGajx2+G2iVd3i1GFRz6XdfrNqdEiQQqXRxYAmaiAuD2+KyyqAivsSZ2
 Zmy7EiABPxqcY1e7AkokAiYXXwh1zleu3QWtKcF26AOThvvsu6IVsQMdKL1IREzE0aV5
 3jv2DYQ2g/qWq6YM8AI1ytgZJCVvG9t13Wm3vVav03rDgKSnXUa5JXLQB5/pOl+9PPfw
 kUHUrriUaFlE1HbVMEEGW5b0RayyHn59x5KDhwNWr23o37UTHiMoQF4bh0DrtLInbiDt
 XBtNy6R6Ol8VcbpI2zQLs5/cRg0bTipcdg2HcL90GRu4pF8MN8TIPBCYJQa1d8ifUmiH
 YFqQ==
X-Gm-Message-State: AOJu0YxFSUatH78uno1o8Evcb3eQnDsZm3tD4eW35b792a578cjxESuM
 QDF82GhQO/nhLMzB9eNkOlOvOuYnNy3oxi10h89+VOe0HPTlSdfbbFdbi0XCt28GWvc=
X-Gm-Gg: AeBDiesnMBHjjxx9iaslFFHjsN6uODWyRJU51L7TbDHeoA3BwaM8LmPg0t8DMFt/6D2
 7068k8NDQ7vnY/OO/p75NY4TaoY2HCrPRT142Xj2c18g9rLS81jd8/4kiV40GDhccTNYVUunZMj
 8cJ/ZnU7uCBb8qFsu2RDcMTfL6g1k/Yq/c1tOYC9uu1V5sP5EmdEhdIazyAcYnOORCGaDCos6P1
 0cUc6I/ZVXsX/05FsqAJJV68XhoxMcHVvLQBJrsRx15ipVFVvxAZi951y+Mb+AYaFHaUvJOYkSt
 GOFm9ErkpRTc/UUS+28gdtkkytFADAT8iX06Coe7lkiZa31SPtVZnVk2F7qymjSJ31dM5sVdFfj
 64k6MGim55cx4w8vOGMfRjFfd3POlxww2MuNDKKjhNP14M+4Tgoi3Bgmmu4lZguEKsR3psLxrxj
 QN2ULe14yV22XUHqxTO0Wr
X-Received: by 2002:a05:6000:2886:b0:43b:93af:e124 with SMTP id
 ffacd0b85a97d-43d642c7992mr4048938f8f.26.1775819072997; 
 Fri, 10 Apr 2026 04:04:32 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2999sm6382054f8f.6.2026.04.10.04.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 04:04:32 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH 0/4] net: cpsw: Add cpsw-switch DT binding support
Date: Fri, 10 Apr 2026 13:04:02 +0200
Message-Id: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLZ2GkC/x2NSwqFMAwAryJZG2hD8fOu8nAhNWo2tTRFBfHuV
 pfDwMwFyklY4VddkHgXlS0UsHUFfh3DwihTYSBDjXHWYN6iePRRD9RDsl9xfx2aFgOfGbueyc4
 0kXMNlEpMPMv5Hf7DfT85WgFQcQAAAA==
X-Change-ID: 20260410-topic-cpsw-switch-v2026-07-next-89e21f2d2446
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=msp@baylibre.com;
 h=from:subject:message-id; bh=SCp9MJCFq6Pm40TfOoyq2ZPLuejV8fMLKnEyq+DfZRg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbN1WLC/IcPKJevb4SkrgjoEzqy/IKswnHvebwdB/ea
 J2cx7uio5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACby4zEjw8+F7J6HX7tV3ou0
 eqE0w8irSUuHZdUT4e+tEk3exxTU2xkZFl+W6zqxz0ms2fVW1tRjH1bsac8NXWS6Q3HSSqnsSZ7
 1TAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Hi,

this series adds support for the new cpsw-switch DT bindings in the cpsw
driver. It does not add support for advanced functions in the current
driver.

As most upstream devicetrees are using the newer cpsw-switch DT bindings
by default, it is necessary to be able to parse these so OF_UPSTREAM can
be used with minimal changes to the DT in u-boot.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI) (4):
      net: cpsw: Fix error message
      net: cpsw: Remove compat string argument
      net: cpsw: Use driver data for phy_sel
      net: cpsw: Support new cpsw-switch DT bindings

 drivers/net/ti/cpsw.c | 190 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 143 insertions(+), 47 deletions(-)
---
base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
change-id: 20260410-topic-cpsw-switch-v2026-07-next-89e21f2d2446

Best regards,
-- 
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

