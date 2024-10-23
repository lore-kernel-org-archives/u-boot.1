Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E63D2E008
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 03:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F0388A4C;
	Wed, 23 Oct 2024 05:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZWYsqHT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD9C892CD; Wed, 23 Oct 2024 05:00:01 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 556E388A43
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 04:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVdvS48pCFpW6rfmRlDy3Qlamv1o7wVu+UdN/X38LSbTaQT004PfEjmUkPyDj+Tpos+IJzG7oZ4JBKBF1xgyYWeJYl7yN8P5mSt0kLKrhueYoaUkAfBGSEPkRpAPZaqA13IdMgsXDoMYaXnKZA6oZWOqxXv4iNpQTDB71xAX0QItnz6FbjMrmr3DXlEtCjO8jWzAfoYGB5VfU8W6/aAJTsO/GVUUlcturKiEt7uUR4Vk0wXYPVs/yNFpnBvxnRyltqIXM31TRI/tQbve7/6gIOxAhOfh3B0X2dhkhA4sg9L9dIf0YBejAecJEiAb/VRIvtQ5NCr/BEhAtDzsG3HDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5wan4y9KFG6ZjLxx2HGExbVbsx/Flj6kk9cOVHNj4A=;
 b=FnYk73mB/URkQnHc4WFrZ8oNL4GoBE94wBGeCf7yDVRONFJzWvz0oSdbAWdlf5/oGfFnk34XRMnY26EfUUw0gjfwbiynsh8kV6xIBX42bNmhM3kZ7ScgrVQtZHct0LWKaRhvXAHhRzz1gl23KjwFZXOV8TQQ7p7pyldViEOqZ+ENQD4dhNuApk2DRt53Xd+9xXcTpEIw+1buufdAgfIXywDfIBQqvy6ErLqID/jJ35NhWn2ejpiFPxjDwGb6gRYiK/lHsY1eSqIyElubAi+6q4UNfRD6CtWfCqigsXDrWM2ZLWPHm6i7pp4entMllGfsZ9v8ZcZHSmxCGGv3s2pQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5wan4y9KFG6ZjLxx2HGExbVbsx/Flj6kk9cOVHNj4A=;
 b=ZWYsqHT6GMuWF3NVxjfFs7Uzl551zFcgEmDzAoWBlp+zqEfqdAk0u/1xBS9A9mdXJRo+Vu6fbOPaI/LQx3Sm9leVbVok0rMvCEIMx/PTojqDTdh8MTyv/QGDNQ0UL7pFkvTtsUFZ4zHQAnEFrjB+RyN1amk9E3JuUV/vTGAXlkMGX1aLwid8pl2De2zg+EnrvgRJzQptcNljRhNx0e0WjfaWiKKzAdqAH/k9aHW/Theb3+efBW9XwsmW82jWFhH8C+OXufF0xrdWv9GewTNs5ExWBHdYgAV+3qBiywSZLuihidfn5dpVfQFpEWipTImxccq/UMZGV77aq8qK0VBGsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8956.eurprd04.prod.outlook.com (2603:10a6:20b:40b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Wed, 23 Oct
 2024 02:59:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Wed, 23 Oct 2024
 02:59:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] imx: Add i.MX93 9x9 QSB board
Date: Wed, 23 Oct 2024 12:03:15 +0800
Message-Id: <20241023-imx93qsb-v2-0-1843ab1a4d5a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIR1GGcC/23MQQ7CIBCF4as0sxYDlKq48h6mC4SpnUWhgiGYh
 ruLXbv8X16+DRJGwgTXboOImRIF30IeOrCz8U9k5FqD5FIJzjWjpej+lR7McXc+aeNQTxdo9zX
 iRGWn7mPrmdI7xM8uZ/Fb/yBZMM4GbpSxQ2+tVTdf1qMNC4y11i9viTuHngAAAA==
X-Change-ID: 20241009-imx93qsb-d0d769ade9f8
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f224ee2-7747-46ef-a467-08dcf30ec580
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bERLYVNJYnpLMnlSMFovVkVNSm5xenh5NExnc2Q3c29DcXZ2eHNpcnNvMHFw?=
 =?utf-8?B?MVZEd0Q1RFdGY3lFM0t2NEp1akhIRlBFQ2pkUGpXUHlSVEFKRk0zb2FrQVRm?=
 =?utf-8?B?SXczMHM0czB2bEpjektjbFp6ZXZMSkExNUZPQVRNN1JiUEladlovS0toQyt4?=
 =?utf-8?B?emp2ai94ZktWTGJxVDF4NVM4Vy93Tk9DMU9lbmNlOTY3QlJRQUhBY25acmtB?=
 =?utf-8?B?RXhRS3gyUUdUdTcyY1drekRxSUhjOVo3WVFnWGIrVTNCRHUzeXFudTk1Z2Z2?=
 =?utf-8?B?a1ZRTloySDVoOWQvTEhZK2xhdjhGUFoybEpnQjVoUDlPbkRpOE9PTUQySmMz?=
 =?utf-8?B?ZDRsdU84SVV2dkhBRWRUUitjZVl4TkloVGVzYUE0aXNnS0pURTMrS0RSbi9X?=
 =?utf-8?B?cGZCRWhzOEZwb244OXNJVFRway9wUTJCNDhGbnVyNHpVU3BjZlNtR3hlVHBj?=
 =?utf-8?B?MEd1ZkhINW5mUVFSQzRQaStWR3pQVHVvNHAxSWEyRCtvZmI3SnN0aktTQ3VU?=
 =?utf-8?B?YTIyUWpGaUJBelBDVzZMNTRiMWFPQVhEWWE3S3N5a1JFN296UWJUOUxNWnNT?=
 =?utf-8?B?c1B6L2FRYjhsU3E0NzRNTG5DNUQyUU9KSDBOZmVSWmJVRDYwZ3hvajFXcHh1?=
 =?utf-8?B?ejRQZWdEdGkrZjdmdTRIemdDdzRvZFFsMFVHeW9aNzNTdkFKK3VFNE5IczNB?=
 =?utf-8?B?S2w2cFIzMTZVN2pCZng3bTRmbFZiaFVtdkRSRzYzQzMycXB3ZDh2Tkc3L0R4?=
 =?utf-8?B?NW5jNGVWZVBjQWJWaDJ4KytlT05tamI3Wis5anhTeTdoUCsrWDNwSVl0eVdP?=
 =?utf-8?B?bmFIL2JSbkxSdG9KUmFweXJ5Wm8yMnhJQWRRREdFY0FseWI0ZDBsTW1pM2xF?=
 =?utf-8?B?UE10VFN5WFZHUzZrajF6cExvRjY3WEhET09pbkpTOVZWVHJPYnI1T2c5am1k?=
 =?utf-8?B?R3NwdGhBTk5XUlFvc3hCS1JBb2l2Um9SV3ZPWHlXZXFoZk5leXF6dVRmaERS?=
 =?utf-8?B?akRYMG5MNXZyTHdsZ0ljbzJSdUt5SmxwR3NwNkhTcFh6VlFSbnlKWXdxRDFR?=
 =?utf-8?B?dHdJVnpscU9tcUlaVmROQ2FwcVkza1ppSnFBazRBcUdtRE1zMVluek5Hbjlt?=
 =?utf-8?B?bFNlUGJ4RWNoNXRlWVo0bWlNQWZhb0xHNGdGeDV3aldueVRpVHBpUnB3clFp?=
 =?utf-8?B?cFNuYTFKeHcxamdyVGphUmpRUmN6eXdRcXcxeGQyRzQveXdDU09rSTRMYlYv?=
 =?utf-8?B?dW1DVDEveUdSV2dxSlFlblZVWDJibmsyakJYTGdFWGY3VmRFTjNSOGJDeFVj?=
 =?utf-8?B?TUQvVTA3MFgwdCtobGFqZnpmcDUwNjh5Q0hwVjNqRWJnOHJQQkFtSWhpNm9O?=
 =?utf-8?B?cGZiWnZaUHBwTVNFcDY3bm5uaDNUaWxxZk90V0dlL3JsQ1ZBWVM5ZWZhY2wx?=
 =?utf-8?B?UE85eXZrYklJS2VvUUxvNDZkd3dna281anlpei9sK0YxN1J2dWtENkhtV3Ra?=
 =?utf-8?B?bU5BdkRyZUpmS3pMR1VqR1BSWktKTGdVTmRnemU4YWJ5Qk5XSTlHRlVLNnA4?=
 =?utf-8?B?b0w5R1JsL25zWjhGVnE3NGd2TmFFelVIZUs3QXlVUXg4RmNoNjlJcUJuMklw?=
 =?utf-8?B?K29qNU14M2x1ZlZrVkl1KzE0YjBRN05ab1gvR1pzZFR4RXVIdDhrMUo4Ris2?=
 =?utf-8?B?K3FlSlJPUThpTVF6b3ZRb0ExZXVlamRJZmR0ODlqaFQ0S0Z0NldKT1VWZita?=
 =?utf-8?B?QndCRFZlU3ovWmhMYzIycWp5UkgrYzdTd3dpbU5EOEtPTkdPZ0VlMzhCdTkx?=
 =?utf-8?B?ZHl6TTJBSXpaU0I2M0pRd2dGZUFQSUdzUzRWcXBrc05yZkdrcXZiZit0aStK?=
 =?utf-8?Q?dj5QXTQpq1V3Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzdOc0xhNHdmc2JVWDhiNjhJT0NiQzBxMkt6SWQ5d1JwTVlYZjZGbk1sUHNq?=
 =?utf-8?B?dHQ1TTV3ZE0zdDhhb0ptVGxjRm0wZHkxK3EvLzRRKzVXUFdtaWR5MTA2UHQ5?=
 =?utf-8?B?Z1RQSFp3TDJVMUgwNFQvcWVkeHZPNnUvRkU3RG1pTC8zSUN0MFptU3BVSTZC?=
 =?utf-8?B?VEU4L3c4WmhySU9Za2RWTGh1TmYra1N3Tm0rMkt6ODBsWk1zYkkrRXB1alA1?=
 =?utf-8?B?L0dWSFQ2T1dPaDRibDV5cTRoeDgyQnpycVRTRTcrOHZQMHdiZnFWb21QRS9r?=
 =?utf-8?B?ekZnc2J6aG52NVNlL3J6ZGtOM1pUV1ZYaHh5VXEzczkwbDF0d1BnWi8vU0tS?=
 =?utf-8?B?RzdQRmhRbEhueWEyQ3RYOGdSSG5nZzRmeTZEbzlwMmZhOFNVcHREY2JxRlZX?=
 =?utf-8?B?YUV5dXdBUzdNb1FPNjBOdnBodDVLckhWUTAwUjQrVzEwSzNQSHJBWVBmNWpH?=
 =?utf-8?B?UXFVR0t5a09LcjFIMFJjVS8wZGE1YndFeUtYZXA3dFByYk1yWk5nNjhDYnMx?=
 =?utf-8?B?U1FHaEd5amQxNE1UclUxZEc5ZFRjK2thTk5kRU0wZTA5NDcwcVJSc1hDNGZ3?=
 =?utf-8?B?cTcxbjcva0lNL2FaZG1HdlFvQjc2cFBhVmd1bXArcnhhMWVsTmthK3o0cks1?=
 =?utf-8?B?elBIQmVKQXFXalU5M1VidjBwa0lzbFRMN29FYzE4OUI0OTJ3UFZXYUlMTDZ5?=
 =?utf-8?B?cnVpa2s4eUVTTVR4SkNYQnlxbUR1WEJKaHBySjdFVFgrZEZSeDd4cng5RTlq?=
 =?utf-8?B?OE0rUkMzUlZjQmM5dDc5V3hDeUdGMGZ4MjNXUmlucUJibEFxdDRSYkh0K1Jt?=
 =?utf-8?B?WGJSUUsvaGNES2JVS0JRbDBwWUlzTndCY3ZQRXNmY2s2TnQ1cVppSjhpb0F2?=
 =?utf-8?B?cHc1d2dkR2tacjJ4VzlDdGJCbTBxZFNsdFBEUHliMis2MWxCTlpUclJrUTlE?=
 =?utf-8?B?cUo5Wm9BbGdjdG9tVUZVSGQyR3FnK1J1RGFEMDBjZURLM2ZLeDRGV1M1SW1u?=
 =?utf-8?B?bU1JSFRReWdCc0tLa1NBRGYyUjFTbU9aSU1MRllPcGgzYThrNjBWMThpanVR?=
 =?utf-8?B?WjR4Tk9QanhPeGN5WVFnb0VMYTBsNXh3cFAwdHJzWmtDL2pNc29KZDJPZXV1?=
 =?utf-8?B?MTRJbHNKTjlPRlJoOGp6UlVsUkovQUViZlI0NVJOcC8wSkFGOG1BQmlrajJt?=
 =?utf-8?B?Y1lrZmNDbUNoRmJwWVlnNXhaeTAzTndCTEVtZkxMckpqZ2ZzcldDVHB5RkRk?=
 =?utf-8?B?dk9aVmd0VGlmZ1J6VFJUcFF6cE5LZVVzaUxXd2I2UmY0OW5IbjJRTTNtWlZY?=
 =?utf-8?B?YXQybExRL0RTT2lEcGhYdngwYmxhUWZPcGh3TVFoMGNHL0k0N2RWYU5YVXo4?=
 =?utf-8?B?QUJaeDNjcVI4S1JMSHpGTlhHOFA5UysxM3RPb2U2alB0RVl4dU93MGk1RDBi?=
 =?utf-8?B?UWVMYXZxWHlHVVR5emkwUE9iZHNNMlhzSWxCVEJUOUJrQ2Y0clRweEs3UUpx?=
 =?utf-8?B?Y0JTZk9SVkp1K2pObHZTS3pzNlJHUmhwZTRGdnplMWxUWFpaZnV2K0NnR1Q4?=
 =?utf-8?B?dnowbC9NNHhOc094aVJqWktKWnVIUWJ0eWJJVkRXd0FlU3ZEdWVQVXB1QXY5?=
 =?utf-8?B?NnMyc015N2haNkMzcVovcHhtZVIxekljYzVXeWJnekFjbVM3dGZBVElwSC8z?=
 =?utf-8?B?ZmdRdXFVa2hmYUtRRGh2a3VpZWdjbFViemVUMkx3V0JTKzdFM2Fxdi9LdGJk?=
 =?utf-8?B?VkczakRkZTdaM3gyUnB5Tlg3Z1VWTVU2cXk4U0p2WFpMaGJuVlpGRm5MYlhr?=
 =?utf-8?B?VkVvVDNVOVM4VXkrZzlhRnpFUkpxZUxVL2t4MWowaXNxQkFPcWgzZVMvbzlX?=
 =?utf-8?B?VHVzVUtjQ05rbjAvTUM3Q3kzNGI1dXkydmZXM1h4ZVpianVNTVByVEpUSndF?=
 =?utf-8?B?c0RQZzFsK0tRZUwyTklVSFJjd3VjS3hybmJXOWFEL0Vrc0FhTHRhQmNBaUVY?=
 =?utf-8?B?YkpCcVBrNzljRk45dnc1TjFUbC9obVFBamNGSVJxMVFrYll2MDRud3MycnJJ?=
 =?utf-8?B?TXlUVU9aUmw5RUg2ZkRCQWtYQll5aXhOUHNReTFVOFgwaFVoS1IrRDQ4U0hX?=
 =?utf-8?Q?fsSbDb8uZNbDhpZoCqXtG6hNR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f224ee2-7747-46ef-a467-08dcf30ec580
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:59:55.0226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5VEcCEAwsAv9K26rPadRL06PrqVqOqVRL363P3k1QSuwEhXhSjX0lHrih3znSXdZr+aFpRDk1bNitwsTNv0lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8956
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

The i.MX 93 quick start evaluation kit provides a low-cost platform to
evaluate the i.MX 93 applications processors in a 9x9mm package.

Patch 1 is to add a new pll entry for 3200MTS
Patch 2 is to add the board support.

Patchset is based on imx/next tag:u-boot-imx-next-20241005

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Use imx93_qsb.env
- Update doc for inline ecc
- Drop unused code in board file
- cleanup headers
- Link to v1: https://lore.kernel.org/r/20241009-imx93qsb-v1-0-50a4ac53ccc4@nxp.com

---
Peng Fan (2):
      imx9: clock: Add 800MHz fracpll entry
      imx: Support i.MX93 9X9 QSB board

 arch/arm/dts/imx93-9x9-qsb-u-boot.dtsi        |  162 ++
 arch/arm/mach-imx/imx9/Kconfig                |    8 +
 arch/arm/mach-imx/imx9/clock.c                |    1 +
 arch/arm/mach-imx/imx9/clock_root.c           |    3 +-
 board/freescale/imx93_qsb/Kconfig             |   12 +
 board/freescale/imx93_qsb/MAINTAINERS         |    7 +
 board/freescale/imx93_qsb/Makefile            |   16 +
 board/freescale/imx93_qsb/imx93_qsb.c         |   33 +
 board/freescale/imx93_qsb/imx93_qsb.env       |   63 +
 board/freescale/imx93_qsb/lpddr4_timing.c     | 1995 +++++++++++++++++++++++++
 board/freescale/imx93_qsb/lpddr4_timing_ecc.c | 1995 +++++++++++++++++++++++++
 board/freescale/imx93_qsb/spl.c               |  172 +++
 configs/imx93_9x9_qsb_defconfig               |  139 ++
 configs/imx93_9x9_qsb_inline_ecc_defconfig    |  140 ++
 doc/board/nxp/imx93_9x9_qsb.rst               |   70 +
 doc/board/nxp/index.rst                       |    1 +
 drivers/ddr/imx/imx9/Kconfig                  |    5 +
 include/configs/imx93_qsb.h                   |   25 +
 18 files changed, 4846 insertions(+), 1 deletion(-)
---
base-commit: 52254a3d3bb8ef3da3ef23a9d6cfdf1fbdaefef0
change-id: 20241009-imx93qsb-d0d769ade9f8

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

