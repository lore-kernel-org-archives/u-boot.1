Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13702D206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990C288EAE;
	Wed, 16 Oct 2024 09:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PUr3JLMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B0988DB2; Wed, 16 Oct 2024 09:20:08 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A7788E89
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8kqz8exJQDhzL1ssTtFoZXwlNPV7MZuy5R0oSIUL+2IKhI9SmJWHPjxV6Tgxm/fq5bEfrO9jSZpGiS1wY/3AkvyAe8JdQ9kjws+CuqEnPvzUbq6G4qiPS9iaQ3tRx4FtX6w1DkvIFLhRcMwMk6+jVKZeWJ12kVElOxxAqyD+53POWcOY8ZCvAVv1M4bhJuVyXcQ0YJgG+4CRzyFvJhmGxUwZKWL1zIHpVlXUpKGMK9Rf0hIMIdghQmQzY3AvxDu7kLha4PBKpdLtXrXd8Rqhv7KQyGO5SXtqy2rpmNg/lSqUmoHQT6UeqaB/YqUpRhhfBmfImRNRqZQfLzCIL+Yeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY28Gp5hEBHgEUyqSZiHuxvkBj4fSUi5wuUSzN0jo/o=;
 b=n4CVL3iLT1qft2N9Wkor1ovSqwJq8jxN2Wfvv9XNrnCmcHTz+USKFHbYzxN/k8UpK8VG906bKawNmBUvRGfn4AqK9qt+asXSG5lVFDJaCdWckUTXhajMdnkYTNcXwjpQPLiixhKF+oZazg/sgFoh3+/0CNC3fyVACuLqg18OepWbPRfowUmF8FYNNuCFQqrzKsB+llH9Y+tao3XGPKNN2E81GQPP3ofs23V69chXzsA3btofSYSO4AYQ1uDCvGf9sEWaBIn3io0p7rD2+zuietO2MgHfN7bAL1xzN3D0Rn85huvePiSe5x4MDZztfJgZbhg1hsahzwgHBnrKol5Y3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY28Gp5hEBHgEUyqSZiHuxvkBj4fSUi5wuUSzN0jo/o=;
 b=PUr3JLMDKhX+k+H1eZ3H3nWhPuB5vKnoM5mr7lOvjEhRoD0iIuOpYJzHANm0ZXP759avq6tCXwkA66FeyWngZt6f6WamR2JSrFYYJDpFxCL9i88Sh87ggIoVXwHb9SMVcStKWtFM0s+3ziD9tyXR0tBxTS5/N1p5Kruw7gevSPtDlg9cwfD8+wF1+Edo/YMapX3VwgklRP/+0iJngVZc8IuKIYM6b7jODNjUYHAIy0dXeYbsibKu1ZytCL/e4xO6N3br2Rno0/dHWNZizIl1aQdPtieTZSIcUEmYrlHxu6hJRlmfeswso7fSYbuUOlVZv6j28t10r53zBtZc/kGyew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 07:20:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:20:03 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:10 +0800
Subject: [PATCH 17/17] imx: Fix ROMAPI driver to load container image
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-17-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GVXPR04MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: 2419b7b8-7540-4908-1c96-08dcedb2f421
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGY1M2FYN2s5bWJ2UmFEVFE1czR6MkdBTis4cmFWRDJrb2FmMW9ibGJDRXNL?=
 =?utf-8?B?dDh5Z0RERFRINmpGZXhHaHZqdUF0Nk9qZXN0elZ2RGd0L3c5UFJYVEdhb1hW?=
 =?utf-8?B?MlBLN2NPWlVnSUpIN2d5UkZiWkY5cFIrT1JleHhvdXpQMWpPQ3lnUi9nSjQ2?=
 =?utf-8?B?eDhDVmQ4cnVnK1pVRGoydzB4Z1ZaU3lwUWpFVkpxTVU4cm8rWU1TeVJnZmNl?=
 =?utf-8?B?cGdxZVhzcmh1c1VHWWJjbGw0ZFJpa0lZS1IxdzdFU0lzLzd5VDRYaXZud2xP?=
 =?utf-8?B?L1prYWlZZWVZVmE0eE5ZYWhBaTlRb1prMEV4TnYvWUhNU0NOeEpycExwMUpy?=
 =?utf-8?B?QS9HemROazR1RnNZTnZzYlhsclNrN1M0YTVEcS84UTRGS2hCbnpKc1NuMTRu?=
 =?utf-8?B?OHRnblRIN1pvZi9MaHAyZTlMK2ZTMm9RMFlpUDE3OCtnRWhLbm9sZjJVbTRm?=
 =?utf-8?B?VUZ6RGFvR3dSYlBDd1dFbGRja28xMjVOWHZXRXVnTHdxakx1UWRxWWNHaUU2?=
 =?utf-8?B?WjJ4SnZJZHRwWktMYzJONWp4eFc4dWZUekdDd2ZZWWlVSnZUVnB4aUNWRmRo?=
 =?utf-8?B?K2pNYWYxOGJuTDJZeU5HTHhNTHJyYWlTV1g3YWNJZURQb2tPVnNvTHROTE1w?=
 =?utf-8?B?SHdVWUxIdytEajg5cmZ1N0dUWk1GeCtIajZCWlpPTGdHc2xMRjdlM20zRGFv?=
 =?utf-8?B?THErY1R2VHBORXZyZzFCK0NEUnJ0cFBNamVVK3RiVVY3QnJodEJrRHpZelU5?=
 =?utf-8?B?TjhMcDJMWDJDd1FDVG12ZUlTODZNaXYvSWJzMHRodGFWd0YveTY4TkdTdS84?=
 =?utf-8?B?Ylh1cjZmc2xkcjVvOHRnRjhiRXlhMEdZQTJpTjVOcGhHdDBwZUZtN2prcHVt?=
 =?utf-8?B?N2VSK1JTeGNQTHpiNkJqd2xqVmZ3aEVQN3RFUGo2cDJpMDJXVkVIQ0hyZ2R0?=
 =?utf-8?B?SWdMRUw3NXZLdUI2TmtScVVIK05TQ01TblM0Y0Q2NUtyWlBuY1ZWTWhvdmlk?=
 =?utf-8?B?L3lMZ1p1cUxyZDg0L0NjL2ZLejFML2dQZk0vWEUrMnVJQ3pVZ0tTM3M5SEwy?=
 =?utf-8?B?QzZBSWlXOGJXb0RvR0ZYQUNKbkI1dXpYRUpJQjlVSVpMVDNQU01ZOVFENXZW?=
 =?utf-8?B?V0xmMFB0ODY1blN6S2kyM29GQnRmbXY0dVNwUkFVOXYycmV3SWtiNy9ob3J4?=
 =?utf-8?B?amFmU21IYzhZMmtlNms5d2N2ZGtJSi9Kc2Y3WVFXQXkwcE9nSkdSVVpnTFlZ?=
 =?utf-8?B?djA5NGRrTlFBWllXNXBTN3Y4MkpPVWxRb3V4RE5MWC9xQ2tVUlZWWVU1bWpU?=
 =?utf-8?B?ZERIaStBbUY2UnJ4d2tvU24yclMvaGJBWWNzY3ZJdzc5YnpDRUpSYmt1RTVH?=
 =?utf-8?B?ZVhpcVRHZi96Um94VldxaFR5UDljZmZySXZ0NzgwTC9rRTZuaEJBSXVkUmky?=
 =?utf-8?B?UFIwQzlwV3BPU0YwNm1MS3FudDNrRDlkK2J6NGozN2wrRWMrWkFGQTJreTVQ?=
 =?utf-8?B?cUNrcTJMVy81TVRDRVhmNHp4cjdxdEpySE9idnYxc3BoVVcwdVlqVEJKclEw?=
 =?utf-8?B?VFRqajlacms0dGc1UWxsVGJzTjZ3NlRLRlhJQnhHSkNLN0c4Z2V4cWdrb2NU?=
 =?utf-8?B?RCtPa29rRmpRMGJJOENlQmRYMTFTaFdidGZsYUhWeU5hd2lOeDh3VEZXN2pZ?=
 =?utf-8?B?V0RuSy93U0w2NTMxeXNmbzRKa0cxRXhvNC9mdVhjSGRtSG5EdUNGOE5ETFVv?=
 =?utf-8?B?Ni83aFIwbkM1RW9HaWJLSWtQOFovYU5CQklnZE8wSUJGQ2t4VnM1R0FVOVh6?=
 =?utf-8?B?cVUzMmhxTjlEZFRmaWJiUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUdTNnNpc2ZnV1ZNa09JTnlKL1N3ZjFNV3pvYlMvT0N2ajlIeVorcUhuVUhQ?=
 =?utf-8?B?V3hmYXpMKzMyd2pGRURPT0JISnlSTkFjRDFsS1RRODZwbnVGTHBzWWQwSTZy?=
 =?utf-8?B?d2NEa0h4NmFGQ2tNektsU2Joc2taUEplaGhpTldqZWkxSENYQWREVG1HZWx2?=
 =?utf-8?B?bTMzRFFpT1cwY0FKaXhUWlRPeFBON1BIN2xCejZ3VUJjak0rZG5na1JqWVdh?=
 =?utf-8?B?eVZZa0YxcE1WOWpUMWRoZjg2bGFqdEJWck9ZaHdRV2wzRXZyYWtYM0FyTk9m?=
 =?utf-8?B?Snp0RXdwd3JTK2RXdWdSMjZKdW1TK3BOQ3dmK1FzUzdKWWxNSEpxL1Q1ZVBs?=
 =?utf-8?B?K0NLc21jTU8zMVlWWGxkd1lnK1ovdjdOMllFa3BKK2Y1Rnc1YldxaVd2Uklv?=
 =?utf-8?B?UkgrK2p3WklSSE5EV0NhUGRqNzVtcWpjejA3cTdDb2dhNTdUKzEraVVUUWVu?=
 =?utf-8?B?Z3dwNkt3d0VINGVwNmE1cmQ0Rmo3Q0FmbnM2YVpNKzd1bnErT2hINGNnQzg3?=
 =?utf-8?B?encwSUozQXdLL1FvZHdEVU5xWGZEU1h4OTJFTkZKMmpFaXhESlR1d2RZZmlH?=
 =?utf-8?B?MjlMWGF5MlVtbWMrS3dsVkNGbmpqTmNIbWJnR1g3UWlLVDJDSFh0aTJaUWZI?=
 =?utf-8?B?cWJsUmhzNjRIWXR0bnpGWlUyaXFEa1M2NnU0UnAwbmdLR0lRc0dHRk1hdXAy?=
 =?utf-8?B?Y3gyNHBJcU5WQzBraUtYZFZkeW5WRmNYVWhNZXhHYm1KSUQwYktKU0lsVFdK?=
 =?utf-8?B?YVBPOG55ZWxEYm83aFgyZ0RxSU5UZVRyb2ZOL21qWXlndURBT0szSUtlaERs?=
 =?utf-8?B?RnVnOUFpMDNjY3RPbURxSzB0SHpLc2tFcGsvZk54S0E5R2xleG9vVlhpaHFw?=
 =?utf-8?B?eW0wbG41MEdleW9mVTY4M1o4ckttRkRqR2s3QlRxbWRqMzlZYlZvWTZsdmFn?=
 =?utf-8?B?TUZ3REVVczJ5VklrMDcva0h0OFUrQkVpMDhtVHgxTU51Tjhkcm5UbUhaQXN6?=
 =?utf-8?B?UHNVby8yTHpiMmt4ZWpObXc5ellQRmVqSmdLTk1JQjlDVlIvdGttQzRxMmpj?=
 =?utf-8?B?bE1HRHRVeHhpSlpNYlNvZC9GT1FDb1E4emEzTnlySlVDZnZnK2tOQnBFY2xx?=
 =?utf-8?B?cXYxemY1WDJTei9YbTY4RkFMWDRBVVBiU1ErT3B1OTR0T1dHZXVPZEx1Rlpj?=
 =?utf-8?B?ejV2eGlvN0crdmpmbk5VV1NxQjhDZ2tRMGlZR25jM1lQVzVvSlFZMjlqR2hv?=
 =?utf-8?B?WlJyTi9UbzJsVklybUltT2JGYkhmTHFNT2V6K3pldWJDR1VuNXhRbk4wUm4r?=
 =?utf-8?B?bHFUdklRaUY1YVUzZW9VMTMvVDNqR0RKK2JZM2E2OUZhT2dYTVlJOTZWY3Rj?=
 =?utf-8?B?UldsbGYybjlBYm9UNjl4OTNlU3J6TCsxRHFSUFhseFB1TFloaFAyMmJDb3p6?=
 =?utf-8?B?VS9GNlZhQjk3aERubW5YTWJEWWszNzBaaC94SitXMU9kYUpZTkZZSG9vaFR5?=
 =?utf-8?B?RWNOOGtGN2dHRlhSQ0kzRUxiSzZWV2YzenJndml2czd1R2hPVmZFY3ZJV2Vk?=
 =?utf-8?B?TTU1Mmp3cUxhaVBEQldhbjc3UWEyY0lIblJ6TEVLeTN1TDFwNWF0VFE0K1hv?=
 =?utf-8?B?a3N2NjdsZWYxQmlWSGo2VWJMTUMydENhRzZ1eTVPeENMeHpUZCtaU3VEczlN?=
 =?utf-8?B?U2FPZnBFTnM5Y2orK0s4azFHQ3UzVFFUNEtxTjRERDFWY0NRcCs3L0k2bHhj?=
 =?utf-8?B?ejFxNWhPbFUxc041cm5HZEhwRGFXc2I0MnpJZUUxU1hlMzd3aEZqOUNjZFpp?=
 =?utf-8?B?ditWYS82MVl4Nkt0SEZycGNETGk2R2h0Wlc5TG8rUHdtcEVSRDVQYS9SSjJE?=
 =?utf-8?B?RmtBWkZZaXordjRiMFowaDkzeFQwL0hxZFRCOXZxbFgxUXo1NDAxck9rNFM0?=
 =?utf-8?B?c2hlYXNRTHA0TVovWWs1RGFnT0lxWlkyV0lqTjVpZG9nUXBWcHpqNHZSdVFv?=
 =?utf-8?B?NGdXdERJNHBUTTdWOUkzc0x6N2NSY3QrcXYvT0Q3YUxvNnZRM3hQRXBLR0ZP?=
 =?utf-8?B?VVVQZU12RGw4c1hadWN5NmVBUGIrT09Mb2VwZ08yY0RKTEdNdDZWa0E4UExP?=
 =?utf-8?Q?fkuHX2ZyUFpTU9Vp5U2YWkuP9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2419b7b8-7540-4908-1c96-08dcedb2f421
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:20:03.6788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYUV6dEKw6qlz9w/1nL9isRD+DpEEx04Fdcbx42zDqXw/QIrIymtv/JwdzdjP144eZdHSPbhix355sDMPGJAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235
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

From: Ye Li <ye.li@nxp.com>

When using ROM API, the size and offset must be aligned with page size.
However when loading container image, the rule is not followed for
container header. It is ok for eMMC/SD/flexspinor, but fails for
flexspi NAND which page size is 4K.

Fix the issue by providing spl_romapi_read API to handle the unaligned
read and around container header size to page size

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  4 +--
 arch/arm/mach-imx/image-container.c       |  5 ++--
 arch/arm/mach-imx/spl_imx_romapi.c        | 47 +++++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 878a4821996392e36d9bb02613276e502f463eef..076ff41652315d2d8276424843862ef30008b3ad 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -207,8 +207,8 @@ enum boot_stage_type {
 extern struct rom_api *g_rom_api;
 extern unsigned long rom_pointer[];
 
-ulong spl_romapi_raw_seekable_read(u32 offset, u32 size, void *buf);
-ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev);
+ulong spl_romapi_read(u32 offset, u32 size, void *buf);
+ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev, u32 pagesize);
 
 u32 rom_api_download_image(u8 *dest, u32 offset, u32 size);
 u32 rom_api_query_boot_infor(u32 info_type, u32 *info);
diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 27dc162f2517b6d75b0ed95510c09385f7cbc859..73dd8fb2f2bf1523032bdf17da2e347598403527 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -141,7 +141,7 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 
 #ifdef CONFIG_SPL_BOOTROM_SUPPORT
 	if (dev_type == ROM_API_DEV) {
-		ret = spl_romapi_raw_seekable_read(offset, CONTAINER_HDR_ALIGNMENT, buf);
+		ret = spl_romapi_read(offset, CONTAINER_HDR_ALIGNMENT, buf);
 		if (!ret) {
 			printf("Read container image from ROM API failed\n");
 			return -EIO;
@@ -376,7 +376,7 @@ u32 __weak spl_arch_boot_image_offset(u32 image_offset, u32 rom_bt_dev)
 	return image_offset;
 }
 
-ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev)
+ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev, u32 pagesize)
 {
 	ulong end;
 
@@ -384,6 +384,7 @@ ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev)
 
 	end = get_imageset_end((void *)(ulong)image_offset, ROM_API_DEV);
 	end = ROUND(end, SZ_1K);
+	end = ROUND(end, pagesize);
 
 	printf("Load image from 0x%lx by ROM_API\n", end);
 
diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 3982f4cca184716f0000a28767c14a57567ed54d..6a5d66a8e157b6030318211d4ca04b799ceb2527 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -14,8 +14,10 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+u32 rom_dev_page_size;
+
 /* Caller need ensure the offset and size to align with page size */
-ulong spl_romapi_raw_seekable_read(u32 offset, u32 size, void *buf)
+static ulong spl_romapi_raw_seekable_read(u32 offset, u32 size, void *buf)
 {
 	int ret;
 
@@ -31,7 +33,46 @@ ulong spl_romapi_raw_seekable_read(u32 offset, u32 size, void *buf)
 	return 0;
 }
 
-ulong __weak spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev)
+ulong spl_romapi_read(u32 offset, u32 size, void *buf)
+{
+	u32 off_in_page, aligned_size, readsize;
+	int ret;
+	u8 *tmp;
+
+	if (!rom_dev_page_size) {
+		ret = rom_api_query_boot_infor(QUERY_PAGE_SZ, &rom_dev_page_size);
+		if (ret != ROM_API_OKAY) {
+			puts("ROMAPI: Failure query boot infor pagesize/offset\n");
+			return 0;
+		}
+	}
+
+	off_in_page = offset % rom_dev_page_size;
+	aligned_size = ALIGN(size + off_in_page, rom_dev_page_size);
+
+	if (aligned_size != size) {
+		tmp = malloc(aligned_size);
+		if (!tmp) {
+			printf("%s: Failed to malloc %u bytes\n", __func__, aligned_size);
+			return 0;
+		}
+
+		readsize = spl_romapi_raw_seekable_read(offset - off_in_page, aligned_size, tmp);
+		if (readsize != aligned_size) {
+			printf("%s: Failed read %u, actual %u\n", __func__, aligned_size, readsize);
+			free(tmp);
+			return 0;
+		}
+
+		memcpy(buf, tmp + off_in_page, size);
+		free(tmp);
+		return size;
+	}
+
+	return spl_romapi_raw_seekable_read(offset, size, buf);
+}
+
+ulong __weak spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev, u32 pagesize)
 {
 	u32 sector = 0;
 
@@ -94,7 +135,7 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 	printf("image offset 0x%x, pagesize 0x%x, ivt offset 0x%x\n",
 	       image_offset, pagesize, offset);
 
-	offset = spl_romapi_get_uboot_base(image_offset, rom_bt_dev);
+	offset = spl_romapi_get_uboot_base(image_offset, rom_bt_dev, pagesize);
 
 	size = ALIGN(sizeof(struct legacy_img_hdr), pagesize);
 	ret = rom_api_download_image((u8 *)header, offset, size);

-- 
2.34.1

