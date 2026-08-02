Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7211EC55174
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 21:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82E0B405F4;
	Sun,  2 Aug 2026 21:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cfipwAlhAh_P; Sun,  2 Aug 2026 21:35:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EB95405E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785706546;
	bh=5E1UqtFscLUlN1UfJff9/9NUlolYnu6oIPg1twTBo0Y=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KxQMgtriDOpL9DMagAqUdIbZn3sCpqB0i8eqI3/1A9XizRoeyZeTzQR88H8Xs87iN
	 W6CYhOeAmWGrcN9ZPYCNxjx1Y9pSO4+EBNRJGQIyfEw6ferbbm2snvWM1JPUicewaY
	 Y6uphmiH+kJwnFF92aUqEcCLf0V7fCiBug26XzGK+tpvZVjjd5U/Wy6AxZHzRFiTyP
	 eChy7H9PN44hGx7u6u3FqDHwY+nRlvJDq3GACzeyC6g8xCavZMNZBfrVuD1VpXVqyR
	 9hxFLumEdHPG6FD0Gjg4Rp8rU3/a60Zb4D5BdA4Y0tuuYQV6c1T0x+m64wHmICJglB
	 EZctrBMrr6AXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EB95405E5;
	Sun,  2 Aug 2026 21:35:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A5DCB26C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3391400FD
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:35:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rmORbbALeK3Y for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 21:35:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D3FDE4006F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3FDE4006F
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D3FDE4006F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:35:43 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hCtQP5NTYz8tCZ;
 Sun, 02 Aug 2026 23:35:41 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: renesas: Enable verbose DRAM layout print on
 Renesas R-Car X5H R8A78000
Date: Sun,  2 Aug 2026 23:33:38 +0200
Message-ID: <20260802213530.134789-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
References: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6b710624c47a79c0b07
X-MBO-RS-META: zge38u5zeyb7apgbx9gwuabtcqsb7kak
X-Rspamd-Queue-Id: 4hCtQP5NTYz8tCZ
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785706541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5E1UqtFscLUlN1UfJff9/9NUlolYnu6oIPg1twTBo0Y=;
 b=lwqjoLjxUxi88liLt0drI0ZM8tEbRmUnb1o35TmAolZqNRWtoxEwsVi1Te2KPekAIlJdbV
 /46whcNL35sIICguvcgsEavz7+syu5n7STP6g4b4uQLFZfkLu9tdCGOas+haXa8Hj0XJ42
 8SwnErr4euCVUpE9scztBDVt3+jsedGvffB5aXg51+8ShCWXnYxnuQruub8F52bg9xVzLs
 1DaUJAwCGsCpZfDOLXSn8jy++pk/ETvljehmrEG9k2G3GN/HbiVyhBJU0kEq2AMEONRkWi
 blj6Ob0mIDF6jmLbX3P6RivkMn/Zs7m8PCoWWB+6HFk10P4fSFU9AelGVFnqqQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785706540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5E1UqtFscLUlN1UfJff9/9NUlolYnu6oIPg1twTBo0Y=;
 b=tpKfgAW58zAWh8Qwnne2TdfqsnIYI1qPUds+99bvKhcMW3wRsMBJWdLV9KacnH4SPTzYib
 bTI3KIpz5CzPQw+Md68IsyG5nByxExLV8HW3nzdLVKjKuuQFitecwMGOmxsD9s0X4JLINX
 AnUklNo1v3HRWRmVXHs3XWJN9IVvrYbx188+WZgI64Mw/q6zhEp4Tfhn4QDk2GrXfvXIFx
 xvinRRt0FaIeD2HAXstflsb+0H5rC+h7SVTqHFifPMXKarl81rx1+YbChQAXd4JlP8y3BX
 cxriGmAquqXmRUwUgVNBnUXgWE6tgttBOqilTvL1wuj8kUhfVMEgsxhCbs1LZQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=lwqjoLjx; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=tpKfgAW5
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tpKfgAW5;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable verbose DRAM layout print on Renesas R-Car X5H R8A78000
to inform the user of the DRAM topology on board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/r8a78000_ironhide_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
index f8a1403ae0d..21112c439f9 100644
--- a/configs/r8a78000_ironhide_defconfig
+++ b/configs/r8a78000_ironhide_defconfig
@@ -17,6 +17,7 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_SCMI=y
 CONFIG_CMD_UFS=y
+CONFIG_DISPLAY_DRAM_CONFIG_VERBOSE=y
 CONFIG_DM_MAILBOX=y
 CONFIG_DM_RESET=y
 CONFIG_ENV_IS_IN_MMC=y
-- 
2.53.0

