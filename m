Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037ED606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R5aDi1SV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D589D40B3C;
	Sat, 31 Oct 2026 11:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gmtYC97sdV8s; Sat, 31 Oct 2026 11:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 292F540AD3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445104;
	b=tRNtlvfNErG/MzjeGkWSbV8bQbxUDb2PjnOASBZgFSCPCznjNMzS0zoymDiZuMOsaSIu
	 VEALLvR4YAvZLSexOM8OonPdTK/YEEZj8g3ZOVRqkZExEVHqsjRhvOIqI6++i/lS5+dB1
	 TnmoepgtlE2g02dYzelIgvV0qR6qQFYkshoXZvXzYQ4ss32ARlOvUWbkx1tLz/K9NWc1q
	 722M0dUoFWW6vhxJ8hbw5Wv73ykvvdcBqTmYeEQr1KBFZbhoo68mws7pRYTXNBM38iKC/
	 9GAfVgyP45t5AINYc5D0CBCDedas/FBO7ZlkauabXDPZyzowtUlFccEFZozzu400mlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2yTmvkvfLw/XyDybjOsIuSUI5Fjx0tnWrNfOJ0BOrlk=;
	b=SLjh8u6e3Js3vfJuKMoX8snzdU+C4wMVSu5b363exFoAbq273Tv3pEVtXWGmRBGEGN5c
	 YxPIBRZ30GFlhlKi36YnE4Sj6GRT8rOOEhER6StxNoPARYe4nUwBH0FmgZTJ4jKJlSInc
	 LHaQDZA2HqXkNZTC8PYOpa6CB7kfr+RAHRaxUWF0GQRsFRfcva5Okl+xmGJY4uDfRJrHj
	 pVJnnZcF13ENSGx3RklrHC1/9OslkGST3eR9php8Tv/IjPOEAfkkbId1T5YY85RANA+gf
	 69KGcPFkROgTcNwfq3UP5s8dkrqx3cF5MZpRIENWgn1fgpvJsSvz9qCp37a16C/Rr5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445104;
	bh=2yTmvkvfLw/XyDybjOsIuSUI5Fjx0tnWrNfOJ0BOrlk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5aDi1SVFF+cCJ6Mcxj9E5rSQgVNTI/QRr0nXXJ3H+H58JWWmESgb21OuVULS/rJ0
	 gYi+IH7l2QlE1XJRl+lr4Z5XQeiUzLRlLj8s/Bb4F0vhzydou0aP/H26vTvoHTJII0
	 /Xll2E6fwhlzrKw8NWJPwsOkW0c+FFX4CAYumR/2ylK+RlRS0j/sejSBNm1JeoxBmQ
	 z46xnJrwjz8qb7G7cum+9PZt3/EVz9mwK+ryv9tx1v0lxZb4hk0Pi3aHU1nZpca24K
	 SMwwJKjYEP2m0NRcxB2Q5AZrARDqItYxy7AzT9dLD35YQACGuS6QZE79ZmOuvwwh32
	 o0E7eE3RDrVmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 292F540AD3;
	Sat, 31 Oct 2026 11:11:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 118D94BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F27940057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TA0yjqk0dpe0 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:11:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5F9C34004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445102;
 b=e8gT6CbL+/wD3EhGLefPSsHDyhiYr2cElxDQ4688OCqWqp1qXRFix1Djc67tRG/D6zO2
 aBMfNaS+txvd2qwuwC1x4sX9ZvHjtoOfx9y1xg9eWzUfOcKtr8UmHgm2eVaNezGPFMyfg
 Snw52BwNBV5CcKZbrrfH0WXJeepI/OX+UXwDm4nTbyPTT7uEx1yJbGh4eTJqN4aHsKZ/5
 dlu8om67Ms7gFGyn9F57/wuDQk6mn8Ml7xy6q9xRgEgjjwRnRZ2cNwiKqteSjVrmafjCI
 Ib3GJCILp+93RSVghM60wRJp6BmVa/m/QqWjcPC+erXSIbY7AdnfBUNMKD/n6gYS0Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445102;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=2yTmvkvfLw/XyDybjOsIuSUI5Fjx0tnWrNfOJ0BOrlk=;
 b=kBAcUlK7DEp31mx9UkGDHEbJHKSysDSk+H3qJxQSghGUMFa5NiqMJjCFpi/ZtldtU4zR
 T7uIF8Cq8SqhhPbj0KQlXF5jcy81I/GLXu+ObI3QpqUL8b/58Fj49E1oRqwN1gl6GJNW/
 3egoJCIxEkraVulXMgsqPgKPl+D1N9T6yGpftz7cSMIksPgkrybT9GMyrRMnr0g1jDBre
 ITuUNJJWONK/BI7auMSU/4Qhok52wrWlH3u7aSMto4Gf+hyG+EVOBrv5GxdrhVli4/mv0
 Sfh3CcOs+Zjf+Oj1FejAJY1AnLsgfEEGToxNUapR+9UxH4ZiqnnxhcYfq/vXgTd9Syw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F9C34004D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:42 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6wi-000000003QM-42FK;
 Sat, 31 Oct 2026 11:11:38 +0000
Date: Sat, 31 Oct 2026 11:11:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 08/11] boot: bootm: set the imagemap from bootm_start()
Message-ID: <4a01c45471158b23cd8b225391524e271af464ff.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bootm_run_states() puts the imagemap back into the global images struct
after bootm_start() has zeroed it, which leaves the invariant split
across two functions: any later state that calls bootm_start() again
drops the pointer, and BOOTM_STATE_RESTART is already close to doing so.

Pass the imagemap to bootm_start() and let it set the field while it
initialises the rest of the struct.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v1.
v2: No changes since v1.

 boot/bootm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index b9aa83c3328..67df647d176 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -275,7 +275,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	return 0;
 }
 
-static int bootm_start(void)
+static int bootm_start(struct udevice *imagemap)
 {
 	/*
 	 * Free dm-verity allocations from a prior boot attempt before
@@ -286,6 +286,7 @@ static int bootm_start(void)
 	fit_verity_free(&images);
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
+	images.imagemap = imagemap;
 
 	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_START, "bootm_start");
 	images.state = BOOTM_STATE_START;
@@ -1198,15 +1199,8 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	 * Work through the states and see how far we get. We stop on
 	 * any error.
 	 */
-	if (states & BOOTM_STATE_START) {
-		ret = bootm_start();
-		/*
-		 * bootm_start() zeroes the global images struct. Restore
-		 * the loader pointer so the storage-backed path works.
-		 */
-		if (IS_ENABLED(CONFIG_IMAGEMAP) && bmi->imagemap)
-			images->imagemap = bmi->imagemap;
-	}
+	if (states & BOOTM_STATE_START)
+		ret = bootm_start(bmi->imagemap);
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD)) {
 		/* Pre-load verification is not applicable to storage boot */
-- 
2.56.0
