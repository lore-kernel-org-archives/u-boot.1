Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BBBC98324
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 13:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45ABD4056E;
	Sun, 27 Sep 2026 13:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ghrYN03FIMip; Sun, 27 Sep 2026 13:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 889E340509
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790515041;
	b=RmGuk7txi4cr1uwTe24dPfnP2U7OoBC2PcN/hBRF6FTTii1P1lO9Cx9sALTMNdWiAzUP
	 i6bjG5PU+wJsAmbI7/rGT6F0BVtflpoO2dSWZvvqzqyI/Geds3uyjZqrt9b9vmKyxq/eE
	 3IcyiN9gJIepV/UgCUpsgBV45vsH6dtejvaAIa8QoJ7wTzCq4UWfi1AWIxqu9A/QvtjLY
	 CyWzmc8DTqwVO2/M5ILjHhCGII71Jq05Y0g7trpCW1DoXqHj33y74niIcytpEG174qb/u
	 DWlOywxgEx9jPiX3ADQ7sPFyvktq4wKcKYPRjq1KyaUwqHlrjNMhfjSFNgq2JfhRF+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790515041;
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
	b=pLd9w6VPKhiTh9ZPIVYGPxwx/XTghKPPlcMPNdecphaiUUqiGq0n6zlfUJimvzUTFEgG
	 uLPmO3oUWyzA/70+gtuxqw6DId8wp8n6IOYDgDCxPoWxQebgta+bH0C+DEiPJNLPTmsxT
	 DMnh6A7GapzbhPiUuCNwxFS6eEO78ll/aCq2NApD2TBdU1IQtVqMlJuKUjx/g5zePnx1p
	 F+hXqLcfzM65lXsl6KZBMBIxSp7rYrY8J4CyYt/eKoJcywMBghR+C9lXdJfk+zeRVLrzm
	 EhN/fgkR33dH5FXEzl5DAFxqkec9xSojYJj8fNLuERNQhkYTfuwRY9jekLij4Vqpzdw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790515041;
	bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tUNKh88oEcN0QWu848ZqOGtlK0/+aL8oJ8+NrB8jcd2KIBmCnc1Z/BiChRh5x4a4/
	 yX/qg6pCyE2HbDf57HqCpKK/i/ZWA/h4Vq7XyNkNjuLfxCNSvuUWFYABBQQ5VudzsK
	 //jW58LVwMxaSIHoz2NnaU0WmUXNLNtn5wS/Qqh+F9T3XXBhmunrtZ4UbAPKQ2aI5z
	 QorLbXanB8cFzS9L+PaTj4K5mWY29vmIDZRhUAueC9wZCoBD2Ny8wAmIOPIuKYVD5f
	 VDEiW5b08bWbaCrP6WhXmtjKHgOnJ9IRobaWezxKGRP9nVmNziPgZX1ZtGaO3hyLT8
	 CBUBVIjraX1pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 889E340509;
	Sun, 27 Sep 2026 13:17:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23263329
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08F0F400AD
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H8rZb7cH8zGD for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 12:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 274CE40099
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790511166;
 b=fPaWzj0d9CuPmn/C3x9BJau/PzYxr5XDEdB5KLLgrlYe4pdnKINXQ4JCl/kGlFT+npLO
 ZW/twhmRnnHDNlTWd29aNPFkdyvDBmnWg0sv6kr3RbA4pX3WuzIXF39wL9xzDlh5vLeyU
 Ox+XNE03x6MHFyp9jcp9EsvSHnrLzN6p9xyHJdu7Tkyl737iTyjmHRuLSwxspIYtR43R8
 zNZahLDHMft3S1tsv/KdJYADrLu3A81ypE6q0dv8NHpWcRe3upj+bOPMPy0SYrkr25Meo
 F8zE0lneq9ssuBO4DD7G3o6sGGZmtLs4Bvof7OlgozDcCEbuP1kZbLzWLdmYxaFQZlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790511166;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
 b=tO+gj8T4Ir1+3L7VIF9p5Z+sEDltyyUeBjCBzyVlshmXc5UpAqaCqVOCEA53Fa2tqg1C
 f2CS8B/UvShJqTj8SRtO/qOS5XLDEVFb6tmF/sYMrGXoiRt2mA3nLd7H9hMnUVem4omwt
 3YyiX0eE47MRAc+9Fzl/ekqjFdxRQ4v/kW2Kja5/P722ZJM0hKwS7BHzUjJF9krCxRYmS
 neqiMLQ84wMbgWNU0b4dIrAIKwJKwlqeDtMBjj4GPGTYr84LpM+GKtvYT07pEuGnRHizT
 mULa0yW7wNek5hOkmZyUxkS5wQaHcHjKeUXniZh84WUazzd8iv7yT7l5Ql3bKQrGG6Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Sm54zADk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Sm54zADk
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 274CE40099
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790510983; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fwWurCmjlDaRWp8bxVEnOfUNvI/+emRh4896xB5r4VzRTvfxYmbyaWSXPdsOUZFOjkIvBzaJ74WfzwgnG0f23+AW2wuHgBNXhczw6wfym2iZfW6qPI55RHKorHbPHBdtSVfOaJ9E/nziwuof5F5jLQZqh5FMyKhwcRAmKhny+HI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790510983;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=; 
 b=n0dtQAIauYoqJ6JRDPKItSl0QShPhjyb72YbfF4wH7RqkwGKOSBUAiw8UroxnqZwe2D08wUujkQgTbEzuV3deJzSB1AcJLjZQj5fwGfMX/22wBDbFoUMjiIGce2ZRp9hpv70cos6nkrc6oMmi3RymBEvIt5UgAa/l9Z+E7fePPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790510983; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
 b=Sm54zADkOoITUeAWmplO770cj7JDhwgz+5zZsIkUsPmHr3zW5qVVrZ5TRHUQWnlK
 GHFSR8/TZyS1PnHHLU4TQWWDUYYKUspgWWSuTXb69GMZd8I1CeT450xJSjhc67J2ATU
 NvQ+JR+1usSCZrExtyFYTIcymA5lTUuimbZlJDJc=
Received: by smtp.zohomail.com with SMTPS id 1790510982140979.0999558039225;
 Sun, 27 Sep 2026 05:09:42 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 20:08:57 +0800
Subject: [PATCH v5 02/10] mmc: cv1800b: Add SG2002 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-2-7f64983e59e1@zohomail.com>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112278f7dcca89cebd716f279df53000099266903d226153d6fad23e64e356a08773eba87692581d345:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:17:14 +0000
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

