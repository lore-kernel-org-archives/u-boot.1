Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ADEC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF17C88D62;
	Wed,  7 Aug 2024 19:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YiyDbIi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B082188D5E; Wed,  7 Aug 2024 19:13:24 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1BE88D66
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso60458f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050801; x=1723655601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7N5ciLGUY+C+mQLp0Utk1Wdal7GnooFyY4TOXR2jNv4=;
 b=YiyDbIi1AP6zWHgt4h9h0/EnXcIQiBR7kbvDGogIzZRA4ij0oQ8nrD2BnQZojHPZE4
 wvI79vm0/gHZQhoc4qVjC7C21uDPg4X9iP+SMhr9PUsIBazjSYehd5i8EegNi8ssXiMM
 Yw8Id8FHSE3l9YmxmwR46mXmzD0HICvWX4Pc6iOMuiNEHRarbW2gjrWN2N/a73a44E8w
 nMnYjejUOPh7i+7ST1Dr0pTHJYBav0VJTwhVA84O2+13jNuQ/tuQUVV3uwmkaqXwz/s3
 peP1XPvu8N3ZFV6/X8rOBtlyVB+FJz4/pszmePLZM6pyazN+rlecaxpXjZGiykDr2fMM
 JwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050801; x=1723655601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7N5ciLGUY+C+mQLp0Utk1Wdal7GnooFyY4TOXR2jNv4=;
 b=bXzU6utmdGGJlP1R1MYp9e/XoJ+6hz3p9lZ9Yz9jBZhgN363JUK8rpEgySZ1WxR2JT
 Fj4ViypaE1jTqGCxkXIfNHLPutx8bBx17yvRI1Bs+B4pecMHu74AAh4/NENCjrh7WOZS
 Hu30R6U5o7Ndr8zyrZWxHXyYQo7NQVK3ZU+ZLM4e4XPHu4jqVWDK+fyP0PWuFicwF6W4
 EeQtQRTuCAtqh37SBJ8UkXCL9zhkJOtla0M7haQvM5bNnpoNnvHzLqC9Vq7zNtuN1fRQ
 l1VtPGbeYRpzNRrNJFrkgMVV5BP+cscc6NH4bcMEONXSMKpt5NbSND5QtsqB+YZ0Vna2
 ZHTg==
X-Gm-Message-State: AOJu0Yyw5qz/9bIu3s4Q/nx02Vw8xaT9xIFk4ILSkz8xG8UWWnH7og60
 E0S0y1P5aAk4/BWLclaoQHqpvZ6xzhzVgQQQeb9OvMX9FPK5fClVSKAkpbGADWiXdPUtFoGhcor
 HTqK5SC2t
X-Google-Smtp-Source: AGHT+IEMonUZ6PBDS0aOY67CtK680JeqsxELC21PE8d0vn8x++AWw/nk/bcFi2xGOkJLyrpxfZYxEw==
X-Received: by 2002:a5d:4003:0:b0:368:31c7:19da with SMTP id
 ffacd0b85a97d-36bbc0dd4d3mr16686572f8f.13.1723050801371; 
 Wed, 07 Aug 2024 10:13:21 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:21 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 16/23] net-lwip: lwIP wget supports user defined port in
 the uri, so allow it.
Date: Wed,  7 Aug 2024 19:12:00 +0200
Message-Id: <1b4fcb30e3577970dbc7a504840081380f21e469.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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

From: Jonathan Humphreys <j-humphreys@ti.com>

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/wget.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 83f4de01d1c..fb544308eb8 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -347,12 +347,6 @@ bool wget_validate_uri(char *uri)
 		ret = false;
 		goto out;
 	}
-	s = strchr(authority, ':');
-	if (s) {
-		log_err("user defined port is not supported\n");
-		ret = false;
-		goto out;
-	}
 
 out:
 	free(str_copy);
-- 
2.40.1

