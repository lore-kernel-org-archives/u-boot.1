Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD93AC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 17:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9585807D7;
	Tue, 11 Mar 2025 18:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iFiYhrQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377D981335; Tue, 11 Mar 2025 18:55:48 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1293C801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-30761be8fa8so64695101fa.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741715745; x=1742320545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vUanRaCN6JEcz0BUNbjbD8IBB1o0+DMN6l9Xny66zfY=;
 b=iFiYhrQOxmk1/xH/w2eejD8J4G3KNMFPWN+Dw04lxjd3oBqz6cKJyCVLbVSjHGDROF
 wQaPE0ZgbMfdPx1+CCDFq88P6HsyrJKPuoNkZ5CLEDym4uklmO9mImprw5HfHGihc/tW
 qOfhHOWqjQVzI658g5bfm+9AwwN/q6UmsKcM78o2i4aheFhnO1rHi7v3MK5v+vopvIUZ
 lbQAlGzNA5qxWw8Ue9XlxiLiyVf58P+nyfS+fA83eP24LgKd6jsb+fzZfaTokUbrBtZs
 Nshh0EJgo426I5E2ZXHS7eK6sbz9a37A70g7iXkl8OiXBIOCWGOWvkAwBev97Q7ziEqI
 7IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715745; x=1742320545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vUanRaCN6JEcz0BUNbjbD8IBB1o0+DMN6l9Xny66zfY=;
 b=Ncw/kY2TTXGMrNT2Lt8LdLttkQ5tAAJMfvNhgeBqzg8xIafMeWWAHTswqPdmxR5WSl
 iccjtLpueyV28Y8pMLNqqv2M7/C5xpkp9lwZDQZ0R5fGnkaeJH2zsFX1y+E4KW7mXN0N
 a9EUJsiQbeYn7L9koqcCuEffNbBVZKqCie6aITLTu8mDNEJrVrLUp2xmdzOl1iYEvIYM
 tijaEAkKYqUVbZcW56CODPfXLcbD1og4DpbxAwiMEk7Vg6hFNJCN8B/sVpiVVhwHemqI
 mYL6ovfDVj35jYMUwUPpPpATbTK7zULcN1MzV8llutzIjcLEZhkNXj/MEU6Qg9NFiGp9
 x8mQ==
X-Gm-Message-State: AOJu0Yz6n6QmuWIu8ihDVanytBjNvMlYf0GP4gPGEICxzoSN82m1er92
 Wtuoo83nx6u5sq6lqD4E8i0Ny9s4eagNbewCWZFftyydIB8XYMsT
X-Gm-Gg: ASbGnct+RRHQDNRskOFBOSTeRfK8CwcRyF2Sc3+VsOPgiUzaWhOPsyzDbu8pp+YSaL2
 xZkcxS4EGxePuOWlberew59udt6zh/wLtvVaPsRwjpIB+K43Kd9kDOKaV6kivEIqXjOregwO47P
 M74rlmzd99zkoSTBZCGT67aouklPJjsFF9ge0fhTDo04Xuqx7PF2s/dwVLPU7/MfO7NSG4inN/M
 ZezQQj06BUNOkNH7Pz5kEnB4UB0qQ3RCoHg/48xg6YtiHfAwwVnCVhw2Xyc061cxAHwUZOBNGrj
 48VxZJWijKkZHDHcUzEB89ll00V/IGU/+sau
X-Google-Smtp-Source: AGHT+IHt1KOU9Kb/2q1NmZ+eZoZQvDpJv3l4bnluic1cB56t2qQgjkK0SIefvm/ThwqDqWtdWOEcuw==
X-Received: by 2002:a2e:92c6:0:b0:30b:f775:bb25 with SMTP id
 38308e7fff4ca-30bf775c0eamr51825231fa.36.1741715744209; 
 Tue, 11 Mar 2025 10:55:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bfceebd49sm15542811fa.60.2025.03.11.10.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 10:55:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/6] tegra: devices: add 3 second delay before power off
Date: Tue, 11 Mar 2025 19:55:16 +0200
Message-ID: <20250311175522.120018-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add 3 second delay before power off for some of recent devices to improve
user experience.

Svyatoslav Ryhel (6):
  configs: transformer: add 3 second delay before power off
  configs: endeavoru: add 3 second delay before power off
  configs: grouper: add 3 second delay before power off
  configs: picasso: add 3 second delay before power off
  configs: x3_t30: add 3 second delay before power off
  configs: qc750: add 3 second delay before power off

 configs/endeavoru_defconfig       | 2 +-
 configs/grouper_defconfig         | 2 +-
 configs/picasso_defconfig         | 2 +-
 configs/qc750_defconfig           | 2 +-
 configs/transformer_t20_defconfig | 2 +-
 configs/transformer_t30_defconfig | 2 +-
 configs/x3_t30_defconfig          | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.43.0

