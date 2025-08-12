Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4301CC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 06:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7075A831C6;
	Tue, 12 Aug 2025 08:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NQ2zNdjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 009B3831D8; Tue, 12 Aug 2025 08:08:14 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9332B83106
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-615622ed70fso8158354a12.3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 23:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754978891; x=1755583691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=og3JlpGv46KwZuXuuqI1cmlBgLxxh1VZk+i7/Orufj4=;
 b=NQ2zNdjRCtnuk6WlmPPPH22dztSw+KzaC+jDxB2qqtylFc+iaueg/As6J6IZmbZjQ7
 CNofynm1Kz9s39GqKx7pwsKONVs4vWJQixL2AnvpXIiwBQ/dcn2EhaY2MJpDq0YXXsZ2
 FTPfzKWDsg9ZCD8gUDM6dOQHAsUarwjRaymYlP5Eh4QmpIH5NpYaePoFqgxGcxobqM/j
 EUY6QUUx3jBgz+7ZXCEoKy0toVZcJr3jYg8oWlPDTMvDXQJqx1VCZSJRV4b7R+UFgF6y
 dNwLJbGFBRoreAv9R1bFS2gc2qnUqRKiZLsi14geNelxaSn7m7TKOblaYqhwWPqpJItC
 jmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754978891; x=1755583691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=og3JlpGv46KwZuXuuqI1cmlBgLxxh1VZk+i7/Orufj4=;
 b=xS72me7KGfzBzKggBNvMIiEhcSin5cKObaspsiTu9HZ4W/fNnkaa5OXqRE0CGCrSEw
 aE2VMoS8aCckaVNm1kKcZLPki0+LzRQ9Hls162AABeSwAhrNpjA1PMW4Qu9o64CGP+AI
 NLn2DhmUuldn+9erO988eQf/CYjepfn2/Sqe1RakV6xvqzNGPzpmZ5etyvlV+hTHQF8x
 K4XJzuWMjq/cy6vZRH2NE3w+7MLmm22T3N8hojYn+Ui2OfKtXQh9tenhsu+G7TmkzdB1
 4kfWqG8Rx+k5WBVeq+5TU4R7zHn/hV7kbbYaRJX55IzOr63BJtEYPkSMVu4fXdCMNJW6
 caHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Cbgvsh54xIuMcepjxSD4qB5u2P1+sFVZH0g+KQPnO4UoBg4rxFVTiOaEs/cl3c2plQ1ujyM=@lists.denx.de
X-Gm-Message-State: AOJu0YyR3arj+JfiIeMFVw3zZmpQX53bO8WwIWisxEh9q1l97bbsLnLZ
 YQRFb7vtNlLgA4LnrOEQQ35nfuDkkOB16g1xP8F6gpMN/KigqO1qry3j7ew/we67RfQ=
X-Gm-Gg: ASbGncvaYEiSEZ3yr6O7ZsGl+rmmUcdqIWalyrUbNtb+MX0SonhYfOzIkLu1Hu8+6UP
 nmtAfbXHFGUhBkhgM4KTYE6bNPYNOadn+TfgaG/yoptBym1KKhMZGabExiIx/jW1hdQy67qEe51
 HLO7Pycog4dNHjOkLKzzx3U/Vtme7qeC0iIEb5p1Qb5BuwRQE6naKmq4THSrJLi4950RiKQz3RP
 5b/kai2mjn4aG4j/IK3ceGcohxVjelo1rHsADl34EYblP7E/6Zh3XlEuKgcsGSchmT56bYHcr0r
 l2k+j7SU7GJi/Axfn9BSrZQq0ulu1wu8ypff2yXgb8YBAA7NBWsUuFKU+Vlx8Kr5HC9qQ/JJ5Wp
 oKQkdiUdPvVSGKCvbtA26w0ajFw==
X-Google-Smtp-Source: AGHT+IEV7OU/LckwkETKKPTQrNCsT9sGBIjY/7VXE/w/QlsxI5Ke6o1wdwhOW+3mXASZTO84XgwHJg==
X-Received: by 2002:a05:6402:3553:b0:612:b742:5bba with SMTP id
 4fb4d7f45d1cf-6184ec56e85mr1686474a12.13.1754978891003; 
 Mon, 11 Aug 2025 23:08:11 -0700 (PDT)
Received: from hera.. ([46.198.241.143]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a9113e40sm19636474a12.57.2025.08.11.23.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 23:08:10 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Gary Bisson <bisson.gary@gmail.com>, Maks Mishin <maks.mishinfz@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH] tools: imx8image: Make imx8image_check_params() static
Date: Tue, 12 Aug 2025 09:08:06 +0300
Message-ID: <20250812060807.1224861-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

We are trying to enable -Wmissing-prototypes and this functiion is only
used locally. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 5a76643c06e8..3cea536b8e88 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -23,7 +23,7 @@ static uint8_t cntr_version;
 static uint32_t custom_partition;
 static uint32_t scfw_flags;
 
-int imx8image_check_params(struct image_tool_params *params)
+static int imx8image_check_params(struct image_tool_params *params)
 {
 	return 0;
 }
-- 
2.49.0

