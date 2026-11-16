Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LTK2JWQi;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cKleBbW1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4355E8114E;
	Mon, 16 Nov 2026 17:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pN_N_0deBqCb; Mon, 16 Nov 2026 17:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F88081199
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850598;
	b=ky9/wuT87PZo7VydJ//hYGfpTdzmx0ets8v1TvdqzFJQzP+0Nrt35GPplA1oa9OcVe6t
	 u4mJCTWR0jg5GHIimzaUQJRP0oLKUYg0chUkpRYiSJzNoYAW8/au9AkXmV0KkNd1gW4rd
	 7+H4xHuk394ehXf2KlN+CFngP70gLX63erXkdWze+92Tr7ZlHh971xn9MFuTHeSyZF4eP
	 2dQzgZO54B1mptvs7wASYOfPFBvnxjFQf4we2hORQvak5HP9BMl5idogvglizCFv83WkF
	 ifDosgbtxvBDVUEfturze+CWMPw3q6w4F1KNZ1rVVrUAUGpFFjzbjh0bbWNWa6bedLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TcZjdfOWob/BIvK3F1g5ODXHH5k32jARH6l2Zju4ZM8=;
	b=iTuE8TKmjLo9O29KgfHg6dDPe/6B4Dogt3HRNW94x+lquUqPFgagZuGrDP8i/jusKy0/
	 tMhDDXEGHvZYr3TYjdQzd5WRkZvOy0tIxLiRJrh+odrOLolPXerp9VJ/+uyV4ZHtRGi6H
	 zkupc2sOIC+PdS+iYp1eHQi4/J0HkXjH4oWRu8QgVkiq2buHdJz49nDAQ8BQ29fUjgd6f
	 2sQl9Ld8co6wAcm28P+4Zhb0Rh/3+iZGaY/AR7cahveQCw9u2csWDEyYKNnPGwrO4LYYf
	 pz2L8weSWeKwELoHlHK1cbtdpRqMqrcnd5Yl/5tN2I4TRUjd+BauMrMGImhlRW1KnGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850598;
	bh=TcZjdfOWob/BIvK3F1g5ODXHH5k32jARH6l2Zju4ZM8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LTK2JWQiMG0XCpojlEbdfrVmpBHlObndEbgbnAD84ZQb5KRsLIANbQ+CTwnJi/wBb
	 LqCjANiCmZ7QaCEMp60ZJVOUzW7uCe3TLXCjSNJK7hr75ly0UcMqDCz+07WuEgomKg
	 EyDpTxM0D2AxwLC7DJ36TS7yi3sVt8N0ho9RJXV1LMEGhuA4ge8qlFE0LeOWqCjNaM
	 LIk6y1Rw6JsZJeWOvZfykHKYHPyp5t9f7V4JPTEt0g+V4Fl5GStXL6Xv9cw7NeqCgL
	 AyfNbdiX3yY5vxviV+CX9Ka3Q4qlU8HqInajL4WdTNQhZYqDtgaDUfZeJ7QRzW2+ei
	 gPOy/XLrdE8Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F88081199;
	Mon, 16 Nov 2026 17:36:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DD0C70B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5909B407B7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcSjicUn881E for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9ABBB407A0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cKleBbW1
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9ABBB407A0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:23 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw5J0Bq1zMlDm;
 Mon, 16 Nov 2026 18:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TcZjdfOWob/BIvK3F1g5ODXHH5k32jARH6l2Zju4ZM8=;
 b=cKleBbW1T8FCM5cii4Aa9Pdbz4mTdRSsGjR3fWZFPCD4B6wX64ZdHLyrP7sJgGgYLzw6PU
 PPReTzWnjfK+jAl4jQZSt5IhZSTWjgbWOwQ/Kxz8Wk0oOA2jzUeDcZ69cXLRtFF9A7fVW7
 uRrhVTFasJQQQc7Owcu8fFIbQJD/hzxvGyg2LvIoBz9EDeblJhNh30JklYmthzPWs6/2ps
 yLYti/8yd5m6S9ti0GnXNGo/rte+bOP16IPBs36kR01Dz2guj4j11GA5JWA8tB5doyrWQ9
 HWkgZGvy8ZLkVXaW3TjU2Am6FWtH47wuqq789oDx/634DzMz8YIYFQ0E/9LrXQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ddr: altera: Constify driver ops
Date: Mon, 16 Nov 2026 18:36:11 +0100
Message-ID: <20261116173617.3487902-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7c13464fe1cecd1d8cc
X-MBO-RS-META: eyqjt8nrn7qz8mzddsumxfoz353zqboi
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/ddr/altera/sdram_soc64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 93df3d1812a..79b7bcd520f 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -472,7 +472,7 @@ static int altera_sdram_get_info(struct udevice *dev,
 	return 0;
 }
 
-static struct ram_ops altera_sdram_ops = {
+static const struct ram_ops altera_sdram_ops = {
 	.get_info = altera_sdram_get_info,
 };
 
-- 
2.53.0

