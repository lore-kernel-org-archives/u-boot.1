Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8880ED12D56
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2013283FC1;
	Wed,  3 Dec 2025 13:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ko8hAFfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827EE83FAD; Wed,  3 Dec 2025 13:22:40 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B1683F93
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Faer5Dcdoj7zqThEkowAMo6pfDCafghwEG4xTulepyIxK8dvI/VPzj7dCyUo9jZjWi8Wvja4bUbC+Z15RWjksy+ZIMpcNO7Y3jUBWB+0L46IYHM/RajVBrwtn/b9KiMSfhImU0obI/pE53/rPoQDe+3QoyNWcCtz9jBL9TnCjibNCAqGCGv1/Vbz9GJ/dpgElMzXa6EI4lQ2Mz91WsyHU4aCuwVVPs0ijLvmFZUI9ncN3NlgN6kgYMfxU+dtlSq5L0A5PZkQil+ptfHVM0Vc/Yn7YAFbDAXODe8iF9EBqU9qs36YP17UndCJA561ZxcQ/MK9dmwBz2Upw/eyqiwylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvAVhiEER53qq75B8sWUFIuGswgCHnjpt/p4MoiI6Us=;
 b=Cmlkp0IQrb5vnksNldgFXMgTakle7tWMbQRIzcdZ/TtISVL5nLWoWXPNbVld3kGm4ARU/kDzp03tPPoIUI7L+JPsF0UozISOTPoaDa8w0pTcrBY0U4MJuATCw5wwPhhgC1bhwADYD13f0+nBV+rH8rFODrZfwXc3hTXkX0DX0KwmqdLZ6VVeJRdmvAPiSTXUVQusJ0HOPNMBGyFIhZ9/URZ/4YN9751zh9Ku92pNcq6nThL8C52KzWT5fVRqjHmdn5fAq5CpXQK9d/1wqASKQO1+RJNe5MMuwSa6G83hv1iTwoUEBoBa+WuI/cWpiVWGPVsCKcj+j1PcdQQPAOl/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvAVhiEER53qq75B8sWUFIuGswgCHnjpt/p4MoiI6Us=;
 b=ko8hAFfAx9GX0wblxj9kNmUTIMotpmohYjbBxhG9qIMuIdKUtMTpUK0XI6zfD0UsW1PTCrDB5sXl5V7X3mRAOGWYCmVU5rcgGJM7DGPeQE5ov8AXFMmbrZforwXfubf8EwMtan+SnjI5pUwXWwjUMuTI8iqJxPa9c6GexnmVfCwho7BN/tDzHyhmrBkrpfQ2UeXAYf964/1YGgSGGfdQp5fiF3oQ31++xTkEgITcIptm38gH7o20yShmxuRL9hG2WLmIqJ2rGPw/xkGw/YI38JsboD2lVAF9Bwx5ktsBZ6RRQS7vTNtvkndFW9X8sG8qQ/vljzGNZEJrsXzLCIcSBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY1PR03MB7924.namprd03.prod.outlook.com (2603:10b6:a03:5b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 12:22:33 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:33 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 9/9] mmc: sdhci-cadence6: Add DLL master control and
 improve tuning reliability
Date: Wed,  3 Dec 2025 04:21:39 -0800
Message-Id: <204e8d92cad8d609a18006a4848f2c5a57f6b495.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1764760325.git.tanmay.kathpalia@altera.com>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY1PR03MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: dd24e74e-44c8-4157-da9e-08de3266a2f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VrUhG0XFvnX3n2cvvYaGmPNb/0+FF2Of2u5n2cofQ0wtO060xK/8MadqI9qk?=
 =?us-ascii?Q?HyEpPSro0vv/10omoqcqL3D1DsGhNR0YrrHg3S5C41DKWDwImQFyx/nlF1F6?=
 =?us-ascii?Q?OQWb9jsi13T1TBxEzzN7Vvw/5G3EGi6oPwfcZCPi1KAt0aPQ7WZ7bqzxdC4K?=
 =?us-ascii?Q?hyIEgAwk2FWsVQAfOkkvsZVoxKJm4ox2fVnP5WZQs6CEXGFPhtHdPX5+BPFr?=
 =?us-ascii?Q?Y3VuI18kAUBTziURfKJK7dvo0Jext6hjzq1RZDdX6SAkxBFEMq5U2zSI8Sit?=
 =?us-ascii?Q?tBFaMtiN2069deaOEwJVanLcf/aYIgo7opzJj1W8ayrgTN7EbZZYvUG0zwYL?=
 =?us-ascii?Q?tLGThnoGjhd2t96DTNmrFVytNAFxXmPziezjt9Btm7IVdVwTrCRW7UI8/6Ip?=
 =?us-ascii?Q?npzQFMo3t2NWKxUHzZuPTm9fWHwHeOqt7fgq7M4DbeSdhVjt2dNVPfQ2VSoW?=
 =?us-ascii?Q?gR1OljuTDud7flY3JRu0iiPlTBrLhT4RzImpOwx9FJQi2sBS10zEZEpMq9xd?=
 =?us-ascii?Q?OxwftWyZpp7j++NCumlh1iv+kKBnJE1kKrV3z/o36w4LUtFEt2sFKUs0aSdn?=
 =?us-ascii?Q?Dvs655zyY3+ypvwz9Y7lclHvcNBeBSnzVnjx7/q9959ZA4tmSzB3j37lsIEF?=
 =?us-ascii?Q?kuc3+byfNWQA2ibxQoXRUsvYNgZ7Xyv8qrlWG3FbupR/QsiaSTR1CLDAYklQ?=
 =?us-ascii?Q?gjV4ShOkdD+5VweOrncsRh1uB8SHENJXKWEt7RW3L2HUUtN4B3XuQJn7EwcQ?=
 =?us-ascii?Q?5h424Djw7It8Hu4GKekV3QxfdpmKFcoMx+C2s3GGnD5mIUEt4bsPzMkewOVp?=
 =?us-ascii?Q?ndhdyPOwSldjdhZqKnFbZmznm7UKtxp+u2KdstBReQj0QVp361QrzGoPma93?=
 =?us-ascii?Q?ZP7MTX1hXCVIMD4y8ES8KZNasoG+IQ2eDerpId1Sgcia1Gu2yBnnDdNbWQ3e?=
 =?us-ascii?Q?R7BVkau2H1EDhbkS8xwz+S7XtBOWbduMiVDbBUK8Qun8RCx1+Gqk1d5y8sCK?=
 =?us-ascii?Q?TY2gAJPRe5IQnHLiprd3OkF4XumR6WtHdqRbNOzwChv8utu34xIgm8r7IhX8?=
 =?us-ascii?Q?rCVmptUI4luqv5Pq/xthYvEzXP6vC70YjaaA5SlBHlNQ6/zP5bSEWF4z6Px5?=
 =?us-ascii?Q?Eurf+oi0UPTwH6iMRrjTmGc5qcL7Z7ooWaI8zsW+VpajneYVDgftIvrcgj5X?=
 =?us-ascii?Q?G1pCr5KwhimOStt/ie1L9qc1tVaoa4O5KIE3mmgd9tuEDQPTk0tVu+sy+Sbm?=
 =?us-ascii?Q?Q8oBUxKhmTxavj/fdzH/876a4dfNJZEUk8L6yEBqi2o8siSq82tZ9od9lwse?=
 =?us-ascii?Q?rwPKdciN1diCQsi/VJ23GeewMABJdxijD0xj6vEU3lHgfhj/d0hoK2Ck6sEI?=
 =?us-ascii?Q?JrqoxbZpv0n/owRXP9I8TT1pQqni60QhsQu3GOkJ84XqhzDJgsUPZ0ieZvNW?=
 =?us-ascii?Q?FdC7g2qwKQekuPYKwi0Ao4srZfsoi+59?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zr/Is++j0cLekY029Mukvvyka/hhDP3EAtdot6BjFEZMYAJu2nq1CsMWQviL?=
 =?us-ascii?Q?NT5JvuqhwNP9NHA50f9NSKY/mIZjO6NTppc2NtTDxUe9VHbwd9alftfZuS5C?=
 =?us-ascii?Q?wGT/1TdgeCxPoEOWA+iFZG1kHWReXzJpFFizoHgnhsunUb16sJYY5o3rCOPJ?=
 =?us-ascii?Q?N6xAAF/J9CBf0R8marA+ZwHwjqmH9h9koWrMt4vsbn8qo48awLg6ZnXL9E+t?=
 =?us-ascii?Q?F5e9cuPYkZWNm21o+SZ+EzMoP7C+PQwMT7UG+iuFuBBat0Ry4747ltf+95Wn?=
 =?us-ascii?Q?W9dwURZDXAY+3U+Hd1p/udSU7D/3h5GH3E6yG2VdDFZjpzQFUWw30eCouQtQ?=
 =?us-ascii?Q?O/6o7aXvIOmMRqmKEOOjEHcK7AcDoUwbnHv1UT+gSoOWzBbf7AqG26x02kCP?=
 =?us-ascii?Q?8TV+feZY/cRgHvbvTLGTnGjRYWHKDwHXP8gahx6V1SIs50xQ+XqWNf0wXwIS?=
 =?us-ascii?Q?BxO1w8Ar4L4n6CdngNhbCbdS8fzg6ENmDNqvxHYLzKGNquezdv4OZ9IOAjU7?=
 =?us-ascii?Q?Jq00H/3W3lo9FVXqHux9KfNJ7RMkzzP5cqUmbLlgiZb76VVneGyOZFoTgJ/r?=
 =?us-ascii?Q?Tk7umFzZdZfJox1nLjf+M3qpq2Jpwhz73Wpt6zMkkl9xG9zNWAnXxvXsftSh?=
 =?us-ascii?Q?yqJ/UblolJKb8FK6ezrVvUoyVnD6Y+ToaaqujWXdlOW9PHoysoF8nG8gRQmQ?=
 =?us-ascii?Q?WxEZ7rt1bRb6PPFAZ3ZnZ6qG5khXVvZKOiKUa/7BAL/c8Zoh71UKpTYUgU/z?=
 =?us-ascii?Q?gvRCkwZtltAEUcVZFCmWL068Je8lX9CzY5qxRfNEG02+Uk8MfbAoHN4sNO0I?=
 =?us-ascii?Q?5pyN0AorFzEny8xT+0P2epVUfNDCuy2KhfIXNMS17bVBzmci9wYoASdamBUX?=
 =?us-ascii?Q?tpANLOwseC622RnWDW1JoNSIADBG6DWhiVXof7EfcZLgI2DKk4a3HQNI5ejn?=
 =?us-ascii?Q?cwWNKZEA5t4n16gtGsO8g4Yj7yiN7Q2Yui1LvuVhQcJi7s7UXV/puE0JeILh?=
 =?us-ascii?Q?ravnqEVHFWuu3FIctkstC/jKjwusEWucufEAffUN2QzxIEmoPmfL6oxF3/8S?=
 =?us-ascii?Q?K8e03GT1Sa0Q4HqP40vRGlr/9fly6IYirCSQ/QeiNSAB6/slQMiIRg/53kXZ?=
 =?us-ascii?Q?0Gg1zw4SmRPiWOumytZ5XSanXWzEZ6knJxndIJy6XbZ3VUo+mw5P29rWnlEW?=
 =?us-ascii?Q?hV4yiZBUrX9XVDzIw2GP1NT+dZGxBrHSqRBuNCfWrZEPec2lvaGiBbBAS8Cd?=
 =?us-ascii?Q?NZsjlz/rz6BlQfj5Oxhhgetaz3pHnXuY6hM7IOp8DfSTQYV4/jmZmWdkwtI4?=
 =?us-ascii?Q?MadlPfzWGKifEsOka1Nx2NWshuLvTL79lwF7N6Z5g0OBhLvBmd2qVzwmgSX2?=
 =?us-ascii?Q?K13lNf4U78hohGqg7kOiVCi8OjWg+L4vr+bSoktVUY7YNDRIku/GhdEpYl2v?=
 =?us-ascii?Q?KWM9Wk0v2tCWbHtIZMQ4NtXmspwHZ1hILN38SxbNfxRRlPtjdXNkul26EIIA?=
 =?us-ascii?Q?K6J6jB8Q9j0VlBHS8GKbIkL8sWj+4Ayvv2TbdcebcgfW/e+u8CEsg2XX1HKT?=
 =?us-ascii?Q?IdiSVUI5p6ldkrDg2BrcW7GG83HaCoS9BDfToew+qGCweWHyLxt0Tv2phKs5?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd24e74e-44c8-4157-da9e-08de3266a2f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:33.6363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSfLVtYD30F9SenBbtEA1m0v35ylVqfBpB+n5jWYU2M1KELxwHPbAfEXHKADI06esLXmce63wr0pvDpYfDHIpvRWXT4WcIiAo2qEFSd2KM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7924
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

- Add support for configuring the PHY DLL master control register for all
  SD/eMMC timing modes (DS, HS, SDR, DDR, HS200, HS400) by extending the
  PHY configuration arrays and writing the value during PHY adjustment.
- Fix tuning reliability by toggling the DLL reset before and after
  updating the PHY_DLL_SLAVE_CTRL_REG_ADDR register.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index d9467293807..91a245aa490 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -58,7 +58,7 @@
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
 
-#define SDHCI_CDNS6_PHY_CFG_NUM		4
+#define SDHCI_CDNS6_PHY_CFG_NUM		5
 #define SDHCI_CDNS6_CTRL_CFG_NUM	4
 
 struct sdhci_cdns6_phy_cfg {
@@ -76,6 +76,7 @@ static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-sd-ds", 0x00800004, },
 };
 
 static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
@@ -83,6 +84,7 @@ static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-hs", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-sd-hs", 0x00800004, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
@@ -90,6 +92,7 @@ static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-emmc-sdr", 0x00800004, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
@@ -97,6 +100,7 @@ static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
+	{ "cdns,phy-dll-master-ctrl-emmc-ddr", 0x00800004, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
@@ -104,6 +108,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-emmc-hs200", 0x00000004, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
@@ -111,6 +116,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
+	{ "cdns,phy-dll-master-ctrl-emmc-hs400", 0x00000004, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
@@ -252,6 +258,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 
 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
 
 	/* Switch Off the DLL Reset */
@@ -296,6 +303,7 @@ int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat)
 int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 {
 	u32 tmp, tuneval;
+	int ret;
 
 	tuneval = (val * 256) / SDHCI_CDNS_MAX_TUNING_LOOP;
 
@@ -304,7 +312,18 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 		 PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY);
 	tmp |= FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY, tuneval) |
 		FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY, tuneval);
+
+	/* Switch On the DLL Reset */
+	sdhci_cdns6_reset_phy_dll(plat, true);
+
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
 
+	/* Switch Off the DLL Reset */
+	ret = sdhci_cdns6_reset_phy_dll(plat, false);
+	if (ret) {
+		printf("sdhci_cdns6_reset_phy is not completed\n");
+		return ret;
+	}
+
 	return 0;
 }
-- 
2.43.7

