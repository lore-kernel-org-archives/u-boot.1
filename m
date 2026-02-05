Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A555E91287
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 07:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DFE683015;
	Thu,  5 Feb 2026 08:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dtG7H6T4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78288341A; Thu,  5 Feb 2026 08:27:36 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB4218063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 08:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5idLB4ZouKZNmvqVGinjx6n7MnBbHtCr7+dju5OC+kRep5WqKFx49ccsFYdUe21OHtmaGNZTcrspN9lUC7Yvnnzf2wLc1vEtN+x7Xbp+QPvbOHBQuEA8e2SHnD7HlF9YAM7w7vLeAESL7riLV/VqNgfl9BXQI+DC0bnTfYa/s92wUTO3G+D07jSaGqx5KhO7qQVZ6w5yoG2bbueCvwqmPOhgUs6rHaFFpIbg9I24gH438ZLCBOc6Zb26IJes4nBfgrf2Ux1vgh3Fb3nEnlGR7UYXUVaefaNm7gS43kfy+y5B928RYjDFYapdTLOKvp4xt/QZXGKPcYxGKLsH62emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdq+kC9/wZgu293IfxyRC6HxVFp/4iN3anbRcHL4B8A=;
 b=RjL3T+nHG90w+O2Fmk1BMK2HGxJZOmUlN7NCWHMcnFiVp9VSw5R7Lqjczq1LKK/xei7z2SZOCMgKwb94VQhG34PV5eh9v1eJry32wAi74wr6av55sSUIMegaIdXY2XmTnJSjtE96z88g/7d3om8P0DizIvUlYI9OFOEZo+TP3QxL4eG9aDeC/kxIlyCByN+dPOFjtwCrtfSXNrTI9e9VL8FPOQhQEFYBf1qMguW7OB4SDIt0rRzwtBgdFqJX8zF2TUjy7/P2EUNmwa35iQnPbEm5nQKiISMlSCRRCD2U5mWuB+97RHze+ykS1tKLoce2gYvYkmD4TcXuo3LMNe9TyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdq+kC9/wZgu293IfxyRC6HxVFp/4iN3anbRcHL4B8A=;
 b=dtG7H6T49toLYO+k9F8OPUgeZDFvLNj46bxqXOFzvTZfsriJFedmRz5WWThbNb0wIYEtYX+peMreoO+L8SyztlgsJ2SCIDww129kfrFm6oBagZ8UgwgBZKncCtapQ3ypzqKqmVtFY15u/ftHbOY1HBcXYvzGRMHCSA1bTfaZwNkrCDjt/4EMuXCICA1WAMOGsd1RL4yk3kiXU6VSteyxDxjO044uT3reu90HYEujFtRVyy9Pd8JL8ZWwdkxrIDjIN0NUEoLDqdO9zfLOj+so/2RNxeU/3o5rz+YOuuSe0mNKcAE9XCFKDtnJMsgAykWq9EbonzIF7yIlGrBOBEAyag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by MRWPR04MB12147.eurprd04.prod.outlook.com (2603:10a6:501:97::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 07:27:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 07:27:32 +0000
Date: Thu, 5 Feb 2026 15:29:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Chen Huei Lok <chen.huei.lok@altera.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>,
 drosdi <danish.ahmad.rosdi@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] drivers: fpga: Enable SOC64 support, remove
 Agilex/Stratix10 checks for FPGA bridge
Message-ID: <aYRGxjjMEMo4BCEU@shlinux89>
References: <20260205015823.11401-1-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205015823.11401-1-chen.huei.lok@altera.com>
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|MRWPR04MB12147:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5a0880-6fad-4736-a82b-08de6488052a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yovldHVuVtNhWibsl3k/dLAOOuFucPupoTrXDIIMUxPlsOa2cuzKF9ukQONv?=
 =?us-ascii?Q?nR/CMuOHtGuOfeiQ8UoPln70yWJ/94vZ52F3o1i7+t92m/BU7GcxDhQMmRc1?=
 =?us-ascii?Q?Tf5OBlmr1vOXhWwTW1Aq1I4o+nlCjcS+w/GrqrrS7kXsCqa0lpxc26jKrOEA?=
 =?us-ascii?Q?gvnDuXnr5UqTUWJY3RyioHHCWxB0UE1TMUHs5eym+ZZ4eHiU0MawZjzagogq?=
 =?us-ascii?Q?6CgThWyyPAj4eXHtxpnjzG1OpS155bn6m8lz5PbshipKB/QOdaV/2dgICiPh?=
 =?us-ascii?Q?buhcxc5h8yp71v5A8BfOyMWEsUYgguASWvzqduu2k4YIGefayWPQYHqm+HrT?=
 =?us-ascii?Q?XpATvD/sNomk0UJkRb/86I6fMJ06mhzaqIKqtRKNUSaSBl8ceJnjHt3+mtds?=
 =?us-ascii?Q?jDH6uQNzKIzNr9nLJ2nI6LBJqJU+dpb6AJdfqoDhGwQIvRU2vo0zT6swcU5W?=
 =?us-ascii?Q?A4xrGmRh13ORy/d8s0g6l9tMCJQi3akMTzh2G4lZQojGlWARJvnY4AYpiZvX?=
 =?us-ascii?Q?432mC2SUMEOFYynvmIpeTw1M1aWbNBCtSSJYW/NxK0tEz90pPla3ONrZPaye?=
 =?us-ascii?Q?qnD3Q0CE24FiwJ5P12IKO+k4fDJzhnMQGbiYbQ8ccO03oWfDEup/nHf+Mv+j?=
 =?us-ascii?Q?0ajP7aQ1IgSJfT/0SW6mFiPLwr3u/JIjpWeRGh/9TZVdvmsCD3l9VZ3tk+Wq?=
 =?us-ascii?Q?LrTX7k7JvwC7OrLDlT4MHwAfUFaHiZxMMXx4LBFKRkT5rhAXSNIBT0u3w5j8?=
 =?us-ascii?Q?BZnhynpANj/82/pyAFQKFJ5Y+qdR7H4DR3J83TqUPjKBuo0VLIun9nwouZQM?=
 =?us-ascii?Q?W8/tCstZ3bgAYPzY5jwv3eXaVRBYPNpmR5Sz+ipLO/u1Xg1DT3ADPGLs6a2O?=
 =?us-ascii?Q?7ZVLs2o9cmhYhNeJv+cVE8Q7O+siLPM5yyIJx5UZGBZzv4W/wsp6M0T3O7uq?=
 =?us-ascii?Q?ZUwywylDFudH8Mie1BOHWnIvQziVlS57TITWqehC6qCl42KAHVrNvi1CGzTu?=
 =?us-ascii?Q?ugHZ5Mw4oUJ+YaActSzB2se/0X6TUQtzmsV7oa5JCCK0c91OA246rqbZdOR6?=
 =?us-ascii?Q?/40s2JcF5PuZNF6aj2XWcjX5C2I5LlkAb436YHUgmxmK5auPTY1/RZh1BxrC?=
 =?us-ascii?Q?7SHFd1mNGEN8UbLm8SMrhrr151+BoTFI4kBSqL5FdsdEGk96o1lI7U9zPptj?=
 =?us-ascii?Q?Jp1LVdYTfY7P14BvcyBWm7wqPcv5QuWB/CkFlsYmw341TgbgxyNhuIDvu+bS?=
 =?us-ascii?Q?pHOSDAnh1rBUP5kTp1WRLq9R7nuamYT/WI/DqoJAqqGg0VsG7246aelz7umz?=
 =?us-ascii?Q?Onzx18DaB0T5q0E4X6homrxiOVOcjRwNV1fZsp0fc59Sph85U2qzsQp0BJva?=
 =?us-ascii?Q?sTiKZ+ABMh7LU5FWnlvhZn5GXK2zNet3g6V0k0l2bF/2dLTQnMVLYGx9IN3l?=
 =?us-ascii?Q?ZLdjP8F8Gk/Qvt6YWcIO874VwxEBNIz5YP7zQ6Jn9fLoVRJy/HLVjxdvnGih?=
 =?us-ascii?Q?s6QjQM3SND1AqSPMGLv3YGzwSiGN32JATy1m5xe18Wi6heved+0LX2N35BQS?=
 =?us-ascii?Q?7d/ax7dU2/aBVDn1NxuUc8RLNlayO1TS0xHm6wszJfX/wPw9C3Ymy6BoCEzM?=
 =?us-ascii?Q?hmEl8NQ+IESiDNXuouYG898=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bBmD5pQ0lvMW8mrJyGblbgYuz0p7SqAKFShvUIYwDwL3lzWKQc6MHKOZ1AlM?=
 =?us-ascii?Q?0LDc6eExk3Jt4uObTI6YxtzfLZtzKfRUC71lO1K/IsK564hg75dZUOxKbQYt?=
 =?us-ascii?Q?J/717JQqfGoJnUlvDjJWpQHMJz0pX9aAxTwpN+qGzTfyuCPsmUysxeFzibP1?=
 =?us-ascii?Q?N7NeD6RZx1zhzE2lnV/rvaY5vzWkBNceKEX8bKbemZfxYDDogATSrBb2sXnB?=
 =?us-ascii?Q?CKrvVyskFafu6lJBcT+xZiUBEjmLInLjuB0yyY17iHg+Ymi888xxs4kEFcMQ?=
 =?us-ascii?Q?SI8tKeL2McBL1tcxaXkZu7Y73TL3rK9A9rLf1grvJrnOXNjHwHkPoG4HOKL1?=
 =?us-ascii?Q?pNT9sWZbhS0XKfIlAHEOj0vMdFcXfTTO9jF4OQ89/FStZ7lVJLXG7smh5217?=
 =?us-ascii?Q?fCnC302kw1LU/TF6VwUtP7+hkNGtgK124h3x0GjWcMVf3+mOLjnwsePr1FQe?=
 =?us-ascii?Q?7psw2rQDQlvRvps40xZv7iLBhTWoyZHmnki40ysDFOcJK/4baCORqMD7+Pnn?=
 =?us-ascii?Q?hlRwRQoP9Zw87zu0V3gnzNL3zEd0pstVW/yLrLJbD0TRP2Ja5QR6kvgWq+RP?=
 =?us-ascii?Q?ZUFejpsjzBTrefvXtNAq5HMtlNGj3OqBhxUCywQAgZQPaCfjfm99JmCsKKa6?=
 =?us-ascii?Q?/cSpcEIA7YHG29ekDpwXwFwY3IUGZWc6SYG61djcZDeN/FM3JGNQkZfCpW0A?=
 =?us-ascii?Q?c3FMdk2mbgqKJhEmOU4OkZ+mcl0T5GOOIve/sNX3bZz3uq0M2gFz2G3aDsCt?=
 =?us-ascii?Q?8f3K6j6rFa7b92M2ZW6Y74dsBiXE3b4uno9TGMqTvGz/+8KiviT70JKNatP6?=
 =?us-ascii?Q?7fUlOqbqwRO1yOytEqjPTGD/RkGeAauGpz5T2ZYeuIGEL1Rl5pBd/ZLEKekH?=
 =?us-ascii?Q?mcCfiQQpHB9sYiOxWsSevv4JM6EAqSacdi1RM3arMak7wTuGW+iudgcOwCfN?=
 =?us-ascii?Q?B14T5Ve8Giay17Fcsuw8uTcfc7lugBa6VcVuOOPg19f9Btb0EkhbqYhvUy8t?=
 =?us-ascii?Q?WM2KmhHgTZimfArCeGtSoJkEEnjdqjgki8684Fli3yo+l2s4XrM62erxelvh?=
 =?us-ascii?Q?MaIMp+7NGO/QTDXj9C+/JLC3qQD5DGkebIk7PKm3EmJRSoyc5vT9sInlz88x?=
 =?us-ascii?Q?n1taUiAlucmplYzA+CHX4PmzrONCItHcYVOnbh8Swgq3Jk+iXYUELoufc9Ed?=
 =?us-ascii?Q?RL75mJnKtJf6yPAx9ZUvdch5fNYEUW5Cdjwzjl+xvBOeAjW6DfnyZGLiYS/5?=
 =?us-ascii?Q?EwLCWjYQWrlUgSq5xNPYYlNDcofyJHCbe2x8lJX7t36cFxjrdW50+nkd72FI?=
 =?us-ascii?Q?pf/95Kw+ytfvR7bWuWvTV6UboyFk2f2+qyDEv0h6Dkvdo0t8NPX46N4qU/N6?=
 =?us-ascii?Q?5hNHZ6dj0zCWlRm/RzmSsU3v/POlZHeGx0xggaBTQuiVBqX912uuaPDL+Uql?=
 =?us-ascii?Q?tVHz1CrdcOICRwsRG+zwDW/v9ejQSOd9/tKGi/Ell0Ogcfa/e5bpVJAjLKtW?=
 =?us-ascii?Q?ODPcUXFzZi+wYx2itALK5r68k6n6rsogFbGV0lcPKvBhb4D+IT869XHtD/H9?=
 =?us-ascii?Q?X0ZhSKsTSRHGeC7mHjPm9SyTZ+j3yVWucsz2WUv+kVUwQwAotTCTE1ggdHru?=
 =?us-ascii?Q?BhqWXCQW26AzD57p8fuz2j8RmZogwCAZphmMPV/6NeYJDlS12lICCq7NxLYb?=
 =?us-ascii?Q?KmfEqRbxwBdWsn29Q1V4EyBA6/yOus+pFjpZKyLy0fw7aiMhdTjtAyrBPK+o?=
 =?us-ascii?Q?Y6q8IPVL8A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5a0880-6fad-4736-a82b-08de6488052a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:27:32.8512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRHhSjn2ghCNuZEqyeFL3XN8impfKD/WzXOnWLBKYlXT/JrybHQVB6ldEDGERRet8A7YvXQ912YarxxMxj0HZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12147
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

On Thu, Feb 05, 2026 at 09:58:23AM +0800, Chen Huei Lok wrote:
>From: drosdi <danish.ahmad.rosdi@altera.com>
>
>Replace the conditional compilation checks for Agilex and Stratix10
>with a check for SOC64 in `drivers/fpga/altera.c`.

Add an explaination on why this change.

Regards
Peng
