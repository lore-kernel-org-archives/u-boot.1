Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665D0C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3201287CCE;
	Mon, 29 Jan 2024 22:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Bis2OUDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C8787D99; Mon, 29 Jan 2024 22:05:17 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7FC87C13
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EB99D3F8CA; 
 Mon, 29 Jan 2024 21:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706562302;
 bh=oWTizndt1GIZEm7WIuPC41fvOCTdtfTJ7/AZATh7Kwo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Bis2OUDWgK98wc7XIxbIvSFiRUSIWHXImtvcmvno63X75Q1iXQJCIiUnTJqW1N5dJ
 mnAQdorj9mX9rcDSMc9TLRd8mvv/PBUKKX4bZbabjQHriWf6NBfOrEaprgvky1/U0V
 bo+3hXPIR4NQnvLXr1xg6OkFmZyUED6EfP7FcorXA3BKahcfbOqU+xJHlwtVGaLNCS
 yhSUFR5GjovDU5ZHyUDXcTSUVauWYCGwUmIHdu3zXwhe/iTUiwTbtUO8Jj3NyOaDV+
 ZoL3CefxSfftxr9q+Q+h558XflapyLWde2cGyhjAjIfvVSJ/Bo7yS7waYXNdiWtDux
 uIcfq95Sr22Ng==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 7/7] smbios: correctly fill chassis handle
Date: Mon, 29 Jan 2024 22:04:53 +0100
Message-ID: <20240129210453.31070-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
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

The chassis handle field in the type 2 structure must point to the handle
of the type 3 structure.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/smbios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/smbios.c b/lib/smbios.c
index 50072adb4e8..5a6a980ff6f 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -420,6 +420,7 @@ static int smbios_write_type2(ulong *current, int handle,
 	t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", NULL);
 	t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
 	t->board_type = SMBIOS_BOARD_MOTHERBOARD;
+	t->chassis_handle = handle + 1;
 
 	len = t->length + smbios_string_table_len(ctx);
 	*current += len;
@@ -548,6 +549,7 @@ static struct smbios_write_method smbios_write_funcs[] = {
 	{ smbios_write_type0, "bios", },
 	{ smbios_write_type1, "system", },
 	{ smbios_write_type2, "baseboard", },
+	/* Type 3 must immediately follow type 2 due to chassis handle. */
 	{ smbios_write_type3, "chassis", },
 	{ smbios_write_type4, },
 	{ smbios_write_type32, },
-- 
2.43.0

