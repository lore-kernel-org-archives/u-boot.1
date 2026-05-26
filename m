Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1E6CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A861E84659;
	Tue, 26 May 2026 08:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LziSittf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8BE803C6; Tue, 26 May 2026 08:08:34 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 557AF8039B
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgwcFpswFqHK6gIByeplyfp83HgJTLuRY2yr1E5bdlSQrBmXDzxCF6+dX4yZWK1CQhqd2/ZOYRppcHZrb8tC6DmHHPeuk9l/ZnLyiF+XB/zNXDzdFs0PMn+Wgg2Pbm+Qxj/Op0ZUCRNPiCDudNF4Q5MtQDbnKHSwdN8I0kAjZwCsuggC74bJqLXXAt1TINfE5Xi8Wlai1gwuTKb1lOCpvETr4cHm0fvyKz4TuS3SPnqtRYITq9ljD6nyK5HqBPk/UbUGkwxuGnfCXT8JjH3ZsSxKH73oQos4hxHZ86vGIEOt1UYwerNujJ4EnMUN1db/nwa4T22cLPSRvXG/td9vRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIzOeb8lxjgFdCOKl4zPWpwBiHkh9L3aKzgnOq+9p+k=;
 b=IiAQo+haaFp5pBs803ziSY3DESz5EW0Tatccw8maGmd9ApKSEZCthWKT8Irr91uz/mCb53BAd0xpTMyAQDW3VHovg77oDnUNRP7lm4im1gm4BlnVgT63gaWvGnKwXMCEhJ6vsVFCJMocoAEY3MEYwqSQHe819BXv76OoDZnlMhRUzQ8j6xy9SqQY8rVlR+EoptS3IdSc0JGe8N1bDMASfHJzoOYnDZ5OqHcYR2JbZ5XtF0upyh/RXpVoInmz+doJnEWDIHWfKYHKGaGKtAhkGnCI4NZvK6c13DjNgVlWYLnoNYkCZWcm6Ags/CkDW9vc3LXmMhKM4Bp5i0ZwiZQnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIzOeb8lxjgFdCOKl4zPWpwBiHkh9L3aKzgnOq+9p+k=;
 b=LziSittfeiaWQ0D2nT0vjtR9sshf+CvVM1EIhn7ybFu9wveOaszKG/uFoKtlkqiME6D4mg5JJpPabQD7fm5ENY2pjYijwFKiqiBARX9dY7t8ozqeFFZTxUQYzFEoLwxAdEm+JO8+nUvYOnGLIrgjgvC1WmaKEULQmR6My7/8d197mt5N0tFiHWhAjTOTS5ZQfSK+Bbn9/kVO9wpTjifz0EBrAoGe9yYG2xhEAp+fimJcQalGL4hiV7LcnFU8T/xnt2Er0J2WN9PqbU+VuzYbbwU9O1Ith8ZZqJmVUNcZ7e4Jv//obAsUB8s7YjmDP0GoZ6MMCy0m/hmJBBba6pI+Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:08:30 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:08:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 15:25:10 +0800
Subject: [PATCH 1/6] net: ethoc: Use dev_read_addr_index()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-net-v1-1-be3597b85b5e@nxp.com>
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 835acb17-6893-4a08-d1b0-08debaed3563
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|52116014|7416014|18002099003|56012099003|22082099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: m3UhWR/dWUxIeWG92nLwL8d8hIrRgaG9VayiMP3Hjh/BtwU121vtXt29OVdfRCtjHotdRQ78sAexLIBOUyClpDLsHBj/sD2x3pnKf//gPJS/eBm7+OwD4V5vDPH7b/Rgz6g7Bf0cavMDlBfgGU66fEz0Y3OCEvlUMzkRDHFa5cM2KeHmfdL6WGYcQ1Rl/5mG5qjDtncpgRmdai3xf8fSIa7eS+pRLYak7Drux/YE0uxEaIYn1YUMH3foMnNA6mppl1ImacZyQE5dx7oRH9Tb6B5p5M3F8yskd+3v/JpPPd4T3ADE34FWwveK26CVjvieVGoSpdw0MVptZjkUOaOyTM+EkQ1QHKaMRAOdqbpUO0ondci89o8aOMLgib5wAuqmzQOuJO18EZuKiSmWm5fFrRnYJW6xJDXf1IJlijBOXgEVqlSszTPcpEjS3JabNIg+vD3gGwhSJl8yRIC5uI0nMIhem09KzdulOj2uG2nf7b6tKynnYrJlO7zJzb83AesYWebagVhSNM9tMAw3NyagpsatvzTGo4hP6ofJyPivHu3BauYUKLktXXa68+Dp1MY6R++PwfxmT61dcm87zHVYx9FwPRRB3hPMQ+tzolSjepwLXw+bfDcyD0Iys34ZEZs5wS8ZhsGPMXln6MiDD/b8R9L4J58HhYXOL+f8pFTlaaN1O+8vuBR+8/2yJ/eUYvxrIYn6hhKHv+pBRlAut4qGq99vXJeyVTPP/5Rp4QsOmFK+7KwIz1KAxS2EqZiEpR7+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(7416014)(18002099003)(56012099003)(22082099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUhzUWd5M3l6N1NTQUVKWmhPQTJDdWRicE4yRVQ3R0hwYno2dUtHaERUSURx?=
 =?utf-8?B?TS9CcVpPT0xTMVhpZVl1V3JGY0pIMzIwSElpTm9BMlg3SzJJOHJDMW5DaFY5?=
 =?utf-8?B?amhqcHZmMyt2L1JJYm9CWnoyVkRFckNxSmdkMkFiOVRkd1lYQm9lSkdjNERZ?=
 =?utf-8?B?dFZjQVR3cFV2bytxS3IwOGNWRGlZdFFiTC9yTjdlZTlVc1hBcm1LcFFSVDE2?=
 =?utf-8?B?UjQyOXdDZUhUYVU4OHpsQ0ZJR0NXOEZTTUhEQ3pQbExXTkI0OHRQcStKSEVM?=
 =?utf-8?B?T3JGN2JnaTl0RmNrSVVlUndoYjR5QUVLLzhhcGtWcjVNU1Fkb0ZkUUFqMUFI?=
 =?utf-8?B?SjFDVzNwNVArclVXRThBVkg1SXllVFpXUTZVWFlES3BzOE1wSit2ai8wZVNl?=
 =?utf-8?B?QnFNOFZUbTZPdEZZaW92Vk44Z1lrc1lYckZncEx5S0hFdTc1eGxUT20rUXRu?=
 =?utf-8?B?NDNENXQrQ1E4dFV3cWs3ODM0bktaTVpPeUwwVHV5ZE9UUWJ6UjB2MmV1cnlU?=
 =?utf-8?B?cXRFNnU3R3F2THpqRXdFUXlvTEZDSm56aUUyTFNHb2ZINFhpWWQwck8vcmdX?=
 =?utf-8?B?NDc2NlZsS09ZZ0lvL3JqNUJSTnBnQmpHbkt3djlEemc0UUNwakwycVBKN0ho?=
 =?utf-8?B?WTVUT1ZZakdENmJ6aUtCcFhoMlVtSzYwM1g2eDNlYXZuNlRENjJERGhvSjls?=
 =?utf-8?B?QXE2ZGlFOWtzREp1Yk9uaHBLNzN3RnFzWjhMcG9NWnF4Z00vTU1xQ1hyUjky?=
 =?utf-8?B?aVhiT0FwZnNnVlZDVXJnSDhwY2NBNUE2RXdjcmlaY2YzcStObGw5ZXZSYXZJ?=
 =?utf-8?B?dTJWSTdaaWZCM2hzSFlMOW51LytJWHFkN1BiaERDSllwa1FJWlJEblFyTEpq?=
 =?utf-8?B?MXowSnhBdFhwSTFvVmlZOWF1QTRENEhIUnFwOGZlT0drU3Z3U1VoRWVkbURS?=
 =?utf-8?B?MmRjMStnL3M2TUd6NVFGb2gzcE80cEZydUhyMmVpRjFPSGdQSW5iYVhhcHhE?=
 =?utf-8?B?STFEVFZvQ3hGVFZLMm9SQlk5WXpMd3pkRnZQWWUrVlIzMEJQTlpCMHRsdmFu?=
 =?utf-8?B?MTQ2M1Fpb2VnTFNxSUZKN2wzZ1hwbTNTYTdGNW1abWtoOGJJczE3aFUvSGtZ?=
 =?utf-8?B?YkVHUDJpcHNGZ2c4ZFFqN3czNGo3aDJFaU1mWE5laGlFQjdpN1RLTzJTMWNo?=
 =?utf-8?B?RDV3OExwdXJNNVpjcnNuSkRUOGczblpjazVSVVFGMExWYU1lVEs1T1Brc2Uv?=
 =?utf-8?B?QzcrdXR3TVVncDVvWFFPNHpnSGwzcVhWcDNqQjNUa3E5VXZuM1dUTXhQbG9j?=
 =?utf-8?B?Yndmanl6SGpwcHljNXo2RWJ6cmJ1OWFkRmdBZGZvdG1aM3JnOE9NdWhXcGox?=
 =?utf-8?B?anRBZThhYVc5a2V0WmdRZ3gxaUI0S3dRc1p4ZU1rbk45d1Focm1jTWRYcWdB?=
 =?utf-8?B?RjBYSWNkdmVqQy95UHlFWWw4bGJyb0JPWm1DbUpmcjRNMlFnY3dQc0Z5YmZl?=
 =?utf-8?B?aWdBRFZsWDh2Y05QT2xYdEFxSmVMclFHc2hyQTUxTHhiaGJhWXZvaFZoUXJM?=
 =?utf-8?B?TVpmbGtJWU5PMVUwYTlhWTBJSjdGeVVOL3dESnQwdzN3ZnlCeDN4TWVnV0NK?=
 =?utf-8?B?MVJIeEs0NVVFVXovV0pNSjZUU3UyQ2Fibk5BeFljRXpub0oxNVl1OXBsU1FC?=
 =?utf-8?B?QmF6ODkxdzJnMys2c1FDUm5zdE5NdmQ5aFQxTlB5aGlwK3dFTkxPN0hqYmlN?=
 =?utf-8?B?M1lEQW1XWnlWL0ZtTmxwZms2VmxoZG5nT1FzNkdvWVR0ZW1KcUZYZXN1UDJz?=
 =?utf-8?B?cE9sNlJzVGlPMzRPanQzemlKRDJTb1pVdWhyK3lYWUoranoxNHFpM0ROdVcv?=
 =?utf-8?B?dFIvcStqanZhQ2pXOTlidVMycy9hUFJDRElLZjg4M2xNYXhRc1YwKzZ3TFVL?=
 =?utf-8?B?TXU1dVVvdjVZVG16em9kOWtHT2pZK3hLYXVpM2RwN1Vxd01IaHBPSGR5b1lm?=
 =?utf-8?B?RkNVclJuZUlCb2U1YlNhNXh0Vkg3bDFMVTAwaTNyY0pwaFhyQnVxU2dPTFdp?=
 =?utf-8?B?aHNaNVVyUVd3dzVNbG01ZlVFdzdhVGJaQ3hLbmU1d1RKMEdJRVIwR2NacWJj?=
 =?utf-8?B?SWhlZ2lxM2ppeVBTU0N5clloYjRtZi9PR2xXMDFIb0xFYkprenlYYUR4dzVN?=
 =?utf-8?B?R01vK1U0Umo0aXZPVjkrU3dkRXV6UlZaNkhEWG1YeEJtWFNBVlZ5M1Q0eS9u?=
 =?utf-8?B?N0J2Tmczbm13N1UwdHFneDk3eHdwTTBZRVhxclBaRDhFWDFRYm5Dc29McEpn?=
 =?utf-8?B?TEQ0SjVVWDhSc09MYTRJT3NGSG1GNE5Xd2szQ1BJU3VaZGZQR1NyUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835acb17-6893-4a08-d1b0-08debaed3563
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:08:30.0026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFJ4lNBQZasBa2WmmJFG8yVEmtP0u8oLfdBQ4UJK0fGYKQOoFEGn47Pc0bSnEu554H+Q6j/9OJ3Wvhj04Cq9MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/ethoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethoc.c b/drivers/net/ethoc.c
index dc7e6f1929f..87b2b3426c8 100644
--- a/drivers/net/ethoc.c
+++ b/drivers/net/ethoc.c
@@ -686,7 +686,7 @@ static int ethoc_of_to_plat(struct udevice *dev)
 	fdt_addr_t addr;
 
 	pdata->eth_pdata.iobase = dev_read_addr(dev);
-	addr = devfdt_get_addr_index(dev, 1);
+	addr = dev_read_addr_index(dev, 1);
 	if (addr != FDT_ADDR_T_NONE)
 		pdata->packet_base = addr;
 	return 0;

-- 
2.51.0

