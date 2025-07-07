Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C887C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACBF082CA4;
	Tue, 15 Jul 2025 08:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eutefOPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2606E82F8E; Tue, 15 Jul 2025 08:18:48 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089C28277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxjSELLYyU8WMHVArf/82wY37HhYzPF8h92E24De31i+Twx4g/Ha0TyA6Alxk0nLFujYAQ0wb3JucIAW//46c1oNC1QWv8dgFQrH0rzafVh/PyAfuSxabF7p+a9kygKaUEl8Z/FO+aQgQFQHo4Ijl0uoxbckovRbLPcDVrjNEZ5iRxpwrV5zTHqF6FCSOagGr+KyjjS2Tff1nW7NKDFUY70BJCQcXVbHe2JYcOoVRouRduRY0J+V7Z2wu/0UetzamvL1hrXBmWH9UEWWSD2KUxwmWPEGJv31pzhLlWSmHlAs9rOfBShfsFw6SO3MhkvNU1XxwdlOviSextsSiwe45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kyoef4hFjo63rGgFJPin/E3b6FHM5m9gxKnwYzbVF50=;
 b=fPmXobSjoZitbDvVudbptollEXUN6h1f5ZMpTlWLazynrdSbvP7073izgU+ra7g/Tqvk9rIAEYxJ51gDQrzwyey71+JmOwXxHqC6daRVhOLcnduB0TqVBZhkp+yhX96uDYPT4NVdsuH/ToG7uWcNdI9JlqIl8xoXoAsjpfSEnXFumiu+egrjrP5W1JNm8uZB+oVcoEioFLamHwieOiXJzbOOvpgHBLeq4uvIWxfIpgSnhA+4DSoSsjRizwseJXBCKDENHhQUMHs2DbVJa2evFdmNUbWa9CfDQENBLLsBU7dEmNm+3QHsR8oaZd1YYwiu6gBNWuL2xJ4Rif3RuyWuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kyoef4hFjo63rGgFJPin/E3b6FHM5m9gxKnwYzbVF50=;
 b=eutefOPVgrBOr5hP5fpuLiZCJ0pZouqKgnnYLD3qgHRrLHxoOVtZHlFbKOy6Q6hfzag4pHfHaiezmYgvUSBDxFWUxcfirUXR5mXxcITEgX5xfeyJqonuOwHbm0ZuWhaDq9d0pNaJdLsudaiWVG9YYWB8KLRiIfC7vxa3466ylmT9iflTZqNPPbq1MwhykI2qis46EL8PW04+CVm+k7JsOf963sGAz/io9s9AbmJ5UqgDvPZ/2pqBrs0iczQ7mb5LaGqglx3ZQN6th2fy2W9GDXvxJylycUgTq56ezg8LBurwcYM+rXinSTHZIlNU1BIAc0350q8DuDcma1vvtCh2+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10605.eurprd04.prod.outlook.com (2603:10a6:150:20c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 06:18:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:18:42 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: lukma@denx.de, seanga2@gmail.com, trini@konsulko.com, festevam@gmail.com,
 alice.guo@nxp.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, peng.fan@nxp.com, ye.li@nxp.com,
 valentin.caron@foss.st.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] clk: scmi: Fix clock identifier passed to struct
 scmi_clk_parent_set_in
Date: Tue,  8 Jul 2025 04:20:34 +0800
Message-ID: <20250707202034.385890-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10605:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ea694c-abbc-4b79-1f8d-08ddc367720a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SoplDw7SpxAr9GWBT7wuQiTRtryd2bcRg3+d9rKfAPmdnbJRRU4gE907NQ1F?=
 =?us-ascii?Q?Ja4z4dm2NjbtLXC/R4ChKeYPO3R2KCKHcsSKF6AUMtajZHHcxYJxoYXleBIL?=
 =?us-ascii?Q?X8gEEWfuevThpYkoFdRkUUG0Q7zU/hCF3CKpB+pHElfUspTT3WpRS9Pw7ipJ?=
 =?us-ascii?Q?ZW+y9ffjrlm9VlLHs5r1ldRRuYt3trw1F8a+hYrBIH5N0XerTJ+qOyZUh7Cx?=
 =?us-ascii?Q?7U8Z5a/j/FJ3NHf0wvecpI4cQA5lIVcWwa32psDzT2K+j+rgpz8CC2TS11Zk?=
 =?us-ascii?Q?F6SJo4jgVUmvQ9zuSwBVrUFjpv/DVdSoQ2f0CQcEdAmDh/x2dhFErciBOIHr?=
 =?us-ascii?Q?88OYgVIvfoPl85GLeygcyHlncBobimmjcfN7cw1oLE5GThZMfxKFGPdPsGdT?=
 =?us-ascii?Q?IgJhX38xRkdwoOLYNR+rmBAp02PgAoyP59iere4I1vWCHZFlEkzJKWEr0//Q?=
 =?us-ascii?Q?jLFOBzRbvd/15Be1CYYjVjVVBVv7G3dh3z6o/ekoRZX+fVQEshxkkOlsSB9L?=
 =?us-ascii?Q?CulGc22yEeDLHymIqLVcWqPBDGkVSxKUrOh+mRMxuOOgIjyG9W0fcKRAWKaS?=
 =?us-ascii?Q?HwD+hmxejWCSNtdKn9oiMfns9EUI13w6ceLw4gNNxXU8ksWLvJplBcftdhP9?=
 =?us-ascii?Q?d9VRlx9jFoPmJsazslv+ZmoHxBhLTHeGv6WqsFvi9PBpgRza9ddLzoeJResd?=
 =?us-ascii?Q?bQ13OCiSg9GoVsPOqXZWQa+NO2XgdPVrewnnFWY6vLeNsO2OWuek3wTNeLx+?=
 =?us-ascii?Q?6pdpfodi/IVy0v/PdKpFbicbLzR0LwiAdNhW1r7vFFVVms/Xn9pQZo3kN3pS?=
 =?us-ascii?Q?s9In9RqBlTOmy1GIwM6C5u3pUYDZy+KUa2bxehcfTK+C2mfbGuf0ClxuqVuh?=
 =?us-ascii?Q?3XQqiOLs1Mp4GBZeEu7ahBWyZ32p69yYesEm5EEYwHI8qcxieGZ23J+TChif?=
 =?us-ascii?Q?ntF09HCXHiPsyzqyvn1njMiKvfd1HyZ5TVMyI9jJ3S3+Jn2OkWTO0qgL5+yR?=
 =?us-ascii?Q?c801JFcrblU62048Zzgp+PqiPeFci5LiqeAbND7GQCD76xoe+tzWFuX+8J36?=
 =?us-ascii?Q?4POSD9Gp0ssnCHAB3CWCIemE9omf4WB4gzTosWR4lA/sop6KMaKI//5J8lYG?=
 =?us-ascii?Q?W8JTwZqZoIkJ3xHs3qUqbnkI4NO00/q51rXBS2cwQNeZZMUgLQMf5gj+8YZD?=
 =?us-ascii?Q?sU+BffBtcfp/XV776zlN6ABQrYt1W1OXwYA2JSmqL+4oFQ6LXQOTOL7MBPlD?=
 =?us-ascii?Q?GnnIFVxFPwPUVg+ptOfm5mesWgJerQCJ3hXYmRpeK1EiThSr4dfN7oNaaoOd?=
 =?us-ascii?Q?yR705EvEZVoNmlcFGeBoWvANc4IFlkMoc414KSDWNOm8wAz6WVuFZZGSqI6O?=
 =?us-ascii?Q?JqssjKhY4OFviAx/q7x2N0oJEfVrPPlh414yybFqXOCXb/f2Ly3MbHfJv/B0?=
 =?us-ascii?Q?ncPkLJn4fk3xCFKbBJFR1zQb8+28Yv7E9Zd78/70AgEI2wlg3IFfEcCocxc4?=
 =?us-ascii?Q?1O1S+mc4brZNx2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CmoFftyjny/x0oEDQgVP2sF0iFHM00OZo9K02SperFvqqC+k2VUsJmk41Bf0?=
 =?us-ascii?Q?RBXFlD2kIAOYxawx46QNpOreDgM5FfY09eLwxmtj6ez6PABTiSo0HYEAMzWh?=
 =?us-ascii?Q?jC9d/b7tiko+4MAxdAXUdHy4GbGvkCNhEUneSIDNw16B8U0kl3mozHaqx4lo?=
 =?us-ascii?Q?XWd8yUuAMEcgZYQUszbmRNO6Qa2/abLkqM/w3SgWWq7k1FcYBX0u07LKNjZ2?=
 =?us-ascii?Q?ihGqJzLJPXzP6aWa3GOCLYZI/aN9mxqJj4mm80LZXKSsxMDNCCU4/TUM1Jy0?=
 =?us-ascii?Q?Ipebdewq8yU36hZEbMMwAzB7EJYXehlf6sJL3FxBFLLQAFvtJHOndEFdxGJZ?=
 =?us-ascii?Q?BwNHrZL5/J1jfYHcJvvTGwuuMHQHDGrP4trrnNLQLgVptwdZLa9gnYTHqmZg?=
 =?us-ascii?Q?1RJq70ABqZWyglKPNKLIF12+GE7MTpxSpRzUDhfwkRnlFFbqDZbWLTpLUBbL?=
 =?us-ascii?Q?Gpye1dfLX2Ij+UC3cdY5pQSowMwUE9gamHCbZTgVQF+XkrbjKYqFC5CPa54x?=
 =?us-ascii?Q?c6wPfAi7jPEbwGVKH72ngZ+ITZkxCsZKOOmpvm6dda5wqXdpo88hdlG5G8DA?=
 =?us-ascii?Q?iRx/dCWc94WNYhwddorusPFA/QkaSLgT7nl0CWp95K/q/dv/1+WJS6FN980r?=
 =?us-ascii?Q?Vb9J5kBm7S4ATd2D65B488TYCeZboIrIWv6QuU1Af9Lrab5+bfWPt9nGoHy3?=
 =?us-ascii?Q?Zt3nLX0aeNZrKDd+JhHjcDpIiySzEIhDCYpKx3164Z0m9g94qUQlxTq2+lR7?=
 =?us-ascii?Q?fb/r7JTfWcjM8rYi+aPCM5a1xvwVm9MK70u1U9VS1kONGX8TgR3GeUaxDlbX?=
 =?us-ascii?Q?20KDNYHDnnuRyhC5JsAEo9d5cGOGXPgd3nf3exShbgcyjZKk1kEYAnzyYGGL?=
 =?us-ascii?Q?ROxkoM5yajqLVruh8Dc05Hd692D+dBycPDU/u65auvrn4iL2tUPt2DP2PGtA?=
 =?us-ascii?Q?2Im8eCk6EP5FgcOy4WxL4dWJyQrzv709UpyFOc9979TjXddPr6NGZRQNghr5?=
 =?us-ascii?Q?TAAgsZecqJRc1okhhn1CE9a9fhPbHUr8sZWLDslyEF7KRJtvy1ezFcSOEzjL?=
 =?us-ascii?Q?6W/rm/IJx52ne5KQDmt4m319GMtKcfh41fE6UH/Z8NDAbDVUXZyVZQ6oiaL3?=
 =?us-ascii?Q?T986vfFmKNINqH0gRhw0FkxO/XM230KD2mcc2M5WkKRx95q+sONjE9y+smF0?=
 =?us-ascii?Q?1fYZMXd7BVbR1aTkUQMg4lM3bvnX3v9yVkaF3Yrjazq+7j8hfIwJ0eRclCVT?=
 =?us-ascii?Q?rlLQyOIScmJANxfkEGL5qKwb4yG04ZvpYahnqesTZR7GX2X4AVT5YPnYqnHa?=
 =?us-ascii?Q?uiPFKdeeYoUORbSo3prCHibTN341HAIotfRXEB+2CD7ouexeuME04FRWJ0NU?=
 =?us-ascii?Q?sGyd02qey8wRQ6reqj5+EmR8BnKXiwFx2XMbaBkkoRbe2zVfl2BLYTa2geQN?=
 =?us-ascii?Q?Fkq6vY3x/N7vswT1HsfumgInzAAxgOoXz2EhvV8zgO9/JspYunG4CbV8jFhX?=
 =?us-ascii?Q?MysBK30i63OYP/orxrLydvgr0g4AdRDKSk+iRJqdiKu58dcs+SlXR3s9A78G?=
 =?us-ascii?Q?YX9aJmpoFl7FnH/vuNQhhW1jIJ3Vig8D1iR3OVlp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ea694c-abbc-4b79-1f8d-08ddc367720a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:18:42.3369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XA8kxfJyrU2y5dNSu+w9wkywhlpigVSOONcBbncA7hPbuOVnUvHwMCYdZ1N7DE+QQa8CSeXTCner9MeuDK3mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10605
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

From: Alice Guo <alice.guo@nxp.com>

Commit aa7bdc1af505 ("clk: scmi: manage properly the clk identifier with
CFF") enables CONFIG_CLK_AUTO_ID, so need to use clk_get_id() to get the
real SCMI CLK ID, otherwise wrong ID is used when set clk parent.

Fixes: aa7bdc1af505 ("clk: scmi: manage properly the clk identifier with
CCF")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---

Changes for v2:
 - improve commit log
 - add Reviewed-by

 drivers/clk/clk_scmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index cfb372e6190..0c9a81cabcc 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -336,8 +336,8 @@ static int scmi_clk_probe(struct udevice *dev)
 static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
-		.clock_id = clk->id,
-		.parent_clk = parent->id,
+		.clock_id = clk_get_id(clk),
+		.parent_clk = clk_get_id(parent),
 	};
 	struct scmi_clk_parent_set_out out;
 	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
-- 
2.43.0

