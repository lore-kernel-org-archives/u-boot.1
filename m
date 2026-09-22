Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D270C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 15:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DA394074F;
	Tue, 22 Sep 2026 15:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RX-E1HNoz0JB; Tue, 22 Sep 2026 15:15:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 83D4A4078C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090103;
	b=cBiJUJmc5OHbNeEhFUuxGAI1zbLB/Hn0IE0xAXasJ0K92hkF7JurMKOEl5cGVEldmWEw
	 edFcOD191TI+xO/IhmQWa/Xchuzjju1cWXn2FtzWj5okdX/5EhwCIK2P4X5Zjm3hX7tBb
	 fePpJthfOcE41vSl6iDaWV+3NbPQhiPAly/SKqDRo/MhtWRPD4eG1OlDGTulTQsugfj9V
	 Aa4uOoGS6pd4QX0jo2vLQ604Gh9EwdLCdKWe6ud03ZAxBDgkZCD/nuzkO8D6ZbrrHyPwo
	 O54jZcRZHMGsvd//KxRtiP5JIROI/ztg+j7qHbjVMsNDOh+RgmxKNVAGJxKg5gEO7VA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
	b=QYtR14ogoKX2ujA6a9QCOGSvAczTRzzU4L6U8KZj6U3RKDVC9UDywEo9c9C7wHP7/EoE
	 rlbTV8kwtJnv1E2lTlq1dzDXYtmxdtf9KKWs/G1TBNLhYsK3SJl8U6lTiAQBp3BmirJWL
	 ymdO3aGrpAAJSOyvGHKu8O7MtqhmozzRN7xzJyxTivtMlGZE5572580HMsSoaWhV7qDIV
	 /x/c21iuWIL+L0z6yptJMEjUxb04zACZYMoqDT1EJx7X/SOzI8Imreiu8DLGM21eei+5M
	 vGssPJ1vF9TqQIESnF9HETzRh8/nXPYPc0J7Fp0hzFXM0rmImK7guPgfu+EMogRF9ew==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=RKPV4JBb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790090103;
	bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jQobkNaJ0BXLZGC/+WIH4TSTFV3j6b30XDHNttMUT/oTJWbhF8dHfJO6bkSn8/tqj
	 HUOyt9mJ+GW6xBMe+kOO51GT230XpaXbbOXupq9uMSArNtTjyvF4XZo5abpYCKn/aj
	 aG4TIH3woKj7SzCES0xjCNSfdkcFTDVhmkYBxj3L5JD5a8JOvCWneDb1vo4tXmHTFB
	 4rjz9BaPDhU7o2IIMq2r9Ec/HvDd5SuIekttWL3ea9mjxdODVq6+Ra94lZs1PLGEap
	 X+KFJFdwNVne1SCe9EB3I1bwlVGamSw8HC5Vdqfn1SyvMu9P0UnvmX1cjv2uDzNutG
	 BFAlNdNK8Be/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83D4A4078C;
	Tue, 22 Sep 2026 15:15:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C62B4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC04F40746
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:03:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkpxrAF_6NCp for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 15:03:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0786F40741
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.92
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089437;
 b=bsJPkxS5+/UJqPSxxfK4V2UVLrofmg3rUJV5cg19cWBOA8qi1bt6TZfsowSMuySbUW4S
 7fYRB+Fwzwo72cnPfVqqE8MP08Msr4bqifYumlpKCHepO8yHpYPjnUjitHUbLxkQ4ra8G
 eNhpT7nzkQiAp2fWKWLCNWF1EzpqetfC0JhJh3CqkDbM1+wNo8xr+egBjMukqPu21lfTq
 /e1CsGgxH/wtYSqtYSIdWqNO+0OsyUcDmlKmanFWg8bK5iZV00Pu9MWv9hczuhrVLjymR
 aRhSE0N2dRblS4gFGfZgsiXdNqCEgqu6+CNHkYjRFnoZ+gclwoZTGy/3LMXH35hdpjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089437;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
 b=ktdc4ZdsC73lvR92xRPqsx7Ax9804PXcWJC/dWbNfWxEJciP0aJv76/coViu9dWOsTnq
 ZRCG5xnnCKaDopug6S4gP4MmvXvlrDzSyiQIzq3olDh62mRsUVa+6+VVBm15Jwn7AiRso
 gzqHUNV8Q5UH/R8jPuXRoa4p0RZNw0oUYGFYfsVIXQQFUKB9aocKFLMC0Fp9OPLMKvTST
 nyQaeuVRINorZiGhXdogwnIwkdCNS5X1njZxJxj9TvD1Pi3XqaBebcE7WwPojL/NwqT7f
 ACMUkYJguHYjzpR3hs5TKYf3pfO5o/iI5h7ioHlr19mU/7B5WxBynOgfiZcSZamp64g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=RKPV4JBb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.92;
 helo=sender5-pp-o92.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=RKPV4JBb
Received: from sender5-pp-o92.zoho.com (sender5-pp-o92.zoho.com
 [165.173.182.92])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0786F40741
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790089187; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j0LXOzOFZh+cQWh/KtDwr7PFwCp7BwFKcmBrqhM3ilURaRO6x7jUKx340NxwShbY03PvKlj1jF3fxWC88oG6q+uXRj+iP7asZ/qoAsnnOJ79qNOHrmgeMu9vkQZFELIOyqe+nNF7TrzbCd3xEi8FdLWUlAkl8vyn30eLocVl6Zw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790089187;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=; 
 b=L3anpuDhsC9wL+AsBeowo2kPydMV9pvw7M3ROg7hDUHvAz5HDUwPhgNah34vQr4Q5pkN5PayjzeuuoN3s7PZKtySCG/ijAScvzaoza2KdpA5TNAyaKzOxh6DEfbU/AWe2Z9/OkBvTi7Hbh7SW3ObthpsMoDjGxdmLoZc3Gktxp4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790089187; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
 b=RKPV4JBbB5aLW2ZlYRmb0AX2yAIzIYZ0jTHpfowzLwux/M1Z+hjGdeQWxwTg7pNi
 ZDh9S3vGt+970ETfJIn5IZ+wKIRfSZ2QAXA8JO2EMLHEsgDIJ8pVQlLrLhjrphaEgyO
 7Q7UID9jjopXg/vOd8jSyHZPK6M93BI8rDPuRnCQ=
Received: by smtp.zohomail.com with SMTPS id 1790089185780991.0394313151221;
 Tue, 22 Sep 2026 07:59:45 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 22:59:09 +0800
Subject: [PATCH v4 02/11] mmc: cv1800b: Add SG2002 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-2-d45b74dfad36@zohomail.com>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112271f10d8ed5164e3fb520827fe00002fab972db7374a3927d656f728e195d38d3bb5c958b8aaf08f:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 15:15:02 +0000
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

The upstream SG2002 devicetree uses "sophgo,sg2002-dwcmshc"
for the SDHCI controller.

Add the compatible string to the existing CV1800B SDHCI driver.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/mmc/cv1800b_sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index b756649f90f..f8d94232170 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -110,6 +110,7 @@ static int cv1800b_sdhci_probe(struct udevice *dev)
 
 static const struct udevice_id cv1800b_sdhci_match[] = {
 	{ .compatible = "sophgo,cv1800b-dwcmshc" },
+	{ .compatible = "sophgo,sg2002-dwcmshc" },
 	{ }
 };
 

-- 
2.55.0

