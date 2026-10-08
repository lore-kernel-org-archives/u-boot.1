Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B38CCA6013
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 430EB6088B;
	Thu,  8 Oct 2026 22:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKLadJdVP1b0; Thu,  8 Oct 2026 22:47:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F4046069F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499649;
	b=Vxh7cz7de2n9qzS1DG7awNcNbEPFtsIQKp9YfjMSTC3GRUQnepYfjyYj+wdd9/mPqboj
	 XYwqi1XeARhIIBXfDRjbRt5oB23+6IyGss65cphk4iaL4eLkZ1RUeRblIoXNguMW/X8G8
	 0/7FQFhS8wrKEt2fQ8HiKdcpbk7eZktK3sBbnbJuD/IgrBvYtCpk+ZpBHU5F9i2P6cYnl
	 A1KRow37z8g3rdlvvsd0e+jncJHEZYuvCqW5nH9Ssf408Fmi6zx4Uz6ws99RqOK4kyZHo
	 WT1X55d1qlHIZqOlG3jjb73zacXwZSan4VSko9gBWysKMpUvEL/4pppgop5V4yK+Qdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x4d0wqswtpDb3XR/odSdJiA2gPOFNzXUpxqW5U7RI/4=;
	b=hnLxckgPfYgK/djcCmqYfmm1a5j73yh9WviKwAd4z9Nk0m4/qzBnK1DLkI2l8XsMeOUi
	 smL2UoIOmDS9pnXewsfnGADWhxNCx8kRKXLof1rnnKR1yABJcHBkp/pJcOfIdoqd77FFK
	 5LRd77hoG+X4wOuxGrdt4gm2hM9EhFMU+QhK2h1tPYzq6ppgpKAggOtX6rKaKcpmU08bN
	 sqJJSqyYklWOlHKSwXk8hUszX4J0fV3Bg8WYSyiFXtpTMnhtR7kr7xyhoKOogh7gMoGpK
	 g2AqtWvmFwJzrPaRNjrehloVYom7UxLnoXgS4kMtVe8sSi0Uqa3Wqg+04h0CTIonQCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499649;
	bh=x4d0wqswtpDb3XR/odSdJiA2gPOFNzXUpxqW5U7RI/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r6evAtzi1sMPdC4pyQTZyopyOm5ENI2j5q2tX0iJTlqtt5shtVd4IsXnh8j425FVG
	 SpDi9lIUyhasi0amxH9xglrJmzYs1Oe+TDscWndQvHlptcrI67V9+8us0LF66sQbxl
	 mWRA/RuKvTrO+fHOb9huyFfloG1MwXp/YpAIz8gtYolR644r6eHNwS1N5/LaKdq684
	 Ojd7IFwenHLTtpwv4npuz1/PXsK1jDpRwbijfgZpWvoKRAv7WR3jPg9p2BE2UDzX2t
	 GaY3u9fPmxgbUaKvhBOw9gcWf56N5jDKIjUxtZZKISoIt9A5kAmx0je9FshKH13AwQ
	 mWJ09wTVUwGQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F4046069F;
	Thu,  8 Oct 2026 22:47:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAECC1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACB5D810D0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qat4hCTljeG5 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:47:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1676B810BB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499647;
 b=LtPo/jzKOeFmhcB/dC8t+0xzxQ3naDvsf/YSleSA2M/9K/FES8oWuW/tPDcq0SR/bxGU
 AoqwpWhhVaMusVH0TOlmZDuDxk0DlvnSgWlUDCfQOYYURdcAbDhUjtt7lkbFcBIG4Eflx
 e90qKinVp6v0PKFZ9nBNXr15F7tVv6eUZKHUzNWSYDpemffcuZB56102pynsJNS4NK68S
 kKHA/D8+rBLVkmFkTuErXCwscEt5v1lE4ev8EVC4Tg2FLg06CcliJ1fJXiDZ8bxJRepo/
 Jr2E2M3V/8JOmQ0tprYAwgyTKVN/fLz+8iOY1dZCFDHHNLBonQAuI5gpBxr7Gxgkm7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499647;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=x4d0wqswtpDb3XR/odSdJiA2gPOFNzXUpxqW5U7RI/4=;
 b=s2eIcG2FE/BlTAXS391AWQQA5i2aRzcDa1zc5FeC6y2HQgQMia629BSnQgRTyFQWLnpL
 lo+CIvFv7X6EzDPDBm/seP3ydPzPPjJqzhMiAyKM+NraMTrX1uxLxRI+7Di0mr46aPZaj
 KGEO5PKulIkeTMXJEpViOtsbIscsrc9EHViu0SJ2uShqpf6PInCeyFQuWHB8eNEAlxM8v
 AxEC03/xsBrhiUvG/CLwKfy8M2ay0eofZFepHYoDQ3QXzB9A2HslkbjKELqNcmuuyusH2
 ElgO7ep5ZY/6jmiDbTzxuoZ5ZJL8xWHZNT/vhhs1IJgkRaX/NlMlt5MXOowauAxOmLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="qSD0r/J7"; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=qSD0r/J7
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1676B810BB
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:47:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id A1981B0054E;
 Fri,  9 Oct 2026 00:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499645;
 bh=7JKLytmPu2m68YNKqioqBncIfNWXtIZNMyZW0Z4Zs2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qSD0r/J7H/5EooUuVEOyB6li1+5/geC1UrTukcjKygJdxPyAc8hqxjxoVAAsRErru
 +YlblaYktNAU7PQhYDicsji4C+PiyG5l5Oqs9W00ifspydV1l+l3ZbjoPsAxEuYlel
 Z+osDRBnwPxc3FGkrdthVoHv7z0rI1nAgI5cB80ZlD1vBXhCe7E4O+Cq88pYOtCckY
 +hqxT4mmEPW9My2ZxTLMP7ia/N0wvo8roigw0lno+HvVqs1SXnB4lh7dRr9d02mVhq
 r5UhBML191uhrMkfNk4ItdH6dGZ2BNQTGGDJ0SSd+sNjAIjMbEyWIy0npe4/FhhSjD
 qYJFR/WAFT/eQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 13/13] board: nbxv3: apply sd1 hwconfig before MC starts
Date: Fri,  9 Oct 2026 00:42:26 +0200
Message-ID: <20261008224228.512353-14-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008224228.512353-1-vjardin@free.fr>
References: <20261008224228.512353-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Apply this feature to the nbxv3 board too.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v5)

Changes in v5:
- No doc change: the doc no longer lists the boards

Changes in v4:
- New patch

 board/nxp/lx2160a/nbxv3/eth_nbxv3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
index a8d249c5cac..69873909733 100644
--- a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -15,6 +15,7 @@
 #include <fsl-mc/fsl_mc.h>
 
 #include "carrier.h"
+#include "../serdes_split.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -34,6 +35,8 @@ void reset_phy(void)
 	 */
 	nbxv3_carrier_env_init();
 
+	lx2160a_serdes_apply_hwconfig();
+
 	if (IS_ENABLED(CONFIG_FSL_MC_ENET))
 		mc_env_boot();
 }
-- 
2.43.0

