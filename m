Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5232C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 941D2606D3;
	Mon, 27 Jul 2026 09:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VuKbcr-N8XvA; Mon, 27 Jul 2026 09:09:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24607606D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143387;
	bh=7T2t664wmTQ4FwvC5X97PwVPbEa8rWOpCJM4NWvaSZA=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=UhgOJkZVHadnlvz1mnCWA/9+/KhpS+1O9HDm91f0aFW0MjJCDuGDF9g16/Mdi2ABm
	 0Ll0kaIHWctBm2x2AHByagub8RdyGkv6bmBXtnkzwgZ0vhH2loUq5qoDBtUG2caQCz
	 +s7n+EfdRWgMrMbZZF70zTivbB+j6zyD0VGpIkiLV9QipPVj5eky8b3NnT1cpWIHss
	 dOVoPurNPNGVug7LxLMXON2crBzfnZHYXfqUbQS/RJxrWTJ+VRLCRlHtIfNp9JDelW
	 5KfDxa3M9rW3SzR4fwzMxQHDC6pB6nDeNMlrOzJtb3ivM4JFroLN/H/2I2rVG8Py/k
	 FqJKdpBqMK7xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24607606D4;
	Mon, 27 Jul 2026 09:09:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CC553B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2AD340621
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qs5SCcyA1L80 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:13:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DE9434061F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE9434061F
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE9434061F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785135221; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Os2JCelZGJuIQILLuBEn3Ukpm6afDq/JvjrC8Bsxtx+hJiLgul1kOTqtBb4LRxY8tFZxUcIcyhJJmVj9Y+aqr0dMIQoCFc+EG5UAO1FFEp7KCnCcIOeK4rJuoq5AsdDSJ3fqjH4lmTzl8DPQ3ixd5ZaxwxIYcvKGvUWntDm0pIo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785135221;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7T2t664wmTQ4FwvC5X97PwVPbEa8rWOpCJM4NWvaSZA=; 
 b=EFWSihKFIt/cD0SIyaYC2hQPmjnz0pMAL4vsVMESo2VD+h0k5cfBkxmcuf5Q4m5BC7AaTeZ78DAYKQjsMyqqgiUC7bOVVwbG5Rl6dVlAKOYqKZZrM1C2NZ+L/kz5YW9RFYBtVWmM7Idgl2N1aJDXWUxil+0BP6k66hW+XaN/dbA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1785135219147340.0331840927356;
 Sun, 26 Jul 2026 23:53:39 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:50:16 +0800
Subject: [PATCH RESEND v2 7/7] clk: sophgo: cv1800b: Drop legacy compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-milkv-duo-upstream-dts-v2-7-51486b4549c7@zohomail.com>
References: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
In-Reply-To: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
To: u-boot@lists.u-boot-project.org
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
Feedback-ID: zu080112271a4ccdd206df50e5e7ff1e1f000081391d13707d5ce08d4f0cef1d1f436d6660c3533c0bd21d2f:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785135221; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=7T2t664wmTQ4FwvC5X97PwVPbEa8rWOpCJM4NWvaSZA=;
 b=awDdXwYPCX+jdcbgY21F25X1e0DZUMuPqumodQItOMGXseApxmiG3Cfv/FK0+Jyg
 oSSGlCb21rbak+9J0PfelMcOWqN6BNEogdQsC9XEAkcomK8uaq9G0OWB5/wmPZE+Ytu
 tUSAHiZNgZ6giVuvREawjEYCnzMRDbwqV1/+3Okg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=awDdXwYP
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

Milk-V Duo and LicheeRV Nano now use upstream devicetrees with the
SoC-specific "sophgo,cv1800b-clk" and "sophgo,sg2002-clk"
compatibles.

Remove the now-unused legacy "sophgo,cv1800-clk" compatible.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 57051c1ec0a..2270a076ce2 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -743,7 +743,6 @@ const struct clk_ops cv1800b_clk_ops = {
 };
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
-	{ .compatible = "sophgo,cv1800-clk" },
 	{ .compatible = "sophgo,cv1800b-clk" },
 	{ .compatible = "sophgo,sg2002-clk" },
 	{ },

-- 
2.55.0

