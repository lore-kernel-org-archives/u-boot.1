Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED5CC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 03:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43733885A0;
	Sat, 18 May 2024 05:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="SkuireUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F63884AC; Sat, 18 May 2024 05:55:25 +0200 (CEST)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA16A885D1
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Envelope-To: contact@jookia.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1716004523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qk3SWYrHO030nbIshZ7k5LNdi0+IQAc8D7b6QkVc0H4=;
 b=SkuireUv9/A7KhsRkFm0DITp0g1VXuIy/r+Uzhh2RfIx7x4MKW9cOPRdmfqr6w4FKveof+
 3F9jOOKKCAg9hEWSNnDtJMJGKNL8T+fud6OSN5/B5cNTh2m43Ttgtc5YMcHiKn3ZvXWh+E
 U0WTz+hYP3LVh2HnYcyOhx9hRXV3nPKVr699Yh4A/mk6G4A1Uf8VmggNF+WcQ68GIRiG+G
 XEKOfmA76nYHcw+ecls25tO2OMcJV6Aa5/GbtewJ67VC6GmbFYyp3nR5tkUhEjWPO3mCW2
 McVXHryCJF1MJMdVU/dYnHiZDIe358aQGqGGzaD+92CgYyjZ2XEPh21Q3ivPZw==
X-Envelope-To: lukma@denx.de
X-Envelope-To: rick@andestech.com
X-Envelope-To: seanga2@gmail.com
X-Envelope-To: ycliang@andestech.com
X-Envelope-To: sumit.garg@linaro.org
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: jagan@amarulasolutions.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Sat, 18 May 2024 13:54:44 +1000
Subject: [PATCH RFC 2/4] pinctrl: sunxi: Add PWM7 pinctrl for the D1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-pwm_d1-v1-2-311fc5fe2248@jookia.org>
References: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
In-Reply-To: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1716004490; l=750;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=6bTlha38aNs4J1rib2aurYVoiRH4rAEaIAGHCBwenas=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAi/l2D9HPMoxF83QH12Cjh8r
 EK01YUI3aygzeXCXj9oDvLEFn4DPU3uIjP0le+nRZWwdOyojysHtmagaow/XBCwUAAPRL
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
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

This is currently only used for PD22 on the Mango Pi MQ-Dual.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 37ea93715d..b3f2568ffe 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -615,6 +615,7 @@ static const struct sunxi_pinctrl_function sun20i_d1_pinctrl_functions[] = {
 	{ "uart1",	2 },	/* PG6-PG7 */
 	{ "uart2",	7 },	/* PB0-PB1 */
 	{ "uart3",	7 },	/* PB6-PB7 */
+	{ "pwm7",	5 },	/* PD22 */
 };
 
 static const struct sunxi_pinctrl_desc __maybe_unused sun20i_d1_pinctrl_desc = {

-- 
2.45.1

