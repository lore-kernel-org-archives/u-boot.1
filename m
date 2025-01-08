Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10FDE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C706805FB;
	Wed,  8 Jan 2025 16:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="aGaA+U/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B31B800DF; Wed,  8 Jan 2025 13:00:29 +0100 (CET)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5598280040
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 13:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1736337618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/qAekYVsODDjDI6/sqF2Sx3Li2pWHg1qcQ+KcWbIvRk=;
 b=aGaA+U/wlXP6BEy8L8UOgaLzWqFGKiyPDs4YQhwISVxcGsbAYg/TzJ/sWT0sapz0zrylFw
 Aa+d8CdMxfMM7o8og8Ex0KkG+JaJIOE6FGSCioxJuDE31L4sBHRgjiLmmapANjlFVsY5tB
 AymwVoAZiB+m20PvaXSDnUqT3FE1YoBABy3K8ILRql+ycVhzBr88XUBsL/7T6gUog6pJZl
 kQf6gMwZwIzSHQO9wtw/ZJLsqpYqZbL7i6XMeD3gu231m7ezTPn1pycwHTzymTiCA8FlU4
 e8y1GJQMW4yMQqF/5nS1XO1L4wJaKSNCF+tL/iMoPq75Kk7kkXA7baXufMOQWg==
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH 1/4] clk/qcom: Print more details about stuck GDSC
Date: Wed,  8 Jan 2025 14:59:08 +0300
Message-ID: <20250108115911.4163437-1-alexeymin@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:48:26 +0100
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

Clearly say whether it's stuck during power on or power off.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 drivers/clk/qcom/clock-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 25ca67e537d1..1cfc430c14a5 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -496,8 +496,8 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
 					 GDSC_STATUS_POLL_TIMEOUT_US);
 
 	if (ret == -ETIMEDOUT)
-		printf("WARNING: GDSC %lu is stuck during power on/off\n",
-		       pwr->id);
+		printf("WARNING: GDSC %lu is stuck during power o%s\n",
+		       pwr->id, on ? "n" : "ff");
 	return ret;
 }
 
-- 
2.45.2

