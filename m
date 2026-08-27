Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BE2C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D43BC60817;
	Thu, 27 Aug 2026 19:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id obidpKL620cH; Thu, 27 Aug 2026 19:53:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860430;
	bh=y6CVmXr7pTW6iwONmMDWLLJkje9HQOzKAvnq1TizQHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IhWes/3A60YVLYo3V+WJFGhi3kA4x8c00UOmg1FI0Z7Z1EgmBO/WrfOCCI1vrOL4A
	 m6ygmUtnhkJWCeVxvl9MW83xSuzEHRYTx8TiQKKJPwEeYr+0vp4XqhvFQRxm1XL55r
	 d1m2M7vaeKNtJSHXTt1Ys+x4U115nY5trebG5vwN18bJYMO8iLPjWx2MXd0eAEjbiC
	 6+TtDwEqWQyBA63W3+Aj22tvfPJadJVB3X3w5+YJ/kjseoIfzCPOvxPYxtWyHDByxI
	 WG6tlFegTOCR0ktj6elBV9eomSdpSpdYrvxnTze0h+Y6MP+V7ame0fh5xHPtqi5+Vu
	 vMO1ARQAuWv2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A7ED60802;
	Thu, 27 Aug 2026 19:53:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C4ABE105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B63B4607A9
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4rpOHm4OjOPI for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::8fad; helo=smtp-8fad.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=L2L5IRxv
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::8fad])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53F72607A8
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:46 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzD0mhtz3B8;
 Thu, 27 Aug 2026 21:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860423;
 bh=y6CVmXr7pTW6iwONmMDWLLJkje9HQOzKAvnq1TizQHk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L2L5IRxvE8ue+vWiC7Dq3V2SuccHo922nZoYofJQ2CUI4b52VlXweFkjbpBtBQTD1
 AbejvkSC475rwluaBkCz/Qpp01GONKnc8woUdD/8GIYb+ygy1Nx+dxRn+LvRuNQ4CG
 9RgFOTO0EgGpJPQenyHJVs8+BksMaof5i+UVthjg6DSt5lF0TbTND9Wrv1cWEFfPwe
 6uMd2abSK5k4x+oMrxn/fUWqweAGiqd3Kmnm9476vX8ULAbmtLm+SHxG+OUTsKYo+P
 ePAmM72OoJEzLVbLQ2YAOVAmJKpwnPqt5mO1/6RLfJc0Gg/xcP0C/ssUAg6PeImHle
 8EyO1FZE5Pi6g==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzB30n2zLcg; Thu, 27 Aug 2026 21:53:42 +0200 (CEST)
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
Subject: [PATCH 23/45] doc: develop/uefi: stop tripping linkcheck
Date: Thu, 27 Aug 2026 21:52:51 +0200
Message-ID: <20260827195313.129994-2-foss+uboot@0leil.net>
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

https:// trips linkcheck because it thinks it's supposed to be a link
and is malformed. Instead, simply replace with HTTPS.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/uefi/uefi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 6fd1db6606db..94ddf6904405 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -703,7 +703,7 @@ We need to preset the "httpserverip" environment variable to proceed the wget::
 UEFI HTTP(s) Boot using lwIP
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Similar to the above U-Boot can do EFI HTTP boot using lwIP. If we combine this
-with Mbed TLS we can also download from https://
+with Mbed TLS we can also download from HTTPS.
 
 HTTP(s) Boot can be activated by specifying::
 
