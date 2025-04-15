Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6348AC369BA
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 18:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E5F82B4A;
	Tue, 15 Apr 2025 20:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XkA/3bnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E66381F7E; Tue, 15 Apr 2025 18:24:30 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F8081E14
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 18:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so48105435e9.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744734268; x=1745339068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DCRKdw+4YeAZFGN3liwpk9DXiweOgOfIm/Wbhz2aqM8=;
 b=XkA/3bnvJPMSMQIl08U4N4ghdwckecsC6JB84TSPE82N3LbGC1Rm9Firyk5BM5mL+r
 Clsq+tGvyi+0SWCCcSWwoLru1SAhwGclpoE0OLmE+anp8R7JF272MV8Z1sRJHIPX8Hy9
 pfq5Tk9HbnWoz0yxkCkCTa5gf37xYuvVhu43HI2n/mXMg/auSvGlf3lSkLNYeqxzRxN5
 RQnVccVch8hSDk1eyESp9q1BoGngHorJMDwCNEbqa5XKiqsHykS9WWPOBOvV7rB7kL/l
 LIjxaeQRD0DCIFZYWn+AQAwydPcfsJOPdq0/Knz7W4QP1mrhYHOSiQqrM3zpk6zm0ylE
 6vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744734268; x=1745339068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCRKdw+4YeAZFGN3liwpk9DXiweOgOfIm/Wbhz2aqM8=;
 b=gS29hnO7L84rMzbj71JlOsGbX65mTwx5zy23uTSzkRVQOKpXsXhdzWJ5APUuznaM/1
 2FJ8Suuw8q5iwHm5b+oYubn5HdLgko/zSQaz6IrZ1E/MTCo1fy6lmiqsugxrsl0tlAhH
 QnBollTBfgaa30t0YikztwBwmRLUBnMrOiJQi0hQLlCCQR85lIeak1nlTMpmfwkubzkq
 1QL/UUrRsOlschLMp1CEVQpfzfxQlujg/JfhJYx1/djVLIdM2hMEEM34SaLTgSBf5dOT
 XLKNSfg5G+4v6xWmV/OvihYYInNd4sLG7gDi1a344PG/1Pe/jA3pHfHCtBYF0ppreDD5
 kQrg==
X-Gm-Message-State: AOJu0YzZo3iDLesHAvtr+lem+vYcPYbodfB6HP/dDv0iYqi61MzBdItC
 WCxLmOi4jn0/qbK9ck56MBa19e2tQhUDoi3MI+7tdvICQ7Xul/qIBWMVGgek4To=
X-Gm-Gg: ASbGncs6P1n9COTHw61X05cxxoMpjpGu11HUv6EoqGdF3ocLa1Qlej6If9DKDTVQkPS
 HZEjOwQInaMFDYO7eKvoxzdsP3tb1p3SjZoi9MsV7xNL4l8iFfV3fZDdg1IHQ1mUS9BTYMEyzPB
 V1OSE+a4Un8riVbpjWxVjXmlYIy21Y+DXzQrN48Ejco8Nx+ceEGSP1bz+rifVn2z2F3AIvVma62
 Dzdf7cPH5rLkivwZq/3BLkbbpZS6MzEOzk+niS0BCW/7JamEDQeEmCghuA7TNLBiRglJhe07gVW
 +RLLgzlNBIewHBqNRIjFBqcY24iY/pBG+ukdTfa50N1VdM8tAqcjJwPD8+CLLsKHRfkoNKSHxpA
 2XiG8j9jEchj0NSU=
X-Google-Smtp-Source: AGHT+IF+ncpVzsOO1H9DxjGhbagbdgaSOoJ8F2qNMLIcmNp4S7U3tS3pk9ALX9lhLUFwIeuIR7gUlg==
X-Received: by 2002:a05:600c:3b23:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-440597a14f3mr872385e9.5.1744734267821; 
 Tue, 15 Apr 2025 09:24:27 -0700 (PDT)
Received: from localhost.localdomain (i5E863ACE.versanet.de. [94.134.58.206])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96407esm14835197f8f.17.2025.04.15.09.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 09:24:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] mailmap: update my name and email
Date: Tue, 15 Apr 2025 18:24:08 +0200
Message-ID: <20250415162409.4548-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Apr 2025 20:16:52 +0200
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

Update my name and email address

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 85086602cd50..717daa9adc4a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -34,8 +34,9 @@ Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <bhargav
 Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
 Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
+Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
 Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Dirk Behme <dirk.behme@googlemail.com>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
-- 
2.49.0

