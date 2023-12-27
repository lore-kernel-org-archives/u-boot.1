Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1951C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B30879D7;
	Wed, 27 Dec 2023 22:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BibUz6wF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FCC879D3; Wed, 27 Dec 2023 22:07:57 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144EC876D7
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7815c5b69e1so73993585a.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711273; x=1704316073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO5wMGyLmtP17mXl6SJk+QUJ9h/FXcc299FuxgH2TWU=;
 b=BibUz6wFWG0vjlqAMwNP8i/Trs6m8Lppwo/09NFluQ+udHMuI/3412cIO87t61S8ix
 20FynBG0H+dub8RS6g2E+1pjmvpSWhjyoIEVXJuDgF1X0vtgNhD7jC3kdVV5FAXRj9aO
 lwdimROAzwHd/qftHTOc01+9IDGjLxYDj78AxxTHX35Vv4zBVMMz+T9MoKnIfU/V1gxJ
 IJXPLEX4l4kBIVClJqUylQ0e+iLw4svoUdlT4lV2hezCxrMJ2RFeMICXymlnPAWVFhAB
 47n5tN4X4zGDpnpLtP1nROPHCzxkxetXuTDyW3In41RWy6Ngjfm44gfgIshzqvBZEpQj
 XHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711273; x=1704316073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO5wMGyLmtP17mXl6SJk+QUJ9h/FXcc299FuxgH2TWU=;
 b=Pz9EVOdbOs/1Y5RUmjbBiIfwe3mpAXbGn9tVGc9g6Fg0LRS13BCEllqNZ9BCWrHAhn
 0x7Y/paKycUyVzIT8YYUQnL/ENXL/avO1pR3HHmywpsbXr6kwqZ7VXS8uhndvEByKaa0
 TlkIzwMfqdzwqowzIhq095vhO6jNMGL+e8wt7Nat1YSvz8cdj58yRcezSo9vsWQ3jdEC
 KFj8kizgMGywGMep1HOgd2uV6gCnnX4FrydvEgtg6qkmX5xBGNIeQNUS60KP4/i2wLev
 KwZQD3b88olXEX3a2zmvnWLmS8Ir0/REjC29tbc4v1Oz4Ck4slQqZeGlPPOZquZrKpkd
 hsTg==
X-Gm-Message-State: AOJu0YyILlPkDYfF2hXFbeRT/vTl+Qdl+I6KVwTSaoUbsWu6W5f6yAYs
 OuLUOGgSO6tuklqF4QWkh8ole/iaHrEucGDIuz8Qrel3ww8=
X-Google-Smtp-Source: AGHT+IELH9PLTwZXtJw0Hqkq7wd72XExWcAtS50pJEYmsuz1LG9dvCihGxzRyC8m8/eBNL1J+z46yA==
X-Received: by 2002:a05:620a:d81:b0:781:6db5:1a93 with SMTP id
 q1-20020a05620a0d8100b007816db51a93mr752680qkl.66.1703711273574; 
 Wed, 27 Dec 2023 13:07:53 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:07:53 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 04/12] bloblist: Set version to 1
Date: Wed, 27 Dec 2023 13:07:02 -0800
Message-Id: <20231227210712.712937-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227210712.712937-1-raymond.mao@linaro.org>
References: <20231227210712.712937-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

The new bloblist for v0.9 has version 1 so update this value.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 72c785411d..7eff709ec8 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -74,7 +74,7 @@
 #include <mapmem.h>
 
 enum {
-	BLOBLIST_VERSION	= 0,
+	BLOBLIST_VERSION	= 1,
 	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
 	BLOBLIST_ALIGN_LOG2	= 3,
-- 
2.25.1

