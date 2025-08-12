Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B952C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 10:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2023832BC;
	Tue, 12 Aug 2025 12:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EgBK4dW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6D18317B; Tue, 12 Aug 2025 12:13:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A718323A
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 12:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b91325d79fso210232f8f.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754993631; x=1755598431; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FLLamhXEah+wWkFwtit2lP3/m+DG0tW3g7dsaAJL4E0=;
 b=EgBK4dW12AwtsMB04680qJMJ8TQbGfzLHtS41hfzBXC/ICEglY2ZFLFnuciwNOrxxv
 F3iq23ae9BHW4o0F1qnlh/0Xh4e0MMpXXAhVlT7XhGqMS6e3RYro/FCbZlJAiO5zCt9y
 OKzBBHuAYqcBPVdn+iNeDt89kvbMHmZtKTuCpw5rdxirCzCfO9wljJQCak8rF5vHARl3
 gr2VmE3plRrSdudvh7KSBNJcWLMtTmazJSMnMmhqoGRbhLzmZAuKabAQYNsh+Vj5462f
 TX58pAncHju2YtWraShdaotsMIAq4SXuYKK8Z2rpxJBnYX2D0Y+UPvRvyOmXM8eNWn4H
 7RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754993631; x=1755598431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLLamhXEah+wWkFwtit2lP3/m+DG0tW3g7dsaAJL4E0=;
 b=wVOyAGCkbmhT+1c2O5kJ6nyYYNRwjd1qjdZVt+JI86fLxCrBmBItJuHyLH2+uXlSGR
 y2NOaFRbc3tNVVK3CljY6qku/xf6PVeqKXfMVd+j4x3lPQg1oRSHwgubjPzc/obFDpHL
 wFHYXSwEkLItAAftOFsVFB1bGxP8LBKd8We/YCC4DvxzaC0uSAOzgGJJzkFwtSU6VA4b
 EPINJGJIY72JLnEi+XL53k9Ib0+pfwQzPC7bn/GYRpq0Kdz9yQ3fHI8jr+emcWEwktsq
 ukZlb/uKCK8o7C12OKSQGI+ElGjNt5BX4ktsvYg4XMGTQyzrk5xwLpRSbn9YYM4bP90m
 aWDQ==
X-Gm-Message-State: AOJu0YyssQNKVl5GIgfHxAaBikhpuLgB04nx3ShimCYlkaCcA7Y6thDm
 V8iSWQbt1Lpt9ANrzBxrcRUoXqzN5XghKfJ6Ts5uxEqfSrOK2vbPnnhM48FXVWBppf4=
X-Gm-Gg: ASbGncv5V1R6N1H+Hfw9rNzkhg92e6coZIqu7TH6hBXMuV/ISimcLltaJgO0wt340pb
 kK35ytyfaeSIKrB9Ns1gntNwvFT292vCWf23+KvmnxSE0FCJKfk9NNQNYOZe4RL0ZeiwVg3+d3b
 5z5kyG91ks8BWGOqsNAmCA2rFw8safI3zB2xVktPTS5W3ksZRAKEyI0oMjc47Z2h6d2UZUpYjWE
 6XDHBdYifbaLBQhoE9GO1adGY3GT53P0aTrP8S0B7Vhs467t3Mp8J22sk/jsfq8+lQ4lmbq7Klg
 ugL/1+79QidWokrZfzspOvDFqEpjoeZuAodv0Xor2JE4HVDl2ecWmpjPWLnZPWu1Cb1em4XvRVx
 uIbxIGwxlqP3fOljTyub9dLVXJOEo346ak/t9P7kpRpA3W2MyYHQ=
X-Google-Smtp-Source: AGHT+IGVVlOlfvHwQPFH9Uj4WXeBVbJbRav2BSi0FKvxF+SDi0A/OD4lbafuKvCFvsJipK2X6GlYzg==
X-Received: by 2002:a5d:5d0e:0:b0:3b8:b33c:b8b0 with SMTP id
 ffacd0b85a97d-3b910fcead6mr2247916f8f.7.1754993631307; 
 Tue, 12 Aug 2025 03:13:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm44090808f8f.44.2025.08.12.03.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 03:13:50 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 11:13:49 +0100
Subject: [PATCH 1/2] soc: ti: k3-navss-ringacc: NULL check before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-k3-navss-v1-1-a88f7db58998@linaro.org>
References: <20250812-k3-navss-v1-0-a88f7db58998@linaro.org>
In-Reply-To: <20250812-k3-navss-v1-0-a88f7db58998@linaro.org>
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

Move the first dereference of ring to after the NULL check has occurred.
This will prevent any possible dereference of NULL.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/soc/ti/k3-navss-ringacc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index 14114a65830..ac29158d489 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -632,12 +632,14 @@ err_free_ops:
 int k3_nav_ringacc_ring_cfg(struct k3_nav_ring *ring,
 			    struct k3_nav_ring_cfg *cfg)
 {
-	struct k3_nav_ringacc *ringacc = ring->parent;
+	struct k3_nav_ringacc *ringacc;
 	int ret = 0;
 
 	if (!ring || !cfg)
 		return -EINVAL;
 
+	ringacc = ring->parent;
+
 	if (ringacc->dual_ring)
 		return k3_dmaring_ring_cfg(ring, cfg);
 

-- 
2.39.5

