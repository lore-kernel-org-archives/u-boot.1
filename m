Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2309CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8940846FD;
	Sun, 10 May 2026 19:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SaqNHYsZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S0XTIWL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7504846FA; Sun, 10 May 2026 19:17:10 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F21B846F2
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gD8fg33pNz9vC5;
 Sun, 10 May 2026 19:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwF+lumBrjLtDCPqtKCkZ5BsSkOilQZ4fMRjZ+xmIPA=;
 b=SaqNHYsZpNEUX30TqKlLNKdFWqILLo89M/kADz07QRm0dIXcKhe3qLZb1Duh5Wt1Y7Mbw8
 lQ9SwMvKpvp16ntDF7so5aRaCFIckSMyyqGQLmkMDolG5t5jqbmIKutTgdtAMwIwteEH5Z
 W/8+cemfLmOYTH4+5cyew383m7fnbrZaKYFYenwbDpgFFwcnYz1J5FC/Hmalz1EXqRll4I
 4M8/EbyOSMbvalrcb4RwYEdlExqxyXuUrRz5qB+qAIpjqt65lPfkULv9/SC0N68sFEmEbV
 SO8J1WRhVv67txk29nHVpBb4T2RL9H5xsmfAdaO2ejCQsuCa2prZf6cKDMkx2Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwF+lumBrjLtDCPqtKCkZ5BsSkOilQZ4fMRjZ+xmIPA=;
 b=S0XTIWL2GLQ22CVnvkzUkHhpEGwrsiwTHudBxcLWHtOm26aQqgg/BthiWvO3Xw5h8PRzx7
 uakzclXZBnx5RhS1rUUkHHpzzkiP70ssAZLUnBMMoMplBjWwOXELNnDHGpEekp6T/6qAS+
 q4DwOzNBjvWYALewLtwPkgGi4uUWcBiKBBQE5xExhmFpgHAVHXOmhmrkP02cbMNDet2iaM
 XdRJIt8BWI4ZRLN4Qx+vs3X1RaagfrFJ+oBgnBWIW15zL1Aofr8SwbHT+ehqbYnj6envXk
 TP1beXMBfpZlq44MyMKJKknR7EqdYKwLuzGyg08+DpXQF/E+NwGPqm4BeDuo8g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] usb: dwc3: generic: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:16:33 +0200
Message-ID: <20260510171649.56837-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
References: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fd7d087cf1b3ce8ab50
X-MBO-RS-META: hwrptbqjqqyokcjud13hnpjotttwecf3
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/dwc3/dwc3-generic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 22b9ef0b24e..2356b3bc0aa 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -330,7 +330,7 @@ void dwc3_imx8mp_glue_configure(struct udevice *dev, int index,
 	unmap_physmem(base, MAP_NOCACHE);
 }
 
-struct dwc3_glue_ops imx8mp_ops = {
+static const struct dwc3_glue_ops imx8mp_ops = {
 	.glue_configure = dwc3_imx8mp_glue_configure,
 };
 
@@ -414,7 +414,7 @@ enum dwc3_omap_utmi_mode {
 	unmap_physmem(base, MAP_NOCACHE);
 }
 
-struct dwc3_glue_ops ti_ops = {
+static const struct dwc3_glue_ops ti_ops = {
 	.glue_configure = dwc3_ti_glue_configure,
 };
 
@@ -506,16 +506,16 @@ static int dwc3_flat_dt_get_ctrl_dev(struct udevice *dev, ofnode *node)
 	return 0;
 }
 
-struct dwc3_glue_ops qcom_ops = {
+static const struct dwc3_glue_ops qcom_ops = {
 	.glue_configure = dwc3_qcom_glue_configure,
 };
 
-struct dwc3_glue_ops qcom_flat_dt_ops = {
+static const struct dwc3_glue_ops qcom_flat_dt_ops = {
 	.glue_configure = dwc3_qcom_glue_configure,
 	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
 };
 
-struct dwc3_glue_ops rk_ops = {
+static const struct dwc3_glue_ops rk_ops = {
 	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
 };
 
-- 
2.53.0

