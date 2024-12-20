Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BC5E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D87803AB;
	Fri, 20 Dec 2024 03:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oUlzrTlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6071480371; Fri, 20 Dec 2024 03:55:21 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1218D8021D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBT24qt8y/l7ZRRP+3c0+J9W8XxeM6DLt/QVoQtrxs07XGCglG/Ms2CXIoRAotab7vmKzR8yMbCUlpQMdbW+WreTeBUNJEWPoPqhnxda3j6KUj1nm4wp87/ofsrmfClGVLP3IIIH7oweF+7GsnoukVwuY3VFhRwX+vN6QC69UvSyVv8FISo4FAt4NB7h2tmXDlywiVuvLXki9fboZams0NgC7dKr9TWR8xweKefo4tZAROx/PwqN2msvQ0C6rIRPsu2waC9Q/N7TSOcOSlHSXIAmMQRHdQ07lJn+NkNy8KBMi6XVpzDJ2cvjBHCAIzxNxTY2ys4gAVboB9Ni5cQDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdaUJq37u5NwRd1+15f37N53HB8K2yUwFC7jSB214UA=;
 b=wZb+8rLx1GKL0v+3LqlGBo1Ep5wSWJtWzL2xRIXIogktAMKME+w8CCR7mbrkoLsoHF0dJv4JpSOaaG53oJcliVimB6R8zijYQtDb+id7bHn6SmPmADQbGdtAxfJmv6ubfhuUZ6D1Rf2ItUhKk23hxvYfEm7CnlJazqwaWR80BgSJFreUAME9oNUsm+xG0UOPPYM+sPZenh3j5XxM3lUtAye4q23gxsr3Wesu9S+bOXO4GUD0yLwDao8G8hi6cdGnZFNOkyiQcBCRgIjz4YEWwahnSdD87PWsTN1dw3eEPMny6h+Otvrx0CTxp5lfEATaV1YOUv7xgqMs4R/D4+YqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdaUJq37u5NwRd1+15f37N53HB8K2yUwFC7jSB214UA=;
 b=oUlzrTltgzXHKistGwOruvnBRTxl/CttMTX+93NeqVZmFSUFjx4PgBAMqpnkNnHj+vsVLq+z50mQqGrgq596j03B+c1Q+vFxFoo+w5iV2+qQajBuSJQ7m6rqQaQ64d9QrENjEoAuIsQIGPUIvVCxYT1MyvP/oegjpsmMtV6hOf6w+e4WVy2PP/uFD2C89ILYsFKR+zq9Sj6dDxGTYBUqKmwmc7M0RavF/qNQ6OXnl8t9jVZH49+fQPTs6x3gZao3CSKAlsiE1zPnW9PQS14Hz1wlr8XGnGJqNIQT1egJjxsFJI2vKH8Oi0SQyuYozrq4ZkYOjUHO8KEpHkVpPiu/oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:17 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:17 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:01 +0800
Subject: [PATCH v2 03/17] pinctrl: nxp: add SCMI pin control protocol
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-3-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=12268;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=iuYYIv4PubC/TZlHfUYKQRO3Rk5FciGjCHlSMa9Dmfw=;
 b=CAsTYD7/lMfhizwMLGdTqYND06UgssJ613nsZlxY9noStGMQNpciDJV2/Zih84YWxs27DEdni
 JpYuTreUYTtBz6AIe81pY6676nMg6XViAOGdZzb8WS7UHuA2KVKS+Gv
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d9b425-2f73-4402-f811-08dd20a1bc1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?My81UjZvb3dpRWI0YzIvTkh1N2FzSmQzeEE3L042MDl2SnY2QVkrNGZ6RHEv?=
 =?utf-8?B?aDhWekhoSk9XYzRsaWFFdTFJT2xsV2c2SmJVajNvOGhzeXR4eTFPZ0EyZTZK?=
 =?utf-8?B?NHFxeml3c2Mzckd6QkJSQThHZ3NVaEFuQVhKS0JOMnlQWlJnajVsZ2MyQk8r?=
 =?utf-8?B?VEU3SVRtclR1TXRJT0NuZEw3K1djRFJldGk3Si9JTVZCYmZkd2xNNWRiQTVO?=
 =?utf-8?B?ZlMzaHdza3Z6TXN1NkpQK0sxWXorcGh3cjdycXlqMm9BVkxuR290Z1dMKzlh?=
 =?utf-8?B?KzZGWHJaWkh0SGRpSzM4cmhrTXZwY1F3cHRwS0xwcjU0ZmZxOGtYNW1YZ1NC?=
 =?utf-8?B?VWJmbXVRM25IOGFYMTg3TXpIZ0xkSGpzU2dzeEcrMkJxMjBtd3RlSnJGdmlQ?=
 =?utf-8?B?YkVMbWhJTmJ3eUt0K09IWjF2UWZTL1k1RXY5aWFTajZFVTgydk9ibllwV1h1?=
 =?utf-8?B?WHFEaEdjMW5sSmI1OExHMXlTNlJQMGdPb0tMSFVCY0tQMDJxbUJsOEliWGZx?=
 =?utf-8?B?M04xL051STJZeHFzQUhaY2ZLYXlLMjR3VWVibldXbWpOamtXdFROTTFqSXZh?=
 =?utf-8?B?SEQzdVFmZnpzWTFYVlhxd2srRDlVR3Q4SkUwaGREQXpWV3dDTlZodjRqb0hE?=
 =?utf-8?B?VVZqUWtxWjZMeVpuRlBUaitqVngrTXNKd1JTSGFZY3JTdktlRmY0azM5K1Rv?=
 =?utf-8?B?VW5rb3B2NXVrWDlxNkliRFl2d0cxU1MybE00ckVDeDBKa1Qrc0NhYW1iSG9k?=
 =?utf-8?B?NklpdVlmWW53QktFTytwSnp2dlBPLzZiUUZBUW44dTFndVJOZ0ZpaFRkQWJ0?=
 =?utf-8?B?NDdaUTRyZm9tTnZrREtYR2I0a2NXVWxUQ3pvZmtxREZLUWtQODllcUxWOFdR?=
 =?utf-8?B?V2JrbWJmdkpWOWZmT09JMHg1ME5zd1MzSmZ5VW5BQ1VVeitkTVI3S0R5dmhT?=
 =?utf-8?B?a0t3WThQMHB5ZFAwYzNUUHV4WUdJR0lIaEdaMHJJMktET0JVT3J0SmFySUtF?=
 =?utf-8?B?Tm4yeCthMG1hc1Z3U3FsU2NjcmU3OWxQam13U0MyblJ4b3BNTjB1RUNuTHNQ?=
 =?utf-8?B?d216amlRaGU4MmhhR2RUU0JTYlYwbXNLVzE3dmpjS2JpVnEvck1XTmpoMVl0?=
 =?utf-8?B?OGNoTlZjdlVxbkNCQXYzd2dyTzJqc3RKdW1WTDY0UlNqQXhuNkVvTVdQMXlV?=
 =?utf-8?B?VFoxNEx1bHVDVitySGNUM3JHUzkzcXdtSW5sVHJOSjR2eVB4VGUxS3VmeEhs?=
 =?utf-8?B?eGtRdk00bHlXREVZU1lxQjlwdzhBR2VlNkoxdnpDUjlwclZIaDhqa242SzVU?=
 =?utf-8?B?VlF2L0d0bXB2YUlLdjRFbzZZWHpDMFU1RzBKUEJxZm54Qlo4bHNlK0Fkd1Uw?=
 =?utf-8?B?UmZuY3RybDd5WW5kVW9sSkxDaEdYdDlIa28rL1lBRFVaNGpROXk5WmlJclYr?=
 =?utf-8?B?RmZMQUtUcWkzRHFVZUMyOW15NUgwaTZXaG43elRLVWcxRGgwbmcyVCtIK2xD?=
 =?utf-8?B?Qi9EMmJrZnNiQXA1eUN3RDFTRWhmL1Ftd3V2YWd6NUZUTTFOR0cxWENyNDdh?=
 =?utf-8?B?ZG1hYkQzbmZESnVVVURiajhKSS9vTUpBeXpqREJKVE1XSVZncTdXaVljWGp1?=
 =?utf-8?B?bm1Sc2ttck1GOFNNSjh6K1JXNkplODduVkhZRmNPQUFwUjVyZ0xFWHQvMDhv?=
 =?utf-8?B?VWZlSmhVeTNlaXpvQ2NIVDhNbjVMVE9mallBOVZQRTVxby9La1JheXZiS1A2?=
 =?utf-8?B?NndJZVJTeUdhZVhEVm92bGErM0Nwb2hNMGVmTllvenl6YkJDcVJTbjVjQThJ?=
 =?utf-8?B?bzZBV0xHbk5JbmNDUUNLMmZ1eXJTZ09USWhmTmdpUzE2V0R4T2YvN2hYK0Q5?=
 =?utf-8?B?QU9vLzhFUWJJMmJLWGsrNnRJa1FvQ1dWdEFpNm9JV1dBYkRXdG9OQ2VjYmlG?=
 =?utf-8?Q?atDuGvQUhRSGzkeboNTUoNc2J7c4t/Jc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHd2emQvYzBnYWkyOGgrdmpWM1oxR0RKb2xOc3IrOUNZeUNGVGNrWDEyeEJq?=
 =?utf-8?B?TUFJSlNsWEgxZ3RZcTg2blhLOSt0cmUyNm5WOXlaWTMxNDV4ajgzb003czVT?=
 =?utf-8?B?Q28zN0RaL2RDNzF4WU9GMnBkRkFjdXEwcHFlU2Nxa0dVMTgxMzBvaFk1TWc5?=
 =?utf-8?B?QnhWYnFZRmYrYjQ2UzQ5UlVKY1BNZFNhY2J1UkhEZXNVazZOV2xlaXRndVZx?=
 =?utf-8?B?bmtMU2MwTjZ0R1d4L1NFMnA4VTFyRTRFYTJmb0oxVHVhZ243cUd3b0huMk1E?=
 =?utf-8?B?V2lhOXpSSEpZT3NqSXR2V1dtQWtoQ1VhWHY3NG4wNjNZTE5CYkZydzhwSzBP?=
 =?utf-8?B?N1JUU3E4Nzd3N1NqSnZrUlZPaHZoOHNMdlJQWDJDWlhQd042Z2pMVVMzbENl?=
 =?utf-8?B?dXVGeEdaT1I4aktwdHkxWmlWbE5ZVmRwK2lVZHowVUMrWjVnSmJlTWlOMUVX?=
 =?utf-8?B?Mnl3YllBNldzdHhUWFRLK1VuVFFtQ3FCbksrOFZzbEprK05vUDVIZlNYaGpX?=
 =?utf-8?B?VnFxWElQSXh3dFpQaUZQN1ZSaVhkZXBYSjgwN2RZWDBKZTRTMTFhZzRhR0FQ?=
 =?utf-8?B?YmU3NG5oTTZFODk1R0padFdzUCt1NndrT21GRThtREc2cWFZYzErZzZCYnVD?=
 =?utf-8?B?NUtLNVhLVTRDLzg4Tm45azRsVnNzUEJCaEVhMVhmL0x3Q1lzTjFJNGJUOUN4?=
 =?utf-8?B?UXd2ZzZmTjZDcDhTZTMxSWNnZ2RUbGE3VmVwVEcvaFRINjR5QWMyQjFOc3ho?=
 =?utf-8?B?NkJaZVh5R1gwaExhN2FQMTAveHBxMkdRM0krVEhoWU95UHA0emFtbnRRMEpo?=
 =?utf-8?B?WXVXcVVLT2FVV0tEcVg2Uk9XVWRRdThJcS9hRHhqQjE1VXNWajBWejA5ZVFk?=
 =?utf-8?B?d1VHT3c4YlNVQlJXeHZyUGNEVnd0MWk0SXFhVmFkMTRab2hwRzE3RGp5VXFx?=
 =?utf-8?B?MFNMeHBiQlJ6emphcG9SNTk0VEJQOGpoNGdyM3dmaDJwSHdEK1E3a1M1NU9K?=
 =?utf-8?B?MnU4cmFUeUMwV0VWeVBNM3BlRWJiK0R4ZTJRc2ZqMXBJbHdZalJtQW8wY3pC?=
 =?utf-8?B?VFR1eENESDljbzV0ZXQvMlFCczk4eEFzS2NVdThLZnp3VUFoUm8rbzZESWJt?=
 =?utf-8?B?K1hLdDYyeCtWRG8vM3U4aE1INEc5V3FOOHRLOXpyUE9VQXpQMFlPR0tSaGs5?=
 =?utf-8?B?a1FxOENCQWJCSk55MkhNa0xKSmRhM0JEcVYxUnR3SUZ0eGQ4RE1Rc0Y5ODFt?=
 =?utf-8?B?Y0E0ODVLK3ZtbHdFQXJwZllleUtFWmFPNnQrdHYxcks5YUZMSm9FRHBzSU9O?=
 =?utf-8?B?MDJhWmNqYWF0MmVBRXRmNjZGZjRGbDVPSitMUTNEMExiMzJ4aDd4Zm45Yll3?=
 =?utf-8?B?cDlzaXJwWHRzY08yZFc4L2xybVFTMkFIaEpiMm1BZGVGQ1pDbFBFVllEZHpC?=
 =?utf-8?B?L2Y3bEoycitLZkNIdGlvQVFXenhjUUFLZHhwWjZOZmhDOVpmN3BlcjcxWGJj?=
 =?utf-8?B?MGk5NkdWQ2pwb21ERjBoTk5uNGtMeWErdzJRZzVMSjVFZENjREc3U0RXZ2Fz?=
 =?utf-8?B?MUlBYjk5N1FWb3A3SkQ1dTREVC9iVG1KNm5vSkt6YlBEREV3UE9US2MzTzJl?=
 =?utf-8?B?aE9KK3BhSVhXbGdOaHF3TWZsUHNyRWR0L3FwQjdveFJkeSthbHk1SEJ0RGR3?=
 =?utf-8?B?bXRtRHhoVEJqS1RLNlFKS1Q1UmN1YlhqekVUQ2JHcTEyc0VoWUpJTDNWNVhQ?=
 =?utf-8?B?Y3VPZVNJVnduZ0FOS2hZL1JtVTM4NlJ6a3VkamxHdWhvV25aeHMwY1QvaDBp?=
 =?utf-8?B?MU5qenlKWXMxTW1vSmdJZFpiL3pQNW83Tm9RMlhsRlM0cGlpVThYdEl6SjVV?=
 =?utf-8?B?Smhhc0N4dCtxK1A2STh5U2p5bk5XTTM0bTlnaWJGcmtRLzdGaTZzc3FEOGJX?=
 =?utf-8?B?dFNGRXppUWpHWWlTSjRMUXkrcDRYVlpJd1VsREhLbFJpa0tqMXBaNStYZU0w?=
 =?utf-8?B?SFhVemd6ZmdWcUMvbDBuRzlFUHBqTzFaYVVPWGNtdThMTnhKRnFMOG95a1Fw?=
 =?utf-8?B?ZjhFaCtBQlE4TFZIZjJISVg3cnE5QXFNejllMG0rSy9oVVJNaE9tL3VlRUk1?=
 =?utf-8?Q?qFBqY28mhLxbdR/nfGGczU3PH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d9b425-2f73-4402-f811-08dd20a1bc1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:17.5084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmFcO7q2i1VMO0IPOZ1sKHl73jwLP5xsB0iMXeMU37K4vG6NCCv+SelnfM0wbmuGm1GJ/HfP32qmmgRmW+Q+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

This patch provides a driver for the SCMI pin control protocol which is
based on ARM's System Control and Management Interface (SCMI) 3.2.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c |  11 +++
 drivers/pinctrl/nxp/Kconfig               |  13 +++
 drivers/pinctrl/nxp/Makefile              |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c         |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h         |  11 +++
 drivers/pinctrl/nxp/pinctrl-scmi.c        | 136 ++++++++++++++++++++++++++++++
 include/scmi_agent-uclass.h               |   2 +
 include/scmi_protocols.h                  |  34 ++++++++
 8 files changed, 213 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b0328095c4b35ba089ed608fcda48b567..5f101f4ede8b585f8c562a42886ea7be4ef09953 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_pinctrl_imx);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index 06c26f156f6c8f63204604d6065485629cfd9b61..0086f9825837bf568bd7633a21da860e410eeeee 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -1,6 +1,19 @@
 config PINCTRL_IMX
 	bool
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imx pinctrl scmi driver
+
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
 config PINCTRL_IMX_SCU
 	bool
 
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index f10aa6ef188e37583b181bdf9d70ac191e506d75..3ec3e2a9c6fdb875da4ae9bf151df5666256883b 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_IMX6)		+= pinctrl-imx6.o
 obj-$(CONFIG_PINCTRL_IMX7)		+= pinctrl-imx7.o
 obj-$(CONFIG_PINCTRL_IMX7ULP)		+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_IMX8ULP)		+= pinctrl-imx8ulp.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_IMX_SCU)		+= pinctrl-scu.o
 obj-$(CONFIG_PINCTRL_IMX8)		+= pinctrl-imx8.o
 obj-$(CONFIG_PINCTRL_IMX8M)		+= pinctrl-imx8m.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index b1960c56b512cc113a810304dc3ac3f99b237a7e..3d53d0cd4b60c0685dd4c73c23e61cb712cda0ee 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2024 NXP
  */
 
 #include <malloc.h>
@@ -65,7 +66,9 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 
 	npins = size / pin_size;
 
-	if (info->flags & IMX8_USE_SCU) {
+	if (info->flags & IMX_USE_SCMI) {
+		return imx_pinctrl_scmi_conf_pins(dev, pin_data, npins);
+	} else if (info->flags & IMX8_USE_SCU) {
 		imx_pinctrl_scu_conf_pins(info, pin_data, npins);
 	} else {
 		/*
@@ -216,7 +219,7 @@ int imx_pinctrl_probe(struct udevice *dev,
 	priv->dev = dev;
 	priv->info = info;
 
-	if (info->flags & IMX8_USE_SCU)
+	if ((info->flags & IMX8_USE_SCU) || (info->flags & IMX_USE_SCMI))
 		return 0;
 
 	addr = ofnode_get_addr_size_index(dev_ofnode(dev), 0, &size);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index fa4c084e2fc067fcb4e92c33312d4f430081fffd..b2f8865ded0ae380fc0156baa5eaea505c12f501 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2024 NXP
  */
 
 #ifndef __DRIVERS_PINCTRL_IMX_H
@@ -47,6 +48,7 @@ extern const struct pinctrl_ops imx_pinctrl_ops;
 #define ZERO_OFFSET_VALID	0x2
 #define CFG_IBE_OBE		0x4
 #define IMX8_USE_SCU		0x8
+#define IMX_USE_SCMI		0x10
 
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
@@ -65,4 +67,13 @@ static inline int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
 }
 #endif
 
+#ifdef CONFIG_PINCTRL_IMX_SCMI
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins);
+#else
+static inline int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	return 0;
+}
+#endif
+
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..19b1b433a5ced0bb85e52f4d19bdeab2825f275e
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <misc.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <asm/io.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <linux/bitops.h>
+
+#include "pinctrl-imx.h"
+
+#if defined(CONFIG_IMX93)
+#define DAISY_OFFSET	0x360
+#endif
+#if defined(CONFIG_IMX95)
+#define DAISY_OFFSET	0x408
+#endif
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	int ret, num_cfgs = 0;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+	if (mux_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+	if (config_val != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+	if (input_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs - DAISY_OFFSET) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+					  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret != 0 || out.status != 0)
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n", mux_ofs / 4, input_ofs / 4, out.status, ret);
+
+	return ret;
+}
+
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	int i, j = 0;
+	int ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM)
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+	}
+
+	return ret;
+}
+
+static struct imx_pinctrl_soc_info imx_pinctrl_scmi_soc_info __section(".data") = {
+	.flags = ZERO_OFFSET_VALID | IMX_USE_SCMI,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "get channel: %d\n", ret);
+		return ret;
+	}
+
+	debug("%s %p %s\n", __func__, priv, dev->name);
+	return imx_pinctrl_probe(dev, &imx_pinctrl_scmi_soc_info);
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.probe = imx_scmi_pinctrl_probe,
+	.remove = imx_pinctrl_remove,
+	.priv_auto = sizeof(struct imx_pinctrl_priv),
+	.ops = &imx_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d4ae4ddaaa2cb3830c03cd7a559cc0..4beec43cb080b14a777cac1cb0f18ef53433596c 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36ba53223bd9103fcc02f58506fbfc8d..2367467512a6b65253317e51bea71de396aa96f9 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,37 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:	Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled for the
+ * 					selected pin or group. This field is set to 0xFFFFFFFF if no
+ * 					function should be enabled by the pin or group.
+ * @attributes:	Bits[31:11] Reserved, must be zero.
+ * 				Bit[10] Function valid.
+ * 				Bits[9:2] Number of configurations to set.
+ * 				Bits[1:0] Selector: Whether the identifier field refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.34.1

