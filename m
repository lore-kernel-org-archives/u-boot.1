Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53908606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FJqMeALs;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=PVysBdJq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EA838116F;
	Mon, 16 Nov 2026 17:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JkKsCuoms9He; Mon, 16 Nov 2026 17:42:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 851E08114E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850930;
	b=r6p0IWqSZ8+NCNx7IHFm7Z8OyeVB9RYWb7EIZvr1FFM3auqaO/mVvIQve/M2ckShljXV
	 ECMXbJ+JGI80rC8ae39/48UKvUdquWewTOq8F+kamkvo38iFHRAYd+5htZ0OazgbYBGMX
	 Ishojz0aaLH/kLChIuKUD/q/cDO3+dn+ehKAf3BEUVur9h4+rHrB4ysUuipRDhAI8YSeK
	 RYbPF6fcd5ySIEYpdHPTPgnYPfWzfTpdLXuo5okThceB1cM9dDDtlW/QfT2k70BAmlTfg
	 9bZbwmm71MrTjgjV4gatyVdtXjRdckQGx5z4/w2brj0qSK6mGZ8x0BLZfUnYfJQ/GXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iludgMzKs4GW2RszyFL0nrP1DLC3fRKtaupvC48RjRg=;
	b=BQ7kQhM90Cv5B2aYX+rJVF4TCaSPEDP7yTEsTnEqbCc6jYmiWzVlRLyg0IBmjml0kRdw
	 nX85U5awqeHUcXMeXGdCF5Fei9DPUndsIuKAeiu7RjQyiQYScTPto1V6lHjxBg5xUgCzn
	 3TKc63lE0HbiyofuFpt3/yy2ovOP8pgETb4Bq27e+x3lqqDCJVf33hEEk/U2J/Xbvfn27
	 nAPjknO4wPpxf+wJv6E/XVO0xVmdW7CdQLBVxAGL22MxLKVv/kI+gYsBlsmKymdu3x4mr
	 dZgLOhokknGQ5pucoUNarjhayyX2Kg7ViXcqNWSGg2gey6AymDxi5hI9w62gsHxxt2w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850930;
	bh=iludgMzKs4GW2RszyFL0nrP1DLC3fRKtaupvC48RjRg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FJqMeALsVIRLzklb33hODvXb++Ryay8giaiAUSyEynAM9UPAeIPLyU++g+C4Y8dSd
	 13IQ95uebQXFwEBjuT922gvA15TxHsLG2O8H5iJOO2mUz/9eTIcO+qiKYWDgPncGrv
	 mzAGf3gEs7Ffdhw7u9EcaqVYA+aq04pdUkm4V3/s2ICME9y89M+s7tCWNJzLZbqmr/
	 KbtrmTqdwURhh7joNMQ2FULv+sp/Qd+OJzbzPcW0gTW0nefu9pEoo/AgPDz23d4CVY
	 4doeaDZFZ70BTx1HioV52wxX0XxP+tr3dcWe11sP9lM9fyX/xX6jIeG9GAigfb3Kja
	 4y6TxahXv3kzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 851E08114E;
	Mon, 16 Nov 2026 17:42:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86F344DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78CC640282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ROOFC079qkzQ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:42:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C32CF4009E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=PVysBdJq
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C32CF4009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSwCw0wC1z8vcQ;
 Mon, 16 Nov 2026 18:42:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iludgMzKs4GW2RszyFL0nrP1DLC3fRKtaupvC48RjRg=;
 b=PVysBdJqboQIhGyYBM+MG0TpxYbgLmOfjslBrDLEc21Au/pA28WYtoceAm5luFKfPu1qIE
 cjvS7KVVNm5hjVIUNQAsC21FIJ3i+6uHutDNdb7YixIPsHWBdo1ZGdhqomQLjge98RbB/3
 j/jHRNU36Dj+s8IRM4DNhDQnVeWJmZukGGVKBr+8PkROr2XSazciLC8nvFZfL6P/FqWKqm
 kgGLuQfJbLYT9pltMNqwLyfmp/HJx+tGB/wXOD/IGDebSpIlWFMQVs2iUarYzMkA76EnFa
 1/LDcqkIxpjiz43abcXLT2Jr7d7I6asUl8pDa1t/auOk0ryzGPyJLJsWtZFJiA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] regulator: pbias: Constify driver ops
Date: Mon, 16 Nov 2026 18:41:59 +0100
Message-ID: <20261116174202.3488204-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9b3f1ab79a5f219ce84
X-MBO-RS-META: jpygx65fsex37pae3ojwu3rcexuy4w6u
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/power/regulator/pbias_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/pbias_regulator.c b/drivers/power/regulator/pbias_regulator.c
index 8f599cab689..6ddcde66b86 100644
--- a/drivers/power/regulator/pbias_regulator.c
+++ b/drivers/power/regulator/pbias_regulator.c
@@ -111,7 +111,7 @@ static int pbias_bind(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pmic_ops pbias_ops = {
+static const struct dm_pmic_ops pbias_ops = {
 	.read = pbias_read,
 	.write = pbias_write,
 };
-- 
2.53.0

