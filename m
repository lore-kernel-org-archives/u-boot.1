Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99415C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 23:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 421D2810BB;
	Mon, 27 Jul 2026 23:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 606MGFG1MwLd; Mon, 27 Jul 2026 23:25:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BF00810A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785194725;
	bh=OB0mRFoUQNSZzRz0xXCVTAzXRx8aKkR96M6kHzrL1Dw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zrWDzCJ4ochjAXCje9WKAuXC28LodaTJUWJg7Bj0y44xWLri/0iFZB2jJylP8Ibjg
	 TNJ9AAvj+u+L+6Zcij89tTmtlnxC2F1pTkPFzsmMtFbKUKnobab9RZ/iIH7rQw2xqw
	 z4PSyuBVFIaSrnjVDOMuzowPkn0erNoOw+bjb2wBapMqtJWBTQDfvckMrkWV/dl5uR
	 iXWVgmgVltc36zHNPM6YnzKGXF2wFSZ/5vgvFQ49defI1nyWR05qC954y/NCgZTyuD
	 /l5oov3dtHgrtwqz0z2Vfc7oH32Oe6a/c+cN3ZYyHPWt9IGEdgKKAyWMMXQ+MMCwKK
	 7cavtCOFH3RVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BF00810A8;
	Mon, 27 Jul 2026 23:25:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E7C5350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07E4D810A8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oTWVDx2Lr5HZ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 23:25:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0899F81005
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0899F81005
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0899F81005
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:22 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso1756984a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785194721; x=1785799521;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OB0mRFoUQNSZzRz0xXCVTAzXRx8aKkR96M6kHzrL1Dw=;
 b=I924vXcfZLosTgGhZO2jMAd1W+BkqhZt6trLMWLsTPvg+bR1U0pHs5Hlfg6Boxm3vH
 O8BaJtKzxGGDYhgmU/cUowFt6UVTs4wfMPJDDhEg9fD1MN0ItjIcmL+DoMykmHx//dAJ
 m31rGD18lXG7m9733+X+QoLMTVr0hmlvpvz2jLd81lbxHaQfMW/4B3nPnlAz1vswoK6O
 Fn7+trk/63oI3w30+JDI6L89m5LovbP2Vf5R2hpyOA4bKO/Sqi/22Bp3laF/TRnAKwSg
 5fAHo247NHOjef72kskFIxs6HJpV9/PbqB2tYKhhMB8kDriHU0HZWQPLzKzvILbXbMfE
 yLEw==
X-Gm-Message-State: AOJu0Yy3l5DShKKevee8TJ7SEcUkJi//yISskZbGll6F9tekhAH3N3yP
 VXpOYQEHrTJjcB6RgalLsb5tbUgKsy2oXTpaSed3eck7LIIFdQWhQ9DFT3vmHHyopNs=
X-Gm-Gg: AR+sD11O0X/d7eDAnoU8axzEtEja+l7NEB+hinceG7cAfRP7NlpQAumFmambBaYSwBJ
 ZgmQ8oQIaMAdsqwVRvXWu0p4Go+Am0U0bCmqoc/7+mh3n4+JHkJERBImhGwOTM8qli7UstYY4Wh
 8Txule1ISkHG0sXB6y0DHC6R5eIwuWUWcvQL6O8iQwsQuh82PIxb6FLAI7DFKSf0OUBk4y17Xh5
 H0VPaKa2lYn1g9HlJKoipcHjBs8WaihsaWq13uIMjcFkeDAL/m/X4ozf9azPlkgzVPXbqfH6ji4
 UJFxwNceT5LViqS3cZDEst+cCOhF5fpccVuH1xug/+QPBiOt4rl79/d6fYh2Rp3nXtVHDVUP3o5
 teSeznWX5Ky/68xqzQvqSr65o/RcFqDHY1S4FFr4FstR99au6E/Be26oI+zzoTmiMdjrB0NNbxN
 +Vdkmpxy8=
X-Received: by 2002:a05:6820:a0e:b0:6ab:d79:93f9 with SMTP id
 006d021491bc7-6ab0d799512mr6601275eaf.41.1785194721497; 
 Mon, 27 Jul 2026 16:25:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3026:75d1:db9d:8984])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766e66674sm14810638fac.3.2026.07.27.16.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 16:25:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] serial: mtk: clock rate fixes
Date: Mon, 27 Jul 2026 18:24:54 -0500
Message-Id: <20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6DMAwEv4J8xhLxIVH5SsUBErc1UEBxQJUQf
 2+A42h2dgflKKxQFztE3kRlnjKYsgD/aac3o4TMQBXZypHDc9+O+E0D+nH2A77kx4pkLVsTKDy
 MgxwvkS+R22dzs65dzz6db3Acf+sbaDt6AAAA
X-Change-ID: 20260727-serial-mtk-clock-fixes-266e61d2d917
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=598; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=gUpLy0/I0lZl6F15fnlHUio0Zx4aID1ZYRWsxbsaMLg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqZ+jMWqtCjvydFDsYERP6Kb803oupwBib0nIKV
 H+SuOlL6/6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamfozBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALc0IAKAze4Uwg1SaIlynBHzhPXo2+D4WJgrlRekXZW9
 +A1QUwHMZfDucONTp74fVob6osjhWJX0gAW6/ZB4o6Ua78FHorbCVBkMXqZMItR9iNg3NsX+lEF
 fsk7HuT7KBC3/zDebXnIkRQRlxiYWjJ64Jq7kqAeAow3buYokMDjiFS2R/3fdvGF9TDSMOIej3D
 6vlDIm87iWvbGCTRP6AH8LDfmW9Jo9fX4nAnBaRbBw7elhlFLNWHuZsvLkD+brylKi5oYuPH19M
 uYtSVUfta0kdmwVz5rjateIeNISw2HkEKCogw0Ak8w0YoRCN2YBIm7D5f7gftQZQORgylIpl9c4
 sYQo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785194721; x=1785799521;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OB0mRFoUQNSZzRz0xXCVTAzXRx8aKkR96M6kHzrL1Dw=;
 b=Z5iRSMNxV1wgIMaSJlcBPT4oAFNNSCt1WzYSrUl/VLgirOZLoVZveEInYFNQwy/h17
 NdRnUIyf/2uNZYJXgMNCIEFj216SRzVJVHAFHx4wMk0Tvy7hgY2V5RnvteheyRBWge/w
 EpYgmZ/i8spspLj0pnFxaLZ6JNpVM9lUFjAkPPqD97jjgOgMH7Ri4PGhVPNsMXJHlupX
 0pwoqrr60ByFx3Oj7AkHuVe+FRyOuAP2vasb9EpvUFWBln1JeHioqS+XzZ3xAH3Hhgsq
 fLwRH2P9qf/GQXl/l87nUJl5wyYHIkmJTVsQ0Xz0J4gsrYUQ472ToXm4swsiJ1yRLiWA
 3Ptg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z5iRSMNx
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

While working on SPL support, we noticed a few bugs in the MediaTek
serial driver related to clock rate handling. Here are the fixes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Suhrid Subramaniam (2):
      serial: mtk: use ulong for clk_rate
      serial: mtk: guard clk ops on clk.dev

 drivers/serial/serial_mtk.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)
---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260727-serial-mtk-clock-fixes-266e61d2d917

Best regards,
--  
David Lechner <dlechner@baylibre.com>

