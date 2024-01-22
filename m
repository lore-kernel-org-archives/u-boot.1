Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF91FC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E0C87BC5;
	Mon, 22 Jan 2024 13:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="YJFdUh5r";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAH4m2lx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7822487BB3; Mon, 22 Jan 2024 13:47:05 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80D9087B41
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id A9B3D5C00F8;
 Mon, 22 Jan 2024 07:47:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 22 Jan 2024 07:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1705927622; x=
 1706014022; bh=g3C1lXy3XVr6CYdiJH7FwdwwY8j3Js8rPoNvFN0NoOI=; b=Y
 JFdUh5ruQbUPYUXN6AFDI6GAv1l5J4WW29Z3wWa8NPtzCjDnDhyC0keJC8Vn8b2V
 YfSXjJrWQumbVlVwlk0o689rr+wSL1xa5FX0yGPDDbcSpJyIn1A6PkopCBIPYlE8
 EPvvlTAA6qInVo03dwsoRr//5/B5Vc3jJQLM3f1TRZsBeyBMX/KP3pFb2r3xjeiG
 3y5HHup4sjU+VmzOLFsaDGmceGPdikYSZ3IwpwGUqRiA5/OGJrYvv182qAkzf/C6
 BKN7vQerXkLrweaSfXdCQiPrQd639E+lGTTUAfKyZRPZJ8GF77aGm3C7VOdZTgms
 NHk9lepJt2ybr+MQJ78aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705927622; x=
 1706014022; bh=g3C1lXy3XVr6CYdiJH7FwdwwY8j3Js8rPoNvFN0NoOI=; b=S
 AH4m2lxPBrlzrWyLi1mMKBYOUnn+SVYzezo5saWF0fDvHD9DEUjLcL8JVtDSf9j9
 GZsU7izsES614bnZOMeBacArYpCmnikD+gb4qOJpYy/DVjsX3sEJE8Qr+ze/qgqq
 UmX75FLXLrkuK9ehmnBbl8scmPF1A9wv9iTYgwxbm4L+x4lELA2Oq73XtJZkWSnr
 ln0h01yRb4qLjpjTg4LdEGgG7K0Samc9TrZ/iY1Xw0LUQsef4k3mDWDZY8OdLqER
 ZfNm/wv1ONJ4WzQYRo9vivBI8GVfx3olwoeZBKb9cbr3BuMl+TarBTJ7yv+7oery
 jTvpnNqwbcDDu8Cm1B9HQ==
X-ME-Sender: <xms:xmOuZb4aDnza9yMg9EbJ9-EnKyea_7IlNBP1lrcDJ98BPeOD-ZN5sg>
 <xme:xmOuZQ4zJjFXuZ9KROYyF0ckr4zCAcLKTDGsCYGrMVWCX8gSHATTvfZH8TRmYu3XU
 DDyxif0yw>
X-ME-Received: <xmr:xmOuZSepamsehIXpVMsVW5HGi20hw5QSpe-4bMgcfcs3hnNll6W1OU5u6qXwVD9xKur_R8wS_Mwf9uE5-xxSvgDFNGc_rrXjhmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:xmOuZcJ7Opdd-5_X6IXTfv2OVtXodL-D_-ygJW9CIwEW0hPwEqvNoA>
 <xmx:xmOuZfLBMn5qxpPNJQ-46RayiY4WqUYclXL-h1WAL7aBhSmrXnmJow>
 <xmx:xmOuZVyc2n0nwQJYJKWXfos81rkaqtchKs20Ue-QpxGCCXewf_3yAg>
 <xmx:xmOuZVjBxvJxtxU3yVQ-RhbpZHKadB_bGi5jJLeK0S0u9L1di5RMwg>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 07:46:58 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Mon, 22 Jan 2024 23:46:55 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] rockchip: rv1126: Move RAM disk address
Date: Mon, 22 Jan 2024 23:46:03 +1100
Message-Id: <20240122124603.3341988-6-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122124603.3341988-1-tim@feathertop.org>
References: <20240122124603.3341988-1-tim@feathertop.org>
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

OPTEE gets loaded into a memory region overlapping with the ram disk.

Fix the ramdisk address so it doesn't overlap with the OPTEE memory
region.

Signed-off-by: Tim Lunn <tim@feathertop.org>

---

 include/configs/rv1126_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/rv1126_common.h b/include/configs/rv1126_common.h
index a64c0c6364..6961dbe20b 100644
--- a/include/configs/rv1126_common.h
+++ b/include/configs/rv1126_common.h
@@ -26,7 +26,7 @@
 	"fdt_addr_r=0x08300000\0" \
 	"fdtoverlay_addr_r=0x02000000\0" \
 	"kernel_addr_r=0x02008000\0" \
-	"ramdisk_addr_r=0x0a200000\0"
+	"ramdisk_addr_r=0x0a400000\0"
 
 #include <config_distro_bootcmd.h>
 #define CFG_EXTRA_ENV_SETTINGS \
-- 
2.40.1

