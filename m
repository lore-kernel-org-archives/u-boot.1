Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46027CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 880A384D3F;
	Sat,  9 May 2026 17:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HHYaALwE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M83GB5Td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79B884D13; Sat,  9 May 2026 17:13:19 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED4F84CEC
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gCTyP4x8qz9tjH;
 Sat,  9 May 2026 17:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mmrklXFfkDXNdX6X2g6TXARxXdSadelQx52c2/yfus=;
 b=HHYaALwELiKxSa14ihOLfMd1AWymZdQ50NyyZJ7PxbblQqoLgX0S6wGxIst0fYh21cgVEA
 DUyohe3zWPLb0zdLBqLA9a5hP4iMANEKSE9KS9McPlrJRa57ugLI5rze6OXaV270cOvVYr
 LM5yPMRw1ITJyKQDbkEMza46sE0S3c/QIbbzFK6K2lAgYgknPB+n75KJeMICd2E8eqVzij
 4+4UfHFFjUSQevVyWbdtge5gTP+ighQMg7tzoEJr4nI4Ww9q6NTOlZY+uVMTWDy7UsfkEF
 DHEmbAIBeqQs58d2pXij+16etPZbsIS+ihaoORxxSsc67OJZjLd7WBIG8iyIWA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mmrklXFfkDXNdX6X2g6TXARxXdSadelQx52c2/yfus=;
 b=M83GB5TdbcnV+gpjqXCEGGmI86QqjPxdrbblYV61uWa0RdBWr+RlwZp/UGa3mj+/D6DPV3
 CKJuQH4shCZjKE6PAbdrvhOS7x/Vd5L+UiBQU0UwCrbwCY3TiUnVrhReJ2L83iEbAbaaTq
 pPHDRymCJ7aGRG2K+pbzuS2nwWsyE3+QKFPMGBUrM/zNCYNVizIWd9qn9H7z/fIrGCXIsD
 Xet7zD813dOdEFcI0YAwhiw8ICYF6Mu4pbcWQJPz9v1CceH8Q0pQV4FmAeG+x2/xcs4cga
 WICjIUTJ9RsH9kWHDeT22FTdyHswvPauK6dXKjYLs9hjbU5mSDRe3WP/t45gJw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/14] reset: ast2600: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:25 +0200
Message-ID: <20260509151308.23067-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ih9rti64yysop6qdh89n7kq6q8szhsxs
X-MBO-RS-ID: c6431cfc3398aa9cfab
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
 drivers/reset/reset-ast2600.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-ast2600.c b/drivers/reset/reset-ast2600.c
index ec7b9b6625d..9b77f6c2b71 100644
--- a/drivers/reset/reset-ast2600.c
+++ b/drivers/reset/reset-ast2600.c
@@ -90,7 +90,7 @@ static const struct udevice_id ast2600_reset_ids[] = {
 	{ }
 };
 
-struct reset_ops ast2600_reset_ops = {
+static const struct reset_ops ast2600_reset_ops = {
 	.rst_assert = ast2600_reset_assert,
 	.rst_deassert = ast2600_reset_deassert,
 	.rst_status = ast2600_reset_status,
-- 
2.53.0

