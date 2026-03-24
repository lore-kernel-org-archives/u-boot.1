Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A52FEC0EC
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 17:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFD883952;
	Tue, 24 Mar 2026 18:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="ppAXRF56";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="Y7pwTIrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D3F838BB; Tue, 24 Mar 2026 18:02:41 +0100 (CET)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477BD80087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 18:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=lq7PZ9mIFMKaa6yvhGmpugAS/9LWugxDF/81Wc2hUmI=;
 b=ppAXRF56gzZxAvNideIw7f7na08TfiyGSSEs2ZBYUrYgqME/hN35tBkCBrR4ffoXKaYVK6iNJ7V/2
 6RQUkxX++nVFqbyJyaOUoG7SA1Yq8C33/Hr8oNYOvDgUk/Xk0INhh+JHvpK907tvPIUMtPxJ5OS/QZ
 hE3SS4OlEjTJ3CzM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=lq7PZ9mIFMKaa6yvhGmpugAS/9LWugxDF/81Wc2hUmI=;
 b=Y7pwTIrVXnYav1bdw3um3ZsMJW8PIxv5hdZxTU83jHTx/iQOHrzSHannGlG3/MLkOvblAQSgi1+9G
 PveTQ6K1CAh+jqCgrkEc8f4ycT9Dz8b+sllzn0THzNPtZTHlAreGBX2om7J/+eeeDiutFUSbi2whaJ
 seCsryy1kFohdroP8diwuhdvVWdV2qkiRz8/46IPMkEt4fRaGOdePeLlZV2Kb9JTqcuXLzZJxbQpwo
 zu8F9jqajT7mhisotoGGphWH1tBbA8+PFzEN2FpdyRfYUZgzgK2ak9wsX8MRCD9dXP4VeLa7mfU/6l
 4CkF+MiZBHt4hKrHnuT2tR+1Y3zBt1g==
X-Originating-IP: 20.82.50.241
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 41a81992-27a3-11f1-be08-754228886235
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 41a81992-27a3-11f1-be08-754228886235:5
CFBL-Address: prvs=0543124a45=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000331.corp.hitachi-powergrids.com (unknown
 [20.82.50.241]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 41a81992-27a3-11f1-be08-754228886235;
 Tue, 24 Mar 2026 17:02:36 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000331.corp.hitachi-powergrids.com (Postfix) with ESMTP id DDF0C4043;
 Tue, 24 Mar 2026 17:02:35 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net
 [172.31.41.203])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id BC35F60B7D47;
 Tue, 24 Mar 2026 18:02:35 +0100 (CET)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, chuanhua.han@nxp.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [PATCH 1/1] spi: fsl_espi: fix din offset
Date: Tue, 24 Mar 2026 18:02:12 +0100
Message-ID: <20260324170212.481394-2-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324170212.481394-1-tomas.alvarez-vanoli@hitachienergy.com>
References: <20260324170212.481394-1-tomas.alvarez-vanoli@hitachienergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Mar 2026 18:56:27 +0100
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

In the case of SPI_XFER_BEGIN | SPI_XFER_END, the function creates a
buffer of double the size of the transaction, so that it can write the
data in into the second half. It sets the rx_offset to len, and in the
while loop we are setting an internal "din" to buffer + rx_offset.

However, at the end of each loop, the driver copies "buffer + 2 *
cmd_len" back to the data_in pointer.

This commit changes the source of the data to buffer + rx_offset.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
---
 drivers/spi/fsl_espi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
index 7ed35aa3e66..117e36376b7 100644
--- a/drivers/spi/fsl_espi.c
+++ b/drivers/spi/fsl_espi.c
@@ -275,7 +275,7 @@ int espi_xfer(struct fsl_spi_slave *fsl,  uint cs, unsigned int bitlen,
 			}
 		}
 		if (data_in) {
-			memcpy(data_in, buffer + 2 * cmd_len, tran_len);
+			memcpy(data_in, buffer + rx_offset, tran_len);
 			if (*buffer == 0x0b) {
 				data_in += tran_len;
 				data_len -= tran_len;
-- 
2.47.3

