Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02F1C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 15:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E6ED4074C;
	Tue, 22 Sep 2026 15:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CO2sX66zXMU; Tue, 22 Sep 2026 15:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD3A440740
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089393;
	b=TYcogzKmxKHrQmEo02xQSWpHVh3SA3CGWR5BBUadSylDgLT98qjdE4Ja1Q1xsHMX1EZY
	 Sq+4TQykN9oaLxub4ypTeiedPxNWo6A1EPZNN3TK3jnaoksjb/IrPT0UcT6eTjnhQgcyV
	 THCs+oaGLV+SM8jofk7DmlEKPYlmmx2k+wBvvHwWdwO3sUdV2xKnTdxk+hr9gNtkezFlK
	 tyjXq766JVzPOiZtWHSN4zouilWj4yKVgGcJeqM/9NPoF9lI/AURmcHN9Pdrt99Tzw5Qk
	 uUnVkoPtYYPm5RMJl9qxZM3MLEh36OUZD/fX3YW+cZATOJySZ6BXSH8sDP5iTZcBfDw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790089393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=;
	b=fSfC/lMYh4BF515bI5fr01FUu8jhtxLJ+awdCfsV83pGCPxThnSWNcY1+qDPKWu1a7he
	 sPwCb/UFiXKckJA6SYqLJ52RMXRkIuK9OFcvDgTzsqVkV0t9cSgNnTJn6HWhsoHXh2ymo
	 iE++iOxqV0XwKRNDW3OFZzZ7t1plpMgv/Ft/LUrllalVgtjBooSNSieZZfrPyqQoRPsoY
	 92v+XzR/4rND6oMSZpJAdtpwDVzCBqRrjOGtQv2bCRJaxqUk3dpiRrYw2ttt37APyh25c
	 B1WCE3bf/KmFVktJ/T01GRY8NywQ5J2Mxf8GBZnUJjePLhbdMcrzTDq6Zp6i/RqH0cQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790089393;
	bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oxXFvbjTdDBYUnevlT+55gVG/f5HSroc6lZ2XwMHQl3WxXLcWuUL5pyFX8Oq05IGj
	 f9OZtHR9nH1+3U7nn0y/sQCiRFQMUHbayiJnZrGJHh+64YcUGtNnKUuSzsxDi2/ZnV
	 SvavDQBA3TPBas+vZRD4j3t+4e94Rj5x7LJ566+F6+XT39IEGkWsdau5PEeRa6NHnR
	 YiL2VZ+4bVobPhjFDV+xcwQk44eYS9ux+8Rp/xTGqE9Tg9sp59UFGvsWhoABzMNxc8
	 QKvRqLtk6ZbMB6tzgyCI5pJ79V0X3sE6BiZF9ZbP+4c1VSWb2v3vTJfOiGAJuZO5d/
	 5fT38W1188rBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD3A440740;
	Tue, 22 Sep 2026 15:03:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 959EE35A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92F296061C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:02:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lp99v7OVlLUC for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 15:02:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 791BB60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.92
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089342;
 b=D1Bb9DuF2Rd0PCkJybU3fmcfl3yEQd1z71O9xStzpQs0Kfi3Ao3Q7HicA7pJfmAfuzkV
 GoDssAyMCA4lkvgSqonPmyISxpPskITy4RJtfTqSCpVCFwoX2lVuVSsme9JlhmgL/tijT
 jjmL+KuuAecHmE2PjAJjMdhBGePslk30v6p9KY5YTZApus0PS++qZ4YFC8iGttjRCeqQr
 rCbjRXn0Qgvlw/PZvoZPY/EdzrfFXyyugcsHAQv/aKnzudlHRkOzNBqaRUGGJprUCbyHz
 g6X1WlxFf//OAPf9zfwROWV+J7IvEbodXc/B3W4iUP250I1CCaXvLGT1ftdHFNtmqWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089342;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=;
 b=oUxsax4WerwN0qsLM6+jr5dlPNv82TwBAifxwDYF12KWIrc2tjDRfdArQIF7CR/We1HO
 /w+qrVXd6UMBGmWd6riBgLmS1LTV1MMoe7WKKNJzaU4VvMpW6nio9g8i8h099/Z1gYU2C
 nTgyELKTaIqGKrEN4T8ri4P+XMSfUCVcZrF3ZL8AlWP0ta684cyBLKiLW5WJPMoWMsl+P
 qjMR4DQbJLHD2YhLci5anp/Srp0ssNBOKVi3B1/LOWNYxBoPtgDC+tWWJ8izJ5mibVopE
 5Aa9x1iXBB0PrfLn6eOvprRo9eEw1sN58iy4SCMbNelMuFp14qjMMN118zoq0p7272w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b="D0/22Qo8"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
X-Greylist: delayed 115 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 22 Sep 2026 15:02:22 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=D0/22Qo8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.92;
 helo=sender5-pp-o92.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Received: from sender5-pp-o92.zoho.com (sender5-pp-o92.zoho.com
 [165.173.182.92])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 791BB60613
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790089175; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XnTHiyNa0a9aa/6VCYG+zyf/NeDWIZa2ZIkY0uE4aqAHDHJ4usW5fyX7Z12xSUyjVWhQdVlg935toX/MnR9HjS6I4Wd12zFRJ5w/K3slkhBRYi6nALnwuoNH0mLAb8lg21htlnpRcgXBnCu3U+6CZe8ZE2qUwBuAU45H/IBiVtM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790089175;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=; 
 b=Umw8FWyVqOZ6bmBFcORZ7On1qoakfvVYhPDYWfS2Gop8eD7U9kj/uA0bJZkpnzsddjEgjPIP8s/lQ8LT5tXUbun1F7NYhYs5IsL4UQKvNn84w8Kb/z6aU3Y8eCEyoCccAWXLYophGmYb3AE+C0/R3hwC4VhamUqlFWKJJ4yEEUs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790089175; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=;
 b=D0/22Qo8FFDieUGRzIdGn3DkrK8dBfbyVeySyHT5olJa0D2t1k+bFjHD/BpKBBee
 GS6kC3nsx4nWK3Y/fWg1q0L4/8OxKoPm9tdi+Evfk6GJnH7+OvnuW/yoSA2/JWq6WPt
 iWS/vl2KlRVIpE8ttORSgA/f0PDAu+swQFe3SDdY=
Received: by smtp.zohomail.com with SMTPS id 179008917410637.7988238085328;
 Tue, 22 Sep 2026 07:59:34 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 22:59:08 +0800
Subject: [PATCH v4 01/11] clk: sophgo: cv1800b: Add SoC-specific compatible
 strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-1-d45b74dfad36@zohomail.com>
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
Feedback-ID: zu080112279b88063b547ab2c95c94d3e700009cfe023e9e98ac19f7e152e440a4ff7d1bd97c87ae785acbfa:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 15:03:12 +0000
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

The upstream CV1800B and SG2002 devicetrees use
"sophgo,cv1800b-clk" and "sophgo,sg2002-clk" respectively.

Add both compatible strings to the existing CV1800B clock driver.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 248a69321fc..57051c1ec0a 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -744,6 +744,8 @@ const struct clk_ops cv1800b_clk_ops = {
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
 	{ .compatible = "sophgo,cv1800-clk" },
+	{ .compatible = "sophgo,cv1800b-clk" },
+	{ .compatible = "sophgo,sg2002-clk" },
 	{ },
 };
 

-- 
2.55.0

