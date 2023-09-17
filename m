Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5F1CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CE286823;
	Sun, 17 Sep 2023 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gCAFLvQQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Odz1zpby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 110C486785; Sun, 17 Sep 2023 16:09:14 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EAB8658D
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RpVCp4f7gz9spg
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=558buCT3hQrd3oZ7jtZvyNRCjndB/wEwM58G+TKaTQE=;
 b=gCAFLvQQ0f2dGCCmKcjSbGOLK5Gn3Zn3ssW3FR7/G9SQ0o5io+1wbMZ/Nc/zSaYKmBT0a7
 m0wg54ZDWxwiMK8lLB7NEW0vSzzinhFv8AxIZ3vHEcuNMmBKTs5vc24MpL7d3GwZjGEWYG
 Kj8s7PGFETis5S2GH8WgsOwyzUcXKEW6EYT6NFxU8ksSPvHhCVgI++Ha9bq05X0Xjp3u+G
 f+cSR4S8MXJaEFZ+zHkDH8wCO3alh3f6JubfM87UlpeCPGwI+kY86l4cqfICo8lz0E2m3Y
 IPK0T47+mpkXm8V/t+R4RgiO0rR/MhTirTtUXpdc3WubOZTRP/Vx8dZypDiI6g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=558buCT3hQrd3oZ7jtZvyNRCjndB/wEwM58G+TKaTQE=;
 b=Odz1zpbySzgxFEqSDAPaHTVaaeyR7oZk+dCqhZhqrahwN1CJhVJjJ/lsMFeO9DMena8Fl6
 oEjpUKXQ29oulHfE5H8i4wCWk6QcOYz0JnMFzOLDPP7UDuqNEfTtG+0hWOiDQGlBUXjJgb
 9hCSYrvBAs9uLJNMScXY0eUv5yjhsVnNp1FK0n/jGDGPpeXPBfi/g0oHOIYR31KmzF4mTO
 Vs1gBXq7Q+UvwV2wyliAEjT2tlgoGpGA/bEep8E/BZuT33xQFL00N/6w+WPC9XN6Ep+8Bm
 IWNfD2jxVJCGK/tOAW5bYaQ9VDZrGA5y+3pINUXtCM3oHp+vP/qkVdCJSeaS1Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/18] pinctrl: renesas: Drop R8A77950 H3 ES1.x PFC table entry
Date: Sun, 17 Sep 2023 16:08:34 +0200
Message-Id: <20230917140849.379711-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f33bd6786a4f1118a63
X-MBO-RS-META: 87d33tc11g9r4pzhxbqeho5f7wyc7wdi
X-Rspamd-Queue-Id: 4RpVCp4f7gz9spg
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

Drop outstanding R8A77950 H3 ES1.x PFC table entry from sh_pfc.h .
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/sh_pfc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/sh_pfc.h b/drivers/pinctrl/renesas/sh_pfc.h
index f35fd3379a9..bf40944053f 100644
--- a/drivers/pinctrl/renesas/sh_pfc.h
+++ b/drivers/pinctrl/renesas/sh_pfc.h
@@ -302,7 +302,6 @@ extern const struct sh_pfc_soc_info r8a7791_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7792_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7793_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7794_pinmux_info;
-extern const struct sh_pfc_soc_info r8a77950_pinmux_info;
 extern const struct sh_pfc_soc_info r8a77951_pinmux_info;
 extern const struct sh_pfc_soc_info r8a77960_pinmux_info;
 extern const struct sh_pfc_soc_info r8a77961_pinmux_info;
-- 
2.40.1

