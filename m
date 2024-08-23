Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD8BC5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD1288ADC;
	Fri, 23 Aug 2024 15:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zTs5OsjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7490E88A2C; Fri, 23 Aug 2024 15:49:18 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9711E8890A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-371b2e95c34so1101593f8f.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420956; x=1725025756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpbosyhlpRV3kqLXjV99Gj/U9ZaNJ/exWx7NDBToF6A=;
 b=zTs5OsjURMt7AD8wT2YkPl+F7IDgw/G+6QDHOhEHdagx6G6l9td+tzLNYpZEUydb0k
 qncUPpRE58Oys+BUqyTVkB6tGKaPHpzpGpyQ0WxUqVlc79+BMH93Ciie1kAEXV/29//N
 EHKT6v8GHC+/7T/YfassTq76pgFzBmR9Fro3D3p2kr4aYapWIRIeCRY4U1/0LjzM8uZp
 VXuOLwjT3XYOEmTx7pSBnwegDAPKS1rSSSQ5HO0AwHfgK2RLnHVspW8m329iW13kSofo
 lhCgxY76hyzjLx6poDqEevoEGjJsTDZ5vgNanTxFNsxGWY42QA4JKUTN+lM/y2uXNQzR
 yN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420956; x=1725025756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpbosyhlpRV3kqLXjV99Gj/U9ZaNJ/exWx7NDBToF6A=;
 b=S/Bt1XGs0/yfHptaGLC8SjU/jlS53wV/6PdiIhs1uR8XGKJUyHfhSTP3HR1U//xrgr
 IQwycHkN0zdTXBQ0XvNU8/LZ4vMiB4S1PvNnmiHZTDZ/SEJz0ZJyFUuCbZ0xjyv+3aKK
 zpYZMNDDGQ0w1oiAc3RdAyK9drIjUI0odF1XzdzWZwp2bRyoUx6cMWOJPioobfC+glpE
 Y4tbSpzim+KUCaONBeZwqJ/KS84nz+wRp+Ui5ThSfX4icACkT5ACEFuq5Q/SVH0B/D/A
 aJd2rAtTZJ9YHReiKsnDlrmCHjz+1gOpPnbH2rmizeEE91FeOup2ea4HQNlJZmVRWSQj
 cXzw==
X-Gm-Message-State: AOJu0Yy5AcBu33pqBZ/isy2Ub51HQZK3euZTdaSbOM9F46T04L3ilAkK
 GfI2wZZjTYVr4CbTYxIDaMLevFidV1yVt5Sj52trEYuaFanDJrM6Dwy4gWS3aXcbzwHdwZNPFE3
 OghmiA8Bd
X-Google-Smtp-Source: AGHT+IHTRoHY7sxvRjMNRUdvhqnHcDBsTcKyXaNe5LKZ7oKwkwSWCEkEE0wG9tvCWrd4vHB9lTaoMA==
X-Received: by 2002:a5d:6b03:0:b0:368:12ef:92cf with SMTP id
 ffacd0b85a97d-373118e3735mr1701766f8f.48.1724420955799; 
 Fri, 23 Aug 2024 06:49:15 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:15 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 05/37] net: fm: call dtsec_init_phy() only when it is
 defined
Date: Fri, 23 Aug 2024 15:48:09 +0200
Message-Id: <d9f7d214a9eb63947613ad6a129cc27ce6d4f44e.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

dtsec_init_phy() is defined only with MII so add the proper conditional
in the caller code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/fm/eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 19f3f0fef07..e4ec7696939 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -701,8 +701,10 @@ static int init_phy(struct fm_eth *fm_eth)
 		supported |= SUPPORTED_2500baseX_Full;
 #endif
 
+#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
 	if (fm_eth->type == FM_ETH_1G_E)
 		dtsec_init_phy(fm_eth);
+#endif
 
 #ifdef CONFIG_PHYLIB
 #ifdef CONFIG_DM_MDIO
-- 
2.40.1

