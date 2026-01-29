Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E49D46C15
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 00:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4785C83C91;
	Thu, 29 Jan 2026 01:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kyDYClq4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Zj2M+BFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDBAF83D3D; Thu, 29 Jan 2026 01:45:46 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8A583BC9
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 01:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1gRW4cW0z9tgK;
 Thu, 29 Jan 2026 01:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769647543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SacKJvv/pRMr3s+6ER6ULVAdJ8CCiV0FSarNazZLpdo=;
 b=kyDYClq44mLMwxB+I41rcloJEGPYVXsf+g3JJuWASq+h7SYfnUauEKHlhTkT4P52WhBs1F
 lmad+YyhjCRrF4sj4dHpBp7E4bTIkkh4dQXG1+Zs1XBvm//EJCW3LbkZ7x9vm8PtyfIEiB
 pG3xH40cF+pmriRgnArYQK0SEAF7VuG04g5u3CdhV6+96JnokYBrYw1QyKPznQp3sZZwXE
 0x6LEdt519A8uSXdvg4+GNbvHle1qJf+AprQzoYraEG0/dmPx+0XJ4hUzz6vdUg4x5AVT+
 2vyC6S7tz5gOot4gVrAbg+JZZqvpDOqxc5juR6TYMh+YTi0j+b6moKgO3PGHrA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Zj2M+BFg;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769647541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SacKJvv/pRMr3s+6ER6ULVAdJ8CCiV0FSarNazZLpdo=;
 b=Zj2M+BFgljE5+hCcDE5M9m7c53Fey4VbfcDezjN68GklfgY1p+4Lthx5K8Grfcb280+tDp
 HJLthIl4DuqkFVPsalXXVVaIsNA6nfp8KF/cGKW1M8+0leyFVbCN42oHjSwlVCch+fSe18
 5Lj/b4Z0QkTfSf7FrPaveyORsq79tHkCJlDCull8GtIaKVTeOGtb7K2eoiHlPhbG+bpW7s
 pgem4cOmL9nXKteclX7wQ0TcgPv4CzW89sJQZ1VGgLgK5f4HisZ01CLoQ5QyLtcdSxCHuQ
 P1E2wPyNfPG6+YYlscgZQosynsaZ90zfdJ0ITGKPg01h62FvGEdxf5hczYK+3g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Enable wget command and TCP on all R-Car systems
Date: Thu, 29 Jan 2026 01:44:28 +0100
Message-ID: <20260129004536.434373-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 46e871f64f5a926c3af
X-MBO-RS-META: bf6r6bauohrim1eufbfwpn8arhfe5ybo
X-Rspamd-Queue-Id: 4f1gRW4cW0z9tgK
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

Enable the 'wget' command and TCP protocol support on all Renesas R-Car
systems. This allows users to download content from local HTTP server,
which may sometimes be more accessible than TFTP server. Enable TCP SACK
support to improve download performance.

The usage is similar to the TFTP command. To download file from server
http://192.ser.ver.ip/file/path/on/local/server , invoke wget as follows:
"
=> wget $loadaddr 192.ser.ver.ip:/file/path/on/local/server
"

In case the HTTP server listens on port other than default port 80,
set the 'httpdstp' environment variable to download file from server
http://192.ser.ver.ip:8088/file/path/on/local/server
"
=> env set httpdstp 8088
=> wget $loadaddr 192.ser.ver.ip:/file/path/on/local/server
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/renesas_rcar.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index d9a99e1f428..b3107d79b0e 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -10,6 +10,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
 CONFIG_DM_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_DM_REGULATOR=y
@@ -22,8 +23,10 @@ CONFIG_FIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_MTD=y
 CONFIG_OF_CONTROL=y
+CONFIG_PROT_TCP_SACK=y
 CONFIG_RCAR_GPIO=y
 CONFIG_SCIF_CONSOLE=y
 CONFIG_SERIAL_RX_BUFFER=y
 CONFIG_SPI=y
 CONFIG_VERSION_VARIABLE=y
+CONFIG_WGET=y
-- 
2.51.0

