Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859E3C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C3E1809A5;
	Thu, 24 Apr 2025 08:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UsH1QFJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF07806FC; Thu, 24 Apr 2025 08:33:59 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71809809A5
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1vL7QPJOe03U8XQ4iCTcPIIUZodGZO/+rxhZK6CFGdYeciOGoSt36bDfV1rBSbxpUlc237EeAZc60VoMCyAIMq0l2DUTNG5V7iN7pNuGQCV0T4ZC8VBOasejRW1RcKC+ZYq/Tuicx0dMR5A8hfkOPL2zxPl5/d/AUqwgxUaC+ZZXUFSpfd5Qtee/JECpM/wFry5WI+bPWCwXTEn/zWRjQKlWj/RdH+g4Lr9rLUb8Qz65TxcdrTHI0loBoJkF4025i6QRwyP1WpP86jmch0cFEDAKbH/bukQ78jeHpecXvrEKdD1vjgMuqpyu5JjcWq5GRNfdG1WVOS5NAZXWOFpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArTnAMIDZBfXoQNw0M/5PJCPVQTJJmWwL2BQcQC461Q=;
 b=usCJisb0VEL6RlLxkgGMnCl0r00FxUXzhpqZSFjFJcH6UKKt/mR7dgNyPWZaYYH2e/CcwRA6H3pzdJOw00s+m4kx36MhzZBCwvg7hvH4d4HnAq9kLZbY3FAYf6GRC0KcIvi38RO63rbelVGxD6osDa4jJkmvEcs8ipsnHBwFFXOPXztUvhTK8hfEKkHTPpL/L07XKQ2g5cspMHOgrDWsxGwxXD0r+/I9+cseX5pwmHcuurTmq4To+a2e4/GeTEx7aqw4bdjqE/JOHYetsfx4ZEoHkEbND5RemA3bMlYLmsEngb2zu+tQXLdLDdqO7GIEeHGnBQILHDsMLOybfOlwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArTnAMIDZBfXoQNw0M/5PJCPVQTJJmWwL2BQcQC461Q=;
 b=UsH1QFJuTRa6R6Y4kvPTEsDSejtioTMm+pVIpqxniDlu4eKVig799ASs06OzejoAyqDyq3qVLjF3SR8n4ZQzTBtIfNjkPNym5pMqNhN2gShLvE5rr7u/uRlEAIfBXFU/1XMjlwLQtf4pjTkXz0rIw5ZRR7b3YI6eIfLJur1OWO4hYnq2T/zua/Jm/QmSi79rj3fCyGOUjYgoZYVG+l2wk5SrGg/4vpzlRsB7co48hxsHERJw7kTGavC2U2BqFg1cP1fSwVXsS/MXvwG4omlTT3F5GN7rIopwSF1Ndck66es1p3SA0NPWgP3NsmPg/AX0Do5k8yYPajEpVRczcAI3OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 06:33:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:33:55 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:32:57 +0800
Subject: [PATCH v10 01/21] firmware: scmi: support to manage SCMI protocol
 drivers with a linker-genetated array
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-1-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: e0abeb01-0e78-4a37-0046-08dd82f9fc52
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEJuTTZuQkxvdzBUcGErbWE1Z3dRVVlyMDhDRXVXdC9aZnhzQkVsZ2xLUzY2?=
 =?utf-8?B?QkRna2ErOENlTnZ3WThkRmdXRFdDVEFkWUZhNjF2T3pmYTJsdnYydDRic0dW?=
 =?utf-8?B?Q2cwdFVCYXQxSzRLZmRCNmdTWWQxRENQeS9yblF5VGJWOHhFcnVSUWo3WFdu?=
 =?utf-8?B?STdjMGdoTVBSRTRLd2dKMHpNV2E2SUFNamIvVHVVMG13YStJdWtKOE5QVjd6?=
 =?utf-8?B?RGZLK3NCcTBaNjVXKzV1MU1mWGpFZkhKUWJhZis3NkFndnZxbHVyOXhtb2FC?=
 =?utf-8?B?VW1scDRQVDFBU1MydGpCVXI2RUVEUkg3NWJCQXk1R3FESTZ2NVhwNjZmbXd4?=
 =?utf-8?B?WUU0TjZieEdJWkd6WDlzVmNOSkpJUEtWS2cwUWNOYmI4NGhPcXNzZXJKOGtT?=
 =?utf-8?B?akNEenVBTmtvK1BMZVpnV00vYjRMSjZGSlNUOUlIRXYzOVlodW42UmtBNGhz?=
 =?utf-8?B?T0R2b3BqcE44SnJQSmxRTzhzcE9WK25XWVNubGZ1ZXVzaXZ0aW9qQzZiYWZL?=
 =?utf-8?B?ZDJ0S1crdUdvdVZKeFhQV0taQlI3TUhOMFMzRmQzMk5NL0VkbTc5b0Q2L1Bj?=
 =?utf-8?B?bXp5VFh0RC9VQzhreUR3SVJtd3k5eVBLYnNHenJiaytJRHZZcmpFcUQ3ZHBU?=
 =?utf-8?B?cHQ0bTNMbTRqYVlCcmdNMWhnMnRYQjBWL2ZpSmVpOW5mZlduRWY0NDJYcVdk?=
 =?utf-8?B?MUNTZXdqTWg2c1k1N21PZENxbnEwOUpBbmZOTnZzT0wybHpMNDZKdHkraGsy?=
 =?utf-8?B?eFJ6RU9uMEZpVEdVckhqSnlvUyt4YncrZHEyVGZMRUs3SkY3SEg3eUF4Wm5E?=
 =?utf-8?B?TzJEWk1ObVdxbk5BZHBxeVlmaTBCWWVEbjBQM1FibU5SSGgrSkpkTUhiblZH?=
 =?utf-8?B?enBTVkEvaEx2dWpUazRpellxS0FqRkQ0elJhdFJ5UlpNMU1nZDJWRnZCT0I4?=
 =?utf-8?B?QXExR2FwZ1RzMzdkc3VzcGxlN1JJRllGOGFUTVNJVWt1c0NvemNJWW1uTXZp?=
 =?utf-8?B?Uk1NU3JuZjBZcGVsRFNLd2VMUmdubjlNTWxSbmxTT0VZVXcyeThlQS96SElK?=
 =?utf-8?B?VnpwbGJVUkduU2kxTGtaUUVEMGZzSHFwU1FaL2tXcHMwcWd3RTJsMHRjUDdJ?=
 =?utf-8?B?MkJ6NjNOWnB4ejlXRjNOZWdCWVlOK0NtTFNsNTNGby9kZGU2R0Y0VFJuMSt2?=
 =?utf-8?B?YkVOVGRITmxXZ1dqV1o3U1pUdUJqTG1oUzhyTjNBdk9DZXRQZ0Z3OXMxdEN5?=
 =?utf-8?B?ZDF6eHJZRFlaTW5laVRUTkpRSUg3eWlweDEzdXpoYllJZSt1NnB0RTdlOHFt?=
 =?utf-8?B?V1NrM0NVUWR3QmUybmpTOUNUdFo1VlRyWVc5aWVqRFNEcm0yK3VUVDg4eCtO?=
 =?utf-8?B?UUVRNys4NWlqaktKMDFMWkFjSW4yQURxREFmVk44WUZVNE5RQzIzZjg1UEdB?=
 =?utf-8?B?OUJ0RGJLNXFHSnlOeDk1aWw1NnJiNHROamR2ZlhLVGlYclIrbXVlcFJGd0U3?=
 =?utf-8?B?NlRrc0dCcmsrbXpscExSZFFUVWR6MVJkU3dRc0xzL0tTeEl0L3RHdk5wU0hs?=
 =?utf-8?B?RW0rQy83enQvbEtWTEhhR0wvVmpYQjVueTNaUFUwVk0zbFVCdDA2ZWgyWSto?=
 =?utf-8?B?Mmt1dWpnWmVycjhyaWo4My9STXVuVkg3N2lOQUtnSDZOckJEKzNkS29wYk1z?=
 =?utf-8?B?aXUyRVdTTDgrWEoyMG9yUTlPLzFTcXhBSmVzTUpDV25DUWtQWjA2aDdrUHNJ?=
 =?utf-8?B?VnIzNFZZcjlGTzJGdWZ6OVNIdVF3MlBxcXVoZHZVNVloT3N1RE03TWszQ2dh?=
 =?utf-8?B?VC9hOUdsRnlMMmk4QXprL2ZQOTNlU0RQcGRXVHlDTWcrbDFWeHR0L0loSEds?=
 =?utf-8?B?UFVleXFNZWtTL2tqeDBIMEs5SGRUb2hDUld1Yy92aEMwS3RkY21aNTRBQUdl?=
 =?utf-8?B?eTEwRGFOUVFJVzdyVFlBb3hXcWlaSWtMZTBBZXZxelY3M0g0Vkc0TlNqTUxR?=
 =?utf-8?B?Q3ZtY0tTU2V3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhXM2tScEw1ZUxMOHlCVnFacUd2UVljVE91Zjg0ci83cHJ1TU8vNHpSUW00?=
 =?utf-8?B?dnhGNHJTeUJCQnRLa3J1eW1sVG8zNWRGc24rS25wUFc4VEphcWpRNkZndEgx?=
 =?utf-8?B?OE1KME9tY3Y0SzQrcmpvdmY0bzBlYWZ2b2MxcFhIUnVpSDNTaTlKbDdxZ2pT?=
 =?utf-8?B?V0ROV1dYb1I2K25SL1g2TEg0TW5GYTQ1MjN3dnlVZHVzcWRJd1AycEtVT1hw?=
 =?utf-8?B?VmtTcmNQUTJ6WU5ZVXhTOXBBdTduNWhaTVdZQ2djbm9kK0l2LzhjWWRPSGdX?=
 =?utf-8?B?WFdLbmZhbW9lb0dIU0Q2Y2NPb1NORWcwMjNaRUQ0b1lxZ01QQTc2NzRSRUJN?=
 =?utf-8?B?WjZFTWowd3NsakQ3S2NBdVg0MjRKS1pVK2t0bEpyKy9DTWYxWmcxYXdFTkh1?=
 =?utf-8?B?WXBkYUp1bG4zVjhGZ2s2L001VXdnVDJYbGpsY2NONVUrYzltZmFmVFF1bkN1?=
 =?utf-8?B?SFQ1ZklTZXBoY0MwNEhuaC9rT1lRNGtESGk0ZVhwVEFCNEQ1U2gwVUY1aVV0?=
 =?utf-8?B?TGdFcFVKZW9NOVZIL0haTHQ3RGNNUVk4N21Oc3pzdDZrNWtkbXVNVStncjZw?=
 =?utf-8?B?ZUxWalMvZ2xQUkxsdG9SMFdTOFVyR3lvaXByQklWL05aT0N3NGU0VUs0eFo2?=
 =?utf-8?B?WFo0QUtJV3RweWVuODVjR2o2RUFmbUFpYm5BNGlRWEFGOW1DanEvZzFMc0Mv?=
 =?utf-8?B?am1PeEFyeE9QYUdzU21hSCtLVkJpWFEyMkZJSS8xTkM2Rm5kYnR4bWMzTzVH?=
 =?utf-8?B?N3FCalZsemhGa2o1dlkwTHl2RGpFOE16a1I4dTZMZzB0R2RnZjBOaEZqazNY?=
 =?utf-8?B?eEp2MlU2SlJaVy9zdmk1UkdhZXBHaVg4d1Q2SytYeUxmcmJ6K3dLYURRZkNp?=
 =?utf-8?B?TjFCUEJtU1pFWXpnbkNjb3J2b1U4cEpGMG1SZ3FaSHRDNjVGeVd5c0VLWVcv?=
 =?utf-8?B?UjZKcnRwa21BTThoS3NmaWxSdzRYcXZGeUkwUlFZR1p4eHk0dkRhcEFyUG54?=
 =?utf-8?B?QTQ2d3pvWlMvYkhTQlFMdlppVWw3U001UXh2eHdzK0JaT2dTczZBMytodjVI?=
 =?utf-8?B?ZWRuTmZmcjMrUGs0cWxzMzJBNjlvVi8xTFBJSkNXYzIyalJtc1l2U2RNMURw?=
 =?utf-8?B?RHZXMHIxeVJLQlNLOTgvVThyZndGZXUzT1I5ZG42bTE4MVdkMDcvbk4xQWtF?=
 =?utf-8?B?Z2s0eTBDaEpJTi85NzFLWVd6TmlwS2piZyt2and4c2VnM1I0ZVVvalNQQW1p?=
 =?utf-8?B?T0s5bHlEY2xhcldxblgvcC9HR09sTFMxVllkdC9rTXZWRndUcGhiVXVOWVlv?=
 =?utf-8?B?VGtnYzF4M1lOc2Z0UU1KZVcwNTRrNnkyazIvd281UmJtUi9UdnFMY0xrZ3ls?=
 =?utf-8?B?ZzNLT2oxekptM29KeExBZzloTnVZS091dnZiOXBlakcxdGlhSXM5SjJnWGNS?=
 =?utf-8?B?enFMSDBKRGJWU3hhOWpIOFVkRGJxMzI2UkFYeStkcEVCNFd5M0lXRU9IMEdB?=
 =?utf-8?B?RXBHdWJ5NGg4elJtSWZ4cEkrRFJRamIycUpxNStyajlVZE9CbHZnNjcxcUtS?=
 =?utf-8?B?MXZlSXNITlpSM09DWnQ4RGpTcGhZZlFKM0FlMVJ4Zy9yZXBrdVp2TDVEMU9h?=
 =?utf-8?B?ZkVpRU4wUGlHcnE5aDFpZldrcEZZSTlvdVR3TkdpN1hzV1V4OEhlc1oybDhF?=
 =?utf-8?B?cS81b0ZubjE3ZzE0T1FRYzJZb2NqNC91Z1NTMzROaFM1cHFvTTV1RTJKNk56?=
 =?utf-8?B?dHhETU9VWHBrYmNQRTMyN2g5TjBGWDQ0ZXRUR1ZSRWczYTdPYUMyL3FJM1VV?=
 =?utf-8?B?d25IajJKakxTdHUvTytpcEdSRElML0tJRUlucit0d21QRzUyQmJqTHF6MGZp?=
 =?utf-8?B?OWtrYktmaUtvUnptUlQ3N1BCeW0wNlUzR2t3WjlHTEU3bTRMZ01DQjBxWVcy?=
 =?utf-8?B?eTNTWXB3T2psOVVwUlF0TkFCSGVtazFBU1NCUDM3ZlVBM1RmcWV4TjdreFo3?=
 =?utf-8?B?ODNiSmcvb2YrNG5GUmNqR2h0UDhaVWVvV1QydUs1SG1ZeVdqUXVjb3JVYlY5?=
 =?utf-8?B?WG5zUUxLUDNqQ2NPWFk2Y2QrVUpFOGhHblBzb0NrbzFtdkFXUVNDUEhoRm9D?=
 =?utf-8?Q?efOWuL+SiokXoXoDCpeD5TqKL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0abeb01-0e78-4a37-0046-08dd82f9fc52
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:33:55.6218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iF+wwaUWOlZnj4zB+KnkqvVd66Y5zY0ejpSHTHvehaSG+7if5Gp2a/sUlul1P0R/euxMuRgyUPhil9kNVDbvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738
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

U_BOOT_SCMI_PROTO_DRIVER macro is used to add a SCMI protocol driver to
scmi_proto_driver list. scmi_proto_driver_get() function can be used to
match a SCMI protocol id and its driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 16 ++++++++++++++++
 include/scmi_agent-uclass.h               | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index e6e43ae936a..ea79cfa0cf2 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -352,6 +352,22 @@ static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
 	return 0;
 }
 
+static struct driver *scmi_proto_driver_get(unsigned int proto_id)
+{
+	struct scmi_proto_driver *start, *entry;
+	int n_ents;
+
+	start = ll_entry_start(struct scmi_proto_driver, scmi_proto_driver);
+	n_ents = ll_entry_count(struct scmi_proto_driver, scmi_proto_driver);
+
+	for (entry = start; entry != start + n_ents; entry++) {
+		if (entry->match->proto_id == proto_id)
+			return entry->driver;
+	}
+
+	return NULL;
+}
+
 /*
  * SCMI agent devices binds devices of various uclasses depending on
  * the FDT description. scmi_bind_protocol() is a generic bind sequence
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d..842c56858af 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -115,4 +115,19 @@ struct scmi_agent_ops {
 			   struct scmi_msg *msg);
 };
 
+struct scmi_proto_match {
+	unsigned int proto_id;
+};
+
+struct scmi_proto_driver {
+	struct driver *driver;
+	const struct scmi_proto_match *match;
+};
+
+#define U_BOOT_SCMI_PROTO_DRIVER(__name, __match) \
+	ll_entry_declare(struct scmi_proto_driver, __name, scmi_proto_driver) = { \
+		.driver = llsym(struct driver, __name, driver), \
+		.match = __match, \
+	}
+
 #endif /* _SCMI_TRANSPORT_UCLASS_H */

-- 
2.43.0

