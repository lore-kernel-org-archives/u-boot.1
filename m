Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5235C61CE8
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 10:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D0082C4D;
	Sun, 15 Jun 2025 12:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fkik33IV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j/gZatIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7B8806D8; Sun, 15 Jun 2025 12:50:33 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC5582B00
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 12:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bKqfb2KMYz9sxH;
 Sun, 15 Jun 2025 12:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+9jd9KyvV0PSmTQWnODuBsekPXntlkvz915Xe5KYBA=;
 b=fkik33IVSQPl+HWDKZ0S8ZxTs2vlO3EKXDIHImQJKMt8atXwETlglo627pGXb+4UqIIGcJ
 KrR326zzMX2wWzx920xSCEiSfftYUo8zVrHvg7eCSH4dp/xe+LX4ilWdVsJB0eKYBRcbEz
 ekieM/BqU4tmsoLTpFU57D/WHlKpQDb0eKQq/0bSnm3gp4c8oVYt3OJ3zU5baxtSy6a3HH
 pHPKWjxRpZJ+9SQegKmz3HQX9HB0xoV7N3emwBSbAJqCc3wM8oBh80ylJv1JipP7PfzCzz
 B173hOlwHfJH6/XTrlTQGvKTydcX8gXwcIutvhzE3eNC5pDEOfx2MEyjxSOIfg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+9jd9KyvV0PSmTQWnODuBsekPXntlkvz915Xe5KYBA=;
 b=j/gZatIg7+CBPqvAg2fSHMaFpzLieoea77R1vqOgZwXOUth+yUC1jhgff8Ex92FbZBYNY4
 vJOf0USWaQ1jxok0JSir5I6m/Gl9hD614CHrIj8DvhUHV1smyu0gtxAvkr76cqI1GQmpmL
 8PP2BfLUJaa1Dq+BZN2I4aIToYiHVscWlWk0TZpV02ZJj4Wee3ELMdHYpvyFJ8BMzz49he
 FxZINzonNY0cD3zsKC2oLSAmq1/4kS3yMRj1TvC1gbTInAxPYTfAXfF/eu8mQ/LNEr+r4P
 PuzRI4ahbF63GfzGOzpbQC3Pkme1QWwfU8uNr9IwZT/ou7XSkvenvms4MGRN6g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: renesas: Switch R-Car V4H to renesas_rcar4_sa0
 binman etype
Date: Sun, 15 Jun 2025 12:50:15 +0200
Message-ID: <20250615105019.15257-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250615105019.15257-1-marek.vasut+renesas@mailbox.org>
References: <20250615105019.15257-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nf7xsy986949pr74hjxpuzjekogm744b
X-MBO-RS-ID: ead2549c172ab200622
X-Rspamd-Queue-Id: 4bKqfb2KMYz9sxH
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

Replace current ad-hoc generation of SA0 header with renesas_rcar4_sa0 binman
etype on Renesas R-Car V4H. The new binman etype generates header which is
almost identical to the current ad-hoc SA0 header, with one difference, the
load length matches the actual payload size, which slightly improves boot time.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-u-boot.dtsi | 78 ++++++-------------------------
 1 file changed, 15 insertions(+), 63 deletions(-)

diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index cc9d99b0f34..83f67876d87 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -9,73 +9,25 @@
 
 / {
 	binman: binman {
-		multiple-images;
-
 		section {
 			filename = "flash.bin";
 			pad-byte = <0xff>;
 
-			/* Offset 0x0000 set to 0x0000_0000 */
-			fill@0 {
-				offset = <0x0>;
-				size = <0x4>;
-				fill-byte = [00];
-			};
-
-			/* Offset 0x300c set to 0x0000_0000 */
-			fill@300c {
-				offset = <0x300c>;
-				size = <0x4>;
-				fill-byte = [00];
-			};
-
-			/* Offset 0x3154 set to 0xeb21_0000 */
-			fill@3154 {
-				offset = <0x3154>;
-				size = <0x2>;
-				fill-byte = [00];
-			};
-
-			fill@3156 {
-				offset = <0x3156>;
-				size = <0x1>;
-				fill-byte = [21];
-			};
-
-			fill@3157 {
-				offset = <0x3157>;
-				size = <0x1>;
-				fill-byte = [eb];
-			};
-
-			/* Offset 0x3264 set to 0x0003_b000 */
-			fill@3264 {
-				offset = <0x3264>;
-				size = <0x1>;
-				fill-byte = [00];
-			};
-
-			fill@3265 {
-				offset = <0x3265>;
-				size = <0x1>;
-				fill-byte = [b0];
-			};
-
-			fill@3266 {
-				offset = <0x3266>;
-				size = <0x1>;
-				fill-byte = [03];
-			};
-
-			fill@3267 {
-				offset = <0x3267>;
-				size = <0x1>;
-				fill-byte = [00];
-			};
-
-			u-boot-spl {
-				offset = <0x40000>;
-				align-end = <4>;
+			renesas-rcar4-sa0 {
+				filename = "sa0.bin";
+				pad-byte = <0xff>;
+				renesas,loader-address = <CONFIG_SPL_TEXT_BASE>;
+
+				/*
+				 * This section starts after 0x40000 Bytes long
+				 * header added by the renesas-rcar4-sa0 binman
+				 * etype. That means u-boot-spl {} below starts
+				 * at offset 0x40000 in flash.bin .
+				 */
+				u-boot-spl {
+					offset = <0x40000>;
+					align-end = <4>;
+				};
 			};
 
 			u-boot {
-- 
2.47.2

