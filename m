Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3CCC9831E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 01:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B16660BD3;
	Fri, 25 Sep 2026 01:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9q2SKO621GzJ; Fri, 25 Sep 2026 01:14:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B048060BCA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790298880;
	b=F8FNjhJ0R4ZajY6XesKv6zd/TMMGMndy/JB5JvTka+AwHPw/PIsRwycIFDZTy39/xWT0
	 zJx/55oCf3VOhztJbORQgzWcB/KgVn9zrQiOqscRLqodQcdaW+5OrRZKIC9/yqPCF/VZ/
	 WpJlMyOrlSzUAVqlL1SQq6Sror26MOfmGNK5R0cKYAzJYwgOyhpOjgaT/RUbnvhLBPZxm
	 9GDBvuQDi5IcDUbIjXNOR9b8y8iM/y91bnZP1DX6OpFhJiB01E4oJuBE5HdtPDO9sVXqb
	 1HJ0gz9+DqSGVN40XWK1wGly0Hlfx9L+U1PuAq3fXmhV08o1v52z/UXJsaw4H+hll7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790298880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tkRRuMq1PjOW0enecJ03wZkKC68MGwW7bC9CrdveXEI=;
	b=m1V0oFtG2z3tI5mS7rK99uufzB5yuQtV1fOX7l7TxGUIsnoXFAFrykOyc/5TNtehHeUR
	 EKaJJUR4L5TzagVlI7tu6lEqlqPkC+2NHTGP9ky0nVVU+Ma/N+imHBSlJacOr44AqOe5j
	 R7TDbC4IvGITplmSYgtwR4JUeqHSWbWw12rxQsqf4uiWeev1KaCpivY0ie10Dca59HYvo
	 5w/Gj96/HfSkWENw0IzBs/34OjJ6laOOQ3MoPkYfJnYyen46OjjohBQiFuPSTR1W6D4SB
	 PKlRw8/Ko4By4ZEBcbzYRYk027PDKDZE1VP8N0cPYH2E3C0PDoLydHBwEUb37upU7Ww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=eUZaldSS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790298880;
	bh=tkRRuMq1PjOW0enecJ03wZkKC68MGwW7bC9CrdveXEI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cKMcOgA0ny11EU0G4/mHcmU91poDUtGeXNLp6pC1tB50W6LG9HwnNQLIK/RIi7ayu
	 kfazoZyxsbxoW51TE8dyRQF2KV8IadsK1UsE6oz01IoqP08UQqe5S3fJf2egFGxeeM
	 8+WKgf/QjEceEzwtFcwncUHJbNeZ3q4I87WiGhsXusUWBHVkewWtfU9RbGAkykXuWV
	 EqXvjk+yVsKJ+1gxE1jmOdpPZKL20lBK/qm2y2aFSk0YfRbDzKVEqERTO67Pvlg9J4
	 j3849ZvMdRk2wMSIyOs8/6z66nM/WDH7j22hdAA32S28kqm2cDms1NWs5xqp9mYPNf
	 Zw7RReSlZohyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B048060BCA;
	Fri, 25 Sep 2026 01:14:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98C2E332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 01:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A49060BCA
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 01:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFRM3KGomN-B for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 01:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5ED4860BB2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790298878;
 b=LXDd2rFuYSdI3oDS3r8r5PMgJkP5ws+vuilidr9jFeHixCsmPxP+YUsX1rcr4zLxdR0N
 h2D3ZSKyhO9mIsYFgskX/TtLChGEJGJFFyiV5RTYEzy3tyKLE+DS5vi3jhBHQ9YsbBQgS
 NobyAioOuEivGsKEQr6i4zx0+sQMo7yjBEB9c7NpiXVNYXM4ACum1OnA+kGtK/IMvBW4c
 BsJ4aIYzTHBXcg0owCyK7jvJtXuHjT81AUZl88x9boTHdvS9R1wCDF+qvG1g3jlZOThRn
 qUh9rq6tVkuL2KadQbmthihpvr7keesDbQrohcGyCkd+X7HTrX4NJayi7jGWMpNh65g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790298878;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=tkRRuMq1PjOW0enecJ03wZkKC68MGwW7bC9CrdveXEI=;
 b=a2rsJkLwoW82rMp2DuBTwGx8YdbmPQCl9XG8K0jvwm4CrgyRNcEkp8uaAHhzFWToahaS
 muXrNVhEAU7fk64ZKCwyreE8lVAVFIq0aVottDFppGNgfMprUUef4A5Uwk63ZaCko+BS8
 GboguwA3FgfR91TqFilnUh7wcA8t9s2cbVg1wiwZXpOhQakDwpycy7HlIpOU1Ok4jEcMg
 hS7RqJsAiEatUXUpvpkD/AV2ZEQDXox1y9TJpaCRTCfFBUOoegjIBkDstU7yL0OJlXsbb
 D2Otcwni6vSbFw4Ujgab7PQDS/L6IrKkrtP8PnVTkj5OcakR/d0WZbFxCeot3amd5BA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=eUZaldSS; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=eUZaldSS
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5ED4860BB2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 16F01B0051B;
 Fri, 25 Sep 2026 03:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790298874;
 bh=505k8e/ds1fOTCZPGmlnXQeLVooGNfjU66ymU8Yg5og=;
 h=From:To:Cc:Subject:Date:From;
 b=eUZaldSSx6Jigw0IGARTY9ToUARkCxbbkP/SxWqoNNnlMCZcd58wl3iwfsekIFmOw
 cNcD1MFDJUe43qQExkiKw+dFnSMFdeOPuLWI+WhTO49FAtda98EHFYSLw3HFfN9awf
 lUBkFQXxHII/pr7yXWzjXevYEwxw4KiI2sMZ+nOhNkVABEc32Gl6BXlkHfJSEk41UL
 xDmsQf54R5LNGYOd5MGgFuvFsM21LaqSMN/wldEHkHzJsatCZJi6xUhY8eEGQaXFn2
 G4KIvAWhlhKG9TE2Q9/ZRsUih4lbpn2Kn+9Sw1jBYRg6Oh8I3TDbQmBV9f2BaO61XV
 CQABVvjVhjGkA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
Date: Fri, 25 Sep 2026 03:14:22 +0200
Message-ID: <20260925011422.290027-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

The GD55LB02GF supports Dual Output Fast Read and Dual IO Fast Read
according to its datasheet, but its entry only declares the single
and quad reads.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/mtd/spi/spi-nor-ids.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..59247b3f4b9 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -233,7 +233,8 @@ const struct flash_info spi_nor_ids[] = {
 	},
 	{
 		INFO("gd55lb02gf", 0xc8601c, 0, 64 * 1024, 4096,
-		     SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
+		     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+		     SPI_NOR_4B_OPCODES)
 	},
 #endif
 #ifdef CONFIG_SPI_FLASH_ISSI		/* ISSI */
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
branch: for-upstream/mtd-gd55lb02gf-dual-read-v1

-- 
2.43.0

