Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F877606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=axhD0X+/;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QHXUuF3E
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A6F240DF2;
	Thu, 12 Nov 2026 21:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9kY9b7mkaW9; Thu, 12 Nov 2026 21:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4243840DEE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518206;
	b=AlIldoDSOLsgZN259bEjYy4qzleV0waiScQpWXMqa9AoOH61Wol41rDPZQKhM8bDATD9
	 ceF32ss1WOWc7ewnIiOCfwNLj4IZN57WJNRiRBws+tRWELeL6UqEjhavRyGPm9n2P9uec
	 NSlxd3z0JqVE9k5vM6gkfSXTZtguK8O1V9aeE/Cj8tkbSggPw0sbQL699BqjoJ/U/Qlh7
	 ARYR3H8kyi0Q9n84AmrhqEjUsCv85+zXVVcQPShn4QKxVXUhSKsmpIVFZ+8ODnAguJHzd
	 WjYIaMz+HA7oRm5z4Is/ssymK1DUICQPfCTM4+5s8oBCDiP8uJ438SxS3EEKsk242DA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EEYub2gC6ftOc7xweUvQIKiBcglMRh4lYwJSxYbTN9o=;
	b=DF4zW7/9bHLv+QO+G8dPHVylBuR56U5wLbVxIepxlXRZwWltD84Iiw43ZJBz3zo38u5M
	 nV0EROGodrWB3dfcQ2dHsIQ5wMLUWHiBGeZ8EPXbDZL0r9FYbsqgJAKZJ/tzwKPGW0r/6
	 fHvEgE440cY2GwfBGTMUdM39VJPExPuH25tkhCqklBFW37dZ7n4LblUmE1ZhhdUA+WX0J
	 vMClLUF3HSsTYt8TbEDxnWetg9ls5+0KySyRL1/3QDBAd8gW0hQMFFMFQZ7jHjh06i+3s
	 R4PXUq7MGgFAVQbsk36Ug0BCqeRrUAgQ+fXbsdoSvBsmhDhbnOfHz6tkE76R7FAaOlw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518206;
	bh=EEYub2gC6ftOc7xweUvQIKiBcglMRh4lYwJSxYbTN9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=axhD0X+/e+PDcBOX36jGPk+7V3sK2dOiE668MXo1VDUPKkseWxwqvbKUCzTV+Uy3K
	 kUY1/Iq9kHMPjYXIYoZKvoHY8ki94ue4wtgGL1X0KR5LxHv0fOw7tWWf48/ux82vFp
	 85q3Y6AmRs2cDE7TU1qmVsOiRGAFfmOf5H25/iwpV/mRrnieqzftHjFeU70tx3mQ+s
	 4NE1hzoR1Yo/VblgaQOfCzEVzlu0SAY6aCoN84TQngpVNyGvIXoyqnRjfR+LOWA35G
	 KNcUrjFCf+dvAs1GoSUImXAZrQbZtapPN7k0tMMLjTnz61QlvcYot5Ck4mowCjdz+3
	 BA7MKa+MHr2Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4243840DEE;
	Thu, 12 Nov 2026 21:16:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D69941790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6EC9817A3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nF21JC8FW5Wl for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91B1F81763
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QHXUuF3E
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91B1F81763
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:41 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-861965c21faso72881a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518200; x=1795123000;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EEYub2gC6ftOc7xweUvQIKiBcglMRh4lYwJSxYbTN9o=;
 b=QHXUuF3EWi9lDKezeny2gX5mGOphusz+R7z1m0x5pamorIGq1qFiy5CMvMVF+oIW7O
 YnWahRw5kWPrwgA/xrf3Wu2SemUJp6gyp0jQmxA7nHzQjrBIaKS7TDNbuAfs1fY9b7M6
 a54Cuua+PzaHWeVIknipYgdo2Hu6DEkGALEp+w6dCNLAOz39zQHL4rT+agGCO2UvZSW8
 Ju9kFalbkUZ/QxICti09/Q8GuYIbznON4YP9ENIuxXuVHWn/M7IfoEjvdD2TXognocIP
 bNIFhk3azjUdZWF2obAMTJiFYRg2dDZ2hLO33ddMEjz/mSuO2MSs+4CLAfvdcc9BOpCo
 5H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518200; x=1795123000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EEYub2gC6ftOc7xweUvQIKiBcglMRh4lYwJSxYbTN9o=;
 b=leCeNpUE8iVF7WeEyE0CQJJnF+MvQ9w/Ywp97ZCbS4zJwVYgFtp6PW82mY3NQWpLVp
 AhpWTdWesv7YMnrikFTwEpOx1+faWgVayMaS7kK7K4/PGc0E8D1cyCa+0MiOH5S8ZgsF
 e3XB5URQkiA47TNbu4ev+CdhJIsZyM4XmfAKocOn2mGYiOYsi8WOb3bNghjrSHtVxd9Y
 ZRb6Osldkw5MNayQ0MeyYXl7HnbS4JTcczvPd6JwbLsnW9pkO/mCvYm4GfxM7Kwwfzid
 h9wTIBx0ua+rKD63vPtnYDlP9qx0BBO/YFGwi5UiCRHec0VeLwOBK7tCFaIFb+tzzcMA
 zmPg==
X-Gm-Message-State: APuU4Z8vUy/GVHixe1rkLuHeuCCNgKkFG2cbPT0tbZxZtsvTtB689Tbm
 7wkAgpQMNQXEOI4EKGets+taghEl/RUv2GqIU1+tpuWV+9M+11CzEGKvPM8XpoJbxXA=
X-Gm-Gg: AYBFou0wpHTqtzTY5aYM8w3m0bcWDO/irP+3vzmp6bXQcRuvwH7xUQYdBkTiGq1JPRe
 zX0DWCjsmIWF19mvV3Bh0A2GXlO1KdQkVcmH2CEP7dL66+SEKQLMIsejWqYvns3gUL1AcqcSpUI
 3PA86hf9Ln/lEGxWw3ntwsFs4D29+EcRa5XanY7cv6gLtuAd7s0nPgarWB9r3tjct+zz3nshXpI
 eu8ztsvrNwfA/DEl94v2czuhxreyU4sk2Pq8zp6yu6+dC5wvCs0dX0jpMljlH+CqNoXXCqs/FCF
 jnCX5qwfjmqVgvD6uhlWrDkfAXEtWHnSkljXTGJfAhSqRuu9SjaZExZ3F0H3LwJSlpc48PvVs/c
 igIKYoPGTjq22d7FpmG1Dmx2HHuuObfyMQI7nOrNDYo5LGZJ9N541gkBoZzT7pDb5XxpWAWnOxY
 oFI7BlOE6qvpAmWso6jS+Qbd/V/foZK4We0oswsihzB5esj2Eq5rPgGXhU380zFXPd3XGLsRf15
 Im+Sw4SK9vnQORxqxNX4AlOUV784d1QFk4qspDUKjaHPdOBoarPGgyjxxbFtAnGHTfAbo8qMfoa
 AgheDQVkXOjYavTlet8mOJKKf67HYCUk5g==
X-Received: by 2002:a05:6808:1a02:b0:4fb:8469:fc4f with SMTP id
 5614622812f47-56e64df31femr441480b6e.29.1794518199763; 
 Thu, 12 Nov 2026 13:16:39 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:15:02 -0600
Subject: [PATCH 07/10] arm: dts: mediatek: drop the -u-boot suffix from the
 Genio binman files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-7-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8569; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BYUtyPBclAaRjU2xLbovzIvBbm9jYKMROioOGSB+tpc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9iyK6MZKuE2BUpBwNYgapPFUMgi/F4DzX7s6u
 O0YpPqMw9+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYsihYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AXxoH/3HC1828zd48Vocq/PS7EOvW9TbERcwe+6k2BHi
 TlWe+y3f7Gh/lqJ60uOcvMJP0AhTrY+WWRuxD7xcYENYsl3aaMHsPFNo35wgAbZi8bR4OBn8grD
 mkTazjMqywDnlsgpOlHU5J58w609RuzsgJ62++tBrR+7bglia7szYJiQrRB8dWi+es4vVyWhAA/
 2+0Ucwlg8LZUUkUy9F535xB/rL/Gk3vDtkgZqW44OjwGycUZmoVAb/R5Hw7EHQpU9my+zWEgLIC
 0X0e/c1laU7F5K00U9CfYaBLnT94m/uTeDuxqP+fsHlniiF7O5uYyTcfe7rGALld9msiQ5ZgglI
 rbhs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rename the dtsi files that describe the Genio firmware images so that
their names no longer suggest that they are part of the U-Boot control
devicetree. They are about to move to a separate binman devicetree.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi                       | 6 +++---
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi                            | 6 +++---
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi                       | 6 +++---
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi                       | 6 +++---
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi                       | 6 +++---
 .../arm/dts/{mtk-genio-binman-u-boot.dtsi => mtk-genio-binman.dtsi} | 0
 ...loaders-binman-u-boot.dtsi => mtk-genio-bootloaders-binman.dtsi} | 0
 .../{mtk-genio-da-binman-u-boot.dtsi => mtk-genio-da-binman.dtsi}   | 2 +-
 ...genio-da-fit-binman-u-boot.dtsi => mtk-genio-da-fit-binman.dtsi} | 0
 ...ader-spl-binman-u-boot.dtsi => mtk-genio-loader-spl-binman.dtsi} | 0
 ...o-mtk-boot-binman-u-boot.dtsi => mtk-genio-mtk-boot-binman.dtsi} | 2 +-
 board/mediatek/MAINTAINERS                                          | 4 ++--
 doc/board/mediatek/mt8188-genio-evk.rst                             | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index f81ae1c82e2..2cc5e14a37a 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -10,9 +10,9 @@
 #ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
 #define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510 bootloaders"
 #define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510 boot chain"
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
-#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
index 249441fdf0e..00517a753f6 100644
--- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -10,10 +10,10 @@
  * controllers disabled, independently of the normal boot USB setup.
  */
 
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-da-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-da-binman.dtsi"
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
-#include "mtk-genio-da-fit-binman-u-boot.dtsi"
+#include "mtk-genio-da-fit-binman.dtsi"
 #endif
 
 &ssusb0 {
diff --git a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
index 53e06bc6af1..4bd3a87392c 100644
--- a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
@@ -6,7 +6,7 @@
 #ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
 #define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 520 bootloaders"
 #define MTK_BOOT_CHAIN_DESCRIPTION "Genio 520 boot chain"
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
-#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
 #endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 395241173a0..9a742483cf5 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -10,9 +10,9 @@
 #ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
 #define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 700 bootloaders"
 #define MTK_BOOT_CHAIN_DESCRIPTION "Genio 700 boot chain"
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
-#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
diff --git a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
index 0ee1ef3a869..1b659a9fa9a 100644
--- a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
@@ -6,7 +6,7 @@
 #ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
 #define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 720 bootloaders"
 #define MTK_BOOT_CHAIN_DESCRIPTION "Genio 720 boot chain"
-#include "mtk-genio-binman-u-boot.dtsi"
-#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
-#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
 #endif
diff --git a/arch/arm/dts/mtk-genio-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-binman.dtsi
similarity index 100%
rename from arch/arm/dts/mtk-genio-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-binman.dtsi
diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
similarity index 100%
rename from arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman.dtsi
similarity index 80%
rename from arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-da-binman.dtsi
index eb956c91a80..1e602fd9565 100644
--- a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-da-binman.dtsi
@@ -9,6 +9,6 @@
 		filename = "da.bin";
 		pad-byte = <0>;
 
-#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+#include "mtk-genio-loader-spl-binman.dtsi"
 	};
 };
diff --git a/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-fit-binman.dtsi
similarity index 100%
rename from arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-da-fit-binman.dtsi
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
similarity index 100%
rename from arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
similarity index 91%
rename from arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
rename to arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
index af5cb96398b..778b3646465 100644
--- a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
@@ -20,7 +20,7 @@
 			section {
 				filename = "mtk-boot-payload.bin";
 				pad-byte = <0>;
-#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+#include "mtk-genio-loader-spl-binman.dtsi"
 			};
 		};
 	};
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 601e1c5c89a..bd0afb35995 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -4,8 +4,8 @@ S:	Maintained
 F:	arch/arm/dts/mt8189*
 F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
-F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
-F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-*-binman.dtsi
+F:	arch/arm/dts/mtk-genio-binman.dtsi
 F:	board/mediatek/mt8189-genio-spl-ufs.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index 8a7694c89b1..4b3871e02de 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -448,7 +448,7 @@ start of the image, and region sizes include padding::
            |                      |           | 572 KiB              |
    0xfa000 +----------------------+   0xff000 +----------------------+
 
-Both DA modes use the shared ``mtk-genio-*-binman-u-boot.dtsi`` templates and
+Both DA modes use the shared ``mtk-genio-*-binman.dtsi`` templates and
 ``CONFIG_MTK_GENIO_IMAGE_CONTRACT`` settings. The image starts with the DDR
 loader padded to ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by SPL padded
 to ``CONFIG_SPL_MAX_SIZE``. The loader copies that SPL region to

-- 
2.53.0

