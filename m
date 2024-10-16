Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA91D206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404BB88E3A;
	Wed, 16 Oct 2024 09:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RVrVhhTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5644888E14; Wed, 16 Oct 2024 09:19:39 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5877C88E14
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdQ9mBH/J8bQWz2yQzxetFGmE/wdEBGRSHYM6Y44WDQl216zrHEjZ9TLOuMLMEsOdJPP0LOKA+jWEDFqgXKDzHCPDiAw1UU9uGla51vZOLW2WlVWkeNq+ixI7sDleApFM4vN7kmkpU/LM9ZccrUOMlIJk4Am1Xm2VQzpLHeVNIbfF8C+j5aZdbTrdifjwSIeKtF0CyLEUK+lYqw/zBO7jasS+PLTLzo6OAFy5xoMMwsfEHUDdpBEKLY0leRuDP8yhn+RlPHNRZfgyrn0gpMnyMfR6VYpfIe7ICBRVf2JI3SVO40OvPCEMoOXp7CFc+5ZvuYmoTIqNQrt5TZf6oWw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAFV6bCU5q4raiL2Er1Wgo/SEU2659D+VaxlPURxntA=;
 b=UHkmr/dZ0n009weuuEq3DcB0wOGmx4yNDQ52vapgyYaIiuRKLcfhRNwzMmv1g6ZGk+4kjtV6XhXQZ9EbjTZFnsv/htB1iMLIBNYMlEstMRK9PGeYo04WQ9RuCJWPqVuM4mrFX5c00B5f6ebo80Jxon6eJdFXjqXvdgXg7aNZklrqwygieo8Qs+GlYZiz8I9EgXmg6H+GY7tCay1pjvjW/PC2nWgzz0gD38KeoCTU1+n219p6dNn91JSP7lY0t3AFYCRJ1YT6JXAJwsY56XVyJZ9aLQB4pVwkss7u1gvaQ226EH3+XTnLz8zURgUSWgBNwFbWyoA59CJMPz4cCt1hog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAFV6bCU5q4raiL2Er1Wgo/SEU2659D+VaxlPURxntA=;
 b=RVrVhhTUvW4Woxe9pEeTnFm6iyR161LQ0KcC7imnNU8883c4yskspvoRcqiu5XKuiri12Qx8Vp14x6picPHATvu/ycYoL0wu9VtiAkb41iHmPB3WhGFOfvwoJnV9N9baTPSpnH0ZArd1Gd2gztc3nBeZun6NtImbA+wJ2ykZ8KRXLi+vSEJzEV58+Fp3LqWuaO8bjShyJhUGrsklle3nzBSy9eNNbh/MyXhYJfJ8mO2BItOdUNo2OrAUWnrDCZT8BPT0SbsCK01xUEnaOetyYTChZ+mZMYEYUbgDOe96VQ6lzgCDTV3JYnTyhEM4zrg1VtFgl/IRncedY2JVAQrrfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:19:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:32 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:02 +0800
Subject: [PATCH 09/17] imx9: scmi: add i.MX95 SoC and clock related code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-9-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fef72e2-453f-4e6d-11c9-08dcedb2e198
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0k0SytiY0VjRW9CRzAwWjNzSnJ3RHI5S0NHZmJBSWQraEdUKzdBY2syZ29G?=
 =?utf-8?B?K3NuZ0hpTWFEK1ZSUTNqNkUxYW13MGt3NWJES1F3R3JEWUhRbVh1cDllaDhs?=
 =?utf-8?B?ZGxaVjNDOUhDdkwwN3JQY2w0NnJIMzFMNXpWYmV6ekJVcUxIZnZ6clpJNFZD?=
 =?utf-8?B?RFRVek1DTHFERlg0UHFpWmJ3Q24ycFNhOXRBcFJQcGVXRlRuR0YwVDJVY2Jl?=
 =?utf-8?B?Tnc0R0dGMUJYVTM5ME9Yd0NQa2hPaFFZVWJZM015cTFYSUhHR0ordGxqbVZP?=
 =?utf-8?B?UHNPS3k2UkpUWHFPbzFtTVFqVXBWMzhsNExOQXFUZlJNZnB3TUFwbmVaM2VB?=
 =?utf-8?B?OVBIRURNZlNWc0I3WGZER2dDYStZR3hjaTYxNlJaSGcxeXlUQ29ydUczRVNi?=
 =?utf-8?B?ME84Zmx4blJLSklNVGdSdGUxbk1hcXA5QVN3aTRQcmpMaUZWM01mQUx6MnMx?=
 =?utf-8?B?M2M4d2pyM25BWXppMmVKY3lmUWZ3WmZYdytJVWNVRjBrWUZLa1lxenhSVXJo?=
 =?utf-8?B?dUcvN3dkSThxdEo3UW9VL2V4T21kRms5b2d0SGFLM2Nkc01sWnlaQ1J4Vm8y?=
 =?utf-8?B?UUEyUFQ5UnZiMHAvQTI0emtNdzNqb291dnMvNkF3ZEhVaG1WcE9FNHdHczhK?=
 =?utf-8?B?VEZhY04yTGt6cmhrQlltbGJ6aC90eklkUVBuVDVHWmhncUpIZkRBVGVLNHIy?=
 =?utf-8?B?Wm9rYXg5amt1RXMvZE50Yk9iTkdKRVdJeDA1NUphdkFpaXorVkFVQ21CekNU?=
 =?utf-8?B?MDFVSmFObDh1RFQ0aUkwQkFtMUMycDA5eExkcFk5NEpPeFBSOVplSlZPb2Fy?=
 =?utf-8?B?VmpVdlpDcjRZbWNINHJWbTBWWmNRTFFoVkh2amd6Um1peG5UWUpLbkJabWpX?=
 =?utf-8?B?L1h6dDVqZlk4UjB2UVJGR2Zlbi9nb3lBQjFSMGZjazhTbG91SXdrMndIWjRV?=
 =?utf-8?B?VUVkU25DVCtiS2t5a3ZOV1plM1A3NTgwZTN0ZFc2MS80djNPWFk3ZG05Q3Va?=
 =?utf-8?B?U2tSYXlhSHZicnc2UUczeVluR0t4enNJVlBFRWtGUjhYS2NVM21rK01iMWRP?=
 =?utf-8?B?bTZTSi9VREFyZkR6dE1tWG50UHZCZ3lJbkgrYUVUWUQ1YTNJYU5NWGFvMFY3?=
 =?utf-8?B?TFdJaTd2clN2dktMdGRrY0VNUVFWUjFFWTNNeFpkWHlSc3ZpM3M5MmhSOGh2?=
 =?utf-8?B?Y1R5SFlCbVIwRktZM0lFQjBEM0dPemliMFBQd0lrOEc5Y3M1RC81ZkJ5UWYz?=
 =?utf-8?B?c0ZqMmtZYVgrRXM4dy9yRGIram1FK28ySk5rYkQ2WDJjTjNrUjYyc3AvS2Ur?=
 =?utf-8?B?bDlNMHNUemlOVXpqMDMzbml0dXgrTkNRQ0wwbDk1OHRWNmk2VEhXSXJsWEd3?=
 =?utf-8?B?NGVVV0UvVS9abGF2TjJ1YVdLVU1BcGd5OUwxVy9nWVUrYzFoNXZkeHc1RUYz?=
 =?utf-8?B?ZWM4MXZuaExnQkd5RHNFbEk2Vmc4YVFQNEN1bHhvRkZVcnNOVzk5U0Zmekc2?=
 =?utf-8?B?bzlaNVVUajBDS2xBNnVzR2w3L093RlprdHlCNTlDWlNobEVPL2N0TkoyQ2ov?=
 =?utf-8?B?cFhLMjNGc0hUZ052VHZ6U3ZTemJPV0Y0RGwra09hR0hhcHd0Rnp2OFdGQ3No?=
 =?utf-8?B?QS81OXREbVoyQ01RR2xGbWFtUkp6YzZYTi9XMHFIaWg2WWtBQU5wWmljR29C?=
 =?utf-8?B?cVgzQnIxVDNDbmRVQWtoRERpYW5ubnhUL08yd2tKbEYvNUMyQzJsYnB5VEF3?=
 =?utf-8?B?VTRVem1uQ0UyQWc2K0hZc3poR2pidjJSRmczZXpmalM2SWErUVNnZE93SkpE?=
 =?utf-8?B?Z2h3dGVuWE55L2xEWDVrdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnMwOUUraldIWTZ6YzZQUkhpemVWQ3ZoMmRVeHp3ZHBQZ0xIZUZYcElBUElx?=
 =?utf-8?B?a1ljNzQ4MFBMand2eEw3Zk1jTDVpNWc3dkNnTjdDelRGRnQrcXVsQWI3bi9B?=
 =?utf-8?B?bStic1EwZzh0cHZnVTBuNjBneVVEU0NVSmpXMHZzbEEySVN1eVZKZnlta1k4?=
 =?utf-8?B?ZVNUeUF1WkJaQmU0UVJvL3h0a0EzL0tzYitvdGxubXFtVkQ0YTZHQng5T0FV?=
 =?utf-8?B?bDYzZ1dVWUVSYk9FWitVWTIraHNNa0E5MnNMM21SQXpsekVrVFBuSms0WFQw?=
 =?utf-8?B?V3UrM0xmcUxvSy9ZdTU4akVKNzh0TGR1WlNwU283R0o3clN1Q2tMUkR3NUhy?=
 =?utf-8?B?bUx3U1U2bHZXMk80V255Y2Q2ZWJHVm90Y3VHd2xuK0RvUnp2Q0lmdG11bC9D?=
 =?utf-8?B?RVdLUTh3WlZBaWJUcWV5c1k2OFlKZ1FYcUVTMEZVc3VpdWkrUXdBQlhnZ1ZQ?=
 =?utf-8?B?MjFvOXhiWlNqWnhZSTRyU25uZGFtaWpUR2tuNUliVi80NDhNWjV0N3Jkc0lt?=
 =?utf-8?B?eS9DUnU0Yi90cDc0NzUyYjN5eGJIQ09aN2RBVWFNcW80Wkw0SG9Ea01ZU1hx?=
 =?utf-8?B?NGdQZi80d2JFcEZ0UDdVUXZnaUpvbXkzRDVYcjFlUUFTY3JTOE5jY0VEM1Bp?=
 =?utf-8?B?SW11VnNGMnhqY1lNa085cm5vQnVzQitxYnlMcjdNcVBiUEhXRnRDazBiVzl0?=
 =?utf-8?B?cVdEQ3d6aUVKdDJJT0ZqeU1zR05OWDk1L24ydkRlM3A5K2Zub0VNejF3dWZG?=
 =?utf-8?B?TTk5M0VKbTZGRE5TV25oT1pMN0xYOVZyRHhDSGZaaG5ua2ljSnc0MmZnRnlF?=
 =?utf-8?B?a3M0dzVpZC9PYzI1K0cwejNUQ1A5b0YzeGFzRXVEcFZscVBXVnJieWV6SzFS?=
 =?utf-8?B?UzVmeGVwR1BlWnpwUkNBbC9xSVpHRmUwSG1vU1hCeXp1UGtQcE1mQUZySksv?=
 =?utf-8?B?Y2pkRGhEcE42RzlzMkhPaWNwNWJnUElvbi9pQ3NXRlZqVUlZelJTQkw2MzFH?=
 =?utf-8?B?ZUxFeU5SaEFhL21kL3FHczNpMTcvOFRKUFlWNEV5ZXpBM2ZBNVhmSkRJZU1X?=
 =?utf-8?B?UUd2R2ZiMkhkcndDMFNJejBPNWFGeU8zWk1wYTEwaDY2b3IyUVZkRG9LYTE5?=
 =?utf-8?B?MWlYNFBZQlM3clZFR1hhb3E0ZEM5dFdUa2t5OE1Jb2lDVGRBem50aUoyQUEy?=
 =?utf-8?B?dERXZVBKUHpHZ1M2aUxPTnBrVWJvSExUTGVNM1YvWTRpN1NPbXBJOG51Slcv?=
 =?utf-8?B?V0VwRHpNRVFRQ2VwelQzR3RtdjhFWGdYS0JadEwwSDc0ekdGaVlYQkRTb2R2?=
 =?utf-8?B?THJmOG90Qi94bnNkL29neGFBL0Z1Vm00ekR0UXRLcHhJVnJ6QndaTzAzL2ZT?=
 =?utf-8?B?aTlRM3BkU1N3Ris0SHdHVTJMVmhBTnhtZDh4bkkwcUY0TVcxZWh3SkxIcXI1?=
 =?utf-8?B?cXJpeWx5RUVxNU41ZVpKNkgvWERtRW9kbUNibVlUNXBpY0d5ZW5JTlluZ0hn?=
 =?utf-8?B?RVJ4WGNQa2pXUTFNWjdNOG9zSi9HOVJFVFI4b0xSdWlEeUx2Y1NidDJlbXN4?=
 =?utf-8?B?MWgwWWhpZE0zUW9GbFloQnNiRTRHOXJEMWdxMUJTRUpYY2ZUaC91L1dLQ2g4?=
 =?utf-8?B?aHBYNnA0NGdVRVlkNTZsUDEzNEIwcWdGZVcweTM1NnI1RWJJbXhsUlRjQlI0?=
 =?utf-8?B?V1MxS2puaEpvbnJOQVdqQ09pZjhDcHlwakVUWUp3NlVHN24zMVRjMlF2WDI0?=
 =?utf-8?B?OG81L3ZiWUh5eHBheFlBdno4dFQ0NHgraytDUDdBM0plQW41N1A1T1BHdC9W?=
 =?utf-8?B?WTVhV1RpNEtuVnByNWR1UXE4VlBrbGFkVDVrdmtEWExkMTcrejBvbzU4eGRX?=
 =?utf-8?B?VEs5M3l4VTBuU2VJd2VXdjdRY2NyZE5OcVBpczdKSXVmYVFqMFRlMU9qYzlm?=
 =?utf-8?B?bVFQMVFiNWZTQ0RPUEx0R0ZXMzJFOVk5WWFqeGUwRnVsa2daMW1hRXZvUUN6?=
 =?utf-8?B?b0lkN2ZDUlF3V3U4WGgzRDRkUDJ6aGlyMUZyQmZreCtac2JtRzh4R2pLRjZv?=
 =?utf-8?B?dFlJdysxTmoxckhRTEtIT09jRU5UaDE2eEtnQVljR0hYK1BkOGdBLzRqYnBw?=
 =?utf-8?Q?MVHyf6lnSe5uSFM/wlR56JDhh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fef72e2-453f-4e6d-11c9-08dcedb2e198
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:32.7765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mum9xH3sdXPV4ipCxUvrsREv5spjyWZITnuWN+sbvb0c6g7QV2u/e3i4kQfBa0uF9Gy2nbfR0nEbUAYWIrsqIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

This patch adds i.MX95 SoC and clock related code. Because they are
based on SCMI, put them in the scmi subfolder.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h        |   3 +
 arch/arm/include/asm/arch-imx9/clock.h     |  10 +-
 arch/arm/include/asm/arch-imx9/gpio.h      |   2 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |   7 +-
 arch/arm/include/asm/arch-imx9/sys_proto.h |   3 +-
 arch/arm/include/asm/mach-imx/sys_proto.h  |  40 ++
 arch/arm/mach-imx/imx9/scmi/Makefile       |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c        | 328 ++++++++++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c   | 148 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg  |   7 +
 arch/arm/mach-imx/imx9/scmi/soc.c          | 832 +++++++++++++++++++++++++++++
 11 files changed, 1382 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index b0468a1a1364e13e1a7eb211979c5d3f280e0c16..5ba67c9a1aa08115bb78467e23e96eff386d97cb 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * (C) Copyright 2014 Freescale Semiconductor, Inc.
+ * Copyright 2024 NXP
  */
 
 #define MXC_CPU_MX23		0x23
@@ -71,6 +72,8 @@
 #define MXC_CPU_IMX9302		0xC9 /* dummy ID */
 #define MXC_CPU_IMX9301		0xCA /* dummy ID */
 
+#define MXC_CPU_IMX95		0x1C1 /* dummy ID */
+
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
 #define MXC_SOC_IMX8M		0x80
diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 76f12118592cd0a83cbcaa57f8d582847ffd68f3..cb8e5a724b0e287c15687019da5721069f2bb253 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022 NXP
+ * Copyright 2024 NXP
  *
- * Peng Fan <peng.fan at nxp.com>
+ * Peng Fan <peng.fan@nxp.com>
  */
 
 #ifndef __CLOCK_IMX9__
@@ -248,5 +248,11 @@ int ccm_shared_gpr_tz_access(u32 gpr, bool non_secure, bool user_mode, bool lock
 void enable_usboh3_clk(unsigned char enable);
 int set_clk_enet(enum enet_freq type);
 int set_clk_eqos(enum enet_freq type);
+int set_clk_netc(enum enet_freq type);
 void set_arm_clk(ulong freq);
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable);
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate);
+ulong imx_clk_scmi_get_rate(u32 clock_id);
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id);
 #endif
diff --git a/arch/arm/include/asm/arch-imx9/gpio.h b/arch/arm/include/asm/arch-imx9/gpio.h
index 40732022e7e56e9e460350a97a50b47bb2e98fa0..1917a121aa05140a677a6225195117c8e0c182e2 100644
--- a/arch/arm/include/asm/arch-imx9/gpio.h
+++ b/arch/arm/include/asm/arch-imx9/gpio.h
@@ -6,6 +6,8 @@
 #ifndef __ASM_ARCH_IMX9_GPIO_H
 #define __ASM_ARCH_IMX9_GPIO_H
 
+#include <asm/types.h>
+
 struct gpio_regs {
 	u32 gpio_pdor;
 	u32 gpio_psor;
diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index ef9538bd42e8b2972d7e6829a402bc4f661e3cbb..5512d66ee0a44348845d2a559bd99327115bc1d0 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022 NXP
+ * Copyright 2024 NXP
  */
 
 #ifndef __ASM_ARCH_IMX9_REGS_H__
@@ -20,6 +20,11 @@
 #define WDG4_BASE_ADDR      0x424a0000UL
 #define WDG5_BASE_ADDR      0x424b0000UL
 
+#define GPIO2_BASE_ADDR	    0x43810000UL
+#define GPIO3_BASE_ADDR	    0x43820000UL
+#define GPIO4_BASE_ADDR	    0x43840000UL
+#define GPIO5_BASE_ADDR	    0x43850000UL
+
 #define FSB_BASE_ADDR       0x47510000UL
 
 #define ANATOP_BASE_ADDR    0x44480000UL
diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index e4bf6a63424f7c54c1dcdf6b882a908940e5fdb1..aac43c74a44a127549c67059e70f570aae5f680c 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2022 NXP
+ * Copyright (C) 2024 NXP
  */
 
 #ifndef __ARCH_IMX9_SYS_PROTO_H
@@ -12,6 +12,7 @@ enum imx9_soc_voltage_mode {
 	VOLT_LOW_DRIVE = 0,
 	VOLT_NOMINAL_DRIVE,
 	VOLT_OVER_DRIVE,
+	VOLT_SUPER_OVER_DRIVE,
 };
 
 void soc_power_init(void);
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 31ace977d2bd9264fd0f0a43e0c79e18d5a65673..878a4821996392e36d9bb02613276e502f463eef 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -2,6 +2,7 @@
 /*
  * (C) Copyright 2009
  * Stefano Babic, DENX Software Engineering, sbabic@denx.de.
+ * Copyright 2024 NXP
  */
 
 #ifndef _SYS_PROTO_H_
@@ -97,6 +98,8 @@ struct bd_info;
 #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
 #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
+#define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
+
 #define is_imxrt1020() (is_cpu_type(MXC_CPU_IMXRT1020))
 #define is_imxrt1050() (is_cpu_type(MXC_CPU_IMXRT1050))
 
@@ -210,6 +213,43 @@ ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev);
 u32 rom_api_download_image(u8 *dest, u32 offset, u32 size);
 u32 rom_api_query_boot_infor(u32 info_type, u32 *info);
 
+#ifdef CONFIG_SCMI_FIRMWARE
+typedef struct rom_passover {
+	uint16_t tag;                   //!< Tag
+	uint8_t  len;                   //!< Fixed value of 0x80
+	uint8_t  ver;                   //!< Version
+	uint32_t boot_mode;             //!< Boot mode
+	uint32_t card_addr_mode;        //!< SD card address mode
+	uint32_t bad_blks_of_img_set0;  //!< NAND bad block count skipped 1
+	uint32_t ap_mu_id;              //!< AP MU ID
+	uint32_t bad_blks_of_img_set1;  //!< NAND bad block count skipped 1
+	uint8_t  boot_stage;            //!< Boot stage
+	uint8_t  img_set_sel;           //!< Image set booted from
+	uint8_t  rsv0[2];               //!< Reserved
+	uint32_t img_set_end;           //!< Offset of Image End
+	uint32_t rom_version;           //!< ROM version
+	uint8_t  boot_dev_state;        //!< Boot device state
+	uint8_t  boot_dev_inst;         //!< Boot device type
+	uint8_t  boot_dev_type;         //!< Boot device instance
+	uint8_t  rsv1;                  //!< Reserved
+	uint32_t dev_page_size;         //!< Boot device page size
+	uint32_t cnt_header_ofs;        //!< Container header offset
+	uint32_t img_ofs;               //!< Image offset
+}  __attribute__ ((packed)) rom_passover_t;
+
+/**
+ * struct scmi_rom_passover_out - Response payload for ROM_PASSOVER_GET command
+ * @status:	SCMI clock ID
+ * @attributes:	Attributes of the targets clock state
+ */
+struct scmi_rom_passover_get_out {
+	u32 status;
+	u32 numPassover;
+	u32 passover[(sizeof(rom_passover_t) + 8) / 4];
+};
+
+#endif
+
 /* For i.MX ULP */
 #define BT0CFG_LPBOOT_MASK	0x1
 #define BT0CFG_DUALBOOT_MASK	0x2
diff --git a/arch/arm/mach-imx/imx9/scmi/Makefile b/arch/arm/mach-imx/imx9/scmi/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..78f24c6e5151e2d7280b9c456c0477a3b6a958c4
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 NXP
+
+obj-y += soc.o
+obj-y += clock_scmi.o clock.o
diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
new file mode 100644
index 0000000000000000000000000000000000000000..b46ff3f9944d2b08db56f7ef892fba715afd2655
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/clock.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <asm/arch/ccm_regs.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <command.h>
+#include <errno.h>
+#ifdef CONFIG_CLK_SCMI
+#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include <dm/uclass.h>
+#include <dm/uclass-internal.h>
+#include <linux/clk-provider.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+u32 get_arm_core_clk(void)
+{
+	u32 val;
+
+	/* TODO: */
+	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
+	if (val)
+		return val;
+	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
+}
+
+void set_arm_core_max_clk(void)
+{
+	int ret;
+	u32 arm_domain_id = 8;
+
+	struct scmi_perf_in in = {
+		.domain_id = arm_domain_id,
+		.perf_level = 3,
+	};
+	struct scmi_perf_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PERF, SCMI_PERF_LEVEL_SET, in, out);
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		printf("%s: %d\n", __func__, ret);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		printf("%s: %d\n", __func__, ret);
+}
+
+void enable_usboh3_clk(unsigned char enable)
+{
+}
+
+int clock_init_early(void)
+{
+	return 0;
+}
+
+/* Set bus and A55 core clock per voltage mode */
+int clock_init_late(void)
+{
+	set_arm_core_max_clk();
+
+	return 0;
+}
+
+u32 get_lpuart_clk(void)
+{
+	return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
+}
+
+void init_uart_clk(u32 index)
+{
+	u32 clock_id;
+
+	switch (index) {
+	case 0:
+		clock_id = IMX95_CLK_LPUART1;
+		break;
+	case 1:
+		clock_id = IMX95_CLK_LPUART2;
+		break;
+	case 2:
+		clock_id = IMX95_CLK_LPUART3;
+		break;
+	default:
+		return;
+	}
+
+	/* 24MHz */
+	imx_clk_scmi_enable(clock_id, false);
+	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
+	imx_clk_scmi_set_rate(clock_id, 24000000);
+	imx_clk_scmi_enable(clock_id, true);
+}
+
+/* I2C check */
+u32 imx_get_i2cclk(u32 i2c_num)
+{
+	if (i2c_num > 7)
+		return -EINVAL;
+	switch (i2c_num) {
+	case 0:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C1);
+	case 1:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C2);
+	case 2:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C3);
+	case 3:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C4);
+	case 4:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C5);
+	case 5:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C6);
+	case 6:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C7);
+	case 7:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C8);
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+int enable_i2c_clk(unsigned char enable, u32 i2c_num)
+{
+	u32 clock_id;
+
+	if (i2c_num > 7)
+		return -EINVAL;
+
+	switch (i2c_num) {
+	case 0:
+		clock_id = IMX95_CLK_LPI2C1;
+		break;
+	case 1:
+		clock_id = IMX95_CLK_LPI2C2;
+		break;
+	case 2:
+		clock_id = IMX95_CLK_LPI2C3;
+		break;
+	case 3:
+		clock_id = IMX95_CLK_LPI2C4;
+		break;
+	case 4:
+		clock_id = IMX95_CLK_LPI2C5;
+		break;
+	case 5:
+		clock_id = IMX95_CLK_LPI2C6;
+		break;
+	case 6:
+		clock_id = IMX95_CLK_LPI2C7;
+		break;
+	case 7:
+		clock_id = IMX95_CLK_LPI2C8;
+		break;
+	default:
+		return 0;
+	}
+
+	/* 24MHz */
+	imx_clk_scmi_enable(clock_id, false);
+	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
+	imx_clk_scmi_set_rate(clock_id, 24000000);
+	imx_clk_scmi_enable(clock_id, true);
+
+	return 0;
+}
+
+/* dfs_clkout[1]: 800.00MHz */
+void init_clk_usdhc(u32 usdhc_id)
+{
+	u32 clock_id;
+
+	switch (usdhc_id) {
+	case 0:
+		clock_id = IMX95_CLK_USDHC1;
+		break;
+	case 1:
+		clock_id = IMX95_CLK_USDHC2;
+		break;
+	case 2:
+		clock_id = IMX95_CLK_USDHC3;
+		break;
+	default:
+		return;
+	};
+
+	/* 400MHz */
+	imx_clk_scmi_enable(clock_id, false);
+	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_SYSPLL1_PFD1);
+	imx_clk_scmi_set_rate(clock_id, 400000000);
+	imx_clk_scmi_enable(clock_id, true);
+}
+
+int set_clk_netc(enum enet_freq type)
+{
+	ulong rate;
+
+	switch (type) {
+	case ENET_125MHZ:
+		rate = MHZ(250); /* 250Mhz */
+		break;
+	case ENET_50MHZ:
+		rate = MHZ(100); /* 100Mhz */
+		break;
+	case ENET_25MHZ:
+		rate = MHZ(50); /* 50Mhz */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* disable the clock first */
+	imx_clk_scmi_enable(IMX95_CLK_ENETREF, false);
+	imx_clk_scmi_set_parent(IMX95_CLK_ENETREF, IMX95_CLK_SYSPLL1_PFD0);
+	imx_clk_scmi_set_rate(IMX95_CLK_ENETREF, rate);
+	imx_clk_scmi_enable(IMX95_CLK_ENETREF, true);
+
+	return 0;
+}
+
+#ifdef CONFIG_SPL_BUILD
+void dram_pll_init(ulong pll_val)
+{
+	/* Try to configure the DDR PLL. */
+	u64 ddr_rate = pll_val;
+	/*vco_range 2.5G - 5G */
+	u64 vco_rate = ddr_rate * DIV_ROUND_UP(MHZ(3000), ddr_rate);
+	u64 v_rate, rate;
+
+	v_rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMPLL_VCO, vco_rate);
+	rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMPLL, ddr_rate);
+
+	debug("%s vco:%llu rate:%llu\n", __func__, v_rate, rate);
+}
+
+void dram_enable_bypass(ulong clk_val)
+{
+	u64 rate;
+
+	switch (clk_val) {
+	case MHZ(625):
+		imx_clk_scmi_set_parent(IMX95_CLK_DRAMALT, IMX95_CLK_SYSPLL1_PFD2);
+		rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMALT, clk_val);
+		break;
+	case MHZ(400):
+		imx_clk_scmi_set_parent(IMX95_CLK_DRAMALT, IMX95_CLK_SYSPLL1_PFD1);
+		rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMALT, clk_val);
+		break;
+	case MHZ(333):
+		imx_clk_scmi_set_parent(IMX95_CLK_DRAMALT, IMX95_CLK_SYSPLL1_PFD0);
+		rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMALT, 333333333);
+		break;
+	case MHZ(200):
+		imx_clk_scmi_set_parent(IMX95_CLK_DRAMALT, IMX95_CLK_SYSPLL1_PFD1);
+		rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMALT, clk_val);
+		break;
+	case MHZ(100):
+		imx_clk_scmi_set_parent(IMX95_CLK_DRAMALT, IMX95_CLK_SYSPLL1_PFD1);
+		rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMALT, clk_val);
+		break;
+	default:
+		printf("No matched freq table %lu\n", clk_val);
+		return;
+	}
+
+	debug("%s:%llu\n", __func__, rate);
+
+	/* Set DRAM APB to 133Mhz */
+	imx_clk_scmi_set_parent(IMX95_CLK_DRAMAPB, IMX95_CLK_SYSPLL1_PFD1_DIV2);
+	rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMAPB, 133333333);
+
+	/* Switch from DRAM clock root from PLL to CCM */
+	imx_clk_scmi_set_parent(IMX95_CLK_SEL_DRAM, IMX95_CLK_DRAMALT);
+}
+
+void dram_disable_bypass(void)
+{
+	u64 rate;
+	/* Set DRAM APB to 133Mhz */
+	imx_clk_scmi_set_parent(IMX95_CLK_DRAMAPB, IMX95_CLK_SYSPLL1_PFD1_DIV2);
+	rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMAPB, 133333333);
+
+	/*Set the DRAM_GPR_SEL to be sourced from DRAM_PLL.*/
+	imx_clk_scmi_set_parent(IMX95_CLK_SEL_DRAM, IMX95_CLK_DRAMPLL);
+	rate = imx_clk_scmi_get_rate(IMX95_CLK_SEL_DRAM);
+	printf("%s:SEL_DRAM: %llu\n", __func__, rate);
+}
+
+#endif
+
+unsigned int mxc_get_clock(enum mxc_clock clk)
+{
+	switch (clk) {
+	case MXC_ARM_CLK:
+		return get_arm_core_clk();
+	case MXC_IPG_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
+	case MXC_CSPI_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
+	case MXC_ESDHC_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
+	case MXC_ESDHC2_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
+	case MXC_ESDHC3_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
+	case MXC_UART_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
+	case MXC_FLEXSPI_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
+	default:
+		return -1;
+	};
+
+	return -1;
+};
diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..543abe9fed481c796602b2b2eeeec6c8f9a94862
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <command.h>
+#include <errno.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/ccm_regs.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <asm/global_data.h>
+#include <dm/uclass.h>
+#include <dm/uclass-internal.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include <linux/clk-provider.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable)
+{
+	struct scmi_clk_state_in in = {
+		.clock_id = clock_id,
+		.attributes = (enable) ? 1 : 0,
+	};
+	struct scmi_clk_state_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_CONFIG_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate)
+{
+	struct scmi_clk_rate_set_in in = {
+		.clock_id = clock_id,
+		.flags = SCMI_CLK_RATE_ROUND_CLOSEST,
+		.rate_lsb = (u32)rate,
+		.rate_msb = (u32)((u64)rate >> 32),
+	};
+	struct scmi_clk_rate_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_RATE_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0)
+		return ret;
+
+	struct scmi_clk_rate_get_in in_rate = {
+		.clock_id = clock_id,
+	};
+	struct scmi_clk_rate_get_out out_rate;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK, SCMI_CLOCK_RATE_GET, in_rate, out_rate);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out_rate.status);
+	if (ret < 0)
+		return ret;
+
+	return (ulong)(((u64)out_rate.rate_msb << 32) | out_rate.rate_lsb);
+}
+
+ulong imx_clk_scmi_get_rate(u32 clock_id)
+{
+	struct scmi_clk_rate_get_in in = {
+		.clock_id = clock_id,
+	};
+	struct scmi_clk_rate_get_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_RATE_GET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0)
+		return ret;
+
+	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
+}
+
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clock_id,
+		.parent_clk = parent_id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0 && ret != -EACCES)
+		printf("%s: %d, clock_id %u\n", __func__, ret, clock_id);
+
+	return ret;
+}
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
new file mode 100644
index 0000000000000000000000000000000000000000..464d43f85d97153de35d6d8f0e5a544c26fa8ab5
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+/* Empty, so not generate flash.bin in u-boot */
+/* TODO, i.MX95 binman is under developing, after done, bring back to let U-Boot generate flash.bin */
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
new file mode 100644
index 0000000000000000000000000000000000000000..fefb1a6f4ca58722a5d93c39e4f6a7aaf85aa177
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -0,0 +1,832 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <cpu_func.h>
+#include <init.h>
+#include <log.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/ccm_regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/arch/trdc.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/syscounter.h>
+#include <asm/armv8/mmu.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <env.h>
+#include <env_internal.h>
+#include <errno.h>
+#include <fdt_support.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <asm/setup.h>
+#include <asm/bootm.h>
+#include <asm/arch-imx/cpu.h>
+#include <asm/mach-imx/ele_api.h>
+#include <linux/delay.h>
+#include <fuse.h>
+#include <imx_thermal.h>
+#include <thermal.h>
+#include <imx_sip.h>
+#include <linux/arm-smccc.h>
+#include <asm/arch/ddr.h>
+#ifdef CONFIG_SCMI_FIRMWARE
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+rom_passover_t rom_passover_data = {0};
+
+uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
+{
+	/* Read ROM passover data */
+	struct scmi_rom_passover_get_out out;
+	struct scmi_msg msg = SCMI_MSG(SCMI_PROTOCOL_ID_IMX_MISC, SCMI_MISC_ROM_PASSOVER_GET, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret == 0 && out.status == 0) {
+		memcpy(rom_data, (struct rom_passover_t *)out.passover, sizeof(rom_passover_t));
+	} else {
+		printf("Failed to get ROM passover data, scmi_err = %d, size_of(out) = %ld\n",
+		       out.status, sizeof(out));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_ENV_IS_IN_MMC
+__weak int board_mmc_get_env_dev(int devno)
+{
+	return devno;
+}
+
+int mmc_get_env_dev(void)
+{
+	int ret;
+	u16 boot_type;
+	u8 boot_instance;
+
+	volatile gd_t *pgd = gd;
+	rom_passover_t *rdata;
+#ifdef CONFIG_SPL_BUILD
+	rdata = &rom_passover_data;
+#else
+	rom_passover_t rom_data = {0};
+
+	if (!pgd->reloc_off)
+		rdata = &rom_data;
+	else
+		rdata = &rom_passover_data;
+#endif
+	if (rdata->tag == 0) {
+		ret = scmi_get_rom_data(rdata);
+		if (ret != 0) {
+			puts("SCMI: failure at rom_boot_info\n");
+			return CONFIG_SYS_MMC_ENV_DEV;
+		}
+	}
+	boot_type = rdata->boot_dev_type;
+	boot_instance = rdata->boot_dev_inst;
+	set_gd(pgd);
+
+	debug("boot_type %d, instance %d\n", boot_type, boot_instance);
+
+	/* If not boot from sd/mmc, use default value */
+	if (boot_type != BOOT_TYPE_SD && boot_type != BOOT_TYPE_MMC)
+		return env_get_ulong("mmcdev", 10, CONFIG_SYS_MMC_ENV_DEV);
+
+	return board_mmc_get_env_dev(boot_instance);
+}
+#endif
+
+u32 get_cpu_speed_grade_hz(void)
+{
+	u32 speed, max_speed;
+	int ret;
+	u32 val, word, offset;
+
+	word = 17;
+	offset = 14;
+
+	ret = fuse_read((word / 8), (word % 8), &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	val >>= offset;
+	val &= 0xf;
+
+	max_speed = 2300000000;
+	speed = max_speed - val * 100000000;
+
+	if (is_imx95())
+		max_speed = 2000000000;
+
+	/* In case the fuse of speed grade not programmed */
+	if (speed > max_speed)
+		speed = max_speed;
+
+	return speed;
+}
+
+u32 get_cpu_temp_grade(int *minc, int *maxc)
+{
+	int ret;
+	u32 val, word, offset;
+
+	word = 17;
+	offset = 12;
+
+	ret = fuse_read((word / 8), (word % 8), &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	val >>= offset;
+	val &= 0x3;
+
+	if (minc && maxc) {
+		if (val == TEMP_AUTOMOTIVE) {
+			*minc = -40;
+			*maxc = 125;
+		} else if (val == TEMP_INDUSTRIAL) {
+			*minc = -40;
+			*maxc = 105;
+		} else if (val == TEMP_EXTCOMMERCIAL) {
+			*minc = -20;
+			*maxc = 105;
+		} else {
+			*minc = 0;
+			*maxc = 95;
+		}
+	}
+	return val;
+}
+
+static void set_cpu_info(struct ele_get_info_data *info)
+{
+	gd->arch.soc_rev = info->soc;
+	gd->arch.lifecycle = info->lc;
+	memcpy((void *)&gd->arch.uid, &info->uid, 4 * sizeof(u32));
+}
+
+u32 get_cpu_rev(void)
+{
+	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
+
+	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
+}
+
+#define UNLOCK_WORD 0xD928C520 /* unlock word */
+#define REFRESH_WORD 0xB480A602 /* refresh word */
+
+static void disable_wdog(void __iomem *wdog_base)
+{
+	u32 val_cs = readl(wdog_base + 0x00);
+
+	if (!(val_cs & 0x80))
+		return;
+
+	/* default is 32bits cmd */
+	writel(REFRESH_WORD, (wdog_base + 0x04)); /* Refresh the CNT */
+
+	if (!(val_cs & 0x800)) {
+		writel(UNLOCK_WORD, (wdog_base + 0x04));
+		while (!(readl(wdog_base + 0x00) & 0x800))
+			;
+	}
+	writel(0x0, (wdog_base + 0x0C)); /* Set WIN to 0 */
+	writel(0x400, (wdog_base + 0x08)); /* Set timeout to default 0x400 */
+	writel(0x2120, (wdog_base + 0x00)); /* Disable it and set update */
+
+	while (!(readl(wdog_base + 0x00) & 0x400))
+		;
+}
+
+static struct mm_region imx9_mem_map[] = {
+	{
+		/* ROM */
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = 0x100000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		/* TCM */
+		.virt = 0x201c0000UL,
+		.phys = 0x201c0000UL,
+		.size = 0x80000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* OCRAM */
+		.virt = 0x20480000UL,
+		.phys = 0x20480000UL,
+		.size = 0xA0000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		/* AIPS */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* Flexible Serial Peripheral Interface */
+		.virt = 0x28000000UL,
+		.phys = 0x28000000UL,
+		.size = 0x8000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* DRAM1 */
+		.virt = PHYS_SDRAM,
+		.phys = PHYS_SDRAM,
+		.size = PHYS_SDRAM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				 PTE_BLOCK_OUTER_SHARE
+	}, {
+#ifdef PHYS_SDRAM_2_SIZE
+		/* DRAM2 */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = PHYS_SDRAM_2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+#endif
+		/* empty entry to split table entry 5 if needed when TEEs are used */
+		0,
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = imx9_mem_map;
+
+static unsigned int imx9_find_dram_entry_in_mem_map(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx9_mem_map); i++)
+		if (imx9_mem_map[i].phys == CFG_SYS_SDRAM_BASE)
+			return i;
+
+	hang();	/* Entry not found, this must never happen. */
+}
+
+void enable_caches(void)
+{
+	/* If OPTEE runs, remove OPTEE memory from MMU table to avoid speculative prefetch
+	 * If OPTEE does not run, still update the MMU table according to dram banks structure
+	 * to set correct dram size from board_phys_sdram_size
+	 */
+	int i = 0;
+	/*
+	 * please make sure that entry initial value matches
+	 * imx9_mem_map for DRAM1
+	 */
+	int entry = imx9_find_dram_entry_in_mem_map();
+	u64 attrs = imx9_mem_map[entry].attrs;
+
+	while (i < CONFIG_NR_DRAM_BANKS &&
+	       entry < ARRAY_SIZE(imx9_mem_map)) {
+		if (gd->bd->bi_dram[i].start == 0)
+			break;
+		imx9_mem_map[entry].phys = gd->bd->bi_dram[i].start;
+		imx9_mem_map[entry].virt = gd->bd->bi_dram[i].start;
+		imx9_mem_map[entry].size = gd->bd->bi_dram[i].size;
+		imx9_mem_map[entry].attrs = attrs;
+		debug("Added memory mapping (%d): %llx %llx\n", entry,
+		      imx9_mem_map[entry].phys, imx9_mem_map[entry].size);
+		i++; entry++;
+	}
+
+	icache_enable();
+	dcache_enable();
+}
+
+__weak int board_phys_sdram_size(phys_size_t *size)
+{
+	phys_size_t start, end;
+	phys_size_t val;
+
+	if (!size)
+		return -EINVAL;
+
+	val = readl(REG_DDR_CS0_BNDS);
+	start = (val >> 16) << 24;
+	end   = (val & 0xFFFF);
+	end   = end ? end + 1 : 0;
+	end   = end << 24;
+	*size = end - start;
+
+	val = readl(REG_DDR_CS1_BNDS);
+	start = (val >> 16) << 24;
+	end   = (val & 0xFFFF);
+	end   = end ? end + 1 : 0;
+	end   = end << 24;
+	*size += end - start;
+
+	return 0;
+}
+
+int dram_init(void)
+{
+	phys_size_t sdram_size;
+	int ret;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return ret;
+
+	/* rom_pointer[1] contains the size of TEE occupies */
+	if (rom_pointer[1])
+		gd->ram_size = sdram_size - rom_pointer[1];
+	else
+		gd->ram_size = sdram_size;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	int bank = 0;
+	int ret;
+	phys_size_t sdram_size;
+	phys_size_t sdram_b1_size, sdram_b2_size;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return ret;
+
+	/* Bank 1 can't cross over 4GB space */
+	if (sdram_size > 0x80000000) {
+		sdram_b1_size = 0x100000000UL - PHYS_SDRAM;
+		sdram_b2_size = sdram_size - sdram_b1_size;
+	} else {
+		sdram_b1_size = sdram_size;
+		sdram_b2_size = 0;
+	}
+
+	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
+	if (rom_pointer[1]) {
+		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
+		phys_size_t optee_size = (size_t)rom_pointer[1];
+
+		gd->bd->bi_dram[bank].size = optee_start - gd->bd->bi_dram[bank].start;
+		if ((optee_start + optee_size) < (PHYS_SDRAM + sdram_b1_size)) {
+			if (++bank >= CONFIG_NR_DRAM_BANKS) {
+				puts("CONFIG_NR_DRAM_BANKS is not enough\n");
+				return -1;
+			}
+
+			gd->bd->bi_dram[bank].start = optee_start + optee_size;
+			gd->bd->bi_dram[bank].size = PHYS_SDRAM +
+				sdram_b1_size - gd->bd->bi_dram[bank].start;
+		}
+	} else {
+		gd->bd->bi_dram[bank].size = sdram_b1_size;
+	}
+
+	if (sdram_b2_size) {
+		if (++bank >= CONFIG_NR_DRAM_BANKS) {
+			puts("CONFIG_NR_DRAM_BANKS is not enough for SDRAM_2\n");
+			return -1;
+		}
+		gd->bd->bi_dram[bank].start = 0x100000000UL;
+		gd->bd->bi_dram[bank].size = sdram_b2_size;
+	}
+
+	return 0;
+}
+
+phys_size_t get_effective_memsize(void)
+{
+	int ret;
+	phys_size_t sdram_size;
+	phys_size_t sdram_b1_size;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (!ret) {
+		/* Bank 1 can't cross over 4GB space */
+		if (sdram_size > 0x80000000) {
+			sdram_b1_size = 0x100000000UL - PHYS_SDRAM;
+		} else {
+			sdram_b1_size = sdram_size;
+		}
+
+		if (rom_pointer[1]) {
+			/* We will relocate u-boot to Top of dram1. Tee position has two cases:
+			 * 1. At the top of dram1,  Then return the size removed optee size.
+			 * 2. In the middle of dram1, return the size of dram1.
+			 */
+			if ((rom_pointer[0] + rom_pointer[1]) == (PHYS_SDRAM + sdram_b1_size))
+				return ((phys_addr_t)rom_pointer[0] - PHYS_SDRAM);
+		}
+
+		return sdram_b1_size;
+	} else {
+		return PHYS_SDRAM_SIZE;
+	}
+}
+
+void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
+{
+	u32 val[2] = {};
+	int ret;
+
+	if (dev_id == 0) {
+		ret = fuse_read(39, 3, &val[0]);
+		if (ret)
+			goto err;
+
+		ret = fuse_read(39, 4, &val[1]);
+		if (ret)
+			goto err;
+
+		mac[0] = val[1] >> 8;
+		mac[1] = val[1];
+		mac[2] = val[0] >> 24;
+		mac[3] = val[0] >> 16;
+		mac[4] = val[0] >> 8;
+		mac[5] = val[0];
+
+	} else {
+		ret = fuse_read(39, 5, &val[0]);
+		if (ret)
+			goto err;
+
+		ret = fuse_read(39, 4, &val[1]);
+		if (ret)
+			goto err;
+
+		if (is_soc_rev(CHIP_REV_1_0)) {
+			mac[0] = val[1] >> 24;
+			mac[1] = val[1] >> 16;
+			mac[2] = val[0] >> 24;
+			mac[3] = val[0] >> 16;
+			mac[4] = val[0] >> 8;
+			mac[5] = val[0];
+		} else {
+			mac[0] = val[0] >> 24;
+			mac[1] = val[0] >> 16;
+			mac[2] = val[0] >> 8;
+			mac[3] = val[0];
+			mac[4] = val[1] >> 24;
+			mac[5] = val[1] >> 16;
+		}
+	}
+
+	debug("%s: MAC%d: %02x.%02x.%02x.%02x.%02x.%02x\n",
+	      __func__, dev_id, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+	return;
+err:
+	memset(mac, 0, 6);
+	printf("%s: fuse read err: %d\n", __func__, ret);
+}
+
+const char *get_imx_type(u32 imxtype)
+{
+	switch (imxtype) {
+	case MXC_CPU_IMX95:
+		return "95";/* iMX95 FULL */
+	default:
+		return "??";
+	}
+}
+
+int print_cpuinfo(void)
+{
+	u32 cpurev, max_freq;
+	int minc, maxc;
+
+	cpurev = get_cpu_rev();
+
+	printf("CPU:   i.MX%s rev%d.%d",
+		get_imx_type((cpurev & 0x1FF000) >> 12),
+		(cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0);
+
+	max_freq = get_cpu_speed_grade_hz();
+	if (!max_freq || max_freq == mxc_get_clock(MXC_ARM_CLK)) {
+		printf(" at %dMHz\n", mxc_get_clock(MXC_ARM_CLK) / 1000000);
+	} else {
+		printf(" %d MHz (running at %d MHz)\n", max_freq / 1000000,
+		       mxc_get_clock(MXC_ARM_CLK) / 1000000);
+	}
+
+	puts("CPU:   ");
+	switch (get_cpu_temp_grade(&minc, &maxc)) {
+	case TEMP_AUTOMOTIVE:
+		puts("Automotive temperature grade ");
+		break;
+	case TEMP_INDUSTRIAL:
+		puts("Industrial temperature grade ");
+		break;
+	case TEMP_EXTCOMMERCIAL:
+		if (is_imx93())
+			puts("Extended Industrial temperature grade ");
+		else
+			puts("Extended Consumer temperature grade ");
+		break;
+	default:
+		puts("Consumer temperature grade ");
+		break;
+	}
+	printf("(%dC to %dC)", minc, maxc);
+
+#if defined(CONFIG_DM_THERMAL)
+	struct udevice *udev;
+	int ret, temp;
+
+	if (IS_ENABLED(CONFIG_IMX_TMU))
+		ret = uclass_get_device_by_name(UCLASS_THERMAL, "cpu-thermal", &udev);
+	else
+		ret = uclass_get_device(UCLASS_THERMAL, 0, &udev);
+	if (!ret) {
+		ret = thermal_get_temp(udev, &temp);
+
+		if (!ret)
+			printf(" at %dC", temp);
+		else
+			debug(" - invalid sensor data\n");
+	} else {
+		debug(" - invalid sensor device\n");
+	}
+#endif
+	puts("\n");
+
+	return 0;
+}
+
+void build_info(void)
+{
+	u32 fw_version, sha1, res, status;
+	int ret;
+
+	printf("\nBuildInfo:\n");
+
+	ret = ele_get_fw_status(&status, &res);
+	if (ret) {
+		printf("  - ELE firmware status failed %d, 0x%x\n", ret, res);
+	} else if ((status & 0xff) == 1) {
+		ret = ele_get_fw_version(&fw_version, &sha1, &res);
+		if (ret) {
+			printf("  - ELE firmware version failed %d, 0x%x\n", ret, res);
+		} else {
+			printf("  - ELE firmware version %u.%u.%u-%x",
+			       (fw_version & (0x00ff0000)) >> 16,
+			       (fw_version & (0x0000ff00)) >> 8,
+			       (fw_version & (0x000000ff)), sha1);
+			((fw_version & (0x80000000)) >> 31) == 1 ? puts("-dirty\n") : puts("\n");
+		}
+	} else {
+		printf("  - ELE firmware not included\n");
+	}
+	puts("\n");
+}
+
+int arch_misc_init(void)
+{
+	build_info();
+	return 0;
+}
+
+#ifdef CONFIG_OF_BOARD_FIXUP
+#ifndef CONFIG_SPL_BUILD
+int board_fix_fdt(void *fdt)
+{
+	return 0;
+}
+#endif
+#endif
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
+
+#if defined(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)
+void get_board_serial(struct tag_serialnr *serialnr)
+{
+	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
+	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
+
+	serialnr->low = gd->arch.uid[0];
+	serialnr->high = gd->arch.uid[3];
+}
+#endif
+
+static void gpio_reset(ulong gpio_base)
+{
+	writel(0, gpio_base + 0x10);
+	writel(0, gpio_base + 0x14);
+	writel(0, gpio_base + 0x18);
+	writel(0, gpio_base + 0x1c);
+}
+
+int arch_cpu_init(void)
+{
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
+		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+
+		clock_init_early();
+
+		gpio_reset(GPIO2_BASE_ADDR);
+		gpio_reset(GPIO3_BASE_ADDR);
+		gpio_reset(GPIO4_BASE_ADDR);
+		gpio_reset(GPIO5_BASE_ADDR);
+	}
+
+	return 0;
+}
+
+int imx9_probe_mu(void)
+{
+	struct udevice *dev;
+	int node, ret;
+	u32 res;
+	struct ele_get_info_data info;
+
+	ret = uclass_get_device_by_driver(UCLASS_SCMI_AGENT, DM_DRIVER_GET(scmi_mbox), &dev);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19", &dev);
+	if (ret)
+		return ret;
+
+	node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "fsl,imx93-mu-s4");
+
+	ret = uclass_get_device_by_of_offset(UCLASS_MISC, node, &dev);
+	if (ret)
+		return ret;
+
+	if (gd->flags & GD_FLG_RELOC)
+		return 0;
+
+	ret = ele_get_info(&info, &res);
+	if (ret)
+		return ret;
+
+	set_cpu_info(&info);
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx9_probe_mu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, imx9_probe_mu);
+
+int timer_init(void)
+{
+	gd->arch.tbl = 0;
+	gd->arch.tbu = 0;
+
+#ifdef CONFIG_SPL_BUILD
+	unsigned long freq = 24000000;
+
+	asm volatile("msr cntfrq_el0, %0" : : "r" (freq) : "memory");
+#endif
+
+	return 0;
+}
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	enum boot_device dev = get_boot_device();
+	enum env_location env_loc = ENVL_UNKNOWN;
+
+	if (prio)
+		return env_loc;
+
+	switch (dev) {
+#if defined(CONFIG_ENV_IS_IN_SPI_FLASH)
+	case QSPI_BOOT:
+		env_loc = ENVL_SPI_FLASH;
+		break;
+#endif
+#if defined(CONFIG_ENV_IS_IN_MMC)
+	case SD1_BOOT:
+	case SD2_BOOT:
+	case SD3_BOOT:
+	case MMC1_BOOT:
+	case MMC2_BOOT:
+	case MMC3_BOOT:
+		env_loc =  ENVL_MMC;
+		break;
+#endif
+	default:
+#if defined(CONFIG_ENV_IS_NOWHERE)
+		env_loc = ENVL_NOWHERE;
+#endif
+		break;
+	}
+
+	return env_loc;
+}
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
+{
+	u32 speed = get_cpu_speed_grade_hz();
+	enum imx9_soc_voltage_mode voltage = VOLT_OVER_DRIVE;
+
+	if (is_imx95()) {
+		if (speed == 2000000000)
+			voltage = VOLT_SUPER_OVER_DRIVE;
+		else if (speed == 1800000000)
+			voltage = VOLT_OVER_DRIVE;
+		else if (speed == 1400000000)
+			voltage = VOLT_NOMINAL_DRIVE;
+		else /* boot not support low drive mode according to AS */
+			printf("Unexpected A55 freq %u, default to OD\n", speed);
+	}
+
+	return voltage;
+}
+
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+enum boot_device get_boot_device(void)
+{
+	volatile gd_t *pgd = gd;
+	int ret;
+	u16 boot_type;
+	u8 boot_instance;
+	enum boot_device boot_dev = 0;
+	rom_passover_t *rdata;
+
+#ifdef CONFIG_SPL_BUILD
+	rdata = &rom_passover_data;
+#else
+	rom_passover_t rom_data = {0};
+
+	if (pgd->reloc_off == 0)
+		rdata = &rom_data;
+	else
+		rdata = &rom_passover_data;
+#endif
+	if (rdata->tag == 0) {
+		ret = scmi_get_rom_data(rdata);
+		if (ret != 0) {
+			puts("SCMI: failure at rom_boot_info\n");
+			return -1;
+		}
+	}
+	boot_type = rdata->boot_dev_type;
+	boot_instance = rdata->boot_dev_inst;
+
+	set_gd(pgd);
+
+	switch (boot_type) {
+	case BT_DEV_TYPE_SD:
+		boot_dev = boot_instance + SD1_BOOT;
+		break;
+	case BT_DEV_TYPE_MMC:
+		boot_dev = boot_instance + MMC1_BOOT;
+		break;
+	case BT_DEV_TYPE_NAND:
+		boot_dev = NAND_BOOT;
+		break;
+	case BT_DEV_TYPE_FLEXSPINOR:
+		boot_dev = QSPI_BOOT;
+		break;
+	case BT_DEV_TYPE_USB:
+		boot_dev = boot_instance + USB_BOOT;
+#ifdef CONFIG_IMX95
+		boot_dev -= 3; //iMX95 usb instance start at 3
+#endif
+		break;
+	default:
+		break;
+	}
+
+	return boot_dev;
+}
+#endif

-- 
2.34.1

