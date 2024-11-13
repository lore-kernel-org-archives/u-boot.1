Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DA5D637D0
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 22:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC6489282;
	Wed, 13 Nov 2024 23:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="IaFsmz7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF698929D; Wed, 13 Nov 2024 23:32:33 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B7A890D9
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 23:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSWkh9vNCSm0607V/IRss8iOfNqGMuNtejbVa6V4WZDfSbdgdWvbYehXHv/AsEXPNg5iDzOMRQHkiF4987OQgqV3FFzxQULPiRZs7eyNdUA1zr3HXwrjNIcLsU7k9s3dYEgZ1Qz/oF3t82S9gydC7NY/Go9lxFEw+r26s9PQpWFv4BiM1vz0uyB2F8/meRhyJcXPlJ9EWzMdRAL5jgoOTq/8KTVaAT9LXcaKkuRwR4l9XtOtH3EMwFSgX1qWurocBSvOuQ0NNypw6rvj2X7FS9DXxZDxT4xmbB9W6JGXgUpafc0r7RGWeAKSk/efnVHlphT26aYClj3/84imhBj2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxd+D7wFlqOqpHv+djNh3PIn/DWcm8ZCaNwnvrww7s4=;
 b=a4ocd6wGnAjJqw+4hFHB3JREoD3msdXaN445AK7VKmPgRzjhVG0suW90gAYqo0taohu76WhbzeJ57VZWpploQ4b5U3sOG77RpIf7ntKpGi9rxtMYuL/GGlH5bYYiyX64/Nn2wPwtehWKByL0qafddTMbgczWrleZtHyxRd2lECCfoWHEKTywlRDntgCm1yMvslSBdkErjJ1pQnjhFjXIr9v0gbDAaQ2wL4eNdjNm2U25jCfu6cNc6ytDkmIsGzrS3Paeq7tIkRaHirge94uTG4/+TK80igX+wpjVAn0ZCIQg8Li5A5eGHcULN0bUcyfheXrmWlTPgZW2YkwfZvTOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxd+D7wFlqOqpHv+djNh3PIn/DWcm8ZCaNwnvrww7s4=;
 b=IaFsmz7qpaxYqkWfKEG0lAWftIZmuxNSaQlE0vg53eg6VIDUif67bWIciyct6rQxQqUuPiegxNkC2bGX1jRzxwXjd28LtokxWsp26eogvLcMlw9p4oKKgv38Pj7y+VeNZmm2FsA/tUEfjz1i67tVO76yXrpNavSzN++vFxIdF6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DU2PR10MB7768.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 22:32:25 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 22:32:25 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,  Joe Hershberger
 <joe.hershberger@ni.com>,  Ravi Minnikanti <rminnikanti@marvell.com>
Subject: Re: [PATCH 0/3] teach 'env default' to optionally keep runtime
 variables
In-Reply-To: <20241030213404.2894247-1-ravi@prevas.dk> (Rasmus Villemoes's
 message of "Wed, 30 Oct 2024 22:34:01 +0100")
References: <20241030213404.2894247-1-ravi@prevas.dk>
Date: Wed, 13 Nov 2024 23:32:30 +0100
Message-ID: <87y11mn4sh.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0018.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::32) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DU2PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: f4211052-92be-47ed-9d38-08dd04330ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EpyJEL7B0FpeHyUxtr4CZSb0SuQOZP1WnCQnuNw5CXuzO7kv9UycxdAnPHhm?=
 =?us-ascii?Q?VpxyeXJNpvjAiXnBaX+fIzWhqxYREEJu4RJmUl++ohpEIhRr2I7ZrSibdaNo?=
 =?us-ascii?Q?QS47dVfmce3xfA9sstmq0mi63KIZ/BjBqKmPj557UgJmnjzn/qSr+M0M/RPH?=
 =?us-ascii?Q?YcyP/nHuMbBJdiqAWKBOa1jpwJvvqiYJKxVGfmA+seVGM/53JU++kFNN4QS1?=
 =?us-ascii?Q?A/mOPVX+JJD20ru9RLGOMfwATYccHdu/LOAnTcGHaojlwf3fVofsYLUzGSjA?=
 =?us-ascii?Q?a82ui197hKgVBJe7YvOASHfH32uGjevLHo1QSBDDr0J5Uv4Mgu+yGinAeNW6?=
 =?us-ascii?Q?CInVAdHuujrRkFLApSG7S2GEq++xtSqGvy4nF56RDVkcbK0Jil846lr+LEdH?=
 =?us-ascii?Q?8SBFYAQovR0alZU58xc9vYh8DQG7T0kgh8pQ1v6JV+1UGIeBIEAmi884qzuV?=
 =?us-ascii?Q?o8XU7WFCsl3tw2m2mn7oncDY0PEV8ufka/Hofohs2ABBDJr9V04t7RfTJZ0v?=
 =?us-ascii?Q?pd1v52dm1+0UkjgZ3LXT3uSpsn9RfaYgugC8THDWubB9GCW4XzFR3V6QC1t6?=
 =?us-ascii?Q?Wlz63acVDsQIpcxvRR1uSx5llAqUr+XNHIe2DZA0JScX67slHnACzuhST680?=
 =?us-ascii?Q?Buw7aDB8iwfFuwXBpSmsgQynCJyC5hPSH6xq75VtAwpeO4e5Bih8Ers3x7sP?=
 =?us-ascii?Q?H5Vo/1U/VHyM82zikz7c9wRyX9BjoP7Yyi8u/srvVYly2WhLSjn/XdlQJ6IL?=
 =?us-ascii?Q?obgyXBtuUzJkZp9JiajjFeOQHuXF2djX+yDfDuJMYdlrTti8MUep127cG+xY?=
 =?us-ascii?Q?C3cy60YY17X3oY4KSJut27yZGRdQ+vGr6wSP2Gc8JUAkQcrZGI8ogVBiKsS2?=
 =?us-ascii?Q?E7ZJ1zeRGk+7mXVOCj21B0roc/VMvxqfkLuhFcZN2PiIplyGYx0F7xjd2AO2?=
 =?us-ascii?Q?MR0f7gvXD6VNfOhKOnKFv/IdyfYi4yGAPSeND4UM6MipXzcDsZPftmntI40N?=
 =?us-ascii?Q?tqfwsTD/GQ+x0zv6Vlefjzjmkxmp8ToD9SrilddaXi8+NK+0n/F/0D4w2b66?=
 =?us-ascii?Q?LnsurRzw9OTiMhplMnEwFvP/BOqu8Jon9T7haMCdYxAtf/FT8sH4NBU4V2O5?=
 =?us-ascii?Q?KdFA5Z+XuZKSmCKwPB2H0UyIHibEanB8Shu2Cq5z1u6rIqhr8qfQCbA4nrEx?=
 =?us-ascii?Q?oOo9M+CgjvYpIyhnUSrzF7Ttw2IYzISWuTb7DOG26LXIyIW+OqYxGa8sLQR1?=
 =?us-ascii?Q?bV9ISZfYTezBL1ZOFjNyGc7zCfMn4p0w2ZTmaTfUrswuC9ct6qp2WC/KTFnQ?=
 =?us-ascii?Q?0LK+lACASdIQ7rZl2Y8MVEL3tDZjvAzQ5//yZkpavfC4908gOlokTTIugdFD?=
 =?us-ascii?Q?SoWQSy4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fAtplz6B8SE1bLVrwUSYqpkB90qjw4ryrdywULilNKmGbpK5FvIn4xm5YYEa?=
 =?us-ascii?Q?tgADrK2NnpD5xXXQyZUcsIqtms6v/9X55NMYz77ZhVJfXBVYsXYQjhw5zfbN?=
 =?us-ascii?Q?N21rdny+R6NOkN9nTIyZdgcLtmlayL/59hi43Iow7hYI4tw0pyphK4kxX+/9?=
 =?us-ascii?Q?Pn6d4qaHH47GZGW2Hz1uu7uWt3TskFom+SGrfDxvvoa0c2SLAOMWRRvR3WTs?=
 =?us-ascii?Q?IklSXNeJGeUQo+Himhm1Z/B+GJsnIFub5En9pYAi3u7Lr+fcz5Eo10WFSRVV?=
 =?us-ascii?Q?gLpXdddi8Refpb7dY8a7yxyCtytWU7WprSjuVQtIcqTjHntUvpEycDihNTD5?=
 =?us-ascii?Q?DowsJieJxSjn1DuBhxris2d6h8iZLVjj82r/b9Y2xg7Wqv8i2q1+p8EHxUR1?=
 =?us-ascii?Q?UzN6cIvDaILA6Jxg82EdtJGFetfcd6wkFLL1FIMeChShVMGlNxmvFS0ODpyB?=
 =?us-ascii?Q?Vscde3WF4emzciq+UNRLP2ox23548yB8BUZV4Ej8zBaiDa9uFQ3pQx/KjGaI?=
 =?us-ascii?Q?/hh3rFwN3z8K8l0B8ISueqYRdCH5YmMe8dcF58Ewzam8YYiZpX6ShRHpI03C?=
 =?us-ascii?Q?FhWYmQkUFuok6HSeAf82umEVO4y7yk2h1B9GunO8JGyIBRQampQk0X6e0Trm?=
 =?us-ascii?Q?g6bOfijAvOXm+Ha9bb95E+R4Iuvr5ptdzZ4Z/bdMa8kYU6Sb7MIuRbW1O7A9?=
 =?us-ascii?Q?CiJaD5VL0n4Gw/t1t+2OScdDSGRkSiK4+9Eacpmb+vUL3hshxTrI1hr8D6k+?=
 =?us-ascii?Q?daEqcYw4k0IxXPcBZfxN7Tllf9twEecZTH8vCd5RvuYREvPMd1+9sa1SJfVA?=
 =?us-ascii?Q?m7AlNO4Hm3Kwq0lm7jJClN2ra4kXyJ/8UJzn0Q3sX5USnVrJVwUxyUUBBQOQ?=
 =?us-ascii?Q?oGbZKPMlaf+VayNUMM/2igJU05VlI8CXihT2XXH/OzYVUTP0oUsOmWwiNG9j?=
 =?us-ascii?Q?RgOXbwnt55RxXy1Xaq19DRgBgMj76eU6zP62aySb9fVBwS/avDSAhXSAYbU9?=
 =?us-ascii?Q?zRInpcW9pzXXzMglqD2qfhOPzYO6GIxmF52mrLp91UbC5cIB/X03CRPDhCYO?=
 =?us-ascii?Q?QZ6adeWCtf3rgnZoGbCZxxeJ5H4goBpHfz0A6BNG/NS8eHzhPU5Y1Bpv9JPV?=
 =?us-ascii?Q?ziXSm6JODdnCXM3zPi7GXwcTmb5W7qtZBbrigL+TGV6e2IDzGd4twJkVPcZv?=
 =?us-ascii?Q?t/VoxSyWA/7aITn5zRGAefNAmVLGuaKKpcRKaA540xWb9mI65c+PySs07tRv?=
 =?us-ascii?Q?7B0dwXg6YkpOXg+cbLGrpRZjgwhu5ntStZJ9mveQzZSIieFnshyvXxVAf8Ph?=
 =?us-ascii?Q?kFfKiub0GeAs48LmU22NjDr86j8BK9QN3ThKGc/0E7sx6WoQeP5hLm2jX4zY?=
 =?us-ascii?Q?sV8Bnk3fb30wP02l6uITSoaCE7FNTU82XWP/q1v8gPatkwhbZefydKJ5qFT4?=
 =?us-ascii?Q?EUQL54Q0j6gMkQ92hw1k5J01gGTwuNwblG57qvhaO50rF9rVTESq2G0tw5W4?=
 =?us-ascii?Q?KD0w35MEPOQtvK+fuZDa4P8BwfcLJV/Cf3EeqJHWhX6OjRhMNW6OMMToFHTg?=
 =?us-ascii?Q?guhotuZwfdP1fk+TD3wBrsDt26KKWnNoZnEHcY7rwXTnMHxK4LAHW6BlXDI4?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f4211052-92be-47ed-9d38-08dd04330ba3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 22:32:24.9969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UF0Ssb0j5H/bT07TsJYuF8v1uzDPJUMk7RhhvwbXaMYuiO0zxv4WvdeGLiBMV10oQkCRCYGi2t3Lqa/DjwYAB7KL5hOjAV4Np6ENXzo8fNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7768
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

On Wed, Oct 30 2024, Rasmus Villemoes <ravi@prevas.dk> wrote:

> Doing bringup of a board, part of my bootstrap logic is in U-Boot. So
> when tweaking that logic, I was bitten by a previous completed
> bootstrap having left a copy of the environment on the device, which
> was imported and thus overrided the new logic.
>
> So I thought, "ok, I'll just make sure to put 'env default -a' as the
> first part of the bootstrap logic so I'm not bitten again". Alas, my
> logic also relies on certain variables that are set by C code
> (e.g. for detecting board variant), and doing 'env default -a' also
> eliminates those.
>
> Looking around, the hashtab code already supports a flag that does
> exactly what I need, and exposing that is (morally) a one-liner.
>

ping
