Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC30E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353228029E;
	Wed, 11 Dec 2024 08:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AYtgHYi5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EkotGa9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D50B80209; Wed, 11 Dec 2024 08:32:42 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4800E802D5
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y7S465Zrcz9ssn;
 Wed, 11 Dec 2024 08:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyXQx39DwiKucOX6ppBjD6ymQEspZOfGHWO5NM3ShYU=;
 b=AYtgHYi5ZSPKddYdDo7MYQ5YNmu3CtSRR+bQXBf34cRbOYq/7Q8F1GVWrQA1ZlsPoHB5J7
 VMOR/TF8la7uKP3GnAbTElOqvnIiOwH3OymiUuhijaJYZKYEA68p+oqLXiU7kgt6pLbh0p
 ztOwBkd9NiEr4L/KUNmgoCuW8z3rOaf6Oetm6QlH402Y1kqbtEePh0LANw8ndko+35JtZq
 Kx+5CpDaUCVH7cM1yEUgxzRF29Ed14rXg5B07AEIPKyKK9cMl0QZ0GLTaVcku4Xzy23kqh
 /MIbdqCqcKpznDnxE91ys93tQepHI/JqYuBXIUzZKWxnrNHxrKbKfVoQIca7IA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyXQx39DwiKucOX6ppBjD6ymQEspZOfGHWO5NM3ShYU=;
 b=EkotGa9vIrEOnQNaR3eG5utHjTNZJYbowvyGcW+kd3fXkCJ07UAnzTEU2ZRmxQg7EpCmnT
 SIVKp10VAvJfrilW7VlnGX/vX4dVwhC65IgkCs9Ga58fJ21VR4MZ1HLbF3MH+4gUgHuqOj
 4H3yCdVwLeWSp920bNz2XCdgZWjkevwcI2WmD5xqNES8jAAeH25gncVhVK4mJAK1cXK/X3
 xLeAnw3PhyANM2DvyGcbSmhee2TJqPnE90uSZrwtxijpgQR0eSLPXDriy4B0oY4rjNVMYP
 g33diYoFwEGBb0S1MW6n5q5na2954JeLZvSiujpcNgz9Jz3V19CXlPqJADyD/g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/13] serial: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:35 +0100
Message-ID: <20241211073210.8087-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 46cbcfdf0500051f14f
X-MBO-RS-META: rufyuomnq94ob47t4pfym3njtq4mqg1w
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 drivers/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 8b27ad9a77e..c4f4a8d78df 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -920,7 +920,7 @@ config SCIF_CONSOLE
 	depends on SH || ARCH_RENESAS
 	help
 	  Select this to enable Renesas SCIF UART. To operate serial ports
-	  on systems with RCar or SH SoCs, say Y to this option. If unsure,
+	  on systems with R-Car or SH SoCs, say Y to this option. If unsure,
 	  say N.
 
 choice
-- 
2.45.2

