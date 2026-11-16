Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D8606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kDHJO9x9;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=OALSTpym
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C53D810C3;
	Mon, 16 Nov 2026 17:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vP_Rhlv34bBr; Mon, 16 Nov 2026 17:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95193810A5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850565;
	b=HImmfvmP+Z7WoZukBAeyR2VHV9Wz6Jsy6QA5M7jE5/2dEVZes0le5D35uHrJJWW0YNNs
	 nH5He2cz96i0xc/v/VhYGqf65sjUzm4ojto16j0T1GeYRrWFFvFdgotqOPB0sGLBn7lM5
	 JNTnEjHQNH3PnB1Z+vNjzeNfcIlMLAf8fCd3J+C3kMxeX9EOFsiexrpOkkX8kdYKeXn5h
	 p9vboAy8ZACCuwEwQMfiyn1prUbBhadRdgynwZPZdrYWr0aYe16UxJJj7WRSsbaWM2W2f
	 Mwg/X6p8uL+NNTonD+I+0sUDUlIR51jsSISpylpTE9CxoiN7seqk2SWQSWyoostvqqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1dWo9C8+x1BHRQClUlPKR76gheT5qJ0pNfOKw0lXBtw=;
	b=A5h6IsUs0XG/jDA0xEQ+/omiSCYdtL4nRIodhv5JIGZn3aToptL7LnDYUAXyD2VleRIW
	 QoInDAFe49u8Ln3DB3nSkSScHBGky6VT3dWckbYYOKhB8gSnYHzWtcFB0pEQrx1V2cC8Z
	 JjL3tGzFHBkt2b22XGSYaczd1KEb1D6u2LT/lEn71EOBckBi7vhIDhdgoGETWRKcJCDaP
	 sDnrHkEmSaUCsm4KxF7wpPQ9gDHJ+jT4QpA3TsrszPUfgBStyClHjjlTQL/mva4RZJJIV
	 1m/RiZLKOLbIylf30sl3m4D+DgFOBWn4WUz09t73dqpQ/IKa9axmlCHKsntP6wTm+iw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=OALSTpym;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850565;
	bh=1dWo9C8+x1BHRQClUlPKR76gheT5qJ0pNfOKw0lXBtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDHJO9x9FTmnaQnqe9YulqSoQKvmFkwxTxA28Oc2xc7x27D4LSWpiftgsQ9fCnhIC
	 J4l/+UoluJAK3MBdp7LB668Ha8mMj2gei8ACjtPJLAZTlHrGu2tIS8HwLHPFke5f7O
	 6RoNZI26k9YfwDjsWY1R7+JZpMKixBppZS6lVnwgKh6hKfRkfTiKps8UR2YBZDvf0o
	 ZCSS1tWvuf+yryy5ukeWGfxpeoDMb7LMMkHFYSw17SGnJsintglStASEHtWMFDdTTa
	 u/UyXUhON2laV+r41Kdp6HD/uX2nWETFXK1wRagJVOLaZow7kHXM5A9LzYv0cpPRGi
	 0vmUdddvsSt0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95193810A5;
	Mon, 16 Nov 2026 17:36:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD0422FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EAFC81062
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2djyPqGKITpS for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA6DE81061
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=OALSTpym
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA6DE81061
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSw4p3msszMln6;
 Mon, 16 Nov 2026 18:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dWo9C8+x1BHRQClUlPKR76gheT5qJ0pNfOKw0lXBtw=;
 b=OALSTpymFbpXRpz5ThPVvdIcV+kjWrythaxMy54aFezYyArPhXXKyWvt316jFyLCIoVm28
 YGSOXEEkVXkFNF8879vFBkbbkj5Vu8+sfuZ+WKpX4+nA2A9YOIrBMzCaNwEdO4Om+SbhNp
 afcqCSyfFAxtN2GuTiejZZEh7VMpmtle2xSB1lW2Du9gkSwP62En+R1XgO+rXnGnEphxPl
 XPBPslFAIhHIgiElPghuguVJkzd/l6MLqikR7GQPmH3sVbhfcJMLzHPQf610bpouFNfIx6
 5BK+IYzIhXTH4QAVqoCMKk23V+OvT79CH1qGeB2C1fKA2l/KWFhhybIovkRNOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/20] clk: intel: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:45 +0100
Message-ID: <20261116173546.3487841-6-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j5kehcpgtau9yrgtbwdkm6g8kg6phema
X-MBO-RS-ID: 4d12c392aca01726c72
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/intel/clk_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/intel/clk_intel.c b/drivers/clk/intel/clk_intel.c
index a677a7caac7..c9cb4d19dc1 100644
--- a/drivers/clk/intel/clk_intel.c
+++ b/drivers/clk/intel/clk_intel.c
@@ -19,7 +19,7 @@ static ulong intel_clk_get_rate(struct clk *clk)
 	}
 }
 
-static struct clk_ops intel_clk_ops = {
+static const struct clk_ops intel_clk_ops = {
 	.get_rate	= intel_clk_get_rate,
 };
 
-- 
2.53.0

