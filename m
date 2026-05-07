Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1621CD3445
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A63B84C21;
	Fri,  8 May 2026 01:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nwJhHKFd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Yy8hJX6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5BC84B58; Fri,  8 May 2026 01:24:51 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0640684B92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBSyS5V72z9tYP;
 Fri,  8 May 2026 01:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UVoBTA4jT5iMM3zCbn9wUlDJj+28rgLn6Do2bE1kSM=;
 b=nwJhHKFd91AYYl75wZXQHke76kWjZ00TnJYE4fkSocdWwSySrw9RBYNZYbJp3Jc9glbLSn
 9s9IBLXqhDh6rA1X2q5Dd68tJV57LJHtX1K+ilw5MW8lb5ifRv/oiFoG0U9rNwsiE/wo4J
 Dihou9lwYyAjy/p49JlkiMAafHFAjhnQ0M6+XnAqm1poDpqfZ+be6ro6HEWQ+s5ECtwiOO
 7ThS3lf735nnzvt1Z824jNpf9cgZp6zepOkkJBF+Pqxro+OZ0GnnxlmJh1svT4z8aQ+kbm
 taHHiORDcy8kDSg/xIDzzH4Ei6FQUCR3gpxPVUE5ZnTs+1wlVxrxuFSD8vv1zA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UVoBTA4jT5iMM3zCbn9wUlDJj+28rgLn6Do2bE1kSM=;
 b=Yy8hJX6kS2rVDMYRW/c1DyfLvycURzv66tT7nZRtBO4nhVAZnKoflXEgUS552MGooHaD7j
 ax+UZgxq13qlr9uDduxKMWfB1tw+x+YHBS4SmbY8CFjqZX2Bs1S973KFUE2NXENAch9ZN5
 Ek8HwM80h4d7kkLeDelheXEu3gv5RphQFNX3kln1HDIVgwiSjEmV7Vsw/vodASraIIbkAa
 xTiwCuy4iw28nx+JR5HMxFMVIotTZY19N+kM9+BM1AWQKe13eZqT7aWtDsxmkrW7rxv+W4
 FgMDwrZWUYTZAaeGOHuYYc4zE/2grR5ZDpqJ5qBHpmOlWNY42OfFo5laIueL4A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] arm64: renesas: Select R-Car Gen5 R8A78000 X5H MDLC power
 domain and reset driver
Date: Fri,  8 May 2026 01:23:31 +0200
Message-ID: <20260507232424.304154-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
References: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gsfpqj3oeej44ksy4b3ozc3rm9cucwd4
X-MBO-RS-ID: 56a2212b417b9d91d6e
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

Select the R8A78000 power domain and reset driver on R-Car Gen5 X5H
SoC by default. The power domain and reset driver is used to remap
DT power domain and reset IDs to SCMI power domain and reset IDs,
which is necessary to support multiple SCP firmware versions with
varying SCMI clock IDs across versions.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Clément Le Goffic <clegoffic@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Kconfig.rcar5 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
index a9a9137f5be..fcca3811241 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar5
+++ b/arch/arm/mach-renesas/Kconfig.rcar5
@@ -15,6 +15,7 @@ config R8A78000
 	select GICV3
 	imply CLK_R8A78000
 	imply PINCTRL_PFC_R8A78000
+	imply RENESAS_R8A78000_POWER_DOMAIN
 
 endmenu
 
-- 
2.53.0

