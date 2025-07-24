Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD9EC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 07:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25818367F;
	Thu, 24 Jul 2025 09:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vb6fOVjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C2B8367B; Thu, 24 Jul 2025 09:38:55 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5CD83616
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiGe91nfmr74Baw0DPW/JkrHsxoJO6TKkRJAaE/5XeCgcL54CcXWgcI0xd1Q32m7tEEngqKkQaj1qifzEKdIGxFPU3QMTRRAchNgQ+QJp+DdLeUmG8S+vQWMhduaekaU7wyVf7+Z/5ze6AuohruuQKm1Q5b6yWKoufbzi8k+3IHO/BS0gRjew+Rm+ZI1uSYROWy0nio7b/0GjvbqhUcmRMcKPTtw/x1Ps8o1XNcqNE7LPncj4ucshJaNIdKDFIidN1h9dpR+l7M8grizZciKWCOrO2UiHKGsR93X6IjifRDxXApMnQqOQxnxXMF4rEafRz51eFd4eTeW7o4Ayetihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIZ93RwSg3iYRRtnNOzGDr8ZhUypOss0dexT6jmHulU=;
 b=g8mOO1ZJBmplJaKFm/Nv9JbP45v1M/ovpbMEdG++iGT6BjeSxg066aVAZVb5dX2SJiKtvxRxGXJVyoB+TpyYOSeQKMvwo4rHchxWGythNGM4b99Gza5RYiegPAq+1aVE37KQ9jNhGFe2EYQSiE/yyu9KXLymHYGORcday2KHTFBdMvdc/wtVrzYZL0BVGxHnXffVwiBe5rsxU0Q91hNu+/YmEvNdArqvn5dDaKHI/Wk4LQOsgptHHuVKq+UMJkPE7oBL3PHeMXHHL1qQM5mspuJJXzFKDLqXboWb3B4eVaPQYraZTVl67PRq9URlf/Bp8yR/SsT56Go2CdTductlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIZ93RwSg3iYRRtnNOzGDr8ZhUypOss0dexT6jmHulU=;
 b=Vb6fOVjwvR8gTnQiFX+sBvru4DxQRSfKO8jzdpbRxcNkSgIAv4TVolvGvlGzuvPyJGNDjwwyEpo8qKDraFuAinaL9k03NUzWOdSc7ERIAPqOnHBTuRbISCvFhaRvbEGQLW1Ir1CtFGj8sgMER+lF5KjEpibF1afoooLNRMjydT9lTrEWago3hpeLOuN03Xe56QlCe77Qh7/h/NgevvS7QbijOp/UKdX/JgCWaCPrQNL4i33CLu/fnaunuX64BeXpgi43280CNQqOMtpxGNL2OkxUZKWYFowzy8EGEUZOywkjytjUq1a86IC6skxK+YRvbuRvGax0qtMOzdtnAl6a5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8109.eurprd04.prod.outlook.com (2603:10a6:102:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 07:38:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:38:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>
Cc: Peng Fan <peng.fan@nxp.com>,
 Iulian Banaga <iulianeugen.banaga@mobileye.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] Fix emmc error state after mmc write timeout
Date: Thu, 24 Jul 2025 16:49:07 +0800
Message-Id: <175334692063.31128.10007378224006895288.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250721123513.1105662-1-jimmy.wesolowski@mobileye.com>
References: <20250721123513.1105662-1-jimmy.wesolowski@mobileye.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 723dc11f-ba7b-45a7-0652-08ddca851d6b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejBQUTE5Q0NRTFNidHhOLzQreDdGaDUrdjFlbFRLbnVKU3JubzE0Ymc1c2l1?=
 =?utf-8?B?YnlmT01WeHc0dmpjSlgrNDFZSVJ4cytMN0FpdTNzUndmTEtBVUtPdUdqWWFV?=
 =?utf-8?B?L1grdlpvQ2pWbmlvUC9EanVERDI2eTYvUFJFelAyM1djUm9GQ0xDREErNFZO?=
 =?utf-8?B?eGpPbUVXd3c0dzdDZks3cnZMazVBSGlUcitFN1ZZRXZnKzdBcVFGbEJUekN6?=
 =?utf-8?B?Z1V6QlppZk9GWjl1TUVhVVdrak5DZnJiMFl5SmJDVmYzY0VTV3ZUT21EUllN?=
 =?utf-8?B?M2lNRi9SUUc4enRRZzNYcXZKZkhZTUJYak0zeTVyYmVaenh3Z1g1M0lvaGk2?=
 =?utf-8?B?K1l1SllOREtpRk5YQkFRWDk2elF1M2F1NFRjeWtpTnp5VGxMSUJZOU1vVFBY?=
 =?utf-8?B?dVJrbC9naU53LzJNVDJJalZrUTVHckRlMTZJcXRDQnlzNUhVYkxvbkhEYjZQ?=
 =?utf-8?B?NE5tbVdkVUNvUTU3SHlrTFdkQVdET2FBRXFLcnpOTnJxNkJlaTFXN3NoNG56?=
 =?utf-8?B?eC9BZ3FXNlo5UGQzUDZ4RWdWK1U1M3NsTk9UdjZVMDhTb1c0VHZoNHhJbm9y?=
 =?utf-8?B?NUNvZExON3BweXFsdTd3cVdKR0xsd3d3aGJzOGVHc3VXMUR6ZGtYLyszM2J3?=
 =?utf-8?B?L2JjdmRqUy91YmpMR2RlMVZPUXc0bXhQdDRLc0RVQUN6VEVCOVFYMWRwT1ov?=
 =?utf-8?B?UDNuMVpVSXJ5OWtiZDF3MTdSREpKckN1RXl5RnhFSnFMNUhzOE83SjJ4cGVt?=
 =?utf-8?B?SVVEUXdPVVBhdXpTVGEzV3lOdzdOcm9Fc0xxZ2ZkcTQrL0VjNEs1R3h1YWc3?=
 =?utf-8?B?MTFhdzI2WE1GR1cxOXRwTzFPQU8zVEc0djJtaXRRVjVuVmdaYUVwZmhvTW5G?=
 =?utf-8?B?LzlxVjArS0dxdFBVTE5aanlBYnZYNW9XT3VyTkRTbXVTRzFqSEp3R01FcW0x?=
 =?utf-8?B?VmhZMHBZOGhGNEFmZTRUanpQWG5FRFZ6Y0tsdmN3cGM2Yk8yZ3o1K3N5UGk1?=
 =?utf-8?B?dnptTTFQZG5jZjlnQWhvdUloYk5oUUdhZEpJUTRqTTZCeUkzSFlBMHRDRjdF?=
 =?utf-8?B?c3hIc0M2M3ZOU3lUZndkMEowVEZZTUltTXRxZEVzS1F6UWRMUzM3Z0tzTGNO?=
 =?utf-8?B?cnFDeHJac2UyZFlCYktURlZmZFJRTWVqcmhSeFJaSE5LTmZ4TzVVdlpHSHp5?=
 =?utf-8?B?b2ZCMGY1RVZqdVh5Y0hQWVEwdWdnVnNqaEgxMlVnc2tCQ0xSQUhwbmkxWk5N?=
 =?utf-8?B?MjNIaEhPK3hpbi9qNVFHU1pWZFZSaDNJUCtPdHZwMFJ6RFJ6ODYvcDFCQ0pk?=
 =?utf-8?B?QjNPR3JmbDUvc3BYVmFIcUNMT2FhSmJjdEpJQndNVE5CTFlnQjFqM1JsdXNm?=
 =?utf-8?B?VFJvNEFJNURST0RXUXRVYlFIR2dtTDBXTG9pRVpGV2l0dmg4VUNxMkNqbDRM?=
 =?utf-8?B?ekY5cFZXMTBLV21CZUhXcnJVd3AzRG1sZlh3RWYyWUFJREdHQkdTS090QXpl?=
 =?utf-8?B?OFRKMkdXYjFnY0dNVUVhZjA5anhTd3FvZjVjYVhSM2NQa0lyRXZMbC9pNm43?=
 =?utf-8?B?Q3VWeEZrQmFzbitYbFZOUFhVWnFEYVk2R1R2Q3FtNDlWd3lVTitHN1FmMXA3?=
 =?utf-8?B?c0FQT2dZd2NIa0lpYjQwYjc3aUI1c2Z5QkdnNitwcWlROEU2bDhkM0ZMc3F5?=
 =?utf-8?B?WWVDZlFoTHNhSGZNNG5uVlpRS1c2N3c2bmpSamVOK200cDJwUFQrTitjZUQ1?=
 =?utf-8?B?UG5sUHdweDVMN1o0d0k1eUV2ajJXYmUxWExWei9FdXNINHhVVmdUQjdyUzZE?=
 =?utf-8?B?WTZnSDNUd3pnVnlLUFRkUSs0TUVIQkw2Y0g1c2o1RDhqS1N1eXJqR1lDU0ls?=
 =?utf-8?B?S1FSUjFQZWljb3EvSDBlNHE3SG1jME5QMEh0em01UVZXNlBXVWJjNDBGUERv?=
 =?utf-8?B?Y3dPK0pvRStCQ2J0T3ZiOXNYR3cvcUc3WDBPdnZmMlBHYkVSNk5VenNCV3kr?=
 =?utf-8?B?a1V5LzFtUGRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUgvTmhGRXVaZnNnV3JqUkpleTJVZ3AwTm9ZVi84Y2doS1pXdWRyR2MzTFNL?=
 =?utf-8?B?R0lzSHVNNW8xekRqRnpXeHlNbVUzZVkvOE5zbEJmWkdyN09lQzR3ckhOa1Jz?=
 =?utf-8?B?cmVkL29uc3FTbHcwbDFzSGU1ejJnd0dQaDRiTk9tOXJISnErSDhkTEE0TXpz?=
 =?utf-8?B?U09hWXBIL21ZWWMrVjlsWElKQndqbGZuZk1xWXVkTXJaK1I3c1FQazBZNUt4?=
 =?utf-8?B?ZnE4VHRKbkZYZU12OU92RGJ3RGt2eU45V29hdi9ubllaSjhUWHdPV2RYK0tB?=
 =?utf-8?B?Ykk0cytoVGRuQXZUZmhYbm1CQjVscDRTK0V6SUJkTjd2Y2l2NG42MHB0MHdY?=
 =?utf-8?B?QjRRRy9jZWRYTUQvOURlTTdJM3NMc05yU1J4Wllqc3NCbkNpei9rQW96enEx?=
 =?utf-8?B?UElBcStaOEQ3WGlvaG1UMEh2c1BMTzlHdGUrSGt2eUVwR0l4eHQ2a0ZVemJP?=
 =?utf-8?B?T2dmQnNVekx1UjJqS0p6amxQYmZLOEk4YjdWUnk5V3pyN1RjdHY4UDA1NzQy?=
 =?utf-8?B?WkozWkdOVmZOdWlSOXRhOXptb1RRVmJUVmJNM0FQTzZ5N1ZicG5QWWRMZGh1?=
 =?utf-8?B?VzVXc2xETkU3MlZpTERuK29yeW8rRlNZN3poWnV1TmJrbnNSWWlHdXpaa2RW?=
 =?utf-8?B?UDdncU1kUzJPWHhBMjFCdE9pYWcrazZnejRJOWticG55cVJpQk1hZG4vaEFI?=
 =?utf-8?B?ZnpBRDJQTUo5TURKYVc5Sm5Mc0IrRE50UTVoT0xHT3I1c2FicVlSalhxU0Y4?=
 =?utf-8?B?ZnpNZE14L0R4UkpUM0g5Rk5rREwzV01pUEYzSkFsakhDckxHcW8rYW9ySHJi?=
 =?utf-8?B?cTFxcjdNL2sxSWY4bXJoNGpsWEk4dlc3bjFBMGRBNWFzNU9nVVVzclI5Ull5?=
 =?utf-8?B?eXZzakxranBmcmE3U3paLzRhNGkrZ09yVFdHNFdSRU9BWHNLaFB5WUhmb01v?=
 =?utf-8?B?dXZTRlpqSndmdS9vN1I2MnoyUTJlajRmaDlxd3BmUmR6WHFuTFFzSEY3NjFx?=
 =?utf-8?B?NXRJQkcxc01Nc2NGSmxseGpyZEQzNmdETEVNVUlkdGNZVENKcmJqdzBtaDVx?=
 =?utf-8?B?djc5WHFiS3VsbE4rbUl3cmo4MkcvMTFKd1o5NThZVXVYK0Z4dUE0MjlPckxD?=
 =?utf-8?B?NmhITE5ydnJmNlkzY3AvZG9vbUxZbHhMUTF2bFpKV0Mva3BSUmp2WmM1QWtM?=
 =?utf-8?B?TGtIeEJmek9YdHYrWGZ4eUpiQnRRZ2M0aEtZVElDOE1tc3cydkpGTjVJMi9l?=
 =?utf-8?B?ZWFnOVRvdFc1aXUvZUd4TVkvZVllQndDaDk4QXltOHhYK0YwK0duelJuR3pE?=
 =?utf-8?B?M3k3Z3g3RjZ4Um9jQ0JGTzlMajJycVI5NGV2M05YZGNUaENGV1RuWnBlR0R5?=
 =?utf-8?B?TmhtVE9IUUtpSjhiekxOdk5Mb0R5U3Q2blZVemFqWGdUTFhBeHAwSE9vQi9m?=
 =?utf-8?B?RUNHNjFnVElkclVQcDJxdzJiY3diZ2lmQmg3OFpoTVZUclZmVHpaM3NHU05G?=
 =?utf-8?B?bmJoZzRqc2s0RzNmYVpOaVdDYnpQUDNQS3ZiN0I0UTREUkk3S2ljc2JhUmlz?=
 =?utf-8?B?aUh0ektaYzRaaEVYOGNmYndhQVVINlRXbkMxVWJZWW5HdjFGKzBSOGh0N0ov?=
 =?utf-8?B?ODlLMEQwWFFLZmlTTEo0ZVNmWU1rYU1xUk4vMmIvY21GTzBWL1ErYksyUTBj?=
 =?utf-8?B?TXBSamEwTCtDQkM3ZzVJcGp3NnRkWDk1RzEvRGQxZ0ZyV2U3cDdBWktWMjhi?=
 =?utf-8?B?dFRqRDBlNzN5cEszM29lOHFjK3p6aVBlSmFIeVA5d0xLTWplZUpuSkYxenV2?=
 =?utf-8?B?NEJtY1Z2SlRNVDVKUDNtajFPeTFyb3RvQ3BkU2V4Si80citmK3JLUVVmanU2?=
 =?utf-8?B?bnNUZW0ydTBObzFjbGc2UFFhWnFqbGo3czlXaE8xSTJENVA1UkRIYURVU2FQ?=
 =?utf-8?B?dk0yalY4YzRqeHhoaGVjSlFqWUp2RmNzTGsvNlliWXI5YnltNTZzYVd1V0pQ?=
 =?utf-8?B?VVF6NlA1bmp5UWlneGNWTWU0U0gydUhtRHZId2VuSkZMMDZLRjFmb0szd2NL?=
 =?utf-8?B?MzVvT1hpanJvVHJUMFE3R0pjQk43dHVLVGtRamxqWW5PVDc2N2ozK1A5YW04?=
 =?utf-8?Q?N5bjqk1xUFAhxJiAIc7c6MEQN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723dc11f-ba7b-45a7-0652-08ddca851d6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:38:43.2875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg+BFu5EYJDs3VlN+LrcOqFQb8ZK28qxAfr4NH89A+Zrl8r71g77658HHQTRO9dP1tQtu01lo2IOYu2vasqJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8109
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


On Mon, 21 Jul 2025 15:35:00 +0300, Jimmy Durand Wesolowski wrote:
> This is a fix for the sporadic mmc write failure:
>   mmc write failed
>   0 blocks written: ERROR
> 
> After this happens the emmc will remain in an error state
> where subsequent read/writes fail with a timeout.
> 
> [...]

Applied, thanks!

[1/1] Fix emmc error state after mmc write timeout
      commit: 1080815650a00257929f645bedf4e1795bf188bf

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
