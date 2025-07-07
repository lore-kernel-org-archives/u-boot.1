Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692B2C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 11:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB9328305C;
	Mon,  7 Jul 2025 13:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g5PsU78C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DBFF830E4; Mon,  7 Jul 2025 13:25:13 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AC18304D
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60707b740a6so4029436a12.0
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751887511; x=1752492311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=56aK80yfo9kMzrt97hue+owLa93KQxgz5rp+sg65XD0=;
 b=g5PsU78CWPJF3Ya6m0/VxQzsEfmTUat5LjQd9C94EHdHLV10JamnOPVdawiQrTyAsk
 CHoeesuUs/vNKHl885n+4uF/dq1nsEUQlPGNeKL2skqP0/ESclnS30Jl0JQWpfuwXLBq
 rYpGPyb2pnamUwGdyuVvi47wcWLXmC8E+DQiyQ/nSB+rUxc5JB8DnU+IWefgRCt/aq+N
 XpteQOYTI2GTvqftLVRgFUrarq0XmVn40ET45UhIJ8o6i2GfGXZuEkDefSX8CibjfmMo
 v5G0UspTn+ewYQl8szltzL3LrJYWorXmP3H5gC89z2bUxrtJYIfHZo6BcNy15FImNp2d
 VXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751887511; x=1752492311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=56aK80yfo9kMzrt97hue+owLa93KQxgz5rp+sg65XD0=;
 b=YGiAU9a3jevJaEGVGgn3R3yLmkBKE7OPkZ2uizkJvMqs5T91UPUvsVOxf3oDigWXLz
 1q/AHYUuvooUr381+fEEtAMsmVxyPi1RCGCpgYB33RUveEz2AWHaqzk6k97if+3iThrq
 lSWHbgwkgb9v2Jf4ZwaEXCtkbVEBvQx1pEDUZx0oU+c8izypBzRDHfrZl61mJ/qxIfAX
 VNlRAShGpUBQu51mDTwnZJGZY2QeTiXMKrqgP+KTGcIfz46Slze72VAj1jHCSqoNpdoV
 TKsnl7L/UmG697jZM/XDJ1HBcudojZgutnwH8i/9iGz5JFhtU/7HUry3vrZFUD0s5JXa
 nALA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhVx8foowt+X5pYQMBwsSCTmMf7M0F2otYzNFWxgVouuSz2pzAyiaK1e14fTVecE9RmeEQj2E=@lists.denx.de
X-Gm-Message-State: AOJu0YzjuQVEQVsq1JFRA23JSjkKnuECWb6rvqAX2CpMSzQmS+z/4OKv
 rz7g0qv4E0EstLYVf0rGzK5cU6WeSZVUkwgyBfHLN3xZye4ZWIhxlxoDIc0MZ5gG+KM=
X-Gm-Gg: ASbGncu9quKni0gzvIpWpJyXY1MzKOJGrDiBZoY53x7ijPcJKT4V1bjs6MAPyya+JmU
 uLeDQQn9VsTHOvQxqjLjjIIzagJ1Gs43edh8uQ6dYTIABd2M7DskNYTj4zoQcuHwdQxVURMvq0N
 Ht0Q0NXKChFp3x5nuZH/S0CbIUEzE2uGizegNa4dYy91MUqcwxoSIcniP8FDRJp8kh3BDJNbCp8
 EPRJkzVUhevaFtxuqyDPfd8Skj2W4L/xHY3vkOZKpdSt3QppvhvD/FgewCzUAI2lrMg2lzfKupE
 Iwcl5pm5XrDcNYlnSZSFGGtJ6XCv1fggog4KxyZeQcppZEjYUsT635DgmYXra123g6R+JFyighi
 l7SPVzItZ1OjOYaDI9EE4kA==
X-Google-Smtp-Source: AGHT+IECa/ltuyAYphKThAli32fUOqdLpENudpadAoVaMobktSAC/8y6vyOzG0dVKebjxgfgkjImaA==
X-Received: by 2002:a17:907:94cd:b0:ae3:ce75:afd8 with SMTP id
 a640c23a62f3a-ae3fe7b2d1emr1073859166b.30.1751887511057; 
 Mon, 07 Jul 2025 04:25:11 -0700 (PDT)
Received: from hades.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b08568sm688874466b.139.2025.07.07.04.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 04:25:10 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: [PATCH] tools: mkenvimage: Make xstrtol() static
Date: Mon,  7 Jul 2025 14:25:06 +0300
Message-ID: <20250707112507.103797-1-ilias.apalodimas@linaro.org>
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

This function is only used locally. Enabling -Wmissing-prototypes triggers
a warning. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/mkenvimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkenvimage.c b/tools/mkenvimage.c
index 885cdb1390ef..944ec82e761d 100644
--- a/tools/mkenvimage.c
+++ b/tools/mkenvimage.c
@@ -47,7 +47,7 @@ static void usage(const char *exec_name)
 	       exec_name);
 }
 
-long int xstrtol(const char *s)
+static long int xstrtol(const char *s)
 {
 	long int tmp;
 
-- 
2.43.0

