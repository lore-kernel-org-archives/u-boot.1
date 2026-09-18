Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A70C982D6
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 02:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E67B60BC1;
	Fri, 18 Sep 2026 02:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aoviZFnmzUMu; Fri, 18 Sep 2026 02:54:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6202B60BB7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789700047;
	b=cHSkMuFDgkzImY53+MMHZoyc0CQULrXPagA9Zl1WBGdZ+W4KRcrAxA1VRhQ0fbVHFZIt
	 TtaDRaWVAOg40uw4eNl45mBGuB303hxWz9WQ+OI2ViRj9spVzkyIK7iA6JV0G0fdxbivs
	 DRen6Btzdp8J1wYOQrwja6B2TPf/BWYyhzFwbpP6XCM0aL6NTWR6E2OaseUGeUJ4gOgAv
	 xXC2WYHNj3OxJ6eJk6QqBYfc5QyiQhaVRuOpgyGigHO5Vj9adK5DCuVKYHPfgWV7oRWzY
	 V/e8CGFQzDC+WBqpG5N2RbZ3UtCuuFTmXp3RVtD0uDQSYsIptri6erzSyueafxmGKPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789700047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QrW5wTZ0iYpulb9CH47A6n7wv1lZ3ep8RK8lCMasn60=;
	b=kcBrNiord1UmOQBOa4KFC14z7GhTe+g6COeN8upp9V6K4hul/m/CimV/MF0/XpLuFMuz
	 7Hg69e4Orr1SuIGDeWC4Kv7HI9N2X5iqRNuvTGWR/8aXH3lIT3hDG6KlG1jIbaWbaNrnp
	 SH0MBNR34iu70DjVAQKDYhB5O71WnJlNuTG3x81KgwoZhOgacR/WVlFHhuu4JhxdWEeDw
	 rUsT9SF5XJDlsYKIMp7x/pV5cD0y58ebxkn32FvpZL3trDThjIH60wU80flhBrcb8hOXn
	 15IYkxXCS7XYUD1SDpY1KJM2BkXJucSuuvuxswn+g4EqsshdpQnYzNf65fqWnw8OGTw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789700047;
	bh=QrW5wTZ0iYpulb9CH47A6n7wv1lZ3ep8RK8lCMasn60=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kicNFq5EqP3zDfJ0zVds9gP8tRrYcLaT0TqOTSvspBgxgYFhGx3IauHCiJkOWcoOd
	 lIz3PC5njGwRqXkV4j2+Hj27wT/LDhlc9kyxL088kxemu6+O34Q1EC9CR8kRHY390D
	 L08MC1sscPuhgbx5QZwZ5nU2EsnPKD5U6MAe654DcCT48BLVHj+OHt94cPYNsuKXno
	 +KHNKYRRDxAAXUcLXVnnbB6wOkm0mWjA/6dE8dlf+76f3HRxJX/YgkBYgqGiErBLVF
	 TMrBLQ1hYjMcLjn82/BP0fXmI0uSUiyitG7Nc94JWgeh/kbUcyOoc/X3NQ4FizyOQY
	 7AfXwuZWVJubg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6202B60BB7;
	Fri, 18 Sep 2026 02:54:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A026B3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91E2F40492
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IIr5dsFeb9rT for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 02:54:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0D5104008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789700045;
 b=rHAh35ozQi3Y6h3XuAHuvdXynJ2JYBxxwQZHWWabt0lN1KvX5ZOgQAzkSg0cLDSQlCwz
 8/pPLNYhiNqin81jzjsXx8yjGPCNA+RMHVjF7hhkdA7lcv9J98kDJE1cPRsrjh6+D6wkY
 KVC+ykjA1mv3NZc9UDbiXkJVFMnv6C0mQTkDQt/3PWNVEMdgJxw/5d19ndT45BFqhXRtA
 2tdHBqRnjG6bb+sF9kEM01xihPuros+kL5ELMyZq8JAoAzswE8ZNlWVJGBeKCqq9kurVY
 C8EAL/WPGOooCxZKAU6yl8JEDvfGOOI/NJuaMbTCH74pCND0kaULPm0ePhFfLudI/mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789700045;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=QrW5wTZ0iYpulb9CH47A6n7wv1lZ3ep8RK8lCMasn60=;
 b=QEnuR1eNPfvW8aYp5gsD0UaZBkGht3bAJVP+U08Kt8yHrTtwa27MT9EWT8iO7hnt/jbj
 hnR+p6sA415AmFOpow5cuk4p7qqrOloFTVKzzglIk5CoZwHNAHGZ93dbZE/3Xwo24ecYX
 +jKh5P2cxBI4kfXFgTazKaoeELd2XcMjS5t5u9kHyqkQf138m2AC00vGUdnBwC2sSG9hS
 Z2QG+CNWPeVd9CnZlSaiHX6QyYQyZTnh727VJSKt01igmvupHerAIWT1L4lNqlmRRXYuS
 FT3zqxK7tmLbEqmXvwkIufGQuaOjxXXoZH3opOcn5cdjebgN9PPjMFNNDEZyxiJEF/g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kBKBpd5N; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kBKBpd5N
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D5104008E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:54:04 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso326145a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789700043; x=1790304843;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QrW5wTZ0iYpulb9CH47A6n7wv1lZ3ep8RK8lCMasn60=;
 b=kBKBpd5NcaHpo0VdRAoy6tM/NvQQ53SIXHJgHjioyoH/3CbyS/p7Wj4zlkYEy4Yq9j
 5+317ufhG+5zcrbqsAKfijnteaig48hiy9/170NuzZwT7mfA+EFXUnHSvuT8+7LpklpN
 zfZMKkhB5ZhRK/Hs0+TIWaQcBR7BXZUR0knY+/HcFBk+FD3IBJo/GkXwsNqootgXInEO
 lBcmCAw8EoOtaF5jpHv1JOKLXnDjQlUAK73eyU5JpY2nGw8H0peVQkJvRL6+q5vkqSEG
 /DiUz8HcrFM7ml8k4qzlBNuKO96bHUx7bO7ZojNZbpabaGXPNP0Bi6Iq/oKv0aWUigx7
 yTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789700043; x=1790304843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QrW5wTZ0iYpulb9CH47A6n7wv1lZ3ep8RK8lCMasn60=;
 b=vKazINUmaKOdXnREVL1vIzYUyfaDRix4Yx6ChqcXUCP1uPLBQnEg2eXAwgkA/RpYOS
 2ZBCHGNhVQkFUYKq/GxN1HHKLd2H4HErvTr2hLgrMULe4MNf5qcLFAefxMZ5p4wemm0B
 c+9o+W30Kl6fLATZNmYiXfOsWQhaxPmLS99CjiUUfPqoZj3EwzZunOt0yf3VhqPJ6LGR
 cno5ZJu0lBzr2ZdxDGSyWQ8gO15Rx04D0EfwEKxROud8Gj/ndWdxWx23jVQ7Yg5SATWS
 EA6S6Honuo7chChBEquY0e/Ui/tulAFZzsXUeknK4YFLYzeVnw0hABfWt2bxZPUJYUmG
 jKgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoIJR+P4XWcwS/3x9YEmr5pQFQV1GkjMjKMRtmZxgg6aL8jXp79woCV6KXX8MRLMuCRZSvmL0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lk7jk5gvBgRBRYcQFNuvlJHI4HQs6Fr3/PF4dFO4odtbkPNNkv
 ualPV00FIj63xKYo3A3bJhrA34VR/vC8NEwN9H7xJG+ZNQhPWSfZy2cn0zwnkg==
X-Gm-Gg: AYBFou1Rc/uXzTZxByFDBwSO+6ExtzJbtmCwblIUJv7bPJo2pIicKxBltsbYxAQAvtm
 szZITjxLLZ7lYnROd35XSY9R9x1z/c5mN2Utbu3UqApjvEI3j3lms7zZ9vbV/0aem6KLyJTwmTY
 z5d7OyQ67F5L2+VDLnjJx6paAhG3CmAWEYqWWUSl/KzlAqzGSrrz6GIqfiSRO/Q/03+D2wWFu9I
 EVbCGHj/oUXQ0I3ngu+QjLUbqinqScymnKA0NB1SL7q3+JancFd/mZWad/pm6htkeaJx6YAR6Gj
 c8ZBtY4sxKN9Tfbr1hyj4nElg1KzukT9bVFfhRj1SNmK2pP7x7cHaOPNc0fwNkmjni2jsTnlVPI
 tVSzbyJYQ/UIPMKqBN0P3CWyP1+Tj8/FAUSriw5BDwcxNZuPIukrAAKpOBAYnuRk+F/60xCJ8uq
 61/a5OHT0XyxG+ET9Erf9roeHg+3joPTzHPxElLMSTPh/ylQk4pUPE75Rv1FHpnyi6SQz0ihd7x
 yOaldg4
X-Received: by 2002:a17:90b:53c4:b0:39e:d2a:e2dc with SMTP id
 98e67ed59e1d1-39e54d1ea4dmr2488351a91.12.1789700043586; 
 Thu, 17 Sep 2026 19:54:03 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3618ab38sm7878401a91.10.2026.09.17.19.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 19:54:03 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, hs@nabladev.com,
 trini@konsulko.com, dhphadke@microsoft.com
Cc: u-boot@lists.denx.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH] i2c: npcm: Add segment feature for bus select
Date: Fri, 18 Sep 2026 10:53:47 +0800
Message-Id: <20260918025347.1839402-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add segment setting for bus select

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/i2c/npcm_i2c.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index d57237a6df1..cc1847893f6 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -14,6 +14,7 @@
 #define NPCM_I2C_TIMEOUT_MS		10
 #define NPCM7XX_I2CSEGCTL_INIT_VAL	0x0333F000
 #define NPCM8XX_I2CSEGCTL_INIT_VAL	0x9333F000
+#define NPCM_I2CSEGCTL_SEG_MASK		0x3
 
 /* SCLFRQ min/max field values  */
 #define SCLFRQ_MIN		10
@@ -112,6 +113,7 @@ struct npcm_i2c_bus {
 	u32 freq;
 	bool started;
 };
+static const u8 npcm_i2csegctl_shift[] = {0,2,4,6,8,10,26,29};
 
 static void npcm_dump_regs(struct npcm_i2c_bus *bus)
 {
@@ -564,6 +566,7 @@ static int npcm_i2c_probe(struct udevice *dev)
 	struct npcm_gcr *gcr = (struct npcm_gcr *)NPCM_GCR_BA;
 	struct npcm_i2c_regs *reg;
 	u32 i2csegctl_val = dev_get_driver_data(dev);
+	u32 segment;
 	struct clk clk;
 	int ret;
 
@@ -590,6 +593,16 @@ static int npcm_i2c_probe(struct udevice *dev)
 	}
 
 	/* set initial i2csegctl value */
+	if(IS_ENABLED(CONFIG_ARCH_NPCM8XX)) {
+		i2csegctl_val = readl(&gcr->i2csegctl);
+		i2csegctl_val |= NPCM8XX_I2CSEGCTL_INIT_VAL;
+		if(bus->num < 8) {
+			segment = dev_read_u32_default(dev,"nuvoton,i2c-segment",0);
+			segment &= NPCM_I2CSEGCTL_SEG_MASK;
+			i2csegctl_val |= (segment << npcm_i2csegctl_shift[bus->num] );
+		}
+	}
+
 	writel(i2csegctl_val, &gcr->i2csegctl);
 
 	/* enable SMB module */
-- 
2.34.1

