Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B61C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAF1A4063E;
	Thu,  6 Aug 2026 13:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufefKYiFAgye; Thu,  6 Aug 2026 13:05:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7832C4065F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021505;
	bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LE3Ikrv85qBbSMZIhEEU5CgltustuCXj/yKyYrYtx6sSVo0L7SQZ62Ed8ndmR9xnN
	 43rXy8BgLp2TBV68taqbF82OMcQT5ggBGP0R3VyXvBQUgv5lfa0igJ7RoW0tfotJca
	 Fn5R7reRid+7l7HqYV7+0ZONMgJvYXLDqwKYzOcDWaAN5ii8D5Sw10t+sUc+pYkmX4
	 9qm/S6w7bNUXIlHVJBgeOjwHEdirScLbv5+7S2szt44WKC8Hk8fS/Yig3h4WI/wHZO
	 uEBvPa0eBpNxEs3LNONpsh+vThktJSkn5lBBNJMk8kp/M2TzoEqqN1Ewk0fWOAbs+M
	 6COTzT7zuSr9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7832C4065F;
	Thu,  6 Aug 2026 13:05:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EBC1B282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E939B403C8
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:15:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zw32EmxkJrSG for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:15:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EB4AD40385
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB4AD40385
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB4AD40385
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786018435; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q0lQULXg08yelvB69I0sPt43y+jMoMYAvE++sKAYLZMuU+qb3WSrmqk6VdHgMFw+wngFzGp7j7nmpNvCJ6CnU4sxNYePT2kHtRGwK2dCgEXsXJSNjaTV0g++M/uQ9qSnJC9bfZDN8zDz3Zn/OG1PZT1UeqP1p8dRbhhAmTpmSgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786018435;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=; 
 b=Ll5sUwwAunv8nWtnm20lRQY50AbowqYH/wK7fSOQvv/TxzYS07HTFO950KSIw75yTUopVQBDyO2Vhb7yp3t9XxveT/oEdx+T+jI/We3Rt3wCpSZf33Fg8y9hDQEhSBt7IKVOwr8HSCWreLE291IWi1PgnYzfFOouPVrp6TSERwI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1786018432270498.53697484163024;
 Thu, 6 Aug 2026 05:13:52 -0700 (PDT)
Date: Thu, 06 Aug 2026 20:13:22 +0800
Subject: [PATCH v3 2/7] mmc: cv1800b: Add SG2002 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-milkv-duo-upstream-dts-v3-2-917cf70a2337@zohomail.com>
References: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227611c51a4210926c4f62ca0e60000e250bac53775f912de3406498b6ab8e9c7cd3d859dcc49467c:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786018435; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=D7y9K9nsKl/qbMyMRX7J16nMx7oB0CNqcR/A6XEWjio=;
 b=JWr03kfa18uC/BwghMOwNy4cvIYpSKY5m3prqm9w1MC7SQGnA8PTjkiH5TOZ3Ohx
 sgTVCbOHrDiMljzo0P7ScTz04oAQzpWoJhNtIH83E/Opxfz/NIpVMyk+59YksAWvxbb
 NJwdW/1X2Gq+RJv6G62uf21ePRyub/wf+z34RAOY=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=JWr03kfa
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
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

