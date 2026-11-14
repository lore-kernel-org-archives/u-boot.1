Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBC606A32D
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uujcXYvV;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=qukav0yh;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=V7quuk2W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA0A1606D6;
	Sat, 14 Nov 2026 16:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7OWDlpCVcaW; Sat, 14 Nov 2026 16:21:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA8F06075A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794673317;
	b=CXp4la3woQ9UxITpBMr9/2jBMa31rMwDXZFLM913U8A5MJNIDUrjyvVHzonZUpeQG8SV
	 p7auquZNdLZseXKgpjwUVhqsDCRmxTr9dp1Id4QP1JovIUY/Mu8Mfpsu9TezsJ1T4+LWL
	 T/gQv5IZaEpqqagSc/g0MXFiQM3e1BPSFKtejeToO76OQU+lnESsg0jGp2O6fCqCYPMc3
	 0fAxWHYS6o2vfw8MXSPU5lL3MV8Zk+adt2LJbLFU/uwferemDqKDAZ3HrZI0Ty+eTPPTD
	 /FDDLq0/YeePWaufQCYGfpOeigQLoKrcUKPaDm2EXvVQy/JCdiJ1RGnEJsxK4xa5jPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794673317;
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
	b=DN9jbaACjxmKCDVYlqDFm/eAmDGzAxOv4venhcwMBjVujfCAlBkaOoVhYEiVFkE+iG02
	 JQ2dtsk8xUfaFXbLpzi4FV0Jyvv6lDDR5JXJILNvw2rqiMDpz0fmKWKYvkrIg+uJ2fmIM
	 sdqhNZk3DQaqqDO1TIZ4zm6bJCaDHZzpHxePwysM6ZEcpW9S8SlDVyftdLdCXPYWORIww
	 LjTAhdZXHD7yAXy4TULS2GaSe9v0qjSMbrGat6h/uuef9gep61+Tq2UMrEjdhc6jdkQr3
	 myI6y7cyCKVHaN3/qraoTLgtVUmH5PJV43KP9S68Tg5nDUFNui1Cn1rpVjyn6+bV3vQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794673317;
	bh=9eYITK9l5/mSJNVvVJBPXL5JUHUXDBlefHOkofm7Lag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uujcXYvVcfjQI7IGg41JeqUMNDzzKi7wPYrsisghh+wNCqiks3lKBDP9Q+551j1K7
	 veOUHApjliL4TTBLgN3dNCaaanjCqODa2BwGeCJEhRcmaINaLsD2OYPZYtWlXj9oZO
	 oJwsELF6Ek1tOHBNdl+6Z3C0IeMs+HgC09swkbCmJvgKi4CGwwgloQEGvWUklSujmN
	 vbViFWg8km4MUg3+lBzlwazw3xKQz/6nWYF41QQXpAbKsZwYl2lcFzo2uQqLW6UZm8
	 vsuFS1Aa84If7+WtrnwtsgvNpFqvAgUo+n2+dN/Rx8k6MK2P6bo5W7KftylYkjWHbf
	 QYLYZl1XZWfrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA8F06075A;
	Sat, 14 Nov 2026 16:21:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 489C072D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F28A814A1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aoHRjIn90egv for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 16:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 427EA814A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.12;
 helo=b224-12.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a1dadd6cb6-5e9a2f8a-de49-47ed-860c-c1a9e343b9cb-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=qukav0yh; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=V7quuk2W
Received: from b224-12.smtp-out.eu-central-1.amazonses.com
 (b224-12.smtp-out.eu-central-1.amazonses.com [69.169.224.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 427EA814A0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1794673306;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=dxWXbM71ud6JYnFyRKoN2Ir/PZwlDqj6n6kiW7pdi9Q=;
 b=qukav0yh8d2L08BCdLuDdhdTF//wpGsMvj/NTSmbxLOtZvvVl5efpekhKdA2VPkT
 p0rucl4Ty44mGRYO38fG+FlvWVgtlp/z9Y+CXBkqeMxEW9g3phLNOfUDLBUBc8s3cVm
 ITENzjzrFpgMzMVGYgPyaQPgn3LRnd13Le9b/ICj1dzZJQifEeetVCfx/1oQznj5O1z
 m1zBL3j99Hd1NiL9v8rRm+6seyWxxfvNj68xVjn2GFBn93rGobCCsPp9nsTjS0Z7v08
 CUjwdq5VuXplseuB7B2VDBwWmINChfU8e6m7ThTUIa4NviJZO9IzZkiOYkHgoZd7GWJ
 jvCc/LsezA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1794673306;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=dxWXbM71ud6JYnFyRKoN2Ir/PZwlDqj6n6kiW7pdi9Q=;
 b=V7quuk2WTHJGrJ3HKORtRySZSTU04ytG9pPr26kkX2LgezrvpaloYDrlZVze+vTt
 pF2zZvyyiY6pbz5rbRMLDdJOl7X1sHFEvN/SZhaas1Z1bgl2Jq/QV7sJ9p9rraBOmpi
 ZfTgM1Ys77OszTE9ChEPCpkGo653mVBlGTzCCEMw=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Sat, 14 Nov 2026 16:21:46 +0000
Subject: [PATCH v3 05/13] usb: Add DWC2 HS OTG params for S5L87xx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a1dadd6cb6-5e9a2f8a-de49-47ed-860c-c1a9e343b9cb-000000@eu-central-1.amazonses.com>
References: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
In-Reply-To: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Vencislav Atanasov <user890104@freemyipod.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Honbo He <hehongbo918@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Stefan Roese <stefan.roese@mailbox.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794673300; l=1388;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=dxWXbM71ud6JYnFyRKoN2Ir/PZwlDqj6n6kiW7pdi9Q=;
 b=8gvC04aWgi/GTRe5Yiplat307yLMTF7uThp3+kMyGSr9HmuTDN+Bbdo0Zbe9g9EdVRb67OBYB
 97UWS8HRoKQDcQUT/uju7w61ph9dmvHvxkc3hD2QOEM/jwic28Ajqa6
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.14-69.169.224.12
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

