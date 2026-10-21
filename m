Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A945606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uxnymDlO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2963D811C8;
	Wed, 21 Oct 2026 14:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTy187eqDjbL; Wed, 21 Oct 2026 14:10:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F903811A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591801;
	b=dfUeUMZ/gTThkq/94IPS69i17/D5S4Pt5JnsPxU/tTl71t/dDdXeT4I/xreeCVRAMVXm
	 sLm3YsMqpS5B3la4o0JWuLTg4+2bAbxVqDOX05QvqTB5pnnX5zgB4u0m4M3Us5JQnaonJ
	 w21ROqldtfBh6wnusqYUVl0r1ORWT9fFj1BfIUfOjo5atQl8IOEwmHdaR/497feBuFgDm
	 2H3whFLNsjlgYLWJcK49dWpHrI1gUlgDA2qDx5X8E+bvGK+oDhXYcwp/dIaY4so9gtfqp
	 NO9LStBZC587foN3YbxdNENTOnmlbW14fAXzrsgLlHkYC9OVHEwfbUfUf67si1cvJ9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591801;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CfBWkEVI0opY+I5gUk90ekV4HRmar1vCY2xkNNdxIe8=;
	b=hZD7idQLtvmW+/gzMI4jbtMuUrKOeAbOrDYjNknp7MkAWcuaoetRSRO8+Mv34sA0iT4e
	 ss6M2UhWgJCwG1g/LYuJNrUqJ324WA0BCcVSwO4ALiueykmQS5c4WL6usGa44350ZDZwx
	 VPJxb+DcgveupuwoFHoSHzfC+GUVMaS7IoJJUyY581m7JoenuaPHbaAeOwP1PfWRDvGOZ
	 zM/H1sz9r8dKGeS0ZPRPuWXca2aL4BYZyQo3Ch0a+G7u8HcJHiRzHaQy2l8Qd7MMI1j2T
	 nM6G4ZM6gsZ+Yl9iZ+xhKr6/dcLcCjWo6p4lOJwu/EPdd4+8Hz5xpaLbynhruaUQZmQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591801;
	bh=CfBWkEVI0opY+I5gUk90ekV4HRmar1vCY2xkNNdxIe8=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uxnymDlOBuw3lozjO86Zxftq2/tWHVF3SeZQsHAvVHdG57fLO2th2mBtEYkosH3JC
	 WXYWoenBU7G0kUZw6xraum7pL0G6La4QWdPDIT/8g9p/WurRVmlRUqIQcBHcaJqsVa
	 U/eY6ILP871bGqIwURi5TZr+ngp+9LaWDoiH5pVpZA6coVwy5WE2lcABlGTpUYych4
	 JIc4nJL3iU946fbXOdw+WsCZOCA1syMPEaG4NxvQ2qS7DqqvEyXkJe1FHygdgDliql
	 HZEgrAzZOYYk0BI11NwNx733UfkKJDXFcw0ifodGp+fNr2x9mhQddDnlEvafBKH5bU
	 JykhBZkna4W/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F903811A8;
	Wed, 21 Oct 2026 14:10:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EF733AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 114CC6083B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TV0A5-JxWkNI for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CAFF6069C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591799;
 b=Im9Je6bEJ7tEg7bu4vuSKzfEVrjYEff3tS61zqp0XnJLT6ufXE0/Lomb0zy5YYqi62Ct
 lmVVR6tFoZZoFXRFlL+u9OwZ9c/3jgbvu0tCnR/rEqA9zFS+LqBQx1RYsNn8U3QBXZGkZ
 eFzR9Tgzven65s42CuE1NpiIh1AXdyRjKxi52m26Jnup3jzWRJKksXj1dLTjnZSFXh9ag
 OVDPNDJ5TaTTepKwih4V3eYVNldcHEi1Afp7gTQXmpz1KU55LLVzsxyXXimNb+ZMw+yAD
 jIOLtYkA1tvQqe6/X96j6qjbR5QjnBnCY0aLUaQn5AhQ43jD8jiBOTeFuR1ZFaI523Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591799;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=CfBWkEVI0opY+I5gUk90ekV4HRmar1vCY2xkNNdxIe8=;
 b=iU4T9fHtiuibKAouXoCyV2xYQQ1pKZnQpYn5AnCQWvTqHSFiWJSYsLFDOyMWroI+wnTI
 3i8hi6RuC0i8hrWXc2aNy3g4IB8EVARD1xF9aGTEhUxXsxToxYvyrxHdEAlGBBwgNH1pf
 3wfPiBIx5RUtkG4CKRjTnxXPZeNZEn7JdHuXXjhGjfwYB/5vD+A8xOUoO0ko/ZWnekHY6
 Lh1VF1up1SvL6ExZmIxOxAjMvdcDcXLHyPgZlE1DnhIWD1AYZ1yaTiDW3a8SqUDsrK9Dk
 kEGwB420cakaY7ArHXMP1EuZsIA36nL525cPINwZPMAFayTxfHERcYYQYo2WQpr7Bbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CAFF6069C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:58 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWxm-0000000027Z-06Sp;
 Wed, 21 Oct 2026 14:09:55 +0000
Date: Wed, 21 Oct 2026 15:09:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 08/11] boot: bootm: set the imagemap from bootm_start()
Message-ID: <2c89e50387b52b84f5de4153b3c7ac319e50fd93.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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
