Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C90CDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FAF88F24;
	Thu, 19 Sep 2024 04:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xkVLu3V7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FC688EF2; Thu, 19 Sep 2024 04:58:13 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C7688F6C
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr9R0oMHrwtbybYIHb2aEUSbf13hZB0PVGfGUC5uA1xlWxM4a4JSdZqq3unO+ELSXxmLabNKGYVbtuNNRhphc9wOCk7WXMWBjPRGxD3ZmjNTI9y794q7w4NRTy0tLjTZSL8Nw/3Kw49FIis5qRF337Dm09iQ4F8U8uc8pwUOzjfAwPnqmCwhZxdQ5k+Iuz8sDaNuyqlKL5MMp2K8cwE7ghtBy4Gzi5R48P1/O5wMwNJJoZMk4h383ULnClg726x5UjY+d9Xx+h59eQhzwCVmwVNFelM2aWpD+wVNT8SUREY6gmkbxKuYTxwsXK5CZ7gPHRQ1YR2VfbOMnJ0ZS9cv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHFP+HgSpERLwEQp4LyFgJOIrOgSSxwVyF34AMkYhng=;
 b=vZFb6G34+wiZ0+PHjmcNUKp6oRfRmvPZseVU61+IPoZhHM10E3I+kSdQW6IW8gflAMF9khAyUu8iRgI1sa83jePY2ehjpM99/3b50ZN4A/SKo1QWaO5u02FjpBB8hsh0NcgjBckA0F9xs8EIJBcPSojptkphwYRbz2FGndzZ1qnnBqwItRAN8pmMSmcucJDdRrG/bSUWcFSR6uL3geLo72aRRk2x4HWdfPWwxpCaFQQ1bjM0UsDt58VxMQLxBhu6awKhND5mJ4xitZxVJPHUi6klTeUatBGxSCakj5RK1Pbo7bWRGSAEbkVU8aydBbjh6wFGfurN+374Qcn9mcab6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHFP+HgSpERLwEQp4LyFgJOIrOgSSxwVyF34AMkYhng=;
 b=xkVLu3V7btMHMs2MgpQNxKBirk46TRB3DFhm9cIBogkoz06FIfajY1BxUaULxBogX+tHb//PIyQfSFdHR0hZg3IrYztrNaezrhpHrb/GCFSz7VoWYsaeH44R5OdFwd3gZpDzbsDw9WOtiO9/MvVlqG/hy7b4Hqxfjf8bQsnJ9QuIl454h2gk452JPqa011Iq5a0LEYj9htJNh9zaAlz6LSG1uLwP2Hpxpm8ZpTFfVc7j3ePBy1hOWZBBfGdbgQh0lxPeSSivZ1H1qcRzXJ5upfzA27uScnzSGQzqz+3TM2r6zykC1u5WqL9TNMJlMBt0TRPqok5gvmlRtFXzhxmqow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:21 +0800
Subject: [PATCH v3 03/21] imx9: soc: imx9: soc: Align UID endianness with ROM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-3-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: acea83e5-336a-4fe8-a995-08dcd856e4a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0pSYUxsSjVaelp2RUtOZk1nMDd3RUxmWVdkblVsK0tMRHB4MWRCY2h5WTUv?=
 =?utf-8?B?OFFtMUJXUlFhRFpOWHduc2s1Nlpoc1N2TGJWdGlpRjhzOFFiM0pyc1Y1L2tC?=
 =?utf-8?B?SnJiYzdvMkhxaHlsRlpha094SGVyMnRIek5oeHZ5OTNVeHROc2pDR2ZKeGdv?=
 =?utf-8?B?MkZ3THhYbEN1dk1jMjYyUXJ0cjdIcytKM0w0V2JESTBkN1Y5K3Axbnd3WDFv?=
 =?utf-8?B?WG91YVg3VVFFZ2c4alU1bkpyQnlJbnFkUGNDME9iZUx5OXkxaExaajRtVmpH?=
 =?utf-8?B?c1QybTVad3N3NTVlS1dVQkdUOUQ1MnYxbEx2L2E2U0ZTcXhXR05mWlJseXNZ?=
 =?utf-8?B?Yys5OU9vOHRSVjd4VVN2YVR4ZWtydUpIbFNFZnhINDcvUUZ2NHgxeDZiZ1RG?=
 =?utf-8?B?T3M1T3NjOWhkcDBLeHlwZVdXYWcwdnpPQUk2aW8xR21uOW50N25MOUFpZldw?=
 =?utf-8?B?Z2gySEF3RW44ZWcvSWJTMVR3SWpQbGZ2MzdoTUxCeEdwUzRweXBLTmxwOVRS?=
 =?utf-8?B?TkE5OXl5cGFTd1MzbnZJdVp3cDR5VFBaVHdhanVsOGpIU1VtM3Z5TEM5UE50?=
 =?utf-8?B?aTZwSk9YY0U0bThuVnczbVVqdkNtbkRPa2gxSllSaENyRUdnbHZLSUc3eDVN?=
 =?utf-8?B?elFPTk5ickdqVFUzQUUvK25rbTh5OGFmdE45ZWJWQ2RRakk4TEZHenpEQW8x?=
 =?utf-8?B?dUVZNnZhbTU1cDBNZnErWDVRRFBJUFB6VGZZL1JESzNpSmc1ayt6Q3poSEZ6?=
 =?utf-8?B?enI3cFZBb2QrVjRNQVRlSjUyZXd2Umt1RGk2MnZHRjVqM0xTdzlKSVhCczlL?=
 =?utf-8?B?UG02RThKWlVLQVZkU0FNT1N3eWF5RkZXV0Rjai9BeDFBQ0lYWGZPaW1FNXhE?=
 =?utf-8?B?djRCaitHSnBCWVpVb3ZQNU1ocEJ3UGNLb2NLTytQRUJDVmRqR2l6OER0bnl1?=
 =?utf-8?B?V3VzNkg2M2hyQkdjWjJ4MWZkbS8zT3RLQ2dZdGROVmQxV2x3dkVwL3hsQnNC?=
 =?utf-8?B?UEFYekxvb1FSQmoydCtRRko0Nkt5b1k3SnQwL0JUR0JHb0Y0ajYzYUVaZUhL?=
 =?utf-8?B?SVd2ZTF1Q1FRY3U2VG9oRGpUUXZJVUdjMTM2ZUJ1SCtNeXA4SDBpMXB3bFE0?=
 =?utf-8?B?WnkwRkhMNEdZSXFGSUtmQndlRER1QkQ0TDhCeGZkSmFpejJ4WnNQRlJiZWNw?=
 =?utf-8?B?NExXdnNhdlVHOG9tOWpzUnlEUFRxdGpJK3kzWVdqR0grVStNQnJJMDIwMSts?=
 =?utf-8?B?VzRVT0tvcWFEMU01VUR5c2J1M3lFUjY1VDRFVVlHK0tLd0RGODBSYjI1eVFG?=
 =?utf-8?B?ZTFTNFMxRStYeFlndXJNdVZJVWNhaGNpNmFuMzhpT2dSbmxwV0RwekpXSjlP?=
 =?utf-8?B?bUpUN0x2eHJOdWZHTVppSWlUeUhJajNGNGhJMTFUakl4Y3RyZ09YTWU3K29y?=
 =?utf-8?B?VVc1a0ZmcXltL3g4cVNuVmxkcWhvaElKWjVleEVFeWs5MURmU0dkMENjamkx?=
 =?utf-8?B?d054bHRtQ1dLd1huTTMvMmF5U0FPUmx5K2VKdGhJd1JMRnZicUIvRHRGSUpT?=
 =?utf-8?B?OVVoV1c4NldIc1M4UGhxZ0xianE1cDkvaGNGVitENEtMQldxVHhUc3c1cjg5?=
 =?utf-8?B?YktiQUllaVE3VFNIUHFMK3pRNkR1ZVpQR2plVUFabERtNmI0enZBdlZpSWs4?=
 =?utf-8?B?WVAxVjJmekpSdThqSXczRTlxbG9nUjUyM3h3TVVMaFN5KytMNjBBTTFLblU5?=
 =?utf-8?B?dnd1TTQzcWZsZGlZNnZJUHNJbW90aENsMlZ5eldSSllxNzEvWXNJS2h1R1lU?=
 =?utf-8?B?ZmoxMU00bm5nbjJNd0ZKbUpKZkk3eWZJVFIyTVRSK1UvdlBsTTZwK2U5SGkr?=
 =?utf-8?B?eFBpR0FGeWpJcEdRRWdiMWxQYkdPVnkyNjdCK2tvS3hQOGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZzTU9HbUltbTRCWllyUUhZK3o1K3dHNFJZaEFnclZjb2xQQXQ2QUZUK2w1?=
 =?utf-8?B?YVNObFRqSGxPc3ZZMlBZWUFoU3gxVUpuTGY5Skh5THZISDFxMGQ5VnhUSVFo?=
 =?utf-8?B?eFBJckQ2akhDMVVnOG5vYmhhS0lmRkxSZ2xqZ3B5MFU4dHVpa1NRVWxyeTNR?=
 =?utf-8?B?UlZ6M2tWcjBUaDMyb1lIZm42QzFwb3FudHpDaThqRU9BV1JWMlpRdW5CRDJF?=
 =?utf-8?B?R0tJdkVUWklYYURRSW1vc2VydEJTU1E4MnJJeVpWdDBBT25ud2hFOVloUlNn?=
 =?utf-8?B?ZDZNZG1BdSt0NXBOVHpmMy9heUlLWWZsTDlER1J2OWt3K2NUTHRZdkdvMy9j?=
 =?utf-8?B?OEJESkVvaTNDWEZLY0tKckdncUZwYVlySnVGVzVuT29qMUpxSGJmaG53QlJW?=
 =?utf-8?B?TzlWZFRMRU9neTJGdFhhTndqcUc4YVM2NHBkMExua3FzSFNnSSs2a0ViZjlq?=
 =?utf-8?B?R1NsQ1NMUEFXRHUyT2haL25WV1F2dUpzdlc4eHpVQ0JOTW1xMlJCY0hRZ1JZ?=
 =?utf-8?B?ZGFBU3hiVzFoTnNFQnlqbmFaU1Z1c2lqMFVKNG1yRUllNGkvbWhGSzVCZE1q?=
 =?utf-8?B?UkhWV2Z2b1YxR0FtZENtVFAyanN2dmhObUprZ1pUOVo1bmlrQWx3WXFsSmRG?=
 =?utf-8?B?U2RabEpPaVdEWDdTaHh4QkJFWlVmQThVUTIrNUFVVHhuT3ZDN0RSaFFQYVU1?=
 =?utf-8?B?ek9vRHF5djBkbXJxRytkTDFNSkpUTjY3MHFPOXRzZTNPdmdscm1RTWg5NlEr?=
 =?utf-8?B?RWpDRFA5dU1TVXE0T0U4OUt2cG0zbkgwd1dNTnJIeGp6NG8zY2lEYXJjSVo1?=
 =?utf-8?B?Ync0TW5hcTBaZWQ5YWJZOVYwanUyWHV6N2dmamlUeFFSS0VQejJ0L1RJK1N0?=
 =?utf-8?B?R1kzWDJ3azhYYTNNSmJvdHB4ejdFc0dCeDA0c1BFV0ZIcGdKSGxzbHI1OEVo?=
 =?utf-8?B?YmlOMDA0MURzWUJwaTBaT09WTkl3dkxMa1JFbXhCK3RncGRMZzE1cGo0ZDJD?=
 =?utf-8?B?ZWpZQXlOMWVtbURZMHp3R1ZGOUFleU40eFZOUFB1MDVYejRjbUZjL0VRQlNi?=
 =?utf-8?B?Z2VTSTRuTjRCMzEwdkYzU3lEOFZzODhuemhXNkVoSXhFQ1RCcFQ3N2tzK1JE?=
 =?utf-8?B?QU9scXA0cnc5R2d1Zjcvb2xWWllQZjlEK3NHSUtrRE4xS0RYSzJ4bG84L2pW?=
 =?utf-8?B?UXdxV2txWGlyTmFOODJyZm5hL0x1cithbXo3TkR4V3BLTThKWWlwWVNJVDU2?=
 =?utf-8?B?NlpzMnNqK1ZLMVo4dll3MHQ0Y3lRSWpJNzk4M3lFc0FFWUFHakttMGs1Q3Bx?=
 =?utf-8?B?akdMcE9RUWdaQmdpQmw2cCtBQVBuYnA4M3ZwanN1aUg5VUliRGQ5S1BmakN4?=
 =?utf-8?B?QVJlNlF3ZHM0U0VHSStaR3lkZitXaHdXZDhrQ3hDWFQ0cGVOQmNZQWw5WVhm?=
 =?utf-8?B?TGlCdXNWWmpYZVhPcWRWSHR2aVlvQnRsOGhFR0djcjU3cmtBdHdtRGpPZTNC?=
 =?utf-8?B?aG1QQWpRZGdZQnlKVEQzS1ZyTE5vRnRnZWFXN29KZW9RRFZZdVpjdTV5KzEv?=
 =?utf-8?B?NXd2dHVBRUFBU2tFUTFRM3JUbW9BMGh6M29iNWx4QXQ1VGpVMHlvZ1ZBaEZp?=
 =?utf-8?B?blVXbmJZbzllRTRWMFBGTmxqSlA0b3ZyTXl3a0NkRzcwRjJnb0JIMVFFM2Qv?=
 =?utf-8?B?a2F1QVdPZHROZm1hYjRnMU94U0dncDNxeFpkdWJYRUl4bUwvbExLSDFzSTYx?=
 =?utf-8?B?RUI1UEM0alJiTzJ6akltSG1iWTRHRUZML0k0MjhsOEtwcDFGQWs5QTlybS9w?=
 =?utf-8?B?b2srd2RYa1ZvVXRMTmFrYmV0dndIa3VrWVhTN25yUXk2Z1BkbnJra1hsUlRE?=
 =?utf-8?B?cEV1Zk8vZW5NNHJhTHg5c1hYM1BTMkVYYkI4S2lqYVpsYVZjQm5hWkRseXpx?=
 =?utf-8?B?WG85TGtDZllXbkc1SDJyNU5MREE5WWNqMVhQbVBJTGZUeDN6elV6andvaXVq?=
 =?utf-8?B?Mk1sRWtYcllwajRSaUZSMTB4RjI4Zzhha2lhNUhSdzlIbVMwUE5pRkcwOG9a?=
 =?utf-8?B?NEdOZGx1SVhqZmZZZDhjVkUrQ1NpMnlQVVFvdUNvRWF0UUtSaXdCRlFPSGs3?=
 =?utf-8?Q?pqMacXyUh54BarKS9JBbXUegK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acea83e5-336a-4fe8-a995-08dcd856e4a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:09.5389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3c8WVraWMcXSM1qjub8qT9QprusS690pHvkscDrA7lhyOE7p7JbqNgOmaa5boNMffoZ3q/G6yatgPdrgcq7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

From: Frank Li <Frank.Li@nxp.com>

ROM use UID[0] and UID[1] as serial number with big endian when usb serial
download.

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...

[sudo] uuu -lsusb can list known devices with serial# informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 06032f2ff59..6dcf0c4612d 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -563,8 +563,8 @@ void get_board_serial(struct tag_serialnr *serialnr)
 	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
 	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
 
-	serialnr->low = gd->arch.uid[0];
-	serialnr->high = gd->arch.uid[3];
+	serialnr->low = __be32_to_cpu(gd->arch.uid[1]);
+	serialnr->high = __be32_to_cpu(gd->arch.uid[0]);
 }
 #endif
 

-- 
2.35.3

