Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2896CA1017
	for <u-boot@archiver.kernel.org>; Sun,  7 Sep 2025 14:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37590803CC;
	Sun,  7 Sep 2025 16:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="oax/M4WR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE60080422; Sun,  7 Sep 2025 16:36:35 +0200 (CEST)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2F7A805D7
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 16:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1757255793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3oZR+Pte6SydUPb4c/XmU6pUzaBpYwUXhyuYUynkwU=;
 b=oax/M4WRF3xj8LdXWkd3JGGwLJBjFxchXu90Z7ZQj50MsLRcWCHP9OhEq77tlWu+RluGZI
 0inwvltPrGcj5PT06OXqhDYpGdoEhooH6W+hbIr9UafPNELFUuFzka459G5p4y6aQN8pB7
 yFmovbMeY6qzhRKUsXdzDj9PEa8/zoSSSjTMsYnpjZQghlIRBE0/Rv0rgMaF6d0/F6t3UE
 Pv1TowLRftzC++9N1ogV62yQdwd7lx5ERkBDyrjbOx5vRm2nW7fMiRsRRb7MjtcKPPft9R
 oA6RJ5Zo0E9LHZf4mLvStDTJfdmL7jzR/jvFe2ZitmO6DRPY53O21jf+SV/CJQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 07 Sep 2025 14:36:09 +0000
Subject: [PATCH RFC 3/9] mmc: meson_gx_mmc: don't bail if there is no clock
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250907-spl-gx-v1-3-37395d9ff5af@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ZAqe53vXbc3r6mJD0G2dDahAiGeTIuetSy5hg5sR3mU=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBovZhq8VwigyBR9Ev9X8AlUNcsjmEUGY7e1Zim+
 QdeespNyEGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaL2YagAKCRCEr8vQ14ma
 Aw1OD/9IKwmcD91DICwg9lxqBYmjEcxSsir0PbygQTeVXWtAcwrotzqakDOPglKSYBA8P5IUtSl
 oKvhGXHO+3hquxDCgUJqSJ3WCWhRKlRWz8JvCuGYXFXeqE2lCiA7h8G+ilen2ELJ1wRjd3+WQnj
 4vk8K/IUCjTCB4gEmt48a4uH1UEv1piVK6CJXhh3NVr0p85ZQ+QvV99pIbqM7bj52sEtSMFrSUr
 G5DsmCtVt5XFDcqt6w7mNdZXKL+o8n1ASIsZeUHCio7YMGtQquyb36ZD6Kb8xMH6VIe56ERi3n6
 Ix/NfkeV8AIgvymYqfpheqM/arGzuKTyqrxlFFBvqFgu2oRhxyN3veUhtIEVEWzQCKjXxqJa9oQ
 t/t2MaU49bgPKJNi6I7gYYhnYAev4bJjOpoijpeIMx2aAWs+b3keJhr4RCteEwDHS1nIGRUjmCX
 3uMoey9GzmImyuiVH+DPzwgrAHTT8ltes7rIqNUtMYfUlJarcR1j4kHnBsasrOzZi8hoftCjpkE
 6qE3/7lLfQWNhBpBPL+6tOKQamadVbQ8CcsfsxIKXFMuCse9KZvZNSMsedAC6qQp75oCNwC6UHm
 zPH01IifQLNBZs7CW4RXyDfMQFQx+Vrvj9FHvb8u5ITuWNZq8/Qcaw8eRDRJX9LWhdan4toGCvh
 0i0O8UmTxD6/vmQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

The clock driver is too big for U-Boot SPL at the moment.  In the
meantime, continue mmc init even if it is not present.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 drivers/mmc/meson_gx_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index a4338f1e29c1da07acb0333be9b75a318cba1334..d83a79fa0894fc6a32c40642ebce5f845120efaf 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -332,11 +332,11 @@ static int meson_mmc_probe(struct udevice *dev)
 
 	/* Enable the clocks feeding the MMC controller */
 	ret = clk_get_bulk(dev, &clocks);
-	if (ret)
+	if (ret && ret != -ENOSYS)
 		return ret;
 
 	ret = clk_enable_bulk(&clocks);
-	if (ret)
+	if (ret && ret != -ENOSYS)
 		return ret;
 
 	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |

-- 
2.51.0

