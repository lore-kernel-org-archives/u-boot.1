Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9011E91298
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F9083B64;
	Thu,  5 Feb 2026 16:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pfgGYJx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E57F83AAD; Thu,  5 Feb 2026 16:15:40 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D32F83B72
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLwcSoi33Z0kJL8DRPpUyyK5R54mCrZOYrpGxmMSWOVuY8jXmjkWwVVwTw3UVYAA0P0Zn+Sx27myUHu50hlnpgoKPaoXBp5PgxRBSwr9jCKqOA8hAVup3dJDQAjwVMHR73buW7oWWyiGRrVvM2arUCPIT84fV4ENmWfjNnq0hui+DcF5Qe3Lbt9rDDhIiqxGDtot6DtC0f8maebML9adBPnYvA0b7Y/UfXyO1TKkP/5Qk6qO1ITi5w/OtR1YDloYelukCE8MxFPugSb7i8/ZHWcI0qfdQsXoe771QGESmGDFAqPsQSeiTnLfpq39TmS7NGVywJbQZJg0KckFLQkamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/OQLd+xYopspuBc4akIF2sFH2WdYOUZr8wBuPB2Eb8=;
 b=AerT2m12kieD7wmDtVHxndu4isoLG1lUpuN3GHRGh8Mj4BzIDG9/RLoZNF0t7iovJtT6i0TwG5GHqqHIFh1A1E9iyzqZOkwKcwySRpiMfGr5I6bzsluxqfxY4W1fKqrbcLwdRgIdfjTDo8lpaGI/UOsufmLlzI9FdOZSfXCzZb5+VC0XLhHx3QJak6zRujmLq/7n5h1t7smH68xjto6F8HXF5rxu9muRVqNB1qfXm4mu85BJ7vvkKUM3+oh3nEuCN2DuzuiTCsWltHC5XHiOY9E5eOxveqR0T98cvYNc0wohzgnRwMXtEkXLw6HBXaFUWoxthOJCnxwDgCwSi0kx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/OQLd+xYopspuBc4akIF2sFH2WdYOUZr8wBuPB2Eb8=;
 b=pfgGYJx7BYQh4ITI9K9poNmuwz2er2C+a3XsIUI3LcB525/3RFoOqwLhAWEi1jn+aawHSCdCb+Tjmw7UUQX15xZWxDURr9UmiO60yKcSMi151PBJin5X/m2pa6jkeH678n5PqpNTNhuAqlBnAsFaI+pun2qnS4qwaZhwiicPxtoj7zSN1fKw2o9/N5NNFF6AAFIvb5xWKVr4KjJezTCFKC3ksPaClQwVpJar4feYlR13wYvbS0qVN0Gz4h6plyGmer2ZIm3gJmqiSXLVsARphsfE33b8M9DHTcmc/F+8eanAJws+QxpMcT3NW9UoI7/uzchuR80Wq26ppS2WSnNMmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:15:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:15:35 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:10 +0800
Subject: [PATCH v1 04/12] arm: imx: Add i.MX952 CPU type support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-4-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 99658ab2-75ef-44d6-7cd2-08de64c96906
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDF3NERFN013K0ozYUh4c2tuelRNcXJsdEdLYXhzb3ArMDZibVA0S05wbGVW?=
 =?utf-8?B?emhRVDhLcjFHZkV3NlBXNSsrOFpLcEVVdng1L2FaMEtnZ3psRk5lZ3ovUjJY?=
 =?utf-8?B?UDcrUTFuMFA3UW9teWJNZjhBa2JFWkhhVHpxaXBjRVJOaUJ4aDg2TTVmZmdv?=
 =?utf-8?B?QUhWZ2FDZWsrYmRQb0RhTGJOVzh1bU1Ia0QybmJ1THNjclZXNFQ0aW1TMk9I?=
 =?utf-8?B?d3JJVk1YNnVMZE43LzdrYk1yVGVoOWxNYW1RQThpYkFtM3IxVVJrRlhMcjZ0?=
 =?utf-8?B?ajhqMGxTTStKU3g4d1Mrak5zUVlZQU1hZk15UU9kdFFhS3dNS0lIVnRmK20r?=
 =?utf-8?B?cEJ0L0RRS2t2SHJ0TFlNeTd4ODJZc1MyMmFZdk05R2NsYnJxRS9YbDFRQmZt?=
 =?utf-8?B?emc0Y2tGVVpCUTJsMXp6U0tKNTAvOHZEN1IyNWVsMmJCRHFKVmU2TzJYcXND?=
 =?utf-8?B?WjhPWExJSXBIajFvQ0F1NGVuaUFoSFRzSkdmYW1wYmhEQlJIbWNUN2c5OWt6?=
 =?utf-8?B?aEZ1R2RMNmVYL1FvclVXZmdPTDVCTUo1aG51bmh6M3FhTHc4YVBGbHlEaGt5?=
 =?utf-8?B?Q0Y2NExYL05abGFCK0h5RHFOZExrWitMRXZQWGtDLzNqd3VEN3BHSFlVbUJk?=
 =?utf-8?B?OUg1ZGZ2eXIxc2xvTWEzOWZxWVcyckFaUE4wSW9oZFdibXpBekM2dkdkZVd0?=
 =?utf-8?B?YUYrZXUyOEx3WG9jNmhtYmtSaUd5N1RJUE5zQU1qRHg4N1lVQzlGSGwwWGtL?=
 =?utf-8?B?cmlJUXdUN2NVRmczKy82b1hyVXJNMDRwSkg0Skx0cSswc205RHdrOUI0cWhn?=
 =?utf-8?B?SU1NdFh4VDkyTkZSWEZPcktHOFRWaDJ1N2JnM09CVlRkZHVvT3BZc3doM2t0?=
 =?utf-8?B?ZnpFTU4yK0dRckR3UDNiai9ta3hMRzAvZ24yOGxiL2g5Mm1RMExUcTZuNm9Q?=
 =?utf-8?B?NzFoZzZNQ1ArQlErMkdxZmJJeUw5TXdER05YS2dubTdidzEzVkpwblA2Tmtm?=
 =?utf-8?B?NUhnTzJYV0RScnpWbEh6WkxycE0xN3E3VUlpS1dpUUJ2bzE5a3pDc0VVMFJh?=
 =?utf-8?B?VWhCemN0UE1KQmJ4dmJJaU9LSTZxSzhwTklhcEhka25NK1FMNWU4c0RBMTV4?=
 =?utf-8?B?L0UyRmU0dVlTQ1dSOU0xaFltWnR0cTlFb2tsd0ZzOFk4UUsxMDhRS0Q2am5q?=
 =?utf-8?B?R1h3a0x5U1Aza2pNdjd1bkpjNjBEczlnd096TjdhaUJFNTMxa0FLcEVkTEZw?=
 =?utf-8?B?OEVwQmMvbmplTUk0UFB1YjlUcWxXSTltdEd6NGRobEIwZHE5UlhVY0w3L3NU?=
 =?utf-8?B?c1BXK2RqZG9ncjZUY1FYQkdYWWdIYTJOak8yUUFZOHpCai93SElidVFSRUp4?=
 =?utf-8?B?Z2FDZVdnOElEbWF2M1B6OXExSHJFL1lqSmNnTWpPNXFNV1BlZDhSSzN1eWdH?=
 =?utf-8?B?NDgzWWEybzkzaS9aRzNVM0JxNGlSaDdmOUEydjRGV1B0MTN2aHltL1Bua0E1?=
 =?utf-8?B?RlVaVWZ3Y2c3Lzl3OXk4MWpHVGJmaTlHNHFOWnVOVEFPZ09NY2JpSWhCSFlW?=
 =?utf-8?B?MVNEUWVIcmZaOHQ3b3JDTG0rSzZ2NDhqSEkwSHFrVTNOZzZ3bmRqWitHSk9j?=
 =?utf-8?B?aEJsTVoxbVBXNDI5KzdTUytaOFF5ZVk2dlFodFJxU0tsODZYbE1qQnZIVG5V?=
 =?utf-8?B?VG5LWFJ5Mk5vQzB0ZCtLS3A1OHprOGYzaWVrSFBwaWdoL1czdVRNeG1oMjlq?=
 =?utf-8?B?V2JjQ29xTGlKeU9idlhGWEtqR0RpbzI0Z2M0Z3RQRWdMTk11VU00RnprbG5V?=
 =?utf-8?B?SzBQNDM0S1p0d1BoeVdWUnNSTXZ0Tk9QOG8vUUl3QlFXNWlvQTRoeW9oOWgz?=
 =?utf-8?B?dGlneVVwbmwyWG5LYW9zRDMwU3ErRkppRkViMmF2Z0pPeEplK0p0bVBoQzFK?=
 =?utf-8?B?Y3Yvbkc1ajJVbGxJeEVEOExFZjFWQm1GQU9NTkVNUUQzNS9hNlVMMmV0SmEv?=
 =?utf-8?B?Y3BDcEJ1YTRIWml4U3BIL005Qzk3bVJCR1pLMExSZnQra25SYXUxbGNOa3RS?=
 =?utf-8?B?bXV0OXpGZG9oZjJ2YnpzdGtQN2lPVDdnZ0hIaUczNERnN2xYSytvVTFZY2Fr?=
 =?utf-8?B?VHBKVDQ4aUR2aS95UE1pRUliR2tqSWJBeVhvQVMzakFscDM1TEhmYklLbHlU?=
 =?utf-8?Q?hJi1ME9PqBxGVv87iCCNLBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWljemF6UU1EVWduRFlBVVJMajJLNEJIVWoxU2tGOEZ0ZUV0SGhyQ3JUK2t4?=
 =?utf-8?B?ZUtnOUpyZU9MY1J6T1FrcmlYeUxrTGZVVDU4c1ovYXdzRjZmNkFFQ29FYjhE?=
 =?utf-8?B?VXFENFQyMllodjgrWEJxcXVXekc4OWJGWXNWb2J1bjJwRVR1UWFqTFE2U0NE?=
 =?utf-8?B?a1NkOU4xZVE0NVp0K0VHMXB5VXFnVGFKckV5N2o3ZTc1TDI5K29XNTd0aUFR?=
 =?utf-8?B?Slo4TjBMOHV4TDFsK0V5bW9lWnJHNTJLL2xRTUhPUzMwRTNKTEJhelBzRmNE?=
 =?utf-8?B?WGVJMkwxV05RNnFKRjRBZnlyM1VyM01SVHExZFh4cm1MSkg2dTJFQitHRVJB?=
 =?utf-8?B?T1hIVDFNZ2ZxMFkxVEZsNzA1eTJtZ1NVVlc0d052eUxQTHAwdmtKWTZQN0h2?=
 =?utf-8?B?ZXRnMGJxU2R6RnZMS3dhTlFpYkQremI5R0tWR2VoUENmTXZFN3JRazcxNXlF?=
 =?utf-8?B?d280VEdpa2JsRDJROFNRQ0VqOVFFaUhmS2tkSnZVcU1MdGZoTEwxRzgzT25h?=
 =?utf-8?B?SGhqN3VIVWlNSHBuZFZ0bEdjR0lJc2FmV1pEV3hON0JkR1FlOFJkWGkzMjF0?=
 =?utf-8?B?NGtGS01uRXlSeXd1ajQ2ZVVSdkwwc2VMOUphSEYyb1dUd2NaMlpnUkd5b0hK?=
 =?utf-8?B?REpQdURsL1dzN0dFVGlMbWxuUS9aYnRqYXdvejNwOU5WWFdUeWZpNzlIeDc3?=
 =?utf-8?B?Ui9haXZodExGN0tYYlY1K00wRTNKR2s0MkNUc1REa1RKK0tvWVprbUpaeVYy?=
 =?utf-8?B?b3BQYmRkbmgrc3FObHdlYzFFRkFtWmZGZWQwalBBZjk0bHdTU1Y5QUhPdFZr?=
 =?utf-8?B?LzdiUGVMMlZGZCswbmZhci9JNi9GcGlGOFFxcXJ2Tm4zUndZRHI2ZS92Tmg2?=
 =?utf-8?B?VWZaK2V6SURiMEhmNVRGL204SldNMGRTdE9PSVUwUFVrV2VhbDZUK1J1RVVz?=
 =?utf-8?B?YjJUVU5QbEtzMWY3WlBIV1VGVEpObHZrUlJCbWtVTDMxSThjREd1bXh3ZnNS?=
 =?utf-8?B?NjR4V1dOREFzMFlSQi9xMW4yWnRNK3lxZDE0WlpnR0xFTnh3a0lheXg5TnVa?=
 =?utf-8?B?Zm1KOW91SGNGTmRUQWpIODRQZ3JvQ2xWL2s2WXlpcENScVNzNEVmeVRWTWFz?=
 =?utf-8?B?b2Vaa1R5Rk9Hb1RxdnpreDE1d2VXc25UOTFhdWVOUkNHRHdqekFoRHFKMUxz?=
 =?utf-8?B?L2g2WTRkM2g3RmVZQlNZb3VKS2pEdlJnQjJJRU9EZ1JCSHhPRTBPaW8wQ3Zj?=
 =?utf-8?B?TzdhTWVKeSsrb25tcVJSdkg3Vk9aelJqMmhISWZOeno2S2YvSDNQYVUrTkx5?=
 =?utf-8?B?TWFaL0ZIV1locDQxa001TEdEY1VEQWd4c2lkdE5DN1VCVlU4cHVqOVNDczBJ?=
 =?utf-8?B?TGU3ZnVpblNrT0lVV213dk9tSExsZy9hdjhQSVg1Y2VLSkMzbCtKNFZmSFhn?=
 =?utf-8?B?MGhzQlFxdlhwdjRRdkovNWVpSncwM3BUbHFSOGRIQWtGN2VleFlkdi9MZ2kx?=
 =?utf-8?B?OHdWZkZ1d2pIYTNETmJkWWJ2TkdrWDQyd3hPYnhCTEdVMGljY2hCS091YnZF?=
 =?utf-8?B?SmdLa2loUEtUNjBWL2tHc2hzajQ1UUZROVJvd0JvUU94MVMza1pyRXZNd1V4?=
 =?utf-8?B?cUFsUlIxSDd4RytUbGFqMEJmSllJd1Y2THlIdlIxTVRvZVFxM1NMSW9mK0Jv?=
 =?utf-8?B?UDdNUzdkMVQrZ0VjSXQ3QXdvaWdTMXB3WU0vT0FZU0pnS0kxT2hSVXFwUW1h?=
 =?utf-8?B?dDRxcmkrY3kxcmx3SlhYQXBjcnZPZGJuZC9sbnlxRU9aM1ZtMlgvTVhRdlZF?=
 =?utf-8?B?YUh4d1d0blJGYld3cGpYdlVxTll5TFFOUFZ4SjN0ZnB5dWx0VnI5YzJaejRi?=
 =?utf-8?B?N2pWSnA1bnVOeDgyRGNCYWdFSjFJeU1CMnhFOEFmMTREYkhDN0pVUWFJZEh5?=
 =?utf-8?B?UG84RlVKRlJxWlBsREVGaVlhYmVuc01DelJSSUdYTU4vNngvc01wZkJ2MjNX?=
 =?utf-8?B?OWRLUVpKWHFPMmh6NmFRdjB5U0N0WkUxM3FpL3hIS1VuNDFqelJtOGhZWGt2?=
 =?utf-8?B?M2ozNE15RlYxWHJuRFA0M25qdG9iU1l5bENWOGZMeW9MZzZVb3YwanBmWHVt?=
 =?utf-8?B?Q1Q2bmIrRSttZmJZTTJLMVhTZU1IeThmdloyMXYvUnRmeDAwSjNGT2dKaUZx?=
 =?utf-8?B?R1RLMVdwZ1o5NzNFaGo1V2dreWRsMnRnRmNpSEpDTVZyTm9WdmpEVDhRM2w5?=
 =?utf-8?B?T0dnYVUrc1RnMHA5a3FXdnByL3ZsTktiVWlmUURvS1dZVzdVN3VUS0tNQVVz?=
 =?utf-8?B?OUs1T1hudXFLeVY4dTZkTkplRmZwVUR6SkVtQVdzSXMwWFNubWpIQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99658ab2-75ef-44d6-7cd2-08de64c96906
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:15:35.0885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNvoPXTEHw6FhozUxLXMRenPTm5mWoGhx0senMYd5bjCUTrAjBZz0CRJcIPyx+6ocOrQQfsGcmz7PLCHfQMUKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

Add CPU type definition and detection macro for i.MX952 SoC.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 1 +
 arch/arm/include/asm/mach-imx/sys_proto.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 1af9778f8ce..25d0f205fde 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -79,6 +79,7 @@
 #define MXC_CPU_IMX95		0x1C1 /* dummy ID */
 
 #define MXC_CPU_IMX94		0x1C2 /* dummy ID */
+#define MXC_CPU_IMX952		0x1C3 /* dummy ID */
 
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 6c8bd6c9085..e2076fb676d 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -99,6 +99,7 @@ struct bd_info;
 
 #define is_imx94() (is_cpu_type(MXC_CPU_IMX94))
 #define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
+#define is_imx952() (is_cpu_type(MXC_CPU_IMX952))
 
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
 #define is_imx9111() (is_cpu_type(MXC_CPU_IMX9111))

-- 
2.43.0

