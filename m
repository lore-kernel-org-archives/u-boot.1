Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679C3C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 09:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E105B87496;
	Tue,  5 Dec 2023 10:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQYQBpww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9527987623; Tue,  5 Dec 2023 10:12:38 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5BDE871B2
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 10:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33338c47134so2563905f8f.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701767556; x=1702372356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qPUbOHU8O7Ajjk9wYt01lQ8Isl1c4qaQn53AjaKtuSM=;
 b=QQYQBpwwSIchAXmK7cNF1G5roJIvfH+DqVK6CrB1+hChD0msvdPRbdTiGtYDvTUTqq
 lTEQNZeU+FKcBlbenPVYcN2gaRaYb9f0Brmc+BIQ1keAn9245wNZPz+qO30wSyyQbzBQ
 AYDY40pNgxruXBY//ZpujGwyh1vqN2jXf0CmAHzeaW2yvHDwgznNk72ty2C/+cTie4X+
 rmPzwdUtCHtvYujldnLtYr86J6QrN4YH+NjkDydvd59/xHW4OtbyGewdLazttFpO721n
 wZUilLexAbgAhlySOvP8PW4OBkg+eLdSj8wEoJDH/SzC8e/jisDe+dnzADGR051zMgkM
 OoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701767556; x=1702372356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPUbOHU8O7Ajjk9wYt01lQ8Isl1c4qaQn53AjaKtuSM=;
 b=J8Xr+uYXz2tVdRDIf6d5YgmI1L94ryBOrnpzV24v4mAjGFGt5Mdi47Go6JF2rVGDoP
 xhBm5G25Jd7DBPSYVW6f3sIG1Vy3nfjYgLP7WRWk0JNS1QL/NY5XQYFIdLN5kTOOFpYZ
 p91+pyJ7JZNO/7Tv1YpdMWr1IRMUzxZLqAI8xEZAYerWYcDlSicMa8Z3znOP16WOtIq1
 18JLwFVZPDSVK0aEOQX2MIKg9lBz1laKtgOBuwBck5Hj/ITAX1n6wGrp0dvPBlB1x4fT
 yXg9vXsA+ZP0zcgA/dSlcA96AHukAOWVRWQzxKqTcEyuceCXwGhL9yC/J+gzYE2Co6lD
 EKIw==
X-Gm-Message-State: AOJu0YweatfGIgIlbePa6Ud8fgZGROa26WFBzeCW1CrAVOyI9lKSymDG
 w6aa+mXhTaC/Vn1Girl78mYKXqUv6hA=
X-Google-Smtp-Source: AGHT+IFTxPbQBINciHjczPP+udE2/amcSANZmNU75UVy1WhgFGeMUyM7kFgqZv2SXzjNHYNBjSS73A==
X-Received: by 2002:a5d:468a:0:b0:332:eee9:6e7f with SMTP id
 u10-20020a5d468a000000b00332eee96e7fmr3746921wrq.56.1701767555914; 
 Tue, 05 Dec 2023 01:12:35 -0800 (PST)
Received: from morpheus.home.roving-it.com
 (2.1.9.e.d.3.3.1.6.1.e.d.5.3.a.e.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:ea35:de16:133d:e912])
 by smtp.googlemail.com with ESMTPSA id
 6-20020a056000154600b00332ff137c29sm6388263wry.79.2023.12.05.01.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 01:12:35 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH] maintainers: bcmns3: remove maintainer
Date: Tue,  5 Dec 2023 09:12:22 +0000
Message-ID: <20231205091229.183512-1-pbrobinson@gmail.com>
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

Remove Bharat Gooty as a maintainer as his mail is
bouncing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f74c0aacaa..87e5ee04978 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1528,7 +1528,6 @@ F:	cmd/stackprot_test.c
 F:	test/py/tests/test_stackprotector.py
 
 TARGET_BCMNS3
-M:	Bharat Gooty <bharat.gooty@broadcom.com>
 M:	Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
 S:	Maintained
 F:	board/broadcom/bcmns3/
-- 
2.43.0

