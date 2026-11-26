Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E6606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LyZwjPXt;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=KjhFp/gc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B329E408BC;
	Thu, 26 Nov 2026 12:24:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MgegXsHHFdEW; Thu, 26 Nov 2026 12:24:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8EEC4086F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695878;
	b=QdY/FF2vKjQvqoBeX9pNbYndvXgqW6mtn4IQ6g2pZITbS1LJETIYcQJa5rmWhhYHsWoS
	 eD4zDMlRA4NDHQ1DJ/c0Ux0O5Tbo0jsMKgv/HgFHpn9rJkjfraiWfua5NmfMl46Y6+Xb6
	 0CR2pB/dGrrYB5iAOOtgXszimrSkTqLo48LrAgKsWQCPAgHG7lb6VCxKWHh39haOuhhRw
	 umCCo7CkD4w55rcjeSCegmHldgJJ+soiW8WU/V24+qWF5a2N2dDItDiri185t643Wgtjc
	 YAoycS+8l9rCZ+N/7PuUSrC047OTOSyEGmHd9pOUxRv+JOn3K7JbYJmM0W/8EsFcgdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EuFoLsMYDCMDHbY7vuVkLo1ZbTaeOPHSAjpn7rOfA60=;
	b=O0sSYMtK+rpLFpHbofGs4HZCHBhSbamjQxTZ/stB5UID7mg567SnXPtirVAmZQbgQ1go
	 VKvm85GTTW/Ar0hQKT3BwHXhthuSIKgEX2zyTNXCJbwFnhVPEGEr9mlD31KUpXLWjLDr4
	 yrOOKrLbJgk9P3xrGfS3NHdwRF1mVJ9qgzH5Z8HuaqS7Y6movMJtzdVZHM9RLIl+1pMVE
	 P4ucjpkf3kJ+79QAmVo9AXimZpPbKXzoUNIY7WP36HCzFxaG/3MTYjcVeM5FchkIICDjK
	 k5mNhbkAxQ/3U4xj0jQZOPxYsd4+Y8rAFWeSs6luQdflJUqIzpF2+xMnbkXuQajKlkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695877;
	bh=EuFoLsMYDCMDHbY7vuVkLo1ZbTaeOPHSAjpn7rOfA60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LyZwjPXtnc3EfYAsVHK5lrMZXMLWvraot99TGmqfvJouFzWuQKAA0CgypfUKQVpD5
	 NFa76bCRE2UsIwyv8lOhaX9Pal2sD8fjzMYRDj2iH/2RmDnYMpRke9XHhMMb9XX/kl
	 yAdR58TMA4JwENEh5snQfub7NZTHBZ91m2keeIaFao478QeCZEIdjPYrYoeVYfFrUQ
	 WVN5zR+ixl2S++MwRG5D7dG4IJfjQk24plvPAOQ8nZrPK6xn99lIZCpefnWUCHrFOm
	 4Uo1vAxBbktB0OLI0h5R79aCiAc2n2SYT5qU4Y+fMzhM4KsnRWPWVjZv8K9aXBLjFM
	 8mQHE2ySF73Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8EEC4086F;
	Thu, 26 Nov 2026 12:24:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71DD42DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6307840474
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4DJR4L_XCO3 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:24:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3895A40116
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=KjhFp/gc
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3895A40116
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EuFoLsMYDCMDHbY7vuVkLo1ZbTaeOPHSAjpn7rOfA60=; b=KjhFp/gc8sLso3b3jk9iJk31fB
 vYXi3qi17YPd6mU7jmqyCKsnuYIMjNcTOfzELbhy+fIBiuKYbwlp10SUvIbh5WK2pjs8R9wdSsabm
 6Ee77qH27faStO4HoDuo5crYecztmR0RwM6RkpSe9Dv3Bt3mGnHaQD/cuYPlelvqQC9SAK2C/n/sA
 9Vf3uui/I5abYvpUWKM4ovQ9Rvdlc7Iy//IyEhtCOrXuhFLKHJIrKvS+C71amDHE/+9wkRBoN8pdf
 lknN72Gf7u//QkwrtEwHaM8LOjMzh+CZcyPf+3VHqu0tu8Ms8Vln/mOT1cSz7WMVfr5Rhp3J6LjJN
 BeuAe+tg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWe-000IB6-31; Thu, 26 Nov 2026 13:24:32 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWd-0003gJ-2h; Thu, 26 Nov 2026 13:24:32 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 1/7] regulator: anatop: fix probe without vin-supply
Date: Thu, 26 Nov 2026 13:23:53 +0100
Message-ID: <76557d034fc3a7eeea37d9ce84fde1d0100adf63.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
References: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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

