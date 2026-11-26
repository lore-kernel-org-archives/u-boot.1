Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37013606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DIcRFaXE;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=Eva0E6EE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD0F7409C7;
	Thu, 26 Nov 2026 12:24:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGxuh4LLuGuD; Thu, 26 Nov 2026 12:24:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B469A4095C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695888;
	b=HsJOo6JPv/pZ322wrjLD3jWtoiYN1yOyEdIzalO/fllb9ocdtackJHAx1EFsMvsqf67n
	 JfYIQpx07ds+5e/5DxKFMU1YlK6uPwFWOakwEkIjhNF9TSRQSFeb74BqN2pLo0z9y1ooP
	 oEAIZpZXL4cUsMQlyYtBdFuQOH5F9B2WlwZoTQZkA1h7LlJdNplUYsS3ikwZQ1swVq3D+
	 VVIbPDF6BLD5InoRzFt2Zl8GuIYHG+sdxvVdetnHvUauENUbSTIxBvG70RlZS54N3BEp2
	 VXbEPSBFD1i0PLeELJOtopeVCEfjIWBzXXh5jTz7fraLzV2szvVn2bqv5Y01u41JXOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SkUBMTEhkzf61Fv9qqcpsXsK/zPsphNqxPKfp6KWnxw=;
	b=Fd8z8B0YXQnJ8NqF4ss7JB+2z1cmyacRE1/Oowwz6eEpVMapmD35COruHnyvgvHPOJve
	 HMOqpRTEfvQJnSgxK7T+Ih7pIkdt/lCOJYKNLmdCmuVJQvVRcgXJlF90K4Py+DsEiLcHD
	 RGysuwwhGWgKmBAoMQ3T8o82ui4TVaUgRNxWDHlSgfUNaErpCyYHEZZh5xNpwAQVf+9PT
	 WeutkwSgppCHiSfm4N/mI56y5f8fmBK4baYc+RyzAyrLec1jySYrGOgv89WLYcoYtMHOi
	 zOSGsDMe5Vqc4e5wOhIiYo4HP241YxNUw4m9NupW9WAqF4mDl9172o9ecVaOv5MFHog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695888;
	bh=SkUBMTEhkzf61Fv9qqcpsXsK/zPsphNqxPKfp6KWnxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DIcRFaXE0tPj2HA4ymceLajjWnpEBWHOjpZ6kj74mq19dB92UvGdcfuTLJEzTLCdK
	 MhYXJYlz5cQ5DOAK0K7C0I69Ku6UT/m44QZ7ycbYCUoJ1hwp0JX9MEiXbjtkbrh3mW
	 mZ8M+eKgOoMEFNEt3ziJHVNDOpkyuWjgnKix6aRvjdOOrlnYgyQybPB/XWVGWnbNuA
	 b+Grzck/2NKrhlHPhOa6WJytaaa4hot9O5Hezd2BTewszOfX7C4Ju1fKkXAHlfb5Jw
	 N4lf/6Qm1r3/Azx9ICPY+D4iwkycdzOdsxvDAfeAKccIUijewARF0kGK/KjRExo5X9
	 lLUc1nhCCrXBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B469A4095C;
	Thu, 26 Nov 2026 12:24:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A3881AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 709F4608F2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAW8TYhRCgRP for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F3E7608CD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Eva0E6EE
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F3E7608CD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=SkUBMTEhkzf61Fv9qqcpsXsK/zPsphNqxPKfp6KWnxw=; b=Eva0E6EEJBsk0ZGZ5BHjmjR0rw
 7bzquwgoOk1lQ9b29Y2djKc2NkdQfIlWLpKxhAcV1fueB+EvUQbJYwZ26aSx9oi7CSZPnyXW8UoC9
 shiDaTYP6eB6iiwQxFTdrTVL4+1AgoEQ98ZE1JOIENA4/zejem7/yHqO53H6nwtAOyJv4K5rlnT3u
 h9sj5/Kcqs4j/iaN5/8yTtwi9SWLUaXOEjaLjt4lnpXNAaxfTxV7aJtRQYGvga52DDyeHLXEuS/kn
 e61F0A6X4dxCLT+8NJWizBKAwfFs8mAUTX4TDB5UZ64v4D2RtVpGc9QrZPbwAHW0SwUoIdd6uxKUY
 vFLBRQbw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWg-000ICL-0D; Thu, 26 Nov 2026 13:24:34 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWe-0003gJ-33; Thu, 26 Nov 2026 13:24:33 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 5/7] power: domain: imx8m: set CPU domain mapping on probe
Date: Thu, 26 Nov 2026 13:23:57 +0100
Message-ID: <b21b69edc98b027efadcd21e4b0f708e9e74093e.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
References: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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

The CPU domain mapping registers and bits were already defined, but they
were not written to the hardware. This is necessary on the i.MX7D.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/imx8m-power-domain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index b5c3b2e2282..fdca4d9d9ff 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -522,6 +522,9 @@ static int imx8m_power_domain_probe(struct udevice *dev)
 		return ret;
 	}
 
+	if (pdata->domain->bits.map)
+		setbits_le32(pdata->base + pdata->regs->map, pdata->domain->bits.map);
+
 	return 0;
 }
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

