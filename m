Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399B606A32C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=srWKeh1G;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256 header.s=default header.b=g4i0OIot
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D7884057D;
	Wed, 28 Oct 2026 13:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1jOryQTh6ZbQ; Wed, 28 Oct 2026 13:30:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 773F94057E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793194208;
	b=RqsBAr3iz4iTv1l2f5PMrpRLQPfCsWCWOCj+7P1Ol3eLqAAbrPwCGH5KD2RWd8H9UG8S
	 RmMfUBM35+Le6xwvOk7+dDpOYjqz3p/0fCK6XouQeegeYB+lh3jg8mhQY42VaaoMYXVcZ
	 XyyWl0cjJZRTVyiSkLPj5kXZNYEqU+CbkKXLo+1t1ZoviGshEKaTYWU0tXFi4xhLXDCcX
	 6hQc9ih1XRo5/3PcSQZSiu67RfWNdyRhKgxim4m8XJ5o+C0mmxi+s54lHNsMVI91fsTUM
	 yCBMSozHcxNIPN+aWW76dmkmyH9iCB/5pisldCf4q21ELKhl1gfmw2j7oRdsXqYbmWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lp+TWrS539mgR0Dwz2cJnCZGmoMbfdaUu5a8WCEpFOE=;
	b=qPSE+xe/6W6mmThiFve7ScU907zcDWUXnRA8/LYdbBayZ/qlm8OSCoqbXMkAaeqedmla
	 SU7JNlMzlGUp5W/xTmaCcsJ6thgk606VFSWY2L+zPs+qklUsYZs0EbZZ1IGh2gExqGn+a
	 bZvlZHBt7jTzMtVZC/JtABzLJWZYLkTrs+f5nqmEAGlA5GigymLC6KcWDK/79W3knG2Xx
	 x0BrQlEyXRKthEwX8ndrD/2QrtivrevutffkOLfSQLcOV/ByMD3fRH4cknjAzhDoGLoOt
	 9ulprXWQYScO7YRRNRVYnw4lnH5x0COIxLSLRTflSmGtJ3KbsOZ8rmhsVVx8IzSHOHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194208;
	bh=lp+TWrS539mgR0Dwz2cJnCZGmoMbfdaUu5a8WCEpFOE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=srWKeh1GSsDJl70dW3mF1NiK9ASL5tGukcEET/G8h48r4gjgljHDNxm9Ns3bMPOlV
	 Hy92fPQKtz8G9JJA9m40mPuXCaFhIVH+KIaJJ3wtWoCeFf99cxEYILpxiWk3pMISf6
	 EcIQpg2dCJPnH0d/OyNn63kGmKfEC0OH+z4blGNooN6OQ5fNP8NsalnNN3pSiQaKvq
	 zTmgG/DASe+DyIn4Ucb/fld4ONNKcBdLekS18fB5pXUkQ4Khxm20IARtL4Wyp8wxjL
	 as2n9OdGr54J0Q4/x6KnDHaUNQzbGFyQ1K2xDBr4ANKLMcQjKStlPQKjKvXbhkzUVg
	 sCbM05NTllX4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 773F94057E;
	Wed, 28 Oct 2026 13:30:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2775B356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24771605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RP57BulrLFXA for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 13:30:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD584605D1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=46.19.12.180
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793194206;
 b=iJYjEFyLK1J5eaCSvK/Tqq6R2PaeVK73Xne373yo0uJ9IqdJncbrmf0O8l7dqtZItxpR
 KP7VSD8ReoILd0T6p2T1qcJwaDFNdDyY1MAHCCnG3JZ9q369Mmz+GL9GyhF65l89eWWJ6
 m7eCxEuEEn1VU9GSaYC0uTzEEFdu3Hy8UG7EEkza+VUWVmtw2oAr/OL0STmVnI5Ft6iEU
 NGEii3P9lYvQDxZXt+I6W8l9HCIkWHMClrITdIODlCpovvYUxBHbozlVVZLCALgaNAS7E
 LZo0iwpcuVF79yacLJumg1mPerP0/EWE4JLuPW684iANXNJ0LoRhwPaTMvpY/xu4otw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793194206;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
 X-Source-Args:X-Source-Dir;
 bh=lp+TWrS539mgR0Dwz2cJnCZGmoMbfdaUu5a8WCEpFOE=;
 b=gqk6j7I6Rk+F4gm8HN2Gv6HAohPqozEL4wJjw4PgYR9NgXrUvilpqUUEM4in4DW/35PT
 h0feaMxkujDWk4fxDX+UoRR6ygwvmvl5onwP+4UAe4NpzPZxy2HL1ef2ZRar/oQqvoJ7G
 XGEj+xEwGN7BKeV1MyeZ8HHNhLBonB+day+iuvB+2BU9Ll9LPf2VKFCc0yIT/3HQdTwBn
 GIvh6N3zgKWag0ATMTOhGlcYKiHr4nvwcUq3fz+y/jS7JuJOZ7sB5Z6cOFKq1pXFV1GpD
 D0goLKoSCEmOhR0okm0PXchYUSzJJoVfPczBgXVvGrOAOFYuziVwCkhxDy3m+wqqj2w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=norik.com;
 dkim=pass header.d=norik.com header.i=@norik.com header.a=rsa-sha256
 header.s=default header.b=g4i0OIot; 
 arc=none smtp.remote-ip=46.19.12.180
X-Greylist: delayed 1701 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 28 Oct 2026 13:30:05 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256
 header.s=default header.b=g4i0OIot
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.19.12.180;
 helo=cp2.siel.si; envelope-from=primoz.fiser@norik.com; receiver=<UNKNOWN> 
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD584605D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lp+TWrS539mgR0Dwz2cJnCZGmoMbfdaUu5a8WCEpFOE=; b=g4i0OIotJBcsRS2y2H1eB7pLQ1
 uJ7bt6TJZk8g3naFcmeuGul/G2a2VnuVbf8rFjY7FdRe/Xe/heAKPrWDJWT4rYOm0+1h63qBqogJ4
 zHZo/jznUem21y/XmVQzjGlEAuGkhwOEnCe/xsL/YJNshJ0f29l6128uYIRPSO+MrvhwO9zvfvKG/
 PKm7fYYe+UAcnVkO25dt285n2XAqF4yKvQFNHIKEv5xN/7tsVzRO15MWpnSIVCRjaX4GMukHaM0MT
 ZXRBeA8MzcpRzZwomONTTAwCVtXKTGfy72pfpUp6qx50RNAo5MkZLuKJ0I6PDeOmt+YKfEJipe4Dc
 UripVWqw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:40338
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <primoz.fiser@norik.com>)
 id 1xM3Hk-00000001mAt-0xbn; Wed, 28 Oct 2026 14:01:42 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com
Cc: u-boot@lists.u-boot-project.org,
	upstream@lists.phytec.de
Subject: [PATCH] imx8m: soc: Disable OP-TEE CAAM job ring in kernel device-tree
Date: Wed, 28 Oct 2026 14:01:41 +0100
Message-Id: <20261028130141.2587765-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

On i.MX8M, OP-TEE reserves CAAM job ring 2 for the secure world (its
CAAM driver forces CFG_JR_INDEX=2 for all i.MX8M variants).

As a result, the ring stays enabled in the device-tree handed to Linux.
The kernel then tries to reset a ring it has no access to and logs:

  caam_jr 30903000.jr: failed to flush job ring 1
  caam_jr 30903000.jr: probe with driver caam_jr failed with error -5

Function ft_add_optee_node() already detects a running OP-TEE and adds
its node and reserved memory. Disable job ring 2 there as well, so the
OS only sees the job rings it can actually use. The node path is the
same on NXP i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/mach-imx/imx8m/soc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 909bd7476db3..29c0216aca2f 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1234,6 +1234,10 @@ static int cleanup_nodes_for_efi(void *blob)
 #define OPTEE_SHM_SIZE 0x00400000
 static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 {
+	/* CAAM job ring reserved by OP-TEE on i.MX8M (CFG_JR_INDEX = 2) */
+	static const char * const optee_jr_path[] = {
+		"/soc@0/bus@30800000/crypto@30900000/jr@3000",
+	};
 	struct fdt_memory carveout;
 	const char *path, *subpath;
 	phys_addr_t optee_start;
@@ -1305,7 +1309,11 @@ static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 		return ret;
 	}
 
-	return 0;
+	/*
+	 * OP-TEE uses this job ring from the secure world. Disable it so
+	 * the OS does not try to probe a ring it cannot access.
+	 */
+	return disable_fdt_nodes(fdt, optee_jr_path, ARRAY_SIZE(optee_jr_path));
 }
 
 int ft_system_setup(void *blob, struct bd_info *bd)
-- 
2.34.1

