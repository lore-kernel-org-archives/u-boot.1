Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C5606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P23FvBhq;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=eHY2zHWW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5221A60750;
	Fri, 20 Nov 2026 08:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAfhlah7A7P1; Fri, 20 Nov 2026 08:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB855606CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795161645;
	b=BXr81I+rTWtk3H8AMS0EsVTt5ikHf3Dh/m7zNH2CMLcvmZPrD7xNB5DU0hL/eacza9Q1
	 pPSxDBcW+/6ZLeWg2A7zoSXdJN6Dc2auIRZs7HnSVfhj4cFlme0VHcpWqb/ab9GUzJ+lK
	 gGXvJuBF0Ni2fwdbv5R0O2oVPHJKOMlKCUvDQN+4l+saQbDWNw2jO4zde32yQTmE0kqqB
	 Zzh/qrjXiUvpUT/l6s1dPZ0Hvq4Nh2X35U3YUpRrTJTSG3Vk1P9sErpD/r8cCydd4//8Y
	 nPzn69n0pBsyFGQClClpGKg5tV5AM0i3n5eE3ulAYfNIt4wsCkUjQBZnlfBEZO/rx1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795161645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oAN7ALYubojHbcgP2qGuIxwKzC9lp3L6wuyAYsFvuAQ=;
	b=SWXuZYP1/UWwIcYLCBvSTEW/bDT7uD1JRJOI/aErogcvZS4JSU0rVJDF6+ZtRMFV3JiE
	 cCt9aalyqyUTqFENN5z0bwoHPZBI4aE02T8yjL83uVB+WwYO7JTHtuQ2Vacdrrk1iEnaw
	 8KuAeW6M9Fd6qpYHbMVTJNO/uUOyLFWLzmC3vPfp0YXcXDwTFuWuqGvGX6Lb49SvLZXi5
	 oZFP8GtZqNFZNH70CxqGGUcHjMI0C41L/r/sjDV+fsinBplPeVIVb9srMuq2RyPx0Eubi
	 H0ttSTYZaATcS3r+zqZY+esjJ0hQe7npObBPVCl9Hy0Kd0pNpN1RQTizmR92cQcC3Aw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795161644;
	bh=oAN7ALYubojHbcgP2qGuIxwKzC9lp3L6wuyAYsFvuAQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P23FvBhq/Nax3+VCih3xDP4wtznFMo3Q2JdThfsAKCcUKypBCzs2joWU/n6rAm1xg
	 ixnZ/NK7QtZAoxUZ4ulzec0Nb/dLS1TFROZgv0yF5ncL2C+N+bTvS5XO4UPwNkAioi
	 cm8lQY0xpZeBeFBdYmvWkuc67TBxVVPIrVURvUdn2+6gP4oHUs5RmE9Z1SjFNq/0LC
	 mfg8AVl6JwXNuAfH/Qq18NGpSf+3cNZ6fIBaaKzlK5Xm7WkTHyyJnJkpVQ/yxWorrg
	 9qntUB0JeoP8RecvZ7kHqvobxrUBYz5ljtMkP3udoqWY7ag6jeJ5UHyIY/Kd/mRklq
	 +S00Vu34IJBUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB855606CE;
	Fri, 20 Nov 2026 08:00:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA0991E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC29E4020D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9PLbLa2SxcMZ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 08:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6DDC5400D6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=eHY2zHWW
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DDC5400D6
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=oAN7ALYubojHbcgP2qGuIxwKzC9lp3L6wuyAYsFvuAQ=; b=eHY2zHWWP4eRuaY4RxtD/+kMgs
 PeTDTUnHCCswzGHUNUuZA7J/U9949TVyk72CKdLxDwCVea1qqM1kusSFxUNFg11hJhh9rFz+LlET4
 UH0EC5qoXKWyFfNXrtkdcnZLwnqKXOpCFiXO4vVyALerk+Vp7mmGc8V84BL2jjMP/fiEWxojc3EK4
 HTikrDpu+S8POFBSEWrs2U6U6X16HcIGuxNBKwqkNrAPe1szyYXbuoKl4QqpqmcfE4tt02xNp9LeG
 tVM5qexqt1bEiFQ0L0EQXmDP5cP/6GAV/g+mAbhFWgQLv4e5C2wzJOJR94WmpSvsDjV7sVz9SLvSq
 BurQgyQA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xUJXk-000I6q-2d; Fri, 20 Nov 2026 09:00:24 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xUJXk-0002gq-2t; Fri, 20 Nov 2026 09:00:24 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sean Anderson <seanga2@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org, u-boot@ew.tq-group.com,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 1/2] mach-imx: spl_imx_romapi: respect return code of
 spl_load_imx_container
Date: Fri, 20 Nov 2026 09:00:12 +0100
Message-ID: <20261120080017.2762904-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28189/Fri Nov 20 07:29:13 2026)
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The return code is assigned to a variable but never used. Since there is no
usage of the return code and no functionality after the call just return
with the return code of the function.

Fixes: 73c40fcb7367 ("spl: Refactor spl_load_info->read to use units of bytes")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
CI: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13775&view=results
CI has Free disk space warnings: ##[warning]Free disk space on / is lower than 5%; Currently used: 97.56%
CI has errors which I consider to be the following.:
e.g.: ##[error]We stopped hearing from agent Azure Pipelines 5. Verify ...
---
 arch/arm/mach-imx/spl_imx_romapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index d36536e600e..51713b064e3 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -110,7 +110,7 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		spl_load_init(&load, spl_romapi_read_seekable, NULL, pagesize);
-		ret = spl_load_imx_container(spl_image, &load, offset);
+		return spl_load_imx_container(spl_image, &load, offset);
 	} else {
 		/* TODO */
 		puts("Can't support legacy image\n");

base-commit: e6fa1282975af50acf44be7aa678b89e187f0860
-- 
2.53.0

