Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747E7CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091E184D9A;
	Sat,  9 May 2026 17:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M+b+A+C+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YDkYNRx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4990884CEC; Sat,  9 May 2026 17:13:30 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFCA84CC7
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gCTyb22s9z9tKq;
 Sat,  9 May 2026 17:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iY/bAk9jcLwxqCNmAUmp6A/rQyGxhL71K9CIFrQzpcg=;
 b=M+b+A+C+DauEn0CfPgn3uNzXRXVM6scAkTGgWxOCDhk2b/o2yIXnM7atU8eTLAePCI0Quj
 fy0FaSrYFcWdJ1qWQpHpfGVSpYPRSZIlz3ydQq6KIpeKLo4bdYf13lD8J6mN5UtY7ewHv2
 RtDzmnckLWg0cQZpYN0McRjBGLSIir0hVdeCMn+q/pjH0F/YImSLKbSm9dJSmItdDHI8hb
 ZuJ+2qdRjckXHvXLQnPDnTukK+VMN6GfJUuotw1qTUCAzuRAlulvCHxk8aAbwG1kgH15VZ
 PNFXxNRfVqRVw1BnaC+1jSfJvkjAwWHYh2ho8Q65Eci/4XuM8HMfiRHS3Pvocw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iY/bAk9jcLwxqCNmAUmp6A/rQyGxhL71K9CIFrQzpcg=;
 b=YDkYNRx8pcrTEQmVgt/HlMsyjTs3oi6LQf96fhZB9oVxho7dHftNxwwHImSJDJbCOV8hvc
 nfYSIMSJi1yn8+HiFQu3EFcbh6s2QF3yTOd4ZstYmqcl1o6oHMfWlZMizExz3yjr48vETZ
 TC+kfkcpvSZ3yYqz+wHDiap11Xdiv1Iff5myhjnUnhhdWHR4w+rELxjgI5tSfGuwhya4ni
 xt3IL6pW9LFz1Q8TyjJaBL8liX8MnaPNq776OoSB1P3aO9PC5yjAZT51F+qOw79mjxXxbT
 6QqmJS+XaU1o2e1rf3wAOWCxXYQCdpDHiya58HMDjY4pCPIRwiaZkM4T+XjVHw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/14] reset: sunxi: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:33 +0200
Message-ID: <20260509151308.23067-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: x4j9c3843aer973ea8kq4yuwwxqcnt3c
X-MBO-RS-ID: 4ee909b824da25b9ef5
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
 drivers/reset/reset-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index fd47e1f9e37..6195edd5b2f 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -67,7 +67,7 @@ static int sunxi_reset_deassert(struct reset_ctl *reset_ctl)
 	return sunxi_set_reset(reset_ctl, true);
 }
 
-struct reset_ops sunxi_reset_ops = {
+static const struct reset_ops sunxi_reset_ops = {
 	.request = sunxi_reset_request,
 	.rst_assert = sunxi_reset_assert,
 	.rst_deassert = sunxi_reset_deassert,
-- 
2.53.0

