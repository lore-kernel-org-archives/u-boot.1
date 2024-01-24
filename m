Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7921C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 03:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5596F87BD4;
	Wed, 24 Jan 2024 04:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="q4a2Uuuc";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDbMgpXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFCC87BC7; Wed, 24 Jan 2024 04:26:42 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8839C870B5
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 04:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 7B3A43200AD2;
 Tue, 23 Jan 2024 22:26:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 23 Jan 2024 22:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1706066798; x=
 1706153198; bh=mTKS3pwr3m6bdF2VEvA98HYS8sfYbC6amepNJ6NMOBk=; b=q
 4a2Uuuc42LwSjxzxT2lvcl2/ULhyRJPTXc/OiJki7kCnQHv3qzL22j+eIa3+0tCx
 YUVxODy6KdCqZe2K9st6YtFDVR0pELo0iu7+R2zpHW6p0vVhRRtAn7rQbAGERguF
 B2q/K665JeR41xfHLGIiImahHGvlwYumePRN8jHHuGavDq6HQ54GTcy5Fxyucoqx
 BLZ+O6yEbxAJ+xTJfDtuTJhNnPs6oUng2GswFrukiPjkeVvaFb+Y8pWu9q8z2tvI
 3cFgghtekD9iVt7F9W2CaFFB6LT5yQxWZv3fiKHz3TVwGvaKo7fMi97AVT90rT8c
 IC6mBeEoZvKACSB7RowDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706066798; x=
 1706153198; bh=mTKS3pwr3m6bdF2VEvA98HYS8sfYbC6amepNJ6NMOBk=; b=Z
 DbMgpXJ6bjp4q6Dnj3EgVuUhgynFO0WU9TkFPzLb+yG4K4I0HvlRA3kXQYFYhcC0
 JSgEMoPFsxjok6HxLrN7fUZrZ8Gp0LEtudQBJecWIx28cm4k/4T9uxydulSTWgyf
 DOhWybj+0K1BMB3eRxnQs2dzvZAPTvNjjqp/tdFmNAUN0HKdzHjSXrKn4HgnA6gf
 dogjITbuY8s1brsJPgNA32MMdka/SC6o2mLO/D2fgS+3anCnYjn22fTdBZeOZ3jY
 XE4XxySG7H3K7l9puU+SXhjG3cZ/PbTkDzyXqElySOGEsTxR0daJ3F3e4BY8/hyq
 0bxwbCl6czH8/lj4yZCMg==
X-ME-Sender: <xms:bYOwZXsxv303zh86tKeWBeZ9Ts-kIYp_CJ9ebaXY8r-PDqLqM55drg>
 <xme:bYOwZYevNuDtsfkrwDNbDNx1f68xpyK_mtL4H3lzeb6BETHWQ650b1RraC2VmFQPd
 JrRAYVX1w>
X-ME-Received: <xmr:bYOwZaxe0HLVDR5oQe1_8iQ8vwKsjhBTPgb5hjXwLdPWAvlMcgyz3dabzLMUHLiYPFZxVDNqaTb1z9AOCgCsxbUKs1kPizqzF1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgvdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeeutdefieehkeffgeefieelgfdtffelhedvieelfeekffejueeuveegjedtleejgfen
 ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhimhesfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:bYOwZWNDOssThTJxK99SfKUYnK3V6uZxX_PgeaDU2mQSMG89oX9G5Q>
 <xmx:bYOwZX9n4RUPAOnz_4JPjplVXzViRrUaG_elgp8TuX9Wj7pGi1vS3g>
 <xmx:bYOwZWXH79-k0pkyG-CQRA6RAk3yCWu58nCDLR8CimCJwg1KqoEpCw>
 <xmx:boOwZTZOcHSzmG77Z2hFKi8Ma4ZfJ16aYlUA89-Q1aUUddTz425A1w>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 22:26:34 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Wed, 24 Jan 2024 14:26:32 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/6] rockchip: Convert rv1126 to standard boot
Date: Wed, 24 Jan 2024 14:25:59 +1100
Message-Id: <20240124032602.126059-4-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124032602.126059-1-tim@feathertop.org>
References: <20240124032602.126059-1-tim@feathertop.org>
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

RV1126 soc appears to have been missed with the conversion of
rockchip socs to standard boot.

Remove remnants of distro boot for rv1126 common and the one
existing board.

Signed-off-by: Tim Lunn <tim@feathertop.org>
Link: https://lore.kernel.org/all/20230407223645.v8.8.I4cf7708a1ba953b9abd81375d93af34665c7b251@changeid/

---

Changes in v2:
- New patch to clean up distro boot from rv1126_common.h

 include/configs/neural-compute-module-2.h | 6 ------
 include/configs/rv1126_common.h           | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/configs/neural-compute-module-2.h b/include/configs/neural-compute-module-2.h
index f0934ae00c..43a560906a 100644
--- a/include/configs/neural-compute-module-2.h
+++ b/include/configs/neural-compute-module-2.h
@@ -12,10 +12,4 @@
 
 #include <configs/rv1126_common.h>
 
-#undef BOOT_TARGET_DEVICES
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 0) \
-	func(MMC, mmc, 1)
-
 #endif /* __NEURAL_COMPUTE_MODULE_2_H */
diff --git a/include/configs/rv1126_common.h b/include/configs/rv1126_common.h
index a64c0c6364..168cd8b167 100644
--- a/include/configs/rv1126_common.h
+++ b/include/configs/rv1126_common.h
@@ -28,7 +28,6 @@
 	"kernel_addr_r=0x02008000\0" \
 	"ramdisk_addr_r=0x0a200000\0"
 
-#include <config_distro_bootcmd.h>
 #define CFG_EXTRA_ENV_SETTINGS \
 	"fdt_high=0x0fffffff\0" \
 	"initrd_high=0x0fffffff\0" \
@@ -36,6 +35,6 @@
 	"partitions=" PARTS_DEFAULT \
 	ENV_MEM_LAYOUT_SETTINGS	 \
 	ROCKCHIP_DEVICE_SETTINGS \
-	BOOTENV
+	"boot_targets=" BOOT_TARGETS "\0"
 
 #endif /* __CONFIG_RV1126_COMMON_H */
-- 
2.40.1

