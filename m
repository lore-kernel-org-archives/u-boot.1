Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB72C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC53187FCC;
	Mon,  4 Mar 2024 17:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WT4qaCo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D3787F9F; Mon,  4 Mar 2024 17:04:29 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B597F876A9
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 17:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709568266; x=1712160266;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xhwnnh9el0+lX+WwmwDZFDwSnCF2CFCR6wB0YDzHIwA=;
 b=WT4qaCo1PbnpOTk3XRTjC8YsxOQpVTf7Ngz0rqtvXy7b3m9Bpgu7ES7HbS+MhzvG
 KaebByc6C3hGOc8cyWCCwFmZJ7b9+KnASfdJ7+Lr+/3YZyTbrv/4kQyOlkzX0YLB
 ckYeNT3YBh4rXJcvjDcmXzIP/MIc31Zbi2pJ2yL0smI=;
X-AuditID: ac14000a-fbefe7000000290d-c4-65e5f10a7818
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 61.08.10509.A01F5E56;
 Mon,  4 Mar 2024 17:04:26 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Mar 2024
 17:04:25 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH v2 0/2] board: phytec_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
Date: Mon, 4 Mar 2024 17:04:18 +0100
Message-ID: <20240304-pcl-070-patches-v2-0-c534960c4b8b@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAALx5WUC/3WNywqDMBBFf0Vm3Sl5WBtd9T+KixjHZqBoSEQqk
 n9v6r7Lc+Cee0CiyJSgqw6ItHHiZS6gLhU4b+cXIY+FQQlVCy1qDO6N4i4w2NV5SjhqObSmddN
 t0FBWIdLEn7P47At7TusS9/Ngkz/7v7VJFNhY2zjTkh6MfAS/r+SuI0Gfc/4CHEOLeq4AAAA=
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709568265; l=911;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=xhwnnh9el0+lX+WwmwDZFDwSnCF2CFCR6wB0YDzHIwA=;
 b=ngPujbnFlqEyNhD6eDHoI49Vk0yKqF2rnl/gxxZqg4Xj+NqKC1lvLK1ndGXQqYhx7pJ67ohMd
 eqPwJf7RKwADI/DXQvXAeFcFfuHwXZTFA/9YweIsBK/mCPvRtEsEnrv
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWyRpKBR5fr49NUg8OdQhYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyznXPYSmY
 yF7xd+4r5gbGv6xdjBwcEgImElNOKHUxcnEICSxmkrh57y8zhPOAUeLLtb0sXYycHGwCahK7
 3rxmBbGFBeIlDj66yAhiswioSCzYfpUNxOYVcJK41PCfGcIWlDg58wkLyAJmAU2J9bv0QcLM
 AvIS29/OAZsvIfCEUeLosmNgc0QEsiWedW5hh6iPkng3MQjiNmGJTTu1IMp3MUnc3XeUGSKe
 KLHztRxIp5CArMTN81vALpAAGj/t3GtmCDtU4sim1UwTGIVnITloFsJBs5ActICReRWjUG5m
 cnZqUWa2XkFGZUlqsl5K6iZGUNiLMHDtYOyb43GIkYmD8RCjBAezkghvza8nqUK8KYmVValF
 +fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRqAgcrF5xI/oWruSve7vYxJ
 T9fMs+TskVzd8cdd4debZ7tvLXEz8uvVsl77oJL5/Za//grrNj4KdzFTkDMuOzhxrdX6euMH
 HYURO5677fRY3TRLdkbom/jFsiv+bl4yUzLE55DiIS7/ld0N9pJdE/3aiifknrEyLxf5c5PT
 +YnvyUMH3s0TeeisxFKckWioxVxUnAgAGj/tXWkCAAA=
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

PCL-070 supports 2GHz RAM-timings from pcb_rev 1 and newer. PCM-070
supports 2GHz RAM-timings only from pcb_rev 3 and newer.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v2:
- Fix mistakes that prevented building
- Link to v1: https://lore.kernel.org/r/20240304-pcl-070-patches-v1-0-6aa6c89e3b81@phytec.de

---
Benjamin Hahn (2):
      board: phytec: common: phytec_som_detection: Add phytec_get_som_type
      board: phycore_imx8mp: Use 2GHz RAM timings for PCL-070 from pcb_rev 1

 board/phytec/common/phytec_som_detection.c | 10 ++++++++++
 board/phytec/common/phytec_som_detection.h |  8 ++++++++
 board/phytec/phycore_imx8mp/spl.c          |  6 ++++--
 3 files changed, 22 insertions(+), 2 deletions(-)
---
base-commit: eac52e4be4e234d563d6911737ee7ccdc0ada1f1
change-id: 20240304-pcl-070-patches-d31b989cf5b3

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

