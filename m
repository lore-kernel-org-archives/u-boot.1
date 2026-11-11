Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45AE606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LkTxlzMC;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=MT6YkVzB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4C674086E;
	Wed, 11 Nov 2026 10:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6t3lREIDOYK0; Wed, 11 Nov 2026 10:13:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD51540856
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392010;
	b=qTqAsScTKHIdLbp3eUzxuAO59UnN5VrA2om6AI8sQX9J3nZbv6KGFNrLqHQ8s9so46VG
	 42/TYi88vDqMDb+4IeEZYhgkrjFM/UjuOwT9iboDMxzjGhA+4FkmlSTwK4Z9Fi5u9H1X+
	 5xtGEOfl2PQ1AsSs2lsWT4+kKw/UX8AG9EFQutucJGbgVlzaaJUd9GdwGmSxiM4LxXKzt
	 29lFIlb+fe95pPQjHcxhQxXHV0AbnrJelwbAiZfy+y5ukFAbosTk0v8uiDN34Z4vzj6D/
	 NBZTcIyI2R6bhYIbu6Qn3WIP0yi0Of5WgZn00Qd5txZlBRsinarcFAbf4GCqC4Cvs0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392010;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EuFoLsMYDCMDHbY7vuVkLo1ZbTaeOPHSAjpn7rOfA60=;
	b=UG1H0n3ddIqPUdBNUbvyCv/d3SfWvocxpcj/ZKI30G7AuG2dhShOkgYrJPfGQxbEoCPL
	 yPj3nx5pToG2DcucLji6aKdGEPqs2S9NmDgAQQ626wH9mba+49Sv726Hp7byBftG+T0nU
	 eFjBC4WxNevQAm0anSiLBv8uCyRw16HDXyBYxH1fSE0WL5TMCr61smZl9x/W+89nBa4kQ
	 oAPNdmLD8zrGR40n0sb04/QTYkG8vAbJ3QRVCn58bn65T6fGsMUGVhXvYrI9Co9AkYBiY
	 2oa+FQ89FHX6jwUKyApaU0s1QRo2elxfFWtAMt2xj0ELUSS4IWP8n9Pb7ZluI/8bUJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392009;
	bh=EuFoLsMYDCMDHbY7vuVkLo1ZbTaeOPHSAjpn7rOfA60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LkTxlzMCF8kft0K7UBvP3ycq458foilCeKG7cOEYUjari1cdRpX76Kxx1twzpz3DI
	 z3zQi1gN7mHY0yS6EoqDQ6SHrB2N9Fp/OA++L726xnSxdt9P/KHDXG31MbAeylxGTf
	 xf0w4Ij79QXVA5AH3i2WUPwwA2w4v3zyURyHqG1XtAunyR1bYc79mGQeOjzP7mU5cx
	 lt0Yi8uW3Dv2dKAkofH8+evDh6NI6fBdR8lRV34P0damYM5sDTnov5k68wbfEASE9a
	 66yS0Bfewfa1zdFu7X/7KlkiR8e1qh1gFoPyzFsTx9glkgcKNa4jentbq+VEzMNi6+
	 8ezsW6buio6ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD51540856;
	Wed, 11 Nov 2026 10:13:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B9AE31A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB23A60784
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1WMOs3FvTIpu for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:13:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E53E606C9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=MT6YkVzB
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E53E606C9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EuFoLsMYDCMDHbY7vuVkLo1ZbTaeOPHSAjpn7rOfA60=; b=MT6YkVzBChP4mtZkNDh90LyGiy
 M+BVR0F2Nl1z3ZI6xpspos6RYlCmkn7kkSisT2Gh7oFdDngelWpY1TOATV/c/hiVTkUCgITevon39
 Zx2c/z0B2mbrvYJFw9F8EHGbqFGID/yNAN4vJKlZ3yUsNK3/FThkxDJXrmArtKdTfLy5+6ZX7n9uQ
 j3xoei/FwmxJyJRvhC/kGk+VLiR5PFhXwYqQk2tcsYz3Ap6/lnmvbRQ4cTt0GJwvifsOI4MGcZt+A
 GmjxTMCGKylw1Bdw1tRZHoRa7XnXLZo/ppA2Caal1bLZy7wt3EYhW8w8jxlm4XxX+4OOZ70kHZKIR
 BErfj56Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KV-0004wX-12; Wed, 11 Nov 2026 11:13:23 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KV-000Lq2-1m; Wed, 11 Nov 2026 11:13:22 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/7] regulator: anatop: fix probe without vin-supply
Date: Wed, 11 Nov 2026 11:12:52 +0100
Message-ID: <be14ca0607d52bd18d3c2c217acfef12e00480de.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
References: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)
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

device_get_supply_regulator() returns -ENOENT, not -ENODEV when no
supply exists. This fixes the probe on i.MX7D.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/regulator/anatop_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/anatop_regulator.c b/drivers/power/regulator/anatop_regulator.c
index 88570a1f624..68a320bd0f8 100644
--- a/drivers/power/regulator/anatop_regulator.c
+++ b/drivers/power/regulator/anatop_regulator.c
@@ -176,7 +176,7 @@ static int anatop_regulator_probe(struct udevice *dev)
 
 	ret = device_get_supply_regulator(dev, "vin-supply",
 					  &anatop_reg->supply);
-	if (ret != -ENODEV) {
+	if (ret != -ENOENT) {
 		if (ret)
 			return log_msg_ret("get vin-supply", ret);
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

