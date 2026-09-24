Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43904C98318
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 16:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09B9F60805;
	Thu, 24 Sep 2026 16:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I-NSjAu_k7vY; Thu, 24 Sep 2026 16:13:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 496926077A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790266383;
	b=UA8g2d6QoIMT5JXmHerB2hMgTPcRiToOPkCN4pV33ugMR0zXTZdY8z9T/FyCUh4+/KFK
	 enHwBzeBEVY86ncvBzxOCPk+iZa4dwfdRaHyYxUFlNnEuUYTwmPi41KL//fnnoCK4tmK3
	 yncN9C1zOAPOhax/Kn+0ufOyDLesufp2NCE67zdWVVlUZYnEO3YPAFi+DuH0CyLzVokUH
	 1X7WP1sKV2Y8VHWU9Q87IdAWkXYdv5afwbB1ONWPwQMafNv+6Cs7g8pq8b8aGRDJ2C89U
	 i+V3Wv/WsUcEbyg5CLqhjzlJqJQpd6lDtJZwLPB+qzUsvVpzIwZG2WKT5n9OW5wX/Hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790266383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ljqilNTB5IUQ1SliPsRsSr/M4owRSCjBgu5fIUQ77g8=;
	b=kMjGd6i2D0cpXrmOfzLwdLs1aHouEE1hjjiJC8eZRVFjQoM6a2KP/YCvBudpM3xT2VtS
	 /tU7X9BogZhZRoZGRoBhpf0e2N2tucoCzgVRAEMdJMv5zxX7kefwuKPTfekhVDKQ0izTO
	 kxMHGtA9Gy0dFdoucX28RGft6iKRnYl3c9rtFCgsKWipV6a9CDPsvI01cAAvmLD8PyTdX
	 raRe2+rTR0dyyjmz+ONckk5hpQAFIqXVKjC5eZDQnXBSoc/1VwV1mmlNFThxJNtKmy/ZM
	 cHP52vUkIUb6SgyJ//1aSwuxTXeLIqr2cgvn6pexYLyiWHAsBQBvDr69a3LUBzLGIVA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790266383;
	bh=ljqilNTB5IUQ1SliPsRsSr/M4owRSCjBgu5fIUQ77g8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T1IaBVR2ClXDM5e6DasyAwW3pAhP2hBnq93OMnkiIvnNU95W+Rz7tvGxygT/oppSU
	 ERN/NotZJ5ne0Ihm9DdxtVbnALaoaTFy3jHipRYyi+ATn48oqbtvrijdoosIiMjx5D
	 n8iAjuIj2o+PCFw22aHVZVe8GZFLpvJ3zWPq9r1Or+7gfW08kuDfDck13G8XKsllc4
	 c4I3BxIZTBlCZmWz3wyHyWkZNQFKk5lLpo93Ee4GqMCRcKQ3TpaTP5ZmiJBLCm8j1h
	 43AR7p0apY+qGwaubp1MVaLCBCoBqYuvFnLz1IySw9gbkUGLigIhGm3urPpQRFJt8Z
	 QV6b9T+TpXQkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 496926077A;
	Thu, 24 Sep 2026 16:13:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BBCB3B7
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51C7B407FA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bj6cqEUgJUnL for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 16:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5A83B40765
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790266379;
 b=eglfRkeiT1n876p5pSdi+XWt4ERinbjDhcE9d5ZJNhn5oRQMh59R1Qqem8FZ1GH8D4l1
 5jLjcCl/e3ZmI3JfA7TOTFQZ2SnjGUJtWP76I7NWMteqYAH3Ab9ApxL5hS9QD3azIB44t
 7gkPu0eb4zZaxObtz9h+BDBmtQ/zY8LUKGh5a/1EGwRaiSogdx+kBaYNaCxgbw1Xss9gq
 fLFll+lOgfPgfxpbhaKFEDFbOgsBaE06wQBSUik97KDrABFbkwLVUGFDkR8BTk85k+36E
 g2FHBfw9z/p6mZZF6kHPrMZWSZUlNliWba8BxT9xKbYtVXj8PiHcAEi45yYu22mB+ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790266379;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=ljqilNTB5IUQ1SliPsRsSr/M4owRSCjBgu5fIUQ77g8=;
 b=WzMAGB6gxEaYQiXk8w2Hlx/6qc934Hfse+ljJmv95mfMrai5umoI3xJQ9A7uJcSk8qaZ
 xfbTJ4coVtLbMIWlyMh3WObVE8mjDLc0FKHdXs+3nOaoJIOozBqf3kV9Owrs7JuWiKNvl
 IqQf4afEH4UCfQ9/ADiehYGrcHOKPZ8US4cLqKjyciifycCNChTybVD4Rv0SiSx733Oz1
 K6ifwAbkl1eUT7wHSPDiV2phvKr6TiLzn6zqXyVNwn8Frul2zrVTpEzUemLog4JlTlh/N
 9l9n5H65aPsRZVGeOEmHB9SvhibYS9KiDtGSTXXbMYC98wI40CdWcPQvyDdfz6AJGwA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=collabora.com; 
 dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256
 header.s=mail header.b=PiUXzdAb; 
 arc=none smtp.remote-ip=148.251.105.195
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.251.105.195;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=PiUXzdAb
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A83B40765
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790265771;
 bh=dz/kHpmUCh7Ffwr7aYgz+KghcMqJoSaSl8w59c4jmYE=;
 h=From:Subject:Date:To:Cc:From;
 b=PiUXzdAbo9GPjMKyJms0v30CCgEExMaEM+MuIMe1An6xPdOXodM08dLfp023GdM50
 gGusJ2rH1szyANDjucodxE0WKh+L7GxRN9H+5CQn4Gw2sdWiHIuUN2jSbU97/reZNN
 u8TynUIE5JhyGafE/ArkwFlyqhQHIL7KcfWaAp2gZDc3912+r959thXmJPnK46mLZ0
 rTfqYLPo3QeRZt+a5ILOI72aJLxR7UPklZ+V5ceroNpa577WrOEWWYcf5DsV/RSl5d
 ne6UcyeJ+21VL/XGQz9Z1vyOpfZ0wA5GWqNY8WrV/ixN1+tm9hI3C/d6F1x7CwlINC
 eKLVEhvDx5sHA==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 49F4817E020C;
 Thu, 24 Sep 2026 18:02:50 +0200 (CEST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 0/3] drivers: add support for MediaTek MT6373 PMIC over
 SPMI
Date: Thu, 24 Sep 2026 18:02:48 +0200
Message-Id: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqAIBBA0V+JWSeogT1+JVqYTjVBD5yKIPr3r
 JZnce8FjIGQoUouCHgQ0zJHqDQBN9i5R0E+GrTURpY6E9NWqNIIXicSxlmdozcqUxZisQbs6Px
 udfOb93ZEt70LuO8HPaEAKG8AAAA=
X-Change-ID: 20260923-mt8196-spmi-6ca27ed6131a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Guodong Xu <guodong@riscstar.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=dz/kHpmUCh7Ffwr7aYgz+KghcMqJoSaSl8w59c4jmYE=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBqtUmp5LMOU3dMhpD8UFEY/wEh8UVSCcXNTjGdq
 iFkOJNVtfKJAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCarVJqQAKCRDT67WWa7mR
 lg8SEACwzqicHVAYvuYHtfLeUIGTQdwune83XbKpvEJX5tGjX0sBK6XEpVWEl7+RReL1tpqmPO3
 8o0JebJ2kCOa18/EcEOtR7CjCBwjAsiXN28WRZzT8KV8w2rKBPoZmZWRSRZAl3ucP+MPu5m/KKe
 gwi5E9mgAEPAfx3u7dsf7RXtWxxcJwW7ZhsV5Yot35z7YBs24YKyBKEwzzYgBkGSHduW/4p9Wt8
 xB+eV6onhJ3alQ43wNf0UQ61Eb5+2+sSI5x5eLhNkcKjyqd3A0ggtfsoXtfzQwJNmU7eJU7N2ey
 U3yqyApWfVro12/oSEmUqFm1N3Kr4TSW32f1KdjjD9GZDDY/320ql045YxgJN1bHy81Eah5N2kC
 gpSW7zADuM1WGKox2LgOB0YBOCH7foCMJsAW18SHe8KFHSTyM2PwG2wtP2++OE8x18YRQXgib3P
 k5WbocX83xcBu3gFs+5Dbn97CrcHfk7Fd9ykponvWfgjnuNNozHRsmAZn8+Q2B2uvae7JE5Keym
 s9XCMm1uVR5AM7WJc7dUbcrzvA9QAntlFWO4znA4Frbvr32Fklw7hM/Hcpb1PtmocenUi/wPOTj
 z75MTIZeyDPHIohUhHXvoxBzzIlkq3U478ew2GSOE/7vN4oMvuNbUH+FqzF2mfyxbdDZ+7vaypg
 S9jfODYo+ENT+4g==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
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

This series adds the drivers required to use the MT6373 PMIC used on the
Genio Pro 5100 EVK, based on the MT8894 SoC (derived from MT8196).

Unlike other Genio boards (which go through the PMIC Wrapper block),
the PMICs used on Genio Pro directly through SPMI. This requires drivers
to be added for the SPMI controller found in MT8196 (and MT8195 as
they're nearly identical). As we don't need the full SPMI functionality,
this implementation is limited to 8-bits wide I/O, matching the
capabilities of the SPMI DM.

A simple PMIC glue driver is also included, tested with MT6373 but
normally compatible with other PMICs.

Finally, this series adds a driver for the regulators found in the
MT6373 PMIC.

Those drivers are all based on the corresponding Linux drivers and have
been tested on Genio Pro 5100 EVK.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
Arnaud Ferraris (3):
      drivers: spmi: add new driver for MediaTek's SPMI PMIF
      drivers: power: pmic: add driver for MediaTek PMICs over SPMI
      drivers: power: regulator: add driver for the regulators of MT6373

 drivers/power/pmic/Kconfig                 |   6 +
 drivers/power/pmic/Makefile                |   1 +
 drivers/power/pmic/mtk-spmi.c              |  88 ++++
 drivers/power/regulator/Kconfig            |   9 +
 drivers/power/regulator/Makefile           |   1 +
 drivers/power/regulator/mt6373_regulator.c | 797 +++++++++++++++++++++++++++++
 drivers/spmi/Kconfig                       |   7 +
 drivers/spmi/Makefile                      |   1 +
 drivers/spmi/spmi-mtk-pmif.c               | 462 +++++++++++++++++
 9 files changed, 1372 insertions(+)
---
base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
change-id: 20260923-mt8196-spmi-6ca27ed6131a

Best regards,
--  
Arnaud Ferraris <arnaud.ferraris@collabora.com>

