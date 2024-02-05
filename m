Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013AFC48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 18:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00DA987A80;
	Mon,  5 Feb 2024 19:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxSNxRBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0FE879AF; Mon,  5 Feb 2024 19:59:06 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9718791C
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 19:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so20006b6e.1
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 10:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707159540; x=1707764340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=prqPIZMG+nw2mX4Iz8TiQmfnXWa7JhNORXpHL3M43K8=;
 b=kxSNxRBBwvhWdowSGCM0pPfW86b7KjFi6xWAj67FOVstzcrLSk9ZJrpCCJfRXpzvQ4
 1XmaYuRrrGx54QB6Sh+5FPokq6pZVByHbCOaOM/b2LsXF+Nj9Z89oZYsliB6gDlqmv2p
 s1/5VNVVu7TI2yoe21SyTcggAG+XcjhVBGlHUA+vG/dl3uy1P+Dz5fkkLWVfuIYOm+/6
 bgL0xCt0BuRCBn3IB+G4KpdSiv3XIyAdJgGhl8vbayxDIcnJC2H585T+uAjW61Nq/UrG
 mt5EojsEXsVNQOvFfKeSorvHxsxHGwWPc9LLuT6kSW/JyAmGc94CcbWGO8nbKX0QUYxS
 +1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707159540; x=1707764340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=prqPIZMG+nw2mX4Iz8TiQmfnXWa7JhNORXpHL3M43K8=;
 b=pEuQ76E29wYV4FqZfmhYreqnz2Ry8ZGJ2CpAtrYs7117gn4zUHdi0tHudQ8OPLbYdl
 kYYGQxPzypUZ8IU78gXFX/uy8yXQJW0dDgZrdUY1jf2BUgNFc+GAcdUFqqEGNwGnMiTI
 772mwqR/i6XwxQDs+4bOAjooRt6jBFGFKYt2eEIaDZGHXwhb6Ce4suZiIFzKgaBEYUzc
 0RIUXnD0E/ahEO5yOaFmYr39NbwNFXn2huVd7+2eenbBwT4aB+zHqyEmFQx0Oz3qUIe0
 ep5nnF8lN6VTAk7Mo1+m+heGwNIorP7kPIgb4XCRRdMQVS1zIuLr5HZXGczT+nuvRahU
 LH1A==
X-Gm-Message-State: AOJu0YzssLLFU6wq4R2qkUtxIxdbIlyOCPgAjFtM0E1klc3BZdGT9jj7
 ocC6VrYW2pftJ51MUDuntDMLf08Vx9iaRJ/Ypaem4bH6K57OHrt4k8+EYNfj
X-Google-Smtp-Source: AGHT+IFuUiU5w+p3z06sWCwCus1UhdSvdDSCAnUMYdvOK8g9xlSRzJVkTZGym5vqcDLlJ1SfambXOA==
X-Received: by 2002:a05:6808:21a5:b0:3bf:dead:30d9 with SMTP id
 be37-20020a05680821a500b003bfdead30d9mr646014oib.44.1707159540043; 
 Mon, 05 Feb 2024 10:59:00 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXzXzrw8M7Suk6bJsL44K/ScZQ20D0ZKf+ys/zA4wXECIAaescdVVNI8tpiemX1Jy+2iS0gu1iiJNuWloJpZpcIX80LZ5Mfo+/CU/S7UpwX5AfOEqDRBpnaFuWbGkwRXihTWvnPqkL0m7NhnSx6LaSHmPKfVQIUVMjeTem4w7OL57s02we131BMR3JRSN1Du6140ekZiqNxFP72kurvX7og
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 cn22-20020a056808351600b003bfdfc7e5d6sm65692oib.42.2024.02.05.10.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 10:58:59 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jonas@kwiboo.se, jagan@amarulasolutions.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/4] Add New Devices for RGxx3
Date: Mon,  5 Feb 2024 12:58:51 -0600
Message-Id: <20240205185855.21508-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Chris Morgan <macromorgan@hotmail.com>

This patch series is to clean up a few issues found with the RGxx3,
add support for a new device, and add a board specific ADC button
check routine to the SPL stage. The ADC button routine was part of
a previous patch series that was partially accepted, though making
the ADC button routine board generic was rejected by the Rockchip
maintainer.

Chris Morgan (4):
  arm: dts: rockchip: rk3566: Remove unnecessary clks from rgxx3
  board: rockchip: Add support for Powkiddy RGB10MAX3
  configs: Remove unnecessary options from RGxx3 config
  board: rockchip: Add early ADC button detect for RGxx3

 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 31 --------
 arch/arm/dts/rk3566-anbernic-rgxx3.dts        | 16 ++++-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 72 +++++++++++++++++++
 configs/anbernic-rgxx3-rk3566_defconfig       | 15 ++--
 doc/board/anbernic/rgxx3.rst                  |  1 +
 5 files changed, 97 insertions(+), 38 deletions(-)

-- 
2.34.1

