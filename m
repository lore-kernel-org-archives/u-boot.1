Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECCAD3B7F5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8A4899FE;
	Mon, 25 Nov 2024 10:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KSSEbATd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B8F8899FF; Mon, 25 Nov 2024 10:36:57 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F75A899F1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klLLj3siBLSyclYbYE++D0dD0ofZQbOEjseDsMGm5bg+H6IrGUagztBxupPHXPinhB6X3CaIoMZKptEfes7go6KZOG+D9R6I1c53TJDMLuR0C5/Pa5191Ikb11MPli1i6D9kbKC+xVLzgAUeGKV616XlXGeBhItNczfKw/S4EKhtaCOuBX//2R+lecGYdbp9hRC41hYc3VKEHTqEzGFXOA6dPdNykQfY2V4wlkd3tv2dy6pYJQMnm5HtKXsPBgdoqL8pR8aLWp0PynHa0qvQDgHkic9Kc9mvET/Rc2CxmBdwzJpI1Sep8cn5+Qw4G+FxPc79hZVpbTuejM0+EGSOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INgr6aeu/pspJO5biPIQ0/FMVFC4KkdkVEg8JfUH0Mg=;
 b=qh6b3gh8FrhnX2loxde6YYsdHBD0MOE6kmaOyVrpqT2fHpSvR6Wwdq+3VdQ5nmEN+pW4MFqhRcm2zPU4ppUVhVX2JVJ0l6UcMQ5VgGIKPo4owOmD3/aaoMtes6LpRMfRrxk//pFznFV1wYRT/oy8PnIol9BEIhXCNeuH/oVsfi0XyJyy9WBHsK6GqxZii3wZpzDeXnLGnucnQwdIE0yr1Yw1L5utqITLcqEsiZRhn0C+veHwXmpdXZCyJpBaD7JkipOGeH0Xoslk78b8wYQI6cPpw9DTI3cheCF+0DG3RIJC3mN9yUGlNNso3hwVZwKIBCb42+MvVoRupOm56/wnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INgr6aeu/pspJO5biPIQ0/FMVFC4KkdkVEg8JfUH0Mg=;
 b=KSSEbATd5yJCKi487ABfIYomyKtGEdxc9m3tBr3DZsFdkPUEgQoWPhfyhGy5pAiDqMjRFj3ELf0uOlVolwHBcn82gYjdPZIG2LLIz20Fo1a8FNxJ5Ar2PVLE2bGbUqO9iNduGQ0TQx5gfp+VXgxaWr6o/+znJPsWVSJgVAIdOzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Mon, 25 Nov
 2024 09:36:53 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 09:36:53 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] powerpc/t2080qds: remove spurious x permission from README
 file
Date: Mon, 25 Nov 2024 10:37:00 +0100
Message-ID: <20241125093700.1135929-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::28) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DB4PR10MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef924b3-fef5-4805-4908-08dd0d34b1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1IoD2LUWEeaAekOyNCBcwX1JOjZ3zNHGWpWU8OlVd2nMz3z996M7LT4YD5gO?=
 =?us-ascii?Q?ye+Xj3NwhnwafwRw8edgOBuiG4FPBkOKMsUhtW4JbeiQ1jtDx3XH28K3fphN?=
 =?us-ascii?Q?dNZBZ9OBMIovUuc3fXkRIBs9ZD5HRSKpXEXeBCjXqfLJTjQw1xHvO3B3rwzv?=
 =?us-ascii?Q?qLkmIp7bKJTROk+JoUPdR4rgyxqxBHBXoEuoe16TilLpkZdDG3PVyPDX2c0H?=
 =?us-ascii?Q?vDZAzloypRt8EbHMeZ+fbNZ0WM8aD44SKS07DlR+CryD2xNVjvfxBuVPlfYW?=
 =?us-ascii?Q?Mfv1cUnqh47xGBW3xKDyR6BL+dkKUggkXZ8GQEsay7MPGr8hGk3022wx3p2J?=
 =?us-ascii?Q?dWPiqhpkZoCbiA9M8xS4jrGCkUtsQhT77gzLCYqg34nNDBHYjZUgcCFV3Wl0?=
 =?us-ascii?Q?OV585XvHDSGwyIwZdoT+yxLL+boOFIvfhrjykA5W5a7WnMag0zn8nHb/2wYL?=
 =?us-ascii?Q?grmJK7TD3WQDHCYIakbq2HEHsvOoBElodbef9a/WGTXSZnOgQcJ29nZ3ztRu?=
 =?us-ascii?Q?pnFRmLkJtNiTLqYfndeVd62hINEvYvu/G6LtHop/72ygimo9TO9Qq++4c9ti?=
 =?us-ascii?Q?3vV0qmzwB6kGF/kGuvxvaDWPFpKnQVtPpbz3DtGzLPqL2tankq/QKcbyLiJi?=
 =?us-ascii?Q?4E1mAXxrbuITB8XXCyUO5+sahGUqvDYYtNmwmlWKIS4mZvlaTPrOJ6ysN0W9?=
 =?us-ascii?Q?yl5Rt4spslUUHBRXFKxNJAS8e8JYCXU17SxoB9hfDrSlnXwE6uFKS5FEipaf?=
 =?us-ascii?Q?9w77IDhV2j4pS1y+7W7c5VQ3HvgmZhDOcCdtWPiMhefhJwvRaR9Ds+yTrSQo?=
 =?us-ascii?Q?pGHQlfVqu8qY9zUSBiwGjwFuJ3SkyNBvXjbRVtgxCM712VMzcWDHXOIi4Eb4?=
 =?us-ascii?Q?qzpiQGgQ+dWoFd3ynrj8E5pEu3qn5u4svu/c7on6sIlYYFJ9GfIufXkNmr3b?=
 =?us-ascii?Q?qBse/4K+mfmJDfo3IUnCKZZDsk1DRKHxwlUwG2tcR3TdKGGfGpHFlMEsZdqZ?=
 =?us-ascii?Q?rFV69qtiemgadeXKEO6pPOoiytiinnPstpMZo6zcwGAfR/iTxaBkZWDvfZHx?=
 =?us-ascii?Q?sfXAvQ+QMiXKG/QYqdzmn272Fhu6E+/H8ER/o8LrmL3yNVV4h9+fYj85TPAC?=
 =?us-ascii?Q?HfDrUwE716lvZeSRKNidgFAq38p9h/n2HwH3Y6QQyZb0AnaBapenCzNhGYCU?=
 =?us-ascii?Q?g814qemRnoM9uMo7D27Bm1G5HSQJhO38rMXJidq37Z11GJihKHNUw30/gmqh?=
 =?us-ascii?Q?4qzJ2tU8bCqTIojowLgAM54jh29cTSJLPJb27Po/IqTaFpDOy/FsPe3tCZGJ?=
 =?us-ascii?Q?xMU5/riqIlBf5AjyToadjYItm4DOMTGmGY50sBXdK3HzFO8cwQRWhZC/jHCs?=
 =?us-ascii?Q?LF7WJ2KN3m2IHmk4HfJnaW5fXQcyeSxmUBuf4ZAqeWaqnUdmcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ViyJdT8zB0n25aKbujmTCZa7wDQ2f/UuexA8/B9BI7NjaenGJSsyeg2EqGox?=
 =?us-ascii?Q?QHECgeV7MVdzRdiiegywvJXVu+Sg0YH58E9er9u8xNcvFucZQz0y0Oksdl+n?=
 =?us-ascii?Q?SPahXdn+ggTJYTSkch4Fwg7eXH8x1cAf/Lkv53ULtLiGYS89ROOgC5DDOmru?=
 =?us-ascii?Q?ZZuqBMIVqBha49n6UF9qzF9fFceVnFFBm27dtQzWQQ6bethp0WqwDJvEMwCd?=
 =?us-ascii?Q?hxdrEqzNhZctxWuJji1YP5GLCoTz7WmgKtQZQdaACZCTqDJEbNT0XJmN6Quf?=
 =?us-ascii?Q?mtwon8ULefIrLUEPIUhofxtTyYylQou2UymjPBXVFuDL2v8V9Zm95M1ezxJI?=
 =?us-ascii?Q?CClLr2Rg2hJlkNwFvuB0MbAbjNzPMvF+W+/s5iE2JD7xdGIbQbI8Hvnkgz3Q?=
 =?us-ascii?Q?sYyxtJFVXDE/rUogWj0eDZrAOL+PVVpZOKk3++WcvE0gBOxnx/NhTyHFaTbg?=
 =?us-ascii?Q?6i0v4jYfsPTsDAgwkA4PLT7U7wUu1YYvDqbr0lXaPRG3dQF57d5Cd7y9aEtg?=
 =?us-ascii?Q?be9r8Fspmeg5YgMaasFtdzp56sud0bOPoo4ZP4q4uCPVTDKRphVzwziI/Nzj?=
 =?us-ascii?Q?8mf7WsiIG0LXXw6rAUHwIX6jB4hg8pJEsPt/UTnSnKukVgGSOgpcEYxuXVsQ?=
 =?us-ascii?Q?0gSEKbY64EWdh952JZaJru234JnwgSKnYdxpeOhvpnGU4+nKIUWuOg9IdeB0?=
 =?us-ascii?Q?jML7rNWWQUsMiLR73trdNbjPik/NW2aehpWH+sR6Msw5N870A+m4C/SEczRL?=
 =?us-ascii?Q?lWnMTeepAjCbUDzy9p8Y1zX8JRmcSiQcWDpeo//8AiuWvYEK1rozfaB6/h1o?=
 =?us-ascii?Q?t84hO+wDZJ0XPbSyu0n2MEd37v6yhZfp6BiCwVIjCDX9GPUjbPGX0GImTg6b?=
 =?us-ascii?Q?0Q2Jt5igpsnQjRR6d/zPFFz3CeoFf017Vl+YQA4pzakeedXJjBRvSymo8MM1?=
 =?us-ascii?Q?UIycTYmQr1a5gD5ZsPBvITosbxFQe24OW7M8kTMjVPSUAqcsdl2Xk/DwTry3?=
 =?us-ascii?Q?nyhn9Ej9fTP1nNHHtV6UQzp5FEJKI8UeGpUn35OnXv0j/lweeYygOV217AI1?=
 =?us-ascii?Q?RUUjU3M10wFOb2A+gGjaBwSiXJ4PWapb4KvMc5REVZXuWvDHS4psUgwjoxDE?=
 =?us-ascii?Q?ZmHRXSjy8cOuQUCxUJiyVqmil8Gomfhlvs6KW37WRoTj33hqBx5j62OG7B5n?=
 =?us-ascii?Q?9OvqvjnFrCCJW8x1ZHai298G5uPDJHnKQJbvxu0sz4Mpv7yPe3GYn1bbOQVt?=
 =?us-ascii?Q?dIqBrowBGLVgKyWC6fPRqqCH2dAgw7ISX7SccAFF6l3JO3dNR27Nrl/SPx9y?=
 =?us-ascii?Q?Qx00H0oIAe3CF3+HUY4jgb/LkmEfenmbmHRUqFYeymYEizeBiSzyl8BDOYx2?=
 =?us-ascii?Q?Nr0rwie9lItN8aPfDZ0au0lqPBweb5RwA7Mi8fKV01l3KXdCtqJQWVFy3ZWS?=
 =?us-ascii?Q?TAVexT7Joom7aBt1z3JzJzSgwFpC6LjyToJ5AGDt97qUprHitK1Gz1LAxhmG?=
 =?us-ascii?Q?apfF/LZQbtwWQKoZM7e0aQF1fqmit50q6eAzV4Gk+U0CaSik5gS0B0yzo1gW?=
 =?us-ascii?Q?/84I1phn9QPjgNBPfmzrpGdmX8AZAH+7eBahol95a4qYpxgOm43QOIGyabFo?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef924b3-fef5-4805-4908-08dd0d34b1cb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:36:53.0209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/LfY8l6T0vM7D7qtbK8jF5fSehcNcTQdZU3EzWhWNN0IUBFVzIWtpPAcLSDWL3VJ/2BWD9w9aIZuoIvWMW5+loqODmU5aWKtXjkTkyC2yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6917
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

It doesn't make sense for a README file to be executable. Remove that
bit.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 board/freescale/t208xqds/README | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 board/freescale/t208xqds/README

diff --git a/board/freescale/t208xqds/README b/board/freescale/t208xqds/README
old mode 100755
new mode 100644
-- 
2.47.0

