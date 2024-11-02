Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501D2E677F5
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 10:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D899889A2;
	Sat,  2 Nov 2024 11:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ccBybCA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C70868899C; Sat,  2 Nov 2024 11:50:04 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5B588FEA
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 11:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BAFE13F1A8; 
 Sat,  2 Nov 2024 10:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730544079;
 bh=yNhSu/IDubKjDlCGuhuZOsE19RRQSJk3RFy4CFcX8RE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ccBybCA/7rW2E5C3owdpkbntk43XdWp9LlNEhL4XgWzF6Xnv2CVxL4/mZXNt70tHu
 M3kV0rlOdc91rQEBBJAOLReEwhwzAUJV2kJVU6xwRfky5ENrFfX4tYd7+lRMquz+wN
 7RVY5zFmHTuTMygLNMqewmseJonaapmscZYRg6l++jscuY0iDEtElp1/ESvUXdC9I8
 z2dH70pecfTzHh7Nz13QJuwV+7uq7UVTiinGqfNi+kTWAqLyckPAEv3cga3ueFD3YA
 CBEuoJmdPv5ISailoEvqMCjkgWkH9Mm4SQsjaRi/dFBBLHJKOi0CtCeyyQ2+/5IV/T
 1i2c4VCZw+DWQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] xyz-modem: Add missing fallthrough annotation
Date: Sat,  2 Nov 2024 11:41:12 +0100
Message-ID: <20241102104112.110838-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Falltroughs in switch statements should be explicit.

Addresses-Coverity-ID: 131162 Missing break in switch
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/xyzModem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/xyzModem.c b/common/xyzModem.c
index 09f74a1f0c7..698a538a148 100644
--- a/common/xyzModem.c
+++ b/common/xyzModem.c
@@ -280,6 +280,7 @@ xyzModem_get_hdr (void)
 	    {
 	    case SOH:
 	      xyz.total_SOH++;
+	      fallthrough;
 	    case STX:
 	      if (c == STX)
 		xyz.total_STX++;
-- 
2.45.2

