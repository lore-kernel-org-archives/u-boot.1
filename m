Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9070CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4582884D78;
	Sat,  9 May 2026 17:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vxXh5SAD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D7TBUgv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6F384CEC; Sat,  9 May 2026 17:13:27 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC33884D74
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gCTyY3WMFz9vCH;
 Sat,  9 May 2026 17:13:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yiLvwptcZZwx3Yesmrs2fKjt06kz0q8N4KQi5zd/z7Q=;
 b=vxXh5SAD4cyjK7J7t8jU1uFNiE5DS/VeZcOcZa1JlTSx1OKSfzwKOrD1v04TBN9Pcn0xRX
 YkTuAbZKI5DEftKYzL0DD4+hj8hnQth0OhGfWrW88f0D8QDuZkA6/au6muvN47g9FGCy5N
 L2D3BjZr52uKEdDVAo3cXAbKxfKKaWqU+xh9/8vqyV3EwOd28E0bVMbXbYo5iPrYAdG7VX
 8DhDrY6lJWJ80O5htEkAqgW/7GZu0Bu9vZe7yQ+R8TT50eFVRQh+JLqiRJllT+CmEFbdUw
 XFN/je6diTdCxTQxEj1mfzf0n6Sn9XlrX3bujfWeHb8E9RHyMJsRM0zo+t0b0Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yiLvwptcZZwx3Yesmrs2fKjt06kz0q8N4KQi5zd/z7Q=;
 b=D7TBUgv3vb1mIr4VM7RhJVJbCQOKYjOTXcatr8F8lsobp+zR2EogqdKpI2S2alOApB6SEm
 u7bmMkMMCUSmOLZ27WUPSw7Jg6uY4tiI0xyERAnqRcVUunEUVAh8ZFm/aGpz8IM10A+1U/
 cgiSuD9vD0vdJDi2rArsTeMXt+Jcc1f3XEGP31p5Co55+rOKp/yt9N4BjYb7TmQDQ6YZLt
 dcBg+0SqwYnM3B8hxA9EYX8eTTVYivbt7Fcgxq0hh/OZRmX4IO/qLm5c+xDMaenT5jkvYy
 byvxV9+COae/ULrklslNHqnSDnyhptgOHRdIcGmaXk4nrPeBOuzJ1/j6R7Hhxw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/14] reset: npcm: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:31 +0200
Message-ID: <20260509151308.23067-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1m9xxhf1euqg7eqiepqapkmr66b1ho9i
X-MBO-RS-ID: cd4ca9e72b63ed0e252
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/reset-npcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index a3b85a42250..66b541f09e6 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -126,7 +126,7 @@ static const struct udevice_id npcm_reset_ids[] = {
 	{ }
 };
 
-struct reset_ops npcm_reset_ops = {
+static const struct reset_ops npcm_reset_ops = {
 	.request = npcm_reset_request,
 	.rfree = npcm_reset_free,
 	.rst_assert = npcm_reset_assert,
-- 
2.53.0

