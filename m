Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE0606EE8C
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eMsxUDQ8;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=B9+CVWOX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AB70810C3;
	Thu,  5 Nov 2026 14:06:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gyGQ4OFTqjGa; Thu,  5 Nov 2026 14:06:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D41F681138
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887576;
	b=GGBHkqMkrtynwov6cYj1Ld8IO6zENLsvtwIe31WeNagdkbFXJO6dIfNVdhp+gjCZJy7N
	 YoivufTACU6eX8RKhiD7ZrDJv9H8llNbJg1MMjMaVW0Zsgw1zgo8rJgefAEmKrWAr1rAC
	 iZeQ2vxz7bdX5AMk7hWZRnXX6WJaPlcKDxS392XnGPouqgBWpf5TQDoaGp9GhpGcdGZPK
	 AmmAGXhkJMwmgBcgtp9v4/fakdUOH78aifM8EqydmpKr8q4Ye1Yj+0GVPrWHKJBfJbL0o
	 tVRuc+imIcN/IvleoNKX+fwXYKUOzvYrODeaurg3OUInNHA7xd9hjeVokon5dsRhn1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FQZ7DCRX07v2jClcwoYH50P6Osaq53ja4jxbcRp89co=;
	b=DQkEnN1nKwzy2Qvu5wWr07pqGh+xmUZvhmiekjT+RsFNVBVGIFnQ4jzpdhW/oCaeMPA0
	 HF5kyze1Z8YEFAQ/gyL0OEX5sgkgxX0xRRHPRwN6cj/O1a5owSzRMGw5JkHqBYn4XLV2b
	 x2TjrwjPwmeCSif/HSUODUa3FySQzkTSkMhXuKZA1ia6cF51qNnF23uPmOjtzEGA2l7GW
	 CSy4N8+O13jbXGtSl/Kd1Xsd5ofLO5ImwDtgpziphYEcpp31+h1bmVZ+wZyhpTpUvBlDM
	 OETASlX/74iCGdJIIguVS4ugx29wML4RhdgFxSI1BnBFwBaUiDtSNwssgkPRTlziWEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=B9+CVWOX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887576;
	bh=FQZ7DCRX07v2jClcwoYH50P6Osaq53ja4jxbcRp89co=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eMsxUDQ8SJbQDBVJiy2tJT2g8mAbbwDOtf1bVBCQyqqX7/SSvh2dH1859ocDVAc30
	 0aSz8JFA09sYAPmu1fft4mqGugTjQ8wuBIa9E3sBlW975Px+vBqsW8abbFURz0OxNR
	 MclrqQnAy+/phL3n9W4yDuiTITX679z04rLQGQd+r3DBiCh7P/3QrBjdh60+UywzVa
	 +XNILVS5/sBLtGecXVLCMYwECl/26rprmb0MNMfKi0CrFRiZahRGOo+ruDmUdmDPej
	 VI9ydKrck3ToI0pzx/GRAR7x75BIXAxhbhhMPCv9vOcRRT+hvQcDxa1gwZyKb+lBMn
	 luVWNnipJfF6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D41F681138;
	Thu,  5 Nov 2026 14:06:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D185F52B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B771481160
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mCIajQEdJvjI for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 353A5810C3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=thomas.perrot@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=B9+CVWOX
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 353A5810C3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 46A2CC6915A;
 Thu,  5 Nov 2026 14:06:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 255FA5FF85;
 Thu,  5 Nov 2026 14:06:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E70C9103291F6; Thu,  5 Nov 2026 15:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793887567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FQZ7DCRX07v2jClcwoYH50P6Osaq53ja4jxbcRp89co=;
 b=B9+CVWOXToKRmMaqCOUuh1NdH237u9yPO233o4VqVs6s1XmM9HRf3i4SWWsgaclAznNkwo
 k1RZ0iXm1eBS5uEYAXTfSnjUL0gZxaM5pbH3dpl+g+iCrw8f9aLZzQ869V7WdugFzmZQgT
 DNIxXxVzee89BEdaBt2xwHjr+Zo/8ppdMk21tsJzobKfbdWceA6hOgDS0GXS3UO+7YGWAp
 wW102H3/YBclrRW5gBmL5v/j5oG+NNiY5rwitlIOqXulDMxFuRdqDUgah5zUFMGazxrmq9
 QHVUm+PK3S5WW3xavDgz9muxKgt9LP9lnkIXLlqRpP1DcYIPtXhce+UE9s2mfg==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Thu, 05 Nov 2026 15:05:56 +0100
Subject: [PATCH RESEND 1/3] ram: thead: th1520: Add single rank support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dev-tprrt-beaglev-ahead-spl-v1-1-ba7472d69ebf@bootlin.com>
References: <20261105-dev-tprrt-beaglev-ahead-spl-v1-0-ba7472d69ebf@bootlin.com>
In-Reply-To: <20261105-dev-tprrt-beaglev-ahead-spl-v1-0-ba7472d69ebf@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Thomas Perrot <thomas.perrot@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The controller initialization only handles the dual rank configuration
and fails with -EINVAL when the firmware describes a single rank, as it
is the case for the BeagleV-Ahead.

Select the rank configuration in MSTR and the matching address mapping
in ADDRMAP0 from the number of ranks described by the firmware, with the
values used for 64-bit LPDDR4X by the vendor DDR initialization code.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 drivers/ram/thead/th1520_ddr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ram/thead/th1520_ddr.c b/drivers/ram/thead/th1520_ddr.c
index bb4736b02362..6e88ec0256c5 100644
--- a/drivers/ram/thead/th1520_ddr.c
+++ b/drivers/ram/thead/th1520_ddr.c
@@ -309,10 +309,16 @@ static int th1520_ddr_ctrl_init(void __iomem *ctrlreg, struct th1520_ddr_fw *fw)
 	if (ret)
 		return ret;
 
-	if (fw->ranknum == 2)
+	switch (fw->ranknum) {
+	case 1:
+		writel(0x01080020, ctrlreg + TH1520_CTRL_MSTR);
+		break;
+	case 2:
 		writel(0x03080020, ctrlreg + TH1520_CTRL_MSTR);
-	else
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	writel(0x00003030, ctrlreg + TH1520_CTRL_MRCTRL0);
 	writel(0x0002d90f, ctrlreg + TH1520_CTRL_MRCTRL1);
@@ -479,7 +485,8 @@ static int th1520_ddr_ctrl_init(void __iomem *ctrlreg, struct th1520_ddr_fw *fw)
 
 	switch (fw->bitwidth) {
 	case 64:
-		writel(0x00040018, ctrlreg + TH1520_CTRL_ADDRMAP0);
+		writel(fw->ranknum == 2 ? 0x00040018 : 0x0004001f,
+		       ctrlreg + TH1520_CTRL_ADDRMAP0);
 		writel(0x00090909, ctrlreg + TH1520_CTRL_ADDRMAP1);
 		writel(0x00000000, ctrlreg + TH1520_CTRL_ADDRMAP2);
 		writel(0x01010101, ctrlreg + TH1520_CTRL_ADDRMAP3);

-- 
2.56.0

