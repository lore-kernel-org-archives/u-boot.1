Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ECBC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FA0140648;
	Tue, 25 Aug 2026 19:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B7SXsCuzBZnP; Tue, 25 Aug 2026 19:34:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787686451;
	bh=fumGF+2192QXUaAbu3XfcC3oHBNvrHgaWk+v8QPZJbQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LTyKIYxYL+gaAQ9JdSVi0Syl3rukcBlig0eBljCCnAXgvP23sITqFho7Dxbbu0113
	 fzTQkzvqu31WGuvg20YDJ5i+QRAMT6AGI3N8UwVqDU2qOdjQgQeHkj8SIPqfD93nYj
	 2hjrXCsYLLbhuMeW6Jmsb2hGwzEhME9OuDY7XDBKHvJmiKD+Fa15jyCWk2FZ4vyMqC
	 JsHDZGSuX+1RW0FXYLMoQszWsQnjkdG7/ljvrHzgi+IhSYTyDV4Zl2u0U4DE8k26xE
	 iUpdxyYI6zRlXUj7YNc73qssBY4vhw6nj6tzc1OwXv+1FtCPO3vK+RURL7GF+nDdtV
	 nbyKyHM1u5lCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF23D405CC;
	Tue, 25 Aug 2026 19:34:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AA7339E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F360680984
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jX5X0uQjUKjo for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:34:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QjwlUZH/
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C1F48097B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:34:08 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f3faf2b081so173736a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787686448; x=1788291248;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fumGF+2192QXUaAbu3XfcC3oHBNvrHgaWk+v8QPZJbQ=;
 b=QjwlUZH/1GDl3F0aNjKkLd0CFIlY9p7pI8qEC2qxj1LhZ3X6X2hGrL74P2d6PDaKhc
 V0Pb1oejaDJATtVInnCgdbsrTpBAR6birLFBvMvxK30eF/V7EpL7jYqKZ+/pT1qF4GAw
 5EojmL8jvmu5IA1ISqUr9ziPd62HEsYenHdbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787686448; x=1788291248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fumGF+2192QXUaAbu3XfcC3oHBNvrHgaWk+v8QPZJbQ=;
 b=RWoUJbVFM9D6Xyr5CPThIKo3LljkjhEoOBVXedvWRs1fNGIYsSfZ8lojlN4Kk5ZN2S
 VU7DAjeeFwr3Z5A+H43Tln6fuG4ATHesH9Atq5EXw6EPmZdTzNyXSxH18mcsuq17DwyT
 hwE2Iw3yyCbaB3IikXCM5BrxJgeJO/g1YBkokK26JOEUi9a4gTQMUPy8VzGLAwQrc912
 sfHcprfgYFACURZXCruLphHO/DF2/98C7mCurqG2XXIuizTtz4YE45gva/ZCvS1eA87J
 hUVGwWU491Lwyouv2i565guydRM6L5SOmOJUn1s9Bzs8rS2wEEm+y9OdQyYkytn+GN6o
 0MIw==
X-Gm-Message-State: AFuF++lbRicsce5L4YjXf9y5pHTeH4u9ichypY6lvpCqUqCG+OXAOVHk
 7Nkie8aVaWEHeoTQlq0TCSwrb5Aa94jD/f4fRBEDoLyIbPV687zMn/PncuzS2J+IBL/jYgmcZBe
 iMOzALiC1Tg8j
X-Gm-Gg: AR+sD111lJn0aPMobLt65T/526RO0yLh2XGLsGMoXGOy7DLWnemfBps0/07/D0rDARM
 tiBwRmbps+qFE4x199MxTuKlNIjSv5Ic7+9/SHjfxtZokoJiCLdaogtlBA06jVTye96MEgHTiRA
 urOAImUiM7lp3XY7yNu+weSOkMt56I+zCFJDVTG29rdn6134lwx7vxfPHa6ldaE98+ThavP2XuD
 Y8E1CuGVZzT9mG9jHzQc7yqs9p5yC8HTwWzdHmXBEwH4d89m5Q8ESRui55V0ulS+QDnLWo7+en1
 rWyK9XxJNEuKuW81IbB5U73PQ+BuwMicqj5tb6VBeDNGOV8O3vesrxYpuFJS5R1gOLIuAQhLrYm
 r9VDl+ot/W0ib4/TpjJV3c5jYB8lgh3GGloNkDBRe1wtUqcpPGnToQQirn8CupXaaYqBtC6uIyq
 uDex04FAcxienEi6/Q/LtkZ2OR21qmvNU4pPH6YrQHMypRbNC00o6r4DCoHwrAx5zepL823foB/
 i4PUDqA66t3i3T+3JwFmaZcdd9V6/kPbE0cxgUyNYMjVueb/+aB33g3nSUsouYh8FdHZiBetxUX
 j+B83sjQaFPqp4EdBe0AZaarMewDwX+FjQ==
X-Received: by 2002:a05:6830:3883:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7f4c525fcc9mr1283600a34.9.1787686447662; 
 Tue, 25 Aug 2026 12:34:07 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c4210437sm355667a34.3.2026.08.25.12.34.07
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 12:34:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] cmd: CMD_PCI depends on PCI
Date: Tue, 25 Aug 2026 13:34:05 -0600
Message-ID: <20260825193406.2347139-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The "pci" command depends on PCI being enabled, both in terms of how
it's gated in cmd/Makefile and the command implementation itself.
Express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4aa02dc809ad..fc121c7c2968 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1696,6 +1696,7 @@ config CMD_PART_DUPCHECK
 
 config CMD_PCI
 	bool "pci - Access PCI devices"
+	depends on PCI
 	help
 	  Provide access to PCI (Peripheral Interconnect Bus), a type of bus
 	  used on some devices to allow the CPU to communicate with its
-- 
2.43.0

