Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9357FC61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5267C80EE5;
	Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5_FvFgFqVaex; Thu, 27 Aug 2026 19:54:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860443;
	bh=HVThWOBGfU+e5KEldY4OQin/WS+omS4zrhO3CKP84IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tI7l2/qNe+CCI0o9GIV5Oykp62ik7m9X+cORgd5jobby5xraDOg/8JAoIcET7HJzj
	 sYzSteykBTP2a2sUrEvCTg6OHyV5rHGabRBiaJM1rP0/6ys6CRkisecNGjGYlP7+QQ
	 IwIu2mkPEXdB+18m/QxB4bwGJ7qYV8I/LkP7gCUqFUCxM3q06HXgaQ1fidSrYZxh1O
	 HOZ/Mvt2yjI/aW+MuyhHZ4MTbMTh3nmsOOzkw9O4VDZ01oolq7raXdhNwDBAJuW/hw
	 tTwW0+obhg7fSxo7YCgRSnNaqN633nO5lVLkuFknz45iz+iCPATLuOeZd/dHTbEenb
	 mCQqgJ9k5ireg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66C7680EE7;
	Thu, 27 Aug 2026 19:54:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C09C575
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A777C400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U530nwdAuouF for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::8faa; helo=smtp-8faa.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=QWPjdEIy
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::8faa])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80F2E400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:54 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzN49PXzWsf;
 Thu, 27 Aug 2026 21:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860432;
 bh=HVThWOBGfU+e5KEldY4OQin/WS+omS4zrhO3CKP84IQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QWPjdEIy9LERhjWiFXsSfZdd5BQNQM1SeI9A+dBKAGaRVyWFtZy6iOKGDjyir5qLz
 GR+D4h3tYVzC5oYXzbs+8h2eoNrte8upMLSUPbPWIAQInWZN8d+0aoh3FsWA6DtnBk
 ODNfyoao2woXDv1u/OYMv9phbiLgvXlHi+sQ9fIzwvt7Itc5ISFbbqIF6pcgsmbQtI
 H1dzC18ftTOlQYQ2xZ9jPloyWJHpsZVW//IadEwlxpEXW6ElZ8xMHIRkeNvS3TeOI6
 EYft2EcCYMRByA92Dg6k2XCIYyUXSPmkLmt6OhWZ5GTQwOfPFsDXHg4yIBHH9+5V4v
 XaLcc6YrfcjNw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzL6jdWzQKC; Thu, 27 Aug 2026 21:53:50 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 29/45] doc: board/tbs: update link to TRM
Date: Thu, 27 Aug 2026 21:52:57 +0200
Message-ID: <20260827195313.129994-8-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

The link to the TRM doesn't exist anymore, so let's replace it with one
that provides the first part of the TRM where the BOOT_CFG is explained.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/tbs/tbs2910.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/tbs/tbs2910.rst b/doc/board/tbs/tbs2910.rst
index 9d4be61783ed..4f2838bc9bd8 100644
--- a/doc/board/tbs/tbs2910.rst
+++ b/doc/board/tbs/tbs2910.rst
@@ -187,5 +187,5 @@ Links:
 ------
   - https://www.tbsdtv.com/download/document/tbs2910/TBS2910-Matrix-ARM-mini-PC-SCH_rev2.1.pdf
     - The schematics for the revision 2.1 of the TBS2910 Matrix ARM miniPC.
-  - https://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf - The
+  - https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/i-MX-6DQ-Reference-Manual-IMX6DQRM-R2-Part-1/ta-p/1115983 - The
     SoC reference manual for additional details on the BOOT_CFG registers.
