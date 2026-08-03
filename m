Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909D6C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 534DF606B4;
	Mon,  3 Aug 2026 23:18:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkQ0fUgt3HTS; Mon,  3 Aug 2026 23:18:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75796606AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799103;
	bh=slJbM0ulhoWs8w1wZXlvHE6cnKQMyq435RtuFXYCqt0=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=G/z5DQTEQMBlXxx98jVxgpmv+myy0TbVr8OxUHcs2wk3FpLweQcq/L+VVGioh3cLO
	 AnOJkGrKBFmDF5E6rVqtTKNxkUFLmEF41drhaSF4p35S8tkP8hD3O3ny5+QHGnVXPq
	 2Wr7rMgverPDqWvFd+WjjV8rwxNhmCnYGQw6xkO3gUHVCyvZBSbUUH8CGY1/2uWceE
	 jRLFit+RvrxndIm+qNflo3VRftYBxZUpGW9J/JXsDbMo6oN6ltn6H6l8ccQS7dLXcq
	 7QfBa+SHrEj13oxVsuClrA1vziPQO7jWlElPrvAKn2NaQtlJF0oPA2EJpjQnhJAc6J
	 geKd/XcVtQxkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75796606AE;
	Mon,  3 Aug 2026 23:18:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 908AF23F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 828B7405EE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ivf19BziyLga for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:18:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 60332405E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60332405E4
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60332405E4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:18:20 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hDXfL3H5jzMlG8;
 Tue, 04 Aug 2026 01:18:18 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Disable MMC support on R-Car R8A78000 X5H
 Cortex-M33 RSIP port
Date: Tue,  4 Aug 2026 01:18:01 +0200
Message-ID: <20260803231815.374087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8e40ca89f774ac59d0a
X-MBO-RS-META: j17cg31gif6nku7ijuf7ywifb1au45cp
X-Rspamd-Queue-Id: 4hDXfL3H5jzMlG8
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=slJbM0ulhoWs8w1wZXlvHE6cnKQMyq435RtuFXYCqt0=;
 b=nshmkILLKeTz4LT/LJTv8dieqi+SGtxCOByIaI7MOxYEcEJFX+jJC0bYaY2CEFDJdUNRJL
 BADaisg9K+F6DUoToi1ArPxKj9Q3r6ftmtc/Utsh/+ENzvJPId42bAKJYfCha16bST4OP+
 TXDOXdQSo9ztOKKwE+xbyIkyhrl/iQNuo4xTCRTLt2MfpvgZ3ql6WcZtKh7vYTPScwcL8g
 Vw7HC9fFoSt8vePz5Cxq2zBrJbvq3Z4d1cSPD0Wtxiq0TBQGxbVpJtGaPLPZW/ouhrCimF
 +NoZkrU5hRHXdJTOxcsIiMFTTe0lJTI7OrskyB1mRFxnWTC4bQVeYYpGqEb2qA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=slJbM0ulhoWs8w1wZXlvHE6cnKQMyq435RtuFXYCqt0=;
 b=dH+KjZbN2sGHIsrfMozzpKy8M+9VogzkUj/GaZ04obDOP08dPjcpyo+aRnR5EEPVfP+/+h
 Wy4/i4wJbkcHcXFNvKRRJ/HAdJnuxBbT0ZURnXY8KRACMavpYl0HD193+GkmBsTydf52iA
 gUfq47s6cwGiyjlnEdToSQIwPl2g385HscJzhQbW5URdcAwyAjAfLIxCuQ1KUR6VT7RWRs
 Fy5s/csTtl5VrW14oJmjQrddCYMJoR04JwhT8XxmnsFhbmUpH3v/frW9pkqkeGtzRLeeJI
 k3zmNmm1n400wNT0pjtlPTQDgorxX51N5+9w3vqYL0ffoUE2tj34km5xacWq6A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=nshmkILL; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=dH+KjZbN
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=dH+KjZbN;
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

Disable MMC support on R-Car R8A78000 X5H Cortex-M33 RSIP port.
The MMC is never used by the RSIP core, disable the support.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/r8a78000_ironhide_cm33_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index 7ea3ae993ba..4b01d82647a 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -76,6 +76,7 @@ CONFIG_WDT_RENESAS_WWDT=y
 # CONFIG_BOARD_EARLY_INIT_F is not set
 # CONFIG_OF_BOARD_SETUP is not set
 # CONFIG_SYS_ARCH_TIMER is not set
+# CONFIG_MMC is not set
 
 CONFIG_DEBUG_UART=y
 CONFIG_DEBUG_UART_SCIF=y
-- 
2.53.0

