Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E7DE9B260
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4401B83C8C;
	Tue, 24 Feb 2026 14:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="HDKlH2Vz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FAB83D17; Tue, 24 Feb 2026 14:22:16 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C923682A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfB7jBgOMbKuceW/IyqmM9MmWFy+2/Nq7xvtf646rblH6aOwdSVIhJ9Pvr4t0Nt0T054AcJV1h/mW0dCCkll2+l2/cEcsrqM0ilTJthvCrML4KuL4mNMi02cBMOywQzOT045Z618bje1xvcuR/fwnxX1hMJOiQKsxrIRR6GAbnbKgvuj4+JHug9AngbKMQSRpngnpYh7Pc8nYh3Y9yzWX6T9F2kww3Fhet2w4Xo5wdOoD8tf4XySoUvuIoX3Gq/bzQZTwf33JA+sFBg0SJT2XBYOCiLZPioJv9DLH+tOevfieaNMBFcDihr1y8biZaN0p630UqWXmvdjfTjGeL1gVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUb0AaosElvrCwHy4hdHjuppXEXW7lkgb9css5H8fxA=;
 b=WeH9xGiY+eR3QPG+N5RUHp7T2gAFsMcEhaPyx01ttxa3TIOqtEVX5sdQPhw3jR6EKHiIGrpKXDDTb0S2e735fkg8PtTHSCkguwaK1xNr5CZ3nS23ak9uH68UFVWwCygoE4nZKKcUGW7GDXUYIlSEBOYEXp2RLUOs/uJ51eLIQ282mkcb2XmnU9LjEmBE2bcXWyc2/SLe9oBjH6i9rPi5g856Qf3Kf8RMeVM6stH8jHEj9livRdAEg38VqauwEEgkcMw1rmqtLYNYh5v3QXuI9cKUqJoYej7jNGwhuLWaJPw/bU5GIZjFCGK38WohW+Mfy01uqwfGwcbhbzO/p0mftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUb0AaosElvrCwHy4hdHjuppXEXW7lkgb9css5H8fxA=;
 b=HDKlH2Vz/+HVariBkfF3xdy+Zm37e7+V5qgBwvNbHXlCiW7urBf7beFWL5gA00X6EKkVi45GhQZxTt+OI2J8anb5t9574q20iICFJOLDyzzLygEFUNy2hz+3mj2le8hda1wPCpsyPUX7iWe7u8pQaQvidIHi6Q7PETFaqzy1wmaW1QbZpsYCeMgdIUODc/8ZJKJj1np7MVME/MrBaNHrLUEZKD92QBIPlDs64IkerQlOprX4Ye6RswTn8pr1eDo88WQrTREnCOyy1kZehdmI7jMTMk8pll+opKMdbWUrerp7O17B+uEUR0n6yb43bnpBYMOCbJtHQ5/ByygbH/rsuQ==
Received: from AS4P195CA0033.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::20)
 by AM0PR10MB3684.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:151::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:22:11 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::28) by AS4P195CA0033.outlook.office365.com
 (2603:10a6:20b:65a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:22:10 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:24:16 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:22:09 +0100
Message-ID: <c798850c-2736-4079-b8c6-8336552a4d25@foss.st.com>
Date: Tue, 24 Feb 2026 14:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gpio: stm32-gpio: prevent the use of the secure
 protected pins
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Fabien Dessenne
 <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
References: <20260205-upstream_pinctrl_stm32_update-v1-0-3a3797af498d@foss.st.com>
 <20260205-upstream_pinctrl_stm32_update-v1-1-3a3797af498d@foss.st.com>
 <1d0c08d8-4c5a-483f-b4f2-c58849f1113c@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <1d0c08d8-4c5a-483f-b4f2-c58849f1113c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A799:EE_|AM0PR10MB3684:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb22f7b-a643-4154-39ce-08de73a7b721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzFlbTZDc2hqbE52ZXRjMUNDMENDdG9Bbk1iMzZTUGRXOUhBZW1yR0VRMkh2?=
 =?utf-8?B?QklFSzN2Z3pIZlBITlAxYlhWZ0dtZW1WZ25kbmZDTldMekt2R1dmTS9ZelFr?=
 =?utf-8?B?NnNxd1pDYlY0dnpQNHN5N3NqUjg1ekMxZk42Mk93WlY0L2tHNWJHR1R2TU5Y?=
 =?utf-8?B?SDFUZmhCVXFweHVuQ0FkYWVmT053UnRiMzNDbEJjdE1LR2JFN3FzL3hScGRz?=
 =?utf-8?B?dm9ZUVoybDlTVWNDMWkwUUtZcEJlYVdIRTJaRnFKMGdOR3phdTltbjVGSWhh?=
 =?utf-8?B?c00relpBM0EwaFAzS2p6TDQzNnUyOHFIRzl4RE9TeXE3T1BjMXUyR000dzh3?=
 =?utf-8?B?cjFYQkFpeW5pVmt1cUZqbkxwSTVJR0REU3dMeEI4d29Ec2xjalZFTE1rbUZF?=
 =?utf-8?B?Y0pONlIwTm9xMXd5cXFYSjFLdllhUitZTy82TXB3QjdRMlhpUUZUbTNHMHJK?=
 =?utf-8?B?ckUxc1lpVlJnSzZyWk5EUW9zVlFjZmpRTnllMU9TR2dwS3lLeVhIS0MwTzBE?=
 =?utf-8?B?anh3VS94bUxENE5pdlRldWJYQ214emlEVGVudnRMbFM1K3ArR2RralBlYmQz?=
 =?utf-8?B?V0xYVVc2aGdZWThFZVRJQTZGWXAyR1E2Q2tzeS8wY2gxbkZnaGNKckppVjR1?=
 =?utf-8?B?WU5vQ3NjTU5xUWE5YnFsdFFJZHNZM3kzWUtocHdpZmplMzRnZnBsL2pvaC9C?=
 =?utf-8?B?VWxLWEJoOU0zQzl2ck5OSGNWOXhKSWZnY2MyaVpoZUl6UC9zMXhBMTNubFVZ?=
 =?utf-8?B?NExXbmFkWUltM2t0aGRrSEpSbk14Sjh2YzBWUlZzQUl1Uk9GL3VrV01SY3ZE?=
 =?utf-8?B?Tk1lQXppc1M1dFZPZHNMSHkyV1BiSzBHSTl3d01BMWc2TEZMQytsaUZIUXJK?=
 =?utf-8?B?blBPWjdEc0VQRnlBK2kwZTZtT3d0amI3ZUI1SW9SRzM1R2N0bUlmWEJrN0NN?=
 =?utf-8?B?dUExelZQQ1pMeDUyVDlnTDdadzB3WE41K2VDWTVNYVN5ellsWGk4VUgraXpY?=
 =?utf-8?B?b3NIQkRCbHZac1Fpb1daS2lMMVkwbkl1V3VpdWx5ck5yendJdWd6TU5BcGZY?=
 =?utf-8?B?VTA2NGFSbTA2YWZOcWNLWTdhZmxydFN1d1p6YURzUEUvMkRKNlY3bFp0WlRT?=
 =?utf-8?B?WE5GR240c1pIWE80SFNlRDhQT3kvUWlXY0h5OEZCSWR0N29TK0NsM3h3clY5?=
 =?utf-8?B?ZHRyOWZUdGNxVzFQdzdqOXZzWWUwVjVKdHJ6L1JZcmdGMWhnNTFCZnc3Tkt2?=
 =?utf-8?B?VTRHWWdvMXFTaGlzcXRWSDVFSFRoL010NVRMczAyRWRLT0hjYkxHS1ZPdDJa?=
 =?utf-8?B?ZHRlcGhhNE9pMy9Ub3p2eXFIWFZNQ3NGaGViayt2M2hYSlBoL1dxNzkxSTlS?=
 =?utf-8?B?d3krT2ZVL09YMU9LT2U0QTdVSzFQY0g0RStVUGlkMUNGUzRwdzFpOHhFSGln?=
 =?utf-8?B?TG9GUFBkQ3Ava1cvUzBZdlh0cHB3MkVyM2lBMVFuWVB1eVNUTXhOWWtJdUhI?=
 =?utf-8?B?eWVVMzQ1VlVSOTJPQTZVUHVvNnBYeVVQcVVmcWhMdnBnVkRWUytWZEZrcW5w?=
 =?utf-8?B?UUZmQmVyby9zSit0ZmZkKzdlY3oyZUYrWVVoVHliQUhDeDV4Rk5ReitHZXZT?=
 =?utf-8?B?WTIrU0MzWWpNajh4Sm1jZGhidVpqc0VHa1IyR2ZySGZKN0tKZkhRV1JoYThy?=
 =?utf-8?B?R0ZoWWVrejdQaFBWSUQyMVZTbm5aZ3Q4UkYyN3JkRmdOWGpoeUkzWHlqYTlF?=
 =?utf-8?B?bkd2TVJ2WTZhZG1vSFZSZmI3amtkVmEzS21qWXBtaTNnYlBmeDBBRFJWdFF4?=
 =?utf-8?B?YmdwM0ZTM0dLRVltM2hJMTI5WU9hSnQrazZHbmpIT3RBYlJkdHE1WUhVcHFU?=
 =?utf-8?B?UUgxQjlyZWVUTWFWKzVBaFJhMm0zSTFhYnFkTEJnRExNTEpES1o1ZDNBNWZ3?=
 =?utf-8?B?eGZoNjF3RDlzbWFTNjlMV3hEYnhDQmttTEhDNTZKQUxDdGJYZHdaNDdzOW0z?=
 =?utf-8?B?OFcxc2lQVHVXTHN2eFNzL0NXWXJLa0NueUNJNmh3S1pFNkxuOFpvZXB1VEp1?=
 =?utf-8?B?Y1pRZVpaZURSbVBHcVRiYnNjT1JFWkpNdkFVY1lWSTlFem9hV2FaTHdhWmE1?=
 =?utf-8?B?REJtQ1k4cS9GTjdpWTVjb2MyNExVWkZXdmpHZjFFbEhWSTlaWms4STdwRkps?=
 =?utf-8?B?Z09SclNCMHlGemUxL3VEc3RLbHVOSmRycWgveXZaNmpiTEthd1FiMmpIZ0lR?=
 =?utf-8?B?TkRIdGQ1eFBxSmQ1SVB3NEI4YUlRPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DEEKtvoPu+K7OP6u18lQ3/BAbMc8RsvsHvrssvADSQso40W02uEO7bOD/B10LGyD0xC0cia5F0nQSz4mU7PEIOTB+DHX90+JybL9IZLu/Cvg2Qa6G3hfH/j6zEEmeKQ9/xIBBqHqSTEJmN1Cr6ZGdngqlFHMd7ePOCKy6OeGB5Um4xiMP+l+JJDi7jIrygXoqmo2QpNhApGrzEuRoFoYukSuh2mKI0GgeLvY0QqmOViFuvUlTOqRkHtntKkWRL40gxqLJs1odmdn+ZQu1VQjxHdBShIBi0gXVGPBhxikDRzN6oLpnGoqz+KFmU3N0SFKQiWpBKridlmZAz9H9iqIWXUP9v+t7nVG8okD2H5m5n7FU3NaZps+uWUZ6IxyZBZP/ptIB1DJSHWMGOEXbNiC716h11MQB8Ly8RCM3ylKDZljBwDdP2rxV3ZBe8sXNawQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:22:10.1434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb22f7b-a643-4154-39ce-08de73a7b721
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3684
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



On 2/24/26 10:21, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/5/26 09:07, Patrice Chotard wrote:
>> From: Fabien Dessenne <fabien.dessenne@foss.st.com>
>>
>> The hardware denies any access from the U-Boot non-secure world to the
>> secure-protected pins. Hence, prevent any driver to request such a pin.
>>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   drivers/gpio/stm32_gpio.c      | 25 +++++++++++++++++++++++++
>>   drivers/gpio/stm32_gpio_priv.h |  5 +++++
>>   2 files changed, 30 insertions(+)
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
