Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CCCCAC5B7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 15:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E38C80107;
	Thu, 25 Sep 2025 17:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TizXOm0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CABF80B9B; Thu, 25 Sep 2025 17:38:50 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154F9800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 17:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso5025625e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758814727; x=1759419527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GKaJnHjx7HJ6j383JWP+gs3nvdtxy7rAXdDLc79J3U8=;
 b=TizXOm0+f4RdOOzo2sFD2ovSi+/+M8wYyYOb7Yqeh/pQR87Sv9lVIb8qTGtPjYta7N
 CG5LTA+gDceEW/KwLUkB1qX8VrMnDAPqnD0s+G2bKdh1qP5ALIA3oCQ0YIEi3rZ1s6Cf
 GrtOBmLKLTSVNQAw4yZ/+oPiB5lSCvmGkApzb3cO/iwKkF+sWzKm8TqOYk05cM0ygClN
 JA5xz9Wn5finvkIbHRLqS6fpI09GpCwX/KlCdIAw/5ua+R3dhHPT6EuSdWUBvc52AKki
 RV0r3Zp98O1Tq/zmYFZ/rJrd77UrTj2xJiVUZ24wY6V6G/nj0Ltau/3ZXVehyJfVRlUp
 uZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758814727; x=1759419527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GKaJnHjx7HJ6j383JWP+gs3nvdtxy7rAXdDLc79J3U8=;
 b=ZbcijffhAs2rF2gyxvOX2yyPbRN5nARvoyAqEjRD1BNIAvRpF9yg1n4E+HowXQy4YP
 VKt44+R9/m/26hNNOuJTacTlIGUlfaQwEvJHhJxgqEBAEsAoXWnAwoSKBQoGpiLeEmcC
 mvUwho+43160Qxla1oG0q9yxbwWNO75b6WFiJO+c1zrm40Ae+fVbzcsJvTczdatobyqG
 yrX6ess41Fb/wUzseJ0Ng0uxLiiLVFrZndzSXSyaRwITAbP9j004vxKghaRVe9v41L10
 1gskvtRqumO1a5eTjdCjeRNMjOg+iRSUqSuJ+qzmC8xa4YOUPrqjAmNPo2viRqOoBdFe
 dyfg==
X-Gm-Message-State: AOJu0YztDD1HP1ZqRm57GZQv/Dw/X9otnHy+96pLkg450dgjNHHkN/r0
 oaKZB5KD++y6wKT5N0ivkmMBEjSjSo+1tTV6iWYyUrhhJHBHGtSTtjTstzy1Mm0yXmg9XSt5n4w
 cL9zxzGY=
X-Gm-Gg: ASbGnctyZqY8iczpJTk1fT0zIzLCfIRk4KVG76teF3g6v5TiNrzAAwLYXn4uKGldETX
 sKjNnovl/wIO7M3XJGR4m6aLhVMLAr+Bdd5++XfEjPAahtcGh9Q8omaAWRR+iYKSiwxMxLLYRzL
 /rZBUNpx/P6fj4qhx4UQb7ESjyzDB6a82sabkrq18mxX5hMtK9jKxZpOewDRzcpor64gdnr7DFk
 19Ng2KOzgzRHrROxxTekuB4gDdevjcxarUHkZAzrS3W1iWo0FD/NpBD9bmB3tg+yM8hX5D41FEB
 DGE9adHLQPhc+GWf7LPkLkl1+Rv9LfH0Na0worOTuMF+QwgdDX4p2asPYktzYfx3qAlVBmAmXpe
 cYAy3HQF3SZsKBwdWzg0QSR3ctwlolCPnMEU83cXZCA==
X-Google-Smtp-Source: AGHT+IFuBIP1DQ/kmKux0JHs5SkaZaZre+rgNiaLK0qn1tl7m6vSOxD9VyyMkhe6Ew05JjsCI/NXbA==
X-Received: by 2002:a05:600c:4816:b0:46d:996b:826a with SMTP id
 5b1f17b1804b1-46e32a19e7dmr25346895e9.36.1758814727292; 
 Thu, 25 Sep 2025 08:38:47 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:2f01:888f:3733:9fe6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9d26ef7sm3607045f8f.26.2025.09.25.08.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 08:38:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH] MAINTAINERS: update NETWORK and NETWORK (LWIP)
Date: Thu, 25 Sep 2025 17:38:16 +0200
Message-ID: <20250925153819.3282808-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
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

Add myself as a maintainer of the NETWORK subsystem since:
- I have effectively been handling net patches in my patchwork queue and
sending pull requests to Tom,
- I do have push access to the u-boot-net custodian tree.

Also, add u-boot-net as the SCM tree for NETWORK (LWIP) since it is where
lwIP-related patches end up too.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
CC: Ramon Fried <rfried.dev@gmail.com>
CC: Joe Hershberger <joe.hershberger@ni.com>
CC: Tom Rini <trini@konsulko.com>
---

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b030242a2d8..108d07a7232 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1412,6 +1412,7 @@ F:	drivers/mmc/
 NETWORK
 M:	Joe Hershberger <joe.hershberger@ni.com>
 M:	Ramon Fried <rfried.dev@gmail.com>
+M:	Jerome Forissier <jerome.forissier@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
 F:	drivers/net/
@@ -1421,6 +1422,7 @@ F:	net/
 NETWORK (LWIP)
 M:	Jerome Forissier <jerome.forissier@linaro.org>
 S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
 F:	cmd/lwip/
 F:	cmd/net-lwip.c
 F:	configs/qemu_arm64_lwip_defconfig
-- 
2.48.1

base-commit: 44c4919e9dd6c162b237633ba689441eca9a149c
branch: maintainers-net
