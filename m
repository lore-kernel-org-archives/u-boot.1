Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F118C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E507E884A7;
	Fri, 28 Jun 2024 19:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLZc/Z9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49042885A0; Fri, 28 Jun 2024 19:41:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57055881EC
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-424f2b73629so8582785e9.2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596495; x=1720201295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O46Cca/sScXUpNrFHUSBEh9kbAC2oFIM0L7a/d0atWc=;
 b=DLZc/Z9Ca6Mzen9wX1LSMbjs+pqwTwnpGtPSghmiWE3LRl7xla2d1DZXnKsjFu1iwc
 D3vay3K5GCU5zAscZdIiOnwoQPBKpxhzjLRbXlzcRnRqs0ZV8AVeNxLNVo0NFOVo98Cg
 a9mvM6fuWRkR4UuDSJipBQ39ZCNd6TuULu/KjPW6QrSdaPHr0T2US6RdRgaYhXtMD1Aj
 4HDrn3jfYzI8X8+5ezkXSOMSCF9DcFrcaa08bNyOHo3r4pHgANrb9zmyFQhMAD6B/lDp
 6clGWyxrtq0iiKJ8aFuv1UDyKhfQCAQ8I41zIEbG1XgOAA4uVgkvMCVPqWIfQPfoyGDg
 vWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596495; x=1720201295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O46Cca/sScXUpNrFHUSBEh9kbAC2oFIM0L7a/d0atWc=;
 b=bL5lPQ2YT/Db/Gp6o7uvlomgdaC+LeZLWVRRPu0Xx9g0tM9QrHFsbjFoJZLYtn/7jz
 3L9v/oaVy0NyvNIRSNp4yknzwrmoHib92ozmQMckg10Enfdcy8Rc9HIkLjym2fByStpM
 Jvqt7B8J2jHKxsIKSKH7T93NNZseSqPzqBkokeWyIW/vf66KHq+YfXiyk6mOqpoOS+mL
 O3U+ByVhEgQgHd6WvE68HFtm7dMYm1F/awtt/8ooRV2iJSPg1RseLTBEgLnuF3EidQ7c
 poc+c4UCWvW/kyRRx3gNu4mHYw7TOarI7hZpGX/fB6sd2Jgidn5Ce3HbIbDtnVNvI3zm
 nN0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNK0kjNb+h2dVD5QlzB+1ngrGwaoztlDo5UdkpntmZTTvZk5TNEvQOkhhaz8HIYX1NDoP8G+2K7mg2h0rdcoowLySOSA==
X-Gm-Message-State: AOJu0YzO6JWXb+BoxYdwGlqlO77F3x9N5Wl0Q10otPAAE1V1i3IV2Dn7
 8d+RfI/9W0a5vB3PzAIR20kB2zDeM9ugt+VjQlWuo3/jqqO5sbsK
X-Google-Smtp-Source: AGHT+IFObFMBhDIhyDfERS5Jht0aQNY/8KnOlxJH7FQe/KSIEEK/iREBTqPUNOPOvwDuFaIXMUFRTw==
X-Received: by 2002:a05:600c:43d4:b0:424:a4a2:9478 with SMTP id
 5b1f17b1804b1-424a4a294cemr95245705e9.25.1719596494443; 
 Fri, 28 Jun 2024 10:41:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 00/12] clk: mediatek: add OPs to support OF_UPSTREAM
Date: Fri, 28 Jun 2024 19:40:45 +0200
Message-ID: <20240628174114.8675-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
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

This series doesn't currently change anything and it does add all the
additional OPs to make support of OF_UPSTREAM.

While converting the mt7681/7686/7688/7623/7622 it was notice lots of
discrepancy between the downstream dtsi and the upstream one and the
clock ID between downstream clock ID and upstream clock ID.

Upstream reference clock by names and clock are handled by the
CCF (Common Clock Framework). The same can't be used here as we would
quickly reach the max space allocated before relocation.

The current mediatek clock driver reference all the parents and clocks
with offset from the clk ID related to the different tables.

Discrepancy between clock ID and the order in the clocks table cause
one clock referenced for another or even crash for trying to access
a clock at an offset that doesn't exist.

To handle this and permit use of OF_UPSTREAM, various measure and
changes are done to the mediatek clock driver to support it.

This series have all the generic clock changes. Once this is merged,
series for each SoC will came that will just change files in their
dedicated clock driver. This is to prevent massive patch and to
permit to split series, one for each SoC.

As said at the start, these changes doesn't cause regression and are
just expansion to the current API. Current behaviour is saved in every
possible way (aside from the first 2 patch that fixes latent bugs)

World compile tested in Azure Pipeline test

Christian Marangi (12):
  clk: mediatek: return XTAL rate directly for gates with XTAL parent
  clk: mediatek: return XTAL rate for infrasys get_mux_rate
  clk: mediatek: add support for gates in clk_tree for infrasys
  clk: mediatek: add support for gate ID at offset
  clk: mediatek: add support for parent mux from different source
  clk: mediatek: add support for parent mux from different source for
    topckgen
  clk: mediatek: add support for gate clock to reference topckgen clock
  clk: mediatek: provide common clk init function for infrasys
  clk: mediatek: add support for remapping clock ID
  clk: mediatek: implement MUX_FLAGS and MUX_MIXED_FLAGS macro
  clk: mediatek: add support for GATEs for APMIXED OPs
  clk: mediatek: add support for APMIXED parent in infra MUX

 drivers/clk/mediatek/clk-mtk.c | 433 ++++++++++++++++++++++++---------
 drivers/clk/mediatek/clk-mtk.h |  74 +++++-
 2 files changed, 392 insertions(+), 115 deletions(-)

-- 
2.45.1

