Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DC4C54E58
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 08:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98FD987FB6;
	Tue, 26 Mar 2024 09:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="iIk//Qsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF35C87FE3; Tue, 26 Mar 2024 09:20:14 +0100 (CET)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618B787F95
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 09:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0B126147691; Tue, 26 Mar 2024 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1711441211; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding; bh=RoohcvTaeaEsfAtvUQCsbgNJ/d690KMYYqkAfXKjf8Y=;
 b=iIk//QsygetxvoA8wmiIb7dPVh7kpmrx7vdDOr870mNGKV1ZFLjeWw7FU+VCEdfM8tXyJi
 FfxfMSoFkUtA5Q2yrzvTO2CiZwHj1qoeBfJTvrGEnDXyVKvdk7XGx0S98oj4AWaAwb5D08
 llokb0sRkWoEstUZZPUqY666/uYn47ML1/6PgCP/m8uOZ373g4OXzLhV9V8PLpXlixvNsQ
 AqY6f+/ayzxCr/jCQ7xmP4gnCmmwjlsZe2rh6jgIRfKjKC/4lla6wr9eyra3VuPFLAarUp
 jyIgIibRisIjLbYhRnay5SKxDuiVD2wHnCH93IlGq+MN2syZ5atuiBYIPwxmtQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] board: amlogic: jethubj100: fix update docs
Date: Tue, 26 Mar 2024 11:19:58 +0300
Message-ID: <20240326082004.1651782-1-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Fix linter errors

Fixes: 2fc5e3c1668cffdb4b894986e98c1ee10f6e9955

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 doc/board/amlogic/jethub-j100.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
index 80bed6e919e..cbf1ea76107 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
 U-Boot for JetHub J100/J110 (A113X)
-==============================
+===================================
 
 JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automation controller device
 manufactured by JetHome with the following specifications:
-- 
2.43.2

