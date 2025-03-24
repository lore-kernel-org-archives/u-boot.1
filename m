Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E570AC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 23:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4722880F70;
	Tue, 25 Mar 2025 00:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G20N3H53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C7C81026; Tue, 25 Mar 2025 00:27:41 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD175808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4768f90bf36so48240051cf.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 16:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742858857; x=1743463657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H6MT1JJcnzBTX3GOdms3jPhXY0p/54hzpZyJIRC1i/A=;
 b=G20N3H53IkkOLViN4BjPGKlFjFqr5JBIP6s1RbeJQnbRJBgCw4EnHwfMgGzC97uNUw
 Jef9msSeI7DPjp5we9hlpoVxQh+bPCnqnzEZvOGhFknRKLzuzSDFJA9tJA2qOuUQsQnE
 8Vn/tjJxNF59dGCEEpTliLYy+7ZGEokEjqjSTkk/WMARDQcsyiNkorcB5fhtCCeNLzMu
 AaJw7EjaYQJyHIi8dP827qmUAkAJ7tlS5C2oG5EKu+jXdWS2Mj/i+dQc7wvutEF2p/Gx
 7XMi0ACCEbB91P/nCxe5mdZR6r3OSgdu0ELq5oaYTrSpEPcMaPvF1d3jOkpHZOTIUJJ7
 oaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742858857; x=1743463657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H6MT1JJcnzBTX3GOdms3jPhXY0p/54hzpZyJIRC1i/A=;
 b=nAlP8zK3g5hr+jLmIKS9gsQ+GHxRmYeG6x+Tv6Ac1m/Bpe+4GBBemHyeF4Fzp/cdM3
 rYVESOvs0QQqw5+eSrAvxvkaC0n2bQppLLfNhSY93wTZsGmo5h5GptngvDHQHA2M2AEV
 bAMTFMU5bjX6uLxJ9PWpNSotOjjttwVXansqBr+zDT2VV9cUY/0Ua09GbnODhzm/OFa2
 Wy+yAwKLWXV+nbjkRvUxoXpwoZebiv7Tz8vsHR/6xibtyNhAe2OP1SgtBAPpqJBL26XJ
 SclduoW/EfbNXxXyzW9dIZ8WSVYOFL4/K5h8jXAPiO9eFe+kmv/N7TpYx4FNfuQNJNHW
 1vgw==
X-Gm-Message-State: AOJu0YzkRhVEJdPUIhDvS0D/ZBNQxgBCX8wQ4NgtkCClo3K3H1lJreUA
 u/IoXe5i2CAZv4/b3bBceepO44cwW8Q7Mi7bC0wApkB+qy/e7WjA7cZYew==
X-Gm-Gg: ASbGnctRNQhrGrv+G4nMiePqeRpT+Ep4w0ZkFfww1qpdmKzIAUx/fGv6Z8NphCFLRdK
 ZqvHg1iA3HGz4uWnhyp9f6Ize5oBgln6W7NkUvLnfXLJGoGfqelAv6pViqaBWomReQgMYPsixK3
 4XyQcDwnyZ/L4Q6hfy69y8GnBz7FBLk1IDS2qOdE2rrnkBb+/vBCnzedYXWFFsBZd6ct6hchCab
 O9luOStLZJ9WwSeg0BmcQ8SCcFLO8M6+6yTOfMe4fMd+o4m/ysGmCUFrnToLIYLbNWxg5jYGrNB
 YYBPACsMndg5e9ACdtCzEl2AzMNBtDZ2WDdO8/I+ISHUf23+35xaKIFIvanihmizLAKARhbFmwW
 2VAp+Wl2PdLNXheUXl9I=
X-Google-Smtp-Source: AGHT+IHQDZl0EwSBzRciECi1X4MS324QqTg2jHmTT0v0sXSqRSBwE+zUhUQtgRRm3dfA13GlIX9rwg==
X-Received: by 2002:a05:622a:4c8a:b0:477:41fa:1120 with SMTP id
 d75a77b69052e-47741fa12b2mr89069051cf.12.1742858856928; 
 Mon, 24 Mar 2025 16:27:36 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d18f7f5sm52763201cf.35.2025.03.24.16.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 16:27:36 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] board: beacon: imx8mp: Fix GIC clock for Overdrive mode
Date: Mon, 24 Mar 2025 18:27:25 -0500
Message-ID: <20250324232725.859935-1-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
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

There is a config option to run the PMIC at nominal voltages
which is not enabled on the i.MX8MP Beacon kit, so it the PMIC
runs at overdrive voltages.   Unfortuately, the check for this
condition to set the GIC clock parent and rate is backwards from
what it should be, and accidentally sets the GIC clock to nominal
if the PMIC is in overdrive, and sets the GIC clock to overdrive
if the PMIC is in nominal.  Fix this by inverting the logic on the
check.

Fixes: ab53bd43dbde ("arm64: imx: Add support for imx8mp-beacon-kit")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
index 6b357d90a3f..027fae38278 100644
--- a/board/beacon/imx8mp/spl.c
+++ b/board/beacon/imx8mp/spl.c
@@ -50,7 +50,7 @@ void spl_board_init(void)
 	 * setting done. Default is 400Mhz (system_pll1_800m with div = 2)
 	 * set by ROM for ND VDD_SOC
 	 */
-	if (IS_ENABLED(CONFIG_IMX8M_VDD_SOC_850MV)) {
+	if (!IS_ENABLED(CONFIG_IMX8M_VDD_SOC_850MV)) {
 		clock_enable(CCGR_GIC, 0);
 		clock_set_target_val(GIC_CLK_ROOT, CLK_ROOT_ON | CLK_ROOT_SOURCE_SEL(5));
 		clock_enable(CCGR_GIC, 1);
-- 
2.45.2

