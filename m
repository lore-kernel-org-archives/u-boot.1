Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D94CAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 13:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA6180107;
	Thu, 25 Sep 2025 15:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fQbH/EPg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CVBUO0Fd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B652780B9B; Thu, 25 Sep 2025 15:48:21 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4DE8004F
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cXZmg1r82z9tTZ;
 Thu, 25 Sep 2025 15:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758808099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rRsWKhd8jlN+hBx2/uK01vocMQZmkOfV9kamqJqtUR0=;
 b=fQbH/EPgk+fqk/bvWS1SafXuW0MC6yf4WH+6LdyubI6SMQlbkFbMgcJYn4FBsPxQBgCyQd
 tBkQQnYDpuPC23qDdxgNGvRchDG8TYvJ7cZ0JAR6FlDaOcdqWvkDfCKJ5mgdshGCMEyEtx
 OqPSV10PdD/C2ypCH3kja6gByGc/uDPPlTa3nKdPxkPlHncK/R35hOHdDZIy9TbVHFi75Z
 pZ9mZeRkFIDcI502ibAs3Zt4Z9S9cuBrOtJI5He/SHYfBrYMFVH7HAaPUsvbmjtN6M17v9
 /QbZkuXdvNeOMR8iACPLl+UdVsJ086SlRk6GltSZxbpjR8XQSXamsJ/VlDW97Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CVBUO0Fd;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758808097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rRsWKhd8jlN+hBx2/uK01vocMQZmkOfV9kamqJqtUR0=;
 b=CVBUO0FdHk6cWM4+68B/cpY5jZnGRFMlW9zfioSNpSykWsRoG+WwctwTQHkjgzl5plRXey
 jST4b+w87uetPkQcYPXIiX5+tT4LTy6vo+IorJokIoVg9YWKBoNNSHeL7zU9RlaSR1rVmC
 QXccmKyN3LnqwftMtfTtn7SrMCuEi6+XeKkpOy/T55r62vJippfyEjlzDBmGkPt7xrQ9j/
 TOMRp9e8mAZ8SwwFgvo8UcxE+YF65AUnRlkHL/YUqf36nz/E1UALSARa1wxc+XwnYir5tL
 cnfa07cnYbw8E5UVTFebjzJOm7+VFmkfKQZjvHrY54uM9RTR6mxCnakKB/UA6A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mkimage: Add help text for bundling TFA BL31 in mkimage -f
 auto
Date: Thu, 25 Sep 2025 15:47:35 +0200
Message-ID: <20250925134804.66689-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q61j756dxpf53fgsi4gyx1ozsob7c7c4
X-MBO-RS-ID: 7f7111131e9d1aadad8
X-Rspamd-Queue-Id: 4cXZmg1r82z9tTZ
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

Add missing help text for the -y and -Y parameters of mkimage.

Fixes: 6dfd14e1228e ("mkimage: Add support for bundling TFA BL31 in mkimage -f auto")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Carlos López" <carlos.lopezr4096@gmail.com>
Cc: Aristo Chen <jj251510319013@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 tools/mkimage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mkimage.c b/tools/mkimage.c
index 12183270776..a800f9507bf 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -101,6 +101,8 @@ static void usage(const char *msg)
 		"          -d ==> use image data from 'datafile'\n"
 		"          -x ==> set XIP (execute in place)\n"
 		"          -s ==> create an image with no data\n"
+		"          -y ==> append TFA BL31 file to the image\n"
+		"          -Y ==> set TFA BL31 file load and entry point address\n"
 		"          -v ==> verbose\n",
 		params.cmdname);
 	fprintf(stderr,
-- 
2.51.0

