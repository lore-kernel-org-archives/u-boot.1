Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBC606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=axPwTT9y;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256 header.s=default header.b=RF4ovJL0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12FBC80DC8;
	Mon, 23 Nov 2026 14:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIst2_Ujdihh; Mon, 23 Nov 2026 14:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6023C80D83
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442683;
	b=htIYWVjCKx+qZQGg5lELKbOdEEfH/hNBSA0+wAHEN3OPzzdZMs0fBKFKFqbWdkyo1bMn
	 kssSm42xSrqbGVf5dL6LX0P1aD2dSDUVyBRWndbenUkjJAVZIH3+c6xRcN7vl26o6f0Mk
	 bFJggEScu0TqjSJr41pDGXKJGfcPtyc4IXXNbo6mjCcl/pD8a0c/EuFTLfbdvUC9I8fOJ
	 krJwTUbK1gykfHJpf+BrjLjs7GuXpBU2Karw0f7a9rFSA+JLtv15VxGB4/erUVvUuSoDL
	 6OSH1O6zXYN37nERZXHIks5Hlqxuic43YUusmAslwY0o6N8FSOfMgFvoiNba5VpeJTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LVkO/gQpo884eaW3bRZIas+UuZ+uzy3gWZQhaXydPsc=;
	b=n0+89glrOjNyk8s35ivK4Ncfk6SEOwWIH8eotfV7P/v5jAaQ+JonLahhC2qeuzszLXTm
	 ++cp/yLzRgeeunCporEaiklhSLrfdpLGay3WMsG6FtJZIP+cKZBHElf6yIDofbLHhv/r9
	 EC+e+rPbgchT9fBvl0JfexxkMsEt9zm9rkYCiQBxyBBZt/jbDaiE9B+FWCqWqYCaJmncB
	 YKZkhnwEhkEwt8ux7rZS/4YczfFZGitVn6sMVgxdcSJa3cAhDiqaRS5LQwGSYUUrKVDnd
	 YNc3Puo82XeIswD7paYJhGVWdu0APFMdlX1TYz9eAJHEWB77nw5++/0qSwKzHssZ1dg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795442683;
	bh=LVkO/gQpo884eaW3bRZIas+UuZ+uzy3gWZQhaXydPsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=axPwTT9y5+xupJNWuHb6dNdjVnHcVVeuqioGk6rV8HLcNLAQjGWYpFvluk4L+lB2S
	 BykUudi69MGqPUy/kSro/4Bc5iw0T+pCu5iXbAYzuJ2zqKZlbkmTq4PdO5pybAyfAQ
	 nBYyuAVFOn7+3bp9UkhbeiFkLXE17A6DlDoz07c5eX+VTPRO/ok9RY8JU2FWkqrijs
	 kg6LR4IOiI1Lx727SCUVnP6vkeDnztUUEfLiFwMpJYlfnGwd8l/syOdywdajDvGlNA
	 eWcQxZxaGWyVXMRbksMFe4Gnu+doNb7xtbRdaMQA88zPDGe+jK313ORmMmbFyMLWBo
	 qDbqn6pgzOj0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6023C80D83;
	Mon, 23 Nov 2026 14:04:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D92F759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F48F606B1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0IG21_lvcSI for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B9CB605F4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=46.19.12.180
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.19.12.180;
 helo=cp2.siel.si; envelope-from=primoz.fiser@norik.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256
 header.s=default header.b=RF4ovJL0
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B9CB605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LVkO/gQpo884eaW3bRZIas+UuZ+uzy3gWZQhaXydPsc=; b=RF4ovJL0TvJhH690zWEkYJYiTF
 47k1rO0G0Z25ghmGxJqLOKbKnSLDI26rSuVlIFHVYMWYK5HTZW6yRkym8ropZ8vRVFaB9IJ/J5hrJ
 lBdXL3OK3HMB0F54vD1KucG99k9a1vhoA8ZxOqkcMlqoTxiwl2ezgGz1qWLfKf/PwKx6Z/JuozOoo
 VZqbVcOQbvzm0BhTbTwshkEWEq921Xuhk9e1B7IIDuPxmllmNsoupEje/bqulF91g+zwJGX8d1iwe
 SQuwyqT4736BjQZ4OSGA3Q4YbX2CAKUfLoAY6oiPfUWUKLHy4dUlSrO2VQRIBA5mq6f0rD9Zu/XPd
 TFcSv2GQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:59646
 helo=z840.taila37813.ts.net)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <primoz.fiser@norik.com>)
 id 1xVUet-0000000H57M-1WNS; Mon, 23 Nov 2026 15:04:37 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH 3/3] configs: phycore-imx8mm, tauri-l: Enable crc32 command
Date: Mon, 23 Nov 2026 15:04:37 +0100
Message-Id: <20261123140437.1526666-4-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123140437.1526666-1-primoz.fiser@norik.com>
References: <20261123140437.1526666-1-primoz.fiser@norik.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stop disabling CONFIG_CMD_CRC32 (default y) so the "crc32" command is
available, e.g. for verifying images loaded into memory and for the
PHYTEC automated testing purposes.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 1 -
 configs/phycore-imx8mm_defconfig         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 3bff958a00c0..77712355fbac 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -45,7 +45,6 @@ CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_CMD_ERASEENV=y
-# CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_SIZE=4096
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 39672b3fc211..a7e5bec0ec93 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -52,7 +52,6 @@ CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_CMD_ERASEENV=y
-# CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_SIZE=4096
-- 
2.34.1

