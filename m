Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658E1CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5312783942;
	Wed, 22 Oct 2025 09:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="semt59SJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEFE832BC; Wed, 22 Oct 2025 09:13:08 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C76882E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmF8Jjh4k5l14GbGULzUCUB9bu/S4pvaltT50GLk0AYSBrogm5a6wXHnDPXfIcWnQcBh/MWXdQpJr9KCFf2ZLQULdGxNQFjaekAla4ylJhPZp+dIUak6qu+3F7NMjKp4ZvMkkV1+Wmuupr+q9EFAwYYzf9XUuDWWtriSqKQRv+1I6wIbzlbVA4xYd+4DbsOpMP+XioT9yCLuTfHKjrVaim38A1RcPoLZDU637z585yFfQcP9lwbX10Sir2KCbl+YamxEo+QGhMJwFyvD2MqzbXm7vV0qGThpzrAwO3ccODgiz0afq8lU6QdS2Tzgo/XPmWGBE3Jione1q3NTZwe+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohN7cJfkiXuUtRPztJOK44/2UiynqfMI4+ylnFUhE3c=;
 b=Scu/cxx4nIurPMZUejEgqQ05k/Q5Ux5xtcxBNPmCtFvdjyIeKrFl8l4KalTCxrIb8AcKJZOp9QE+bZi9e+FMlI5Pj7ht5Qn9wymXhDAaiL8qONlPS/w1IpIRSs+UfS/LuOjQ4RwgY/peBN8ce7W1maFWL2nebcU9FYkkojvRdknsu8Mjv3n4MO0OlH9VWb4sPCXUJP28h+GNFMJqAFJbz9qKE+r49rjKbNejzsn++ZA8Gw0fV7UJz/kpeBMdK6mapbbIwqcSe2yjJha1030Dk/uTm9swOfnhDJiC8AfEg56OknT7jRcoxzg6O14sSwq6Z8pyX4oJRei7fm9J604nRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohN7cJfkiXuUtRPztJOK44/2UiynqfMI4+ylnFUhE3c=;
 b=semt59SJIyrUGB11/HV9mZS/X4sXx9LrOhAabpKLOY8QNfqVxPi8aJW6uPOvKmnWu0xaR6eJy0wBPK4dV3Uu7grTnLatfoIAVMqVl5kToyyPC98FAh7mesrTE6wQQTQKO8NqurmD26nzqDL9t8P9gPLE7+uvasFESfs0GiYuHetvydGM0J4NQU3i7RhJUa8GeQt231zgeT67jEp+OyJhvvC3zmlFk4iCjY/HQ0hTY0MqyOfoAO/PT0XuZPFmKenyeFyYEfD+nTbfkjnvFb6I/Nr7bBbihizpdC0QGBFIVzNA7jQz/uTP4oGBIFMgtaaan8Cdkc6ZkaZLXkod9SfH4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11326.eurprd04.prod.outlook.com (2603:10a6:150:2a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:13:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:13:03 +0000
Date: Wed, 22 Oct 2025 16:25:17 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Henrik Grimler <henrik@grimler.se>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 3/6] power: regulator: s2mps11: declaratively define LDOs
 and BUCKs
Message-ID: <20251022082517.GL30163@nxa18884-linux.ap.freescale.net>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
 <20251017-power-pmic-regulator-s2mpu05-v1-3-91cadc0f4156@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-3-91cadc0f4156@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11326:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ab9cae-8bec-4dc9-01ad-08de113a7116
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n/TbEQORyKGV1Z6Y006CDUTtKX3k9jU925Kd/iG1L+XwGr+Op0QGBQ8iqKwu?=
 =?us-ascii?Q?7v3v+3UzdFzr6duEbdRN7YCHW+PuE61dZJisk5ap1qZLWdZZlDs5P4tPlp/N?=
 =?us-ascii?Q?6hNZ+uVgdPuzLvpnF0qOIzEUeg2Y3ZtqWcKMS9NxBCsdDDh+ouFiVBevHS6w?=
 =?us-ascii?Q?JYpk8aTeiQi8P06xUP48lX8B4EEK5/dHpmagKLVKw/mpwurfXnXEYLTBWRCk?=
 =?us-ascii?Q?d9Ucd8dDrCafTQ/nD2agPOnD8ldhrsZrByJ+GfXeWP5LQCESO29+a3/R8SXf?=
 =?us-ascii?Q?I7P6/1a2ddRWeE3jbuYSkN77+PEJyBeK5F3hhJoWwTnR94WnBVc1T3Qy6rel?=
 =?us-ascii?Q?aM75mF6rMOQXrgH/r6sDS418XoEec9CwE2qUUYZYnpP3lV+iDzZxr/82qNjt?=
 =?us-ascii?Q?xStPBQn3lzP9OkeEDi1xvOPQOTAXVLhI6Qt2en9jArI3xhPmWodJokr7BhQW?=
 =?us-ascii?Q?kRMiFka45DQHmL75EpO1U/nWjZqCKjP890BFwkAR0lHM9YdRKNBcnJsvpW52?=
 =?us-ascii?Q?gXvDZl1JEVVhqnJSp6OTR11sOl42RA6+tug2TEbeFHjfSUEttVD6iiGjVpEn?=
 =?us-ascii?Q?oWtZHz5+nLloShhLEjxPjpNDRFbATkcJE/UEC1dlsCZ8WMX3DrCZzfs5dR0K?=
 =?us-ascii?Q?XpiL2Nv9xH+7KRJ0eX75wUtbFIHH9TjpLbfvjz+Za5V0/TdisyxnkX9Rukvl?=
 =?us-ascii?Q?UOvS2gk5reeH81eyzwDHrx7XFqSpQTTLoO+vfmiDehF94dvMzFxCTA6TLoVA?=
 =?us-ascii?Q?/2098wXmYx4Roi3a0m74/wrzF+ine/44Li7XZ9M6WPRk2d3AL1s2fcNOQ6+P?=
 =?us-ascii?Q?/vs5cEo78/1boq492ZDMY5PvzCpejhDYCXcfhqpxE6rNx8JlJNTU5fTfoFDi?=
 =?us-ascii?Q?jKATUeSZ8dGzwtiOnTDuxWF2EiS0LDVk1raG9FvR6LSkZwsb8iL1L0pd16VC?=
 =?us-ascii?Q?RUm/Gt2nRg8NsqNzEconrKDHYg32BroYRhvPAgEw9TIKMVEcYsdBQ5i27hmV?=
 =?us-ascii?Q?OimAOY96db93p2Xx0IuqgbxoBYTwjakdgpuvuGjJdFut+gwM9cEcUH/Hyxaw?=
 =?us-ascii?Q?GcTlL4MuxzkRQLRxGR0r0R1GdO+kPP6ZzBKTm1djBaVJEJr20noilHNXRwHA?=
 =?us-ascii?Q?HHPGySkH6J05hkdrM/+Rzjg2h16gNta6mJEvclYOEUHQdnKNozR0QlcHDaq/?=
 =?us-ascii?Q?ck8XzLreuPSo5mZ3gjkiBBmJW0/w1UAwpb1agvfSEbjlCZ5Q4y6eHMisH6aT?=
 =?us-ascii?Q?ahhZnXJA7XocX/YppICh2ZFcjsCrg03y+mhK/+bzImgRHSfpGXobDx6e53k8?=
 =?us-ascii?Q?RjzYLkdZUM6gLchXIK0fKerpCjssGiihE2/V9eMSATNvfbhz+ZDX3Oq/wRZG?=
 =?us-ascii?Q?o3LgR1PUPTWTOW5EKPg2oNImLZcnWcjYlQRVjDe1Bf1f2UettWEHo02hK4cv?=
 =?us-ascii?Q?8b5Rij+qi29diIQVPu3NfHzDZL1L8uBasg3JaZ+rzuFLRUuxlhrIc6Xt3yEU?=
 =?us-ascii?Q?vAeTaPKEyDXMVF+GHmMgZsruF8HC0JNOAP3k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AjEH0fc4d+xiHKO8in30yQp1oLFXDCdHNuaNCHjBjyoEhLwe1BMhXJHH+Ams?=
 =?us-ascii?Q?Kwl2z+v105vIBJh5IDzLi3EC+bBVQMJCM+c62g9+Yj+cPRBYa4aEl/ZI24fe?=
 =?us-ascii?Q?IxhLrwlOd7s+vmojzWbxc3w2J8dta2mny8nChCBxU6LJ5USGyIWNumstaUef?=
 =?us-ascii?Q?0XyhJIBZIiFh1ScTJAHQTuQhfCSnsK7glQ775haM8YTJ4miUB+g9OKH+11i2?=
 =?us-ascii?Q?lHfPhLUKjUAtFkcEsaK5FTZHszm17uNZsUAr7ULYkoR0iY5N4u21z5Q5yPyg?=
 =?us-ascii?Q?G0ygwDeGX6XA8/MCyWiCRqjkWw3euqXGwnRrBmS1Zcm7M2/RL0DBi3iUCd4G?=
 =?us-ascii?Q?M0hmXIE8X50Q5a9bsrrhGBq+2JmFs0GXwxChr1zVgzZE84GYUwq98iuEcmAl?=
 =?us-ascii?Q?GrACJvPp/xZFXw9qfl8q1I/IH2JOIYn2Gw6IYE+j3XZv9Z5JyV9zJcuvHRmR?=
 =?us-ascii?Q?kJbGnLHy7OWd7rapOORJKF6f3APcoGkszCk3RraWPCV3nxPH3CenH8rFdOfg?=
 =?us-ascii?Q?L80XHswkEZEVhnYfGnjrcGYxG0GNnSr8F9Qlus0bSRuOqDMsVjy7BJVH/je/?=
 =?us-ascii?Q?3MfmkYu2MhTTiWCcU8wepi2XxSDK0qegvKWKKkymkLuo9DImhdFXwTXxwYhu?=
 =?us-ascii?Q?ctfIAxLe8c9JaU1Nj/jBClYAz78uRjv9K5wOzY1PVX6mGfDn999+WExMZEa6?=
 =?us-ascii?Q?eVC7MLSed2unwSTPxszQ950WBo8wcSwxHWcLY4IfRZeSk6K1+BQNrVHCQiZa?=
 =?us-ascii?Q?KlDto91uY41hFWlZbf4fYRRF/ktC4DKcuaSmxmzLRzYbPn/voCOygoZqc+/s?=
 =?us-ascii?Q?21SpZSVgkU9xcXTyUIFYyFe6l8wZRZ3ZnfeDNO+JqY7HlmWgfIoFXnRmRAqJ?=
 =?us-ascii?Q?XnBOa2AflXV7MOuFIQIbCBA6KVi9iy4K0V4iH0Nyutiq38GSolZCdORuxX8x?=
 =?us-ascii?Q?g2YZpDs3jPhSTwd15D/PEZOOYjbPyJX1x2JXD5c2XbDBDA+ZIR6yPM6A4oSX?=
 =?us-ascii?Q?Dhf6R2XCfrXgl/o8AR4IyAeb0XCDSUQTGQYgf/GYAtncnVCtpgouVI/Phv1O?=
 =?us-ascii?Q?AIFq6QJ0CCsaNOsa1DNYRnJsVbzKJHl41Za+hXFeAHl5MP1y9XeGzcz831Eq?=
 =?us-ascii?Q?GtpHIUoExC1wykLDwyv/fPrEESLXwLR3xPqXFnBtbXm2ANJMbiPntdScCC4H?=
 =?us-ascii?Q?x2gO7hX8eyrCEPvyu1KZoXqtB5e6k3/2uCEYuYvTmljVf5WKY6o7OBhRlfq/?=
 =?us-ascii?Q?ul6emoVpayOP32SNe5opzVbAdmoKUCMeCVTB+b2jmBqSW8mwrbzCeNyWHJxA?=
 =?us-ascii?Q?m2sk7yL4ex1L0qp1mx9QSCxCAdnpU3tq1Evf9XJTeNHmeMENnnbyG3JeMNY/?=
 =?us-ascii?Q?Ek6Sf2ZUpILowPvFSjqzNgFMN1mD9EIb3nhYTP/oFd4WsPUbMHJQfUFSvXEE?=
 =?us-ascii?Q?3PrKNX4hlLkbAjOYnU3Tl5Es1v4O6llORDqv+XNxevUHlW5e6eiRTDkBNhmI?=
 =?us-ascii?Q?RlLv0L4kA1u6X/YwuVKiFuJiMRKw7DQzAlwPjhS9wK2bCpVSVqpSOlB/3kdo?=
 =?us-ascii?Q?M9MjvkBWkaNqmwiTIkyqHUIDSuHbKJrGszIp8MX7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ab9cae-8bec-4dc9-01ad-08de113a7116
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:13:03.9097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aviAGr/huNuJOp0brfEAl5M3il3Jwdfbji+5QQPmsejDfnUMxb+iXLFw6Ci1z2WciTbH9utyZfVARHcQ9I6jGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11326
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:58:18PM +0530, Kaustabh Chakraborty wrote:
>In the Linux kernel driver, all information related to LDO and BUCK
>regulators are stored in descriptive arrays. This also allows multiple
>variants to be supported by the same driver.
>
>Define a struct sec_regulator_desc which holds all values required by a
>regulator. Create an array of said struct containing all regulators. The
>descriptors are designed to follow a style similar to what's seen in the
>Linux driver, so comparing one with the other is simple.
>
>In functions such as s2mps11_{buck,ldo}_{val,mode} these values are to
>be used, make necessary modifications to pull them from the descriptors.
>Since multiple variants have varying descriptors, select them from
>within a switch-case block.
>
>Functions s2mps11_{buck,ldo}_{volt2hex,hex2volt} and arrays
>s2mps11_buck_{ctrl,out} are phased out as the calculations are now
>hardcoded in descriptors, thusly, it reduces clutter and enhances
>readability.
>
>Two macros in s2mps11.h, S2MPS11_LDO_NUM and S2MPS11_BUCK_NUM are
>removed as they are no longer being used.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
