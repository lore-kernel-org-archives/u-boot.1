Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1791E98FDE
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 09:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 299F9839D5;
	Thu,  9 Apr 2026 11:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="GW9YEvX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7B783D8A; Thu,  9 Apr 2026 11:50:59 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F4F83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 11:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjCqEqUnAZb/7VHGqv6bcW7n0mVbxwnyOzcn/CtzqHwwKdotfwRv7jml+oZPrVxPUboGMzZ7jRbhJydL8/7WQY7ZZbjetv3sjfkRytFnBaWaWWO/5w3E1cAUhlc/664+Z3gXKU01IdF+cZWIOsvnwo0lep5vvyAzcptxWl3ibOe5ivI+FgTZ8NAsH+JDd2DTU75a8x1UaILdN4czMPm9K67+SGmfQInIcyFmaOfY46Lh+28UyyNZn9Re5Gj883p4Mtv2C0GpNE0wlbyjz9tL2GCD2xWgrL6EYV4VZ9DQtdbRCmxfT5KGm+dKkpSodJ2DZcptbflDkTIUkp83jtsaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZb7SgPQ+8QTFLFEYSW/FL+zQ3a64g77jZjPa8Di39c=;
 b=rXdFd/5jGyLyHUbSijxbsrgHn4Rk6DftWkFzExD+MMoNRSDB3RixsFDqZQN3A8cSAYiR3Qa6U0LZ9gI5EfNToWP3kkFXz+i8OJj5zVBjrZqIS37xRlqXCNv5NpN2S4ye5gCkmAlSr01qVivVmDaA1LIYVKCCZ5MmhYQMsvRHYtjru9mAuCjoNhmgnY8A9EQhNTRqCvpZmrKjaM/a1x8fYcU14vbL501rUDbpuRkfC1yJf74EpTOkcJmrx8yDcHRTeQqSJ1ckl4tDnzl4EnvAb21nsRvXmfb5hUChmSqUaWa8Q/qxpUuG0K0LkVGKh7BoedC7wxUdEY62jrpO+5Ersw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZb7SgPQ+8QTFLFEYSW/FL+zQ3a64g77jZjPa8Di39c=;
 b=GW9YEvX3kZiiJqvMXCZgZybJtu+HqiNANkBVq5b0lef+2qWT/yc7si/zi4w9zUmAz8cR2kxUiD7/epaNcbWgYZrJkCe8T28N+kFj/XOQopGR9xVbLHPY9CRDwDVZG+1Q3QhX7tIPw7aFOgAQswNy+tzuh/32WjUVw2TUQFMi87o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3200.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 09:50:54 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 09:50:54 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/2] lib: hashtable: fix integer overflow in himport_r
In-Reply-To: <20260408140339.798015-1-aristo.chen@canonical.com> (Aristo
 Chen's message of "Wed, 8 Apr 2026 14:03:35 +0000")
References: <20260408140339.798015-1-aristo.chen@canonical.com>
Date: Thu, 09 Apr 2026 11:50:52 +0200
Message-ID: <87mrzco41v.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0001.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3200:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dc2928-8579-492f-1168-08de961d7da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: c9c0eIrgvBkoOIOz7FUlhOBPVFASxkXZdumeCJTAX6yFzTJGa2rgzbIOP3R7Qe3ZiWKBgEs23asjPItbH+N0Un+0kFPwhXVXipYmU562o5asJ3j4QR2GshHxk7F7PfU00p8pDKRpUyGhoJDTdemVmGbCSe8stTEPE24R+gHACQIrFFhF9RA6w1raPTSKN/PDatVe5TpHQ0hzY2GvK5Qks3Kg741bHvab8hDOFcLAEQjS7EaFzECryYDXSDKQ2KCKTAZvyQPGaIqIZrm1K2+2U1Ft3AfVf41ovHlQbqz2guemx9M70RwUd6bqmccF2CJV2xqzTeSldWvWGE4FY9nJkit3DlVYc991R1GYWez9og79B4nVMqpnMYViNdrQbCF6k1oplLAh9Go+5rMoU+25NC+kxsaekoW1hSsE1rgEXJ/4Dpc5jwA8nhXyImgh8cquUZIgvqGnSBc2GQltKQ7JvSEeO7I5IDYeTsqGUDJwKOTLwAumdK5Yt6tAxsCkdte4bqT4eczjhi+ypNfwHlJabZ5S0YTyuJzGn4yNKsjdwBrGRC8iBZDm6R0qF9Kvb/HY0JgOXAyQ4B/BQRCNFyGLdAsguExc6SzB1VHt5NS52uNP15dIxMsb0yAoHidCWa6n7mOjbSinovsEDVfN0pq9haDtomJz0ui072McO1vS3558636jbK+g/4cmvgltAFgvzH75NSCrt4prrlzrU7PBFzgfvfiKPaqxSjWg+0mTwachRCZFweZ1JkrYpJ0Khsb1eSVlVK/apsoq2POx7QlW0EKTiYYzwhJ7seTAmVC8ZQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UqOI2o+97lujZJ5+6ysY3rid/srdyWJpvKbEzLd94fos+i9sDgUCtx2IPltL?=
 =?us-ascii?Q?LBEHT+zRbWYEnc6DRjAxGvA7Djb1vAHvcbEppHDWFtQJE3NEorBLwV2Fj+a2?=
 =?us-ascii?Q?FePVC9IFqeb2NchWRIxggLQlrDmibgjlafyaf4b1/ymNXS708B+pGAvu5ZUY?=
 =?us-ascii?Q?hwFj8C2Dwyx+tSZsPTKNj2phWZkPrRP19gmvG6GviZPFD5rdGQlCYihD3cB6?=
 =?us-ascii?Q?B4bVZ4fsZGaDcN56anibYWZeRgWAgZy7iyKMvPHt+/kyLojcuL8Yz+rWJG8Q?=
 =?us-ascii?Q?LWmpfzTpYkUzRa5dtUMsvJCPibDqJb1wtVQEfa6XBz6EIiNynkK5fz7AkGfO?=
 =?us-ascii?Q?YX8biJ5LC3R7lONAiahUKTCZHvsvx8c0qIsRXS5gNpEqTr2HM1VOq84EKpv0?=
 =?us-ascii?Q?EToZP8KibCkRFaF38r76CZqzmuwfso2VGttHGS0ucmXM1XSB8ab3NRRUwwXk?=
 =?us-ascii?Q?yaEtTMuaBLjahQ0w4y+hVxfjp9ova9ONN3h1tlSdZhRhUh+MsVSZCw9HCX6T?=
 =?us-ascii?Q?fS84x8Fl0uDDCySYoDK+avcWxMxlWZl9FiMFRHCadlQx+Pad1HXYaAEB70+R?=
 =?us-ascii?Q?aDzIp16nLi0A/wtSvCNvbH3lTuK2lQkhkOZ3flnKldLnzb3jrIM+3zg3uXIY?=
 =?us-ascii?Q?HwF+p+MJ9bb8FLSWTXoyr7KgsZNgxT9eRlGlNmj+5PgTc8iUEGqqR+PLfjls?=
 =?us-ascii?Q?XWBTG5sw4nQtJ6Hyot6XbooV6MeosRHjG+egrIx8FHOEeSd8d3qCMsFqFpss?=
 =?us-ascii?Q?4ruw3KuPk+E7wvML49a6kpghWmcJEbkLzJ9v5kEGK9ccw9qCuizsxIKgVvnr?=
 =?us-ascii?Q?g674qQULBOHUo/K56MMZfroH5MgYoE3QiOxe8d5kdsxj5J5DJ1W6rsS2gbmK?=
 =?us-ascii?Q?H2g5lIrD4c7fosaR2yLLlqe0EuV4dyjMs/QHR/PQgk+vpkFAHWVf+cZ5NJ51?=
 =?us-ascii?Q?0xldxjWDSNu9++9kisU1C64jrKVo0WBMOdDb8CNQbIPdKDBU/Nyvz+m+oIRJ?=
 =?us-ascii?Q?dL2KSkhdp34+6k+jQG7Kj2DYT3hGgyc8NzXMNYxVyuEs/hlRg8N72jO/kcgf?=
 =?us-ascii?Q?ZU/gB7A8XUf3tpCfanUiyKp6SZ9q/tYyJaxiWaxLCrxPtXu3Bb8/8cJTtGYF?=
 =?us-ascii?Q?kYE61q/KFitBIUrEXmHcgZTLW5D2utFCnEU19jJNrhJRL9db8X6NrLTaXLPk?=
 =?us-ascii?Q?DUqCHk4GBNH5Hsq793JlM844uWKmFuLmZaEJJlRizKSg1jKoa+sfaOMcqnNZ?=
 =?us-ascii?Q?zFtuUUcYnQqrL4O2by/1+tq5IFqtyfGg8SOaD46fQbGQTdoRJnG5v5vpjG8y?=
 =?us-ascii?Q?ueCbLiRah4qyunVUIHOTRiqKCx1lpLQ47IZolUgpYrs2OcJTTgsMWcavVgN6?=
 =?us-ascii?Q?EAIktvUS1gTjdlVAucC+KaTll2FFQuUOlxP7Y7GGpDPQs9cgcctp7lmdfEqH?=
 =?us-ascii?Q?0Zq4dHVheN5sgxHJx/MAVoNhJb3AZMErJOZ4MnLuXujWdbYuK/VKFWxeahL8?=
 =?us-ascii?Q?Fz4uJQ1joiG7gmU1BdpF0bbRVjgSD0t39B9fPlGBuJw3X6kIPJ8F4WnFFYj7?=
 =?us-ascii?Q?t2JMd7DHWmZnrZjWTY6e4Gs2tnAXPPml0x9mr3mH/IBs30LtwpiH6u8cYkkz?=
 =?us-ascii?Q?Vkm40Of/R8Qvk0DyIeIGClFOkFv3ez3qNQ9PIQ3Vl6Brpb8lsGgj4YOy3KJX?=
 =?us-ascii?Q?O+YzIpNb92MbKY/XnIT6pe1oEpvKJnFS1Df40zrbGaUqGGhVUFZHPG4cZF31?=
 =?us-ascii?Q?LNdL+hdM32srd70QYvoOj29qqt/2KJk=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dc2928-8579-492f-1168-08de961d7da2
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:50:54.1955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5dQhduxKF+FQkPA1kKMl6uVBP2UgC+J4AteMB4VIpZE5EnbiJR1Zja7kktF0xMD3oc/0qWpgL+0jFKe6E1AVcN95hj8CJWsa4nuB/roBWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3200
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

On Wed, Apr 08 2026, Aristo Chen <aristo.chen@canonical.com> wrote:

> When size == SIZE_MAX, the expression malloc(size + 1) wraps to
> malloc(0) due to unsigned integer overflow. malloc(0) may return a
> non-NULL pointer, causing the subsequent memcpy(data, env, size) to
> write SIZE_MAX bytes into a zero-byte allocation.
>
> This is reachable from the U-Boot console via "env import", where size
> is taken directly from a user-supplied hex argument.
>
> Add an explicit check for SIZE_MAX before the malloc call and return
> EINVAL.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  lib/hashtable.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/hashtable.c b/lib/hashtable.c
> index 75c263b5053..902fa6f3e98 100644
> --- a/lib/hashtable.c
> +++ b/lib/hashtable.c
> @@ -820,6 +820,13 @@ int himport_r(struct hsearch_data *htab,
>  		return 0;
>  	}
>  
> +	/* Check for potential integer overflow */
> +	if (size == SIZE_MAX) {
> +		debug("%s: size too large, would overflow\n", __func__);
> +		__set_errno(EINVAL);
> +		return 0;
> +	}
> +

Well, you can corrupt arbitrary memory from the u-boot shell, so "taken
directly from a user-supplied hex argument" is not really a very
compelling argument in the context of U-Boot.

Instead of adding such ad hoc checks that mostly just increase code size
a little, I think it's better to zoom out and see what this really
does. And this is ripe for adding a memdup_nul() helper (linux has that
under the name kmemdup_nul). If we add that, we can do the overflow
check inside that in that one place, and we can convert a lot of similar
users all over the tree, and eliminate quite a lot of #loc.

I'll try to write something.

Rasmus
