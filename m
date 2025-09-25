Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C897CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722EC834E1;
	Thu, 25 Sep 2025 22:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e3AP4TEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A6E8344E; Thu, 25 Sep 2025 22:44:22 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B17C809A5
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-74382048b8cso1085207a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833059; x=1759437859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xADgeMnax0mNmaOeCGD1T4UqhUfwTS+8Wmrukghg89A=;
 b=e3AP4TEvhIiqA721JW4krojY3LM0SHm1li10CWxRQR8274UXhWUQPDUAQAhip37PCP
 coLY3sgd2ddO/ljjBLInkkUn95MN26gGqRLl8VNZiF/s/ziPjh/WRoXqm5OUS4wmoPcx
 30KjCfaCr7qYSoR4uZhtGYXhaJTdchqNMezGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833059; x=1759437859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xADgeMnax0mNmaOeCGD1T4UqhUfwTS+8Wmrukghg89A=;
 b=d+XtiDoNcQ66bR4669oe2WRG5sGH70mMVhMC1gfQPBii8K/NBr0rMORCSnLfQetFPr
 JDl3XhYZfmWEsEEcJ5MncPqqnRh0f/aokfuZQeK8uiBG/q+qionTo4AqmNFVDvtHKU5e
 afxm3akDyYGFpcxdGIOWc0sTCDJE6Xk83XmyA1uTTvjwSYCVTRZg9N3ZT5SHgNRK1Eb0
 J+rb0m7JSzknfByj/u5CItGo57M61iLCMGj09AplRYQZZHdND/4IJdJdYr/lCImdxT3D
 TAwUGksHquQO5GmfahjbjNWusvAjSBj1YiJ17tE3gupTUuULV2D04B042ubEKg0T+Dou
 4TLw==
X-Gm-Message-State: AOJu0YxHykBXoy8JXtAZskKPqBWwkQa2XFlcjmAnPGdMdLzkWf5FoRVc
 fr8PecAAxn0FKArgohGPhauwqDi82Q53cU07qAOS8pWMw5jyFMyd+qAjDrXYWSdKj+r9fPkoT3y
 2bmnK5o8=
X-Gm-Gg: ASbGncsn2osnC89z2+u+Ky2dZVZyT/lfRgB/2ka1B/tWJeKZikUikV3QiS2krzYYX+E
 3o8ErN71JGA6cqgX1I8JTOw9ki4/14FdhWs3DmZJ3LmOfC0uRcex3chDzdxsxg7uN3w8xjzYy6L
 m3LWGsL2xB5yVjeDZ+nSQmVGAOFStAz5VFM7hz3LMKvb70DoSZU5EebbEz20Z2c6noyOoKUyhbB
 DB48kIPeyRKdJzFO/tu6sDwml2KG9kB993Fdkgn2jwl3HCDPkoncSGh2qe4mO7fkHtmjNLKc9hM
 3ElQW+tmsa70VSmhkTGO0ZsRYvYWNUmGvb99ciGbjic6iYxYCiOM/P5Bh7AfOZqq42jjEOps2zE
 pHh73IJlBDOG4APpCIeWqOiPyilMb6jGbaIfMmnjhVuaY5mGjGF6fMcLJlKY=
X-Google-Smtp-Source: AGHT+IGOfRCRng1b0pTl1SEiGwKNdYFZuH1LNe//pJq0OFEktlcpiiC1vKEdA8Xbou5roaTVQlmnFA==
X-Received: by 2002:a05:6830:8216:b0:749:921c:5826 with SMTP id
 46e09a7af769-7a80020bcb8mr204849a34.16.1758833058891; 
 Thu, 25 Sep 2025 13:44:18 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193d01bsm605790a34.8.2025.09.25.13.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:44:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 3/4] net: Remove BOOTP_VENDOREX support
Date: Thu, 25 Sep 2025 14:44:13 -0600
Message-ID: <20250925204414.3561033-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925204414.3561033-1-trini@konsulko.com>
References: <20250925204414.3561033-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It has been over a decade since we had a platform that implemented the
bootp vendor extension support hook. Remove this option due to lack of
use.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig |  4 ----
 net/bootp.c | 13 -------------
 net/bootp.h |  4 ----
 3 files changed, 21 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 29de857ba7c2..d4f34f4bc290 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1890,10 +1890,6 @@ config BOOTP_BOOTPATH
 	  Even though the config is called BOOTP_BOOTPATH, it stores the
 	  path in the variable 'rootpath'.
 
-config BOOTP_VENDOREX
-	bool "Support vendor extensions from BOOTP/DHCP server"
-	depends on CMD_BOOTP
-
 config BOOTP_BOOTFILESIZE
 	bool "Request & store 'bootfilesize' from BOOTP/DHCP server"
 	depends on CMD_BOOTP
diff --git a/net/bootp.c b/net/bootp.c
index 19e7453daed1..a28d11cb3683 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -491,9 +491,6 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
 #endif
 	int clientarch = -1;
 
-#if defined(CONFIG_BOOTP_VENDOREX)
-	u8 *x;
-#endif
 #if defined(CONFIG_BOOTP_SEND_HOSTNAME)
 	char *hostname;
 #endif
@@ -584,12 +581,6 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
 
 	e = add_vci(e);
 
-#if defined(CONFIG_BOOTP_VENDOREX)
-	x = dhcp_vendorex_prep(e);
-	if (x)
-		return x - start;
-#endif
-
 	*e++ = 55;		/* Parameter Request List */
 	 cnt = e++;		/* Pointer to count of requested items */
 	*cnt = 0;
@@ -977,10 +968,6 @@ static void dhcp_process_options(uchar *popt, uchar *end)
 			}
 			break;
 		default:
-#if defined(CONFIG_BOOTP_VENDOREX)
-			if (dhcp_vendorex_proc(popt))
-				break;
-#endif
 			printf("*** Unhandled DHCP Option in OFFER/ACK:"
 			       " %d\n", *popt);
 			break;
diff --git a/net/bootp.h b/net/bootp.h
index 47c743479e73..14f5af68e150 100644
--- a/net/bootp.h
+++ b/net/bootp.h
@@ -24,10 +24,6 @@
 #if defined(CONFIG_CMD_DHCP)
 /* Minimum DHCP Options size per RFC2131 - results in 576 byte pkt */
 #define OPT_FIELD_SIZE 312
-#if defined(CONFIG_BOOTP_VENDOREX)
-extern u8 *dhcp_vendorex_prep(u8 *e); /*rtn new e after add own opts. */
-extern u8 *dhcp_vendorex_proc(u8 *e); /*rtn next e if mine,else NULL  */
-#endif
 #else
 #define OPT_FIELD_SIZE 64
 #endif
-- 
2.43.0

