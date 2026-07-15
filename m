Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4BBC44507
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4519B84D47;
	Thu, 16 Jul 2026 03:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="MtT8olw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFAC784BB3; Wed, 15 Jul 2026 17:17:54 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECB584A3A
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso357049966b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784128672; x=1784733472; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=72IFztIl76PoEobQov8yD+qaGnYVwQpvrLAgHxMeGwU=;
 b=MtT8olw4gPeAkzaD9ETUy13pMI5c0LvyV61Ko6+YzX6XfXh0bPo4oLp+zmfUzpft3/
 d/f030v/Paz1PLpSH2hoSC83tnx1xTvskAkCq3qszEl9Vkqtc+5M2gRBavCCdVrTTKbn
 UuwiS8+KXdfnwRTaXFlqvIxgpU8Z/Ho2/Q+UFz4iDnxKk97m3IvtCQC88I5tnalskhVI
 3y5aec1VIKWCIG6GSDLxZJu1SbWiiufBXk3m9x7HK9YPprKvrnLxSgzEKo+jy2f9cn8e
 SSPUSRbzgDx+JLN/hE/hfccBvI4vwrbrPllnvdIrTFCeD4m2Jcco0g+gN0r4PcP9ZG89
 4h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128672; x=1784733472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=72IFztIl76PoEobQov8yD+qaGnYVwQpvrLAgHxMeGwU=;
 b=Gdp17NW45YhT3CRRC0uR8gzcueWnvudKeJIMnoTGQO+UEM1FC4TBKGTvMYb+VdHcNv
 ATCsRdh8U2VxccbDazqBGmTKT+NgIs902ihSNSjTD3nuEbMIDArghQb9UeBKDp4i8MBM
 0fwfNqk8lNylpjTY4R3gy9Fk9QDdPAW81OGMD+KpX/VUDSN+5PHpxpBFwRnEgHiqznUu
 o1KUYCvgvBBNshvx7GfxDukBzEYa2B6Q7B4VjcD9pEKUXM4xkedp6SirHQmKcdgxiHU2
 gwbu8oja+/Z8c+WMMUkc7CF+K623SR2nbFNnKP2FKv8oxJ3hf5TywLRnuzAWfIDjKQUm
 whBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/z76Abh4jUIFFXOQNlVncVeaFrJWT0ySZ7JrlBysQl/PTYySZBwUuUR3++XvBQ2ctIkWcFMk=@lists.denx.de
X-Gm-Message-State: AOJu0YxpAbZLub6wafFwYW4Dr/mI9hDIvLqaG5ZBvonmDFJrC6e63uqR
 eHJUUC7WXn+3U3YRjiu+9D00fNR+lc4BP8N8Yc+P8k3Y8d+vL+M3lKgY4DCcOIeZ2CpUoe1itxE
 nJty5
X-Gm-Gg: AfdE7ckpBBZGTkc0EpXODCAKy8pRdrI0vQUd62hc2TCT+MgtCPNNe5XIYeeJehjfHDi
 7ARd1uGbBz27JeYUDijswhUI0PGHnujqmq1dT/I0WquSRpJ7EhF0rkD72kia4j5uwiPetRGSw2T
 OT6Qh9rxRVO1slfwMjoFQ7hny3TB2uDVDwWBzkEyZWLKEtHwvEkTgKPBM3/c4eNsuyDAzsdKcw5
 DXDahlfQJaaVxtg7myAFiMMC+iq5E18WUAjoCcLK3k9aoAtWGtFmbdhWTVlduFOdFphzknM4RCI
 Mhg+8AuaAWYGBhHESy22Samwxvk70LLV5yICdaWnvP3kDofaNIg2kygVnDd2KsbsgAuedZWVez7
 8UyZwPJfYhOkaV8PC9nD/ePujQtF0wR/JUcxseJH0wOg9jNWIGaT4ggSII8vLBhPVh4WuE6QPtO
 x+G6gqC+p0TwNlO547BVmnLVx4uRpjt0UcUMuY7QqzFi+PurLFRnyN+WzqKqbM+UyvFrc=
X-Received: by 2002:a17:907:25ce:b0:c12:2aa8:dac9 with SMTP id
 a640c23a62f3a-c161f3545f8mr994823866b.32.1784128672237; 
 Wed, 15 Jul 2026 08:17:52 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168716f6dbsm59145766b.15.2026.07.15.08.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:17:51 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 17:17:43 +0200
Subject: [PATCH 4/4] mach-snapdragon: Do reserved memory carveout for
 MSM8953/SDM632
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-msm8953-basic-v1-4-bc4cb5099d8e@fairphone.com>
References: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
In-Reply-To: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784128669; l=1220;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=uMXXuSXQzHNb3fs5BpiAeBEhD6/Su8YVen3M58LBtbk=;
 b=HYhyWrKC5pCt84mGjV/1RmCpq+zvq6zI+Axm7jutDpd7VZw7PzrL7pauZkw2DeoN/r+XU9ioY
 k8FAzis1Tu+By2B5DDEKiNNE+7Hu5dkDTVFblWMrkY8xqEJm6mzxxm1
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Thu, 16 Jul 2026 03:03:52 +0200
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

The MSM8953/SDM632 SoCs also requires the carveout, otherwise it crashes
in early init in initcall_run_f -> board_init_f -> initcall_run_r ->
initr_caches -> enable_caches -> dcache_enable -> mmu_setup ->
set_sctlr.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm/mach-snapdragon/board.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 35735f1551c..d7059473282 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -745,8 +745,10 @@ void enable_caches(void)
 	gd->arch.tlb_addr = tlb_addr;
 	gd->arch.tlb_size = tlb_size;
 
-	/* We do the carveouts only for QCS404, for now. */
-	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
+	/* We do the carveouts only for some SoCs, for now. */
+	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0 ||
+	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,msm8953") == 0 ||
+	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,sdm632") == 0) {
 		carveout_start = get_timer(0);
 		/* Takes ~20-50ms on SDM845 */
 		carve_out_reserved_memory();

-- 
2.55.0

