Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4013ED1713D
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A817688E89;
	Tue, 22 Oct 2024 13:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bE4aZbEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90FB988E2D; Tue, 22 Oct 2024 13:43:24 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AF588E89
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRnoxy0OgTe9Epiz+H3WB9akXtPCddl9ejE7Rf861/IAghECwY6ogKJJVfMEUivMV0z2xwjZVfzCyrlqWexaM5+ujZ8hwVIO2F0bP2KpUgkOncL5vTYRiFNiVNshKqCWADvNwTJne3EXN1MDZoUlacqaMXnbhdrhmv2sGvk+SI7e8xt1i37jFYkp58jtiORfTEqaGRMiav911WZqSEKgFkMYW7UhDUb5of+I53u7cEDsqSuYw+qs6Phl1X/qATT7WX0CE9XoTP7MQmmd3n+x3vdHjZJPn/eM9cwYLbuHKxKPByL7ltv2AXEeH1rY5o3zrMmN5Jrdhg9Qq+5oh6d6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us6tZF9ikilQQbbHw0UNfItP4SkBAcpAG31ipKzML5s=;
 b=xkyuffDeJmGB5ZDsN+byK0gvhf+ewdIpa8eaWgqgj1oj3H9+W2nijDa8GQg82rqoaj4tyVskkJvDaTDfXyvsbvn6s0nmLWk0TWRA9KeRT/vq97fviALke7y1FW2N3IuOXKZnrYRR3Lpnfj0bZiOHA7WOTTMM/caw9AuBDixm4mq22Fs1XfsMTnEspkQcT0sQHlpFejQnrOfoG8f8v9OD/6k+f1ufCoLAuEGKNoXGE493wfAWTyu5OjUVCEgTlzmVHYT34mH0RNHgrUrDIUyrIFhauDkSCspc4vkmz4f49fr/oL5UzxiQci67GtfStwBBBjT1iT3hqYro2rMLlIoZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us6tZF9ikilQQbbHw0UNfItP4SkBAcpAG31ipKzML5s=;
 b=bE4aZbEgUStFc0klb32bzuToNDfvqRkmtGG3qeNBOgjoWmugANbhaUmfhCJ3/jbz+N9j7h0WmV/wXW/9TTEZJkeLwvYYFanNJR4CkzXWY5yxNVuUIhWMb32dnLkKDUEmz6NX5RAhosaRoNjnv4TC/9ikhQ36bQVxxmB+kPad3To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM7PR10MB3939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.13; Tue, 22 Oct
 2024 11:43:19 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 11:43:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,  Paul Doelle <paaull.git@gmail.com>,  Felix Blix
 <felbe@prevas.dk>
Subject: Re: [PATCH] watchdog: gpio_wdt: add support for stoppable devices
In-Reply-To: <a95685d3-50fe-4b4d-a6bc-23adac2a33c5@denx.de> (Stefan Roese's
 message of "Tue, 22 Oct 2024 13:18:24 +0200")
References: <20241002192323.632822-1-ravi@prevas.dk>
 <a95685d3-50fe-4b4d-a6bc-23adac2a33c5@denx.de>
Date: Tue, 22 Oct 2024 13:43:22 +0200
Message-ID: <877ca0qs6d.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0109.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::7)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM7PR10MB3939:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f9cde9-0812-4c9f-f887-08dcf28eb947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+CA95504SipjAH27jCsSMpFfrruY6RhBhYlC57b7Zv5kqntIOxT36xPXudD5?=
 =?us-ascii?Q?OkiWEPnpgX6JhBK71NM3p2hWXGae3li4CxKnSpstb6goH4/I7gHF04eSg7tZ?=
 =?us-ascii?Q?6xdkruRWBqJlvA2tHBs/p4XG+/rilIHOlS3RokZKKvNi3jl/yUo8Et3Qi0hv?=
 =?us-ascii?Q?PNZvL0peiD4MAV8EPOefQSeLRmpdG7ZtJztTUZnOEGIUV5nzdODZb9bc+UZ+?=
 =?us-ascii?Q?tR1m+xEFGCfuWt+tdOHp6mgIr3+z7fER3rS3rsu4h0ZDedH5JgyjcyRAQiUi?=
 =?us-ascii?Q?weRNxO7q8Ov9/q+vYPB4PT4DI2AQoL0CP3aZ6vEIFvEiTBH96xx19dFt5rPK?=
 =?us-ascii?Q?1K6kKZzgWlKpGPh3Xv6X6bDK2N3ODUvoM0wqcvRTkjpmE2nnL7nXrOJ/KwNZ?=
 =?us-ascii?Q?TPo7Bd27KuyxgqqQ+E4UWPor9jzLlq+JB7ho6iRKYyRyF0kye3B/v2fIK4J7?=
 =?us-ascii?Q?9mrILdpJAZAFYq8hijf2vo645k1fAWtLguZnCK4BD5edofUjoxdqOLKuZExh?=
 =?us-ascii?Q?8IL3jTIBPKX6/0Ww1g7QjBDezE8y7Tb68SaAMOEkAHfaBWa018ZJ8WAoQZM0?=
 =?us-ascii?Q?gEam7kbwgBEeF4jBp44qchiPFUtQEfzTlBhRgTC/KqQY/LY/EhiKFblfAln4?=
 =?us-ascii?Q?joofyoNrlKDHpPPaUkhqDTERcA8yikF8rokPsT7ZNIJ4WzNeEQLWu+ijwAnG?=
 =?us-ascii?Q?CUhq670PkteESeQlLQiCeQhSbd7YxShO3EkXKuk1BqNzqZVd24XW81qrawnf?=
 =?us-ascii?Q?NpZTXLqngkmAbHAG1LYNH79h1o1mmQJjJ4kiwr0TTlgiEaPlR0cn8oKI+HYl?=
 =?us-ascii?Q?ZEz5uIqhmKMKp5r/iEm0GxthtvP//qud/0rnhj2lZi1tbwdiTkUIjQmb9Kvw?=
 =?us-ascii?Q?cjdP1dwUZhOpGJiC4uRE97y8pel5gpXkt93dKWLhSLU0Mf/WTPg+AnHMMeVV?=
 =?us-ascii?Q?av5X+7rhwL0AK5bEYpsiFrQOX5XhRMK6YJ8L4F7rx30FbquMUV16rbhjsSwW?=
 =?us-ascii?Q?Ifwzaxb9U+Cki8+as6EMpQpOxYoVyfRwONYxxzxnGGIFZ0CSowoYaYbLtq5+?=
 =?us-ascii?Q?pKXCbsSmC1bW3mHcb1XtoMLXxGgKGZ00jtLXD9afATp76/fUrpnMlc2DhguT?=
 =?us-ascii?Q?NO724GDn7Ir7d2pSRfqJKNbfB2D9DlkMzli2fWPRqiy1V6lx6TQSoWFHL6HY?=
 =?us-ascii?Q?G24tpXkgB5W3B3hniCoNBJjIXWnOueLewyBwc+Lo7sOtS3AhJesc7WK44PeA?=
 =?us-ascii?Q?/bbJAJyIkj28TZ2FFaovq/FedZENU9y6hnPCvHzA9mgQbXRDqUB69XiBEKu+?=
 =?us-ascii?Q?ZJ0G9ea4MZllzC22HagYBlQpaHjYBkOyLvRkYK13tGyUMOKWsLAHjEo+LPoY?=
 =?us-ascii?Q?7NbXPVDYPd5IV31lbPOUEwuujDOi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Sz8nVdhhGXqK5BQX1kqj+LjMUOAZXDQlD07autr83dKwE2KrqVtV0sGUjVG?=
 =?us-ascii?Q?wQD9MBPawQeLjhKOdZgHuSgsOm346d3t5kyL8F97AxCYbaj9C44JMGNRE3Uh?=
 =?us-ascii?Q?BMl2L+YkddAlrS5PBHF1rWoJ7IZ0UuPxCow1d3WX/Nq1g0j7akBrndc27JWQ?=
 =?us-ascii?Q?rZODLTaJo/IKrcQ57vwTX7qGgE1i9A+N5qv1VsNEnk6UvKD7tZGnKgaCcIst?=
 =?us-ascii?Q?oHHT22DZzGvoohHDrPhLHFUf2Fpsdqu2o2a8115IOAOt+EntE7gNy69PDQe+?=
 =?us-ascii?Q?YVCQvsyr+JR2YzBezF37mcKCa1fcqOFgE9e1W3iGbnxjzZ9mjz6b7P5Ag21I?=
 =?us-ascii?Q?l0j5UxGuvyMn7uarGZogoy7OCPSvldOEEpVIEcwDCNgxY0cZ8/aBga8KT7UX?=
 =?us-ascii?Q?ClpTkVp7QunZ9dllz4RfXX75DLPV7wZuc3QTY6Xhe26X9ITKD+d4f3osULLx?=
 =?us-ascii?Q?kIAtLMBS1OYjKxJMwp0r45Vrj1WkpY7uUdFIrf2ascMSEVnPhcg6JWUiLS27?=
 =?us-ascii?Q?YunLDSzOfxKHopTYTRPUnUdzXd0C8H/4KZ2kJTLyvL12UqkYL/AaweliyL7U?=
 =?us-ascii?Q?0Gj7N77QPjlv35oB4YxLYo4YbiCCUfMmorEZedfn5dnu6m7zxZYZ+XWrJFKg?=
 =?us-ascii?Q?5bupWB5830N6mgDe0i16cptIxa1lQURPi99IrjTxG/TPMwGFkTJNKR54aj7T?=
 =?us-ascii?Q?zCE6H/Ssqzq8AlqzadnW0HJZgMj91d/p2toCSkiVNdNT3qDSeyGM+0YAKCbh?=
 =?us-ascii?Q?zL/LUy73DScnnHQco1tY3WnUgWCVxkv/8JBu0UYiKHMafYWs84vaowcWV+Ld?=
 =?us-ascii?Q?FRaGcQL2nScAgSx4gOV5XsxL2S9VmajMRtBIUsc6AlAfy9la+JXwf8dHQTN4?=
 =?us-ascii?Q?vYEqcPRhu5jsy5RL7Tie+f6kOKeBL5MNkkLjtyfAZHpDeeycW+n1HhoB1veK?=
 =?us-ascii?Q?TXTKnlejzmM7Js5PjcU3QQaN9tm9lBBhz8bKbOfLYx0FkBDDCiP4qenwQUk/?=
 =?us-ascii?Q?NWo0GeQNU+AZPJwI9uvluO8PQjASdFp40yirSce/Wrm60heXaFh/iZT09+5F?=
 =?us-ascii?Q?ahxl0LKGsmreKM98z/cm9upeApWl34ANF0VOzk124eofszXz0VrqLAe9PlT9?=
 =?us-ascii?Q?iXCu299/gN87JdDsEtD4h0kfe7FRAYkQGE4WkF5mYpZgCVg5R6LuGhSudGd8?=
 =?us-ascii?Q?x4G/BGLMbsj1aOoiLVw94AaxC5rEsA3b38HgPgcRqmPQak+xE6aWzDUNjmy5?=
 =?us-ascii?Q?c3Pz8RYZMzdwhD+Dj2lqtODjUZ6iGJdgoHHW/nVkvQSU57RJDXGxdUGe+QvA?=
 =?us-ascii?Q?TFlDPsCiUYLABSDKq6qxqFqlvbj8866UShYLGWkIg/PKFX91mPp6oMtD3hyC?=
 =?us-ascii?Q?FQ3CWjj2ieQWIyCicDipReOBMqrGatUb2J03/pVXysopO4L1tvFdJnOvhKQH?=
 =?us-ascii?Q?OreR4O8258c1UsowalbxmoSZOsSJfQfV1ky2GoEVxMYvFO3HPbsnFRqodKAX?=
 =?us-ascii?Q?XpJIDlN3ABJeb8jexNvNO9UNCvdlK2xJSU8G5msKJ8InYxRWl1ZlcGBUPZgv?=
 =?us-ascii?Q?614OBeP5H4MwBaQVfWI7fykDaFeClxiGYWWfWhInKVZtZO/AOw04IIbDQMJ+?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f9cde9-0812-4c9f-f887-08dcf28eb947
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 11:43:18.9075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoCjQJMvwXey90gkzXA41jrj9IhbBHe4qLFJ1wqwRmAeHRzDphlT8BU9RTIEjQ6xYRR12ZN5c1tIXvZzIvdEOKawkV5zixqAe73QNVmV8lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3939
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

On Tue, Oct 22 2024, Stefan Roese <sr@denx.de> wrote:

> Hi Rasmus,
>
> On 10/2/24 21:23, Rasmus Villemoes wrote:
>
> While running a CI build, I'm seeing some sandbox failures, most likely
> related to this change here:
>
> https://dev.azure.com/sr0718/u-boot/_build/results?buildId=375&view=logs&j=db15d90c-51e5-5ca3-902e-4c5d558bba82&t=64917d2e-7acb-5ec4-6136-40fc146da71a
>
> Could you please take a look at this?
>

Ah yes, sorry about that. The two -ENOSYS in test/dm/wdt.c should
probably become -EOPNOTSUPP. Can you test with that change folded in, or
do you want me to resend?

Rasmus
