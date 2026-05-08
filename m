Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75315CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A82484C7B;
	Fri,  8 May 2026 10:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JAzNwGW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27C884C1A; Fri,  8 May 2026 10:48:56 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E809F84C45
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=4uKtOFS/r/mMO6wjlqJjEtaRjnLVwiuVRkwzXsqESvI=; b=JAzNwGW3My40jisATnunrNiTbC
 CJvQ2SvwMj/ElRzvF2T0WJo39rPP7GYSsouXCcAk4FhQ4UwBnyGzP0fXsNZrMdOo3SEwcmCET02LH
 aZbEKeSiKIqnhnz9mWGQk4aoNpq4R1AAAkljY/etxIvwnv9ppFQhIhVhg1fnapFVNAaAOmqikfaBp
 DXY7MeGH7tOAbzX9CCCzN9m0N7KX3aDrpbSLw1MrIYvMQt5J6FZPLsdtazDSkdRu5QRIk6XFX56Sd
 HL8PEAIR8knaxoHf2OqGTmxa0CqHNWMfEZqKdvsJLrVRHG0vJ5qzY3iPd6mcZlwfgryU0DC+GDpX5
 nXveMVIw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGtA-0009aT-0E; Fri, 08 May 2026 10:48:52 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGt9-000KsG-0W; Fri, 08 May 2026 10:48:51 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 4/6] sysinfo: add IDs for RAM size and variant
Date: Fri,  8 May 2026 10:48:32 +0200
Message-Id: <20260508084834.45637-5-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
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

From: Nora Schiffer <nora.schiffer@ew.tq-group.com>

The interpretation of the RAM variant is board-specific. Still
add it as a generic ID, so it can be exposed to RAM drivers.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 include/sysinfo.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sysinfo.h b/include/sysinfo.h
index 026ea393730..bd43caab849 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -161,6 +161,9 @@ enum sysinfo_id {
 	SYSID_PRIOR_STAGE_VERSION,
 	SYSID_PRIOR_STAGE_DATE,
 
+	SYSID_RAM_SIZE,
+	SYSID_RAM_VARIANT,
+
 	/* First value available for downstream/board used */
 	SYSID_USER = 0x1000,
 };
-- 
2.34.1

