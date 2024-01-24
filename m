Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF782C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 03:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F60287B89;
	Wed, 24 Jan 2024 04:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="EvylsEwV";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfzyWO4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BC5687B89; Wed, 24 Jan 2024 04:27:11 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F8A87BEE
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 04:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id A303B320099B;
 Tue, 23 Jan 2024 22:27:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 23 Jan 2024 22:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1706066825; x=
 1706153225; bh=cHyJsxNj16N7tOSxumhtZh4Vqo1KcQqoUUoLtjD1ldw=; b=E
 vylsEwVhU77JHm7xr3/2JYl7uduwR6Xi/DpqeLqGkqPzu2gR3gEkWxkQdvUffn5X
 rbtT7zdjeMXuY1U4kdvfUah1LazVh1nYFXpEyvGPOFralmBartReSaTlHKOqoU+K
 j23+TECadWeHOb0aq/qK/zEmuFZCixW7kq0tq3gyqVg2oOb4LBGouu77MEpeIE/p
 Hq+J6E3T5m35qF//BLrfHs5GJRbwU3oiWR5b7FoXJrSud1QYEOzWYPYB9STAGLZl
 5t0r5AsNSDUzCGJsrGHwJXzXAbDqvaupqiu66L3YRKqmfXoAHPyjC2uW+b0c/loM
 S9ZXzjvmqddJlyRtpotUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706066825; x=
 1706153225; bh=cHyJsxNj16N7tOSxumhtZh4Vqo1KcQqoUUoLtjD1ldw=; b=m
 fzyWO4ttG2zYeWKNzjuNNCHV6BuuOJkUFze8H3zWoU4fnnR25x93FmTjssnNlOPZ
 vv9pVtjA3CX2zZBqKhmAB/IOpbp9GjDyTi+tL0mQpAs2jH/GCSk12LvweJPHZ+te
 KpgsyXeid8BEWnp8DOdIAeSoODRBF4F9f4NP0WxuW4d2u5zWNEY7hx6LtpI7JKJ3
 /on9NTErIRtNcepfR2f6oN6NXXmdJzv2TRLFTY6OSQfJ9S8M1BJi2jAiImA3MeUQ
 S9J45C8y1VAmH9Wn2HLs5yFI3EEEZ0Pspp0EHsgx8V9nCykkMBIJ2xfsaWrLUcpR
 CtR2kXpU7wxtDTFU3D05g==
X-ME-Sender: <xms:iYOwZVjLE0K5u6LfnBK4itADpEy4mbLWbVBlqT6wmqujLURolqPnzw>
 <xme:iYOwZaDANPjse6RHM6T914xHDqI-gHf-XwHxvrd1-BcjvizVeoxud-EkVd1RTCp_a
 t36C8cz4w>
X-ME-Received: <xmr:iYOwZVEcZl4k5IA0ed7TfJBW-KF3TEWOWrWQgKwKjg3wLTgnTrJhWt49n8gP0Umcev3wnTHSVb7Oq2dq-O2A-ghPjPWTDsAvoyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:iYOwZaRAeowIjTMVKpfqM1Bpj0QVoxAE8KYBtvMs42I7EzrF6hbgMA>
 <xmx:iYOwZSyilLEDg8GFyWpcj9Hsq_4xsTxMBYFv9lDEUF0Ed0QzgR9RLw>
 <xmx:iYOwZQ4xc086o6FsMPNbv7mO_nqHb8q6-7pq5lP9AeVPqgD1k8nL5A>
 <xmx:iYOwZcuqR8qQhY-r8yE6OFlKSQIuaZkVKEP_hoIl50M-IXUGRaAaBQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 22:27:01 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Wed, 24 Jan 2024 14:26:59 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/6] rockchip: rv1126: Move RAM disk address
Date: Wed, 24 Jan 2024 14:26:02 +1100
Message-Id: <20240124032602.126059-7-tim@feathertop.org>
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

OPTEE gets loaded into a memory region overlapping with the ram disk.

Fix the ramdisk address so it doesn't overlap with the OPTEE memory
region.

Signed-off-by: Tim Lunn <tim@feathertop.org>

---

(no changes since v1)

 include/configs/rv1126_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/rv1126_common.h b/include/configs/rv1126_common.h
index 168cd8b167..ea290f763c 100644
--- a/include/configs/rv1126_common.h
+++ b/include/configs/rv1126_common.h
@@ -26,7 +26,7 @@
 	"fdt_addr_r=0x08300000\0" \
 	"fdtoverlay_addr_r=0x02000000\0" \
 	"kernel_addr_r=0x02008000\0" \
-	"ramdisk_addr_r=0x0a200000\0"
+	"ramdisk_addr_r=0x0a400000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"fdt_high=0x0fffffff\0" \
-- 
2.40.1

