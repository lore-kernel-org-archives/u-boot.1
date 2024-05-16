Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B60C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 22:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F9A88490;
	Fri, 17 May 2024 00:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="MzsJChoO";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ce7z+UTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1752884B2; Fri, 17 May 2024 00:16:54 +0200 (CEST)
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com
 [103.168.172.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E5988497
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 217A81381490;
 Thu, 16 May 2024 18:16:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 16 May 2024 18:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715897812;
 x=1715984212; bh=ze5ngytg22cjvD1Nv+QLVnxU/YWOFZVAcX/MOEWHU9I=; b=
 MzsJChoOsoX6sLlZq+0AU1b8WRNluzORML0dVFVnuF9q3pbMrGlMHTTHiYvMOFSi
 Fw3Mewu1LScxL1NXwhaU1Oln/0C3MSvHhJxxHzhEOL8G7WyLnGmlOCDdubL/3GJo
 Bt7qDVHG0/iupsQW2HAOymUssaIEcT+AjFFJxWXU1qYytjrbbBptg33lR1RdPXI8
 dyYH8vV5pkbGAsb4NgSf1qq4rmtkpMvWeCR5JH4lVDzH2QWzqlVhDElOh5DCpQgb
 1muYFjOhALllCe1FxUidoHMlQH20eDCYTS5R1lVBut73FY+pynTJ/zeG0P/283I3
 UMZnyWNDZBf6/RBhOxkqig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715897812; x=
 1715984212; bh=ze5ngytg22cjvD1Nv+QLVnxU/YWOFZVAcX/MOEWHU9I=; b=c
 e7z+UToPhN/B/5PZ6KYezgc0qSQ1IF37iKOBF8n7/58kOZcJpY45Rdzz4JaQhwPi
 Ey5uM01K1ugM/BUDsHiG5Bd3yFkJZrH1dnjHmGVO3GBWpNtPcjsVDH7UONcCPw4q
 nfc0eb8Mjy5wH9t9gBeFNsK+1JJPKZCHQ0B7NDFU3hZuuJF4bwsnzLVNBo8M+qWZ
 qncZqSwUSYxuUTUYucWfYzOXe3leUjN/Wc2dkJD2iXiDIbz08XV7B2L6sMYyptRp
 O+vDA+ai5alO+Fqn6ObimrHkHz6ceGCY311vN2l+w2HobACnq89X/C2NmQu9orFb
 yRKlmrL54lHug7ueydShg==
X-ME-Sender: <xms:04VGZuMFdbPgEeqUxPJc9qhMD1A4xHNKu5AI0j1hidnCHO3MQcLX8g>
 <xme:04VGZs-PVxvyNeJsp3aG4K_WGGROSD1wicVe4IYShJQ8NIjNThaK5YD82BY7QqVLa
 UXird48AAcQB5RLmEg>
X-ME-Received: <xmr:04VGZlSNsFud1DzQkyijD70htBnMXsgktaKA6g1sOYDhwIVHmEr1AH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgtdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:04VGZusQeQ9JjN9VEzkyhnqNCMOCm7ygqr2ufDgrEDGJi5ztXTzBTQ>
 <xmx:04VGZmcap_rS5nCanq8zFhGjXW6nivTowl5ICnTB6WDWiB9VnoRanw>
 <xmx:04VGZi1kuQTER3n6GrzLNDVqoLENQtr3AelogWQns3UmPGChIqboQA>
 <xmx:04VGZq-mCWXmnR5HmvIUrl8px4724QT2n0bzfIpP9FGm9CrsOmF2KA>
 <xmx:1IVGZm5CcMcTNyGgzb4PZUOBQMgMwm9NgHgUT4pyTym6V4Qgp-zBe1SZ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 18:16:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 23:16:46 +0100
Subject: [PATCH 6/6] video: bochs: Setup framebuffer endian
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-rework-video-format-v1-6-f69822b742a3@flygoat.com>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
In-Reply-To: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=uXUkYoxewDtt2lIZLTm3YxBjI1nWZJYFhbEQwgQyN3o=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS31tNXN+Xl50y0u/OB68iSi/+06017WKWcr5m+c/yb7
 lDzaYpfRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzkuhHDf68vLMeyzt89pveO
 8Z/zbqvyG38kXNy+2Ek4MQZq33effoiRoem/fJrFvMXzn3dZ24copc52X3/56In4v8qqNzwbzs5
 jYwEA
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

So the current situation on endian of bochs framebufer
is a little bit complex. QEMU defaulted to little endian
for both endian hardware except on powerpc, but provided
an endian swich register allows OS to switch endian.

Since we can't guarantee the endian switch register is
functional, my approach is to default to little endian
framebuffer for ISAs except powerpc and perform endian
switch to match this assumption.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/video/bochs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/bochs.c b/drivers/video/bochs.c
index 00e673a4db08..c315c5477b14 100644
--- a/drivers/video/bochs.c
+++ b/drivers/video/bochs.c
@@ -65,6 +65,14 @@ static int bochs_init_fb(struct udevice *dev)
 	uc_priv->ysize = ysize;
 	uc_priv->bpix = VIDEO_BPP32;
 
+#if defined(__powerpc__) && defined(__BIG_ENDIAN)
+	uc_priv->format = VIDEO_XRGB8888_BE;
+	writel(0xbebebebe, mmio + 0x604);
+#else
+	uc_priv->format = VIDEO_XRGB8888;
+	writel(0x1e1e1e1e, mmio + 0x604);
+#endif
+
 	/* setup video mode */
 	bochs_write(mmio, INDEX_ENABLE,  0);
 	bochs_write(mmio, INDEX_BANK,  0);

-- 
2.34.1

