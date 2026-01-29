Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E58D73E9B
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 22:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB75284120;
	Thu, 29 Jan 2026 23:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rmiP3CMz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kmkaR7Ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED4E84127; Thu, 29 Jan 2026 23:31:34 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA4484114
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 23:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f2DQC6GP7z9tyM;
 Thu, 29 Jan 2026 23:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769725891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jjln+adIEslQt1cZjKUvkNUwKRnycTP43cb+rHUyED8=;
 b=rmiP3CMz9Fq4NCuHUpBR01XQChPfV7fcPlubQCbXDetPzYPLxC8W0bcbMhPPe5W4hkRbit
 0cXRPLRZIdxTbBNWzSnonszxd0wCsLvMWlAyeF6bAQXHpfX5qyfbVeifUYhd0x1pWrMusv
 /cueX4qiJNjQPyyhwB4uuPokbgdOir8jDe0KOLLAcNlAoNSb4i9vzAu32fVWv2fuTBfWfL
 zI7tPaad5gTFmOZwktx61ewKwITti/Si7IotFY/+b0smmNzunEjmc7rkgiH3Tty7vBll4n
 eFufSGxf3fN/3YIbovOyP8wr5/JkvBQ1lLPAHTgaAwMMGWFqtwsSPxXBpROnDw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769725889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jjln+adIEslQt1cZjKUvkNUwKRnycTP43cb+rHUyED8=;
 b=kmkaR7UdTiDr5E1pZSuP2ZrBX4Odf+pAVYT7njKBFl6taGLGf5aOCkRHK9Det4yO7QM2s5
 5odrD7wUtwuVqaQjm9djcU9O0uQc29BVInmRpy7tJBVHlS4d7qMsD2jdTekxIOB/9BQL2y
 DlP0w3Mz0Sj/d8isS0mcF1t+Gtq5+s6/NZcNaHTYn7kZt0kReqsoPPRZZLjO/8bufHsK4q
 3Co93u5aaF2jW5Uck4s0uiCarennx19tLNArVj5E6yAd7zExsqesk5zJ//jr96bt6D2K3O
 Ap0vgT7ig32tApMcAhjmWlsJf/FihEYjcsyH1tu+KalQLVFkufiKJ7gFp7rCmw==
To: u-boot@lists.denx.de
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] net: tftp: Fix TFTP Transfer Size data type
Date: Thu, 29 Jan 2026 23:30:19 +0100
Message-ID: <20260129223116.653124-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260129223116.653124-1-marek.vasut+renesas@mailbox.org>
References: <20260129223116.653124-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e0d838909dc7d811653
X-MBO-RS-META: thjpjxisaxm4k3f55yp5ypc631iw1ohp
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

From: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>

The TFTP transfer size is unsigned integer, update the data type
and print formating string accordingly to prevent an overflow in
case the file size is longer than 2 GiB.

TFTP transfer of a 3 GiB file, before (wrong) and after (right):
Loading: #################################################  16 EiB
Loading: ##################################################  3 GiB

Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Alvin Šipraga" <alvin@pqrs.dk>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Leonard Anderweit <l.anderweit@phytec.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de
---
 net/tftp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 78ec44159c1..5f2e0a2bc06 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -94,7 +94,7 @@ static int	tftp_state;
 static ulong	tftp_load_addr;
 #ifdef CONFIG_TFTP_TSIZE
 /* The file size reported by the server */
-static int	tftp_tsize;
+static unsigned int tftp_tsize;
 /* The number of hashes we printed */
 static short	tftp_tsize_num_hash;
 #endif
@@ -573,7 +573,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 			if (strcasecmp((char *)pkt + i, "tsize") == 0) {
 				tftp_tsize = dectoul((char *)pkt + i + 6,
 						     NULL);
-				debug("size = %s, %d\n",
+				debug("size = %s, %u\n",
 				      (char *)pkt + i + 6, tftp_tsize);
 			}
 #endif
-- 
2.51.0

