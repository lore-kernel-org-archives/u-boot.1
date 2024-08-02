Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8B5C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E493688C3E;
	Fri,  2 Aug 2024 21:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bMPLdGev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129E088C16; Fri,  2 Aug 2024 21:56:34 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AAFD88C2F
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso51682375e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628591; x=1723233391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jER9ZaIUYq0X1TlEnVzvaWZz7I/f+wHaLDBDEtIZNnU=;
 b=bMPLdGevmGkdhuDOYV2LOyI21khO4BHtT9J69tnkLMW4dvhFhfbf5ZeCoMxPX036KQ
 5L9pU9yL1HiChFo+bEizFai7W8oCsgzohseAkqt/e7Ks4X08bkqqxZLcBXQISg+XIXC5
 FQcMJkAMjpwb9A7QsA3IOKagw4jXjK3aaA+76S80kQVHEJhn0msymBs/bAsnfEge1gjT
 Di0f1lpJFQDmh0RjX8bUpKTC5jH1B38CzXICxcLUmmhp1CTlg3uUxv7BLUw2BtGZWU3I
 /j9fMmspzhwwJTTPIntdXB+3ojnV5OPPFsj5nCp4FnfSSR/DpQc0kXwHo9iA3pSbvOku
 iFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628591; x=1723233391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jER9ZaIUYq0X1TlEnVzvaWZz7I/f+wHaLDBDEtIZNnU=;
 b=SQR46f1Alv6YRoGEeojcoDHyV5yy3raWG1fXq9nB2tP06etqCXtlYB7atR/dL0bHRY
 pGXwrsYBxlp3xDxSiXApV3eveSe5MtHd1U1TTHzyy9oWxuKrgXXT/acPdVCpX6R7RS2H
 HwygPCc+iWlhnDnuID5quMP5gW+S3K6TGzkA89n5qDQp9g5akUh95TIE25fXNDW9jTuw
 1laf/y13P00/Vr0cqZnG4gANG5nsHqAWxXM5HVIfyHoJtkV8Y3ywYOpCu1bTJ9SAdcBp
 IwK6x7RBhtQPK5SBsDtt8/W7bPJe2PUIz05Oy+hw+3XcR9uVdVt23gjQe3SlbSTmPRdw
 4XZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ucB30CO2R3HkF34YoUyQJp7FDLnWGR1jN6zKwgEdOpKwSQ5WK9t+EI7kOFPP+i0lXV08f1+f5rFWb5Wn1eWckoe+2g==
X-Gm-Message-State: AOJu0Yz5NtpW799gZcQquM2NmJuz3YirxcUB7+8EWpT4/6hl8SDj4uSg
 wpfNWg/aN/oE3m9vP+Z+uISDHOWEJuDAwBKWAQGukDDRB/LaV5xe
X-Google-Smtp-Source: AGHT+IFFmtLNXQgjsZ+Ocm9nTI0zXq0l5OZPYALWDF6njLKxxn72DzSOJUpvPuwieRQXzv9sOCRM5g==
X-Received: by 2002:a5d:51c1:0:b0:367:89fd:1e06 with SMTP id
 ffacd0b85a97d-36bbc1312c6mr2888533f8f.36.1722628590724; 
 Fri, 02 Aug 2024 12:56:30 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 00/14] clk: mediatek: mt7981: clk migration for OF_UPSTREAM
Date: Fri,  2 Aug 2024 15:53:01 +0200
Message-ID: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Christian Marangi (14):
  clk: mediatek: mt7981: add missing clock for infra_ipcie_pipe
  clk: mediatek: mt7981: fix typo for infra_i2c0_ck
  clk: mediatek: mt7981: fix wrong mux width for pwm2 and pwm1 clock
  clk: mediatek: mt7981: fix wrong clock definition for spi2
  clk: mediatek: mt7981: add missing clock for spi1 node
  clk: mediatek: mt7981: swap wrong clock-names for spi nodes
  clk: mediatek: mt7981: fix wrong parent for TOP_FAUD clock
  clk: mediatek: mt7981: fix wrong parent list for INFRA_PWM1_SEL mux
  clk: mediatek: mt7981: implement sgmii0/1 clock
  clk: mediatek: mt7981: drop 1/1 spurious factor
  clk: mediatek: mt7981: replace infracfg ID with upstream linux
  clk: mediatek: mt7981: fix support for pwm3 clock
  clk: mediatek: mt7981: convert to unified infracfg gates + muxes
  clk: mediatek: mt7981: rename CK to CLK

 arch/arm/dts/mt7981.dtsi               | 124 ++---
 drivers/clk/mediatek/clk-mt7981.c      | 735 +++++++++++++------------
 include/dt-bindings/clock/mt7981-clk.h | 429 +++++++--------
 3 files changed, 642 insertions(+), 646 deletions(-)

-- 
2.45.2

