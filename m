Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF11C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2E088BFF;
	Sat,  3 Aug 2024 10:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XWr9rxUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F385588795; Sat,  3 Aug 2024 10:33:21 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7879F88792
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so60069585e9.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722673999; x=1723278799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gpdWCJVDeRvtf+MYIt4GeQZ+0BJVXMBXMXFIDSJ/i6Q=;
 b=XWr9rxUifG7NPcp+rA8/2li2DHQ5qJOEiB8yGCg2Dy7VNWsFeWJyvjS6OpB/oEMndM
 8sJFFasiuzkld4XOjUVBp+SO8wYQVrREI/StlDJtv1CaRFuXyix4kPgSu57K6tAsNmYy
 k5NoP6DHoOZXKGNBzuTtMWQhxf8hgKk1YEVF+DPnGv0ArT0ffsosmzXcR/n7S5PNUSpy
 wGYHA0imA75KHhClbmx/nBirZxYj4LooyTPtWOVE7bXsOlrnQ1+VCLRasfyIlxxuebkF
 4DPDaA81H1IY2P0uN9kErjNbzDiDN4AuVWdH8cQtI0FTR9Ub7UcstjsmmSjEfES8+Cus
 VTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722673999; x=1723278799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gpdWCJVDeRvtf+MYIt4GeQZ+0BJVXMBXMXFIDSJ/i6Q=;
 b=L9fZK4mmvIw6WusOWCeNp6D9uRquj3YaFEd6PfR3Fze2lT5XUrkh62F/4PNOyEk9HY
 B3YrTcZJOfLyDw77nrD7zXLsrvwHuwHoIMgzcva5/2rLBA7h2/NnWjHNgWdUe2msmu0Q
 uJUogLZOnl+Db3VVYDpj+q2bkiIEG9xqdTqE+Z8gDCIRCwd9MqtX8FAs/oQ8f5psTXYj
 Yzbf9QUwYo+dZFnqLdR7oa4m1sYcLtTq4aVDZt1a/az3kIJVme9o+AclGEnvaemztOLx
 N6lfj96SstQW4U3s4NbAnG9CN3hBlnb6za3u3V0YO48xbFWOXlGlOOTfSe1km+uU3EdD
 IdHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZzqj6ba+gV9V4sBY1FuZon/Y9ir2fFuN1yFhNJa6doAbV+2k/is6rsZDVguasK+EgRmNgHLmTAk6T85yRy0P8g2RZZQ==
X-Gm-Message-State: AOJu0YyKz0JnROtbdUUHpQ9ZC9nFjSrijF26qimFSVmwZLWCRFo8yu7f
 NkPjZ6LAjeF7Q3nT/VQ/FliVZFUUWksk7w2Nr7WCPp6ZgQbw1JGT
X-Google-Smtp-Source: AGHT+IF1SCImeSN0KmFwaR8s3Ew9cvpTk4skMtrjbyKulcKo/pG8wuQYOobHqD/PonDufzhWYXn50w==
X-Received: by 2002:a05:600c:548d:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-428ec2a8da9mr25934305e9.10.1722673998623; 
 Sat, 03 Aug 2024 01:33:18 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 00/13] clk: mediatek: mt7988: clk migration for OF_UPSTREAM
Date: Sat,  3 Aug 2024 10:32:49 +0200
Message-ID: <20240803083305.30697-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These are all the required patches to migrate clk and correctly support
OF_UPSTREAM. This will align the clk index to upstream to support the same
clk implementation with downstream and upstream DTS.

Christian Marangi (13):
  clk: mediatek: mt7988: rename CB_CKSQ_40M to TOP_XTAL
  clk: mediatek: mt7988: rename TOP_DA_SELM_XTAL_SEL to TOP_DA_SEL
  clk: mediatek: mt7988: rename TOP_CK_NPU_SEL_CM_TOPS_SEL to
    TOP_NPU_SEL
  clk: mediatek: mt7988: move INFRA_PCIE_PERI_26M_CK_Px clock at top
  clk: mediatek: mt7988: fix wrong parent for INFRA_PCIE_PERI_26M_CK_P2
  clk: mediatek: mt7988: drop 1/1 infracfg spurious factor
  clk: mediatek: mt7988: rename TOPCKGEN factor clock to upstream naming
  clk: mediatek: mt7988: reorder TOPCKGEN factor ID
  clk: mediatek: mt7988: drop 1/1 spurious factor for topckgen
  clk: mediatek: mt7988: comment out infracfg clk not defined
  clk: mediatek: mt7988: replace clock ID with upstream linux
  clk: mediatek: mt7988: convert to unified infracfg gates + muxes
  clk: mediatek: mt7988: rename CK to CLK

 arch/arm/dts/mt7988.dtsi               |   93 +-
 drivers/clk/mediatek/clk-mt7988.c      | 1085 +++++++++++-------------
 include/dt-bindings/clock/mt7988-clk.h |  545 +++++-------
 3 files changed, 787 insertions(+), 936 deletions(-)

-- 
2.45.2

