Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E2AE6BF2B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 16:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0B4844F4;
	Fri, 30 Jan 2026 17:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="we5g5cpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471EC844F1; Fri, 30 Jan 2026 17:28:49 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89EB844C0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 17:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so28526985e9.0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769790526; x=1770395326;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M/gTTfV6eODR19N4OJqmO4nhtRrxh3bF2OZLNoCEdQU=;
 b=we5g5cpJxu8rY23xM0SMvOq4DkfbQVpWYU2PzS+ziJChBRBRsjEhjkCcUjxM2j6Ha3
 R4FTdUdOT5sAwAvZCgq0U7A6b5yyJpiwcYK82DW9esU9c14pIcj5MT2CMP/Ma7IGIqPa
 WwYblDnrF7MWGkuwMk3OoXb6rsU8pwCa+lnu++SXa9P/tUvYjFqiW5BJVx2aSve4lsFM
 nweibwgsUvoNiuH59gx033p3B4wHNkbUYv3TPOTsuTXGStYD4nsX5P36iGi2BLen/KQQ
 M7JihcF30W0GR13VsVcuuvGwaus7v2XpDgw5AlderiqhKW03YduBvwg/bP+H2+//Fjif
 llcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769790526; x=1770395326;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/gTTfV6eODR19N4OJqmO4nhtRrxh3bF2OZLNoCEdQU=;
 b=X7QYay7nAfnXxsRdQ76l/EnMDGYHTSMt3vHkgkXHtrno6Wwb1zpgtdCkKUP80mtcHI
 dFrfXtgMi0b6fQpF1w4AOVAyl5BTomozhwqsj5Pde9Q+6l28VFDShNJN7cX2ari6oNxr
 tMh+DJmaZ5CPN5sL0dPyPc0CNdNZY5IyiLbMGaJE1pWCFJU5G7Unx5fBbBy6lECh3p66
 SO1bBMrNgJw2ltEx7+u8oRmM+8KE23xcfBeR9VodL0X1y5FzBTHp0jvjFLLqRBB1AvQC
 Euf+fj7CjlPaBXqD1N141FdyKVq9AchC6rjCqKGr1kTXPNTskyMBHKbUqjQh+3ZT2iod
 jQ6g==
X-Gm-Message-State: AOJu0Yx2QpbxTESj/QZD+3MPSrfYPRmJkUu6Cc5DEXMvrTj9ed2bDrfk
 C2EecTZprIVJWZRPvU4eusp3WwstYE5vZUpUPopKEG8Vl7VmjzdzcMI752kAlgiUdbM=
X-Gm-Gg: AZuq6aKEiD3Ib1nCoxZb3QS0wqdFVuykcVliLwqQObHJWfpxTty4MM/ILQoqyCY/Pzm
 MktXVbGbe+/B2VAIXrduKFMAmqbR5a1W1A4FBCo8Epdp8E9TPgBwAX88AAbB+Vmhrn+1xIZQlc+
 3GoRXc7ViqhiglQPRSCwccYtM1WWoHPbMI0klsOBF0P8jSgFHqtbQYZ7wWHjYCEWH/ZPJ7b0qgV
 DA75RTW1UPQKQQDYZeI1QjosoHLI0b1IyHTeQuQZTspxhIYsTDL56DFHF+EGghSjn7qK6FoBDGR
 v64qg00GeDgqpy/f/ANkNM56QA1LfYEA6aSAmtjc+IbDNZVanmzaeRIKnHJwbo58ABmu9a8CY8T
 p5Ug7MkEDY/UyJiKmTx4L4ozNayex3VlM7ahWBssc5SddfMU0Uz4VP73OgV1+OX4+Yf8Y8uREjK
 IQ08fqzlx6
X-Received: by 2002:a05:600c:19c8:b0:480:7162:fa48 with SMTP id
 5b1f17b1804b1-482db45fd8dmr44865665e9.13.1769790526279; 
 Fri, 30 Jan 2026 08:28:46 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c37420sm291556545e9.9.2026.01.30.08.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 08:28:45 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v5 0/2] dm: core: Support same compatible in host/gadget
 musb drivers
Date: Fri, 30 Jan 2026 17:28:25 +0100
Message-Id: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACncfGkC/33NwYrDIBDG8VcpntdlRo0xPe17lD2oGVthG4N2p
 aXk3dcUCmUpOf6/gd/cWaEcqbD97s4y1Vhimlp0HzvmT3Y6Eo9jayZAdIii45c0R8/Pv8XxOSc
 XpyOv7ag5IEepZAjBYK8da8KcKcTrQz98tz7Fckn59nhWcV2frt50K3LgzR2NV6ZHCV/O3n6iy
 /Tp05mtdBVPTgOC2eZE44RVvdcE1Ev7hpMvHKptTjaOnDPjMIAbxvCGUy+c6Lc5tXJWCkCCYGD
 4xy3L8geLF077tgEAAA==
X-Change-ID: 20251125-topic-musb-probing-v2026-01-1343fff8176b
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; i=msp@baylibre.com;
 h=from:subject:message-id; bh=mUcsk7LaUYWjiSlpQXtxjYv9vWHWio1zhpsXAkIuymc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyaO9pP+jdu+2d4JKPGwtFOuEFgXU5zfcQTN55l6pf69
 A7Nff6no5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZyh5/hn0GEz/5TTXsTZNLv
 vjtmZcmVdHr1xnmSfTuND9huv6kY68HIML/yoLuCkNXC3hOOXt633hjksv8SkPBz6Ng/wygmJVa
 ZEwA=
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

the core part was already merged. These are the remaining two patches
for musb that change the address parsing and another patch to add
compatibles for ti,musb-am33xx and bind functions that check the
dr_mode.

I kept the subject for the series so the progress of the remaining two
patches can better be tracked.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v5:
- Dropped applied patches
- Converted fdtdec_lookup_phandle to ofnode_get_by_phandle as suggested
  by Marek
- Link to v4: https://lore.kernel.org/r/20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com

Changes in v4:
- Remove log message changes and push into separate patch as suggested
  by Mattijs
- Fix commit message as pointed out by Mattijs
- Link to v3: https://lore.kernel.org/r/20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com

Changes in v3:
- Add short paragraph about performance implications to the commit
  message
- Add a new line in the test
- Link to v2: https://lore.kernel.org/r/20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com

Changes in v2:
- Added a few patches to remove nearly unused variables
- Changed the inner loop in lists_bind_fdt to support set drv and not
  set entry->of_match.
- Cleanup the loop a bit more
- Link to v1: https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (2):
      usb: musb-new: Relative ctrl_mod address parsing
      usb: musb-new: Add compatibles for ti,musb-am33xx

 drivers/usb/musb-new/ti-musb.c | 44 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)
---
base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b

Best regards,
-- 
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

