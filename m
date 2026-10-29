Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A34606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n00g+0rP;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Z/TAhjwm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B48494086D;
	Thu, 29 Oct 2026 00:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlcvO_7UGugE; Thu, 29 Oct 2026 00:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0DBCD404E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793233024;
	b=EeQyJsiy+DAsSegVQhLdlzfHQcES7eBrBNX+kWqQR1VaiGaJwkwkRDsMF4V2/UNdsL1h
	 jY5iLPmyidICyeGjxWd4tE25DtFKryx+mdPAHnE0pOmTXAjhpF6hohAjFTdRblpOgDsTB
	 k5PWfAyiYcumfuDz80kaP+iL69oziUpgrSVD793//ySupdIMdEjmyP2XzSyuHl0IgslVb
	 9tGFCo0+G2J4Mgz/6TJYXCL+UQ4XLKFMWniu2tjAyKPDTi5gG34zhtPGwmHqu73GltCal
	 oW40ZrHijThuXoLflwfRL6EuMkf9QrRMcx7oIkfy805LDZdMLnkEqPK/cKIEYOAl76g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pR6Eoc0gQ2WmvLEOT44A/30B8i+e8lYh3yyqKs2a2dI=;
	b=Uh0YxSj/30XL915f4RI4Y7bbTeiQsDPZmjTf0z/yFYZ48h3lmeHeQK7E2/PYMm8JTWJ1
	 HM9jRN8LAmUg2YMgtbMxnhds8qHQANJ8xMxUj7YOkL1oyt6WDu3snGH8rQqYhB5zayRoZ
	 WtwBincGQG7sIlw2j38e4fNd0MJt1qLDRkZvwqDUNXKadSfdBESlT/9NANAy/vB2R3/iz
	 pJ3BRx/vbWLJ/BNfG2VlupBHRDiDuyNebMyrlmfcXbPxndzFanB9wYPC/uCvO+UjgHgFS
	 X+SDhgKKKUmHxjmc9aPOs9Twb8EFtsxAAX8xmtTepZ+xLFpw95D50YhPBrXbkPt0g8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793233024;
	bh=pR6Eoc0gQ2WmvLEOT44A/30B8i+e8lYh3yyqKs2a2dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n00g+0rP4tD+/HTyGMcG5+MmBna2mybShxvyXOhaT3Z//5+1TFSBEQy78TD9x7kAa
	 yQnpbWcTcpB5NWxtNKnfrJ96Lh26mVHu5LIlDamgr41OVDVTziOu8S9ksNoAhQadN3
	 0cgHkBNFxW1R7nugyfPwfAX9+dsfRHqhHZfsZSCsqzf36tNC8q40JUrafTVgzxPxD+
	 wYe2Dpnl5jHn3TmBQgAXOJ12Soy2+y8gs2JWdFBYiMeDkYJYhWs+0/hW5VgTN/kX3+
	 AblO7odKAd2JgHZvf1E1L46lWa8UadSWveiYLw7FgCjSfKPQ5B1jdCh7/NsFXanvGm
	 iRfOXRRN55Usw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DBCD404E7;
	Thu, 29 Oct 2026 00:17:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 394782E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27F6C60731
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6qhDqD-40hE for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6F3DD606F2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793233020;
 b=KLLX2ksO4HT85ZHIlBWcmySt+L8Kh6ypY3R8t8BmfAtVDGg8HZbpbJphk2ykIbtiDvPU
 WjvYS0KLhkpSGV3Lcp/bSrDvSSgdA4OX5mSb2gLvaONfg0z4WpHUFpqwNwBLx8AnoCb1d
 SCCmssvrSM7+d/MZde8dT3rgT1CATX138ZfzPbn8s8mrbpN5U6U6znPSPKU/QaPFglvZE
 RQCuroEUqAnoicJsIjGqe2M9MLTE9QLJyPACpmWGCv6wNm4EQD6Rv6K2sQOisW9Bfnp8M
 f8zgz4gnwhiDbPFetwYMNxw0+ICQZmZSiLbZtRmRzVJVkU4xA8LUH1412Dg9zpXZ1oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793233020;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=pR6Eoc0gQ2WmvLEOT44A/30B8i+e8lYh3yyqKs2a2dI=;
 b=bnsaKtd2b1mnFzgk3JGYNw60w68sjMEXG4KvDs0iZQ6C2DK2y7PNx2fnseK+oX2Plm2+
 Xb4JjM6blhg6re/avgjmsNbUveRvSNP75GogD2kAXCL0t+38Dxasfj1Y/Pm5i6O1RpHAA
 7e3Mks3wwul1gUrjl/7VSNl8BHe0D58dLildkwiXobEehiyYNe/o84EpqW0eyTtpFjV/9
 lxBTbHowFIrsqciwSKHQffSUj2qE3Mkc+HpFHvmXuEqPDPQUap3qgeZ+xW0zmK0PgkJ+h
 OZcZRMPVoratTspbFeU58UM+CP6X82+JIh/4evKl1yK93b7BKJA3JmiF9gdzGuZyHaw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="Z/TAhjwm"; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=Z/TAhjwm
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F3DD606F2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793233010;
 bh=pR6Eoc0gQ2WmvLEOT44A/30B8i+e8lYh3yyqKs2a2dI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z/TAhjwmdZbW+2U3SYwNUQ6TJ08wQ9ZyjFp4RHeEubD9bSeE6pd+Cid0t6cqN1l8a
 u5WUlkL2fypkZOE/MlmOoI0Gvb2gg3rWgSl44Kz+rHNjBPwTNd+jIExpG9jgMfdbf+
 sdOeQPUdd9nSDPVJLFApzaJtxiZBFyE02kXmWq3fBGLQ+k7NV+gMOts3MVk/Rsj4xX
 cSJKDvptjNuG3HbS1cwXSifJAcz6ka5V2ntWQ48bXbznL5ZrSWeDlmJ8Z2yrRJgRmj
 UMqfefoV6DtGTQkF09jDtV+XbSy21C8fB/JPSUGhzGQA9jOdbp3RrXLQUMIqqd/Hwe
 ne/iLeseYgC3g==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8F3E9B2208A4;
 Thu, 29 Oct 2026 01:16:49 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Cc: E Shattow <e@freeshell.de>
Subject: [DNM PATCH v1 3/7] reduced SpacemiT K3 vendor BSP: add fallback
 fastboot buf addr and size def
Date: Wed, 28 Oct 2026 17:15:51 -0700
Message-ID: <20261029001555.1890775-4-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029001555.1890775-1-e@freeshell.de>
References: <20261029001555.1890775-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do Not Merge

Informational purpose only, to aid mainline development of SpacemiT K3
support.
---
 include/configs/k3.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/configs/k3.h b/include/configs/k3.h
index 7183a4e8fdb8..d3de233b1736 100644
--- a/include/configs/k3.h
+++ b/include/configs/k3.h
@@ -8,6 +8,14 @@
 
 #include <linux/sizes.h>
 
+#ifndef CONFIG_FASTBOOT_BUF_ADDR
+#define CONFIG_FASTBOOT_BUF_ADDR	0x140000000
+#endif
+
+#ifndef CONFIG_FASTBOOT_BUF_SIZE
+#define CONFIG_FASTBOOT_BUF_SIZE	0x20000000
+#endif
+
 #define PHY_ANEG_TIMEOUT		20000
 
 #define SZ_1MB				0x00100000
-- 
2.53.0

