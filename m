Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED33CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FAB884D66;
	Sat,  9 May 2026 17:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EKOyjVl9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bWKMKQYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA83284CEC; Sat,  9 May 2026 17:13:23 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661C384CC7
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gCTyR1X1mz9tjH;
 Sat,  9 May 2026 17:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fja3hlsv7NhCBcLcY/jhfm5tXnrS8krepU9ms+RmD38=;
 b=EKOyjVl9AO5w95e8tezExzFyT4wSJk3ZH+81rERHpFxqmyC0n07pNJHTbmPZ3HH9MVuKV8
 y8uzPC2EiyBzLPKTmwwbhpkS8j3vzpH/k2Alm2o2ZTJAl7sQXqUydgMG6a2a6eeBq5e2kp
 DI3noGOr+RWJVE/ysIQsoto5pWwubT5BJC6fpFub8Pfdjra3lbSrKiJSMWwTRr3Q4w+wj7
 2c/6KukJFrpKMwr5bfXEn2CUfG4lrFZGPQtLrSbiDIvpCWlEMYsUvcoj/bAFkwjOuT/Uw6
 +HQ4rSb9ISPbOK+bVc0hTLYeOvO0eHj+Ig1jbt34KaZ8bRtSIFqwWYXS7V3Uew==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bWKMKQYA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fja3hlsv7NhCBcLcY/jhfm5tXnrS8krepU9ms+RmD38=;
 b=bWKMKQYAn2k9bLvBdczJrlAZ7661NRaGYNUZ8CcROQUXEOy5929f/9aEUgDifB0KMBEQJu
 WaQEXimzY0yJXBtaw/4OCM9uWqQPtsYQEz9ZqsJGBibKbSLp/tw7U3q+ey7NIU8o0ETx7k
 496EboNoKOntBCkuZvFuaqhndoN/jlx5R70rdsnrMfaWAFKc31Bzm1eMt35ykxrBqRdWNL
 nGMP6pucT1+roHgPqEulXyhPiYTRnRdU8Bo8ChUPcCDbOHs6E/3VVELulxQaAGzBGydBWu
 PhlnNPgWZnaVtky68ky8ozZLCrj6GsZYn21PZKPYBBUHT0JRtldA5RRsCwKEHg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/14] reset: bcm6345: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:27 +0200
Message-ID: <20260509151308.23067-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6m8ih8kmqnzcsu87fpki6gs7kp5zg9um
X-MBO-RS-ID: bc06d43bd00de75be41
X-Rspamd-Queue-Id: 4gCTyR1X1mz9tjH
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
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/reset-bcm6345.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-bcm6345.c b/drivers/reset/reset-bcm6345.c
index 6f140574216..161d00d1b0c 100644
--- a/drivers/reset/reset-bcm6345.c
+++ b/drivers/reset/reset-bcm6345.c
@@ -49,7 +49,7 @@ static int bcm6345_reset_request(struct reset_ctl *rst)
 	return bcm6345_reset_assert(rst);
 }
 
-struct reset_ops bcm6345_reset_reset_ops = {
+static const struct reset_ops bcm6345_reset_reset_ops = {
 	.request = bcm6345_reset_request,
 	.rst_assert = bcm6345_reset_assert,
 	.rst_deassert = bcm6345_reset_deassert,
-- 
2.53.0

