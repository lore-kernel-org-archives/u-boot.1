Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBB9C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C0E1406E4;
	Wed, 16 Sep 2026 09:37:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhNLrrO9LtjL; Wed, 16 Sep 2026 09:37:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6AD33406F2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551476;
	b=jZLt0vg5RRJGLfbOv2IoUy254FsIWbmhjg1CaO6qZG4lFuCM4cdBgloTLISY1DWVjiYT
	 jTaVZEDVK5aYUk5bDaxpch/l1j4qiczNKCMxUO1GkSp3lHFpGlS01BiWQNkJrSPX9smjN
	 AJyRjIJzBpu0Y8sMb6o6a6LyAazxGr4NAUEwmx/IVtkPqpMpiiUf7ku0etSqxLsJ0ziXs
	 J9ZrokbfgktPu4pjOjMWwTIy0GENWJezsQbv8u6TpSAddGmd2W9xpBBXRk57nKoTN1fv7
	 tX89251GHfquS2uZJyyT3oJ1YOGYNwW2DL1kb9I78T/6NZdwoS3HZgjw47+hziniACw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551476;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0BMIViEfIimZY9uV44ITpIlbOX7Vrc0wacFUY9ypWt4=;
	b=VjdCQ8tCL0pG2XyGTjb1osulPRLEqIt+woyvSnIt3Stw6YJ2fb9gDOQYHv8H5agq0R7t
	 vY9pPWvEb7MOddde5Gp8v3zawDIduIdQ4pVWt97mNB4+UQEu6eQ3/JUZlbCdAtwsjUr9I
	 G1kvwUCdWvUFzoDZY/9b20X1fzsY7PzY1ypmgSV7dV2I4F1/9vekiLIES5vMSN8K189ys
	 8CZJgwsvitVaedJvJO55wYy0ExJSTj/3XEcubTWsBD5bJNUxwcFdPy4ZTUbFezbCDvCmE
	 9jUdStvtBeg8LWQ9M4Br+RYK/7p/nIV9cVvadh5LXOCVjACq/NLDqMhDIH7y5I+tXuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KMw/UoQG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551476;
	bh=0BMIViEfIimZY9uV44ITpIlbOX7Vrc0wacFUY9ypWt4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpPchxrAyFqcSEHhz9Kid83g5EIUvH+By5utzi/1YzeI6bPpyI0a6fhVfbQvv9bZ3
	 uiOIotE0iBXW+qiPnPQjF2+En4ReyvX9BuxJBL6qXk1yO1+SFs2a1j4d1lMhaLM/ib
	 cslKP/R4fBWq1wo/2Dj3bAsYJ5h3J7FYXoZpLicaZMBmftI7G70KdpwgAEtPXR+/Mn
	 MIsWaOmQGWPhm8+aL1GQ3gkZ4c/U+QXE25BFiX5ndbJtu9JdWN7dZ3pmorcP0bSHVp
	 knUM7PGI97PiroXP5uTg9E+ghJbGdsVi+ntVPDiHCrfU7x6Ap5QGHQ5pM78TN0kMDN
	 ykATms/z1XwfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AD33406F2;
	Wed, 16 Sep 2026 09:37:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22D4029B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A9CC406E4
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wbNvfrbN1cRi for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 30251406F3
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551473;
 b=dByxGOAEh8zHkicMBqbKqRUMMYlGbtXBYk+Q3GZ4tqS1zBuWFO8gQxSaIYiQrt/qibXe
 YzK/KCU1tlGOQDybLp253w/DCSnGdYyTo1e8US3Jb9DeX+uG2jImZzzmdlHa9ZmlpK7qm
 pF3UsjoCH7rMUOSE7WSwFlFMqzsDx6lIxWOqGINK6P4fXEy6NmWxXKSSlcQAS4NBXTV2C
 lfr5H4TDUe3WhulkG+pcisB6+ZYroWo0CwJeh4saZHn80tl8RGcU9vu0bNvN/FHgQBAP+
 wHRGjpT4FKKyqGkkX8SrdFcAMGQgjr54l0y/qWscEDIWeDtwk/hAHAdbtJJuE4HIVzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551473;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=0BMIViEfIimZY9uV44ITpIlbOX7Vrc0wacFUY9ypWt4=;
 b=oj91m2IZy1ZNppJn4V6e04uiFlRlKzfQT7ELjfqqlRbioFFCual0rQ/+Btb7d9wy72Yt
 yfYPkJ7UM8aLewkcIWx+gcH0ILJAuoifSk7JjCE0EulY1HUpBvuLTvztklKTqe8iQH4KH
 NrrhN73Lk1LNPKohX26fKs/jWic+pOziJh65nOJDnYZ/ujU+G51i/YdAe5D/6mXq+NtRM
 8t5U4MQVDlJRfqsfyqTb70sFhSyxidRTSXT4oUlwhF+o71tM31iCt3A/aJFJOUwpTMLAA
 ya26nafsqQ9hy8Xc11e1h56+DkD7roxDEuaqzGTK0GMy3nNO/K6g/FrehYgrvXv47Ew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="KMw/UoQG"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=KMw/UoQG
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30251406F3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DBFB41978;
 Wed, 16 Sep 2026 09:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31D21F000FF;
 Wed, 16 Sep 2026 09:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551472;
 bh=0BMIViEfIimZY9uV44ITpIlbOX7Vrc0wacFUY9ypWt4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KMw/UoQGu39QLdllgKZnIMGx24DwV5FheZBrRHfw6bsplXuw6xBrCAV6u05eo5F1C
 8Zq+M6Owv1oWELyxZUYbV1wOo+/SrlPpnmlaKz6VlmRi4Tt0oBhSLA/3q8G/m3F9WY
 PufwSaUmy8vQpMpjXuje9wktM437V8E25uExrfpAP8g9jKnNh10uwk6H3fERBGNEKM
 h0BmkgFUbA0Amjr62iNyfLk0pwTvSEJKjXVaNi/ol6UhLRuOG18MFfTsuBI+zsnlHf
 uV+UGLSNkHfg9R0DH/7hiuPwKx9ZYvlkxCbAzLPdNX1tlX5ScXUY0qRkYUq6383vm5
 qvRX0B7vIXHcA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 11:37:39 +0200
Subject: [PATCH 7/8] mmc: arm_pl180: Use bulk FIFO accessors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mmc-pl180-improvements-v1-7-5d7670c3bb32@kernel.org>
References: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
In-Reply-To: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

The PL180 FIFO burst loops use eight individual readl() or writel()
calls. On ARM each accessor adds an ordering barrier, which makes PIO
transfers unnecessarily expensive.

Use readsl() and writesl() for complete eight-word bursts. These helpers
are intended for FIFO data ports and avoid a barrier around every word.
Keep the existing single-word accessors for transfer tails.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 5912e9d721ce..7d58c64df11d 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -141,7 +141,6 @@ static int do_command(struct mmc *dev, struct mmc_cmd *cmd)
 static int read_bytes(struct mmc *dev, u32 *dest, u32 blkcount, u32 blksize)
 {
 	u32 *tempbuff = dest;
-	int i;
 	u64 xfercount = blkcount * blksize;
 	struct pl180_mmc_host *host = dev->priv;
 	u32 status, status_err;
@@ -154,8 +153,8 @@ static int read_bytes(struct mmc *dev, u32 *dest, u32 blkcount, u32 blksize)
 	while (!status_err &&
 	       xfercount >= SDI_FIFO_BURST_SIZE * sizeof(u32)) {
 		if (status & SDI_STA_RXFIFOBR) {
-			for (i = 0; i < SDI_FIFO_BURST_SIZE; i++)
-				*(tempbuff + i) = readl(&host->base->fifo);
+			readsl(&host->base->fifo, tempbuff,
+			       SDI_FIFO_BURST_SIZE);
 			tempbuff += SDI_FIFO_BURST_SIZE;
 			xfercount -= SDI_FIFO_BURST_SIZE * sizeof(u32);
 		}
@@ -210,7 +209,6 @@ static int read_bytes(struct mmc *dev, u32 *dest, u32 blkcount, u32 blksize)
 static int write_bytes(struct mmc *dev, u32 *src, u32 blkcount, u32 blksize)
 {
 	u32 *tempbuff = src;
-	int i;
 	u64 xfercount = blkcount * blksize;
 	struct pl180_mmc_host *host = dev->priv;
 	u32 status, status_err;
@@ -222,9 +220,8 @@ static int write_bytes(struct mmc *dev, u32 *src, u32 blkcount, u32 blksize)
 	while (!status_err && xfercount) {
 		if (status & SDI_STA_TXFIFOBW) {
 			if (xfercount >= SDI_FIFO_BURST_SIZE * sizeof(u32)) {
-				for (i = 0; i < SDI_FIFO_BURST_SIZE; i++)
-					writel(*(tempbuff + i),
-						&host->base->fifo);
+				writesl(&host->base->fifo, tempbuff,
+					SDI_FIFO_BURST_SIZE);
 				tempbuff += SDI_FIFO_BURST_SIZE;
 				xfercount -= SDI_FIFO_BURST_SIZE * sizeof(u32);
 			} else {

-- 
2.55.0

