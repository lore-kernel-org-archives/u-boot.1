Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F236E95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 14:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B5686568;
	Sun,  8 Oct 2023 16:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="cr+ojnQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B77D86524; Sun,  8 Oct 2023 16:59:30 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE5386587
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 16:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imvVy2Ypi6RTZmBwUfJNbY6wmpHtOjxH1iNTnJgyJMsbuUGrBxIeaqFFoz0eJR5G2E/dZXNHqohYh1jqpIUOZ5ZFJi+yHBQs+CfkLgwpUNLbiC5hSc6k547lk5hTiXmt0BCOMS5k7tj/H9dT5GOfGs3q8On4029ooJSp2KrcrCSc0E4O29DeXVqXqwQG/QqQwUCu7o8jaMib8NYeLkEho660rpJEdofyOb9fgK7k+N6pQwTFVnEiiD+S0ta055lA5qCKBe1K8LqSW4anhaSVHTCFsQs+4kZa/8/yjBBWCzRHOWNS4eLSd8wc5eRas4VxpxJbXN3TjQ28DPzYJsepEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Eo//bHVekFb6NiWf30iP/UcsDzEqzxDWjo3Ak2RuFU=;
 b=mRtsirUW5S5g6F1qITOje04e/eJpY9/SU3N12nNb2TDsjPXfLXiNW/ZaLV04WRQ+Rbg+xN6Hz/d8NMgv5qfAW11EHB8rxVcB3MaMNywu8hParpqWuno05WPQJFyqDokQp2mxV2rn0yeraRJ/9pf9pqacDvExCxH493PwIo4b2mZliHtZFkKpmWLx2oHlqGu7VJUUzCoCFrA1jOOpzVpt/rICARFf8GH/vEVHp/OrGW2AGABcmXYNrM1Ro24ejJ/HH0H99kH922iHiWnx1hG+R3/d7HtEebsOjkwsS5LsrupQyopFYnuFEkFcSgHAs65NwZoIcF5dD/jh+jACAxbxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Eo//bHVekFb6NiWf30iP/UcsDzEqzxDWjo3Ak2RuFU=;
 b=cr+ojnQXz21tuPAKtxVmoL60MDfY0vnDl9FiCbIuKnOfcuhW96Y5R5Gc/TgodWM3c6l1d/cNTlQ/qQCzzURqCuij/t34lINE8qRrReVh6X1YjqZDqpolFXObU6x+CJ0mOzjt6TGtMPx6NqhAz7wSpd2ODeAKbaPQnIC5Zc/f7PU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Sun, 8 Oct
 2023 14:59:21 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4%5]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 14:59:21 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Josua Mayer <josua@solid-run.com>
Subject: [PATCH 1/2] arm: mvebu: clearfog: read number of ddr channels from
 tlv data
Date: Sun,  8 Oct 2023 16:58:03 +0200
Message-Id: <20231008145804.25567-2-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231008145804.25567-1-josua@solid-run.com>
References: <20231008145804.25567-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::17) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 153d4d7a-9584-40a9-fff1-08dbc80f2777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZDIQs/RR3zrse7HKg6K2JYLVMR9o9z9XCS+Hi0RPZnJ7mfAlBj/0XVpbstyV4wc9uw7PQbWRvM/gNKuYdNHt9CUvl86UbEx8howVySmKW8aEqv4bzhVZctVFbpj454HyWY7X1X5NTxgz4rFrUNp2idBd/JuLPg/dU8i0+h9//R/+VXnYiJw7Ap7TprxpgCHIPu8uJLe1LSlvnnUR4yeH+cIiU/6yGJHCzRiBGAu0WTeiJcnRxmyHNzbGRz8/DzDH1dcCMJ5DN6UWDOcDvLkrLuaFEhiprtnqklRf5itUd6p+zexnvJyOLv0vBbmL6tj78/5CZxQN9RxInad6Vj/wY7iFP3m2bnM/F62DwlSKQsPSTnKbph9PP5KGxVmgNrb+7XjT4HIZcsbzvglGQEWdd2gVCcs+CiiqzypimkkZxnmKPKKz+hdJ5piXpHZTytt8SLIwJxkxFUV6sIM1TvSiC1hLU3NVxyj2wF9dUWAyrQzC72uMBZeIbHiAKWHPE6BCiHn+6C6HNBc7p1kkKpGEANSh1zEIodH9YBAGqp7v74baP7FSy7J4a5A7O40/7GX6/z/t5CGTvtROXAaLywoNRbTaf58S4ynDOClJQhzl8B8ys6RFox46bJKdb3Kb6eT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(107886003)(1076003)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(52116002)(6666004)(6512007)(2906002)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPSAkRWCrijuKkzbgJIqR9HzwY15k6hr5I638FgH10j8iBqMQsZGhHWbwFIE?=
 =?us-ascii?Q?vHwCS4ps5LeNlOafbyHxTpUaFqFDa9J3eFIJoz5XRHZ/IHV52aQRqcXA9HCx?=
 =?us-ascii?Q?dom3y24d49MsbD0YTHQJL7SWsj9XSDeJUf1ib03EjmEDXub6IPhdwi8llgxW?=
 =?us-ascii?Q?nanb+lLghMx/u0TOu41BPYgTMqa5ZlGSA9xJGwkF3kOFKJGz27NI5froXW2D?=
 =?us-ascii?Q?e0ixh+HofoyWvuLAbK/prbHCVSGFBxDZFJkUGwSuSfZSaCe3wgTxDYmfQhCq?=
 =?us-ascii?Q?CkDCIPrQYDygzET3yauZJt3NJROnWMrUZ0NvcmzlRIh/qlTtVxsLS49lvGvy?=
 =?us-ascii?Q?0WftiAaBIh2wXs9asE1OmFoGI+HdYw+onCobx6nb7xSglmzdWcgVHmscEn7g?=
 =?us-ascii?Q?LbXwaiyjkCXxA+CutBQEL5QDzOc6eBszl+ewclbjyKZ1fr1hR2Kl1ERDdyks?=
 =?us-ascii?Q?oL7e/KWKWzG/qn33wRjMvaujbqNhZSh1qCl6AsWmQaxCmzWIpIzDPNEj7xZg?=
 =?us-ascii?Q?JJ9KqZmy+mYOaSEAsKk1LM83/vljGXdaUaeOxc4uWwI1uuYQvoq/qNRNy+x0?=
 =?us-ascii?Q?Ld/Mh2ePgfej2Se0TRJPEJkj6RGenHwvZR8wNVUfuhvp9jpVFt/vFf5G1nIk?=
 =?us-ascii?Q?fLLxQhQ6eobNRRiZDLo61cDzXZkAnBmPeE5XXX0C4AKlrH8FaLuPSgVkcqG6?=
 =?us-ascii?Q?BkkGRBppVRJjoHK/HoJdIeLYroTV1uY7swAno1iHR8mOxXek5zOrI7sHhMUd?=
 =?us-ascii?Q?wcYRixmlI2v+FFb72AZcXOatShV7/lg+FBlejgOjkHDJC2L7daltdft5su3j?=
 =?us-ascii?Q?hMQlt3n4P5Mw/7B0qPlf+m2wLqiUObHPWbQyRiOLNVFegwIyBxL01YC0vnq/?=
 =?us-ascii?Q?ZRbrryjSlHMj23g5N/8UZYV1YDhxANn0ein6ZDZqd9lKtguaxihJI168c6pm?=
 =?us-ascii?Q?wBZDCs9e/XXTKkP1HjoLxuq8CXnlm0Ncriws/0HFp7pAosKYXHQSLsGz9esz?=
 =?us-ascii?Q?0HZxBUQM+bsQlBbFiuzobE7Lr5grz8i61RjR2dQ7BPHnoWUyazJgIZEgCu2n?=
 =?us-ascii?Q?ZIzGFeghECNfJrhybglM4tZHGXGnMnM7JzKmUzIu4HgvxLCZWAIUxM96RY8F?=
 =?us-ascii?Q?L7b2eckZ33f/6xmQVgp+f70uR1g6io2B7RkFxnKPGmTSnW+KN5f63bID7s9r?=
 =?us-ascii?Q?kr+l2ro5SvanAegJFcEjGE6gxJAOFzo9zvnbFanfw8cKowy1WXaDfa9EFiUt?=
 =?us-ascii?Q?huK5aDiQd4mIbELj1/aj+o7E2mtYfgHoLKaZUn9LHDGEz2YPUPmwFA6n3Qi0?=
 =?us-ascii?Q?f0yr3TRAZT+nJZZbEBv8X0S3q+PrazJWZWrT8qtAbW1jutH8T0VC+yNtKA/T?=
 =?us-ascii?Q?Br3QRuvUEIGWQ0peR1Hb8EehkvE2THubGZ40M96qJCDyrIVi2fEg+vn1ptAm?=
 =?us-ascii?Q?Gx9wIFChimnysyqttGO7Y5yhVGLyY3SEQGIm8hmvBKj94dPR6TLCupOO9O1z?=
 =?us-ascii?Q?omlzT80aEQT47Avkw4piecQ1aW4LCJxuQqkuPcYWx14/EiZvXHENgDov/AkD?=
 =?us-ascii?Q?eznHpcYnS3yQIRFUVLbEBW22HfQrSs43tJPQW4wS?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153d4d7a-9584-40a9-fff1-08dbc80f2777
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 14:59:21.6821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRvhuFvRpCDj+9qc89EbdxogIHnnItlv721vuZQLlLEdJWPd8vSY8GQzITxSwWbV9AF4wJlq5tv6oYvgtbE/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525
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

Extend the existing tlv vendor extension used for ram size by one byte to
also store the number of ddr channels.
The length of the tlv entry can indicate whether the new information is
present. If not default to single channel.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 board/solidrun/clearfog/clearfog.c | 14 +++++++++++++-
 board/solidrun/common/tlv_data.c   |  7 ++++++-
 board/solidrun/common/tlv_data.h   |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
index 6edb4221551..4f4532b537e 100644
--- a/board/solidrun/clearfog/clearfog.c
+++ b/board/solidrun/clearfog/clearfog.c
@@ -36,7 +36,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define BOARD_GPP_POL_LOW	0x0
 #define BOARD_GPP_POL_MID	0x0
 
-static struct tlv_data cf_tlv_data;
+static struct tlv_data cf_tlv_data = { 0 };
 
 static void cf_read_tlv_data(void)
 {
@@ -168,6 +168,18 @@ struct mv_ddr_topology_map *mv_ddr_topology_map_get(void)
 		break;
 	}
 
+	switch (cf_tlv_data.ram_channels) {
+	default:
+	case 1:
+		for (uint8_t i = 0; i < 5; i++)
+			ifp->as_bus_params[i].cs_bitmask = 0x1;
+		break;
+	case 2:
+		for (uint8_t i = 0; i < 5; i++)
+			ifp->as_bus_params[i].cs_bitmask = 0x3;
+		break;
+	}
+
 	/* Return the board topology as defined in the board code */
 	return &board_topology_map;
 }
diff --git a/board/solidrun/common/tlv_data.c b/board/solidrun/common/tlv_data.c
index 11d6e4a1380..cf5824886c3 100644
--- a/board/solidrun/common/tlv_data.c
+++ b/board/solidrun/common/tlv_data.c
@@ -45,9 +45,14 @@ static void parse_tlv_vendor_ext(struct tlvinfo_tlv *tlv_entry,
 
 	if (val[4] != SR_TLV_CODE_RAM_SIZE)
 		return;
-	if (tlv_entry->length != 6)
+	if (tlv_entry->length < 6)
 		return;
 	td->ram_size = val[5];
+
+	/* extension with additional data field for number of ddr channels */
+	if (tlv_entry->length >= 7) {
+		td->ram_channels = val[6];
+	}
 }
 
 static void parse_tlv_data(u8 *eeprom, struct tlvinfo_header *hdr,
diff --git a/board/solidrun/common/tlv_data.h b/board/solidrun/common/tlv_data.h
index a1432e4b8e1..be3f782ac4a 100644
--- a/board/solidrun/common/tlv_data.h
+++ b/board/solidrun/common/tlv_data.h
@@ -10,6 +10,7 @@ struct tlv_data {
 	/* Store product name of both SOM and carrier */
 	char tlv_product_name[2][32];
 	unsigned int ram_size;
+	uint8_t ram_channels;
 };
 
 void read_tlv_data(struct tlv_data *td);
-- 
2.35.3

