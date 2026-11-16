Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244CD606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aHTOz1zg;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=N1Fq55AQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF08A40795;
	Mon, 16 Nov 2026 17:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zs3goDs_AxxG; Mon, 16 Nov 2026 17:44:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 253984076E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794851096;
	b=Lywfocj8/ELHmcyvGbNHF9dG9tviByJQcNfe/oofmI7+zquHNOBKp3pYVHq08XG+brB5
	 U1xEHP9hH7GbpSNQNUkcz50azy6+c5CgBf8T+LLP6/nJiaU0f1sgArpRXfKqGmBrynJLY
	 DSK59uxm3FqicmpSahy7+9WuWPpIjZxzl2Gd433B0RfgvtU8VwoZV8BPJTfULE0reYWsQ
	 sm0cb9A6EKh07Jmcj8ZDuBzsez8zNtozkXkHy3SX3TEqNiNiA5VVvt9neXWExW/fVVvou
	 D3QA8kir8E7DZvS9G+vF4QdtFNX8e9c3mL8G1Cim4aDtSxor63uBe4oMZEUclNwJEUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794851096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=19SU79c/dKy70MeuqnzIopypOzcTe5r+dn3rgoHv+b8=;
	b=Dx/ScYfoLAnmSI6vUkrJ1lE2U9isSIILR1k+ayTBuIMlXJxoChth9jH67smH3fT3jCZD
	 NMY8NTqgl8flddeaQRMBri7FgJb4ATPLo5JJE64JJUk7akgfh1+8M1epnVs6YgKznogUu
	 /0T8M9hLNCNWcu7W7qqpP2K2h6iKdCaoQR7UD/xZPuMh5sS7ahNuM+uG8HDsdLHwby/HW
	 Z5/ayNBFKyuWE4rMynFNq1c3/NTzbyynpkmWce4VqRdpY8RYEQVkrZHgoDxHpHiJQoaLI
	 ADMDuOSmqytY/v3KOj5AKukMZ93JJCdbOsBxUEjhrheKiBD0JxeyF9OpgBIHWol+9xg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=N1Fq55AQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794851096;
	bh=19SU79c/dKy70MeuqnzIopypOzcTe5r+dn3rgoHv+b8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aHTOz1zgcEqotLCZV/K6WigWznumb7HSqPzB/EhusgHDIStvnKPXN1JkLOqpYK2js
	 e5MlyuQGejNioQgPR6lsZed4AuvyeYyuRFgciDfUFegeJi1nB0cDu9mazj1MXIppRV
	 +9IPgiPTBcnUq6mxplwESV3jVK0d1+OsKEBhNdmCuHqaYfrnLsTQA1crhoqj0qXKyo
	 /O73lFx5bohuT6AdTg6BYRhD3D9zrZyfIa1g26zQto66sid25P9p5Zr4DMKHoPgfKk
	 7EpyZ36N3z6C10ybGhgrqio2DgVp8U6xk817jDZOqwn5DhBvfNClwj+MfeHIL+VRJS
	 4czmRslSXfDzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 253984076E;
	Mon, 16 Nov 2026 17:44:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D01E176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2ECDF4076E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GVEFR9cl_eOl for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 663BD40756
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=N1Fq55AQ
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 663BD40756
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSwH53KXKzMllQ;
 Mon, 16 Nov 2026 18:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794851089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=19SU79c/dKy70MeuqnzIopypOzcTe5r+dn3rgoHv+b8=;
 b=N1Fq55AQox7pPnYjx6OoX9oKMiQTGd3bGKDiMsL/lLVSEahLjcc8DQonKhw676K0sbKLYD
 15rleHZB02K+WgDNGt98KdZEghx2ghnr3V8/aE90oTo7xbpXCnfZjiCyLDNAdaHc8nuet2
 3W6mfP4T/57iXeDuqzoiuinW2mB20YhvEYr/7nrfIW6+2FCwbxeVK+wDmb9NOz57ptocSG
 ItwFVvMFR1pxux+K/jN2nnuh4GkUBEOZCNj71Jg7VQKBZbQM0yS6l49Uvev0uu4foWyi/u
 P0xQ2yGt+AktHrRrfF1Jfjz4uzNJrzgTVysoPaDnxhgswMQT030YUS/dP5ZTVg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: Constify driver ops
Date: Mon, 16 Nov 2026 18:44:42 +0100
Message-ID: <20261116174446.3488393-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5f71df1c32280022875
X-MBO-RS-META: ahafqh83qkzzb6ma4iufonbs4ebgcy8c
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/usb/gadget/dwc2_udc_otg.c | 2 +-
 drivers/usb/musb-new/am35x.c      | 2 +-
 drivers/usb/musb-new/musb_core.c  | 2 +-
 drivers/usb/musb-new/musb_dsps.c  | 2 +-
 drivers/usb/tcpm/fusb302.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 4dc049d64b1..e680cf6c64b 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -136,7 +136,7 @@ void *get_udc_gadget_private_data(struct usb_gadget *gadget)
 	return gadget->dev.device_data;
 }
 
-static struct usb_ep_ops dwc2_ep_ops = {
+static const struct usb_ep_ops dwc2_ep_ops = {
 	.enable = dwc2_ep_enable,
 	.disable = dwc2_ep_disable,
 
diff --git a/drivers/usb/musb-new/am35x.c b/drivers/usb/musb-new/am35x.c
index ca4d798642e..572abd2b50d 100644
--- a/drivers/usb/musb-new/am35x.c
+++ b/drivers/usb/musb-new/am35x.c
@@ -666,7 +666,7 @@ static int am35x_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops am35x_pm_ops = {
+static const struct dev_pm_ops am35x_pm_ops = {
 	.suspend	= am35x_suspend,
 	.resume		= am35x_resume,
 };
diff --git a/drivers/usb/musb-new/musb_core.c b/drivers/usb/musb-new/musb_core.c
index 17ec0d3acbd..7856af42ba9 100644
--- a/drivers/usb/musb-new/musb_core.c
+++ b/drivers/usb/musb-new/musb_core.c
@@ -205,7 +205,7 @@ out:
 	return ret;
 }
 
-static struct usb_phy_io_ops musb_ulpi_access = {
+static const struct usb_phy_io_ops musb_ulpi_access = {
 	.read = musb_ulpi_read,
 	.write = musb_ulpi_write,
 };
diff --git a/drivers/usb/musb-new/musb_dsps.c b/drivers/usb/musb-new/musb_dsps.c
index b73f3531ce2..41d1d3db586 100644
--- a/drivers/usb/musb-new/musb_dsps.c
+++ b/drivers/usb/musb-new/musb_dsps.c
@@ -508,7 +508,7 @@ static int dsps_musb_exit(struct musb *musb)
 }
 
 #ifndef __UBOOT__
-static struct musb_platform_ops dsps_ops = {
+static const struct musb_platform_ops dsps_ops = {
 #else
 struct musb_platform_ops musb_dsps_ops = {
 #endif
diff --git a/drivers/usb/tcpm/fusb302.c b/drivers/usb/tcpm/fusb302.c
index fe93ff3d339..b77fe0fa204 100644
--- a/drivers/usb/tcpm/fusb302.c
+++ b/drivers/usb/tcpm/fusb302.c
@@ -1293,7 +1293,7 @@ static int fusb302_get_connector_node(struct udevice *dev, ofnode *connector_nod
 	return 0;
 }
 
-static struct dm_tcpm_ops fusb302_ops = {
+static const struct dm_tcpm_ops fusb302_ops = {
 	.get_connector_node = fusb302_get_connector_node,
 	.init = fusb302_init,
 	.get_vbus = fusb302_get_vbus,
-- 
2.53.0

