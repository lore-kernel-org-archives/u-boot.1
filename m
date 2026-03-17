Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0ABFF6E9B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E689841FF;
	Wed, 18 Mar 2026 00:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oKeJ2jxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C741841E2; Wed, 18 Mar 2026 00:26:30 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F328413A
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40438e0cba6so4042372fac.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789986; x=1774394786;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ENIDQ/sDeRrODOCED86dfphV/Bbx5zF2DLh6qO/xTGU=;
 b=oKeJ2jxwo4QoHQCe3l6R/mOSKp1FM/nrRKR7ZWcjAWIJt6rltiGQglVyy96ScucGXZ
 drJTxI0xhPGCKn9QlOhkU7Bhnft+UqzZDAmwKEco+mOJeVIHqvr5xQXB1GtdmTfxQdfK
 +Ng9JR3JVCjJh10CmuwSbA24bvG7wfIWYNjzANlv0i0xOwjqVbzy9WSokzPWVFwODHNw
 IgABM2720vmMkvS3nK1wvaY9n+u0emL11sqyVb5h1DRspZuiunbBPBJGqgiQZbGcRBVj
 yOPLMj4zI9dxJcX1CKPUwGXXCTr5EgGjIrZ+Ek7K+XKrR4bi3fO+Va3zP5+vEeI4erXr
 nrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789986; x=1774394786;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENIDQ/sDeRrODOCED86dfphV/Bbx5zF2DLh6qO/xTGU=;
 b=l6wEPilVpm9ssIf8PNXXA3bFpDl0A2Qboj913BoU/Huy7XQzqsDPO+wvSaywQW6TMN
 F/dgaypT3nNHe6qjkEUnTKbQKPlzgz8d5W8QS9nqrSUSc/7yTtYpjZMoukmbFFC2ECe4
 c3neKGcDQJBeUoj88wXiJcDYCOqkO3ZdAUGBKE4V4NFg27mz3wQW45JMLQoul8cx8hnN
 L7GxVD7Uj31LOieqab50rNMwugf+dxjH6ydxIT4V4psD25gJEm2SCGVq0oG4ZH7yhAow
 QGOl5ZN5gRIE/dzWVxeRDvvgzuMYqZIEZ5WRQNdUIYR++3zmpImVjx0pW4eLBcFNDmMz
 rTTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLcb6vO3o8KMuwNRYyx9Quwr2ginNV8rm+Bv0BhsLn408WgbgqyLVNoXjs97NtU/8syMixQJ8=@lists.denx.de
X-Gm-Message-State: AOJu0Yylw4fUw4utSXA4gBtEkSJrA8M/RlCxAklg4Bb7or6oxLm6EPyg
 Q8E7z+LnS/GjOdGPYeouOxYfqbA+aKgDn7tovCEJTOqACB8qHT1MU36e8wU6mlPz1ls=
X-Gm-Gg: ATEYQzz0pFfjIvio7YYyKwaO3cQwhntShoE4Oc8x7xn1ElBCug/9/M3VPcvf1lwBOrf
 ncTLnXKyHEFWE4tN+O9lgA+jdXpoNhpccuJ/WZmH0civmU1aYVd4B2u/Tv6b2OWavaI5cuoSMCl
 pTRfUpH+bCT1QmzovUgtZinSTg17y7ZQ0VDNikFKfICNRAoJaZBoahzH+Vr/PnW/u/YUyjBGHwM
 VbrMPyO9fZchYTu6AZmjm1OB+vDJ1lknzv2QuAzOGFLWNZxWoU/5Gd/HdcaaiTfjiVEXfAdnNnH
 wK5iGPCicV2Msk0yKn9NTL1kUQ65iPz0LHvpQwyU6ZvCvzfEBPjGlyE8NzeJkR6QSyANYOj4SaF
 QXkUmrmR681txbYRlApIyCBKqg5dc0eVV3y0wRoHLE7oH/2PNzp62aspHAqoU+URipjJBlUgevI
 OSo3a57xBu71/ig5pNU5ltbCcFozt9Ux/2mSKp
X-Received: by 2002:a05:6870:3046:b0:416:3d80:fb76 with SMTP id
 586e51a60fabf-41bd3f084bfmr938687fac.28.1773789986213; 
 Tue, 17 Mar 2026 16:26:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 00/16] clk: mediatek: unify mux clocks
Date: Tue, 17 Mar 2026 18:23:13 -0500
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwW6DMAwG4FdBOc+bCdCVnvoe1Q4JOK1FE2gSE
 Kji3ZfSy9RDtZP12/Jn30UgzxTEIbsLTxMH7l0KxUcmmotyZwJuUxYS5Q4LlNBcO7Cxg9GxWcC
 OMwzKk4sBcm2KSpHSBlGk/cGT4XmzTz/P7Ok2phPx2RRaBYKmt5bjIXugzRhi37JyX5ZSidSB6
 T04mqN4EBdOc79s3075ZvzjsSkHhEKassJ9ZcoWj1otV9aePtPxDZ7kX6x+h8mEadyXpL5LXdf
 tC7au6y+sQrGvVQEAAA==
X-Change-ID: 20260302-clk-mtk-unify-mux-parents-1bf35aeabf00
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3348; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=kJfYqPBGNtimYtBDxeQeW2LODZyDQUgTO8QBhajJ86k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueJrE9lV4h5iJ/oxzhtiVNYwoaAFgKM77YDyv
 NPa1BaCrWqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabniaxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AgoAH/0iYIiXq+sxrb3dSy2RF9y+B4DkoQ9L/DB9kOPq
 DgI23MN81i0L15YIdBb5tUibqLrBkO5aTAFRpXjZWiX+VlmgEz43EJbbxVGEGFWoUWzU3yNsfq+
 CNojT4fA9V9iq9XS21CYNqrLvolfrbXeX9HUU/TUo8oN81Svsn/UWVfQKAoNrysYVhG2YnA3R0g
 p3hJpqUYFLYYm8Hu2pmycyg3I2M7C9aD++pYGD/vYqh4LrVwToWHAaHU8RbJ+NMsGFkPs7mAS8j
 I55rh9b1UHbT7Sg2qDdicbLYa8Q7rcnsZ3dAjKHmebq7l863FAsqGFeGQd3TrOaAe1vilMRVKA0
 rHzE=
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

The MediaTek clock driver currently have two ways to indicate the parent
tree that contains the parent clock. This adds to code complexity and
makes it more difficult to know the "right thing" to do in new drivers.

The plan here is to convert all mux clocks to use the more robust option
of using struct mtk_parent to specify parent clocks.

The conversion to the static const struct mtk_parent arrays was done
by script to minimize the chance of error (and save time).

After the conversion, we can drop two of the clock flags that are no
longer used and remove the dead code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v3:
- Picked up similar patches from another series [1] and updated commit
  messages to match to this series.
- Squashed the mt7622 patch into the one from the other series.
- Link to v2: https://patch.msgid.link/20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com

[1]: https://lore.kernel.org/u-boot/20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com/

Changes in v2:
- Rebased on updated dependencies.
- Link to v1: https://lore.kernel.org/r/20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com

---
David Lechner (16):
      clk: mediatek: mt7622: convert to struct mtk_parent
      clk: mediatek: mt7623: convert to struct mtk_parent
      clk: mediatek: mt7629: convert to struct mtk_parent
      clk: mediatek: mt7981: convert to struct mtk_parent
      clk: mediatek: mt7987: convert to struct mtk_parent
      clk: mediatek: mt7988: convert to struct mtk_parent
      clk: mediatek: mt8183: convert to struct mtk_parent
      clk: mediatek: mt8188: convert to struct mtk_parent
      clk: mediatek: mt8195: convert to struct mtk_parent
      clk: mediatek: mt8365: convert to struct mtk_parent
      clk: mediatek: mt8512: convert to struct mtk_parent
      clk: mediatek: mt8516: convert to struct mtk_parent
      clk: mediatek: mt8518: convert to struct mtk_parent
      clk: mediatek: remove use of CLK_BYPASS_XTAL flag
      clk: mediatek: remove CLK_PARENT_MIXED flag
      clk: mediatek: refactor duplicate *_mux_get_rate()

 drivers/clk/mediatek/clk-mt7622.c |  288 +++--
 drivers/clk/mediatek/clk-mt7623.c |  649 ++++++------
 drivers/clk/mediatek/clk-mt7629.c |  371 ++++---
 drivers/clk/mediatek/clk-mt7981.c |  233 +++--
 drivers/clk/mediatek/clk-mt7986.c |   12 +-
 drivers/clk/mediatek/clk-mt7987.c |   78 +-
 drivers/clk/mediatek/clk-mt7988.c |   82 +-
 drivers/clk/mediatek/clk-mt8183.c |  584 +++++------
 drivers/clk/mediatek/clk-mt8188.c | 1522 +++++++++++++--------------
 drivers/clk/mediatek/clk-mt8189.c |   12 +-
 drivers/clk/mediatek/clk-mt8195.c | 1349 ++++++++++++------------
 drivers/clk/mediatek/clk-mt8365.c |  450 ++++----
 drivers/clk/mediatek/clk-mt8512.c |  620 +++++------
 drivers/clk/mediatek/clk-mt8516.c |  704 ++++++-------
 drivers/clk/mediatek/clk-mt8518.c | 2088 ++++++++++++++++++-------------------
 drivers/clk/mediatek/clk-mtk.c    |  112 +-
 drivers/clk/mediatek/clk-mtk.h    |   69 +-
 17 files changed, 4611 insertions(+), 4612 deletions(-)
---
base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
change-id: 20260302-clk-mtk-unify-mux-parents-1bf35aeabf00

Best regards,
--  
David Lechner <dlechner@baylibre.com>

