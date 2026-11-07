Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75453606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BIUI7V6A;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N0TGXpLs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36FDC8165B;
	Sat,  7 Nov 2026 12:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LxG2fuKAwu5B; Sat,  7 Nov 2026 12:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 612D081695
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055848;
	b=dTa0KI+sdZGCMtyICer2q1LT9DjKYOIukR5uUpGf4AH/Wn4tQccfkO+f4S52wluiyfmh
	 l+zp2NaLPI+Juew+nxLfnm/++VGXNtCyoUSIdICS9NGy/Md/e4OOSC9GyNuqP27T6o1zX
	 Nmrc9e4zSgeKjEhA6tcfW768bIjoZwy582i5OCJ/KRLc2yAou21eF3Wch7UrHHx5xRFs8
	 Tr4pAo4oPT9+uksLUtaYUIwYWogrftS/4fxUh9pRTMll31MRVzjEhIOrSfl/Ae92jgVNh
	 cFVEo2yknyCpgVUtyAf3r4bog3W31SVGKUPskWwlQr82Pdczsv8staBVreAYyldDCgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	b=JTQBB/6mSaB+UaSGqKEyTq3tAtwdtXPq7yxSdnHNfChNGeQP1h+IHarr1mUeFc3fflGY
	 SkwKzg9pBx+dZJoF25+Zfc1eveVzQB7QbUYBmKwrLH1gm/VwC6Pupt46ha5uvGfc2fJuP
	 CUZj1lNVMb3pKYyiLbXPr0zQuM7+Y8PAZWRsDcajciG8QQCXbMwMppm8TqPrpAYw8FawF
	 jX1o2Q8o7YqSl4+C46tbAVEOD6p7ZRHytmYVHWMF2qHXsOveFiRM27WDpkZaa/9Z6e7jx
	 LZzsErmw6GnXkoTrB7Nh2H2gF/F4g1Xu0QItUiTvNqruxnHbVnPXb9LglH/UyGWdMiw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N0TGXpLs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055848;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BIUI7V6A9fL4GrQL0lZhE+llk6RY19zWaF6LKRoaRL+LhQl5MUJI5FF+QE3kqg5ae
	 1HMN8rKPOhVDHDD8wPjWF+3p1cOu/beOsfbzov5SNmsO4WS/jz8tgPw/85HyVkuCCi
	 j65uxfSBk2Zv/qKv05o9Mmj9D+1sn4ut5FJRiO7FQgmCx3bVIEg156XPgmmmRR8dh7
	 xV2zilOLxFTXluybOrmbBmKijv0zf5scop4ilsrtL3MY2RI+HY4HKMR5tM/yDegmhQ
	 HTbilvPmht/xGmL/p6EqpSdFJ4CMlquGOIncU/C6cZ84DkhLDz6zgXkDaznYtluKVQ
	 CpXepanyNm+Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 612D081695;
	Sat,  7 Nov 2026 12:50:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04A422AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB07D811BF
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqoPeXLpG2Vq for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CBF381223
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=N0TGXpLs
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CBF381223
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:14 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b7073ddb15so15085a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036253; x=1794641053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=N0TGXpLsuFapEMqQrgluTrNlNRPC6STyb23oYAFB8gO9ccXKYOaXsz1MpO383VXXgb
 rIWuw0Q6RJPbn0mwbWpnexhroSjfZuhnbq9RQeZZIQZj/quFELl513V7LiANcnC+5IY4
 jG+iukRfze7m7iDOyHeEP5/Xtht81dkR2YFs/AO2PYn7I1FPfIlv3/fKB3Pi2OH2QqgV
 ibcwTy8SGvvncMr0ZPUP7IHGSfmzV20pwb0FPbLbCEplZeLBMoMdWzJMDnYQVU2wixbg
 QjAHgfCGYxF08HxEVrCZrDUMAl9yAJm6unJ8fWnuoMWwf4TtC/1lTF6fh0nCoiK72RSv
 75sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036253; x=1794641053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=EvbyrxUO5aMFVHs9w6pDcVetjGzD3Q2Elx2Y6AedOl1F8v3AC6qmgwMhX0aos/wi5F
 2GaLEAhxZ20v4YxIGx1vYyHQOduTr9EUm+B87ihV4t1KzlH6X5bA7jv1oHMvS0qjBvmz
 iLgFi3ukK9j+COYVYx4spJClqmWoO1c7HELcrTX98UD0c00K/8Ul3/22nxNi5FwfwsMo
 V6BbzKJQxBEnPIjrwedIQImOZ07np6UrkfDNWbV/CcwmGZ3ncPZlyUvbnLvrDxXopzXX
 M/+RM1JV+uKhxV9oJPt1g4LCRIlfm4i4du9Q/CnWtNKphsMDXkjs4vbR05DFXacLFeJO
 yVZQ==
X-Gm-Message-State: APuU4Z8SmEDced6a2vIpmqVMk3MMgvlWceJmtKl42jzaTFKKTrTVK0Ud
 jH6iO3hMbfLGk2lymzSqj6IjJiAuB5aZdBhU5aEkXrTgLv4RAtLJQnbbOWP1ccWwBZE+91yEMhL
 bWUn2
X-Gm-Gg: AYBFou3XMcxAYAQ5DnuRiqu9nxFvWkbhgaziD+FUfYGvijfJhG5kkAUi6u6LGMaeYXL
 xsf2VM8Gme7DcJhyCydqy7m1TJzrAT2i5F0kONNTVvvMbX5xAtq4tP5XspgDQphZTPJlBi9y2Vz
 qjDKxmOk3lbWk4x6sxTgGF8EHt9dqXPxRfV4zvD9U4fDW3fCA57YK/12a4BjNO23sK2MTVD0x35
 0zGQHxacRJdwjo7hJNeLCc8Ah9Ou3rz2tGYUilVbrAGDtdOXYevERwY69qpdQklnUBtu0h1HSwV
 YfU6oE+jYqzb60no9FELZMgnrHnAX1RBCHA0ah0b4IUXDANqS7ZjO3fiBeXac6H+cO0VpdUrfUc
 p55hc62us9ISetuWGwPnLI2+kjV/OVeA1AYdkcHtAdXB6aB3sVeNm9smrPvBj5zLLgS7vjmRj8C
 fMcoUdA/rScyR3gSGLKbVzIjkOEUl506kFnCQAIj/np5+1OxeP75Qb54lKcRaaXcLdoETQeBsD7
 gBMnJEf9aabx+yW224AoLgILCMK3IbZWk6/Jai2pmmZ7ZRnD2GZ3pmN5VeGloPrImBMJBiG9fcy
 braX955K1yS4+CHfrTDFRSvAklOPBjOl3EyQHd8ZBkWRHGGGy3sb9Ooy2K7Aja3uIhtB40Y0mMB
 SBUMl3WrgHQ==
X-Received: by 2002:a17:906:6557:b0:c49:ce7c:8a60 with SMTP id
 a640c23a62f3a-c4d34b8ff77mr389195366b.2.1794036252852; 
 Fri, 06 Nov 2026 23:24:12 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:12 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v11 29/30] usb: cdns3: fix up after the resync
Date: Sat,  7 Nov 2026 08:22:23 +0100
Message-ID: <20261107072224.3492260-30-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the cdns3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/cdns3/ep0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index acff79ae1ca1..40282cbc3234 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -341,10 +341,10 @@ static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
 			return -EINVAL;
 
 		switch (tmode >> 8) {
-		case TEST_J:
-		case TEST_K:
-		case TEST_SE0_NAK:
-		case TEST_PACKET:
+		case USB_TEST_J:
+		case USB_TEST_K:
+		case USB_TEST_SE0_NAK:
+		case USB_TEST_PACKET:
 			cdns3_ep0_complete_setup(priv_dev, 0, 1);
 			/**
 			 *  Little delay to give the controller some time
-- 
2.53.0

