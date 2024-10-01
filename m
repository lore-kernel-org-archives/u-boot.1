Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3E4CEACDF
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 16:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E218920B;
	Tue,  1 Oct 2024 18:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YrAk8JKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D1389249; Tue,  1 Oct 2024 18:06:18 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7FD88D35
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 18:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so46943495e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727798776; x=1728403576; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9G2l7+To5OlgTCvgraK4cWfefDy9bhL/BPt0Ejv7RX8=;
 b=YrAk8JKlp7XPqMyPB25asopQauFX7MhxVjFPhyyYfmRu4GdCFQWJUW5iD4lFi9vuqp
 hTmuaMviqzdqyeR5iZB+0tMvlv5mBqaUq3dRmxsGjP3/1d2bQlMc9d1c2SSsFefwTHIA
 b6Bv2nejUbporo9bqfEV43nvkeIsIwOjKgx5OC3zrFsUM9CEw2f3p2vZBBeiyobOXXcV
 w74404XehecE08zbwUlVlG+BdU/g00DqXfl6FYyjtBqIJITT4ByAyFooMChKz7iVHIjy
 PLcf6ymQGqf3/pNDxSv6NdjVq9zLOFqHpu4jMFU8Gdz+IbJfCnBl4lu+FvMxguishpjn
 Rmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727798776; x=1728403576;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9G2l7+To5OlgTCvgraK4cWfefDy9bhL/BPt0Ejv7RX8=;
 b=iNCxbiu9eSx3dQkOB+0rVjUmMVbbW+7ayMT0GyhUS/P3Y6o1iQvMgyCebDnc7aPAJg
 CdAuVpOgDCO5lJNWfUKA9ItC3qLC6IgvZXu0wQOoejY+FsMAQu/P9PJQJES/Geo0ViG5
 X1ZlBm04vNOsmVY9Sm46XWCe67/tziW/41iAtE/VdQKq7ABWNH8p6IOwdEE+vS+rH+Tx
 5EKQ2r0swNP74NEE2BeS72SGmSwuF5F3y1ab+ZrOPjDgQdiw/kgj2NcSKpoim6sJV2K4
 xrtwIz/qle86JqSNpev8W8KfZTB3MrXfLYVkSVYDvD38eVAuzvNZYWQhgHEJmpGxzf3k
 TT1w==
X-Gm-Message-State: AOJu0YzhyWY9BpAl/2lFpvZAOhE7KpXrwPqITWrmW/Gjb3aQfaqvAMOl
 ghZwgf04G6uGOMEjRi6JVT/MxMNcikszOjXT+RKRTvdQEuXBMpuzhLaOOQUOw+o=
X-Google-Smtp-Source: AGHT+IGg9j+xx45PAhrVY2QDbz7QK+HOTsHRI0kACod0Y0ozI/Lsz0jT5+YJEf+agXvI1oD5T5tG0w==
X-Received: by 2002:a7b:ce8d:0:b0:42c:a8cb:6a96 with SMTP id
 5b1f17b1804b1-42f5849939fmr132073055e9.31.1727798775793; 
 Tue, 01 Oct 2024 09:06:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd574282esm12031460f8f.104.2024.10.01.09.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:06:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] dfu: sf: fix flash probe when DM_SPI_FLASH is enabled
Date: Tue, 01 Oct 2024 18:06:10 +0200
Message-Id: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPId/GYC/4WNQQ6CMBBFr0Jm7RhaQcCV9zAsajuFSQxD2kI0h
 LtbuYDL95L//gaRAlOEW7FBoJUjy5RBnwqwo5kGQnaZQZe6KjvV4PIUSZhkZovOLxg9uoStoau
 m2jau6SBv50Ce30f30WceOSYJn+NmVT/7r7gqVNhaf2mrWhGZ6v7iyQQ5Sxig3/f9C/M9ImK7A
 AAA
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Z+LbyU88Zt4+2fXgeshE7++1CDqdcV2FKtCUj+PSCSY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm/B31iDSU0c1ETQYvsx6+foo1X8GcxygS1GTx5OUD
 8lDmO0CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvwd9QAKCRB33NvayMhJ0U5FD/
 94Nphumf1a9RbvUNWWFygwDwa5gdgK1rMm6ZvVW4hVoCxv06aGKCx4ao8xvZxsQnv9pEDmj7IpSpZ7
 AstyOUGbj4M7gt2/5PqYZ7WyhqWuS4je89M4dStNXL0LbmdrM29573MuYLPZsvf+c3mdiwiHBVuD44
 qQISSnioN8gQaG8jARbU24dRr4LShhdQ81Bj6L20HpPzp1BqTxYWG0aqKuemthNqZrYyUsNee6YR73
 ectao1Gps/vrm9B7RFr9jnhPjSUQqOrkNV0RJRTrMWNQa2f/XyzZcKJEnx7SSLf/XvPKs7uZmelizx
 8pvwRWImDvM2Pyj54BI9Hw2OoaCYJGgZVabIKGl7Vn/IQNXA9e2yudgkoYVOVEJy2rogWLizg85uvt
 p+s2F94/D6tjFk2n3Oea36P+7FrnD5DbH/DrEPXEtqOexLAdLCQEvCdpoLlRxclUYT6Y3riPpSVLHv
 6su5f/7KW+2+XC+2oU19b0GuJVFEJBx1qDonqFFKH7LDkzlq0xHEWgLiriXcx79Iic+kySkELPwJGI
 DMs+EVItqX5F1tcKGlSbJ7IcU0Kk21UOSvClkhoA8o2nZqHoUNYsZaQ4DZ50rRGgnDdKSoSR64c4mZ
 dr4YD+L1ezVLMD1mjhLtjwoQKmooG9zknu6y2g9obwPndU82ukbBRsEVPepw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

With DM_SPI_FLASH is enabled, the code uses the legacy
SPI FLASH code leading to probable errors since it doesn't
use speed and mode provided by DT.

This adds the DM functions as dummy inline functions
to add both legacy and DM support in DFU sf code avoiding
using #if/#else conditionals.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- switch to if(IS_ENABLED())
- add SPI FLASH DM functions as dummy inline functions
- Link to v1: https://lore.kernel.org/r/20240917-uboot-topic-dfu-sf-dt-v1-1-8cf38451eea4@linaro.org

---
Neil Armstrong (2):
      spi: add DM_SPI_FLASH compatibility inline functions
      dfu: sf: rely on DT for spi speed and mode

 drivers/dfu/dfu_sf.c | 16 +++++++++++++++-
 include/spi_flash.h  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
---
base-commit: 19dbc09405d3503ce3efef3c2e4b4f0f1a03372d
change-id: 20240917-uboot-topic-dfu-sf-dt-8ae62e5c7d79

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

