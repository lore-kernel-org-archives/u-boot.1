Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B7606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x4rFpEGC;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ekNu/orr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03C7A80D3E;
	Wed, 25 Nov 2026 04:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N-xvB26-ooGi; Wed, 25 Nov 2026 04:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 115D580CEE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795582075;
	b=JBlKSRQgzlNz8R+8YYDnvN6nSi7CtPi/7Nov8UyHxS5svjMFuhEpTUaMA4DSztf3mLfw
	 8qqS9qYpM3Li0z7j3/RU6KAJQBUqeqmlUlIhx/lJxVlGrlPiLR8es8lTDsAi7eepU7ljX
	 onFxqjQhJO1uGTJw/EjGrB1rhGqDmvs7s2+8MfOCSLHhPGOLUU/RtPmykQDf6weS3G39H
	 48suDMR98JW2Yof8Z2hl+G5PkFZYrukpp4Ta3wOaUAjJm0zVfHcoXXrEop3sWA7+6qbzs
	 4U6nLVCTe6MyIDXzDNaMkm8vW36Mt1bMLtAVsK0PyVM3ULfdYH9vab4uu9GIayhKUCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795582075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NEnhvI5FQpUQrTQhQPPLu6LvZB0xb8AjdJFpWxluJEY=;
	b=sK1pewDhmMddou3UB2AWEzNg49mnMbfhfAYC3S9jYpy+nES0bc4rSETphAUkEfbTSTpQ
	 5epau+Ryo19bF52ZP0uDq2jrO8jfZkWlC96PoG2BcKT2+yFMrIpis86E+VWLBm2pjtxZQ
	 emNZm9e0kzAHr2n3fJ0E5bGU4al1/cL6PkYys5Zv40ilCQ1t0fVNoDhNosOSgAsF3yOwc
	 FeSt+fzinVezGl9NPF0ogPulZIieWM/Xs3WXALam0UCqJ3VPiH+zoOVcuTFkShTFCRs7Y
	 6ctESVXCrsWNyVmojvIc7QoUJFwwiFCPrOA2/r+ZHC70SmF/ENhPUmbMfy6DXe7I/qw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795582075;
	bh=NEnhvI5FQpUQrTQhQPPLu6LvZB0xb8AjdJFpWxluJEY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=x4rFpEGCT0EBuEq0XyNkhFv3VUJkwi+k3J11KvI+K9hjQ5ro4yRzBlrLcvboN0r8K
	 7H1t144GXCoQcu6H3mtHPRoGtd4X634Uxffr/B3ShRZ/uJmsW4hKabSn35FJ2bG5Iz
	 /0nL9eSFdILvZHfncWE3PFJhxBwDiAhL7yCWb7iS0Lxybstau/Vlzy8ikab++zPdcT
	 UyT7kdMtF3KLCCdno0nORVjEz1RM2EJTrcwMKdj7G9qr5M5OkH93luHHCEvbNLx6hF
	 Aau4jyneWml7kN8xH7PSgTmlsRULqUUzBIm9N9i4aAE5tC5n6xjTdT4IR3b6QxEKTE
	 Sv8WxU3PQjqEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 115D580CEE;
	Wed, 25 Nov 2026 04:47:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD885325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A319740180
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:47:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ptfKi0n73qow for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 04:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 879B2400AF
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ekNu/orr
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 879B2400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:47:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B11D71069B5; Wed, 25 Nov 2026 05:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1795582064; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=NEnhvI5FQpUQrTQhQPPLu6LvZB0xb8AjdJFpWxluJEY=;
 b=ekNu/orrPiiuD2P2Ylo5+nPWhHHA1qd8YIXQZjRzb3JyeQVRmkjStmCJq8mysCa0wykpAc
 Y5YqN31Zy2sX5NjAwVkL+1Nn4FsfgUrPYtlWCvgksoNbnb4yENYjTmbiAvHcDbZ0qXE0nZ
 lWqvZLdC9lDurCJsM07zVMMyb0RmnQNi9BACVyRn4rKNOCRT4I5HQ84Npi9Njw2VbeaTYV
 2YzvLwaGIGKSTiw3IoSH77KAcrJmzk2ij1ArsQS/rDCtWERr4rurhLNLKTvHToTa/mbj3Q
 tv+QkBH9W0DcCcOiB9GbP5LC5cWD/3SUKJUsMe2qrTHnfZXKGTV8p5OPSRzlhg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Heiko Schocher <hs@nabladev.com>, Peter Robinson <pbrobinson@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3] MAINTAINERS: Remove Dinesh from I3C
Date: Wed, 25 Nov 2026 05:47:37 +0100
Message-ID: <20261125044740.549518-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dinesh has left Altera (Info from Alif Zakuan Yaslami) and
has not changed yet his email address.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---

Changes in v3:
- change subject as Fabio suggested

Changes in v2:
- add Reviewed-by tag from Peter
- drop change in .get_maintainer.ignore
  as Tom mentioned.

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6edf740a9ce..33af5ed3075 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1137,8 +1137,7 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
 I3C
-M:	Dinesh <dinesh.maniyam@altera.com>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	cmd/i3c.c
 F:	drivers/i3c/
---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
branch: maintainerupdate-v3

-- 
2.55.0

