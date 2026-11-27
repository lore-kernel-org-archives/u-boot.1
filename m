Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA0606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PXmGVL5l;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=nura.eco header.i=@nura.eco header.a=rsa-sha256 header.s=key1 header.b=jzgNpx2p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF7DA81135;
	Fri, 27 Nov 2026 16:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3E6dt0WlfWls; Fri, 27 Nov 2026 16:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C65F181046
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796013;
	b=bo3WAWRDOB7sPkk/tRycZ5ucODFT8A/rflRw0ei6+iEUzxVGvgzydkCRAQScHxhaw+sb
	 WVvRxbANPAxBoq8Sik+gBuKKUANTPfe1n7GNPjUtLRiNT+vEJJQ1RKyzwljrH1SwGlXwt
	 ozMwiAKE4o37rFl/avmXkrqkBik35pU8sSbUDlAyYvWyIVDfWL3Uk3RM9uOVn3SuX8f6/
	 PlwsgNOoBV/Zz61MDo/S9Jh5lM8gL36NXeeullrrRzehB+7D0RnRAa5R193R1jbdUmAYq
	 4Axtb2F8JSN529u/wYwgyx3pZrMzwB+LfOYi2O8X4O3iuCIhPKJF921vg1cRMttQDJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:
	 X-Migadu-Flow:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jRup8l4emeP2pOwvJ5u3MoDhDGp7/E0jvEL0wnyDy9k=;
	b=DJDiD/tqyPJDj641vTr2SVClrpFAwUJXp4RBiqDp5D8P2qLGnzVjBrCmzuZgKJsQGRuP
	 2ySGH/LvVcMlAbCxJ3egS2eu93MIqBi5IYsAe9mwAnRW1vexOHoCDoMTZ0v3XZ1mKIrzj
	 T35YuxsUWPsCTWqozmQxZxDg5AHuPAkJFW4AZPUWSEdFpDS/cLQQx9c9HSHK9eMnohH86
	 msjGsinPvvLvkfe4b2IwvsmMazuLtfqSZ7racN4q2wzoCNiPP2CAm2cGMmzIt9/xEw60a
	 nSjMSlhT22Jdenoau82acQfH3WvkEOEWgjfaYI7DTUn8Ij49hzBS53UbgHQv/x18Oyw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796012;
	bh=jRup8l4emeP2pOwvJ5u3MoDhDGp7/E0jvEL0wnyDy9k=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PXmGVL5lRJq2VUIttKMKZSleysxRV8dD4rKLmI4+qEpY0DtpK0DNYBTn502SoDedG
	 CtcUIr5Kbli433vm6cyJixTVNkByQiVS1JjW477+DJzWnjDs9u79R7US8HC8VV9mMi
	 9nONd9VSgDq8bSwcJ6w64uVWNkcMfxvAWAtRhEOp2p+2Wh2grhsyiY+4FZpCP1R7v/
	 8LnJ367yRfLZquyNZvh/1VSa491nMHoYgTUvjg5CC7YJPRgDkvn+I5Xl29mpTP1/HQ
	 lVbFTBp734NtccWWWLsVNGKpekP3hmZU9Xux1WkDn1zeKfpiyGX3qQHXT5c6Volo4L
	 V+X6pEzxZllCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C65F181046;
	Fri, 27 Nov 2026 16:13:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02DCBD1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8A0440897
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fHkaRiMkNVEU for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 15:40:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E27B40896
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=95.215.58.3
X-Greylist: delayed 303 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 27 Nov 2026 15:39:59 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nura.eco
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nura.eco header.i=@nura.eco header.a=rsa-sha256
 header.s=key1 header.b=jzgNpx2p
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.3;
 helo=mta1.migadu.com; envelope-from=funderscore@nura.eco; receiver=<UNKNOWN> 
Received: from mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E27B40896
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:39:59 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=r/Hdh2Ms+aVq6YXKbF1beJaWk3ruU/QYYBoIQrQPw2g=; 
 c=simple/simple; d=nura.eco;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795793997; v=1; x=1796398797;
 b=jzgNpx2p6apyg/I5bB7MBR/fSgJR2qI+YQe+k/TiBZDDmVV5Q/ia79txJ20uK27oRo1EuMPR
 CeDJ5qv8vTCro8NrPnL3mV9ycSkW5JwqV17QMjVa+Qgvz0KVT4LY7MGsK7B6OvFQnXgiu9F+4GD
 dUT34QJbaIQ4HkX5B0tSSmq3vr205NuTJSBfj8mUUpfaQssG7r4Vcok6KYBBSSi7YqPie0Kn6P3
 N689S4PA3gSeMgb041onS5Olo3hVgpHOIP8waMMct3X6ZEmxz9PjhP9WoyWiXy9ijataxnCNQEz
 sZhau/jT7xSQDBRNPCqefpuMBcwEuaGlmtjw2QllygqOA==
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 86e94726624b23b4;
 Fri, 27 Nov 2026 15:33:51 +0000
X-Mizu-Trace-ID: 86e94726624b23b4
X-Migadu-Flow: FLOW_OUT
From: Ferass El Hafidi <funderscore@nura.eco>
Date: Fri, 27 Nov 2026 15:33:42 +0000
Subject: [PATCH] .mailmap: update my email address
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mailmap-funderscore-v1-1-d76766e2d31b@nura.eco>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBG4avErBPSoqCrRAvJ3xooi5EiEO+et
 PwW7yWKEEaksUokeDjyGQp0XdGy2bBCsSsm05heazOow/J+2Ev5OzhIXE6Bci00OqD1xlEpL4H
 n979Oc84f88lPeWUAAAA=
X-Change-ID: 20261127-mailmap-funderscore-d3e1e4ee3f2d
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marex@nabladev.com>, Ferass El Hafidi <funderscore@nura.eco>, 
 Ferass El Hafidi <funderscore@nura.eco>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=funderscore@nura.eco; 
 h=from:subject:message-id;
 bh=r/Hdh2Ms+aVq6YXKbF1beJaWk3ruU/QYYBoIQrQPw2g=; 
 b=owGbwMvMwCXmrHl2/av2XeKMp9WSGLI5F92QXnkgQkjolmbWoz958ZMZdks9cFilYft3ypEZb
 8J6ih8975jIwiDGxWAppshyPnR/8v7vG0Oltz8KhJnDygQ2RKSBAQhYGPhyE/NKjXSM9Ey1DfUM
 gQwdIwYuTgGYapUJDP+M9k14euecYKT46dfih24J7VXctbMrXmLFlYK9rO3Lpx1WZ2RYM3tFgnj
 n7oRTbySaFiQUn/mX8EhBfNpyjydql7ds3hLJBQA=
X-Developer-Key: i=funderscore@nura.eco; a=openpgp;
 fpr=CF55BF63BFF7B1551BB7E2514329CDAFEA87BA17
X-Mailman-Approved-At: Fri, 27 Nov 2026 16:13:27 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

My @postmarketos.org email address is now an alias to @nura.eco, and will
be decomissioned in a year.

Signed-off-by: Ferass El Hafidi <funderscore@nura.eco>
---
For more context, see: https://nura.eco/blog/2026/09/27/nura-rename/
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index fd230b8fdf6..69864244d02 100644
--- a/.mailmap
+++ b/.mailmap
@@ -54,6 +54,7 @@ Eugen Hristev <ehristev@kernel.org> <eugen.hristev@collabora.com>
 Eugen Hristev <ehristev@kernel.org> <eugen.hristev@linaro.org>
 Eugen Hristev <ehristev@kernel.org> <eugen.hristev@microchip.com>
 Fabio Estevam <fabio.estevam@nxp.com>
+Ferass El Hafidi <funderscore@nura.eco> <funderscore@postmarketos.org>
 Greg Malysa <malysagreg@gmail.com> <greg.malysa@timesys.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
 Harini Katakam <harini.katakam@amd.com> <harini.katakam@xilinx.com>

---
base-commit: 8e939402ab242b02e50cea8b98c51cb4c51546fc
change-id: 20261127-mailmap-funderscore-d3e1e4ee3f2d

Best regards,
-- 
Ferass

