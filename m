Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553DFCDD1D2
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 18:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AD6E88BE4;
	Fri, 27 Sep 2024 20:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RKUjxCi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622E088D14; Fri, 27 Sep 2024 20:56:22 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE26788B1A
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 20:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpmNLFqlbVjDw96c+yirlYTZf5YiGf+hS+ccBg9N/9m0EaRHORDIJ585Q2P6sbdj8wLOvAUzatYyHSfABGscbxKFvAnmg0d4bjskqYdLjyvFTF+vt1ecOp07U1TjHBsQQpkpl04mvLiAkVFXJzqaspc12wcaacefp+EoUgn52XPtxFWQi4+KSEIrSSEuZTJTQpi3UUQcQXMKwjNgZctFTgYz1fqOCaJe36CtwvZGu9bhQjuIOhTlMo7bKS3W9iwSTLD+TrdiNOm1PuojmJJGHIO/wZ26XvwI5wyNmKMqu9d9ohrIK3t9kpH9kd/9LNwdXkkOfNBvtvfLaR/FI8FQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZPseqFFayJ+ikrbRpuz0BGU+8Mfyng5nlJ1Z1fsa3o=;
 b=sgfiSWkIeKJ46C5qJ7HcpYjhCvvSefB/28xxR4AsAjODISaqFcuY4gIe/9HSbfw+u1WmwoxxIGH94I/lEaKAfyiRg5sjmaOJSKvB4mcqCt0FmNJEUT3l3lbZCySjjUg3uOudoC4v+bxnM5va/XUzuAYjynstb0r/uPulIRPoiBKw/i+t/S4SGF1GeM//uuzqjy/LLy1rzRGafIzRUjJG1eR6mIBxNztG/QPjTxa9G/oY2CndfkUXdvtuGtglDOa6Fade9ji7TUZsw+CvZo0CWFod9zt+kb1WCmwdLsSkvS3ZKagAzkeKH+/yx77YXu6ZTruD7xaP5Dd7wgxL1A6Fsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZPseqFFayJ+ikrbRpuz0BGU+8Mfyng5nlJ1Z1fsa3o=;
 b=RKUjxCi6+ehAegpHu7CSOZ0aRmJK3u5nEiX9wCnH177tf0oXiUaLTFNRMbLdsXaIpI167ZDGGIQQaeLioM2zkyL2PVZLC27GqIMs+wDG3iXTd4Wx3Ey7giN/NpUpFSYUxbhSC+QUnGO9V67B0kyZr9qqsOEzZq6hc3v+FZduVVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PRAPR10MB7621.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:294::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 18:56:17 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 18:56:17 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>,  Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,  Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] cmd/mem.c: fix undefined behavior in mem cmp
In-Reply-To: <20240927-cmd-mem-undefined-v1-1-56fa57d0927b@cherry.de> (Quentin
 Schulz's message of "Fri, 27 Sep 2024 18:37:43 +0200")
References: <20240927-cmd-mem-undefined-v1-1-56fa57d0927b@cherry.de>
Date: Fri, 27 Sep 2024 20:56:18 +0200
Message-ID: <87bk09kjsd.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PRAPR10MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: a401031b-7ab8-4e2d-60a7-08dcdf261128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Latc9tUJxIhxwgv3ihev3M8H0ypZZesJyaVBaIew0ECt+bbyjaKjylxa+qZd?=
 =?us-ascii?Q?qdi9vNxjPFrXhcGIJXfOwtDE6gEu59//ERjyZsJc2v5tx3l3aJubANAGxtjt?=
 =?us-ascii?Q?vh4BLN4up74beBKF0u7G4d1pRGS6QeN5d4wbHxXDgm2hCPg3fFHAFsK5wDjH?=
 =?us-ascii?Q?Yv0bri1hZEhpx2xvh64CgYTRpxrebad1pOgyrhCLA3XifyjJAfgOoAb2B3ne?=
 =?us-ascii?Q?YvRXgVZkJexbevqMVE6U5PZ653/REYKe3PGe/kB4WAdyGI6JFHnyHk6I5I/w?=
 =?us-ascii?Q?6NCBiyurYZS5/+RLfZw18tEvMo6jIF81O8CMqjaVQkyY0A9bSp8cWnlf/ZiZ?=
 =?us-ascii?Q?wDMCCRGa1Hvkvrdd1KKA8VPKN4iAiT8Rxgc3Eedmp1waU2GNcQ8IrxaUKKpq?=
 =?us-ascii?Q?nddvFBm3XguMyaEeOGbUjJZVQPfP0QkIHBvhaTQlmnsVtAaIOIbg1DXefxNH?=
 =?us-ascii?Q?y9LrO+SdOA0gD3P1PtK08t5CwRCsPDwpTFZiYXIp87/2xM1zWeghYF3SD8R/?=
 =?us-ascii?Q?vH118b54oXiHcV/hn2qDzI/RWIAe+OS9gLqJlonFWumLlUYJcq3l26TM7qZ1?=
 =?us-ascii?Q?8C5oCqWa/2K8cRO3yNaEXEUnqU9J3hWPnmRZ0Sdx8GFHae4vwWahYRK11gCQ?=
 =?us-ascii?Q?PR6h8cXG6keVr/jOyV/GYm7cHJRV4Lu3mVMUBbJu9ejiyc9bfumZb7882B7+?=
 =?us-ascii?Q?s7wNui6JZO2ccTspTfmkZ4lAUgZJhz5+PT9JvyQcYgscOSOw/BYtsVPtnXX8?=
 =?us-ascii?Q?egOnUPthHbcxrqXMyWmaId+XgQOY6bwNNodr4uJ+SI2nDDbbcvjttxpwGmg/?=
 =?us-ascii?Q?QmYLX59RGqREWZGcQHaXMvPxBuKU/aHaJUreCedzZyInXAeaqzmpe+tXLF+Q?=
 =?us-ascii?Q?5PmK1nYTmbiQVaiE09zb2KrKDIoI45sNfqEeFIlzWwDBnBSqbRugvAj+LGQP?=
 =?us-ascii?Q?1blAWTZF1JKjt+HESSRbHOEONd29KhpOifB6yNBTKJZftgQ+Qm2t6KoNja/S?=
 =?us-ascii?Q?62rFWzfVpibWuZMQiAUnD7DRnf6/Dog0a7wZP+wPub56HZgll7tP+jFRiOat?=
 =?us-ascii?Q?IJzWuEEE8/FXaWwL/6WPMSID7CkaGtHfhLnB4b5RWsd+wXFQYCJjcF5Q/9ph?=
 =?us-ascii?Q?75dDvH5jhlhE0esTXX93YrgjBjRNVXbspoVFW9ggMIbPUOq/VuCXcNDUBpVV?=
 =?us-ascii?Q?YxYj2twoUbSbYVdPS3Sfj4NwYDMtyYt/kYcyfinR9yJRyNz7mlNw6fXfwJYt?=
 =?us-ascii?Q?EYjcsu+HdvSH9fysKmQcPt04vsL75eM1PwpSuD6tH4oAkQMONmWgBRqGCOzp?=
 =?us-ascii?Q?MR1yKt6c0+XM6WYpIcaZXG7RytzypsomsprYw/t7xFW3dA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1c5sac2QT0N/MW8IcgRMamo+93C3Cl8qitj1q8eXdMb3AUux3z9vWnOXLoIj?=
 =?us-ascii?Q?ZdWRBfTO4T3YEP5qkVwDUFGCOJURYjQp+RRzuCnhijPv6RWfRCEZN5b/KFTu?=
 =?us-ascii?Q?vhKM8tPUK5PfovoT2zgj0ClWOBWduaOLzwI1aYt23dGF8ifvAfvvefoK2bD9?=
 =?us-ascii?Q?QxK/Z3OYemLubZXk8JdY7pNU8FVC6U6WeJGxY4onRHqHBw1X4o8PR7rDUZkC?=
 =?us-ascii?Q?TOkfj3FtAplUDt7FiBavJIxEVQICkf3jwBW+gjekWu+R/pM1hsB/LDul8EUc?=
 =?us-ascii?Q?98qMKpGOjC4FRNoOIl8pvJwVKbV3+xv5FAnP3u5LPEZVw0Y90pLlDbHCP/Ha?=
 =?us-ascii?Q?yXNZOC/PQikXZSWrpjqsWaej87W8vm4jlAvI9u6npCI1nt/YZwExrakeKcq7?=
 =?us-ascii?Q?lZ4pF/9eWvdqsWDFuFKLyaoUZ9mryYbYoA5bansqYiDvgcpUOAp0SBZTWh/n?=
 =?us-ascii?Q?0gpGDjGG3ddh2b/t2dswB7R9YIvaEW2lsQNu9WcKIj7K9OCq90GWw4/IHtFr?=
 =?us-ascii?Q?+dFu2DMvPwG5fy7nTImpQaD/IpWeQyEDKWureDG5SqGSEFb14J6sUhhBjxy6?=
 =?us-ascii?Q?7mj36MWo2WfXd3HDYP2r5l1fbx0Glr8eh8R354m8blP0ves7C6XriO6Ep3N/?=
 =?us-ascii?Q?DQIAFtlCOEHsdgXxdcINadqdU4ocF2yuMGK0yN2TnojVoSmQqR1lbzo9Urnp?=
 =?us-ascii?Q?3rYwzmwiblAKV9sO67+rItDmV6yfgOfhNyALWOJbYBaSmD1Uts5Yy8xFtIfl?=
 =?us-ascii?Q?BJFkLcrfkfGUKLHKU+7yRj8KiOd1DzdZ2g0QTi+bNh2xI7ymkTEzPiaYD/lR?=
 =?us-ascii?Q?lC6Wz65C38HEWlnIisbglss+ypAPKGyL6ZHU4H890SVdz2nl2fhU3ForYP2H?=
 =?us-ascii?Q?GreF8uLHB9KS/HuE5iNFhLZnvLwpZpuPtB10P2MeMmLaLChNaDj4Pa6RJS8+?=
 =?us-ascii?Q?Ov5bQI52ZvdJOwS+8n5CRhcO/DJFaEv2HBZZ+xsWXET6SHSsRQELLLR4+KhR?=
 =?us-ascii?Q?boFRTcmrTgGDOR0MBS/WxeKF0yS5850CckiBufN6fcRW0Mod5s0qkmLXOIhw?=
 =?us-ascii?Q?J5oIn2uXDX7KEvfYAf2gXC78Ayhpy9NiBWPZTAq2AhjCuIlj2zN3V4N1pGYq?=
 =?us-ascii?Q?z+MtHLy49FBDx8WNEimeTcO37m2wOVMrhHQIuQnPBXDTesCPte7tHD9/om+K?=
 =?us-ascii?Q?ITXQc1AxGrSZT4EoGLDBryIOZdv8lDjN9snXO+rIH7apAyY11v8G+wo3zETF?=
 =?us-ascii?Q?LDgojeHpoWVDIVau+NWH12t+arjdGHG4tTEeldH+gC8Y0gTrs4pe8I699XLn?=
 =?us-ascii?Q?NAyqFdHlm0yoCkLvSJqX3sHWxGVfi/v53NekWEwFTF1ZdSaBi5aSreuKhNoz?=
 =?us-ascii?Q?Q5SCFY1w75F3XRnO0J5tU5qz0ORinphYNhnSXMFlVnTaueoHvevHOk4tUNjF?=
 =?us-ascii?Q?Df5wMndrsN6qtembk16n+PCcp5W2Fj7h9AJY7yYkj/Mqu3yiECCzP4kEQQiy?=
 =?us-ascii?Q?L8IbRBoLhS6j1P0pkU13BI86nGyipDlQd5vEBICoYOU/pwtgljXjf1MEX7TO?=
 =?us-ascii?Q?EqBVDDH/JZaj7vIdeG2mJ4x+1pHUfy45pcNXvc+3ZYs9hUDwlv6/Bduxv/Qb?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a401031b-7ab8-4e2d-60a7-08dcdf261128
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 18:56:17.0881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc8vKm2GNniscQefpk4B6RMcY9ddq9/g47WCgus2KriSWmkdhcctapodwFrcS14+yfaVVJyraXMsXcgwGOw5hNe5uXV7VYzLwK4jFMBmFQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB7621
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

Quentin Schulz <foss+uboot@0leil.net> writes:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> My linter complains that "When using void pointers in calculations, the
> behaviour is undefined".
>
> GCC does say that "In GNU C, addition and subtraction operations are
> supported on pointers to void"[1] but this hints at this only being
> supported in the GNU flavor of C. And I assume U-Boot may want to be
> compiled with clang/llvm?
>
> Let's fix that warning by casting the void pointer to a u8 pointer since
> the size variable unit is byte.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
>

No, let's please not. Try enabling -Wpointer-arith and see how much
churn that would require all over the tree (doing it in this one place
would be pointless), and all the casts would make the code much much
harder to read.

We do rely on lots of gcc extensions, and Clang has documented that it
"aims to support a broad range of GCC extensions". Arithmetic on void is
one of them, and that's not going to go away.

Rasmus
