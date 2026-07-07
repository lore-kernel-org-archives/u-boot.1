Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97194C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2304884A90;
	Tue,  7 Jul 2026 21:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZQFA9lfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12F184AA8; Tue,  7 Jul 2026 21:12:15 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA6484A1F
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-495ee8e807aso2142855b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451532; x=1784056332; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bPmxDHVgoyTA13hQ1bGF/yEISAC8xXDR+1lcS8avajo=;
 b=ZQFA9lfM98WZqn7W70CkMSnWBpQ5IIInSG1jbhaWm5ftPOWq+9t24TLW0xxL6cipU3
 r8jQnU3ksa3nnENbqUvMmys9TRcEICYvVdodgysLEgTjbMltLLStFMf3UfJxTd5EvOtR
 D2IqRkMn2t/1K/YptPhUzfiTvPCHKWcDycjfk/ae/4w4hc4agVRHfZgLBeASUpg2GMFI
 fV4Uar8GFB9uWNmt8yD1zi7NBJF+e7kfrcpnx9mDSXyC1h1Se7f7+PsrHXtZtfcyNaoR
 pyY3gVAwqJsCdb3tkt6WZngZ+xNPDNXGbtPb+s5VYoZ23kp5+GPNl40drTIAHJEwtval
 LO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451532; x=1784056332;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bPmxDHVgoyTA13hQ1bGF/yEISAC8xXDR+1lcS8avajo=;
 b=mYIiEWRW4y/8rFSsjKHcFzzGrlgr6/NXCq1k5kziHgYKbBXw/yboU/ruaBPHKNHMMD
 ei3eXPCLf6bx1BJGusOoe7EZzrL1nGB2Ol3dQ8jw6uIvgOw9OhEzXYlNS2pSLwOC193U
 UmSMd4VHX9OVXMcEqeTCQXG6ba+UtX3qDjevtHxdxb7/iYIP2TkMS+ohagdwNcoL2CtH
 3FCOQ+5kloWCnrR0hQMc2OxbvX/XIoTjYFN0ucufwjxdYkvzTp60TI44y6i9aGQUk6d5
 HrPfnUE0ujeyUGJVvnnEfW3qHe5zDohLozomrTocw21adJaTZ8qzNqTCumedwDonOfet
 s5wA==
X-Gm-Message-State: AOJu0Yxhb+QAwv0A0ycm/OV4VunbumRKMXhHYqEY0Wyiqb9FwLW61wkA
 WohogWAdAOR/fKlMe1Og38+0UsEWrMljmQXgATiGDK5Ro33JF8aavtou8h1Tg39GZww=
X-Gm-Gg: AfdE7cnxe1kteUpTjMNQHDnI3zupKzP2JXxcfj/BGPCU7yermOPVzO1b4FA29c7iBMP
 OOdF/soG4KPcOcRn2AHPUo7zYHnxrrsu/qNpDOPv6eNyIfxcwubOcydw5DroUnUi8j+K36sh5Jp
 h/Tfn8bvXQycN/gkLKnbXHs5XTtdi6McR+YqYpKNuGiVuecbRf9GoFm+fWawX9nG378mu+cIIKg
 PFIVQNfvhd1WtjaEY0Y5VFq0d3HHLUVf3AqVVtIJa/1fHhpgF9sEFrvZH9YBohxS5qyyaXYGDx2
 ow1TF/Th60DLxhfnI3y2CKYJzGOP/PHG+w4qjyaDl323HehGO1/UMWJPk8hUsIbX0m6ruIxKcS2
 qlCcD2Rvisiea8Qza2/bWUweHhs1JNUESg2NdRdYK97RSgcQMd0/qq0U4mNX6eFixbLHO96BtZl
 7CQDQwwlwnb9GQQX5XTXJqlCm1IvZq
X-Received: by 2002:a05:6808:d4f:b0:493:a850:d93a with SMTP id
 5614622812f47-49fdba33d3amr3989848b6e.6.1783451532301; 
 Tue, 07 Jul 2026 12:12:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:13 -0500
Subject: [PATCH 11/15] clk: mediatek: mt8195: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-11-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fqu7GFBfmMIPeUuP+lRVYQkBbWx4Z1xxswYQBlin1lQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU9bZCmMciUu2WesmDyj2EG0Or77bClW4RLsV
 /HfpiZUn2+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PWxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5WEH/jkLpmHsZxEcjqW7cAhP5RiMQSNcTVcymemTr+c
 wNPoOXBPMQW0n01dXCA1+QChdHzDglwhQ5/GuT6Nv+6Ux+SB4uDNoNey5F6KdXKdjhXBZ07EH5M
 uHTg7JfFn1QolTZNyxxs54O0FHnboXKFME02ZNOZ/druC34orjVhzKw4YB1xjY/e7DoD3N0/z2g
 WwLjDJS3IWFYFEYZjWSSbL9iWg2DtGtGtCxc12ElcmF6yavTyRhKfj/x6Ciq69nJY+9sCi4/Bms
 34X2yr9zM0LFMpfMTmMoh5FEho+DEzCJF12YmHUVOz59QBYm2dZL1UA6QzGlkZa3pPXFpt/FifS
 a7Ew=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change driver names for MediaTek mt8195 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 8763c837781..3dcd4bc6962 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1633,7 +1633,7 @@ static const struct udevice_id of_match_clk_mt8195_infra_ao[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
 	.name = "mt8195-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8195_apmixed,
@@ -1643,7 +1643,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt8195_clk_topckgen) = {
 	.name = "mt8195-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8195_topckgen_compat,
@@ -1653,7 +1653,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infra_ao) = {
+U_BOOT_DRIVER(mt8195_clk_infra_ao) = {
 	.name = "mt8195-infra_ao",
 	.id = UCLASS_CLK,
 	.of_match = of_match_clk_mt8195_infra_ao,

-- 
2.43.0

