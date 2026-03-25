Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E5109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602518407E;
	Wed, 25 Mar 2026 23:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="abKDUwQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807E483A41; Wed, 25 Mar 2026 23:33:15 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7711D83CD3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8cd7ecedf2cso47189585a.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477992; x=1775082792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNR7MdrScMSIABDEP57VF4AVlNZj12q6IN7+UB7UdBM=;
 b=abKDUwQstnECNzKQlyJsYh2p2blfOl/Fh6/HEJRtofuOePnV+25zgArZZJfdfV01bs
 11Obz38ClLLKqnqqx3FSLfVi/pkME+5tSpSa6p30E+VDg/fGL+tTVjzZwlm7wDlopc97
 TW9h+BzJeqNFsHnUF/K9DgVbKEBV1P1BNqIsOOh10PT0W5KdfPc9fuF8ovlONCoozwXZ
 JEBWhljZxjlTg6GFzWugefkm6bHJqJcTdKkrx9I/YraVE8CMFARjGmWXJBbKbHUzmAna
 /XKtZR2FV6AEr43cf22f//Apj9/kvsuPsgBjd9VirP+uMJ+X20se+tOGbYDNFwJFp1ME
 nkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477992; x=1775082792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KNR7MdrScMSIABDEP57VF4AVlNZj12q6IN7+UB7UdBM=;
 b=gFblmBXTuk1wdkKSuq2p22mHU9wbQ431K3lKhfL5wTSiE0BxSAndiC3ruXp3sW6aGV
 GOPq2CR2JY7f8/a8hHD+LqCoUfCpvmRrAsSvg2sE0tbfju2FoXzDj0BBQcDJShfIKJLA
 +yhO42vlf5Jn9WSTkqzIdLdwlpC+HX6qXiEHnwolXVpeMx48Seh0s8xmPQTHdN+Ty8OR
 HiX4iVa4HfdW/DSWQKY5StjG1KDM3JuLh1r35hgH7YlonLFd9SbNn4UDtE9aExKh1tdT
 0yWz9Zz+OaKLkSlpbNWSQ+H6p6RrEa2tWYdMPuz7oIUoAI8SE4zIsMcA20um2CNfYDXr
 Q6MA==
X-Gm-Message-State: AOJu0Yxv40KZHEqkqnOfRm8/ObtD+p63V6jaZeIzd7gJz+seTwJRYyFY
 1ltHTlIxh2/LCgvQWseGNrhC8as+aM98Is+BuNTNY+Niqt1jeOAiAum0RxCdysH0
X-Gm-Gg: ATEYQzyLZ6mYj5GlWMVe4+bVPvPduUWxoIDMIRdBa9diHD+EZ6Fjp/DREjRsFJLWLwj
 YNDZgEDkcUqzXFzAU5X6bA7hMTsc5ikz7gduN79LNJdErZKyqw4qUlpL7K+dL5oU3qoedTnSGo8
 TFDrpxEuX82Nzszy2MI6LIdk8kKSfwuRr0LwuYj+RU7MfqMVwW+1QclMExNUjRWCZr8DIuHhfYu
 5qVyeXMWKBCQDbm/9756eGJ10ODHMs5jHsmCjPJA4veUKb3QdpHcUhGNqHCd/wU91PtP3zR5xrG
 HjVJ9bjGuQGN12yY9CUyM3NYM6ozcMDmMHed6HKmcwDblnSaG6kejgoVGZvRlqUvbmU401zGqwZ
 OkV2JcJpude/P/B3pupaBx4DQS48ppN/+MRSypqqULg+Gft85dmFYI8xWz3KqDSlb3j5huWf9zr
 tYbCiIxv4U2/G7+vgwk+sSfUVJ2sWvcgOxswH2dfDMAoRsxzj2P7jbYPHGHgO6jYWXwsdAig6B5
 V5+Og5saIs=
X-Received: by 2002:a05:620a:1a22:b0:8cf:def2:c35c with SMTP id
 af79cd13be357-8d000f212bfmr793897285a.25.1774477992064; 
 Wed, 25 Mar 2026 15:33:12 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:11 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 10/16] configs: k1: add default option for clock driver in
 SPL
Date: Wed, 25 Mar 2026 18:32:26 -0400
Message-Id: <20260325223232.1553212-11-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add default option for enabling clock driver in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
Changes in v3:
- Explicitly enable CONFIG_CLK_CCF, CONFIG_CLK_SPACEMIT_K1, CONFIG_SPL_CLK_CCF,
  CONFIG_SPL_DM_RESET in defconfig, since CONFIG_SPL_RESET_SPACEMIT_K1 and
  CONFIG_SPL_CLK_SPACEMIT_K1 has been removed.

 configs/spacemit_k1_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 9d7d1041247..cbbdcec73d1 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -43,3 +43,15 @@ CONFIG_DEBUG_UART_NS16550=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 # CONFIG_DEBUG_SBI_CONSOLE is not set
 CONFIG_TIMER_EARLY=y
+CONFIG_REGMAP=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SPACEMIT=y
+CONFIG_CLK_SPACEMIT_K1=y
+CONFIG_SYS_MALLOC_F_LEN=0x5000
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
-- 
2.25.1

