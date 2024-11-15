Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B94D68BC8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 15:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD1089251;
	Fri, 15 Nov 2024 16:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JmjGN83Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F5C89326; Fri, 15 Nov 2024 16:22:35 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6169F89221
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 16:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOw5HWnP5I+3tcjw+9jnPtLgl3X4guHS40XECWa7eW6YnnAoTsVBzFXB8VvOYJ4K+REGkX539muEA4DTcEfESv7l2+qABTk/gMZz8vSvompO3J/A3o4e418O3Zo5FMdALEDb/trAKRvDk8Rolu49v9SacwunP1K4Nr+Z9QMkO0c0UiQ6EZxUlR05KqLZZ9i2f7yVkGyBemzgQgFiDQs//+FabnFbjejH9TfJ3e8pA6z08sdIVR9ZFt1Ql/W6qgbo9w1Rx2+7ajdtnmNbhrM47YnYko5gw0OCWGmsoVQl5Me/Nu7DQ7ONY5GPjCaScfF7VlhUMf1CPYk3rlo+ZfP2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFrp6hND3oe8gbsD/7yY3qdCFkGL6nHE61A8A5byc+U=;
 b=yJCUtWlZjdC2FMCzFgbYoiD0okPnSUYH2g7edv7dSAUDURm4umFaVcKRd77fkzmDToZHvVVWPAiPqmlNCHu45gmXxAhZORVH0XYccUVPIfKHg/3xW100Hyv3A3Ddmc0kYXriJUprHQ4zb6/5py4daYhRnVh5terJ7Ft1Fl03KtIsmpuwYFDET6kI9AE9fuawj2YeQ+t9oTv/WqOj3Qf2H2SijPo+GsHzVRDj2ql5x0XSmlrEX2ENqt61NijIh0/hQ0sPz0qzMu17HHhFgGy6HCJAFTjWyEuFJcKTigeDdcZ7HBqSDllh1jWDS0Ea1WaAd7a0RtfwDEHPd9YsFuzz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFrp6hND3oe8gbsD/7yY3qdCFkGL6nHE61A8A5byc+U=;
 b=JmjGN83Qj9BqnXM0TTAJmaU/jt4Lx/EyM14uzmERKVrDrzVgZvXk1zxw/QuYgoZ4nX6qj5oS6Ofec/QDwjm3R7v6aczjnzMgNmbP3aW3gd6AtlMpD4SGul+1HtXfb5MtwA58G4f1nSQ8lcWJJq8PnQfLjhM5SvZ+n+S3w0EAQKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by AS8PR10MB7182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Fri, 15 Nov
 2024 15:22:31 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 15:22:31 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Joe Hershberger
 <joe.hershberger@ni.com>,  Ravi Minnikanti <rminnikanti@marvell.com>
Subject: Re: [PATCH 0/3] teach 'env default' to optionally keep runtime
 variables
In-Reply-To: <CAFLszTga-7sdukCdXJ+KXEtDMbxPYjN+NvviVLvtzO1T8MHkBA@mail.gmail.com>
 (Simon Glass's message of "Fri, 15 Nov 2024 07:21:01 -0700")
References: <20241030213404.2894247-1-ravi@prevas.dk>
 <87y11mn4sh.fsf@prevas.dk>
 <CAFLszTga-7sdukCdXJ+KXEtDMbxPYjN+NvviVLvtzO1T8MHkBA@mail.gmail.com>
Date: Fri, 15 Nov 2024 16:22:38 +0100
Message-ID: <87h688msht.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0054.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::24) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|AS8PR10MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 65636066-375e-44e6-fb84-08dd0589526e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wIbHKVmIdvP0H+DBf8+IvoX/dfZrKkosSCcb3riK8DzSIhQH7hXlDmzGdWsc?=
 =?us-ascii?Q?K9gHL9MBsN3fIo7UIuopac9yWTj7BB030QeAUqQaJiDvCwO8+Cx6pUroZDmi?=
 =?us-ascii?Q?xQO7Nwz8ALxybXCLXRF9QH88J2uLzLkdMNHSWNgYR/LjImuBbMEVWU8JYMHn?=
 =?us-ascii?Q?wMu7dJh+WE8IoqcoCeR+SMylfJKuW1BkDqq2pib9e2PCuVWHnffFdeGQb1es?=
 =?us-ascii?Q?vgCMOFl2vAA+CRnkYXOoIzQq4Acx+ABQi3H9nWXrkY25IuDcFhsNNl9e9Z5P?=
 =?us-ascii?Q?YXIQOriqfQBr1QXCIEZpphavUUvsmrLy2tpr9EqVQ+AgYICfXpO2QQD4lWPa?=
 =?us-ascii?Q?yGaaFPNSaFJHiSuWDy3lxkRVaA4osZ/40z9EiWj1J+QQWqJHrXKUEe2HEoEW?=
 =?us-ascii?Q?dn/kh+mjgqp8HSvG8obS/v8orE+EN0siE5qY657zDxzgPXvlMtdEs2X6un2F?=
 =?us-ascii?Q?aADdrgYNv/c/1j+R12CeKjf0t3Qfq7XIoQb3vG4XbGkCBysHK3A0ApY9mtCQ?=
 =?us-ascii?Q?XUveQZurSNSXirwIzFvvMkPCgsRXH5nVx3xb3E/CCkzDs6FiC8X4JS2hikrd?=
 =?us-ascii?Q?LyPz9xt6lhYN/uJsBjF4c1WoqOax5xY9gx0X4RbMdulvOTPfVAAF7Vf1z56o?=
 =?us-ascii?Q?/8D1CdBSpSu7z2rYjq5y9HouPklOp4Q54ZMUJtc6hNVHO0995AcR1Qjy3j1t?=
 =?us-ascii?Q?6Vft3a3J0J+4eSz+7f6xiPQVoRJhh8vnkyq60OHX/3v+ne4+g8QzF3swbMhU?=
 =?us-ascii?Q?fRfcdrX5/HQwWeqHm48IlrWN8gnbsxzbXdEEYt0V/VPN1Umqtm659lgTRhlA?=
 =?us-ascii?Q?xZuHmBEKZ4LOnRUbKfZ8TwQ2CObPPEHRiP+MKq0FJlGHc4kvkb44nT4v00Pa?=
 =?us-ascii?Q?xozbLyOrm83sfZqpn42egFk8rUC0d/yRT5uiDAzhBVzgLjcq7AdxGxT5TwEU?=
 =?us-ascii?Q?hI5bebk2u9r9tSOxhfFzW2/cIW7Lwv4a5SZPCYTlwJdRwsdrYh+0zmWkbugG?=
 =?us-ascii?Q?W+E3PfutV9YVCZ98Getgv8L4Q1wEypzTYT4bA10J7tbbsICKE+fzI3y/EzyL?=
 =?us-ascii?Q?Zrhu7aEs+6BKIBPDD0/c/KRd+loXpN91KMcWrXUuG4UsxdUXqduswJ/7U8Ym?=
 =?us-ascii?Q?mHGi7bzcZ3ujvlmwGdo6s2uTLThPYNR6TRG/4KXfHu/iwZnhQIdMzOBOBFpW?=
 =?us-ascii?Q?+TfibBtYcjxXY6x1JvF6rr53XfCFMYev4u5XEUElZVmyv+QoGiuXRt4WvUv3?=
 =?us-ascii?Q?jjTt+xEbz1mEsw7Ebii2956dVdYvDDy7G0zNHTzPhMOjOe3P6rDJ3uTxBeMf?=
 =?us-ascii?Q?VJEv9JHCGF0wjW0fRncwAwikDEmRxQlLgh95UCdVqzH3GYHGjWIOS5npCkQN?=
 =?us-ascii?Q?NPJBMPI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t3wD3UFUg3DJ8AhNEuzW6uwBFJhSLXNngfnFaBzL6ZEpYzTaa3HUmEIQsEAm?=
 =?us-ascii?Q?kkH8jNQIGORSpO1qxaxAvZTzOAQtop4x33R2nLXa3Hywj4y0IH/9g2dCQMlp?=
 =?us-ascii?Q?kdVKv7TRJRkrSngLPI+DIKplWWSFKLJtNSPPRc+ck0Zz36fJZZpcsMAKVDHR?=
 =?us-ascii?Q?Z1mZx9Eu/9WBs21EHi0lD7QPtPm3S9XpOjjNgRy32Z1eFupE18p6PWjLEYu8?=
 =?us-ascii?Q?znzAZ6pCiSOIdo4llv7vvx1jx9HNwlADfkM5oABwGVfc3ClTeJXfAligwW9U?=
 =?us-ascii?Q?+vF0h9leF4sGX2jt1WQl8i8ZTgorJzKmJzAA2f5yPzwgFEaTMBLK8aKd5sGe?=
 =?us-ascii?Q?FSmlm3VeJNwbWmlRqd4fduSzNSTaMla4zhcuyztig94iHkOIdALBaPBM9IIP?=
 =?us-ascii?Q?egzQmaAnrWWtmRKYgGjj3EBkCLrS527doFuH2AWlg3qc50lpdY7Qebvvv3vi?=
 =?us-ascii?Q?9AYz3UgvMo2nBhI7aKQeZmwT82NhEDQO14Jm8VelctvA7ZBkdBZ896SmDXv8?=
 =?us-ascii?Q?JMcCc8Eyi4AVagvhvSe3/TqN2zJuExHsSshbysBdwm/SJfXL0qpIGzTbN0Xx?=
 =?us-ascii?Q?cnQBaW9YWYbo5YgZEWPOdXwkgv1nOuhaY+Xh3l7dCO2qMMKyucD4C1IgAlyQ?=
 =?us-ascii?Q?XkoghzcBu5tpAUsDWhcaFWdMQ3l2Xzfm4yiKBO1RjnuXwaHk5dMyPn4xoRaB?=
 =?us-ascii?Q?W+DA9A8uqTFadvyaUTAUhxU5TBDEfSBheUelnBSvBY86KF5McnEUJChVAFQi?=
 =?us-ascii?Q?6tGE2sZAXAFTFrEWdHxMa1WDB9ILwOGbCTd+Oe8sf8qsIVE3glJkPVtlnhkx?=
 =?us-ascii?Q?GhaUPupFzcFUmp2RvsbxrK7nD/HU3JydBVCDZkpHuydImuo2CWc46W7Msn39?=
 =?us-ascii?Q?qYHXv4iYsCckod0cGsTBPuFvcnPxTTWQnqEekt3Wyh2Fddcj1EgytLko8/fZ?=
 =?us-ascii?Q?bmcHWYIlqdQQ9Imf7s/jz/gGVf8bFAXzrVJLeIMY4CrWYDzgM2/2Lx/MBl/q?=
 =?us-ascii?Q?6hKBYVz6UZTXdfpq8OP1Q31HbrmSHGZNhLIQlqog1DNkC9p+X0fUPQohhdii?=
 =?us-ascii?Q?VWfkb3G8LaeEQiR/k9yQFmyiy050KrM1QHwma1YTZ4Y084dyKL2jrzvrhVAN?=
 =?us-ascii?Q?dG0EZ7oazzjCDNE+ckXHX2Bv/xxJctULmPFc9ZtL32HZFz1yA2ArzlQzujOV?=
 =?us-ascii?Q?oZjYksMBDxEGpYL/jOWPlBwIBLNFj4+TMfmL4z+cJVB/hLwxbENGgJHPLD1U?=
 =?us-ascii?Q?J6/jb1t2lnct66wGrxxK6GGuldav1DetS2QpYh+sUMvxBVL68uBQUJzVHKeY?=
 =?us-ascii?Q?08s1oaTWUhdH+g3fmNQTUbOcvtsmx9yq3mGjVllhK7Uvj/ZvOUC+EHNHs8ZV?=
 =?us-ascii?Q?ggLhoDgVdzr3bLlMhcrs+SUJN0L7HIfLyId9AW0ppug6AE2XFWWOX5DqiKly?=
 =?us-ascii?Q?0IFGNpNvltddusqdIdE9uG3xqgyihenYF/lM1tmJxQiXkxfEV+W0AnFmcaG/?=
 =?us-ascii?Q?iKJ4t6pEpdRISrQ1udyQ0ndxRbKdxMypz9bmGMVkPFKPpj8NtCfPTEMWgq5E?=
 =?us-ascii?Q?Mad7gnKsKwtu0gvyyHw7sX7Jq4L5Fy+BaURdLwafxDnHR3chujLKUeLlfozV?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 65636066-375e-44e6-fb84-08dd0589526e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:22:30.9796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlmFLNZQw9tbenMX0s/cTNNISw4DCb9jN0gBN30ApcqH+2auG36cX1FdURA/BG2+v3mQ82fIrXRlai/cBzzfBKjQu1rw8eL+szUyUfbvfkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7182
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

On Fri, Nov 15 2024, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On Wed, 13 Nov 2024 at 15:32, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> On Wed, Oct 30 2024, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> > Doing bringup of a board, part of my bootstrap logic is in U-Boot. So
>> > when tweaking that logic, I was bitten by a previous completed
>> > bootstrap having left a copy of the environment on the device, which
>> > was imported and thus overrided the new logic.
>> >
>> > So I thought, "ok, I'll just make sure to put 'env default -a' as the
>> > first part of the bootstrap logic so I'm not bitten again". Alas, my
>> > logic also relies on certain variables that are set by C code
>> > (e.g. for detecting board variant), and doing 'env default -a' also
>> > eliminates those.
>> >
>> > Looking around, the hashtab code already supports a flag that does
>> > exactly what I need, and exposing that is (morally) a one-liner.
>> >
>
> I didn't see the patch, but can you add a test?

That's literally patch 3/3.

Rasmus
