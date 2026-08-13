Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84290C5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 11:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 457DF409C7;
	Thu, 13 Aug 2026 11:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3FYmgoXOizKj; Thu, 13 Aug 2026 11:45:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83FD3409B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786621507;
	bh=JuedNv52p6M4xkG7/yx7vmRYp285wUEUZWa6nHPjA0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XABN412jk3XXUFFX4Sl+CUGgoZ/w/bExY8pKLcNpzyPDQRgum6mh55CRhmJ0arhkz
	 6ADRgC2TNmtF2uCfSjO+lzeHVIlLnpdTsExsPzqVP2ud7TH14HXBsHBojKtA1mLujQ
	 XDZIkehJWWSr/o/tAmPbYxVjHkQFcviXouJw3SlmHIVho/sCRFJXY8SYrP0nneMRY1
	 ANC9ZU+gT57PIdk4E0SurIASRdaJPtLVa/h2RW3K/FObSfEReKOYbq8JIbAIpIRJFS
	 i4AnIG+9O511PQ9YTTDaCywuVVlw5p+F15klfonk9DWynPTc3cXAHhsudawCtNMlqp
	 OFNo2vwrrpvqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83FD3409B4;
	Thu, 13 Aug 2026 11:45:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A01D53A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E9ED81271
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 79wERRZX2X3b for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 11:45:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8584381168
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8584381168
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8584381168
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:45:04 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso675832b3a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 04:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786621504; x=1787226304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JuedNv52p6M4xkG7/yx7vmRYp285wUEUZWa6nHPjA0M=;
 b=Gd6E2kTbG4g5sTwumFquYh1e/+dyr3dLN39WUQOU/wdYgPPcrr1Om92OfQhAOhfewK
 GAUxfeqNoNBwAXDtxNOQSrNsiWq94croqaq7eIz2kbTrbClG/nBALDfetFIImZBlnyy9
 3iG6Lq1oUq6IxDWPfyWf72ih1R5qsJbWIPSxNNwXzxqYZNf9PVWh/Z+tmGLNjKdZpHaX
 ddpUV8glRkV90bktBFNXKdv00B1SdWrREjUxFPlH3VEptvxhLTiSWwG8NG9H1qMzeC1R
 8qwOFQadXbrK0haj58NRDtNcDAiSBtcuAhalrxtYt+Q0M0mmGjixX/pZfn/nbFoyAvLR
 NMSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RppcG7YzkqyUUn8M/NHuDTA/o8x27Q39g8jVJRnK775sBJZ5gXplvPGw6h56wJ1JDWaACt8yic=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YybFqySYm+1GcBhefOkx9RDJah+7VC87085HOLp5MUojl6RBNjk
 htzXN/CADrm6uGeHM+0J5ntK9k8nSOSWlPg/t1o9d/MgY5Uubd9wbIv7VO63Hw==
X-Gm-Gg: AR+sD13K8jqfi/IuY16pkZmTpVBKidU+kLOWX8gWhx75aLbQJuzrKlkJ9Jce76Uy1KY
 o0dorJF1gZ9mHiUzukFToyvrO77sWBYrw4CjuNR38Nk/fT3dRBzCVs2qwzI9l/WAK6bGHKsw61g
 p5XBuKaP+otRunWNbS9RIyRIebl9a1pVfIm/IEtCydx+6JXhJrcKHDlkCklh70fBJZjup1kv5bn
 dH6uS19aj5RifQiv84bt4KyOFQ0YZfQdULz/EJjKGUvQdb8hk6M2Yg0kzEDvwfcrA0WRL2rBykK
 Nl175uSUOcXERmzQn2+sAjzuwVge8RmZEwRrD4uzgXKkGbGZHavcRdZObuMb5t2qqheVGWNdadc
 b8BAKkgL6hcYmdedGF7m8Vxv5pBAlJdfWJuoJBEU7hmI6nYh4+/OdxhIWdXbZdLwu2u1/+NWB/H
 F314tsMFnLlyssoZbIiP1mC45qNNYIJf1YtAnWAo1zvaXMum8VjZetfpPBqtLpNB+3jqhFvRSqz
 ABQWufRTXjQbwTi1E7+hhR9DEki1jzA67+lEOd8GyV0OM/1
X-Received: by 2002:a05:6a00:408e:b0:845:dffa:3740 with SMTP id
 d2e1a72fcca58-84fc749343dmr5846070b3a.4.1786621503514; 
 Thu, 13 Aug 2026 04:45:03 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:b2f8:f8b2:9607:d599])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721aceasm918764a12.25.2026.08.13.04.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:45:02 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 4/4] rockchip: roc-pc-rk3399: Enable redundant environment
Date: Thu, 13 Aug 2026 08:44:45 -0300
Message-ID: <20260813114445.51640-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813114445.51640-1-festevam@gmail.com>
References: <20260813114445.51640-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786621504; x=1787226304;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JuedNv52p6M4xkG7/yx7vmRYp285wUEUZWa6nHPjA0M=;
 b=UIyIFJ03GTenW/NUbMV3Yy0lH/iVsMl0D5GgSAiF1imaDFE1aO5vNO2cZLx7aTu8Bx
 bFMSt9N+/LhdVwqj1AxNLRMW4BunN9btJapLsPvmHknKu382MovP82iFKXKsxyMduRHP
 0mHjOIo/54UiJrvc7Vc9nocpYdWTutyEq2tU5eeVwoA7g6+PJjuJ4XzsGXryKNmH8bke
 zpul4mUxx9i0lMzGXbf7WFH/cHRIyHfx8oHzZN3JFJ0VPIk9r10zon1tjXhxgImVd+zY
 6YuvcSXHplrkfM1B2Rwqkhu2tX2fERTGXf+93G84H2k2EAS4xWbw4t8TdmvJYhsqlfuj
 OfNw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UIyIFJ03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

Keep the primary U-Boot environment at its existing 0x3f8000 offset and
use the preceding 32 KiB region at 0x3f0000 for the redundant copy.

Both copies are aligned to the 4 KiB erase size and together occupy
0x3f0000 through 0x3fffff. Redundancy protects the environment against
power loss or an interrupted update.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes since v4:
- None. Only added Quentin's Reviewed-by tag.

 configs/roc-pc-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 53182dc8251..4347bab598a 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x3F0000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
@@ -41,6 +42,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="rockchip/rk3399-roc-pc rockchip/rk3399-roc-pc-plus"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-- 
2.43.0

