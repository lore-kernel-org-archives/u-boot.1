Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A0EC79F85
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6FCC60B95;
	Fri,  4 Sep 2026 19:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUU2Itja6trf; Fri,  4 Sep 2026 19:26:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2C10460B8B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549976;
	b=qpDrbtJTHxGa3/fyiNOpT0qEExY0/anZfOCMW0VKF1FMnVwx9XQaNox3SPScPJNhkze+
	 ORTF30W2+Iih+GQ/6Dfyw036ZWAn8meeuDv2nW1af0eCAlQ5woUumndLwZCFArCw1B1dv
	 qSHTJn7Bf0FyaCB+4o7lHHIk+7Fhaf+fr6OrxCy/fPQkM8DvJqWjdeAghaZDkgA8PRRUZ
	 gO0krrRuUL5DXoNndxcgY9FwOex/9Gv68209V4H5cIZO7hIQ7gh1AIH0fZ+BMa9w4oKFL
	 6gIvY+7R0H0E+2J55D7Bg0fonAhqNc1lUoRPItYwg8ZM2xOYMYsU5Ygn9nzSwkRLzRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788549976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CNuzdzlhiwNZfYS2zue/43u40IEhpo3vKPnIDJ1ODnw=;
	b=OLWoc15ASPOYoveejWRKHRn81cvvNDc7pDXvWTlBrY58C+ipqUq3XNPjDSny8bags/nT
	 T+ReFwp89RRPYTE7KTDy85ApXI80x1y/rLJaNb7ryiZJi41zpoWNMzdMYxclen4cxPCZN
	 XeMOwJx50teXUs/KKlj8GA9SrThgDN2uaKXh9kmkM/LblDRbdXrw0PGGqxXWLXSyWvp7F
	 ABCnAd8okswBmBVp0iajIKFtqKxUOFP/vcrJYmjzXaZ++xQPuZ3keDCPMM4egsPYahVMu
	 oZdB8104Yb26s63Nln+SqGbbjILzhR/e0ScGX5RviTUOipJqrJfbbKHdhbqyhGCkQ2Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788549976;
	bh=CNuzdzlhiwNZfYS2zue/43u40IEhpo3vKPnIDJ1ODnw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zVlxvhSQjs4ZZMBoTB1tcDvtxUbrIw7epfu7HtRwSMX4YkJzbNc5THTrj4N/7LidE
	 zmOLAL3WiugbsS+WLyTJLag/cZ6QTDcq9zuwBY1lxGF/pg8KkqwjmfsEd7EjmOp20v
	 RWbloxVW4NF6NpN3sIdE5Uef7yzKw2vq8CjBSZtnltPhdMPcdSibmoKtbduamDZ6Zu
	 moYIdb0EMNTuki8612HEJCxweAdcAxE/LKbMUVjtNp3czDKprHihk2DjzHMWRBV9Pp
	 ue1U+Tpx0noz/MLSLq5xRN90TaJ/cEK0WuvZIdAiNxaM0KMtOrLm5FOt/lOywjVgXx
	 cIQnRSgLOlxaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C10460B8B;
	Fri,  4 Sep 2026 19:26:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 21369118
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1EBF140BBF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6UsSRAum6oZ for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 99F4B40BB3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788527941;
 b=cB8qb6VdqVS9qKdz688ZV8kRzIBc8RAfM8osWSdZu+GBCSfCsO4yyX0fIGzoLSk6HSxv
 fAgsFl6iYmmvHJfxP7Tt4eQOeTN53JsXbDXXObMTJ5bvsSjma7tskAkmC/zCguqS8YyM1
 rC+EsiyuNCEvXVAjcYLQz+fcHcyraB4DxUKNly1fCYW8I2NErm+4L7S3mzHpjgRtEcgmk
 ZdfPRVL4vdBWhdiRQTqImFkn29ZtwZ0dR//QFJRxuveU9bE73oKRcr9D2XbWnt9b8bnHS
 aCcwkV0bRswlsgcRVtS6D/12JFDMYhszneZfwb08RHIgkziykJvEEPH5X3ZP/ahWQdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788527941;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=CNuzdzlhiwNZfYS2zue/43u40IEhpo3vKPnIDJ1ODnw=;
 b=nTMMdTLjzvXNIA1kdaF1axk36gyB0JXF6oEJT2WAMfO2SXys2RuyMLWujH4k79cpstM1
 fFj1LCPZNdU+I6hBEswqTNq+f/9RlaMZhDm25cktJapw9dxsPjsKMeoPay289Q+UodJn6
 5TcRjM6ViSMp8UbBiCoeizOnHy3hYCABGKvGrhcTsyIn7+01kkZa68puBr31Kheyk6nb+
 le3nlndhcLz/p4b269Aq2C5iNiCkrUdOaBqOOD+D88geS8+wKem7HHqXPBnNP1MKNUzd2
 JF+MuQVL/ypk6vtt58ZoDWLaWK537UBZSOTU49bRsvaMcqNYWMOr5K5D3GBg4hDTIGg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99F4B40BB3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-05 (Coremail) with SMTP id zQCowACnFUBBxZpqpt5YBw--.53091S2;
 Fri, 04 Sep 2026 21:18:57 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: tqma7: imply the DP83867 PHY symbol
Date: Fri,  4 Sep 2026 21:18:27 +0800
Message-ID: <20260904131855.43972-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnFUBBxZpqpt5YBw--.53091S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyxWw1kCF4fCFy5uF18uFg_yoWfXrc_GF
 4rXF1Iyw1jg34j93yS9r4SvryF9ayrWF15Jr4qyw43urWa9r13JwnxJF4rZF17W3yUWF47
 u3ykZrySvrn8CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
 1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
 cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
 Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO73vUUUUU
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Fri, 04 Sep 2026 19:26:11 +0000
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

Kconfig expressions use symbol names without the CONFIG_ prefix. MBA7
currently implies CONFIG_PHY_TI_DP83867, which is undefined, while the
driver is controlled by PHY_TI_DP83867.

Use the actual Kconfig symbol so the board selection can imply the PHY
driver as intended.

Fixes: d000ce5efee3 ("board: tqma7: add code for u-boot with spl")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 board/tq/tqma7/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/tq/tqma7/Kconfig b/board/tq/tqma7/Kconfig
index 477ce3f3d53..afda49bea4f 100644
--- a/board/tq/tqma7/Kconfig
+++ b/board/tq/tqma7/Kconfig
@@ -82,7 +82,7 @@ config MBA7
 	imply CMD_USB
 	imply USB_STORAGE
 	imply PHYLIB
-	imply CONFIG_PHY_TI_DP83867
+	imply PHY_TI_DP83867
 	select MXC_UART
 	select DM_MMC
 	select DM_SPI
-- 
2.50.1 (Apple Git-155)

