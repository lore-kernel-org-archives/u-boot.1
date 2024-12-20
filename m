Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE3FE77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DE2B8036F;
	Fri, 20 Dec 2024 01:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="k/yCPk+3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Wi0l2t1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B968080352; Fri, 20 Dec 2024 01:03:53 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50F280312
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YDnh70YZKz9sqs;
 Fri, 20 Dec 2024 01:03:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734653031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9glFthYpuDsoTVnECQv5+BRxwdjqArkVQ0gtQtsT0U=;
 b=k/yCPk+3+o7m7pYp1ej2hqPEpjvYyWBHAGeVnIfmGeNrFOo1itkA2ASALi995GleiBbQNT
 9ENdOr0EBqzsDVKBHh9Gzv62xbpNUpD9FrCaHtPLpvZUEiAuYE6rusv2najOHQKtsewRwU
 fPhaEofBuEkmRxCWJkx/aqN9GX6pQqlN9wMg8I/tc6CEl1PqWHcZek27UEiivpMcec2Oe3
 w6r6leCI2j8FyPHiei8KG8Rz9f9HfRxp32hynQAWW+vKDRLue11fUX54dTx5Za6AaxUJ19
 emK+KbtD/adulMGjUwrbtigzpoDIfzhZ2cN+w+UgsW+lEn91Sid8HdU/ErHzEg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734653029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9glFthYpuDsoTVnECQv5+BRxwdjqArkVQ0gtQtsT0U=;
 b=Wi0l2t1toYLDbt1SN3+2ABC2v6KLMDUbaqQUor4J4e5zLYP6Gcccr8Kn21guxqRhWIkXFt
 WrSVdoJAu+TVLucjmEF1wJarXf+tSmOYVhTCZ/vXj8PPadO0F3hHcDQ1XG5v1QlE0lSzLf
 ZFRdU3V15Dh2xx3RxyTR1W12Zs0qyzv+PnQn3H7lfoNL8Lg+npW2EZ+zQ+wtl/XZU42ZeA
 F4dwebW15Dhxk+E3XHLGiuvxTEcfOgn6LJmqFSIqpO7qDqPh87DXJ+6SPAnfZM9MAM2mQK
 0eyIfWR5smXNm9SaxYjUyrh7qG+b462XiHBofI3OrqjO78rZg949LJGZUXhgOA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, MD Danish Anwar <danishanwar@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: renesas: Enable CR52 remoteproc on R-Car R8A779G0
 V4H
Date: Fri, 20 Dec 2024 01:02:16 +0100
Message-ID: <20241220000320.167110-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241220000320.167110-1-marek.vasut+renesas@mailbox.org>
References: <20241220000320.167110-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: aff7f6f78a25bf55064
X-MBO-RS-META: u5iokessa6gzao1nymory9j9z6ncp7eu
X-Rspamd-Queue-Id: 4YDnh70YZKz9sqs
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

Enable remoteproc command and APMU remoteproc driver to start Cortex-R52
cores from U-Boot command line. Code on the Cortex-R52 #0 can be started
as follows, code on other cores can be started by passing the correct ID
to 'rproc load' and 'rproc start' to select the core:

"
=> rproc init
=> rproc list
0 - Name:'rcar-apmu-cr52.0-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
1 - Name:'rcar-apmu-cr52.1-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
2 - Name:'rcar-apmu-cr52.2-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
=> rproc load 0 0xeb200000 0x10000
Load Remote Processor 0 with data@addr=0xeb200000 65536 bytes: Success!
=> rproc start 0
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/r8a779g0_whitehawk_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index dc6fd6333f7..c74051d1af9 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -13,6 +13,8 @@ CONFIG_SYS_BARGSIZE=2048
 CONFIG_BINMAN=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779g0-white-hawk.dtb && booti 0x48080000 - 0x48000000"
 CONFIG_DEFAULT_FDT_FILE="r8a779g0-white-hawk.dtb"
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_REMOTEPROC_RENESAS_APMU=y
 CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_MMC_ENV_PART=2
-- 
2.45.2

