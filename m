Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E976CFD65A
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF448405C;
	Wed,  7 Jan 2026 17:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SZiJ4+8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97408405F; Wed,  7 Jan 2026 17:22:32 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D257083A2D
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7ce229972f1so1788421a34.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802948; x=1768407748;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T71nTSWtLz65C0iU9nLkzf5D5YWH3FN3y3nUKgmLNco=;
 b=SZiJ4+8e4JI78Rr/TK0C8f9SS/vSHCOBr/o3K9x+btFxI+JB0QB7uJ48bFFy20wv/a
 +zR56QF69NhQc6bYdf8DozcpR/79N2ENueBS/tjpZ76X9ze2XprTLX24EY1mGcQpI+2R
 JGB+PgcpeUxJNjeImm5lcmAMPmx6IXoYQrBZifmys8Ki2vhIKdoPI3S2VxzFP4mkrTIK
 a+exN+NOaonD8HR+ZIppxYwAs3slw0fN2J2amx9C8qd+mL49TlAc9RxPPKPXuBpnt3E7
 vucvfly4YAOuN68JDXClXXkU8JmvZvpJzeIwKv1cwaEkRTK6iJzqmriRy3AmsBglA3bq
 t/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802948; x=1768407748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T71nTSWtLz65C0iU9nLkzf5D5YWH3FN3y3nUKgmLNco=;
 b=uQaTXEpQUEQpAGXFSPOIn7ekLNTtGKUlehtA6pX/DnCHjtOmcZGeX6FaBIkO/JGEm3
 cgU6mKWOrjfPmT+8FyMiOGCEI41V/bJvTNHlHj71curFIO6oLu9ilC5/S3glX/MOzxQ/
 rYr1DKOYxa++a55gX1+6HYeDEsPmUwRDJL3lC/Xim3No/Q3Nb6wp9MkIAEU1GeM6o9tg
 fyJXtTSHUyDRVXE/p8pYROpmwYMZz1ireJWdK+rw/dBsqtvSBti69mGL4MF4N80T4LRx
 S+tacOuembduqMRLzkCrwGSlxBR0YwVLeGQrCiWSJ6RkgW0AZ2CfNq2DXyub8l8rd3+c
 +6wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVprcztXKHj3lnzH3WKLHcloOdIX7iix8PikzpiwEM3Whc9yWZYNeU9vB534etog357n+BZUeg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx63WpuzePA7ZEraI8psFAY6U/4QUxLjPpP2BYi/p/pWu73gc+
 Mbq4Nd68zMFg/UpV0CrrxA8ucnRFhDF2rQIRoeYKDBAYnwsZUIFSASlC7uEYBolEpoE=
X-Gm-Gg: AY/fxX71HPDls3Yo+pPVK1zm353oqvGvxrR9HRIAlB37E3zuir64BVI6UFn5PBKqK1f
 iYiWCu7F8LXF4X73RFV53HfK0ggBSY5fA3+4as/vxJRglZ275CKwvAYpJT5/NZUOQlBxZ+qb0FI
 ovOftf1JyQOIZTyjplZrLreF8Y0LwGwBASRB+4i4Cgze0NZZ2n67+TtCzYhhfNOh0Xp9j1IswIK
 LpUdPSOxaaaA3F2qAGuUdAU/MmYF6u5uMq0T18YDcPuKsQulqQkt4BY5Et9hDBNFgu1ZTREEd5t
 1CtA9gO14nh6v8APEEngW2awAvaGntpSy3ALWBWDTJksWh/Co1gIbIO1efBETH8B//A6K9yRDqd
 byjhGmDZE7G3TyYsLzNzqK8vdzYkBAQGOGRK6/wSncR5t8RUm1zXNk+eD0Sw7C46FtHyfhEmH+y
 Zpm42pi1zA36ZDF/c=
X-Google-Smtp-Source: AGHT+IE+5tFDZhkMa1a6Y+URC3lhlEhdGSCcnJLu/OOaperg1MED4NAzjN9KXlA9Frbvjcymr/FXTw==
X-Received: by 2002:a05:6830:4111:b0:7c7:6c9f:bb06 with SMTP id
 46e09a7af769-7ce50b7b138mr1799679a34.16.1767802948437; 
 Wed, 07 Jan 2026 08:22:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 10:21:07 -0600
Subject: [PATCH v2 1/9] mt8365_evk_defconfig: enable clk command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-1-3294a5d2f239@baylibre.com>
References: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
In-Reply-To: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=745; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Pcf5aHnqMH7ksSWkTnM/f2K4ymFL9NKvNYH6fAvNgwE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXogHrqUPXOI6AhZ6obsZtWwRK4YzY5FihIfI+
 ojXJ74VCGSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6IBxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACsAH/R+zX5H5aQ3NW8pNxa8g+eqg+TqUDuvEU9Mp/lk
 tcT/r7WIxadQyvV9kelGi0kxd2AgS13c3f3KlXo7YAFcDV61vjMLJprqKEzcf6/H3VdbM+eb9w0
 zCyaoUm4zEOWTAm1FXzmiMmA0ilAjSccaDQt0YPrMjDnXMQA1qnpW2D9jTfmIGUxq94/WiNTGBE
 F89Xaoo13P6+nlBPhbxYLvrc5nnboQckxqzMskUiCE91TchXoiLfiZXfuQg4u/cr0qeGF7IMOQq
 zjlJ+gUt93fb0lEsI0ffD9U719hdIWexIXAQ29iSwizb9tznC3cXg6To95yqCGWAEPnXRA8H9Xb
 4vcQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:23:20 +0100
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

Enable CONFIG_CMD_CLK in the mt8365_evk_defconfig to allow using the
clk dump command for debugging clock configurations.

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8365_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 7b411453e00..a9f7a24bcba 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -11,6 +11,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_IDENT_STRING=" mt8365-evk"
 CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
 # CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y

-- 
2.43.0

