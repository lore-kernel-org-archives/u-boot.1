Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0DA606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lob1e1Se;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X43GR+Yr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75D2E812FB;
	Fri, 27 Nov 2026 18:29:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Vka4KbHttKh; Fri, 27 Nov 2026 18:29:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3062812D1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804159;
	b=tbmuigPgnVmNaUbOXk98eFyu11EneqsTIHydaUrgJxoH+Rtd86nLMTbsjQrZn0f6VMW6
	 +CTJ41ye9zO6UnPrgYfqEP1IGYu3IP/AviuscdvYzbcWsp4QqAIqyQxwz01Lw/LSdiDB6
	 nlXzScl5WOiUesDqdonNJfrVTNlMIAiWtKxhK6th+6LYwIG1NAXXlnGuDneypyK0+H1y9
	 lf3awArJJxw4frjcRNFgJjR/UECBefdiqhtZoAXmuxi/w4bEnSF2j7aqeTXM7PvjQhpC1
	 ZT04GsK64ElwMT6CjCOGjwyLxlxhWu1rBPniggVaIwLitXy3CxYaAEOY5pD4zaeAzcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8hxkX7bDsUiylRzhbHj2OsE3Frh66qDOaPRSUF1nwwE=;
	b=OcZAnk8yF4y9bHyCrJta/o9cvUjTv2x9gOHBjBygmnUZdjxmoKJ7WgnKwKVIacLxWH0y
	 8X2a9HVOaBV6mJooZKIEp4Bm2yOzN8tZdfm/9TLIrSEcyG8pOAfjxutgaSE+29E+vot1t
	 dktUsEXkErRg3z9/js956VahPWvGWwdoPSU0nroeiTv1+6LG558IgWvveLkTDQrNFN9jw
	 1vXlUlIxQ22j0nLSAQStqHrKKy9ZjKdnY39YrFSZ3GDObVysMkYpwiz0AIjTdJcojK9R6
	 Xi8uC4IlSbAuBiQsLpx9Trv6L7SWbLnIPZFsf27XuhEfVSJoSwrYmGgcn8nWM9qfFjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X43GR+Yr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804159;
	bh=8hxkX7bDsUiylRzhbHj2OsE3Frh66qDOaPRSUF1nwwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lob1e1SexhY4Li35XzuqUtiKl6ZppsD3Tm24r0or4s7XReA/dgkQDrGpJhVsiPJXG
	 J4uYnEuQNA6p3jlsqUQmCTXFLoSGqPfKWGoISe95aulAtJMwmOmmxdulZnZvPokJ+N
	 23PTYa396tsPAIjXXGF8f4JMVI0xDhy2c2n91eI9zIlgnSpemlhnXuPNRlc+1UABEu
	 OryA6jRL3VSfj8uCuKPYGx83Jn6RRvPU8mieRyQxb3V5PmuE05lW+XaeVtbFumW/KA
	 yUTevnqnlQjpbWhQ9Krj1IEMNUmETG48oyTN2MfwnVW7PjFZNnm3KMsgfX2d/0ikmo
	 yTPtUp0pLVVSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3062812D1;
	Fri, 27 Nov 2026 18:29:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 656C12BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BC0081299
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3BQ4xeRrplJB for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D61E7812CD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=X43GR+Yr
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D61E7812CD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:12 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so5386780f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804150; x=1796408950;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hxkX7bDsUiylRzhbHj2OsE3Frh66qDOaPRSUF1nwwE=;
 b=X43GR+YrPlwTPmtfSRziHR22/me4jJZQKu2yG1lYEncWzgw51kMvijGuzEZAx1GSxu
 r3sP4YTDYMJ57O7PTdqgNhhCvlT1WNAKda1y7SEnNSdh4yVBN2tukBJy9gLAeEz6DYth
 03N5KPqlcPEjk8ap0mEtCcIoXClV2kas9D+5AxoBzzFLj7ufP4QIgCqohVXA9NHo17/z
 Ur4wxxtIyXLT2pt2yT8xV3Y8LRxyUbHVQqG5EiSyJodMPEWcZIvhPMsw+FD/1JTlXgR3
 0Qju+qdWeB3Ii0nPQXehEJulRGkkKMiWtr8wLJmec+3mv6Q+A4pUgO/2Dofo9+e+Cber
 2Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804150; x=1796408950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8hxkX7bDsUiylRzhbHj2OsE3Frh66qDOaPRSUF1nwwE=;
 b=jqKYmq5r0g5mYvLm+me6Nv3dPIsbGovIP5R6096mfU3t+MaMmK4O3Qhcw0bjKk7J+8
 Ck5nDaU0nCvICjSo6GkFQPsx1SAKbPGP/bN3iubXSqQpdK1xrCQzYlBPtyddIO/945la
 nioGDKKpyNTb8+Rm0P3L266ASSAOHxuADEad6a67pHL4lA+gTnTSGibdMKA0z8JcLTKq
 ImCQrkbowQKvVpassPEQx5LoKUddGTh84E6zhS75/TQ0DBCd20F/f101pBqfa3dVN1jC
 HczKVV5GnLb/uL0uzySfo9qfJ38pD7hfRMZF+76TQj5uz6fFGRUw8LZX3LC6i5+ytL1k
 PyMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEf8M+4o0cuTe91DKa1BgDySXtTLtzsW1+AF7xtfpXyyjZxXJhdj8CMaHuysCW+RDvL3e+J3q4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/fbEy6Bhds+Cp4yUDFl0uI1DI2abpsaaSBEbTlooO17ztbYTny
 kp91oHwztUYXfnndWqceIrMybCNlidqXa5+UePHNdeL15cQP9nhI1SWb
X-Gm-Gg: AZFdTZeW+7ijNTIvnujbV/DRw4Aeq49mel+TJ+IG2unhugPE+dDk7MWCyZL8boaBMOn
 iWc7215SnPHHLlddGA5HrHHm7pD5RdU37zz3CnJRQIrCLrECe6e5+jeiMI5qE4ps2XoW63zFFF+
 v2xRZTI5OI1ZHeFh8XTsv6V7FwSOz/1gqd9JuxmuZoEicBrDpomMDemCHTiH2X0SCvzRTCxjlEA
 ZHncDd6fxYbepXLRoVxcrZ7xXq8vTMMktyvQbCT/qLPEKZwG77LA3XLB9gF0zIMogK9drR60HsM
 92zB8BWm8m8kS+FjGM3WqVloWYTqNxwuej4G4nD+atmj3XwE+8U44xx0MF04r2P7IMcKIQkhOZ5
 uZA0ZKqAaIMXM4P1o422UtP1CaSQBglBriQb5AuEvJglv98N1xMHpd+zj3JKkjZn0O420VXxRMp
 1z1BAHMKlrm+OnVt6hzKUTmxYJ9aiE2+GFxx4TLL7/9kY0PPeN5ILpCIkmaFpibbi+EwI8Y9SCR
 OQ9TM0TanvQbpe6aaZt41b1V4c+k40p8RTnCA6bHKov506tNSzW8LSrNicBuqiuDNunISNvYGHE
 +RHtgMwXmoA6EZXtyeRDwot6aFSfSmtcZaA=
X-Received: by 2002:a05:6000:250e:b0:48e:d7c:4bc3 with SMTP id
 ffacd0b85a97d-4aa5805e1e3mr60670461f8f.21.1795804150441; 
 Fri, 27 Nov 2026 10:29:10 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:10 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 3/8] serial: lpuart: take the ipg clock on the VF610
Date: Fri, 27 Nov 2026 19:29:00 +0100
Message-ID: <20261127182905.2836449-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127182905.2836449-1-mehmet.fide@gmail.com>
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

With CONFIG_CLK the driver reads the rate of the baud clock from the
clock named "per" on every SoC but the i.MX7ULP. The device tree of the
VF610 names the one clock of its LPUARTs "ipg", so the lookup fails and
the baud rate is never set.

Read the rate from "ipg" on the VF610 as well.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/serial/serial_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 00de1926023..e9e917c2335 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -111,7 +111,7 @@ static int get_lpuart_clk_rate(struct udevice *dev, u32 *clk_rate)
 	int ret;
 	char *name;
 
-	if (plat->devtype == DEV_MX7ULP)
+	if (plat->devtype == DEV_MX7ULP || plat->devtype == DEV_VF610)
 		name = "ipg";
 	else
 		name = "per";
-- 
2.56.0

