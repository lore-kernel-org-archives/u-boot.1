Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235BBE7315E
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8922683EC0;
	Mon,  2 Feb 2026 13:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rr6i9Dtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186C983EB3; Mon,  2 Feb 2026 13:42:05 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC86783DFF
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so37306255e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770036117; x=1770640917;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/LjwqZve1m8CtNGqUjjH+ApHz1qcLVt0scR5Bj081F0=;
 b=rr6i9Dtq+6O/uNn+/SdrTKvMwYJ8Ey766hbedKOevwIYnaEJSpSp6NGmEce6bhuzqi
 868Usb8hI5y8nu6Yf9m8288Zm+B0Zx0IWE9lJj5lnleggVgWJ9I3b8q20186bIeWY1F7
 e23VfcGa9oujusTGqu9UARmnId1cwlxqdZjef91hOT9yyemQvZupQeLq91M1u+ieCLcD
 l1pq8Wik7OUnHPoMWpB2Tbrn1RRtpHlXWnp72kv5aj+zlp8h7SvwUo9JnyuXRaXY11C3
 QGUND0EQzSi69wG3BvLP/UlB1KpPJaa4zBxKSZO4LpudyTiNMQgpXkdyrpBMPz3uPgIj
 UAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036117; x=1770640917;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LjwqZve1m8CtNGqUjjH+ApHz1qcLVt0scR5Bj081F0=;
 b=DVMUWFMYvlEWppjY+FPcn5hbOguJUEK6dPRP9Kgmj9Kij/WNkSt3cuH6RP6x4dREKT
 jwLZaNThhx6emAYsvqe73FEd1NeQb0ToTGUB2GedDciGad5cWS+FjvtYXDABZi/xp1kc
 k8q/DXDOxVqZRlC769w+FbWpVNKeobA8ShjD1pFBOUN6KytCyio834bfj8bPxO1FcPOQ
 1Id6VJAo6Y2s3DlhAdzrCnGGa4OtLyK+uhW6JAGXAMSqZOA0B4ddD8cdlFzxpPkhXQoU
 W4YYxLOoqz/FuMaSLo2qJooXSgx+yRVoco8t+6JbJdfisO6WJ0/POhIa/Rs/WfzcGDpT
 7Msw==
X-Gm-Message-State: AOJu0YxWbBDvw6PKWpV53txtQ2Qwk/X/BPoLkttAcs2Uk+P3OrGH8P9F
 9YgpsYmVPQQ8v0F2OD//rJ1aE5aSr+cllnSBqSj+gs70fjmSI9+fNyNAXhXt57XuRVE=
X-Gm-Gg: AZuq6aJPVuM0jdd0kQEqkGwRaQ435U0WNEP2Nq5S/RegVB12p1/20YNkMwJ9iAxH11h
 kA82uCpFC2bgLlnF7wC5uBcO7UjE3yXFTpOSPYJBmAqEsTG1wnB1ucbfk5Glknu61Khn2FfaH1o
 XoWC9jG9CoPAnDOeXYWlFYiLljXPek1as8ZWKMCanOKKWAK1TtbJkfZMDCFt5Nqj5OXdMdGmJ8C
 5CBAeFsC5/lczmLlf29CVtVp22txPn4VjRq8TT5mxPNbqIgMP/n/F5ngHkVWS9ti4DMCoyZWs6V
 4LCnSD5zKBtec6IhkJfiNX/RQVoMQSBEWPg98OzLzcjN1Y/6SnwXNx4z8cx6HvoSi/zjkza4XMl
 pOifNuXL2gXrSb9gN8cOe2ZrECp62XTxXkTOSX6CGyF1QpBiZCSBLrbd1HgLTQQ/XnrteQI1Zy+
 kPjLSEfG04MtuGz1gPs0lEHDVgK/b0wwmoBeTL/ETXcgC9Hf9XUTehB+lvu+GNL2lu1XGfcx9sc
 CwQED9eIQ==
X-Received: by 2002:a05:6000:4308:b0:435:9f1b:8d19 with SMTP id
 ffacd0b85a97d-435f3aaa819mr17592139f8f.38.1770036116909; 
 Mon, 02 Feb 2026 04:41:56 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm43593588f8f.18.2026.02.02.04.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:41:56 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/5] clk: mediatek: mt8188: fix clocks
Date: Mon, 02 Feb 2026 13:41:48 +0100
Message-Id: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNzQ6CMBCEX4Xs2TX9sYicfA/DgdatbARqWkIkh
 He3Em8ev5nMNyskikwJ6mKFSDMnDmMGdSjAde34IOR7ZlBClULKEoepklWFnt/o+uCeeG618HQ
 h7ZyAPHtFyuWuvDWZO05TiMv+MMtv+pMp/S+bJQokbYw2yvqTMFfbLj3bSEcXBmi2bfsAUoqWu
 7MAAAA=
X-Change-ID: 20260116-mt8188-fix-clock-7a30fe9e3cc0
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

I recently submitted the clock driver for MT8188. I naively submitted a driver that was ported
from the kernel driver, and mostly work to boot a kernel.

Recently David Lechner, added support for the clk dump command for
Mediatek clock drivers, so I used it to check the MT8188 and found
several issues fixed on this series:

- removed topckgen_cg, gates are now part of topckgen
- fixed several parents clocks
- added missing fixed clocks

While at it, I also refactored a bit the driver to improve readability,
and future additions to it.

Cheers
Julien

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Add the CLK_TOP_FULL_NR_CLK macro and fix initialization of mt8188_id_top_offs_map
- Rebased on master
- Link to v1: https://lore.kernel.org/r/20260123-mt8188-fix-clock-v1-0-e355352bf405@baylibre.com

---
Julien Stephan (5):
      clk: mediatek: mt8188: remove separate topckgen-cg driver
      clk: mediatek: mt8188: fix circular clock dependency
      clk: mediatek: mt8188: add missing fixed clock
      clk: mediatek: mt8188: fix some clock parents
      clk: mediatek: mt8188: refactor driver to improve readability

 drivers/clk/mediatek/clk-mt8188.c | 631 ++++++++++++++++++--------------------
 1 file changed, 295 insertions(+), 336 deletions(-)
---
base-commit: cbc75552aec49fa190f3ac1ad8e198ac3a2e4ef2
change-id: 20260116-mt8188-fix-clock-7a30fe9e3cc0

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

