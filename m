Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDE6C25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E5A884BC;
	Fri, 17 May 2024 18:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="iSdqN+pi";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFwodB38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A57B9884A6; Fri, 17 May 2024 18:33:06 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D648849D
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id CE788138151F;
 Fri, 17 May 2024 12:33:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 17 May 2024 12:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715963583;
 x=1716049983; bh=9juQBKxyhjgoTFpiianocmI1WldtbMpPiLI7jqsPI3Q=; b=
 iSdqN+pigP+7gJt79ORCO96KyVgdH6bGU4ze6Gxp5rlKZ0FTUWcxvjZ/hVPIMtBM
 zySguCnKUwCXY6vZPP9UJHWJ+xUReIdYeJP78UqtQlPHPNjYuuQ3oHUls1llRt7R
 21cXf0FlfGKVVSj5bKmryeJoE+ZSr6ayJwrStjXQqV3nfM6W/1og5HnOHAA+a5Ze
 g/CG9z1/h2r0RwAOMOkutt/rKEhufFs+fcA5ATAjfy3wqkiX1XrFUUwB+BaA+K7E
 EJ8Osk66hL+GaUDHwuHXZFnuYSEoqM5Q5lAxTdfHFscHmn4KRL78DxamD+Gq+y+0
 zZ51/rEeW0/WiINPXnEb8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715963583; x=
 1716049983; bh=9juQBKxyhjgoTFpiianocmI1WldtbMpPiLI7jqsPI3Q=; b=S
 FwodB38OqWL9myHQrZy6U9uvi6tKP0ibrSypcjZCD/6pRVDKHwVjLm5uYWxAEhVW
 9BtMys+jCmIpZ4zq5ISZAdjaQOsUO3QzrSEtGTznkaRB7pRd2m1rCxeUqu6OJA1w
 jVcsVlcpbhGJgT4UwX1EH7Dkb6fkOYbgdhTjerVB3nc5dq0Uj782WGZliI/uPXtk
 Wo4oeWihZhwyOYsTBN7k+l8UssKp6aOrYYs9JwxQ0Dcbr/TOT4a6+y2ycd7HRwbE
 L2xLQQrpUk/fSTJs7rXg2GlZg56LW6t7s0Cv+OmtVbc9dn0cQ/YdD73zgubMCVql
 35Ol0852tNzGIhi3+A9jQ==
X-ME-Sender: <xms:v4ZHZoknG5Imzg3LGzK0fz0KGC4t_rsT9NKOeTWPd1FcR7lZhswRvA>
 <xme:v4ZHZn0HVyMHQ7F9jBm_wyqLSXDoLGjb73e_jwDnI8PYevi_9cuai0nG-aohMdWPq
 wlQRYUXb3pUu21NHcU>
X-ME-Received: <xmr:v4ZHZmrWZIGe5Qx6bm3HbE4XJ9dZvX28yff4aUz_Jh-K-2reo_6xoQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:v4ZHZknzLYvSwa5EHSaeL12jLiN98a1kqr1c1-KT2o8nbWhe_SRuDw>
 <xmx:v4ZHZm3ws1wYz-UjE8lHDjVhc1Ns7aBM6zDZKv8G1eJikkFno1UaqA>
 <xmx:v4ZHZrvoAc7rQ8xUcGR0t-k925y6itxsxMs90T19m2QTRpZ2rUJ1Mg>
 <xmx:v4ZHZiWr6ZYkrlm7YOS-IjfVKgT17LbhkyDfkDMUdCORUOlpmzAzeA>
 <xmx:v4ZHZgqBtUTgwf3FrI7jMGsq1XgXUlvgqXot8KJv86iZDYxws0luUFFX>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 12:33:02 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 17:32:56 +0100
Subject: [PATCH 5/7] MIPS: Add smbios_start to arch_global_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mips-efi-v1-5-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=685;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=N5nHCKJp6TcyM5ZIUDebRGUgyo6DEeXQ+cKkTaPZmZ0=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3th3B608Yyt5XPXMk/7DOLU216ancgRE/j+Xc+D3LO
 93IwntxRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExE8CEjw25jDmGjF//CTQ7O
 yFnPs/HWrJ8/3oh/W7hxiW/AY94fwk8YGZ53S8yyvHdNLOh50QGPRLYHLNNits3QS0jNjFjew1Z
 8lxkA
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

This is necessary for SMBIOS to build on MIPS.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/global_data.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/global_data.h b/arch/mips/include/asm/global_data.h
index 147a95ecea8b..740bbcdb84e9 100644
--- a/arch/mips/include/asm/global_data.h
+++ b/arch/mips/include/asm/global_data.h
@@ -40,6 +40,9 @@ struct arch_global_data {
 #ifdef CONFIG_ARCH_OCTEON
 	struct octeon_eeprom_mac_addr mac_desc;
 #endif
+#ifdef CONFIG_SMBIOS
+	ulong smbios_start;		/* Start address of SMBIOS table */
+#endif
 };
 
 #include <asm-generic/global_data.h>

-- 
2.34.1

