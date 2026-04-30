Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084CDCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5987A842C7;
	Thu, 30 Apr 2026 23:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="kpUicvvX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDcFd4gH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8045284255; Thu, 30 Apr 2026 23:26:06 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEFA84198
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 68E7F1D00081;
 Thu, 30 Apr 2026 17:25:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 17:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1777584358;
 x=1777670758; bh=N8FF64AQ1sH/Alk14qRuCVJVQjDcaxyydredNqJhHPo=; b=
 kpUicvvXgM6qssIC+cVd0srsMXE3iGRnhdZYNUyxQzNZ/h5OzG4w0Od2Mb2Jzg8J
 sqBHLMScdeuCxQV6AHi1rdq8jOzT73soJSRGfUjGFRDuNNdM8lB3CaUOEkFqMpOG
 fDLUFF7vsSKF3sB0r4X7obZzX8AKnbkrJZtGT331PtVPTwkXFiXZBx9N8fF2Q6eh
 7+w8eCzF7ptlFFUcYdoep7b0AKlv39bI2hiIlJ0Dj/KgpzsZdWKydG6WGp7mjrJK
 uJAFbr2giqF5eNXIhtpYyaE0F6Bhd/clRgH9yQZQjTAeemcLP3wxm8o9IMmVXLLN
 20imPWj/+0YfUU/Ah0B0Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777584358; x=
 1777670758; bh=N8FF64AQ1sH/Alk14qRuCVJVQjDcaxyydredNqJhHPo=; b=b
 DcFd4gHKGcjrPxnH6vZbVlgCFwS4SwLHmP1GpQJMFQPqrP3+RU4EnJw+28iDVasH
 7ntIex+UngxF45/HMmpzVvCwxovOArkusCejWsiQlfj7c5KTZSlS64Nop3gW5Bnz
 NaX12Wp1IXu27tm6vTxuR4YdY8pj6JLebAab/hG9M6oFe+qUrCXnWyq4HFv92X9D
 vNROYKFY/5aYTtyirO97G+SEBsrudXP35Z8ciaNX56z+XepsA+CMINYiU3dJTHfc
 PHxV7J6aCx24FR88Fa6mDZGXxALaEFz2c+0CYYOBnJBiQJcP6eSH2Tz+xG7cwf3c
 Rjqy5AAdecfFFnok1c+qw==
X-ME-Sender: <xms:5sjzaZrx26CJUBHPwGQ5Q6h5V5-5DHx6Epk9RlBCxej2jERLqTvj7Q>
 <xme:5sjzaSr73MEXIJCG68qM6OJ5FHvNrIcdoTK2RTFnI2pOo3PECae4uaO-5dQA2Wlfm
 upwNUD1Q1IbHjbZk4EMPNFflGoHh21eAxPxurNO2T1vnWuMOcXD_yY>
X-ME-Received: <xmr:5sjzabO6YHk2ZEsfpkkeMxtxz5y9kIbwIU_2NH8EL_kCj6k7xnRpoRB8PbcIk-GKC1zxTIU1OGw8e1SJ0Dm6ds5cwS9GGjOupF1wmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeflecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcu
 ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefhe
 ehieeludffheetiefhvddtleffuddtleduudeiudetvdefffehkeehgfettdenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
 drnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
 ohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepjhesjhgrnh
 hnrghurdhnvghtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhr
 tghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:5sjzaTxeEMbPdDQnOr8XNpDAuMwyV_GcRIuYZhvzVFxd6lFaoxqX0Q>
 <xmx:5sjzaUs9M548EF8TX3RCHlcm5U7PGRvAGPnFxTnWZzu6wQdDYnbbZg>
 <xmx:5sjzac7InD7w-xjEIJFkkvehhJ2_Cq79sm9LG71sDYFMuu-lebt9mQ>
 <xmx:5sjzaTSn_c47QaCyOFYqfiW9sJfoeYeBsn_SJm-A0Mv8D0zQDZi82g>
 <xmx:5sjzaWL8_HCGOI61Ut5uKbscC_Qt10wo6rxo_-K_8bTSt0zSlGp3f92V>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:25:56 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:25:46 +0200
Subject: [PATCH 1/3] doc: board: apple: Mention M2 and M2 Pro/Max/Ultra
 SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-apple-dt-upstream-v1-1-dda66c16e0da@jannau.net>
References: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
In-Reply-To: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=7gR771XhGK3bPYBsW1AC/hFewXJPLUFpB96dkcUdegc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPJ+5+mt74KK1K6GyryM2dx07ePj/HOP2rpnv+vKQNx
 wMnfqz731HKwiDGxSArpsiSpP2yg2F1jWJM7YMwmDmsTCBDGLg4BWAiAnaMDHt9V9wwlHqxt3a3
 oFTrGeu1Ni94P8zkXGH+xDE5me2cbA/DPwsPg9e/7vzVTPd7fLTvw90fRlHFnxxMGfhW/9jNsoW
 thgEA
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
2.53.0

