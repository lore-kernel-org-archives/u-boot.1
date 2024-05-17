Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453FCC25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6038856F;
	Fri, 17 May 2024 20:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Qu7Upn4P";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="MP+XviFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E173A88563; Fri, 17 May 2024 20:15:13 +0200 (CEST)
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com
 [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFB988578
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id 0E6CB13814F5;
 Fri, 17 May 2024 14:15:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 14:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969711;
 x=1716056111; bh=5ZULVxPEZagq2ZnSNGWIOYhd4uhOIL+SqRKibJ4Sqyo=; b=
 Qu7Upn4PPHnG1D1YUQv6eMgvjIh/AO2OFqqwDbxYdXGBlnynaBfnM/onymADkirU
 dH6LAONs9xrwerWUJclAo+NCruhgB7iQSQWZ6vP87prLevfrmtS3MLxAjww6sDpk
 u/NlgryOi6Jybg6IeGGlK+C+QqKhMXFMr2G28IrevBAfmyTXUmoOUjvKuqEHAjSi
 3zYA+kcf1qPwKmgINDS0iedQOt8smaiJOzWnbhxEgQeOWKK+OC3GfwMWD3uGL+Oh
 SNOn9w8Zuju9eLWHoMsdSlcbwvNyBtVJD49UWyZxQUR8KujvdfKMJM7PJnoMriTN
 IaT3bN/F82lEdB8FnPorwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969711; x=
 1716056111; bh=5ZULVxPEZagq2ZnSNGWIOYhd4uhOIL+SqRKibJ4Sqyo=; b=M
 P+XviFEcs+4JOTDeE5ch9Pu5sjAGdvLTcH6sscC3FMNnVI706VaSKwcMlGFoiklI
 am7FkyjlRVy+Yk4sInHHrP4L1tpMh0C1lETaNSt6L114+qxmZSJuNnpo3wMw7gxy
 CikC0e/QNnxmRT/y6EIqlIC/ZACyZ9lz8GuLfzf9QgRd+g3PCibEatAnmXtzDe2g
 abXOlxw4pFheLJhbGVE3emSTOjL6GwCm7eyjtXB0ffes3TMgondkQCTBqe5O82uK
 +8tdRCH4qyd26JrFeVMTYEtBIYb4BTq0RR34uM/i29RBL9KVq9XiAr2HD4AiKWtU
 YIex0Pd2Oehtc77eVdn7w==
X-ME-Sender: <xms:rp5HZjI4m3m-dHYBE2iHS7W8DF25QiHecZbAByrgvRafqjKcO0FgpA>
 <xme:rp5HZnL1oa0aLcZSDwXkbRlQRJFazT9FmdivZQ2bPLkVG-IT84dto5n2bpH26ndZE
 TNGTRQQVoFUqo_RAMk>
X-ME-Received: <xmr:rp5HZrtF8ojfAyZ84QF-3LPKG42D79OeO0Y_WMWd_vZOX_Ckz6ajfcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:rp5HZsYeFbGEOp5bRNansdCXbMsxtVwvqmdVSh32hgsQ1OmvJWj81w>
 <xmx:rp5HZqbCb65Bay1QBt9ySdvYi6mjdPsq_qgVBuc_C7HHrLVUIxUxww>
 <xmx:rp5HZgChZZRDcLt6hs0sjvziZeBhKU31xH1WlO3Ia2_hcC2ahaF8Tw>
 <xmx:rp5HZoYeiVzLPz0wpXCHP1QrNScMUY_10ZqGr-7j7mLrMSp9Vw5lFg>
 <xmx:r55HZsDzpau8RdhgpBTQtkwjPqe4YzeN1W5nMZF3VxXDZiH3K5trbH7H>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:15:09 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:58 +0100
Subject: [PATCH v3 10/12] dts/upstream: Add Makefile for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-10-1ea7d23f4a1d@flygoat.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
In-Reply-To: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=749;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=aGEutvGebadnVo5ZyrZMCSxsH5tJeb6Tq/GIekBoQGA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebNPxj348snewun369hVk5ZsFbkm8n3ug9sbZ85P5
 Wi02vdWqqOUhUGMg0FWTJElRECpb0PjxQXXH2T9gZnDygQyhIGLUwAmktLIyLB/k/LVqJ0CYdNv
 pk5acNAz6/ziDO21hvk2nnEPXzgEBb9kZDjXefb5fKnD7S2sXUn1a4us80M53yUd6wpednnGLdP
 ZnawA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

It is required to make OF_UPSTREAM work.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 dts/upstream/src/mips/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dts/upstream/src/mips/Makefile b/dts/upstream/src/mips/Makefile
new file mode 100644
index 000000000000..9a8f6aa35846
--- /dev/null
+++ b/dts/upstream/src/mips/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -a 0x8
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := */*.dtb */*.dtbo

-- 
2.34.1

