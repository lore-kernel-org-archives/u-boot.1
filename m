Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE277CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ECC180F52;
	Thu,  1 Oct 2026 20:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tftPbgf6QdfS; Thu,  1 Oct 2026 20:52:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DB5E780F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887952;
	b=I3je6mRDycKStv4Gg4XQ4DUdT/2KC7iLPULw8NjRjxXnuGKLKbzd/WVIBvXc22blqZqR
	 CL90fjUTNG0njcMHEpeNDWFTQqbyno5N2teR9W25xOR925kntyHU7Eestp8zogZ8yn7Ow
	 BFnwlOgLeAaF3xtkkLHPfEPwegzWLdKZ4WLH9+7csR74zdqDbQr+9a8BBStian1RAxqre
	 9y5eodzL73ob1wOd+xSIk87WfCK/zKjJI19sXzxbaugcr8cQc0L4UDXxd1rBqIRUEx7uA
	 j3pxPcIVHBZOgPu208jXuinFAaKc0Og52M7LMsI80i6iwSAEJjU4C3NP4YqnIgBLwZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x4d0wqswtpDb3XR/odSdJiA2gPOFNzXUpxqW5U7RI/4=;
	b=qBBIQ3rHFgoJOaMk8FDhFmDGCYloP+mURjzQP9q7FzkblnTFSt95atszT3Yqsno7U5xm
	 uOP1QwRLcblyifyAmleydu4+Ql6V0pbtPQ+yjRMMWkK7l8ceW1Zhv4wD0nclbI0DVws90
	 ae+4UwluK0TLb1wGyTWexGa9uJltkmFUm+1zhLOVaT46zKhWbXGO41bMfNClV9cIjbSHR
	 Ut9Ppd27Y+KFP/pCXk2P9egCexWmyhibTCsrDDrllPPAe60oi7+pODIzSfl1CZgtn8vfc
	 GxBNGR5ukKEL4193CeYtBOzNLAQW8G7AiUdyeCC92Iqkq9Jm+JUBs9q1VXYbWYIRa6Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887952;
	bh=x4d0wqswtpDb3XR/odSdJiA2gPOFNzXUpxqW5U7RI/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mn9o/B8s+4bZkb/ddY5sQXZkuliTudan9rdviJjHNYMhWImhos8Y2JKFk7l/FChCn
	 w/wQD+u/yuC81uhWnWQzjt3pFcz2nSWXjUI9DVHLINJXJ0xcFYjrivOrm4PiZ5UBr2
	 0UzbxyhpIZkgi/DP8fqQvMnSQdY/WQOjufmOUGV98N0ocjt5QQNNFjyffyLtQ5bvQp
	 DmMudbJvsMGnXAEGCKvcq6T6rFAl+S3WWh5Xh7DLMr8shyUkHjQCCmaIb1XJTTuqJy
	 jovdNI1KOzVpmfEpQB+ZPlmv5QgerONxQmSGh91YVDiKrkwgUtZnHqhUVSBNh5H+f2
	 54BYnX2yqZXqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB5E780F5C;
	Thu,  1 Oct 2026 20:52:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5ED4A1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44D37607D4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RnVPRSE2L0uf for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:52:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8AC7B6066B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887949;
 b=JEUJA30bQwkgBnBlWcN1pMGSZoNr/jT6CfXrhsBrQx2tWiG5zSdwby5lYoPhR684uy0b
 CJeBMKaAyCsZcC5uob5zkf/UwbW7/EUd2TU8BXocQFAMTqLX8hE12koMffrlphmYxmZqP
 +Q3SP5zrlSOOhhc8E8YN0PjDx9v2IsxqbFRSXSRLZhqgMv9cw9Mkb7d3wz2vpdpXm3sVR
 YaIwM5gPLbMem1xKIrXvQNAIGg7rqn/bc76FXxCz86v1txXk88+gWLUGrYV2s1GspKIbf
 i+YzvtTF8OF1FXbPqGn7VZkuvmJ+mptIV53v7yLikDO7G/UrZEqUDWeQ/SxG9yVSRUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887949;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=x4d0wqswtpDb3XR/odSdJiA2gPOFNzXUpxqW5U7RI/4=;
 b=nOqgfxcVOuGdCQoepGlttNRTth0o4rmHT7dzdUmw/7Sos+RbJLdQ5i6AnoSaxqhhTCox
 D4aG/GgBQiuM+RyLBsTW+yVuh8wmX7rwmpRfYpiRSUzgv03pwhTlDn+d3uSQmTGuOZiTt
 T122M03yzOKc1ThrBPvrv1Of0KgmYTM7KAOQAKRBls9nNCfG14Dxtjg40nKSb5w7oA2vb
 pD14AzYTz1ILONWBxZx6UGP36uZcv7zqI6P5FjCg4tCGhARbmgL/jZUrDJxDvxV2UpYbY
 ZNkcghuRN7sfJQIY5BvRLCInrWsyrB3lZZpRijzR6lS4q0/5zCnDtu5wUsU1hqzKE0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=jiTUKjtp; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=jiTUKjtp
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8AC7B6066B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id EA0BCB0051B;
 Thu,  1 Oct 2026 22:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887947;
 bh=7JKLytmPu2m68YNKqioqBncIfNWXtIZNMyZW0Z4Zs2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jiTUKjtptOm/T09NXczlhpqJyebYXQtzjTzwH9+rLJzZYD+0zdIbtMWUwzvXA/Ku9
 uF9U3REOSNOoU8UECqLedjMDUA6etg77dEFnOaUYYTjPu1ADa2473xGZ3LGTKSUa6b
 51YMeEeHz35YSm411T5/LE1NBlKeEbmI83zozLR4AFUqvNcXAazoz87aEF7/dqaUIk
 c4d2ZDhEws/pfjS4SPiY+b7SQGQ1zhcE796NnMlDBvXxinHwNXqwlkSUCa8NvR3IOp
 +FNnEJE4uuGfcpM/PuYVvjAquZNcwuvVge2WFQtGLTwL1fNYrbvEYXgMQFlXI9iPWU
 iklWRQA1IHSvQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 13/13] board: nbxv3: apply sd1 hwconfig before MC starts
Date: Thu,  1 Oct 2026 22:47:30 +0200
Message-ID: <20261001204731.1774613-14-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204731.1774613-1-vjardin@free.fr>
References: <20261001204731.1774613-1-vjardin@free.fr>
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

