Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8065EC52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB8A88CC3;
	Sat,  3 Aug 2024 13:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5AYN3L6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FD288CB8; Sat,  3 Aug 2024 13:13:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0F9288C45
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42808071810so60729375e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683581; x=1723288381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tC3dNRzNq7CjnMBIr7rZa983im6oFnKGNQ4Wa71cjCA=;
 b=I5AYN3L6RpMngffRoo9kUrE3/EjJ4ibYCTc+5iPJZbyKl6dbsZrSnshOb4AaKyYF6h
 hqU99VeBD53EuEQm7fJqUy2/8gq8wjA004WOLSSskHHLUWR/oRmai9qf3Y0EpFZ/IZyn
 v/zAu8XzrmxefGgxBUjo2/y2LIg/zTyq7IYiJREzl2RQwrE9OiYAiWHN0cSC5FRURAUo
 O5ltK/NIKtuqW+diXgw1usJ8pDqEf74bg4ExbV1It4vz8BdD9lDJ1/CVJ6+ZVyyTmTQh
 rfY2EhGOlTOYTi7L3oy5LF915OudsP5pnWQAzE/CB/ZCtDCohlHziXrQZq81nQqJyZQD
 mTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683581; x=1723288381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tC3dNRzNq7CjnMBIr7rZa983im6oFnKGNQ4Wa71cjCA=;
 b=dz762YyR6JO05qqiOylZRPUq6zi1uHXa8g2SIM3lJfBUx7z9CbDX0w9SR+WGKok3kP
 eTcgSsA/pI3xP8ZVbObprXq0dZD4XzeRrdf6rDrFBsoS90EkLRhiXHY2mhNFsqW5FKNv
 DPJEyX6B5q+xUnjVFUwXs7V7+H3m+mi8PHq7gabGiIWigj06Oa5my0vRJvMjZSIgfB2W
 vU0DbRl7+9R9Jjm1my7T2+kOxqefX9w08pY/zRuX7HUlKx5N8qeihNKzXY8XZ1MpuBFn
 A0hey2fF/gUbRVTqQZUo7V74dQP6ivvHalsKvVNjGnSRNiurgENWdKJE8KvfTg/IJsRx
 I9ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/tQNUsT6ZSR33LOguAp4oyVspFOVWcYlW64wO1lvCn7CiFw5FT+uKtDrHHMXm7txxhHKf9/o13RmBW0s/bmQsV3iBhg==
X-Gm-Message-State: AOJu0YzBFitkZ/ATXFugbczPeubXzEAax9xilWKn08LHN/I2uwVdu4Mr
 JXsfdB5miaTo2GGIizxbZwMFvZyVLA6k5bLOU1xfltr0x4YUskPWUdzYcA==
X-Google-Smtp-Source: AGHT+IGBJC6yj6ZxlsvC20k5EwDepuYA3ilRHtr7TeWGIS0EnaKSSNhvGZj6ZjR3n/ECaL/t+Ef2fw==
X-Received: by 2002:a05:600c:3103:b0:426:62c5:4742 with SMTP id
 5b1f17b1804b1-428e6aeb035mr42258085e9.7.1722683581085; 
 Sat, 03 Aug 2024 04:13:01 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/8] clk: mediatek: mt7622: clk migration for OF_UPSTREAM
Date: Sat,  3 Aug 2024 10:43:18 +0200
Message-ID: <20240803084329.1688-1-ansuelsmth@gmail.com>
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

These are all the required patches to migrate clk and correctly support
OF_UPSTREAM. This will align the clk index to upstream to support the same
clk implementation with downstream and upstream DTS.

Changes v2:
- Fix typo in commit description

Christian Marangi (8):
  clk: mediatek: mt7622: fix broken peri_cgs clk with XTAL parents
  clk: mediatek: mt7622: rename AUDIO_AWB3 to AUDIO_AWB2
  clk: mediatek: mt7622: move INFRA_TRNG to the bottom
  clk: mediatek: mt7622: add missing clock define for MAIN_CORE_EN
  clk: mediatek: mt7622: add missing clock MUX1_SEL
  clk: mediatek: mt7622: add missing clock PERI_UART4_PD
  clk: mediatek: mt7622: add missing clock PERIBUS_SEL clock
  clk: mediatek: mt7622: add missing A1/2SYS clock ID

 drivers/clk/mediatek/clk-mt7622.c      | 104 +++++++++++++++++++++----
 include/dt-bindings/clock/mt7622-clk.h |  68 ++++++++--------
 2 files changed, 124 insertions(+), 48 deletions(-)

-- 
2.45.2

