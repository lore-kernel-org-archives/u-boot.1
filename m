Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A3BD2F7CB
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 09:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8C80841B1;
	Fri,  5 Dec 2025 10:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kgZzXjg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2425841B8; Fri,  5 Dec 2025 10:47:02 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5B9840FB
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 10:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42e2d52c24dso1043474f8f.1
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 01:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764928010; x=1765532810; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k8fGKuOBR5KvrlOoXh38XVZmGOQ1lP+4Yb3CjiI2Q6U=;
 b=kgZzXjg+kSJ938XVQrK5F+xNgq6ZMLwNAiRuj8tZiio03iMkjQSJ04wAewKJPEc6AX
 l4j/V1R2qKtWZvtKOVOA6kr7ZugpcMjbycYfxanfEfkhwE00hAhjEYyF0WWUAe8c3KRC
 gPquehh6YunwUWfI+lNmngYMIwibmazV6crD/Y8e2rkROlL3K54iHl46W3IqgWvvpX3M
 xNQXnUfeBh6hCOiG4ET9oqvOqVKoAgTmZNFswxyL2jEebf9JJyXZghXRiY6QFB56Nt7V
 GFtxAXptGMEGeU7/gog4xfCbFY1PqMab2xyB+4EcLWWAbq6lPz8dy/dZQT0F8guC7c5y
 j4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764928010; x=1765532810;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8fGKuOBR5KvrlOoXh38XVZmGOQ1lP+4Yb3CjiI2Q6U=;
 b=qgyRPDiYRJdL7SDL25cdGv0XlwTs+UCYPiL2zK7y5jnEzN3hORpTAifsRRSsYFZslp
 Cn49t8Bjo2DvSGEEhT9ypuFz65nFbpACRWhDneDgli4cTHDy8TiqYcwfhbPJfk0iWNMG
 U8OIjTxjTXnD3h249WKqA5Qp2VizM13tyy6W8BFkLY08hy2yzA4LdTZdvOr/tOQ1oCDH
 jVU9RFllg2w5aEQ0ND0NfEwrxps0omaDzHiXvY5A965qrztkmZI1JBuI47AJALUt8u+f
 EAqkFhfwRNp84cW52TGNLe6nDuS0kp6oJukI0H49H1x63pdBXGnpo+PhEbNCnekIFvsZ
 sPDQ==
X-Gm-Message-State: AOJu0YwTWmr29zN1NIBphWGoNaJAjqPfHVonu4b++h5mxLS6cTP87wuR
 2JyyOt6ncTkjGlRLeBX91k0M0EIKAZZYRUaAF+5ZG+d3YCZcGEC6yvT09yQztJQ5268=
X-Gm-Gg: ASbGncur0SKvZlSW4cL5TO1qsp2OPDKT7gnPNssCiJZzmmFlSFGeRbpqvU9sjNGuZ8j
 oTz92gpoOM+Lj38NEV0As7+s50Rq7BLI6ZfYe5T6ArzCH/MSuJ262vODndzcTr/dgg6Rl+JvGuY
 NJ3qkHz5vgqLRkbKECsuwi84IBZfrt3E4DaEUS/1SJHwuYkVSc2YyCFZkGXiGdhFAqm9p11a1AB
 4mf79LuQm1IUCdGfYdNUdawGh+ndUDTZ/cn3GgeCcKT8sE8ZG7LHAxf7roalZxMEdd23cSImk1R
 aBKSPaburWRSOnYG95ZdcpNlSkrVC50MztJS4xfQuIO7vxpNXIaOPaplFteWzC/zZJN1DHkHvce
 EAr3B+1CqJ/QmATZ2VvxRgHdg/AlCNoFRBUcdGPaIezx2KvpBA7FP9lENMeu+eWGojL05ovsC+m
 SbGlajjnD+CSLWK5ueB99gPp59yMjt6xVHJjZoUhg=
X-Google-Smtp-Source: AGHT+IGTZPSIKXoVNB+Vsbz0aBY+pQw8rizBjjX5HcNx+P7KZSX5bJEw+uynBEPyljweg9K1eABUZQ==
X-Received: by 2002:a05:6000:240f:b0:42b:2eb3:c909 with SMTP id
 ffacd0b85a97d-42f7319684emr9569326f8f.20.1764928010091; 
 Fri, 05 Dec 2025 01:46:50 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f7b:b001:ff09:b7cb:eda8:67f3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe8fe8sm7748842f8f.2.2025.12.05.01.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 01:46:49 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 05 Dec 2025 09:46:48 +0000
Subject: [PATCH] net:lwip: Add debug line to net-lwip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-lwip_dbg-v1-1-f3406179c0b7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAeqMmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNT3ZzyzIL4lKR0XSMT4zQLy5REg8RECyWg8oKi1LTMCrBR0bG1tQA
 ITp7RWgAAAA==
X-Change-ID: 20251205-lwip_dbg-243f89da0aa8
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Martyn Welch <martyn.welch@collabora.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

When debugging the LWIP NFS implementation this debug line helped to
show the cause of an error. This could be useful to someone in the
future.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 net/lwip/net-lwip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 8741f65fe12e23cc30068506453a762533f8a67f..f70857204b2808139ac3ccacd89d5719b7db12d2 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -297,6 +297,7 @@ static struct pbuf *alloc_pbuf_and_copy(uchar *data, int len)
 	/* We allocate a pbuf chain of pbufs from the pool. */
 	p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
 	if (!p) {
+		debug("Failed to allocate pbuf !!!!!\n");
 		LINK_STATS_INC(link.memerr);
 		LINK_STATS_INC(link.drop);
 		return NULL;

---
base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
change-id: 20251205-lwip_dbg-243f89da0aa8

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

