Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5378DCA1000
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF1C839C6;
	Mon,  1 Sep 2025 08:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a4hYrKY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDE1831B4; Mon,  1 Sep 2025 08:33:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704A383987
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFIX0X/HZrK9UvaCFZyyVflhQmN3eshaz7ZxUEq+EoZENJ7F6RAiOuXxyYKWIQ5FfrkWjVWtUfuvJDvkOZ4KVEeJMycwuf3jd9YpmJtUOfV3Up2HliQO5l+NT3vg+dI7u2KB+wv9JDXPWA+kfozvNgzMOG6iglw8+hwrtSfYKXmWf69r/vReM6zS7NuoQUEhnqkU26Xxz13s+wHWpu+DZCdBcyqHGW65gF/eZFg8xVptgxCsDzUNXhGMqv8ZYlHwCweJGnzsAIkzc24Gvn/qPkhbxK8GeZ5mxnCKqTX50R+JQMdCV/nRCcR4dtx2Ofng1fPNSFlZsxyyB/jMDr6njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu3EhkOY2ktYtw3zRaK+lD5tACv7tEFDFfOuuhLIZto=;
 b=GGYG5B19WSxZVoc08V3ZlvXuI3HmElDsXPZNYtZ3mb7mltAPJS9vC5vfJ2vya0cyJ/WrEs2e/lCkpz7cY7/b3JTdfVUmwfK8NrcUpNbdpdV5FPwlh+rpWWxIt8kuYG80aKz3a68I6QoWkdg6myUOxZZTILUX4itxMaVbF8JTT+0GIjKn9JTSgRFWyQ6m7QlpEVDlvadrrTdE5V5h0oA9oeW0fHE/DNFjUjczeeG3klK/bILhpmRRNutfgj8Lg1UXbhRkLKOdXXhVe3IcNbXiQtfo+yN1SKpkTS9ph8Lpp/bIk6fn9Ir5nCXtRwH/Frqb9ROxOVrr6EKYsoISYD35FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu3EhkOY2ktYtw3zRaK+lD5tACv7tEFDFfOuuhLIZto=;
 b=a4hYrKY4oL0lzpawozbqQwqmPBWNo89GDAZ4DGo9d+PdgC4C/MTkPUOH6Ts2T8XKR6bp89Hz97RVq09VK0thpr14xmHFAC8RzKto8fykqTpMIsqSDAvJxMHyLLFzpUeEdXdubwNYaDsd3YYD0rgsNLpNspDKHYsIHdsZjJ63oCzBihMLeaWQWwSAJywNEl7ACBzXhKu3CGf+8lEmVnW3HpXRUzmecoWrl/dmJKEJ7XVbfxJmafagwIiytPOkFaXpaVHvZ+bx5hXjwdxTMYRjNC8dT1Twl0Ja1NB6x7oKp03ovTMGu9FouCc+Bcu0bEKb7ioJgZQOnrgz+eRA07bYXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Mon, 1 Sep
 2025 06:33:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 06:33:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 Frieder Schrempf <frieder@fris.de>
Cc: Peng Fan <peng.fan@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Joy Zou <joy.zou@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH 0/6] Use correct LDO5 control registers for PCA9450
Date: Mon,  1 Sep 2025 15:44:07 +0800
Message-Id: <175671244824.14594.2354300122219380313.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250811131213.211124-1-frieder@fris.de>
References: <20250811131213.211124-1-frieder@fris.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb8e95c-a625-4a91-2ecc-08dde9216a28
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0ZIb0ZYdFh0K1dQc1JoK0E1OEw1aTk0OGtNUWpITXF6U0JCM01jZDg1Nk9T?=
 =?utf-8?B?cG9RcnFVejhZclp2MHVuVmd1bitWUWVYUHZlVHFLVDBjVDROb1dpY1liYlpv?=
 =?utf-8?B?RWRnN3dHWWRYQmZGa1FnMHhrZVd6QTJPbVh1ZVFQaUpsWWx5RmU2QmdEY2Yv?=
 =?utf-8?B?eWRuRjdhaFJtdHo3blZrcEpQR2xvWlVrNDU4UEhFcDdVanBSS1BKY0RaalAv?=
 =?utf-8?B?a01OSldEYUtlVmJ4N3FjcGxMZGZIa1hac3l4aVZSTUx2ZFRXZHJpM3lCZ2N3?=
 =?utf-8?B?RUNLSUxIUjN1eXhnbWdQUXdQUE5mRFFzUkRDMEhtU3RYSUkzZU5TZFR5V3pm?=
 =?utf-8?B?dmJ1Q0UrcGVHVmcrOFV2bWdhVTd6YVR4NmQyM3ZyZ2tzV3lQb2lIclpvTVpz?=
 =?utf-8?B?RnhNSXNzTjlRMnhBZ2FJRmZ2ZDJQR1NZdkZMSTVtd1pOU1dySXpRR2Q1MGNF?=
 =?utf-8?B?a1RPbHUyMDQ0VXhjdHRjZE5LdmxPOVRYNGZqM2MySUo4SW1iQ3pmYTNrRHZu?=
 =?utf-8?B?Q1AyR1p2YkEzRG4vR3A0R3h6QlhxSzZPcG1RQ1FXalV6blc5RXRRS1VWdGc4?=
 =?utf-8?B?TWFFMmk0dno5OENCZ0xoVDY5OW90SVgzOGRzUWZTMExSSi9wR05vcjlxRmtC?=
 =?utf-8?B?WW9kR3EwQnU5anhWVGIycWtsVVpUUnR2UGJJUjVIMXM1SXJCOUVvSFFFY09Y?=
 =?utf-8?B?Q1I3UC9VUGxLcXpBbm1nbEdRTENvelM1Q2lZRFdHeDBLUFYzenlIRmZ3RjVB?=
 =?utf-8?B?MzJvSGpENkxFWWRHcGZyTmFmdVZyMCsxbHE1RVd2bW90V3RsYmJUSDB3VVB2?=
 =?utf-8?B?a0h4YjlNbCtIZ3dKRXJzWnppUGpUN0ZUWlZIYy9BU1AzTDl5L2VRNDlhM1lU?=
 =?utf-8?B?QXVDQ2dheDRuK1RYMVhFQXdCS3hoaXFCL1JvTEdkUSt5M1c2ZjRkZ3U4Q214?=
 =?utf-8?B?Yzl3UWxzVlVXVWV2MUdWMUo5ckYrKzhSZlF6Z3dVQWlQNkRXRzRNaGFHcGtB?=
 =?utf-8?B?SGo3VzFwNk1UaFV3OHg4bUMyemg3UU5nem9Cd0tva0NyY0gzcVFUVkR5anRi?=
 =?utf-8?B?ZWZZbFNIOXVacEhFam93TkZDSmRFbERwQjdCd2RiZVVuenF2d3F6RWFoN3Fj?=
 =?utf-8?B?ZDU5UDRKU0RML2FOMnBTbi84Mjg0WEw2bHBEYU1tcDdWT3UvRy93N3RvL3pJ?=
 =?utf-8?B?V2NVczhVMnQrQjJMejVPM1lkam85eWU4VnRNTnI0VmpZYWtnVy9FMStkZTF0?=
 =?utf-8?B?Q1FhZzRCR1BhUXlXRXJQMFZtN1MrWGM1cGVpMlRjYzNmU3ZwSDZtMUVmbVgy?=
 =?utf-8?B?OTBDR2tmRFk3V0hwbUJRWkFqRWdQOHNoWHBYYVdnV3JpYWM5aVZ6RHZUaFoz?=
 =?utf-8?B?TmdxK0lNaThUMEU2TWVUcEdEMEhGdENWUWFtd01vTmRNK1UvQi80SlFtdzFG?=
 =?utf-8?B?Z2E0YlUvZEVkMXNXUjRJQ3JqbWJINUpEMWluY2VhOWRPVjdycDU0Yis4QkFk?=
 =?utf-8?B?U2ZpUnpieHlSdGZ3RnlWQUdWeS9JakZpM0tKMDRLM2hvdUt1MlJiRWt0eWpy?=
 =?utf-8?B?ajlaaVFXSE5WUy9yQysvMjBIY1o5cHFsdm5OM2RuRzRxNExucUd6TWE3bWh0?=
 =?utf-8?B?WkRXM0pydHhjNG1zSlBxN1RobWhGZTNXa0tvY0Z3TVcwSUphZWRYdWhRQnpn?=
 =?utf-8?B?dkdmN3lvei9IOFhEVFNsNjRuTUVRYjlFM0xyWStRZnpaMnJ5U1BTenpKK0JP?=
 =?utf-8?B?TVN5ZHNzTUZtQjZhcTVqV01TSDhheXh5Y3dnTTEwbkNRQjNKUDZVZ21sUUJp?=
 =?utf-8?B?SzdMSlFXOVJXaHl4THl1M1FGb2FtRTlPSlltbWNTcUNqZkZUS0JKWGc0RjNh?=
 =?utf-8?B?RC9yTit2cmFtRVN2Q3hyREMvY1Y4NGdDS25QTzV5a2JQeml0OStZTTQ3S2xO?=
 =?utf-8?B?a3cvcERxcmpKUitRWjBNdUc1T2paWXRHYXRxY3AvVGYvd0tXaEpJVGZHTk9M?=
 =?utf-8?Q?S20Q19vPygf4Ks96u+exS1Sfna3YCY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lTaEhpK2UzM3lsSXZFOUVhQ1VjVVVGYXFqRHlYSjk1SnRiVWk3NTFwcllC?=
 =?utf-8?B?RlU1TXl1ZktKSi9XL2VXSmsxMkJBRVdZc2ZvL3FhbjBGdGJmTVpNR3daTG1Y?=
 =?utf-8?B?UnY5ZTFaOXA3ZWZJQi96OWplVHl2QTRvVEpPbklzNmUzanp5ZTFzcTBFNkwy?=
 =?utf-8?B?dzZkOHhZTUZUOGdNK2wrZmtZaDRySENSZEt6djh6Q1VaWkZWVGhPMnVGZFJt?=
 =?utf-8?B?MXZhSXhmUGw1RkQ3MVZzbEZHZVV5VFhCaUNBUmQweFpKU0ZCUmhQNTNDVVIz?=
 =?utf-8?B?OU5KZU12WjNkU01OWHpzdXlCQkVxYVlxRkZOSDdycU81cFJWbTEybXY1VFJx?=
 =?utf-8?B?SGRYMjNCVWFRVnBlNmdEMXFFcE15NEdVd0FWOGtRZ0hzWVFOc2Y2d2NIZjZY?=
 =?utf-8?B?SlY3SklPb1dpWWtoMnZCam9Fck5uU1lYUW1sY0JyMTdMV1h6c3ByaHJ4VGNK?=
 =?utf-8?B?M3J5TENuNmZVQm1IZk15c053cmlZYTkxM1lqVkVhQ2tCK3VRRWQ5Vkc3WEJm?=
 =?utf-8?B?Y0pwMlQ1V2pJeDZBbnhYYndHT2t0bE1VNVdWa3VuZThKQXVQMkt2cExzdWdq?=
 =?utf-8?B?T2FqaDNDdDBCc0lsRjJOcFBVRnBhYkZJYTkxNFFKa05SR1MvdDAxSG9USHYz?=
 =?utf-8?B?Nnp5UHhWY1VsYkU1RUhmVjZpWGNtVkRCb3k3RUFGQndTSWkrNitkTDloZzBV?=
 =?utf-8?B?Q1V4RlhmNFU0aDFONTNSQjdCVFRmS1VMbkRoRyswT21UV0xsVHJlM1ZKU3Rw?=
 =?utf-8?B?U1NDajJRaWpTQWtGLzZiNWJCZkpJVnhLVW4ralB2c2luNytzL2d4a3NmMUUv?=
 =?utf-8?B?NllyK0FMdHY1amEybXArMzVwTXRsVWRBSStyaW5pUjI0R3pQS1JHeXFqNkZs?=
 =?utf-8?B?K05TUy9BTWhHY2tqbmlnRUgxTmZXcERqT3lpMmYwVW9na1JpdG9mNkdaVmwx?=
 =?utf-8?B?U0VTZ3ZJcXpiSlpBbGlxa3E5L1RuOENxeWk0VzJTN296aTBOT1REeC8weUVF?=
 =?utf-8?B?WEtuMXdLakpLdmU4aUs2R29wMkoyeHMzMkh5TjZBazJqRmtqODJQL2w1ZFEx?=
 =?utf-8?B?TTdYK1RNTHBwby96MUNCU0hISU0zbkRVTG9mbVl1eGxCU0tOUkpUalBlZ0pJ?=
 =?utf-8?B?N1VETGlSN1RETkt3OWVYMTVobHQrODMvNVVKeW1KTVQ3d3RwZFk2N2RoRkdM?=
 =?utf-8?B?RDY0bDFRYzl4TnZJcU1QSWloK0g4MFZheGdmbmlQZDVpdkNxSmpwODIxMUxC?=
 =?utf-8?B?Y3l4ZUdwWEpvVGxaOGxWVmt0Y2t1YnZPZ1Q4WXhVcCsxd0RoeUU4SG1hSmdG?=
 =?utf-8?B?TWxoOXp4eitkZi9jd1daenJrbklzYStReTNORFpmV1pxTC9IbTZXZW82VUxi?=
 =?utf-8?B?R3FFMG1VZ1QrYUxvcmM5bXk1YUcvRnpYVHhrMnNQSnAzR0dIR2U4dWNldGRm?=
 =?utf-8?B?c0VObmxIMUs1QldMNndVdTQ4MWgzeHZpcks5c3VGK0NXZEh3Q1dBN3pDSnE0?=
 =?utf-8?B?ZU1SMm5SU09xcFZRcWZGMWI4M1I3UC9WMDhtRjZOYVVzY3luYWVPcDU4RG9W?=
 =?utf-8?B?Z2kyTnAwbVFVa1BoVFZJdzF3K0NLY2FHa2V2U1lxbHFGU2R3UTE1d1J6aU9z?=
 =?utf-8?B?TklhNGFxdzgvTzJSZ0w1ekxyKzZCa1ljTHl5eUwwS1BwSnVGZStTK3E5NW5Z?=
 =?utf-8?B?K2ZDbTFQYmRtTzhrY1BocTc5OWFkYVFIUXNKdEJJeHZtQjFiVmlRNXBSY0xQ?=
 =?utf-8?B?b21POHNaRHQ5K01vUHFWYnFuZHJGMzJvS2wwRGJhNWQ3QWJ0blVuZjU0NzBa?=
 =?utf-8?B?YWJXUStHSGduRHpqc1NRK2hISlE4WjNTdi9LbXdsc1lWRWpYTnlBbHFOb2NK?=
 =?utf-8?B?dzNwU2x0ZVFVeERUU25adlpvRHViaWdiNVB3MDFzeU55enp5WS9PK2xxdHdE?=
 =?utf-8?B?K3piSFpJQkJUNHB1QktTRURiMXQ4RGdYcjVmbFNSNmxENkVyK2JyU3Vod2da?=
 =?utf-8?B?c3g4dkUzVGpwR21QbG40Sll4bnlDNnd2UWFQZlV3SDJFUTlzOVhrcnRQMXFM?=
 =?utf-8?B?aEJja2ZmS08ycmNtQzliMDZvSnBVSWpBbWZ4TnE4b2x5NHFwNnloblY5eHZZ?=
 =?utf-8?Q?bDhiVHGVvySR98PG6M5Q4DgVB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb8e95c-a625-4a91-2ecc-08dde9216a28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:33:08.5145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YSioeqvgJo3ntYCf9ENBFBR/hiql0WDvl5kf42O1d2fhq16DPNmSC4SLx5LLe82WYWKDrRMAHSVkvC6Tj7UHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231
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


On Mon, 11 Aug 2025 15:11:56 +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This is a port for the following series in Linux, which is already
> available in mainline:
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/
> 
> [...]

Applied, thanks!

[1/6] Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
      commit: b7360bd9e8e05dcfd1b4e5fd1c996aabf919e180
[2/6] pmic: pca9450: Fix enable register for LDO5
      commit: 8a04fbd9afd635d37c9afc1b56d014d134861e29
[3/6] pmic: pca9450: Fix control register for LDO5
      commit: addfe4544630a96a1cd03daf822a196af42b7a73
[4/6] pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
      commit: 281829f5ca1645c3bffa130d04753a1a76b64dfb
[5/6] arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated sd-vsel-gpios
      commit: 925f63b0209483cd04b014cc8b5deab1f20267b7
[6/6] arm: dts: imx8mp-dhcom-som: Remove deprecated sd-vsel-gpios
      commit: dc0a12fecea789de83015319f3e9aeddd0a824a2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
