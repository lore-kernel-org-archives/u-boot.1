Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E91606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MS1HD202;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=vzzEoxN0;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=AnzNBwLe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F053405BD;
	Mon, 26 Oct 2026 22:55:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z3V4QZ8vl9v0; Mon, 26 Oct 2026 22:55:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E02D640557
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055319;
	b=MCXb8CesszJgDnjH/UzS4D2JByYIMgPtj75jRBC0TphVt54I4fqWnMPvazLtH4LWrHj+
	 yjJpoODHeRCCnHH68jhnYWJvV61jkimTzj0v+FzIPvRO7ysvdpqndZULL5MioFB6tN/DZ
	 WXpew7NUA4H9cWwUe30dM0lgNLUxhP1P1iRycBLqREbY/VPGj0G4FNCeBXS45ZMldEif5
	 mfuEDb/saAvjIpTI+zmZPc6BTLBjVUyT+YMbFGfF06yW7VUo/Ta/lxCE5pwYrKzZ2ahge
	 ZqYOZ+pTBnZZvlB5t8EhbH4eh+JC4McpoaBtt4qzFTUI7h38+H44fhyWK7uF84BkrfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9eYITK9l5/mSJNVvVJBPXL5JUHUXDBlefHOkofm7Lag=;
	b=Ia/qcF3efr8Z/6I9yyqpVYcMtPvYFZ2Afgpatu0RUm14A8nNLNGMe2r91FpfB12nBNOH
	 WRMLoyZ6NYyfTSZn8UyvuCK1toxTqyU6GM0X1IESzdtmtLpgY3UikmwTqtbDEzJglDRPj
	 sqm5EhHwkN6t7HgxTIV+imZy8n7oBx8z0oHdRsEBS78C0HqO8W2EosIACvEoRHjM7iLoq
	 iylXfaIriDBcNN4IR6tuVahprDFe6q6bcFC90GenhPmknQJhT2c4p9KR0Fu4m1jVhSiz+
	 9OHGjYmFt4dUuZD61p8pleR6z7iESyS6rIIgMLE17lvqzIwSs3RDf3DqlptNIV/E2Tg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=vzzEoxN0;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=AnzNBwLe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055319;
	bh=9eYITK9l5/mSJNVvVJBPXL5JUHUXDBlefHOkofm7Lag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MS1HD202ihCKL+/NIFJpRjZAHo2wOGu4U9cwN7Of/QXPkMMlFRt1oWG0mmpqS66rw
	 CeQfC2MZvh/znm3mXlNXiTytNxqhAIG3pqUudXxs9qhyRxGCHtdz1u72KZ9Hufemm2
	 9/PLNL2++99APRv8y75WH2RZnK2etkzJ6cV6dQYTJhpa+cbwrXVv8c0b0cEI2IINos
	 nvzazgvmG6YVXVLEmXHEuM/ITgdxMsId2sjGBG/W+v9l4AerXuul2ccLKQ1rhjkGUO
	 9MTjOjjmVRNDu1fSKeEevWkJF/Blyv4Nz5ph43qnBYcfvEXXa2IKIIU/04HjeCLuKm
	 OrD4Lq/ELRowA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E02D640557;
	Mon, 26 Oct 2026 22:55:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9682AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA8C9404F8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaYUqwJPJK76 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBCB540501
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=69.169.224.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055309;
 b=OCuyswg/JZ6OC7Azj7b+ncjQr4bFKdo5jRwJBHkXNnym2pOJo4lejYW01Zn4D2+b+2zJ
 oJox4CiZfsk/Sf2VSccGUbAHLoAs8hHIYvj00/JE8ecDvZpiE+54PUURpi44CkTP56mkX
 3sabM12PRGLQGTiZjuMWTYi5kea+Ztm1dou2n6jZpjb+d2AqXTD6nRb0zx0xTBs8gJuT3
 F1dkvUGsnt+ajuJa5vO1LMmcOEWIJbFXpBfO4C4X2G6EM0H2A1qt29q5FaTCTFBvp8U0X
 3hWNQJ62/7CFLq5J1/X05SVOxEO2jH/8s4G9jjoFKkmq4rMvtu8NgkW0+OeXwnPxY7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055309;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=9eYITK9l5/mSJNVvVJBPXL5JUHUXDBlefHOkofm7Lag=;
 b=bN4gQaBpf4ExTu3g9NY+c9PYy4ltsis4ek7pbxsd1hXA61UmLk3AtFj/wHUlyNpXBaNs
 p39C1yqBdypyZEQvNd2yUKUThShhDo+foU/KYaDYrLyZHkndWQow7WersiM7C5xXt6H1H
 qsqcAhBunD1/wUxcazbAOzZsP0ZLotz2udDf4kH8J2vQwmNL2QWl71IGEy/GSNdawzJwD
 T1KtUcXBzQImnCdwbTVjStzUxvyWgQ9ehEI1Nq3L/XpY9+axqG2jktm5JnzdLx8Tn9VFt
 vf3kNzxl9l2JtGe05rH/vpCbsz1oqZXCV0P2ZU3ZShfTwuOLIkAkIj8jpTjlNzQFMPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=vzzEoxN0; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=AnzNBwLe; 
 arc=none smtp.remote-ip=69.169.224.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.7;
 helo=b224-7.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cb39d-93410dc3-89cb-402c-afa3-3e65d7c4d0ab-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=vzzEoxN0; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=AnzNBwLe
Received: from b224-7.smtp-out.eu-central-1.amazonses.com
 (b224-7.smtp-out.eu-central-1.amazonses.com [69.169.224.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBCB540501
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055306;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=dxWXbM71ud6JYnFyRKoN2Ir/PZwlDqj6n6kiW7pdi9Q=;
 b=vzzEoxN0OrQwvqnDNP/BMbPiFs8pldgJoOePqPmmogf1YOh236iBoxHFJ64RU1tT
 3y2p2OmOKEEA1F2PVe2uXFoam+13l3zJK1/mvSk8DccltbojdOSJW0B6L1OKwveQZyF
 c/TJHbN16PHL+j/RwCxrCb6TcCHPPxkh+zG0lG4J5ZubCIXoTa8tK1exSsClvPl/+Pk
 /Utm2LW6G6SDyc/689lrc9GFB63V2PEY9ERF+75WbKzef5mXM5JVXOqd37LKhSgh5Tm
 +aflIuVLgP7GxZocHD9RxqyQxq945rCeyQYF3h56p01xfmLH8uYdHqt/CJNJDyCty1g
 RHn+Uj6rKA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055306;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=dxWXbM71ud6JYnFyRKoN2Ir/PZwlDqj6n6kiW7pdi9Q=;
 b=AnzNBwLes2v1QqjBTFBfXGCxgJOEWXZdC06aV//3NhYOAHhBBGBDfgCdgIYu32VH
 g09jT3H+rOpcd/l/FZdHQIm2sH4JNSWfz4+cKi8wVLEMtqt3nY70YE/gG0e7OeYGCLz
 GmfiQl934FJTMfAjzUG+f9dVq2oZKRrOm2jqaY48=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:06 +0000
Subject: [PATCH v2 06/14] usb: Add DWC2 HS OTG params for S5L87xx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cb39d-93410dc3-89cb-402c-afa3-3e65d7c4d0ab-000000@eu-central-1.amazonses.com>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
In-Reply-To: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=1388;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=dxWXbM71ud6JYnFyRKoN2Ir/PZwlDqj6n6kiW7pdi9Q=;
 b=DcDB4/I7HzcxqmOL4LOEVP7fVY98TRGBMpWRCkIdFk1xejb0Y+iM67AR05D7ZAVk93nDSQQ5e
 ryxTSWs5yAXDlFQ5EUzdo2x6R4661poUAFuCl4Kl4Qa5xFTLn4Rb5Cr
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.7
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

The DWC2 core in S5L87xx needs a specific GUSBCFG.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 4dc049d64b1..ac36e5e2d87 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -1042,6 +1042,17 @@ static void dwc2_set_stm32mp1_hsotg_params(struct dwc2_plat_otg_data *p)
 		p->usb_gusbcfg |= 1 << 30; /* FDMOD: Force device mode */
 }
 
+static void dwc2_set_s5l87xx_hsotg_params(struct dwc2_plat_otg_data *p)
+{
+	p->usb_gusbcfg =
+		0 << 15		/* PHY Low Power Clock sel*/
+		| 0x5 << 10	/* USB Turnaround time (5) */
+		| 1 << 9	/* [1:HNP enable]*/
+		| 1 << 8	/* [1:SRP enable]*/
+		| 0 << 6	/* 0: high speed utmi+, 1: full speed serial*/
+		| 1 << 3;	/* phy i/f  0:8bit, 1:16bit*/
+}
+
 static int dwc2_udc_otg_reset_init(struct udevice *dev,
 				   struct reset_ctl_bulk *resets)
 {
@@ -1205,6 +1216,8 @@ static const struct udevice_id dwc2_udc_otg_ids[] = {
 	{ .compatible = "brcm,bcm2835-usb" },
 	{ .compatible = "st,stm32mp15-hsotg",
 	  .data = (ulong)dwc2_set_stm32mp1_hsotg_params },
+	{ .compatible = "apple,s5l87xx-usb",
+	  .data = (ulong)dwc2_set_s5l87xx_hsotg_params },
 	{},
 };
 

-- 
Git-157)

