Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC6AC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 494274076B;
	Thu,  6 Aug 2026 13:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xt8fcPTAEpyg; Thu,  6 Aug 2026 13:05:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02EA840764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021513;
	bh=6TPEVjhzXnlmWIpx6BJMG0706Jui/vuJxO1yueUar88=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BKPlmqKS/wz+TSmkGP+IzrDwdEQENxFKgl+Et3vSDaD8SWNu2+u6vcGonwKu5FWEw
	 ZuYDq9CeQbjIlhWrd5VWWGR5Vd1M5ru7UU2+iHEMAk+yokn+eFLcjkHt57XoL31H7n
	 As0G35yp909QW4QlpMSCOu69FkBG0vX5zP5SAsLetr960TKu4FGoIK9kPWMpnbROxm
	 9SBfIidO4PBRO7RhDTJV7nIqVXVrbjedhC4n3ozbJ9LLnP/QmrDmgQiuBKYcHGjZzu
	 t+3cb2EJpB5/nOtHlgZ/OJhoPsFu6Vjnnw69EA1OIVUSIa45addjCz8qqPVFf/i+ui
	 QMgiTQ9T1P1tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02EA840764;
	Thu,  6 Aug 2026 13:05:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD53C194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF1DB40274
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7pn_ncSrn1w for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:19:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C873640272
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C873640272
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C873640272
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786018467; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EPkmTRFaZL6MezJOqqb0Q7xxNLnCmtieiV7+YsemfMfpx0RR59R45tebhPFeeKLdl7ggwifh2BugvEydhFybv3KkzY2S/uO0LyoGhNvG/Spx9hovWXSutPbetBOjZ54PxJOL6WNfQOIg/g4Bul3eGYz1GPYCwRAXHdeLMOfYbp0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786018467;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6TPEVjhzXnlmWIpx6BJMG0706Jui/vuJxO1yueUar88=; 
 b=cjRHFmFSOEK5QVQ7Udjx6nBLFTsb6GVd+PsECeRtNu3ubrglCl8oLzgNMLTy9wTZlDBxudBkGpRzQXxdLsn+5t97J2TMiFRYe7k1nPWfpLlhSjsrBCSwowkWmtEuOBJorE15hppC6q1xF5ajkPCTb7UeGCpgB0uIiuqwTdPiZ04=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1786018464992357.48519816501835;
 Thu, 6 Aug 2026 05:14:24 -0700 (PDT)
Date: Thu, 06 Aug 2026 20:13:27 +0800
Subject: [PATCH v3 7/7] clk: sophgo: cv1800b: Drop legacy compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-milkv-duo-upstream-dts-v3-7-917cf70a2337@zohomail.com>
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
Feedback-ID: zu08011227e95ee239342e4bacdd73a2d5000072f0dd7dae6f5eb0526a203b0e54877c9382d75c63bf8d7e4c:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786018467; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=6TPEVjhzXnlmWIpx6BJMG0706Jui/vuJxO1yueUar88=;
 b=FaMgENzWch9pKpiIrAomJysJ1BwFCrNqPtCjzmhNXVvEQjXOPOt9qWAmGI/t3T/5
 MkWPUHqlOd2aaRtxGj8TZwOD9SXvr7ktFk4CPoIMLKFx8S3+2+ejCPV5Yk1LSwAhUeT
 4oH1ZU94wufUK3w6SGvJTsvSp7+9YJaJT6i9JYEw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=FaMgENzW
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
compatible strings.

Remove the now-unused legacy "sophgo,cv1800-clk" compatible string.

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

