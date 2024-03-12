Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C53BC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4AB687F25;
	Tue, 12 Mar 2024 21:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q9b+nU7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CB287F00; Tue, 12 Mar 2024 21:20:40 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DCC87F47
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTpA004637;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=wIxVYdUrv3At8a9wzuc5Frr+mq8WZgEZJmkdgh92tfg=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=q9b+nU7c0gV0mbHop04JyUdRFwKpvb/d3JKrcu+Ro/8VJS4VPOI6ZYJDlqbCcaHuQ
 3ZcSz94aQjjVEberS4MQMTVeDJKSFVz2wFwGOlKFWWnzXgiZkPib/E8W04/fvmhrt+
 hqt19gnJViyxUS4c5WhP+9pD3l/7mHOs6QRnrBGw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKTSL019544
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:28 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKS1i097250;
 Tue, 12 Mar 2024 15:20:28 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:20 -0500
Subject: [PATCH v4 02/13] power: domain: ti: use IS_ENABLED macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-2-fa772bfa623b@ti.com>
References: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=bb@ti.com;
 h=from:subject:message-id; bh=uO4Fun5h6R0eX0jzltRKwXHm8D5QDCTj+SyfqlcOVF0=;
 b=owNCWmg5MUFZJlNZxsPT0gAAaf///7b/t7e6b0+0tz3D97fu79+z/5x/vWKv3pxv/Tvc11+wA
 RsZo5MgaBoGgDEDIAAAMjQAzSBoaDQAAHqaAB6gaAaNGj1AxPU9IabUxGan6o0OR6gGmQGgPU0e
 poAyAMmg0AAaGmnqGj0jIxA0A0Bp6nqZBo0Mh6h6mgA0AeoD1NAxE2o0MjI0NNAaMnqZAMTQ0AM
 mjRoDQANADEGIyAaABphDQaNAYJoDTTJkFChEKsPhZPoFELBg7znOIwIKC+9HsBDCA4C5hAN94J
 Usw5NqH4NgY88Y6EdAddpRW4rUvg9Q+LlYcm5N6P5ULRWr6apxelcYUH2TvPpB029MCpxvpEkDo
 EQ5Wk13NlgYE1W12fCLBsQRlZClB27fcnWZChamwIk6UBwSrYAnT5hGjKAcf0HSMYoQiu75YfdI
 DJiwnTjKWIW+dJJWcYSh5RtcAlhjNOSrXOTV4DmMwepA3uQguU4t8+kYaMdfADXQpHhax1hwvwA
 o+4Kdv0Nf18aS90VkBNrlAr3inF7ZikVBgWFQ2BOVagrR5PV+EyYpHdDVmyUSQik02HAgZeRAjl
 C9LuTAJJIGcEFbDqp+6imXfwC82Yn6r65qmHlJLFEoJ58Cmx/zRZ1T97AI1IbtQ9fAaetYwD0u/
 BBp4jlSEvE7v8XckU4UJDGw9PSA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Cleanup this list and standardize on using the IS_ENABLED macro for the
power domain data list.

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/power/domain/ti-power-domain.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index fb4ca2dd6b45f..8fa9892c02c7a 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -81,19 +81,20 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
 		.family = "J7200",
 		.data = &j7200_pd_platdata,
 	},
-#elif CONFIG_SOC_K3_J721S2
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_J721S2)
 	{
 		.family = "J721S2",
 		.data = &j721s2_pd_platdata,
 	},
 #endif
-#ifdef CONFIG_SOC_K3_AM625
+#if IS_ENABLED(CONFIG_SOC_K3_AM625)
 	{
 		.family = "AM62X",
 		.data = &am62x_pd_platdata,
 	},
 #endif
-#ifdef CONFIG_SOC_K3_AM62A7
+#if IS_ENABLED(CONFIG_SOC_K3_AM62A7)
 	{
 		.family = "AM62AX",
 		.data = &am62ax_pd_platdata,

-- 
2.43.2

