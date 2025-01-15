Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64308C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A386F80714;
	Wed, 15 Jan 2025 14:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qG8whIPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0B78076E; Wed, 15 Jan 2025 14:29:45 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD8E8070D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPtDd8Ba/0DBQNLlffKSUgAYRq9SI7HLi3m/T0UmUtQ2q+NoQQ9a8fuNI0S9gJIG5Mw+Mfogl8meOGhH7EKSMKPlg07zX8As19dVq3wxZaP6nq8I0TQyIo4pM3T0x87oZBgywSacuauNFmVMCxNWDLaw8snwyB09bbIsGwx6IZPHB8iqujOKEZvgc3lr6KbrAcYLXLxVBaKj0RNwQgLwVCIlBY6Ysxc/VEwYxGzMzhw8sNODU8+Bt60t33JYp9FqXycS7Lqpc7yjGalfbR8FMUQWc8Pcv8t8yVweL48Lo9SIgh97Mik3F1iX8ZrLDoaIfHdtmcCHfVjIqydVMwkQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIEx9aUY9YSEZVF01Fe/pnUxxwe7VDXZTyFPcYxwv4A=;
 b=DQqoGmLB/QoW1dVBKfrUExOCPO1THr2Fwx4If1DLiIE/n3/aq71AZmBU6aYqLgnRHtRKPch5lC45ZiqjtZpRynY5D5QaQX1UoXn5XxcOZPpthN32sGfKcbmfqHPWrwtYycwA9ez14qz5EuebgFrEpksWAuuLtVdf+zC3oDfLXJYQ/nyjDmKrQ2xkPUw2nTp283C5Me0nuEJSkma+sbGG4XjDEtxgHgo0ln0yYU2y6HPSdSdRQXxQK4BhkK7Hv/JQ6bZY1Y+cLaFTXmTC9CY2q9wySjswFYo0vYKEjdByimWTnRtfQD0XoiOhI35cB6JZavPRJkuLGjwQQmMdPe5Uzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIEx9aUY9YSEZVF01Fe/pnUxxwe7VDXZTyFPcYxwv4A=;
 b=qG8whIPMHoKH5WQs43Updp+wFbRpo2ZJoWX9cm0zP+BYcxJh1cD4soJmVlxyNgfF2PH5BHeXyrnHSsAeqsoaUCVSpHBJylKN9HfztX9p7WBoB0zm/+e2ZIUct3zdm219D/lhm7lr+NzZesG5i6DTTswABQGnz9GgFb0Bs9pqektBUD4HDcpLIzO4gNfNO3xa5TL5PK/jzLBXFRy6d49WREkTosFub6Blz1BzPhDXwVMdYaHgv0rm7GxViN7u/WVvvYYJquTjCCGSwBsremd3vbA+JUFkioro2+5cL7q8x2DjsglmUmf9zsCH6pDJ7FX3Vp3KlgFfqCJfkIwwVOWTew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:41 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:55 +0800
Subject: [PATCH v4 08/20] clk: scmi: check the clock state/parent/rate
 control permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-8-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=9395;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=/km7GjWrfp1mDOc5bqVcx790IQfxuL9G6mXh5bxiaOE=;
 b=7a/XkZyVLqWHB1g1PwH/d5WBdb2PyUX/+gll7xyfKicQoYUNrG6MVKiHfkvGM0Hm4Darrm5IO
 CxUYTfLDgH2B6zxs6gnLN8WhAN7vpw7sHzNsEc9RfFdcxnL6O5bCW4C
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4482b6-cdf4-4108-5352-08dd3568aab2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlRpZmJsY0YzY3pVRUs3OStaQU40ZmU5OEtnNUNJd0VuUUJidnMxU2E1VzY5?=
 =?utf-8?B?Sm1UZERMVmFtSUxNcDI3UGs5bnNJNTQ5S2J1TTFYMldldy9TZlZkUERlRFRz?=
 =?utf-8?B?N0hNRDkwMW9uOGxINlRZWEdyZDhxTWVUNUpqYzYrRVJsZGVQNlIzVVRydlZl?=
 =?utf-8?B?UDZLZXVoNXU3Z0RJMGxCVUdCRlprVGdjL0YvUkppZ29KaFdibE5INDhFalFJ?=
 =?utf-8?B?c2lTVFVJTHo3VkRGekVsQ0VVSjJ1WURldDB1N2dUTmV3RVVQVGxYa1N6dnN1?=
 =?utf-8?B?WW40SVlGblRkY04rWk85YVNsQ3NyRkVJcWxVamFaRmU2TXgxNitmY3pxeXkr?=
 =?utf-8?B?b0Y5ZmpiTjVIRFFkcGRUV2tmVWZWMEpPMzF0WCs5WTlJUGFNV1J5eGJEdVdj?=
 =?utf-8?B?QzlKc3VuL0l0V1VMYldMYVpLNTVqMDEyUFltL3NKSENHYXh1U3lEcXVlY0dj?=
 =?utf-8?B?VlkwMlF6dkVKejB2Y2Y2RGMxMXM1YmZTbEkyb2lDQjJ0V3VkL01FTmk2SURa?=
 =?utf-8?B?d2wzcm50enNaUDAweGlscWFCMmE3cHc3T1BJcmZZNjM0aFI3TTBqT1pSdk1z?=
 =?utf-8?B?a3JKaUZQK2hhT2ZuNFZnVVVWalRDUTd4K29FWEozRWJjeEFlZzFkM1hqQWZx?=
 =?utf-8?B?eis3YUNxTDVnKzBWN25XOG9neDhOdDh6RnpjUzNRdVE5Q1VUdzVQdTNiMytD?=
 =?utf-8?B?SFB6TXdlNkk0cXF0K1VHdUJJNW9ENFRSME5jWnVJYzZuR1dFalBEQk1zTnNI?=
 =?utf-8?B?WHpLdytJb05IeDZKeDJWMkV2bkFiM2N1OXE3NjBTd2RPR2tqcW0yOWxJZnRM?=
 =?utf-8?B?MUIwOGpNMDQrZE93OFRqa1FRNEx4TmlKZE1zb0c5VzlMeEx2bU1Qekt1T2VV?=
 =?utf-8?B?TU4ycnQwZlQ0R1J5MHVKM21mcjVTd0tlWjJ4L0FEeWlQUFArS3FhNHIwMGww?=
 =?utf-8?B?Yll4dWEzR0hZd2hQcG9MeEdwQW9uWnptYUtXbzJKNTVsV0I2SkdjV1NyS0JH?=
 =?utf-8?B?d20zS3hZNmV0UDVaQTNwbWRlR1JvaFkxM2ttNDZrSzk3VEw3TmRsRi8wRVI5?=
 =?utf-8?B?bWE1VHJYSytBWVIzL3ZWVkllbU9vbTNsME9lY3IxcEM2Q0NNQWU3ZkN2cmRq?=
 =?utf-8?B?WVVVNjdFMmJQK2UvbmRsWjV5ZkV4YlhKQkRteXJpQXY4TEplRXhQbmplODhm?=
 =?utf-8?B?M296TldqWmJyUnN6c2xrUW4yaTc2ZWRBYUNCbFFHT0ZqazlWYk9uY2RkOFZD?=
 =?utf-8?B?clpvalZadU1hMkVuZktkR0NGalk1MnhMenpQdTdtbjI4UmRSQnc4VlY4ZUpI?=
 =?utf-8?B?RnRpZ0ZFK2Mxc3J1M1ZQanVoQlRXUWNJMWJDMTA1dzN0NkNWdW1WbktDbVpy?=
 =?utf-8?B?TDI1Q3F2Ynl2amVITXFJQ3hGSkRyczNTOFIvS2pvQUdlamVlOEZtTmpmNm0r?=
 =?utf-8?B?bFRCSWUwL2VSWWh6cjV0dXhON3cxY3NLVWpZdnNZYnRTOWNGdHNLWk03ajMr?=
 =?utf-8?B?OXlxOUovT21YUkExM0hZWjd0blBxckM5MElmVHRSS2N5NkwrTnByenNSQ1lY?=
 =?utf-8?B?dWFjdFhvRGNvYjkyZTNsR2Z4c0RKc0Z0Wm5iWnQzWkxMNDJiYTZMbk9uQlVI?=
 =?utf-8?B?b1ZUWlU2dHJBZXR0TW5JZmFsd3lOQlFPcW9CUENlamNpU0lYNkNjRUxDNVBO?=
 =?utf-8?B?T05sWEtpT1VLeGFPcHpUOU11N3E5Wm53bERTdi9VTFhGdktKclc0WnBUcVZW?=
 =?utf-8?B?Z2VSN29abnB4RVFSOWxYQmdWZ1dHTThQQ0NBK3RqazZnUFJlVEwveFFFWmtu?=
 =?utf-8?B?ZDFxT2RQd0wxK211U25reVpwdzRDSGF5VU83RHc0dTREV1E5MWJjVkk3WVdi?=
 =?utf-8?B?dFNKTTR2NzFibGRBeXR5TTF1RUFxcmhabmx3UUM0T3FLSmtwdEVvZ1U5dFNl?=
 =?utf-8?Q?uhJzDyjOqwQktocAIL2oIgREffr0JcLp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0RHRjZxbHNsaWVOU0hTVFA2RWd1REh4bEhNUDYwYlp4YXhXR0NrQlpDb0RW?=
 =?utf-8?B?MFFGZGQvakhhcWRWMk5LTEUzR09Talp3MmR5cDJIN0JadkZ3NENQNGNGM25o?=
 =?utf-8?B?eTdldVVZUTRKUkJLMFpERzErRUdmRFdDcHByWmpkOFc0a1VOMWFzckZnd25P?=
 =?utf-8?B?ekZyc3owQXYwUUM1MjRwS3hrL1pBNExBQU9DNmFFT255VkszdnZkR293ZFVj?=
 =?utf-8?B?d2dkenJsb0NQTGs0eStBVXZ1bFgxWm5DUlFvUk1SejJFRHJTOGNNS2U3ZUp2?=
 =?utf-8?B?S2VEcGVGbUNkTnUxd05ORXhLM04yUGNWeTNPOWp3SVBncWc4VVo3a2dyemlF?=
 =?utf-8?B?ek5zbUZhd1VFWituQ29XRzJuNDl5TlhYQWFibUx6M3Y5NnNqdUlwUVViR2Fk?=
 =?utf-8?B?azNYSmVqbkVzdFhTV20xbjkxQUs2c3Vlam1jVEJMRHV3K2Jsa3dyOUsrZUpX?=
 =?utf-8?B?RVRlWHZVdWVDRGVHQW9WR09VZTlhY2lyTTVuTlJqQjg0amRpeHpsdHpvTCsw?=
 =?utf-8?B?TnFXdnh1UTRLeTVQdlM2VkQzYVpLSk9VMld4bkZiaEZ5SSt6Y2tpSWNQYXlW?=
 =?utf-8?B?Q0dNQ0I2S2t4cEd4Q2RBTEhEN2xCMDQrZmlEaUd2QkRPa1lhakZDYmY4Y0pr?=
 =?utf-8?B?TWRkZkQzQnFoSGRhOHlIQmkxZTROemF4WFV2SXNXeWcxUy9Uclh5bGIrRDdv?=
 =?utf-8?B?U01Semk5SFNSSHNaMFpNZkUwbVAydjFBcFllUTRDWGdSOG1vME9TVE1aaWlH?=
 =?utf-8?B?VDBLQzlzVW9PUEdzb2xTbW8vN2tvYm9pZlp0bUJmVlBMZHM0QTQ0N2s4dE1E?=
 =?utf-8?B?VDVsOUtzcUNHSkhvOGZSUVc2UWZmZ2ZCZ2ZLMXFLMkovWlhlRllYMWs0aVNu?=
 =?utf-8?B?N01PR1RHdjBHUTI3RSsvOUNVZ0hRc0ZNYVNiWFR6VENzZ0pyYUJrQ3R0NWJn?=
 =?utf-8?B?UEdvSzN4Q1R5c0xUamNuL0NnUHljWHd4VmhmYjJNallnWXNQaXdNY1dBWnJM?=
 =?utf-8?B?Sm1Ia08xVGthNTNlanUxWWxQdXQ3Y2pxY2FhVEtFTDdCLzMxdm5DaVY2N2Rz?=
 =?utf-8?B?TDFobElrVEVkTEN2RFk2aTB5NDMyTnZmVUVFSUZ4ZklNN1dkY2hpZGJEYitm?=
 =?utf-8?B?UUl4YVdJdmx1ajRsUnhjTGdoQ3ZkV2RMQ3NlRFB3cGdrY3FPdDF2Sndhdldx?=
 =?utf-8?B?TndvMW81M0NiZHh6VEJVNmlFZVRscm4reWNWcjNaRHpKUGxwV3hNd3RlY2NB?=
 =?utf-8?B?K0RrWmRrNUxxWmM5K0tGRGFOdXdYbHdRUFYzTkF6ODFhRnliMmZlR21DMEx0?=
 =?utf-8?B?N2xXT210OVZmc09nWVZUck1MRmFFem9TNGtzYTdRWk9vNVQ4SGtXN0g2V1Jh?=
 =?utf-8?B?TDRCcjVVbi9kYlVhdGtKSVZib01HbmFsQVA4dzNJT1d4RVl4N3RWRGVacHRY?=
 =?utf-8?B?QlBBQUFzR25ualNFdjFVZHh0d1QyWnB6OXBqU0ZpaUJHbWJNcU5CUVFQUEhj?=
 =?utf-8?B?SVB3ZDRUOGo1aTF1TTZOZ25KZTRocS9lUDQ2NFV2OHdrNUlETUZsaXFacHJ6?=
 =?utf-8?B?VGRyUkR1c0o4NVYvdEk2OFoyeVhHV0xNcGdFMFRPRWs0azg2U0FOeXRNOStk?=
 =?utf-8?B?QlRnT25ab3VCVEVRbHNoSWR3Y09pWDhDNi9vbHQveUlFb2ViZkJUQ1NXSHVT?=
 =?utf-8?B?MlFpT3dQRDlqMTNlOVkwYjhHeFpqZlJpY0Z2ODhGQ0xOOHRDQlpnOXNFUWEz?=
 =?utf-8?B?T2l2YTViMkxvOE03aUxkZm9YMlM0bG1CcDhoeVdWWXhscFRJaGN0VFJVUW5n?=
 =?utf-8?B?ZGhmQ1RSSDVMNzBQRzFoRUtIbm80Y3dIQXFra1Q1cXhpalN6SjJOYnlDcHRT?=
 =?utf-8?B?N2k5TGZiMXdKTFR1eitMZnk5Vi9Lei82YVJtTE1WSWQzdS9uZXRWL0FpaTF3?=
 =?utf-8?B?MnhQSVl4U0pFYWdkZzJUYjRIeVZFL2VNZHlVTG9PcUdtT281T0lJNG1JdDNp?=
 =?utf-8?B?QTVnYUp5L2V3UU9GMU9Rend2Y0w1cjZEWDFaSy90QVpMWlhpazNteTFDRzRj?=
 =?utf-8?B?Ukx4S0ZwTGczcnVHVUtPR1EwOXU3bGJWRXA1SmpzNGVtUldONTZVSDhUK0N1?=
 =?utf-8?Q?DXesrVEoObk1mL+NIW3LRoskB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4482b6-cdf4-4108-5352-08dd3568aab2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:41.4285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/+TZmXQNm0gP6H/BB4WjP0tznH0vVbPLmzAP09VadpqwSA5+zw24iyfAYPRidTEWS0U3iglQ7YiQMYDDZnwIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

Clock driver based on SCMI clock management protocol in Linux checks
clock state, parent and rate control permissions. To be consistent with
the kernel driver, add this check here.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 173 ++++++++++++++++++++++++++++++++++++++++++++---
 include/scmi_protocols.h |  26 ++++++-
 2 files changed, 188 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0ccfe566c269f776f39725c69883c25c..0654f0cbf5fcca9c82b840c2fabd057ce1907979 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,56 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	u32 version;
+	int ret;
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
+	if (ret) {
+		debug("get SCMI clock management protocol version failed\n");
+		return ret;
+	}
+
+	if (version >= CLOCK_PROTOCOL_VERSION_3_0) {
+		struct scmi_clk_get_permissions_in in = {
+			.clock_id = clkid,
+		};
+		struct scmi_clk_get_permissions_out out;
+		struct scmi_msg msg = {
+			.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+			.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+			.in_msg = (u8 *)&in,
+			.in_msg_sz = sizeof(in),
+			.out_msg = (u8 *)&out,
+			.out_msg_sz = sizeof(out),
+		};
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret) {
+			debug("get SCMI clock management protocol permissions failed\n");
+			return ret;
+		}
+
+		ret = scmi_to_linux_errno(out.status);
+		if (ret < 0) {
+			debug("the status code of getting permissions: %d\n", ret);
+			return ret;
+		}
+
+		*perm = out.permissions;
+		return 0;
+	}
+
+	debug("SCMI clock management protocol version is less than 3.0.\n");
+	return -EINVAL;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -78,11 +130,49 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 1);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be enabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 1);
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 0);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be disabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 0);
 }
 
@@ -108,7 +198,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,9 +223,33 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+			return __scmi_clk_set_rate(clk, rate);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock rate cannot be changed by the agent.\n");
+		return 0;
+	}
+
+	return __scmi_clk_set_rate(clk, rate);
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
 	size_t num_clocks, i;
 	int ret;
 
@@ -156,29 +270,44 @@ static int scmi_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
+				free(&attributes);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -197,6 +326,30 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+			return __scmi_clk_set_parent(clk, parent);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock's parent cannot be changed by the agent.\n");
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index d529f8e2697472e60d0cb9c275f34ef0ecaed3ca..9607433c3276f9aa18044c414a5bde3143726cf4 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,13 +731,15 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
-	SCMI_CLOCK_PARENT_SET = 0xD
+	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * 					Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.34.1

