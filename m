Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A175CC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 514706062C;
	Mon, 27 Jul 2026 09:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4SZMzVDnWxsD; Mon, 27 Jul 2026 09:09:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F49F6065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143379;
	bh=p9LM2EfsTCrqdsQgKT+v5yy8+9dxgcUpQn5qf12qu8k=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QI7nzGU46FmX2BE5csOqfmlQxLci+upZrqMh34QRGPXWokQVbyz8OcpWWj+v3QqBE
	 OY0Jmtgodm0GoNWONMDWK4Ttbm9T7lSzrQsVyddu7hvfSGJkEc822iOytgAbVmOhoq
	 Cpfq33szDxn0roMDPON5c3gBEna3WzSL4gEWGHYglC65d/KOqax6qSPpvWYRoVQrrq
	 vteHPISPWP9M6IhSUl2YGBvGe+VrF4byza9uvPigJC+Mwy7Wt+WBRDpNZY2+j+0k9D
	 atONFIlWl1otFSqOTslMjV5OzXk6FHjAfgeIvwQeB+4zZTpu0ZKngGvOcJqKfJB1vO
	 CoCr5+aWyZGrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F49F6065A;
	Mon, 27 Jul 2026 09:09:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F2A942A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 319184009A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gu5XCi0g_iKC for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:09:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1AC1F4008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1AC1F4008E
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AC1F4008E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785135179; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Sums6qYP/i6lq4+myvyb9IAFzqsWS52kf9NnseprY4F1zP+9UeSLMKE0fWQWreMCR9SI42aJoQkvcfTZSDFyRCwtCVtWRYOU7XWbC0qqzeUeBYfy1dZx/pwlmQAFQJ7eZiRUDoFTomdP7PsRDzJAiANT0za8aLLCqlu3p7uNeWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785135179;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=p9LM2EfsTCrqdsQgKT+v5yy8+9dxgcUpQn5qf12qu8k=; 
 b=UQczYss9J6r3OtDXGxYfO0x/r5YSVbpxVyKfcUypmyJ+EutCbYkApoZ8pzYK62CSmV8z3pu55WQvwCh/PnqPGbe+zmJudN2xxaHm9O46QD7SZwPzk85ISj9l10Nm91VDVYA68d3C+er/d/GbUqA2eZknGQo7j81TNjLyI+7e6Uo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1785135175626141.51418474166155;
 Sun, 26 Jul 2026 23:52:55 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:50:10 +0800
Subject: [PATCH RESEND v2 1/7] clk: sophgo: cv1800b: Add SoC-specific
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-milkv-duo-upstream-dts-v2-1-51486b4549c7@zohomail.com>
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
Feedback-ID: zu080112272e31943dfd8e14a1ba1c1ace0000f9c2e6ff77a845421d9f6d338559afac9de89b959335c2c9be:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785135179; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=p9LM2EfsTCrqdsQgKT+v5yy8+9dxgcUpQn5qf12qu8k=;
 b=GzEey+8gY/+xI/2DSE6xdlFB3hikqCedHpRZl46fnpqnzqY+btqoNnEv9iifZUgf
 6++wJcUg0tmtuhuaoryCh6CZB4qdNsNQtUVXag8QcP9Es4cun3N2GgkDouXxrFh7lyq
 9KRV/PfcVD7CqGumP4ohY9KoPZ7ViRbSn2w7fPEY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=GzEey+8g
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

The upstream CV1800B and SG2002 devicetrees use
"sophgo,cv1800b-clk" and "sophgo,sg2002-clk" respectively.

Add both compatibles to the existing CV1800B clock driver.

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

