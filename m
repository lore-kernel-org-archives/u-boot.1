Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FC9CD8CA8
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 03:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53028846A4;
	Tue, 16 Jun 2026 05:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CR9L2u1I";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vlEoUUJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCBC0846CF; Tue, 16 Jun 2026 05:36:21 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A491F84105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 05:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gfXhg108qz9tfH;
 Tue, 16 Jun 2026 05:36:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781580979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gagKryhegey2QOHFFyx/ZnwDDXcmMTORr+3sDjG1MlA=;
 b=CR9L2u1I4+Upa8RoFZdD96HJ0Fo2Q5hYGbtAXaJOozVd34THst8iR+GlLwmeOZoAVn3IZ3
 4k69wPZAIUkzhhoMMl0jPH28tzJLo2/zBnMhsGJUAq5iaAfhk4BNGk4q+RlPZsayjg29VO
 IXteTj8VusdwXo7TddzQnJWtbVZ7EZGDdfCSgEYYvph6IuePmteCowwwPFOGGox8UvFt+q
 V2FvbIpghi1ieFBEmKnxYSffqaHfIfQCOA3Qvzj33vgcaOqMBOnZJrrpmWvoe3mZRMCgwr
 KUViLmhYXRuzwVEWdox6vFsaj0/0IwEQqh00YOoVM3qTaJ2aa4j1Rddm+CpJ7Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781580977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gagKryhegey2QOHFFyx/ZnwDDXcmMTORr+3sDjG1MlA=;
 b=vlEoUUJigA7ksPDl2toxiYIBn5lWbpFyY7CKsqGI88BNWChPIsnQbLHrP5FAgd7C5yKtpp
 i6wkYhPiiIf04GEmQnLYSAgpxwJ5Qftq0jLAPAyOtkTvv2Xn35Jqn9ZBY0rmi533NodoRs
 BHUm1NhXO8rM6pM/IqxshkL2xAVV5Y4HyjYcN7/vlLlZef8Cc8fTl0hXrPo0MIg9k4g+By
 SayOvmR7k+Qdu2WBdy7tY0ozGpPGaWxtjR+ZwzOHthXsUc+b4XL7IhvnLVq4S9Hee0FwHf
 mK7DDp+Hzq9aDbGjk2NjaoQkn7QOjWVAn9QvbLJePJ5QRdllGVprrxe3JUREvQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: board: renesas: Document Renesas RZ/N1D and RZ/N1S as arm
Date: Tue, 16 Jun 2026 05:36:05 +0200
Message-ID: <20260616033614.137946-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i4wmq6pj18ejbtuzpmj9d8c8qpsfhwha
X-MBO-RS-ID: d3e91586729475203a3
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

The RZ/N1D and RZ/N1S contain Cortex-A7 core, which is 32bit ARM core.
Document the SoC as 32bit ARM instead of aarch64.

Fixes: a5b9f959439b ("doc: renesas: add Renesas board docs")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/renesas.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 6702d5879b5..fcfd51aa19c 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -255,13 +255,13 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
    * - :doc:`RZ/N1 Family <rzn1>`
      - Schneider RZ/N1D board
      - R9A06G032 (RZ/N1D)
-     - arm64
+     - arm
      - rzn1_snarc_defconfig
 
    * -
      - Schneider RZ/N1S board
      - R9A06G033 (RZ/N1S)
-     - arm64
+     - arm
      - rzn1_snarc_defconfig
 
 Build
-- 
2.53.0

