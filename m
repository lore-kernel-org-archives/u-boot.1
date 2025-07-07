Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16133C83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6976831C4;
	Mon,  7 Jul 2025 22:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="b0uACQ8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208F3831D6; Mon,  7 Jul 2025 22:39:21 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9B3831C3
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 22:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEqQo9iCU5xPyyqLWJVca47LPPxCajMOXCMtcVyENOKImkdz2BDntEPMXZuoAm0Kil84JxYjjbepmtfS3rLNl1UZDC1yaNwqgvlv6bxhC5ipupGSG6Gs2yVgd7O2aIfOJLu9EU51GBYDlPhqxsjN/rJk3OgrbuP8QTSYBWVFWA7Lev5SSvS6POvFxyifRGNN3Ot7unYWmkYnZG/IkYc6U3iWpHWg0GCeFuK1D3m6IXTxmlbIL3M7gHOv83U8AnfFqEqSfyMrfESza2DT7Wfu3A3F6+Q2eYgjmn4KcQg8sJQ+1+wF24e9zsWYG2rcKVj8+7KT9OiqwwTYWV4RZDk5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Pnz6LQ+k0wI6tRUsK8O6JnfMYLp0SXJrvqpgN93QE=;
 b=RWkuKUAu8QxlWinQ7CoI+nl2WF1o25BHrHXMXZSzTDwZwTEM6rLq/MsaVxuGtRjwU7o1IZ9JPs1y2cwJJ8O5l6fLwRwdvlvCQssdDq9LmcrY5oXZaObe7KsWQXqVQD1AMoKd5a2BfPzBeIC5BTYw8a9EoFYndt6+gah8nP880H4qcomm+uLPY0Xlfp/291j7uXVAP+HVFC2fIk7eZejQadtO5dUw4H0BoEX+IGbgunQkKsj7oNn5QYnYdBZlbzfXXBNSMvb5P2k2bdbIbKhraAOrK9ZRldgOT8uqBadZd+Zro81s4/Hn6cIVVKwxhfsPEiOtjKIW42ZYr78ddhTTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Pnz6LQ+k0wI6tRUsK8O6JnfMYLp0SXJrvqpgN93QE=;
 b=b0uACQ8cYp49rNoHkHyeCrLuy1nvcvHSNKWk4vIagUwTKMU1OwGff6HKjqQL5ZJq/uzPSPbWr40hYid1H7W6BN9wFvXRCqIqn6zDXjofOuUVs9zWaEO9Wuz4UPbC1ZpU2hi88vvIstVrDY7fcigjkWJJCg2RCYESVGqlVGVm1io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM7PR10MB3143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 20:39:17 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Mon, 7 Jul 2025
 20:39:16 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] integer limit macro consolidation
In-Reply-To: <20250704221033.GN6424@bill-the-cat> (Tom Rini's message of "Fri, 
 4 Jul 2025 16:10:33 -0600")
References: <20250703113730.531225-1-ravi@prevas.dk>
 <20250704221033.GN6424@bill-the-cat>
Date: Mon, 07 Jul 2025 22:39:14 +0200
Message-ID: <87ecurwxal.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0045.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM7PR10MB3143:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcb055a-f0d3-4e40-4d34-08ddbd965743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jpUGM3VFM0lM9d68e3kvr02Q/FTuJ2XkZajqyyzP/DJfYJqN0T00l82GCHAP?=
 =?us-ascii?Q?c9LrUBWfLUMc8Z/onD2nDxvT746v0VCuynl2x2CqW52egZb0Mu+Su++JWjv+?=
 =?us-ascii?Q?pJjkIgRkxYHbHpHV2E3drmhzt2SPy0w92Afq8eWlZV8RSr93lt7J62Fa/t8B?=
 =?us-ascii?Q?Fys3rNYlyPoZjbB6jHaFb+v+xM9n+bqrJKnLYPLacoGiKC6tAbAxSmdO9rPC?=
 =?us-ascii?Q?pBpjc21ur3sOGZIfGAWz4w6220nAhrCtFROejUulC8V98Hq6K1barMZCwDoi?=
 =?us-ascii?Q?6X4niHgjoRdvsaT/WQBDSmVQ+t3mf9Avn0NMh+y6x77/WwrHGKa61Q1NbXXu?=
 =?us-ascii?Q?UKbr2KJIWnpELM8KXqJeR2mO03LqjxC+qaK/TgTdaiA1HKW0nYZgZ03W7CTH?=
 =?us-ascii?Q?DvYC25MOsLBslJnarAs89sxv14B4zATvlRUEA/MwLNUDcSWETakk9urJ2yOj?=
 =?us-ascii?Q?Oy5IGwBI7NIGCH7T8779DchoEfz330XkBzBFL1tt9URvRLvgbSImVme4cPkZ?=
 =?us-ascii?Q?36MM6RFe2EKSUpkZ3dovdbR1F9hBSEJDgmVP42Dvu9PB7WvzubLw/pRQns9f?=
 =?us-ascii?Q?VuKhfKsf6TfCsRtLQIzl1i67IJB5HgYOa8OH9C4yXQsljMgko4rwKSYqjM9J?=
 =?us-ascii?Q?wjfKmCaau+Bth9uD2BWgK3FXQ3S+yObZfy3EJ8AVN1IFcfXPrs62l1l37LNZ?=
 =?us-ascii?Q?jXh0+klE99HS+fAv9SfuNsc6WLmvnoi91VnNIfdBHzOMrnaZRY3ZQJYEGA/N?=
 =?us-ascii?Q?fGtW3y2EghIpZNfE7yEUNiyJX+vUJrHoNcSY03dCDSBBoLZ52/O/JZejU3LE?=
 =?us-ascii?Q?nUQ5O0UNC1r+Mj+/vlmV2fq03P9ayEjfRM5AGBD6P4rrNVr8hcv8ijELafXR?=
 =?us-ascii?Q?ddRPtEGvOXUVO5uHcT1lvQd+j09yv2uAgq4dIbfoPkhVg5WNKhcgBrS+pOFa?=
 =?us-ascii?Q?t5PK3/hj/MpLFfF1gKfNbpAlsxI9zYees65VfptkVzSrt8KxxCVSUIjTslLY?=
 =?us-ascii?Q?J9lr3tNba7vdsxRUO74J/EEBIBbcMrJ1aF3yA9DWr5D79DP2GLd+fSZEZcBW?=
 =?us-ascii?Q?UehvNNCdsGKYDctj8ZU6qUhByHuP7a4eCgmXNAwFiqTB/LkDaoZU1cctN0L6?=
 =?us-ascii?Q?o/iTzn2Qoncj0awzPzXS56zTaFY3xszXl/3rc1vbvinIqX63wG6fgljJdY4i?=
 =?us-ascii?Q?rqUW3VVDbXzWTaC+VxpinmG1A7gTL7z5U6an6rcvcVUsREdUkgYTT3myWVgH?=
 =?us-ascii?Q?pO556qi2rRzWwWLspebCDobWlsxtFQjksGhUI//s6E4LtMCP7cEjx4u+m1p9?=
 =?us-ascii?Q?3n16bCkAvi+y6GdLOuVvJ/Cg8v5f3XRpFieoh3/nUwpiIUZaVEw81qBhSlIA?=
 =?us-ascii?Q?TyPkBL2sebR3hbIOxyIS+CI+Is143ul5Ma0fb9bClkq+ZkMCA9Qg5Q5CvzIP?=
 =?us-ascii?Q?wc1R2aG/cpuyMFNC+IQ4nWA4IrC5sSEEGExq/hmQ5diGmC6RCg/lkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zWT2dEWd3lr36/WgxNel45SR9ZiyPadp72TX9WMvk8beyGcLyG5Ok0o/84L/?=
 =?us-ascii?Q?tNU4XyAHHz7tA239Og+xyP5S/5i4Zv9gpwBleDnmXQpIVn9UlBZxDqaI7+xz?=
 =?us-ascii?Q?pCR++V1K9BUsmgr+RKPdVcothEW/eD9xqqtMAb0TOLSirkx5H/btUJjngQ2c?=
 =?us-ascii?Q?qpl4so7fpGwavtS/obMHZ0oW2P7lny5HVQFV0nO3c60QUuw+sjWELfHwC5g0?=
 =?us-ascii?Q?9AhWs8boevblW6M+oGGKsiAkqrfkeRgyPg49yhTOeVfIZsZtoYsfXWASVoXK?=
 =?us-ascii?Q?m0HoorNx8INtxeZ2Hb1xOhTds5NylWuSg1uMCFWQP6KzhQEX7dlgFMyvsiD/?=
 =?us-ascii?Q?T6VKspI0YcCxmUs0lbHgPwkAS/8uZvyeKTashht2UZu8B13spY8kqBGnEr81?=
 =?us-ascii?Q?MsLgQot1+d+04mYFSuf+ByvOWx6ejtFPLe3mbq+HPpRfD81uJAfO9lLME4aH?=
 =?us-ascii?Q?+Zy48eIwGtp26O2DJiQeYuIv8Oq4WIcCd+lvpmHd79dECa2zd/d886zLDRzf?=
 =?us-ascii?Q?noAfkiT6diPxObmyXRWE7roS5dvDKGFhKrISDFMOX/u15oMPoIhlzLFZwFcZ?=
 =?us-ascii?Q?psPWrsiZR3rYrtCBaZibFnRajpIgo+ckNwv8RiQUIT5LQPeDJgwWuFdUqjVy?=
 =?us-ascii?Q?ff5ywbK0CyqNWYxQ7vDYpMQX2f29JbOuEXv43KukIqAZLL64OUbAw1I/zyg9?=
 =?us-ascii?Q?dJcBMuoEKcmD1eRucnS3iGwkdiDGmQTpZZ1wr3Khu3d78k7aKbEYHpu039Ng?=
 =?us-ascii?Q?ndEVlCyECTTOIcIBBa30OyQ8EuUzxctpoGyh/lqy+9SzPt90JFxfuisFVwmr?=
 =?us-ascii?Q?SNE6WugOcuS+SSOJ7tjE/v+Axg7N7eFOAQ2HcSyn79RhdDz/9zD+YChnV6ou?=
 =?us-ascii?Q?vHIqcPNvxA66YWTMsGFidWHMAKqHEkmTe+11h0nnRxdp3BVp56ss1diJw0/w?=
 =?us-ascii?Q?/+AdSgADYzjXKvb1I4VxfIQX9VCVrwBzMeEwMkg6SyO3w49tYarp2jJJjxL0?=
 =?us-ascii?Q?lB/g0qMakkjJl6FxMFCvyxXg+ED2HJkADQX7gL0UYisPCUSFPD7Hj/EtZyC2?=
 =?us-ascii?Q?ZhEotFGtJPEDT9oevMWad8i3pEn5WH0Vcs+/0OdOQLcaKoC/Vt3QirXMvgy5?=
 =?us-ascii?Q?Zd7rU9nWFoLaW5+R9wCNsHUf1D6fpdoDloWIL1ktXC6BF6t5LIEQzePcpJ3c?=
 =?us-ascii?Q?P+LEzoXz5t2fWCEZRAP2O78B+P8tiZbko24tdhoD/MgHRvRMYqcxfSb9Fkh9?=
 =?us-ascii?Q?FLtAoSjhQWIdf9BZPloglosMUO2nungn94EVWj3JmaLkNniS7nkuISYs18cq?=
 =?us-ascii?Q?rZGjZGD/YK5Fpvg2iGFukveo8aEOw9rxIpTQ5VNbFwaAUUprK1uD1zQpZO7X?=
 =?us-ascii?Q?2GoNM2ZkopdIc36UTvbBLSO8PSGunIcMV1HcDDAFBlu7ae0dWvThArMB8yXx?=
 =?us-ascii?Q?T7DJM8sJgv19KiRAgrZqX88x7fkGuw/xYNa/NgNg9d7Z2PPBYmQqAh3tkiPZ?=
 =?us-ascii?Q?gdff3sV6Utk+b4lypz3Bm65uh1z0cgR6O+zDbhNfkmbcnX1odIl8nQlI0loF?=
 =?us-ascii?Q?I16LxA5yfJv5zwhqKlDlxBhOuwzA8pIwoIzoIrgKjtq8LiLzgdsUOQaMRQXe?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcb055a-f0d3-4e40-4d34-08ddbd965743
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 20:39:16.8826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cldDhS5ZvoJyATsuAMGIFBGElJdCNvS7Z9j9xd3JkhDJOkvrIIh872p3dSkgG1XgdsjcQbCULMMrsQ50XnEUgHGI+nSGzKnJ0XydL7a5YWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3143
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

On Fri, Jul 04 2025, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Jul 03, 2025 at 01:37:27PM +0200, Rasmus Villemoes wrote:
>
>> I was bitten by our limit macros not being usable in #if conditionals
>> when building a standalone app. It turns out that the work to fix that
>> had already been started by the inclusion of the mbedtls library, so
>> it's something that people do hit.
>> 
>> Let's finish the job by providing suitable limit macros for all three families:
>> 
>> - Standard C types, char, short, ...
>> - Kernel-style fixed-width types s8, u64, ...
>> - POSIX/C99 fixed-width types int16_t, uint32_t, ...
>> 
>
> Thanks for doing this. I assume you put this through CI?

I wanted to, forgot to actually do it. But now I have, and it found a
thinko/typo in 1/3. Fixed that up and now CI is happy, so just sent v2.

Thanks,
Rasmus
