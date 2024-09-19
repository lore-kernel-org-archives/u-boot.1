Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48DBCDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9861F89066;
	Thu, 19 Sep 2024 04:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kzAldwdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF2788E33; Thu, 19 Sep 2024 04:58:46 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E7C588FDF
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPnKTNET6880XHcc5afyzvvhb3MNJ8hzUVEv1M9fgXsCzycj05zp/FEVXeOEw5yK870OuBC5j4alDWRC26kgA2GPMaCyzVfn7GPk0xc0fVfMlGVd/fzK+cd2xz10+Ft4oMF/zZuU7szmICw3bp65qbMD1+sunGnAvmOvWw84ho45hdnVf0dCUIp9GDk1eB24kUEn32nZDRsg5EGKF82UMcR0NF5vpi8QMhctjEtInYXuJNt3aZdFEsueOgwKTkZ0nFigLx/pDzAuBKYXSBte7Xb1fCcJhVeS16d6h5/L48KJQBXaDytKs7KmQbkT2oVn3zGQ3Mo5kAdL0+eBwQofTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BeLICumJ2AEys8eAa3FBOlQl2Hbd3TfBnLX/v/3JdU=;
 b=YqmrmfggrVWMFZc+ux6Zfv3l2LKSynJUf2M7WqzjhCLGD6NP778FvyyXUJZRZUyX/gX0QnWVbMvc8wJphBhbfbgv11YnRM8A/hwowq916+zV+LossMOLRCU/qASHTAYCxGCmnB6PQHYWT/i7JyafTT4AmDV0gDsiGd2quYeF0SzNyzWZu+V0XuDRh8g1qsmUIPaknoJ3wJVjXrOMoLiMmcvMLfKCHZbNwpmQ85uAmCeEOszpLiDB6a+oQuJorFZ9BRHWe3MV4P0/jyEBtdnf1iM2UZ62HBJ/Hwktg5wDVaAO/8Fs4A4sm4zbNwQkgIi1g8tGuSkjfBZ+DdTHRFXO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BeLICumJ2AEys8eAa3FBOlQl2Hbd3TfBnLX/v/3JdU=;
 b=kzAldwdqSCLjro2q3zjJVoGJY52OFrjib2vqy35e6LXyKv4EM6pdo3VZWeX77MwL4Sgg8AP66vIhMh/9iaKp2gIErvWpbi+XGjwGzX96hI2ZfPya7z+W8j4HIRkrMyM8qGpVaMMQxPWGkErkKXO/45ZcmHezHVhQ2bRhHXaE6RN7334FI/5+uUN28CxPTZbpOOXGbBwsk5TcQExnJcSIP9Q3DrFzVI0VYwo36Jsq2VsyO4W9FAT0N1om+SKEsqINV0xHqfM+u2tIzxzEJaGrGol6L95LWFyQAH1pQrOlxQyC+VL5r/txtqHXvFvqf5+XhJKByIsi7j7p+4SpADdFXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 19 Sep
 2024 02:58:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:33 +0800
Subject: [PATCH v3 15/21] imx93: Add Low performance parts 9302/9301
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-15-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3503b1c7-be15-4132-bdab-08dcd856f875
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnppZ0h5M05IUmNZU2dxNGJuOGpNQ3BZTnBnWlloWWdOeEhSd0lDTHlTVnl5?=
 =?utf-8?B?cTJqbGlGV1hkM2lRWWtCeE1SVTI2Z0diMys1QWVzSmRXU2tqVnBnTktVSW5T?=
 =?utf-8?B?Y3F4cThwMDFiaW9pL254eUJVMTBsNE5YY3NxMDdWN0gza1F4ZFZDS05NMzZK?=
 =?utf-8?B?OTFWckk0UW9kK3pnSXplS3JHS2h2ZEJEM2ZRd0NaZGZ2eUkwZVYzVXd0Vm1L?=
 =?utf-8?B?ZTZRUEhlbEdrSlZWSiszUElSN0NuK0FCeU5sVUNXUDBBdjdRd0ZuUjExMkl1?=
 =?utf-8?B?bllDa3JzSjBUYlNWUkZxS0hOTDB0MmRBSERTOVpjdERsTXpxRVR5MGw3ZmJi?=
 =?utf-8?B?ZHpjRzJlS2kxdGg1QUVtOGZMNEhaMTVmSnRvTlpFeWJ1NGdHa3YyL0QvUUhX?=
 =?utf-8?B?OWhYVWRma1dlTjJrbXBlNGR6RWpsS2djUUswWUwxVnBGMllIZFBUVDJmbWl3?=
 =?utf-8?B?clF2THFDaWdmOVVHaDNaaWZGdXJDUTFnY3NzTU11dWx2MkZLaUhZWCsyK0Y1?=
 =?utf-8?B?d055ZDdTclJUVGYySHlHLzM3L09ZVTBYMFJBMUdWOTJ6UDM4SzY1SklSVk5F?=
 =?utf-8?B?bzNoZlc5YkJ3QkVXd0NXbFpRUWdoRzk5RlVrUTNEc2tqTG5HZFU4dWg4Y0M2?=
 =?utf-8?B?bkI3cUpIdVBDS09wSysrZHNpcFBxSE1XWDMxOWlnZlRVeFlWMmg5WlF4SVF0?=
 =?utf-8?B?azQ1YkRjRVAwUGtscm4ySmNkMHl5U2xSa1NtOGZnV2RvM3FCdnpheWlrUTRx?=
 =?utf-8?B?OEUzK29oZWlYS2tLVU9EVHFkbGNlU2F2NXduSnFsZXZPbFlUTUIrRkNUM2tq?=
 =?utf-8?B?S0NKak1taUt2QlJodDRpN29HQ1c3dlptaUJEY3U1eEdMTkFsY0Z4RmtNTGZ4?=
 =?utf-8?B?ZW1IUVZNSnNMOXdCS2N0WmNFMXhHSFRNQzUrSlA0Q2doa0JZYWRRWFRxVFZP?=
 =?utf-8?B?NGpmdEhoOVV6NzlsUWdSNmt1aEVoWi8xOHp5NU0wR2hOeDNLc3k3cFFPWmVE?=
 =?utf-8?B?T2xjcTEvUzE3VVp1azJPZUNrVm1vVFR3Z0JxZklMclhsZ2JXL2dGK28xdVgw?=
 =?utf-8?B?anFWSFZQeUZpSmVUdlcwTS94eVpxZHRwS2NueVlpeTRMWjRaV21VMUxFMFdJ?=
 =?utf-8?B?R1FpZkVUZlc1eFo3Zks4Zk84WFFCSFI3L1BubElpQVhrYlczRVBHVFROR0Z0?=
 =?utf-8?B?S3MzT3l6QlJKOFhPaXUvN3FQU2V3MGkwNVllNExvb256K3o5YmJJUFNBR2or?=
 =?utf-8?B?Ykt4czN6SlZQTU9IOCtuRVJpa0VQV3kyQTNMeEhwT3BDeTdzZFVsZ2wxV1Bs?=
 =?utf-8?B?UnhucjI3c0gwamZlNHErZmxUVXVUWnErb2gzcVhpWU5CS2RVMHl2ek96Tko1?=
 =?utf-8?B?TWRxM25ENXJONTFpSjBBbnBac2Y2VHp4RUxNazkyek1rd1lIeVh3K2tMaWY3?=
 =?utf-8?B?b2pIOEFZL0hCWUd4M3VnQWdZTmEwQzd4dytRQ0RnWXdqZGFiWEFYQkYxK3Zk?=
 =?utf-8?B?bGhpZnJrNVphckFjMlc0anpzR2I4UkZUS09ESkFYdVg4ajlFNWRBZStQWGUy?=
 =?utf-8?B?TGN2K1ErRHBTZzJJSXJuZWRZdmhUMHBndVh4Ky9sYXp3VW43WDd2NGd0RjJC?=
 =?utf-8?B?TXNIa1JsMlhaK1BiMWRna2hlU2YxVHh3L0dlTkFaVFo2Y1c0VnM4Z3VjN1Rt?=
 =?utf-8?B?dThqN1FLcjk3cUNrSElvOFNHeTFuUFY2T2E3RWEwcFVHWVJZRTg1T0RUYVJx?=
 =?utf-8?B?WUEwajlaWXpacGR2TXc0Q1VISFR4dmpGcngxNHZPaUROb01GM0VYbVpBSnpi?=
 =?utf-8?B?U1kzRnJONjRtMGsvTW1nK25tRHBtMWtNUzVVZWVSdFh2OWprNU5DYmFqUjQ4?=
 =?utf-8?B?N2JINTF3WEhBeHRQdmpnLzR3WWkrekFmUW05Rm85VllrSEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFtSDRpVkhIMkducnErS2dvWll1V0lvaVE2U3dUZ2F0VDEyR3BSbmFYKzQ0?=
 =?utf-8?B?WTVKY2MvY1hJakFnSHVWQUhoUVNVRThWNmFTWjM4eVp1YW9GNDdkSjFQMmFQ?=
 =?utf-8?B?UzR3NmhkRmQ1SHdRZU10VXI0WXExVUxpNmZidDAyWWx4YnVraFhHR0d3ckJX?=
 =?utf-8?B?dGdaYzZqblRYeEJFRXJ1ZHZQdWZlVFowVDhtb1hodmp4dWpmbmdZbWErditG?=
 =?utf-8?B?Zmd6VHlyQkttdWZFc3QzYWRocXphMmdBenRZeEhMWm5VOXczVVQ2UGZsQ3ln?=
 =?utf-8?B?TXhaTlNQc0RHQS9BdERNNUhFT3E3bzh2Tm4xTFpEbTAxMCtwQncxZGtmVkIw?=
 =?utf-8?B?ZEE4NWI3SkxSeW1EeGZ2Vm4zaGJ4ZzlZK3pORVNicUZqVXBqckN3NW85V2dy?=
 =?utf-8?B?OXNkUFRWc1hGazZ3YUs0Zys2M0dkdk45TFRubE0za1hveG85OGRhRWJENGlr?=
 =?utf-8?B?Ynk5YVZBQWltaEFjUS9EVVhsS3ZyaUFucVlUSWFlZ1R3SXJRK3lHMEJ1SjFS?=
 =?utf-8?B?OE1tSlRHREl2VHBteFVkVFdjNEh1OEJqNjJaRDU0M1Z6b0R2OE9sa1NPR2Rl?=
 =?utf-8?B?eWpFT1hmVGJ4cUR0WGxlNWk2L1o4eEdVNERsc0xhek8vZStkVHlPRzFvYm5R?=
 =?utf-8?B?SVhwYkxNS2RVQlF1ODYxOHNtcXpiSWRxc25xVlhHaGRMaUJjSVQycjB5YW1n?=
 =?utf-8?B?VklaejkreGN4YVphYVhUOUlyQVAydi8zVjJrNzlhMjZiWXdvZkt0VXU3cTN2?=
 =?utf-8?B?eXQvOFNWOE5QVm9zeDd0cHIwS1FxKzNBYXhlYk9lV1hLNC9vS1ZhYW1pV1pN?=
 =?utf-8?B?QXRHSWZWZ2VpTVpBakM3NnpSZndOcU40M0NFYmZZUU5KUVpkUXN2TkhKdStL?=
 =?utf-8?B?OHpsZlVmUmtLdlY1T2o1NkVrV3d0V1JpVGJHU0tGczFqWDhDdmRYV0JrLzJ0?=
 =?utf-8?B?OHRyR3pkcGRqOUZZTnhQRFR4aGd0cTcyb1BQOGhMNFZVd3pRV3lvRWJqNElW?=
 =?utf-8?B?NzRtMXlpNHVZRTJOUmx5T3BISzdKL0RHSVZXbjdLY1FzRmQxSXFyamYvUGRW?=
 =?utf-8?B?YWh1K1hWZVlhQzRUMFozdThLb3AzdUMxQ1ozTWtseFZOQkt5QUlsV211RWVW?=
 =?utf-8?B?cGhja0UrcjRLV1d4cGtXKzdIRElKZmVaR0wyNUhRTEVTbFVlRjhSS2NyRUdV?=
 =?utf-8?B?bzBFbXROYlBsNXJoS0hsL21NSVVQYzlnLzE3V3NDc1pGRklSQUFUbVJMNU5R?=
 =?utf-8?B?RW5ROFYvd3B3a2wwMWVvYkZ5MUs5RndoQVl0c3UrQVR6bEh4TUlnb2dKT24z?=
 =?utf-8?B?MkFmUmp5Tjg2WDFqU241dHZwMnNHZTl6RjFsckVMb0lEak4vTklPYTZYQWxr?=
 =?utf-8?B?cUVuSFhHajJIMnFrQzhsUFhDd1Bkb0xlSWN1SUtRWlNqSXpsNyt5L3hwTExi?=
 =?utf-8?B?bVdHbzcrL1gwN09qRWVndGFLc0xKbjg4UDJwV1NmVERqQ2RsYUI3V1QyTm1R?=
 =?utf-8?B?QktIek1iZGlEN1NrZzlGZEs0TUJqNHdxcVdjUWg2S1c4SFNvTkxQaTR2anRk?=
 =?utf-8?B?bnhXM1JiaUNqVU5ZVzFNMWlJamJuWk96c2wzRndTbzVlaGNxVk1JSDV2bUlB?=
 =?utf-8?B?WGw3bEFBYXVIV25SWHdMTjdKdW1qVW4yWHNkVldob01KVy9zU0t4TGtmMm9K?=
 =?utf-8?B?L0dqUjJQTmpEMU5TYi9KRjZJclNsa3JpT3hmV1BTL1VqUS8zaGttRXFBZDFU?=
 =?utf-8?B?U0l1T0VhT0s0QTR5aEdORWRlQXBURk4zZzRYL2Nqd1RHeEdhcGxwNEp6MEtv?=
 =?utf-8?B?a0w0SzhMdUlVUkRsdHo4Y2FMTlRiZ240V2ZWVTRtRFR5NWowdEt5dC85Z0Vr?=
 =?utf-8?B?Q3ZMWmZHRE5LWUhYa0xkTUJLc1k5aEtSRlVJV3FxeVBIaWFqRk95alppdFdt?=
 =?utf-8?B?NHRCMm9ZOHVwZERCWUxDeVhKUjI5TzZqY25wNHRDQnF6VzFzQ2poRHczUlBs?=
 =?utf-8?B?OWNKZzFMaEluOGtpKzNHUzVwakVMNC9tanlHbURVeFlEd2k3MXRwWVNDRElh?=
 =?utf-8?B?MkRvN0NGMHhhZ2pWK1VQTy82anY2UjRiUXhBWk1RdDJCa3VFcmU1K09yRWd5?=
 =?utf-8?Q?+/Kk39nfUj2G0hJQYCe4H46YO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3503b1c7-be15-4132-bdab-08dcd856f875
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:42.7894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RyoeZBWplmFSQO2Tmpe4peBhQcjmKXbYzCcKsbggioKRtpsFjKDsjSNZQgQaiEgcC8Acz4/YSPiIw29VE8OgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
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

Add support for iMX93 low performance parts 9302 and 9301 which
restrict to low drive voltage only.
The parts run A55 max speed at 900Mhz and M33 at 133Mhz, have NPU
and A55 core1 (9301) disabled.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 2 ++
 arch/arm/include/asm/mach-imx/sys_proto.h | 5 ++++-
 arch/arm/mach-imx/imx9/Kconfig            | 1 +
 arch/arm/mach-imx/imx9/soc.c              | 6 +++++-
 drivers/cpu/imx8_cpu.c                    | 4 ++++
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index cbd2717f97c..b0468a1a136 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -68,6 +68,8 @@
 #define MXC_CPU_IMX9321		0xC6 /* dummy ID */
 #define MXC_CPU_IMX9312		0xC7 /* dummy ID */
 #define MXC_CPU_IMX9311		0xC8 /* dummy ID */
+#define MXC_CPU_IMX9302		0xC9 /* dummy ID */
+#define MXC_CPU_IMX9301		0xCA /* dummy ID */
 
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index d93e095e191..c146a223b71 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -85,7 +85,8 @@ struct bd_info;
 #define is_imx93() (is_cpu_type(MXC_CPU_IMX93) || is_cpu_type(MXC_CPU_IMX9331) || \
 	is_cpu_type(MXC_CPU_IMX9332) || is_cpu_type(MXC_CPU_IMX9351) || \
 	is_cpu_type(MXC_CPU_IMX9322) || is_cpu_type(MXC_CPU_IMX9321) || \
-	is_cpu_type(MXC_CPU_IMX9312) || is_cpu_type(MXC_CPU_IMX9311))
+	is_cpu_type(MXC_CPU_IMX9312) || is_cpu_type(MXC_CPU_IMX9311) || \
+	is_cpu_type(MXC_CPU_IMX9302) || is_cpu_type(MXC_CPU_IMX9301))
 #define is_imx9351() (is_cpu_type(MXC_CPU_IMX9351))
 #define is_imx9332() (is_cpu_type(MXC_CPU_IMX9332))
 #define is_imx9331() (is_cpu_type(MXC_CPU_IMX9331))
@@ -93,6 +94,8 @@ struct bd_info;
 #define is_imx9321() (is_cpu_type(MXC_CPU_IMX9321))
 #define is_imx9312() (is_cpu_type(MXC_CPU_IMX9312))
 #define is_imx9311() (is_cpu_type(MXC_CPU_IMX9311))
+#define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
+#define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
 #define is_imxrt1020() (is_cpu_type(MXC_CPU_IMXRT1020))
 #define is_imxrt1050() (is_cpu_type(MXC_CPU_IMXRT1050))
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index e892da80fe8..63e75b6806e 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -30,6 +30,7 @@ choice
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
+	select OF_BOARD_FIXUP
 	select IMX93
 	imply OF_UPSTREAM
 
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index e3bfc8d51c5..63647092782 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -191,6 +191,10 @@ static u32 get_cpu_variant_type(u32 type)
 	bool core1_disable = !!(val & BIT(15));
 	u32 pack_9x9_fused = BIT(4) | BIT(17) | BIT(19) | BIT(24);
 
+	/* Low performance 93 part */
+	if (((val >> 6) & 0x3F) == 0xE && npu_disable)
+		return core1_disable ? MXC_CPU_IMX9301 : MXC_CPU_IMX9302;
+
 	if ((val2 & pack_9x9_fused) == pack_9x9_fused)
 		type = MXC_CPU_IMX9322;
 
@@ -704,7 +708,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
-	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311())
+	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311() || is_imx9301())
 		disable_cpu_nodes(blob, nodes_path, 1, 2);
 
 	if (is_voltage_mode(VOLT_LOW_DRIVE))
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 60deca963a6..6c0a8c0cbe4 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -60,6 +60,10 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "93(12)";/* iMX93 9x9 Dual core without NPU */
 	case MXC_CPU_IMX9311:
 		return "93(11)";/* iMX93 9x9 Single core without NPU */
+	case MXC_CPU_IMX9302:
+		return "93(02)";/* iMX93 900Mhz Low performance Dual core without NPU */
+	case MXC_CPU_IMX9301:
+		return "93(01)";/* iMX93 900Mhz Low performance Single core without NPU */
 	default:
 		return "??";
 	}

-- 
2.35.3

