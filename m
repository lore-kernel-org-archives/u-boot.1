Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A1606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GoZJdehe;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uJAZZzw3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88811605EF;
	Mon, 26 Oct 2026 21:32:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3z5d53acmbT; Mon, 26 Oct 2026 21:32:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF7DD60661
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050322;
	b=N1kr/U1hAdVAs/MzSxR+OA7zON5Z0MZTPfI3e1Yx1FK2pQ6Az87sAdFrKihze7uROQ+T
	 W6CLhmSbT+pwYgiG0UZGm48vQ7JMi4pMakByNEvDPP/0NP9asjMbHYMMfCR3C6p3zNF4R
	 TxFDcdr7Dd/ER3e/gvibfwO1xsEsF39F2aQNwj+mHOZyUVWlNFKuZHK2FgHwr1wL4/txT
	 KmzcwYIvnmvyGDpcMgKTt98i/BBrQjPJNmPhRBoM6sUmEN+iobaRRxzsFDch1PSCZoRwk
	 WMzRWLdsKEravwOC9AClnJmlvLJ7iNZJ0/dDFou34LFy4tRVh5LVBIWvKDFbBESXDuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6SnZshwSKu1621bPwP3WOKkNcsJK7R/jw4S6yxC1gqs=;
	b=j2X5YiEvzXfbOelicIU+CdnRhnKG8KxKadWWvFf6M8i1JD9tzJN3SnJ1fizObdZTHiaN
	 p6i0VhTBFOrDVLY+aChGndJohD6+tJE6tZYwTETYnP/9LVMToS6tuHkmn9zgP9u8TRlOS
	 VgFYdk0nN6f9o12jdflmwrMb1kuWBBDJsKqwLmPUyW4CC6yIOL97Euohk7G7kOKPpReBZ
	 Wc1aHeHxA81XdwJ8UbME6OLyMq+faIetOFWfBTl7b7jbcCzZOmueYbiU/y5pFXPTjyzLM
	 iK4dpKXAtLyDtW9C9w7zAnd2f+FqFqBtrV0wYyLlZszgVnpoFjROnoEwaLGGey+E4pQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uJAZZzw3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050322;
	bh=6SnZshwSKu1621bPwP3WOKkNcsJK7R/jw4S6yxC1gqs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GoZJdeheeHUyye9YafLVl7xBDFyRC+ngDAtzJ8ZU//qFy7HR/U8/gdIXI9EAeavyV
	 LYpNiUiyklPjVT5r2gRvXU1EEVGV9KYoT4zUcf+hHxn0PY6vvC31DtVSXrdFnerNEa
	 SbPwtAC2l3bN3n4jtbybLjuoqrYdkb1IpKUQICBrUtvQAZj/l9bwV0zxbnLrW61oZz
	 p12R6xGgLlKQzfXioCN44QTIT+6tjgrC8vdrC5RCM04u+U2u8F1DyfXgGWO8788Ulv
	 nTl9uULELTzNg4bEqmfUcgYhA3xawBFJl8cWTtEv5gtkzealoPzhlO5kiVi1fGJgyl
	 uMsX8HpLvc5iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF7DD60661;
	Mon, 26 Oct 2026 21:32:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B3053421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CEB160661
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R8uqGJZXgzxo for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:31:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88C2260683
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050319;
 b=fQbWL4M9FRL7jCiDnYUM2YA0kNTwlSUEaurpjFqPSEs9MyY8sc42uOb5eojic33si0w0
 e5haCy+vTFBVrzHTY/cJ79zS4VZki9O01kWs2/PC1Jnev3T7zJZ6NdQ49zjOqe+Kv4eAh
 Zn01hYk5NQ8zbMtQNM2YZyRxAnv02+e4M/xmSVYkKV3Ms10OkR6eWUuz2ZIbFjOMjxmmD
 QwDvnsAlVPxDoy6B7hZCCPJnkHLubGsnTIPnBK5fzcaguK6UnJOh42+tWH5dxcqT1yHcd
 XSk5LSo256qKjFqgbCTth3NPelcpPw/qJr89IvDNA60xCCe+XtH+p/dCA8+bUlWMntQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050319;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=6SnZshwSKu1621bPwP3WOKkNcsJK7R/jw4S6yxC1gqs=;
 b=RNyzarCvnJuyQZYvWtqLmfDZI7W5QEIwd9lm4tRSvDUOzbUnPLt+HxdqDwKnQWRLCr8W
 gUIdqrbFTpM71ewSyCTGCmw/EY9p96TM7BzI6FW4L9xWxfcQR3ADJ/l0+HItlGKYhcMXl
 G8B0jzFTvW39afUeZAy2/+fcwD0Slcd+pHMDOlzsikdd9NNwAvdXimWB/LCv3SvvW/wHU
 +gUJwmLqh+V4+Py4OU1+yqWJY1eEVjy0c79knW2QStAlomQJfbFi4tb/DM/hhgN4AgI/Y
 GLvMkLP2hRLuZlYhYuSjidkQmof+gzYQnVK4IJNWh87iTt3Smz+xjpA1f99qYNUQPQg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=uJAZZzw3; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=uJAZZzw3
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88C2260683
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:58 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jD6Jq5q6CzKp5J;
 Mon, 26 Oct 2026 22:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6SnZshwSKu1621bPwP3WOKkNcsJK7R/jw4S6yxC1gqs=;
 b=uJAZZzw3C36kPDqN2Pjg1LPhgiESKPa3+WC6iEwf5xbSS3IAgcXv+wUBcYb1zvY/ej5BbT
 gd+j0khc6USngqDxilwZ4tS+2OnRq5o1SawT46sG1G089b4qs/E8HhrV58QkHf/Yn5r38y
 yAyDL1zQY+CzZ9EhhD/MXNjASMctwmYELHDyvzdPl20oR2cMC1DRgEqqvw/Qxu6xIRtCvl
 9nDI7HYx9Zo0SX1ZdHUCRJx8McaKxPuV+HMBFlijuppaEokoqu0KoMrLePoZBS6VX86zXU
 tR6CVsLs6r+BsctA3G2nI3Iqi+HsClzTC0lvUnzm4DC2x42Njjzn3uSWL6PKVQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Reduce size on Renesas R-Car Gen3
 Salvator-X(S)
Date: Mon, 26 Oct 2026 22:31:30 +0100
Message-ID: <20261026213152.453359-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2f9884a37c06088dfb6
X-MBO-RS-META: jc84n3d5ih6ogmria4ekbpw4t8873wfh
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

Disable EFI collation protocol, SMBIOS and booting of PLAN9, RTEMS
and VXWORKS. This saves about 8 kiB from the resulting binary.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/rcar3_salvator-x_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 3c078feef51..50bfa185324 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -18,7 +18,13 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_PCI=y
 CONFIG_SYS_MONITOR_BASE=0x00000000
 # CONFIG_EFI_UNICODE_CAPITALIZATION is not set
+# CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2 is not set
+# CONFIG_SMBIOS is not set
 # CONFIG_BOOTSTD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF_BOOTVX is not set
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a77951-salvator-x.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
-- 
2.53.0

