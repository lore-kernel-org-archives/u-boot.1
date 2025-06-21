Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9732C71157
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 03:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C753D82CF4;
	Sat, 21 Jun 2025 05:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aqHOWbne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0187B82D06; Sat, 21 Jun 2025 05:22:30 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74BD82AA4
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 05:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-40a55314d06so579260b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 20:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750476146; x=1751080946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aguOS+B0wTMrMBPtS3EdqepbvZjS71ncH1It6O7hj2M=;
 b=aqHOWbne4gVxs6wGULtq72CPICN4E1t2xkm8w5L8aStAd9NcF2wJeQ33mk6tyJuKcM
 TvoEgOU7gC6KfpUlZp1oNQvA/qX4NVD1VCgYwV++fEZimRn6U501Oo2nMPLAc8Q6JanF
 NVDE4Th8WuP1xo1l1LGDnTCctsgsw97PRMMihKZAXNdQ2ZX8JZmoVP3DCMg3RwqvFTKY
 G8DQfK5aZZRghGGTv7/tyaD+aI88NRDpknJK/1dLSl7CPPDLs6/QCuq9bsBHL2G2Q2ow
 0sbxamuevncA22JgsqD/fcieq+5ioxkEtm9WY2pWwMK2Uninoc+/pSwAYs5CBUGx5O/h
 bi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750476146; x=1751080946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aguOS+B0wTMrMBPtS3EdqepbvZjS71ncH1It6O7hj2M=;
 b=Fp9Hf+r/PZD9FeQ9iowd/zhyza+eP91xigQjiN/Ygwq4MTp9I9ZIWwxRKYjqRlnmmI
 61SN4Fe5xUxDnsHeCzffWsJUuYNAzxUJPNA92kOVGakzkI2KykY69ZMPAkSd3O/jTxVD
 hq2ocp2g+DH+0rD2+wxHTSWgWpISlPFAnTmESGaKQ2OS73r4VssV9KiM+zNPpkzw43Tf
 Upa4rZLll6FHrRzrDY/Pu07q4VYU9VCveoMaUvhJgtDwP0EPH9/s5cQRzjC6VibHnOdZ
 6mz18aILcj5pCVhVnFwDSvxZeXC9TLH7q+13ZBkYwTRTnNLKa8W69XniUd2G92hBd6Xg
 LBnA==
X-Gm-Message-State: AOJu0YzrTwJmXBllj7jJs/4rUU3urTk9MevTU8L3CQp2LUoh+3HGzCJr
 hw3+zXRtCQx4ZNqtllLoe1ruhjFi774zTRW5Oigyg1hD1K/W0i8I0bn1
X-Gm-Gg: ASbGncu1x6jT+dY6RT/0jUqbzfMlRG1//6UObaorlYUTF+gk/DjX4minp2m/E0rrjGF
 lqhKeZtJDPQWcfzmmvfuc2feuG+DretD4wTUDyZAwnP9F3hb+LuJ+8n2qWT1g0ZqS1oh0s9awRl
 q/nBe7DWezcA4ttWvm2/t+0LxyYZPGs1MvqzqkUYcZb65ylyph1tIR9H/5uUK7zleSwBL6Ud/Ng
 KpYtSYGUfs8qmgq4CrolXmMHJh15dOFpwgeN/hvwNuwAWcDbo5r9buKgogV1LYe/RaTHwF+DgA6
 ynrcSIks602aoG+byZjiRtGkXKzlitsoGVTvkzpHsqXHmlWrLgWNxuo4y14g1ZbTfnkwTOUVkqc
 LxKLtTTKZ5mid+S8rgP6uxGgkkklzQF7fhZEPS+l+xH667MrERQ==
X-Google-Smtp-Source: AGHT+IELjInFU7eJrA5YQoHXDHXWK4IdzIsee1cOpiHNF/CeLSTdEk6Gxd5/RJGCswvQHdOZTO5x5A==
X-Received: by 2002:a4a:ee04:0:b0:611:3eb5:728d with SMTP id
 006d021491bc7-6115b733bf9mr3556412eaf.0.1750476146447; 
 Fri, 20 Jun 2025 20:22:26 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b7f6ca4sm419302eaf.35.2025.06.20.20.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 20:22:25 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: kirkwood: Maintainer for RaidSonic ICY BOX ib62x0 board
Date: Fri, 20 Jun 2025 20:22:04 -0700
Message-Id: <20250621032205.19329-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Add me as  maintainer for the RaidSonic ICY BOX ib62x0.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 board/raidsonic/ib62x0/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/raidsonic/ib62x0/MAINTAINERS b/board/raidsonic/ib62x0/MAINTAINERS
index 423aa0cf253..2822eb0d29d 100644
--- a/board/raidsonic/ib62x0/MAINTAINERS
+++ b/board/raidsonic/ib62x0/MAINTAINERS
@@ -1,5 +1,5 @@
 IB62X0 BOARD
-M:	Luka Perkov <luka@openwrt.org>
+M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
 F:	board/raidsonic/ib62x0/
 F:	include/configs/ib62x0.h
-- 
2.39.5

base-commit: 4e7ac18516aed7e8e30fc0bd3b282fc1669767e4
branch: master
