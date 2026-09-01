Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D334C61DD3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 00:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14A2B80E29;
	Wed,  2 Sep 2026 00:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9TUfnnNGO56; Wed,  2 Sep 2026 00:00:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788307217;
	bh=yLqX14ES/rsdnQGQdtOJdWvXCnU9lJVvWfR3Wnor9ro=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cRgMorRrztOkf+ypXfvNUa5A6SSeRhxWR+6bWa4TtyVdZ0OQ3W0m3hFV714GdVVvx
	 BIBwfWSveAO3dV6fwcwNGagsfBsMLu91e74Gq6D/bnS8tjAqMAbtgoEt76M1mPn/l+
	 JeRhrF+RY5w8dqMJc4WugIQvosrFf2HmlEQGIKQd6UmZucjfQBMoYiwE8LudpHRDY/
	 yd1g2D3Yi7HgmentyVdt77kFC0vFpbB8cYQgSmuhaxeqtA06UCrLHUuHWt6jRRdTuZ
	 IbA4pbKt/Pp23tMY9CCLO2ymo84323gjA6NwfAp3wvZycba/myRLQ69LdTfCYjSvnU
	 dXJQZZcIwHywA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CA4A80DEA;
	Wed,  2 Sep 2026 00:00:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A483363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C4B74013D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbMAeMNL4RNo for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 00:00:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=VyO9piCY; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=j6NAFSOt
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD36C40076
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:00:14 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hZNCJ0n8hz8v4d;
 Wed, 02 Sep 2026 02:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yLqX14ES/rsdnQGQdtOJdWvXCnU9lJVvWfR3Wnor9ro=;
 b=VyO9piCYoFM5Ulb9arP5eTRLzN4W3vgvPJv0X70Z/qDuP+ypPZ4C4Wu3VQY9XGHaubHv0C
 eWUu7aTBiidJAFrlmiKCydfErJyVLT7DPEopr/G78sF8HFNNL5+Ra9wH69uhoShhlk/3R3
 c2jha8uki1VjmjanBP3TPp3xeaEfec7ITv8HXNWzyGdStEuyYGh6BGNilXmYeJCUANDXgP
 ZK3qUX5y1NXY2DCc/VS3/9JgSFcEihE70kva2U+bb+HnMAX3T7DpDm7dJoV8qGRk8pW+ye
 rITgRByOQ1CHg+bKb3A4dK02wU2JShIkLCV0p1j7a5t7WBTmHERD7UV2l2MlNA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=j6NAFSOt;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yLqX14ES/rsdnQGQdtOJdWvXCnU9lJVvWfR3Wnor9ro=;
 b=j6NAFSOtahGBvse4UFWIIYpw0Jqt9azIP45tqGs0nJYBGnKARZIUhZrPb+eYKOWKQrZczj
 aPd5pyneERIxV5CUZy3+1d6rneys5hMilYFCFQAUsSjlZwj28i9PdzAtMUUOHloCxt3eqt
 R8pfYzFWRHOVsuYyve7wYw6DRIZCp1WNrQ9Hc4LkJHaqcYboXLih4hZMWs1ehPmi7zyw/J
 jKwLnPbfmhNjWRPOnhybog81xZp+VtJBo9Uwx+WRZeckdV56JUOBIYUoPBac1cxrj5XMy4
 4DGQhk6VRDsTOa4U9Nfp1Z6/SWKrxpGMrIMEz6sH6M0FibXTdIxRxRN6TUeWxg==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Enable FFA on Renesas R-Car X5H R8A78000
Date: Wed,  2 Sep 2026 01:59:51 +0200
Message-ID: <20260902000008.350342-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8c3bac7b9350061fc92
X-MBO-RS-META: 4696rq4tyz7qwupxw1cm8uanju8pib8p
X-Rspamd-Queue-Id: 4hZNCJ0n8hz8v4d
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

Enable support for ARM FFA interface on Renesas R-Car X5H R8A78000 .
The Firmware Framework for Arm A-profile processors describes interfaces
(ABIs) that standardize communication between the Secure World and Normal
World leveraging TrustZone technology. The FFA is used for example for
communication with Hafnium or virtualized OPTEE-OS.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/r8a78000_ironhide_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
index 21112c439f9..c2001155f13 100644
--- a/configs/r8a78000_ironhide_defconfig
+++ b/configs/r8a78000_ironhide_defconfig
@@ -6,6 +6,7 @@ CONFIG_RCAR_GEN5=y
 CONFIG_TARGET_IRONHIDE=y
 
 CONFIG_ARMV8_PSCI=y
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_ARM_SMCCC=y
 CONFIG_BAUDRATE=1843200
 CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} r8a78000-ironhide.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
@@ -14,6 +15,7 @@ CONFIG_CLK_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_CMD_CLK=y
+CONFIG_CMD_ARMFFA=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_SCMI=y
 CONFIG_CMD_UFS=y
-- 
2.53.0

