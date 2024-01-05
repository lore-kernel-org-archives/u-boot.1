Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6125C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 14:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FAB876A4;
	Fri,  5 Jan 2024 15:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="TNILhhGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E67E9879A3; Fri,  5 Jan 2024 15:08:19 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36642876A4
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 15:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6C251A13E7;
 Fri,  5 Jan 2024 15:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:message-id:mime-version:reply-to:subject:subject:to
 :to; s=mail; bh=83lknXScKBm5GKBkK9SQczlEnEH5NBayBgmofTU9OWQ=; b=
 TNILhhGEOi275dkT1YpWxztZw12it2+526oMtFZY/n+cEPepUYVnWRVPVLCXQHCl
 fSo+NEql1IJ2A3Q/eOaNAdpgDAlxO4e4GquWq43tklN/4qLQgmXY2fqI9SPJkT8J
 xrx25DuLP7QZWs3Wgsb+vBBP4cAVwc4GlnHa5Qfct+CVrpVGBUO75+mvdgN7HVCW
 a2nWJdNmGn38PdzpqIn7gpXktB1LAjC7RfEwjPa5Uauj8qQV2EQB4+xsV//0VG+c
 ngmK+1TkkmGeYUUsMNByCEKQBzkgsqHFUhooGhnYrWDrJA2e/UL2d292zIBDDji4
 Y+PYXjH5DttG0KZRw/QEuYNNjE6PLsYAjqu3wNne8PqWLQCH62t+3AhzaasJwuQL
 ckwdkj36j/P4I1OHRfLZL2W6R7b+0i4R6ZmogM2c32/WkQuI5+8Z0K+sPGoSR2mm
 jPXeo4HTYW5R89ga8k6KEjrIdpF7Z1ZB/1K1ESrUvSQW6lLaClY12VWyu+Af2NDw
 2MhDsLHa2n7GLfcTPXG1FROgDj0ZWAPN/jrKZBcnc/P2xFfDBg8+Ua8ejafhuj5w
 ZjUFm+L64xzPsnNtyTO3Ob4wAFGFC3ieK+16xBJwVGSIyvwQERzgFDY080NuzEGM
 qhcsaqQDHXzY1/9eQ4PK/fKpzh4rqUW7auxKrBc2SR8=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ayoub Zaki <ayoub.zaki@embetrix.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH 1/2] lib: rsa: Fix PKCS11 URI if one is not given in `keydir`
Date: Fri, 5 Jan 2024 15:08:03 +0100
Message-ID: <20240105140804.14383-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK; S=0; OP=CALC; TIME=1704463695; VERSION=7966; MC=67882654;
 ID=385189; TRN=0; CRV=0; IPC=; SP=0; SIPS=0; PI=3; F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE703B55657D66
X-Mailman-Approved-At: Fri, 05 Jan 2024 15:09:19 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

If `keydir` is not present, we need to build a PKCS11 URI
from just the key name. In this case, we *do* need 'pkcs11:'

Fixes: ece85cc020 rsa: use pkcs11 uri as defined in rfc7512

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---
 lib/rsa/rsa-sign.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 858ad92a6f..fd587d8deb 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -124,7 +124,7 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 					 keydir, name);
 		else
 			snprintf(key_id, sizeof(key_id),
-				 "object=%s;type=public",
+				 "pkcs11:object=%s;type=public",
 				 name);
 	} else if (engine_id) {
 		if (keydir)
@@ -246,7 +246,7 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 					 keydir, name);
 		else
 			snprintf(key_id, sizeof(key_id),
-				 "object=%s;type=private",
+				 "pkcs11:object=%s;type=private",
 				 name);
 	} else if (engine_id) {
 		if (keydir && name)
-- 
2.25.1


