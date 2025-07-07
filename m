Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8763FC83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 07:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B7882FE1;
	Mon,  7 Jul 2025 09:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JSmooJE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8D083015; Mon,  7 Jul 2025 09:46:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599ED82FC7
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 09:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tw293ujQmFJyhxdjyOdMgjg6CDtt2CBfuMZRsrXRcZ7wL4mArJB16NsvgJlnO3h/qEku2KjnkplNKkDxLUwDjBtM7/NGuJk+UwAziXJTMYR9qCDXth1mg1cZoRzj3liUFZVGHR7K3osnZMJgu7J0YkeD8E5Nvo1R3/g99/CPjpiX/amAP+He+l1PhfP6/hgxbIbOfbMWCcATVs9yVrGU65EoG74Q3wP7HHq9aXsAzS4Z/H3U1bWR8SI6bPhh7SmgWiAGi/LJcVcRMdd/XljT4X912DDi+UJ6FXDSlpYahzkRpg+rHYxi57O/j9bbl0USSSElAD/XERsGmRnXpUkWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpj27EFThW5OvMozvZqxtIIfA5CQTedKic33OzcWmWE=;
 b=uwbwCbxYZaXxUfZ36j7WD3yz2yaJ9MX6E9E36If6x3yG6CgsnLtw2wl/wZO4Ic9yqbP39gk0gbaIJunNPUK9rdOWZNPv0rdD82sIrXHV52KbDIsh1M3bHhCGfSJr2ZPJnHzSyrJSNugXKBIeeRkysVgqGXQiYBPHiYokQIXiiC5ovOJTZLZQqsMnkT8CLsRTtVpTy//N1+30Mb4uwMxIIK14rGHU8PL3GTBkRXVI+qezIJEKs2NIcbZfz3kMbSjZYFWUF2ElHmasIOdCSPNhQESRUeLrVKwzWgdskEUwK8RP5O10lwlBn+5ZkwzzjyAVYjgavNGRxwmPd5rEm3w/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mpj27EFThW5OvMozvZqxtIIfA5CQTedKic33OzcWmWE=;
 b=JSmooJE5HZxIK8dSgfyedjin3NcGUltb088T/va52fXwIKO8TcS5NStmlTWt49h8+1D88TNWWXNGue/sCcrjqWZHF7LKw20TNlqOFsw5G0bzgSDKhW/DCiWpPaU5rBZHGbfiKevtpj+ARVkJLTNjyit4x3/Idl+AQ7Za6cmcDoayHBL60zTWmAbZg3lmgeSEc34KOzvjt66CA0jjaIdHMSXapAZ3V64D1Y4TDaPckB5FmE5/OwZkphPnCRNvf2hpPFSUoep3gh3gW+HoWY/lmqx6h1bUSYmKkEjI2e9zKqYn14YCWijdD0hX++STDRlrd5HH5up36UMYu+2qKkEV7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 07:46:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:46:54 +0000
Date: Mon, 7 Jul 2025 16:57:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Robert Stone <rjstoneus@pm.me>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: remove -mgeneral-regs-only for truetype
Message-ID: <20250707085708.GE11488@nxa18884-linux>
References: <2a6ea8e8-788e-4eab-b06b-b553cf4f8320@pm.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6ea8e8-788e-4eab-b06b-b553cf4f8320@pm.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: 192e0bff-f27b-45cf-55e7-08ddbd2a7133
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dQ03M86NL854qDrpb/gWGjLKVHVbRUJIqgqbIyxY2RliNuap6rWyfN4k0a1J?=
 =?us-ascii?Q?UqBOY7FlYJ68N0Znk4ZtJqNnfjm1R0BgT26Qm91RHQ6e2wNQp3r7YGZ0CWE9?=
 =?us-ascii?Q?9qyjWi4T+LsNpjPNfjtweEsWsfQACrRMV4ix7qgCiY2jofE+dFYi+QMvPayI?=
 =?us-ascii?Q?Oul3VR2PijIQYhFSbeu+0cVUYuvyYa2dblwO4aeC3VyuYQyPHzlFeRnTcrpG?=
 =?us-ascii?Q?3NQcZCIuuCuWCx8OLln3c0aCbJpcV2yMyGJdA4dxxcRz4puPuSeBmVipezWT?=
 =?us-ascii?Q?cbU1oChL6AiEmNeGc2ouRqGpNFNshag+NKSdBSqRzzEGXPK6/UTM3SRiJcOC?=
 =?us-ascii?Q?MkUQ28JTotfz/ZomvdF0TKjUmjqsT5POO5ufB2FAH0F81mKCHWqXMOdUUa9N?=
 =?us-ascii?Q?i/MV4JB3s9Ouol1eY8QkdiH0QrXxbxiHrdP8MLifAdsn2pf+B+EUaV13w0sc?=
 =?us-ascii?Q?p6IL2cPo236NFHKQu/7Y3+QsAevkcK69T5/9+4wQcC0UIV0oK3WxsI49gWIF?=
 =?us-ascii?Q?DhSzRYykQPK+F/VmbOg9Ah8Kng/048h5qn91sP4ThkmABN7XsD1GZaoH/XDg?=
 =?us-ascii?Q?m170geqMnQ8QDvDM1NeExf9oZJJSyFTMvYFJ4KwiRMSgZ95KVzdJmzpK6DPL?=
 =?us-ascii?Q?Du6DGs5c2h/LQlCFtE+cBTdltXKc0CT3lSha/HNKX0yuRdDqfHFg3oXUxFcU?=
 =?us-ascii?Q?eUhCKF20VRB1P/d8Dhlf1xkMWIulUQA5+W6R01F6ginqwzfSvndR8Fx9sxIa?=
 =?us-ascii?Q?0wMMTgNOKa1dtoLca3R+RRkV4SEELAMkm3VldvQhe28lUqe1VxemIfabpOdX?=
 =?us-ascii?Q?ViAQuEBBRJRaGAYjpZn5DXyU9Gxu9opRVKrmkSTlc8UcKie8+Gq1Q9xS8nf2?=
 =?us-ascii?Q?pLZX7tWWKvj7NjA9SfPgRIcJAPzUUwesdML9L6kDTU6v0SXtnms7fA3TGon7?=
 =?us-ascii?Q?bNy03CX55vn2pyNQmWnckdr8Eh4doJpSPkpO+qofE0l9kHQjBeil1k/3raLv?=
 =?us-ascii?Q?J+QPOsGHvjYEJd91OoDqROEKGcUWMLdWRbVl7NL3begJYhj3p82bjjI/Go4+?=
 =?us-ascii?Q?7LT9ZDoBIYKekAMNCKEH47JhnFUOCc9q4JA+2fSlQlzppMRq1kbDVmZZQmyo?=
 =?us-ascii?Q?ld4naHZPfvQBK0lUCmPT4sAlDR/ggyMCGCk4TbkqEU3IxbJBZGgG1fOmb2Zl?=
 =?us-ascii?Q?n9BBz/WvQ88aY4zCTcBkUtM7caMtFSEeibNuuXeZbVfvLFlt8Qh1PZw1vvqS?=
 =?us-ascii?Q?p33WcmV9lqELqMySeGbydpyLgqslmsVA+Zv+Pu3uDAKABxa3thDZ17fLki69?=
 =?us-ascii?Q?VDj8QD+3X64/8VxEr9jVDCewHdHo6YS6sYFzNUF5QdM0xrw3afBXbxBsKaZC?=
 =?us-ascii?Q?0vi8p/lwjCc7lgJ8I9XBLvxprucUAokCT3sDwrIytPETaf2hH280lCSntH8Y?=
 =?us-ascii?Q?VNuB3wqF6o/QkD7+N4NKxwrKPMf9r3v4MY/cSJnySe5W3Vj3ihRliA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QfbrnFUMw1ByjFqUz0RBcds7I2mBqX6iY9WwlxKmnuvZMSWfEgdvAjJAK954?=
 =?us-ascii?Q?wk1ojI++1Bh4Q8bhXgIYHOzVoM9U2gG2BG0sW4pQH+HNIpvJPWYRDb8QLM5Z?=
 =?us-ascii?Q?6pB9atFGxQskLGt4paehlBDMGIvnw7yrdO1e4u78Ib+vFLs9wQ0i7ApkUYNQ?=
 =?us-ascii?Q?o3XIL7yaazxGdZ6Al0U0CbPEDIUVsbfdoqGST/H/JTLOtAVfKAqfaFLYts80?=
 =?us-ascii?Q?J/HHzysYu/z/36pRfIXXoQlGmZMLARD2FtTg1CWGGHFILD9eSpL7ww/Ym6ep?=
 =?us-ascii?Q?ZSjq/ydd8uDtpJMAb5dZ95QnOdpK1YiLoRsXX0mr+AlCvCCKaadSW0N1PUbE?=
 =?us-ascii?Q?gVFfqa9tU46qxrHxVxqPmHgIasgk/lL4LdI3hddPpKRb2E/H9czUh0gX3khf?=
 =?us-ascii?Q?nRL+KYcWk/2d/QgnEISI1uUlaqy9VDUqZHeJPh3Ilwtcvu1VdT1i9u5E7nco?=
 =?us-ascii?Q?PKf5bME8YusgI6XcOmWnK2QLcNWMXcQDaKWfP9vQ7qOHFpoLoMCcRzX2Fa7A?=
 =?us-ascii?Q?QQ6X5iGZyl76aERSL1x+epE47tQhtShidcYHyw5bTJ0UTeYQt1O9mbCAwcvr?=
 =?us-ascii?Q?7M1/YzA6zShdV6/c6ZUhu0B94aS58cUEVC4G49NjK+0/6oqgVbn70WCKKzM5?=
 =?us-ascii?Q?B8wKVGQuSOAlipiHrqBMnTeOORiyQCn1iiPBl6AAKbMmOCE7VPYpt3NquPl8?=
 =?us-ascii?Q?J8+YTno7PsIUsbRFfYCtfRzVNrieFwM+qBYz4UkTq2DXlBufZ4rtaqSlA/TQ?=
 =?us-ascii?Q?4dQbhO4JAmGg+Tt3jlipimNbFgbxc/CGhMrAW2J47KXNlnlb4+9OhXyuGzz/?=
 =?us-ascii?Q?JYWQQlgwGJ9pTnAxMmV9lFpnaDm+TIg/GVEl75cjabmU3CutaHJQwcLvTML0?=
 =?us-ascii?Q?GqmuJ9JojFE6gIXm5DXn6/vSW3WZNS97SyuTxs/sfryIjJqFpdJqtPNY6f6W?=
 =?us-ascii?Q?iw+gAoOobvVm5XtaUmt4OE7Lp7fKw+T4vw5LTGYpQXgepDEGYAdLeFodg2mP?=
 =?us-ascii?Q?2o4rrvEu7tiuDdNYIsJcdaQkh8HUNVpWRmSksNyzG3bY1S7PHr7t5YaCI50b?=
 =?us-ascii?Q?gshGE483+R21SFPwJUQ+MWy5GDw8dZJ50oySKZ/zyqK+B9+J4ViBqusPBkI6?=
 =?us-ascii?Q?fsDbW08zr67PGI0qGW9jyxW1BfsUibCO3xeR+zJy0Ci1adn04vzixv6Km9iT?=
 =?us-ascii?Q?OnDomfeNYZkZ0179OulOitUkIf4KftstZecAXyJY00Bfdkjtp4nGJvR/1h5T?=
 =?us-ascii?Q?x8fvdseZALcBXtcrVuOiuqM4sZZE9Uo7TgWUiFA16aIcH98XvvfmSoOAwhjf?=
 =?us-ascii?Q?jO6Yq33ioRKcuzVqWJc6r6v29O3712LEVI0D3ApYGX3nYoEJIeeI8x3Oq7D+?=
 =?us-ascii?Q?DE5dS/rlgp8MWNqbrbE2xFjEyTeMTGbq2Ye0ekX+RTjVZ96sjSwIMeJSHtw2?=
 =?us-ascii?Q?eWxRNC308wny9uHUtnXfmRig9vPDhxEJpki7Ogo2mp7+4J54LSlkvilr8vjv?=
 =?us-ascii?Q?hsFBSdnO+CPUKb+dem1RtGwoP6/VJLzM4x33rEbYlnNhAJryigd7u+LfhkFK?=
 =?us-ascii?Q?OYw134ecs7eNORjV1ubtgRybteNGGvsKsfl1W1B+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192e0bff-f27b-45cf-55e7-08ddbd2a7133
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:46:54.5579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4AVF9dxn4s1k4+vf16koAOMuWFGMh9WtT9/ctCPt2e0h9VVHq5jBD/xECJIU5SuGHWVL+6jYgwjP3nmzMj+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8849
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

On Sat, Jul 05, 2025 at 06:48:12PM +0000, Robert Stone wrote:
>From a364b45738c1fc2e937a8d845f419b8c5c64d751 Mon Sep 17 00:00:00 2001
>From: rjstone <rjstoneus@pm.me>
>Date: Sat, 5 Jul 2025 11:22:09 -0700
>Subject: [PATCH] drivers: remove -mgeneral-regs-only for truetype
>
>For almost everything, -mgeneral-regs-only is a good optimization, but
>console_truetype.c does using floating point, so the build will fail
>unless it is compiled without -mgeneral-regs-only.

commit f43312c974ea ARM: Prevent the compiler from using NEON registers

If drop mgeneral-regs-only, there might be issue.

Regards
Peng
