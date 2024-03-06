Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D729C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 16:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B9887D31;
	Wed,  6 Mar 2024 17:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="h0H4g8zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CC1878E2; Wed,  6 Mar 2024 17:18:40 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8AC180245
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 17:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709741917; x=1712333917;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hxQpZHRMNc71htd1KlNK6i7SyC1RevRh/Nmw1ivfEHU=;
 b=h0H4g8zdKFIfzP0+xg62pzu7wAwzR80Ab8Nmu6/YyQJ7mtJ6Y6NteOx4pQdfvUsY
 IO5p+NL0WVz89UrZ3YYWWankkEzjzppy0p9nhIIOgaWeFyFaG2bhWtEL1ferdEnQ
 SPDlWni3Ll6ZYghUytFGu/tZToco4P1vJN4BIvNi3Gc=;
X-AuditID: ac14000a-fbefe7000000290d-f3-65e8975d46d4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BD.E3.10509.D5798E56;
 Wed,  6 Mar 2024 17:18:37 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 6 Mar 2024
 17:18:36 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH v3 0/2] board: phytec_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
Date: Wed, 6 Mar 2024 17:18:30 +0100
Message-ID: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaX6GUC/4WNyw7CIBQFf6VhLYZXK7jyP4wLuL0VEtMSaIhN0
 3+XduXGuJyTzJyVZEwBM7k2K0lYQg7TWEGeGgLejk+koa9MBBOKSaZohBdlF0ajncFjpr3kzmg
 DQ+skqVZMOIT3Ubw/KvuQ5yktx0Hh+/q7VThltLO2A21QOs1v0S8zwrlHsreK+OOL6kMrlekYK
 Kfdt79t2wdYWw2a7gAAAA==
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709741916; l=1116;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=hxQpZHRMNc71htd1KlNK6i7SyC1RevRh/Nmw1ivfEHU=;
 b=va/mStEC1OyNOj7R3DpJtaHvY0QbeFtyBvrn7B4M7dWpvUjpmH0YSQBHi8jlROIBtsglHI+K9
 ygXl32BAOTiAR3wrEeO1PA0aGm24K2ZdTy9XdxpxGTeL/s7Shn2nhWN
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBRzd2+otUg6VLOC0eXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlTHmwibXg
 HkfF35k/WBsY17B3MXJySAiYSHRd3crYxcjFISSwmEmiccNvNgjnAaPEtScLGUGq2ATUJHa9
 ec0KYgsLxEtMXngPzGYRUJFonbyMDcTmFXCSWLf5MTOELShxcuYTli5GDg5mAU2J9bv0QcLM
 AvIS29/OYQaZLyHwn1Fi99X5YPNFBLIlnnVuYYeoj5J4NzEIxJQQEJbYtFMLonw3k8S27bdZ
 IOKJEjtfy4F0CgnIStw8v4UN4hd5iWnnXjND2KESRzatZprAKDwLyUGzEA6aheSgBYzMqxiF
 cjOTs1OLMrP1CjIqS1KT9VJSNzGCAl+EgWsHY98cj0OMTByMhxglOJiVRHhrfj1JFeJNSays
 Si3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cBYdnxr1YbQmPa0X6Gt
 O5Kfcbtknz5y/1up7Y3O/+e0Hmi+5/KRvtkgrzlnS/e90+kdz4/a27Mf2v1lVUNu406JpNWn
 jLY9aH8za9s/Zze5SflP9ppkbzxmJdq2yyPy779CVaGfN7uenv2sIsCVXHYiu/qzTeD66K7P
 Hy/5f2hZcubJ2Y87xUxClFiKMxINtZiLihMB9k7RpGoCAAA=
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
Changes in v3:
- change variable name from somtyp to somtype
- change enum names from PCL to SOM_TYPE_PCL
- Link to v2: https://lore.kernel.org/r/20240304-pcl-070-patches-v2-0-c534960c4b8b@phytec.de

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

