Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B1606A32C
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kB36x0+J;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=fcagnO/V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC5E740775;
	Tue, 24 Nov 2026 15:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jAsOvyf1JVVG; Tue, 24 Nov 2026 15:51:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B89940662
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795535469;
	b=XjNy0tLHSyhsCcJfrzZMafCCRBslAVrHN0hO4yAjMNhZczK8hGoooaF8mHKrco6uHykm
	 q6vWKQZm62gm+nQQ+nljDUucqoYgAHMD44p9CTiDa/wMZRBaEIKnwoeoNAHSm95ju6FLY
	 ybz8dEFXtkb8bXvGFk6MQzDceiyvZ7UT2Le2TfIerA3eBr9JEnOwavsd6OeJjLvDmCSa/
	 Q3RAdEKNrBRfc1mcnmMDARIGsnVy+vCsMP4l+zEb7wpAYVkNioO+LoVqBqPWBU6o3gQbE
	 1Veqq0kt/G32cpGSxBXTjakwSbc5snQY+huhVt4RmwdR+u8vF4/yTlTX3+Qjkg0ltBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795535469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=asR7weuXvrOU+VHLFkN2PwQjRBoxMq144Y/yjMfiSVY=;
	b=aRyGhQfWrIrKGKugGU0Ecx5nMGhA9SZgg+1F5CuQNBQ01fB45FJuBgJhyPbscw0PcJxO
	 OlTqGa2BUahu4cLupBi5py1z5Pp4uMUSZTTllHtifkZtyA8Psz9a/fmX2GCCrcvN1SM+h
	 +Mh7/dhGqKdtpuGqeGwVb7Sm6ayPF47Gv2CEK3no5PfFQQ2/NYWIQ7F9b/zW4oKke3yCO
	 hHiAKfs2DetAixgqUAQe98wa2Tqo5cMczcMwklajrPFStvhfI4ueKIJP3tjkXP8yvoDWd
	 2wsJN5NCNot6kcs3V0oEU/xjC9S/mPOCsnSNzVm0O6PKv/NT2zUA73zvOJFC9bnKkdQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795535469;
	bh=asR7weuXvrOU+VHLFkN2PwQjRBoxMq144Y/yjMfiSVY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kB36x0+JVMa6T/ywxDNFQFyVcJLMZRi04zQ5GnMymxtQNUgP/4YlMdBWVg7Vr4Aia
	 hXzQHVQg5utJtEUUrPyR0bCsfilywVGSy2LvmJXg+64oegkqasGsEZRe0fALCCHi3b
	 SYPzdcoaTZ4TR2Zl8/bVIdUdlaOGKAbZ+8PWg7UZPV1QncEfpZj1rHIsksrm9LyIIZ
	 NL6eHIq4q3vfCtXS/P+xwWcBLLtdi4BnSM0kIY/Xc2Gum4pvZd57RK8co8mZF9iPQh
	 X5wIveDuhbj1KSTJ/yQpQe0zXorv26BJ10AvBB3Ovb9G2srHBeF8BdRbWVCi+foJkl
	 nRnM3L3IhUIkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B89940662;
	Tue, 24 Nov 2026 15:51:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92971499
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 847FF40282
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HBRndayaWTtk for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 15:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 81D63400B3
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=fcagnO/V
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81D63400B3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:51:05 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jYnN54XfhzKmGJ;
 Tue, 24 Nov 2026 16:51:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795535461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=asR7weuXvrOU+VHLFkN2PwQjRBoxMq144Y/yjMfiSVY=;
 b=fcagnO/VQPQ0jBtEZMusr3M0C6BHRx8+9geRyWZ37DedhMDnn6TY8Wcv021LnEDfgOQLKD
 WOBOSG1p7BGHJ2VrBkIhOgKFWIxpGbZaCSZiN3x+GzIsBRlCY16/seNF1qcC+uVG97eHae
 g5/W5OzUU+qFsRMDeEYvODGOpB6L6jtZrTOZTvgxkCZLReYwbtyKEnLVuxeJYj1rCdkQpn
 8tLYFTr6P1L4n56zFAL4+jU3ICMuzbEkkw2gjFnLRHQGLehWaJEMBjyGTTL+lSuMWwIoUi
 0GnXXyJw8L6OGQvExcqhvW7ixiDMHrTYcDQb3NcPHXfAvxcokXLcEDeniADovA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Disable DFU_SF on Renesas R-Car Gen3
 Salvator-X(S) and ULCB
Date: Tue, 24 Nov 2026 16:50:36 +0100
Message-ID: <20261124155059.192295-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: eb96eaf6e3a64822d03
X-MBO-RS-META: eykub1syhjhns3faunqqtm43eku8btre
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DFU_SF support is not necessary to operate DFU TFTP update into
the HyperFlash. Disable DFU_SF support.

Fixes: 42805b17e62e ("ARM: rmobile: Enable dfu tftp on Gen3")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/rcar3_salvator-x_defconfig | 1 -
 configs/rcar3_ulcb_defconfig       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 50bfa185324..57a9ab6a16b 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -48,7 +48,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
-CONFIG_DFU_SF=y
 CONFIG_SYS_I2C_RCAR_IIC=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index f3e2112a91e..aad83fd639f 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -36,7 +36,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
-CONFIG_DFU_SF=y
 CONFIG_SYS_I2C_RCAR_IIC=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
-- 
2.53.0

