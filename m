Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433C8C9830E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 13:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 783616062D;
	Sun, 27 Sep 2026 13:17:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKyLfo9l5Vnr; Sun, 27 Sep 2026 13:17:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B0F1E60621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790515039;
	b=eQVNRF1U/zJSOjB7ogIW/8fephIRIgNFHciFeb/YVjrf6D2cvkIRF89t78WSCmEfnnpD
	 oTgALcBd9h9BJj+5OJNujBhuTb/h/HhO/hAlvpzXVIFaokzk2G/Th7y6zynsK6drqALE9
	 4YPE7k9kgrrgGUC8cWK7hM6uMlcRZj4ozgzcJ6/4aF3tyQVnmHk/IyHhWSs707zRI1Gf4
	 4dvvk46d7FPjhHcSbtlmMV0gDybO1Q8DTKmjvIjhcBj4kAcAi3z/xUJFpXVUQ5gmlYl9d
	 iJv6McraJp/2kop8pZTAEAyHLoLZ0HUKPLIyUaCxd64wsPAeXNzVsveVLmk0l7DEozw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790515039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=;
	b=FfzN17x96TwRjaqhp2CLU4ohrnOM9U+NRwR0zNjQejtpe1eAuJPRe7ReeIqkC6CKEC08
	 KVDiTT6ryWy+ktchlCpfJkLvLzM2agTD4xrcvJCp3zkSyxiuNpqvv+kb0mLKyy1qLvrUV
	 zaSUJOR+qJdi67UCsMfKdF6VeUy/3qOBuEN8H0xjVpbk4lRQEkJELsp/mdpRjbsnq6/VO
	 GXJYiVEbLk+d+V+QPMnpwso1+RX+Jj+W2njML2dK//ScWrG5hnI+mXz8zesYUrXEdzdKe
	 Ay9gu2dfeHmI8Ol7NJfFyKLZU7jiTNWcyjr2qXO9oCnMZfe97gayS2rswfN+zpZKgEQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790515039;
	bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SAzG8jjNU+NOtjgqX8qnh3VWSDJpyFpG2oSiAPs/OO48QmFARJ/bS1rSRDljYTdss
	 JVUPR0JWNJaBduuT2R01ZPCIFp5S+B82FoOOOFoLUyyv7rfKXJ/s4qwlYQiw0wA5Tp
	 Oqh2o87Onp4hOp6meOuRhwEwH3nHhjiDtKRYaeGieGay4Qyy0vbg4h7x2p9VCXzNrl
	 YnZUslhIpAuewSTLiYKG7Vu0cgUDVz4znZuKpWLc//cioCPP1Ajoxqgs+yH1ZR9ETg
	 yA76BVvAAinQAaaXe/yeDbH8i/nuks/OkYlL/+UMuLxppDUJB3UDerAmGusFr+3pDI
	 gjVSLFwih3lNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0F1E60621;
	Sun, 27 Sep 2026 13:17:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A11172
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B3C4400AD
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2R13HawVIrZl for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 12:11:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4300C40099
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790511096;
 b=bdodC0oUi/mrZF1KxEnWN6NkH8f4yI1jqRkWNwH6L9IA91JqZaDIVX0PcuHzH7LVlR5J
 k1TpA2uRvar6LGq/5ZLpUpn/vMbNld8KmoV8aKqzYR1e5CqEVV2s5BoQMar9B4Hc+ml5X
 vcmoCum4R07az9x7vAkfa6ZU9vQlacPd7Yc8Bjjc2r8eGiAIHq3n4IS+7s4ZI6WExt+Ef
 PV/OkTAbfnYDTAe2KArSS3ajQUmia93aSdmVuYL5G3dWtPvm8uldaozq+F1+4IrXpFMGz
 BefRC4n1CT9dhHTqFw63qRrWmbIXCzPiCWV3YfWX0TdwiP43aX70FrPLHEqnFJr7dWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790511096;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=;
 b=nAWFoJxjoyyp2NgcYoICjb5+s775AZ6eI6LYaw64i+BsNzwgShvJB1t73ZTYv4A6Etix
 mhS8+Eq1VSgLnoMQV1VzYJ3r3WP9xC6zrIqGxy0yNme3BraJpC20k5DPiUgQXUQNWpGNc
 aVApmjWQLrNh2WBIE+t3uw9b1pRjtcE1HAV+h96Egkgh5I2bheLhzd+QD31bljwRVZfTi
 97gNEX/MD0eTzinKegURFI1Wm7mR5pP3GnmLJW+m3xwUVOU+EyzDgfjYUfemxkEjiFELq
 WQnegsNMzgYp1Km94KfYyFDt2x7o5ufFHiuZWeekcF5cWxT/z741yIFxCOz8I+cSc9w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b="PQ/l5etR"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=PQ/l5etR
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4300C40099
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790510971; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FVc+U/ML9QXPWdxgNUP/B+YhJDPX6V7phkN3zW7WooMcu35y8dOKCK14eC0DPJGRw0VlMWFGGaMsucfdF4Jy/ZHAgsrpjHKEQYuT7zD4duSAzQnA1WXgdqgLohFqVvfiTj8SbgKb+kdbcgri4Twv3AkP5VOJDKrpIvuwc1P/tQM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790510971;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=; 
 b=WGXDgLjBv+wN8+UeEHumxkWKELgcI0gjIhBecK24I6UfRmgUEpu9SP0mr6/1r0BNEs39W2dYBTqxKvVlSX2LBs3B/iq/r9+P4R+BT71c06Bvt2JclbKe0Ukja2naaQqVXHyXmj7zlUBy1bmW8BpmHDYbU6bZVKqrRE6bxqNp8kI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790510971; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=Ucz+tGyex1V95dwXw9xH2Nr3mTdb9dXQCR6eNtR4PPg=;
 b=PQ/l5etRoQq5hkc9Tv6B1IAHwL2DDxFiYMBIztZ8Ioo2F+/nWuFQJpajUYZapGmg
 j8mAWnYXh/43nv1cb897njSZna7ZV2v3cbgp9op5PygBvWUOSMEUpatvxBzsvn/AjUY
 cS3Mnjp1wUu0WGa3FFw3LJSirsXoOQVRlbO9hn0Y=
Received: by smtp.zohomail.com with SMTPS id 179051097116987.65292598545079;
 Sun, 27 Sep 2026 05:09:31 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 20:08:56 +0800
Subject: [PATCH v5 01/10] clk: sophgo: cv1800b: Add SoC-specific compatible
 strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-1-7f64983e59e1@zohomail.com>
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
Feedback-ID: zu080112273d34d03ca1211d0952c7466a000039353e6716e2c2e070ffecdbc88353833343c21145c40a828a:ZohoMail
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

