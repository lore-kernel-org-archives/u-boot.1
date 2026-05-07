Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39019CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA57284C29;
	Fri,  8 May 2026 00:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mzPLyXal";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fdJm5Rax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB9F84C29; Fri,  8 May 2026 00:07:08 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D334A84C25
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBRDm1NbZz9thT;
 Fri,  8 May 2026 00:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMMr/SfSMpEZH9Y5fWPidwJvidk4gKxUIqvf4FxKlrM=;
 b=mzPLyXalEYtRAC24fLPoDYnSRp0N44y+zFETKXlWCIt7utNjoi4jjJ+RkcmCP5Iw/hhWN1
 YG2aiUd952m4ZJ3JE/FP4aqZDUV2WqXVRtUFAIxnbfzPAK2DtU2UivhskIrFCRpCjkaJFR
 qPF+ZYtAyqfb66q86WSN5dby3lyVmHWkUCHBkHbyYSF4BZzOHzM0GoDm4Ceceqp4rmSIO5
 QC4Z28khZb+eTOAd7vMKtVUtMMnerw7gY9LcxEM2GIMLiq9lzmIXyAwwA2lKEgSS4eIVBf
 2QRKfbgQVTfq9MYhyyhMXTcdtONAF+mFvh2lYBjgwZjzbLFRiUiLAqxS6hx8ZA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fdJm5Rax;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMMr/SfSMpEZH9Y5fWPidwJvidk4gKxUIqvf4FxKlrM=;
 b=fdJm5RaxeGOwe4Q0G7NshEMCoW8pbTF7TnSUqjOqXvzR7DZYVLb01jfUtBzXOhKBJtGmcq
 MUA8EK37wwFlgJty9xmx0dNcpX2UjVbEibdBuB/mxZBcuYAUpdpx+Tt+FOJXns0psbaGIZ
 +5b6NO32qbeW+7LDjX2gxsk78wU/5UhlZNnBGlddB5tdpZnQbrIbihkSSaiIBw+NnTF1tM
 UBfUluwfYkWiALiTSgYHVdbKqZI2seq1u37EQyHub4+c0gHmME1qKKkEfpcWuSd5EqeAin
 yuBzVr2nfwTCpQRVzu/zYtgWwyUWtYhFmMYiWMwunaTyNX0suSnSlKEePWmm8Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 6/6] mailbox: stm32-ipcc: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:06:33 +0200
Message-ID: <20260507220651.209168-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: e8p89ujirhi8jh93u39xija5xspoqr4b
X-MBO-RS-ID: 60a502365dccda57036
X-Rspamd-Queue-Id: 4gBRDm1NbZz9thT
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
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/mailbox/stm32-ipcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index dda108735fc..49f7795b3cd 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -147,7 +147,7 @@ static const struct udevice_id stm32_ipcc_ids[] = {
 	{ }
 };
 
-struct mbox_ops stm32_ipcc_mbox_ops = {
+static const struct mbox_ops stm32_ipcc_mbox_ops = {
 	.request = stm32_ipcc_request,
 	.rfree = stm32_ipcc_free,
 	.send = stm32_ipcc_send,
-- 
2.53.0

