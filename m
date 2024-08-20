Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2085EC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 18:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A7E87DB6;
	Tue, 20 Aug 2024 20:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="m9Kz6mp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFB188A3C; Tue, 20 Aug 2024 17:47:01 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2EC688D93
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 17:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Y.Varakala@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1724168818; x=1726760818;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9r2YP4gdiBeJeZ6yGvPNQQ9Pc2tzST+DuUUYNXzS9n8=;
 b=m9Kz6mp56Y/JSamz5MsECtnwgT1N731Iy/mE5xtxIy/9KRoLCTL65a809uwIynm0
 7hwofHVO7n65CvgdzEJSs0jZ7f0Jmn1asWnOEOqNecwq9g7c5FYnVcr+ggHnKU0W
 7yE/GL0Mc06DsZaYe10vh/2aVt/3AOKBNcQHF5ucDU0=;
X-AuditID: ac14000a-03251700000021bc-73-66c4ba728981
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CE.20.08636.27AB4C66;
 Tue, 20 Aug 2024 17:46:58 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Aug
 2024 17:46:58 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <t.remmet@phytec.de>, <trini@konsulko.com>, <sbabic@denx.de>,
 <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH 2/2] configs: phycore-imx8mp_defconfig: Enabled bootaux command
Date: Tue, 20 Aug 2024 17:46:30 +0200
Message-ID: <20240820154630.78976-3-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820154630.78976-1-y.varakala@phytec.de>
References: <20240820154630.78976-1-y.varakala@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBV7do15E0g/5mSYuHV/0t2k/5WEyd
 tJnd4u3eTnaL7nfqDqwe82adYPHYOesuu8erA6vYPc7e2cHo0d/dwhrAGsVlk5Kak1mWWqRv
 l8CV0T75GHvBMtaKE5P9GhgvsnQxcnJICJhIPP+xgR3EFhJYwiTRN521i5ELyH7KKPHp2Guw
 IjYBfYkV6xaxgtgiAhESHReOgDUwC/hJfL4xlw3EFhbwl5j4YAkTiM0ioCqx5mM3mM0rYCmx
 7PMsVohl8hL7D55l7mLk4OAUsJLY/1cDYq+lxJ4fP6DKBSVOznzCAjFeXqJ562xmCFtC4uCL
 F8wQ9YoS7x92sMOMnHbuNTOEHSrR+ec+ywRGoVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusV
 ZFSWpCbrpaRuYgSFvAgD1w7GvjkehxiZOBgPMUpwMCuJ8Ha/PJgmxJuSWFmVWpQfX1Sak1p8
 iFGag0VJnHd1R3CqkEB6YklqdmpqQWoRTJaJg1OqgbG76e6RHK0Jr461z1lbqs+4sD/HQ+D8
 h+J9cekJnecjsvT3dEmkFt4zk5QzmhzH/fSzm/bnuH/bV5kc2x/EM3PWRMe9Ah8UJ5/W0xAT
 vBD48fpc/8R1PVKX/j2NZf56VMDcv/GGj4is67/6Cc8ndxyIYpicPzHZwKbslJvt0xmvrcSZ
 Q0+sWqLEUpyRaKjFXFScCADX6mlKZwIAAA==
X-Mailman-Approved-At: Tue, 20 Aug 2024 20:45:13 +0200
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

To start the mcore binary from u-boot, bootaux command is
needed.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 63f8a80ba99..6b0ffecf9a7 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_BSS_START_ADDR=0x98fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3e0000
+CONFIG_IMX_BOOTAUX=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
-- 
2.34.1

