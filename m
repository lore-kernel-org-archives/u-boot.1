Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5A4F46C7C
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27AAE83EC6;
	Mon,  6 Apr 2026 22:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="vh6ZH+7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8804783936; Mon,  6 Apr 2026 22:14:35 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E8983E36
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so1544182eaf.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506472; x=1776111272;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nm6YJIbfqwiUC3DbnBBxZ90oinYuwYQFOLqJWDTh41o=;
 b=vh6ZH+7M4Hm7RhkSvC5rKXzVA3+yRL1fQ+S0K3txlYs6JfryNBDQrh48PN5DTJoU1S
 MYAaOzC/AGP6x7gCBzAwEc1jlT6po9bN+AmpxhlBkRsrVRxMG6jiKqLyiBceFaxMM+pg
 o8CafLxxmBB6WmbiIZ0t8oIpay1IoPSpGGQvOpO9GtnvBxjqu6p0rcgSL5EcSikGvUnd
 7kTlLAkicHPwwHWGIorlSIqBRAvfIkmF1ZJ0HdBr4tuq2FLQsSiIICgD/5jfXkXQUx44
 CwxO05Bu2MaCtKZ/O1lVOHPlh/EkwvkmlFyQUA6XyzaU2hVTF8TLyfeLVv6+Cv3udRMw
 bIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506472; x=1776111272;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nm6YJIbfqwiUC3DbnBBxZ90oinYuwYQFOLqJWDTh41o=;
 b=EhN5lO9jENlAKUiKeA7FFAmkcwTqGCJWy1+0HIwkLbj6WIfA1tCB98FBJGuvyuaKCi
 IuCHKLrJfFfFTkOu67aSrSaEV5g3aPHUGx/RO/yRtLq2KB42FsmrWtm/EWx1FwpJ1zRE
 4oTAak7+p1MiAd2uOj0yAq4Om4E0B4di59ZrvFi5RipQnrsN1WUXbDGnVITHr8bychlb
 HXSZijrfjpFsk4JdQrB4x4vOtTujq9oh/bHZM+nvOsp1wo0ipNIZweDWKJKoMBL9jzAu
 Ffz2P+FKzxT5ocPaE7LQXdjznwQ19Z6WJhyS6gU3YOPsbXKeZDOzQlSHae+NYEAVWWE6
 wOUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxdSlwEtVWC8BPbqq5ZQj9ATVy9nq8xxzFdplnGHmo4Xz9ey5FlUGhRNxeRiaMKSP+D+nbCdo=@lists.denx.de
X-Gm-Message-State: AOJu0YyQpKqP7w8rGiZBa1HuWHiKhOr8PWsFff4LL5lfj1Sm7hxBictt
 rQOLWCw3dzLI++lO3z1pL37oMpUXsqiO3NcBnPcHYU9br+rg140ZMkSlvwWnXdolYNj0p3cq8//
 VWIUf
X-Gm-Gg: AeBDieuQAZgr33gIOIxaJ/7yo+QxnLOKAQm97JAD4gxUmMGwlZh6kMgQ1ivejw9jXFD
 fOIrHDuRVLQmtHj6iawgMuYFp5TJhXDzHk2/KdCSEYJv649nERnpTs0MXFq6VgrRX0BcW6zxMsH
 1kbd7jvtg+cEwvQlxZfJHmTQnkAu0WLKyNFS300TA7bL75cDjbFyghjqyFmjfbsG6PWfOZVETBo
 vgk504AJ+d/ozbnOnMHswt+T2W3VASOvEIyYJHK9xDmtnG1avNS7CWSi5vlu8F2kVEB7eS9D4F6
 XbzvmjsQtnrcRCVLbi7C6rk46SGSTThAdOcHXzX2gT/chXyasQCD3yFjAiP1pzf6Ldb+ZMNKOn7
 Jr9QgrYNFQmGSrvJCFHVRvUI45+nmYrrOd0tqQbGLr11iY9NED2Nkka1CQcJBgg9ARv1JkL8kYU
 boxXHUfUMkm1zkL5Y5yUrUoUoAkcA=
X-Received: by 2002:a05:6820:168d:b0:67f:abdd:24b9 with SMTP id
 006d021491bc7-6821fa62f93mr7730696eaf.29.1775506471913; 
 Mon, 06 Apr 2026 13:14:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/8] spi: mtk_snor: various fixes and improvements
Date: Mon, 06 Apr 2026 15:13:26 -0500
Message-Id: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CQAxFr0K6thGQGOAqhsUABauZGWgHQkK4u
 6O4fMn77++gJEwKdbKD0MrK3kXILgl0T+NGQu4jQ57m97RIb2jDG3VidF6Q7SR+JUsuKPatKcp
 qMH1VZhDnk9DA2y/9aE7WpX1RF769vyE0L/EznBq0Rgk7by2HOvHCI7uroy1AcxwftmqVUqsAA
 AA=
X-Change-ID: 20260403-mtk-spi-nor-improvements-dba489fad981
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, "Noah.Shen" <noah.shen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=GU/G27s1yu11gQFepMyV7s2oJh9gRFyCVc2MFoPuaHE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BPrZYxlkvSUHTnBytbjW8B9BfvyleJ9j+ofi
 Yd2b2nH6oSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQT6xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AH6wIAJIxWlJ1ZuXfXZ0q12HxOvI9f9kqTOeBiQ6qDFe
 jktFDLno9PBBU2Y9GMtocqW2SnqxQB/CdRAimkBHb/tozSQ3LA1ZnRvBsxfZSv33WagQRnFSAOm
 +qDkUF/nayEWuRYDTQOp7XjkhQHFE+MxVMirDgcxTew1gT5Hj9XhHnNoU/4QEbM1QMRLh0tRGha
 mEiPoe3/zyuW+aVaf9AY7M9DxrenDipvyhgUXVOtSaupkAJFDcwuS8kwMjpB+GVXkGgRXuuVNAG
 QEFlnF9bsaC6dJxh3QDCUmTrirY+UmBloOt+JXcp6OI9p8z/Q9Qytu8lYe7euVwbSHhqg9dte5L
 k1kY=
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

This series contains some downstream patches that I have split up into
logical commits. I have tested these patches on Genio 720 EVK by reading
and writing the environment from the flash memory on the EVK.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Macpaul Lin (1):
      spi: mtk_snor: fix zeroed data in DMA read bounce path

Meiker Gao (1):
      spi: mtk_snor: Remove status register write procedure in probe()

Noah.Shen (6):
      spi: mtk_snor: clean up comments
      spi: mtk_snor: avoid alloc in mtk_snor_cmd_program()
      spi: mtk_snor: conditionally copy tx/rx data
      spi: mtk_snor: check return value of mtk_snor_cmd_exec()
      spi: mtk-snor: add bounds checking in mtk_snor_cmd_program()
      spi: mtk_snor: support newer SOCs

 drivers/spi/mtk_snor.c | 196 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 129 insertions(+), 67 deletions(-)
---
base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
change-id: 20260403-mtk-spi-nor-improvements-dba489fad981

Best regards,
--  
David Lechner <dlechner@baylibre.com>

