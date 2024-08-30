Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4BCCA0EF7
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795F888D9A;
	Fri, 30 Aug 2024 11:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="E4hLA7sX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E6488D9A; Fri, 30 Aug 2024 11:10:20 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8BDE88DA3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009016; x=1727601016;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NGDfR3/kPYAdXp6iuRy5MVr61XDvGmFXBp3xhAogS1A=;
 b=E4hLA7sXDFExu0DDGoUC4EQVZGLJp213fQGWvBekb7KuRen4Arnqzw6Ik64+ateE
 6RZro7kVdPQt2OmWtyO/EC47hLMRKoRHuV+q80E/lZ9lit+WjenKX7AMDbXQpMo/
 Gkzwh49f6pWtuapxafR+OSOg8Vyb5ALM8ag7KMQXivQ=;
X-AuditID: ac14000a-03e52700000021bc-45-66d18c78b813
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 05.52.08636.87C81D66;
 Fri, 30 Aug 2024 11:10:16 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:14 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 12/13] configs: phycore_am62x_a53_defconfig: Fix
 CONFIG_ENV_SIZE
Date: Fri, 30 Aug 2024 02:09:39 -0700
Message-ID: <20240830090940.2592157-13-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBR7ei52Kawf0Puhafdj5mtZg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+tntjMFsERx2aSk5mSWpRbp2yVwZcza9JKl
 4BJbRfObTewNjO9Yuxg5OSQETCRer9vKAmILCSxhkvj3CSjOBWTfZ5TY/6+bGSTBJqAlcWfL
 XDBbRCBJYteTZWwgNrOAi8TiGx/ABgkLBEh0fpwBFmcRUJWYdu8fE4jNK2AtsWX6RSaIZfIS
 My99ZwexOYHim78+YIdYbCVxfNo5Noh6QYmTM5+wQMyXl2jeOpsZwpaQOPjiBTNEvYLE7G2T
 GWFmTjv3mhnCDpU4smk10wRGoVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRu
 YgSFuQgD1w7GvjkehxiZOBgPMUpwMCuJ8J44fjZNiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/q
 juBUIYH0xJLU7NTUgtQimCwTB6dUA6PQ5NP56UUrY3yOfM7Y9fdH1KET05fIcS3uEDmsM/G3
 YF5rjcDbNWrFakLmUtP6XublCyrHOZrNtz28p+Xe1El/4tVyX0TpH3R7NH9dc9bEAx1/Q6V+
 rNg/IeDBhidzOd2WTUvLkP8tvH7hlL33VnxNuC6vlb46Jltv4kqFmdzZb6ROHP3Zf2mjEktx
 RqKhFnNRcSIA2qesImECAAA=
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

The environment should have a size of 0x20000 instead 0x2000.
Update to have the same environment size for all PHYTEC K3 products.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 07a1fff1f3d..246b8743da0 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -12,7 +12,7 @@ CONFIG_TARGET_PHYCORE_AM62X_A53=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
 CONFIG_SF_DEFAULT_SPEED=25000000
-CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-phyboard-lyra-rdk"
-- 
2.25.1

