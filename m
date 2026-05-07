Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBBFCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8FB84A17;
	Thu,  7 May 2026 10:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="TrJktBOs";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBwi5AyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6B384A21; Thu,  7 May 2026 10:06:22 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871E284A09
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 06CE3EC0077;
 Thu,  7 May 2026 04:06:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 07 May 2026 04:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1778141178;
 x=1778227578; bh=pvWQYYD8Xwu3/aWnhHHLDjqaIl6344/6TP3nUyHTFY4=; b=
 TrJktBOsR/QwElv6QL8lWhRlcJKIYBDEOZPy73+Nf8sE4oYS6aE98ZdDNGXtdgGP
 2RKwIWHsR7mh6fISR+XrWw0UBToxomwCeFtXIP/Uk/1iJIoCnnTsevBxalthcKqw
 AaQv1OpSyKd50awj/DhDGF4EO2gDiNmZ8UIineIqFSEfY/avAChg8Dc/lxLHOPCI
 NNyuuu/bSwFIokq7YGKLyriMd/GLx1A8iGxJPVE9CWG5DAondhUEuV94IYPP6fgA
 jiWrBubnKVRzCjzMP+MybGYnxpNjg6O4f9SXxMqiqpM61S+tzCJ5d5fJwwKhzY2u
 TqOFEHNYRDLiuQsAkbCR2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778141178; x=
 1778227578; bh=pvWQYYD8Xwu3/aWnhHHLDjqaIl6344/6TP3nUyHTFY4=; b=S
 Bwi5AyWXlDWJOIY+Pgj9ywot3Sqzs7lFbSSIJMOfLqDM85eRdyDcz375SjMampiW
 zuQjSbBZ+2zTjr0Q8RZ9U4EN/vKBJzx8THpQS9ONnU3r6k0+1q0si/nP1oN8p3A5
 pUboya9XiLelUIZWJ3HKj9W0Zjpa2XJbAnugcyTS/lRS6OOIgUB7TY3DXAB2HAtX
 t5QPj7TtRcCSwTR4dCIQwI7/6qYJxZcdPbk5dNtpn26d3TzypAbgQdym2dZBpLFX
 HMfTBRXMfFPsOQuLHxLmqwKwT3GrIbbWAmGnv2XVta6E+IQGOjjTkqa5Unf2WqOM
 L0TSGNrWWxpQvm3LWa3Gw==
X-ME-Sender: <xms:-Uf8aU7qS2NDPh48i1JP_BTlydWVhaHycqEc2dmDTWHWcv2Qc4ubuw>
 <xme:-Uf8ac6X64ILOF-1_bRNxcUTvxJ8g6bOSKt544MeBqRY3lX-QywSGzNQ-vs89o1-g
 MXX9p8USNIvoyOay_SBTbu5UoHjpbHrwnWgM6djpE5M2wpSAi1YAcg>
X-ME-Received: <xmr:-Uf8aYfEhGxUoyqkRB3kJeLLZPuDa8f0_yJD_zXXrTTCoapHgqYfgrRsvoF5KHuTKPT_rXd2S__DeVurgQVYdxZIBVxe1I5mExqNrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeileehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
 ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
 ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
 hurdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
 thhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprhgtphhtthhopehjsehjrg
 hnnhgruhdrnhgvthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdp
 rhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvg
X-ME-Proxy: <xmx:-Uf8aYAFrZS19hmQJ6D5lPs_yjf7mgeqbm6TitpnPEU_R5qmIjVFdA>
 <xmx:-Uf8aT-N3X_K7S8iEHMv5T6IPh_CjeKXNdAvGrUtkQR9ZyV9EoEvZg>
 <xmx:-Uf8abIL5qQNrpNbZq1wfbom7iZB48HuHjcCGnt_ysWfAex580M9Sw>
 <xmx:-Uf8aUj6d5DuXd6XWfvJzA4184gNXXq7fU0KKa3MXnTdz87O_NMURQ>
 <xmx:-kf8aZYraHIhS-Jff2l2CPzlXhJr8XhEgCtq7BtoB-jj8KHwDGsiOPsf>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 04:06:17 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 07 May 2026 10:05:49 +0200
Subject: [PATCH v2 1/3] doc: board: apple: Mention M2 and M2 Pro/Max/Ultra SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-apple-dt-upstream-v2-1-35181f2b0509@jannau.net>
References: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
In-Reply-To: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=mm3dtSgUyvXsXY3iX6L8AQEDvYLuaG8GiBvC7gIeTtY=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/7t+m1q+/5Vq/rrwxWfLhYencB3qtcSxv/rUtF29aL
 HQ25tnzjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABP5yMbw3+3O99O3Hne2ZG6J
 OXTRet7lmKm2XvH9f6oO106JsLs7bQrDX9HGb85q1w5e6jawzjxu93ai33XJK9+uPp564KaY4t3
 ZN7kB
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

These SoCs are supported since 2022/2023 but were never added to the
documentation. The devices very similar to the equivalent M1 devices.
The biggest difference is that the M2 and M2 Pro/Max based laptops no
longer use SPI for the keyboard.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 doc/board/apple/m1.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
index 8fa7637629e..5d2cf750fde 100644
--- a/doc/board/apple/m1.rst
+++ b/doc/board/apple/m1.rst
@@ -8,14 +8,18 @@ developed by the Asahi Linux project.  At this point the machines with
 the following SoCs work:
 
  - Apple M1 SoC (t8103)
+ - Apple M2 SoC (t8112)
  - Apple M1 Pro SoC (t6000)
  - Apple M1 Max SoC (t6001)
  - Apple M1 Ultra SoC (t6002)
+ - Apple M2 Pro SoC (t6020)
+ - Apple M2 Max SoC (t6021)
+ - Apple M2 Ultra SoC (t6022)
 
 On these SoCs the following hardware is supported:
 
  - S5L serial port
- - SPI keyboard (on laptops)
+ - SPI keyboard (on M1 laptops)
  - Framebuffer
  - NVMe storage
  - USB 3.1 Type-C ports
@@ -77,7 +81,7 @@ supported SoCs.
 
    * - SoC
      - Base Address
-   * - M1 (t8103)
+   * - M1 (t8103) and M2 (t8112)
      - 0x235200000
-   * - M1 Pro/Max/Ultra (t6000/t6001/t6002)
+   * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
      - 0x39b200000

-- 
2.54.0

