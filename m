Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D9FC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6134082E26;
	Mon, 28 Jul 2025 18:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sUb2rKKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C7482E52; Mon, 28 Jul 2025 18:42:24 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8963982D06
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-455b002833bso17924325e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753720942; x=1754325742; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/5TtnaO2jN7/O8+IHkEqrjPcOINEGjCIUU0+P0mzp/Q=;
 b=sUb2rKKpm49Senus7Bvn7XRTq/Jh7Vm7aR7gj+e3CTwMOpn2nDH+DSVkrY2fjhWvMr
 kyPkKq9Y6aI391XoGD8kAhACEBkWzBdOq7W9w+e9pbH2A2v/hA98LnGyQCvIsgryJQty
 4fOlGPXs8I5/4Pb/Si1o3pcGDDd7uX3Hz5f3xkLWikiWfzDFzU6j6hj2fy3LWwCwYazy
 Dg3GaleYzVR13uv77YYpnOl9xKrq3LcnKssT94GifpYSTb8J+T46tmmbd6b6yshqR4KU
 VN6aGTXIA2nT+2oBIY2874ngrtwUy4lQUp208leWEs8hQ5OrPOoxIBMjEZyXRLD9Y51V
 pN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753720942; x=1754325742;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/5TtnaO2jN7/O8+IHkEqrjPcOINEGjCIUU0+P0mzp/Q=;
 b=Q/S8bTjU8jagzZGm/3gkO603f98KTv5of9uu7bAF4aKBwG6zmWEHLObZ6cgsCIALIb
 AVhOhlwl3PZteFdIWg4CWZWmt+/mxt0DeFvjtdSS+8Fk/ztRt3l+BE79/hLFvwgckBc/
 MuaF5Ws/ELxwbSYGkutrq59rrtXiw1aya/Jo9KBg/cIe3eNsZ6+0sSCrIFNTi4NLhnqQ
 D9Lc2CUMsLABV3B2oRlXZ1yaNhtG94MPYbvu+k9Z68q9gaYTPKLz2qan/dRt2FBG2mIU
 bnoCwLQghm2jRdgUcwpcGZO3N6latdrjttMvW9YvB8UVyw64MnnndCM+5ZhIAlJReG+N
 R5Rw==
X-Gm-Message-State: AOJu0Yx6qDhswIik4uEstIEY5nyP2cuqA85QJWmsXtoGPQySg63UZldc
 Z81ypGu6q5PxV8GPojdINcRQuilvcAvNZEL1woMIQvRDpXEylNqPkVhv9Gu3zQFPPsE=
X-Gm-Gg: ASbGncuKM4K6GZPU5gDm7HmJ7OJrDxQoWbpESCAgan1urkVOnKGg2v3nRlNhKxLUnbE
 WEV+1qrlpL6Qs7HfB9eN19ygDd7Sptd0MJxUHmAPMClOIjloFHLXgUHffKz27lZW/hpDeOWZC6A
 26chZcVMxtjB8Js+RUTzklGJEor6bUEcVdmScBoNnjGV9iIkTBo3qAnGDcSUSjwvhS7BTtVqZPS
 9hubAd6zaGQSz5QQaZhRP8+F/BYou3HewtBWu3SNSwjOg9ZR5Hyevig74CsQhLSbPj1eXU+AIbo
 9LTTE0W6FF8CFXoDjChVCuB2Re6UsCnp7Kv9u1yTS1qjUFCXadF7hIcrC7U7DngNNAv1VjQVNkP
 g2cHrh04HEU3b9tWvABRpHCq59b+DgxkIXOY2Qt8X2PcEsdAopA==
X-Google-Smtp-Source: AGHT+IHhItlhBBgtn7no4hkF+cyNper7l243cmjJ+3L9c7TfIViO+UZ5WS5TW+GVENbS7lzkkkiOrQ==
X-Received: by 2002:a05:600c:828f:b0:456:1442:854 with SMTP id
 5b1f17b1804b1-458827c18bbmr42664645e9.24.1753720941908; 
 Mon, 28 Jul 2025 09:42:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054f2e6sm160984905e9.12.2025.07.28.09.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 09:42:21 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 28 Jul 2025 17:42:21 +0100
Subject: [PATCH] imx: scu_api: Remove unnecessary NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-scu_api-v1-1-89470de6d9b8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGyoh2gC/x2NQQqDQAwAvyI5u2AXpeJXSpEkZmsOXSVpiyD+3
 bXHYQZmBxdTcRiqHUx+6rrkAre6Ap4xvyToVBhiE7vmHvvg/B1x1ZD6tqWUmFgISk3oEsgw83z
 1b/SP2CVWk6Tbf/F4HscJYzlDz3IAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In sc_seco_secvio_dgo_config there is a check for data being NULL but
this occurs after data has already been dereferenced. All callers of the
function provide a valid pointer for data so no need for the NULL check.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/misc/imx8/scu_api.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
index a40c8badf9a..8985ab6584d 100644
--- a/drivers/misc/imx8/scu_api.c
+++ b/drivers/misc/imx8/scu_api.c
@@ -1282,8 +1282,7 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u8 access, u32 *data)
 		printf("%s, id:0x%x, access:%x, res:%d\n",
 		       __func__, id, access, RPC_R8(&msg));
 
-	if (data)
-		*data = RPC_U32(&msg, 0U);
+	*data = RPC_U32(&msg, 0U);
 
 	return ret;
 }

---
base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
change-id: 20250728-scu_api-f844bffcbceb

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

