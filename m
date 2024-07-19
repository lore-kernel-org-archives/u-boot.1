Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C0BC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2807388BDD;
	Fri, 19 Jul 2024 12:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VHoJaE8F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VHoJaE8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6536E88B9E; Fri, 19 Jul 2024 12:50:33 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8024388BCF
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRKL1hK3z9skR;
 Fri, 19 Jul 2024 12:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RbhfCNPBfBWGO8rRKE4cNM9wLT6ZrMxv/WSDcUXajA=;
 b=VHoJaE8FEQawqaqjSGn5wo6YR0xE1tJRx9zop7AGqMGD+Q0u6ZawOp4mg4vrim6tDIs704
 WJjPwK/GdMZ4looRYhP4RjELOH7s1u72P21uUKfnMSbDXpuhFMyNlB48rGtP9bs/gPscGB
 oSQ1POVjZwr9y3r+pfBSQGFpqXZjp9YAM9pbfy9/jCRXMGfE4mnpKws7UC5jqRTdpGOuF9
 uwg8HSNVxzzg+viW9cUpeV/aMEHdCfu9JwBGH8pT8zJP+ISiI/UQEzKtBOOVimYbZCU79E
 YEXqcvxU2rZwZuY7lBY7nI0DWeKnteuVOB2X6wmV6IxfNrrYN3M41lbfsTmuZw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RbhfCNPBfBWGO8rRKE4cNM9wLT6ZrMxv/WSDcUXajA=;
 b=VHoJaE8FEQawqaqjSGn5wo6YR0xE1tJRx9zop7AGqMGD+Q0u6ZawOp4mg4vrim6tDIs704
 WJjPwK/GdMZ4looRYhP4RjELOH7s1u72P21uUKfnMSbDXpuhFMyNlB48rGtP9bs/gPscGB
 oSQ1POVjZwr9y3r+pfBSQGFpqXZjp9YAM9pbfy9/jCRXMGfE4mnpKws7UC5jqRTdpGOuF9
 uwg8HSNVxzzg+viW9cUpeV/aMEHdCfu9JwBGH8pT8zJP+ISiI/UQEzKtBOOVimYbZCU79E
 YEXqcvxU2rZwZuY7lBY7nI0DWeKnteuVOB2X6wmV6IxfNrrYN3M41lbfsTmuZw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 14/37] board: engicam: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:51 +0200
Message-ID: <20240719104948.323791-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dzrb5sg6nc4o6yk4881fx3443xd5tdwd
X-MBO-RS-ID: 27cbdb25d4ee805d83a
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/engicam/imx6q/imx6q.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/engicam/imx6q/imx6q.c b/board/engicam/imx6q/imx6q.c
index d799fe6526a..a8d54128476 100644
--- a/board/engicam/imx6q/imx6q.c
+++ b/board/engicam/imx6q/imx6q.c
@@ -5,7 +5,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <linux/sizes.h>
-- 
2.43.0

