Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF920CCFA1A
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 00:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0741D8399B;
	Mon, 10 Nov 2025 01:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="msv8UYqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6642F8399D; Mon, 10 Nov 2025 01:33:20 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F02683993
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 01:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llM0gX5JSlL2JMkQs93DJSYZcix1IowqM20EvTWXDUKdd5k8wFRrrMn8mSR3xNg6/GqjlgAxGLv5QDEy+LqBmk2AERyC082S63AaeqdAsv4juPHpdc0uapxh/fV4lzzhRYrDoCCwkjn7omRtymJqAmuhOXrGrjVmBEC2oGvF0XAb+UPYjKQZ4SCOS7cWmzKRLvet6AeuSs4Oty1SyEuCCURTH9Bg7W5rJlW7a3Dx8dL6Rw4w3GQLvSv1/U3UDG+tzzrjDC6mfncmlTiaGoI7fxZAPbceVQeW2maSnbjV+2/qgfQY8mzrgocei13yQ/BEZDNHXKg/LWB2pGuLwwofeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdE89kKnApNjp+Sz2xbfMe/66S7xMmflLP9FWEvFb8k=;
 b=Z1P0LD4RAhLh1lVwn8c0K2gdK0rDuljtR/fDZU4Ygn2FZeZD5rDPOuOWBfFgzC+eqQiunY4Tv6Lgs2HM1e88secNOlQRqAi6qBjg+je6PyfQzeePXGnVid954Q5j7Nzg0oK93lKbNwRJCS1WMZwP3T2nCiLrj9oGpxuQOjWLs2U4qtN6+bLrIwCcoL8s/xJtGq9h+/4c0oX3eAbN4PfV9d6tin0YCZhKhOmWp4oRmPp8eWo3kUKPpFos9/U6qPF+YIb/8Cta4ki4qIDnbBrYnss5DsDV6THbdnP1XBYLs2ayWsIqHsv2wmd1ZOg+c9EOzSJm7CjpW0gxtv1xliXB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdE89kKnApNjp+Sz2xbfMe/66S7xMmflLP9FWEvFb8k=;
 b=msv8UYqUPzvTGZX1sXJ3zZM06a7F+W8lTho15BUaF16mxGxMCTM4TmpRoWt13oWcS1S0zS8FGYHAE7PJRB/5OCOrEqFViSUU0sMkn3MyEnULT+jfEvGb8nCTKZAOBJhzMKO+Cws3QGXe3SQYyi8E3K+jvXyL5By2HlbBj/8Cyz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 00:33:13 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Mon, 10 Nov 2025
 00:33:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 0/2] 'part name' subcommand and some robustification
In-Reply-To: <20251108150152.GJ6688@bill-the-cat> (Tom Rini's message of "Sat, 
 8 Nov 2025 09:01:52 -0600")
References: <20251020121100.1742812-1-ravi@prevas.dk>
 <20251107201927.GA2243313@bill-the-cat> <87pl9tcry1.fsf@prevas.dk>
 <20251108150152.GJ6688@bill-the-cat>
Date: Mon, 10 Nov 2025 01:33:10 +0100
Message-ID: <87ldked8vt.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 503686c0-e7ba-4a4a-2c16-08de1ff0bb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FHU/pDOlZrNvFgNUkE+nnB12/y6Ge6VXO8R7Mi7hoCugSO9S/TzCWJrA/ZhR?=
 =?us-ascii?Q?zDyttN1XlEp9BT5q1eqz4PZLc6wiOfjbmJbQrZjqLDZGQ2dDN/XvaJ0sSjy2?=
 =?us-ascii?Q?tce5y0haitkxSnTtG2x+YaDkLIa7+QhVqVUxxbSS+E3JupUpbZLD+886BfuQ?=
 =?us-ascii?Q?8oN/WcKrnnahLxdUfd2Zcu8koLCCsXtbau6t4TTUHBHicdH+/hKfDNABI+cX?=
 =?us-ascii?Q?DapPQGloerSFNIaaoCoDGM9iRig4jLbbUI+wLsN0YZo1n8eCh5EIuaRUb1kx?=
 =?us-ascii?Q?MEkzTFr61c5MpubRyGeIhO0Mdz9HrQAk4TZ1j2YrjMKjdlYwIsNuGJiepNGS?=
 =?us-ascii?Q?BkkV7UavQfdLl/NsjzNinvOq5ZbFwIyBn9bZ2IcNhSMVraLL2WqPIbaMSQzc?=
 =?us-ascii?Q?6uZSWEhPYxs6PaHOWmhu8KLn8U10sFhDusyHcrR6yd3jZV1L2AmlF0ZRf1LV?=
 =?us-ascii?Q?tGTk2+HvJ4pX6XVo8wkom4cKUJBeliFMDlqHFlWRirwYCGELipKKFk3Htgwo?=
 =?us-ascii?Q?6ay6iR+6sAwYa4a64LtUEv2DL2dOHuA86Fv5BJG6iSqGfkvjskvVDmN+oRps?=
 =?us-ascii?Q?Wzj6ENEtJJRhD+C9fL5nvYW/3q0Y6/tbRIWv9MiGbSPNnvEll1RrvrOnQLIY?=
 =?us-ascii?Q?s1T5BjPRzda0/rTJW9vpZA9psmpNUrFGIaJpuDiCGbQLiGuOuxZDFHWAivPF?=
 =?us-ascii?Q?dmoQW25DD6t7itJoeIHRN4b2fpODeTYwUaSJwJOdFbpSkq060nEt1YHy2QKB?=
 =?us-ascii?Q?2sQ00R+2AcXZIRDqJATmTYCk0cNKCiMttDt5uEsmE/++x3+0qgdXSbrSpi4R?=
 =?us-ascii?Q?90ukgTGewx0w4yGnckb8hrl+b7SM5tTJNnyA5KggEOXEMwJk43TGc3xy1bAX?=
 =?us-ascii?Q?6S9Lruuu7WiUkSnZ+5E6oi0eDXkJIwXkYGls/EwszvJQSJ6wdhQjGZJcK+TT?=
 =?us-ascii?Q?e9dhNZSFI7kfqS6bX6uDO9C9eDzBE/8IIb1gxyxO+CUEZctYsWC5/Q2cRMzz?=
 =?us-ascii?Q?vGbEUVFEeIXsWNm4WO8WInU2DR4egss6F2gE+j+CZ0ghiFYA0P4TG8mGgEma?=
 =?us-ascii?Q?VXk5N0Ss5+Qo+gmBHiWHoPVFE1zdf+gBIUs253dfpt9LHevuMcaeHTmhbjFt?=
 =?us-ascii?Q?2WkrYqemrlrBGYdu8TdJWb4AuJyeGw0UYNTr5kpJ535xzGx2SFSNzj7F7COh?=
 =?us-ascii?Q?vOAgOb/5HjrUVNqC1Iso2bUHA6bzB2R87jeHXOGXjNJY3Ltu1M+fH60NBjUS?=
 =?us-ascii?Q?4j65bYANUL7J0i0ZMrxpHjSm7tfb5WFDoid9PmuDBICXLG8IEZ9/gim3HBll?=
 =?us-ascii?Q?vFxxY5cmoJAmKztb6xujSeoJc2CQ/vNAy22vpnD7gaMsc/o66nXIUTsx76oe?=
 =?us-ascii?Q?+3X9FXI20cOF2oAE8O5MKD98FS88UiLxsGPdBcv9eto//fgPXW2btwSvlAUz?=
 =?us-ascii?Q?BWWLbaXAFXZ6jLDgpdDxD6xDy32kN+k1zOBXhkn10zm0F8iOZeMBLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Myj5dPSghgpShF2LsBHsYSEHFHODz5QnusJKehiTW9uKmGDrPAtN2kjSdoLG?=
 =?us-ascii?Q?IJJHUQGw8U42aMBezVDSp/miGgofjqs/6nVdVybiXQ0Kh5DEZbTwBpEznDJL?=
 =?us-ascii?Q?93w47gXtPBRO6X4OY0eYiNh911lLhJWDs95m+MOepIL4ASHJRSBNHxEPCE+l?=
 =?us-ascii?Q?EN1r8nKNQgcvZGP8XDArslCxLpM0HBdETdZQ5mAXpdSDPBmDreUa8fsIR3lG?=
 =?us-ascii?Q?PtOZfVor40WeYEAgeeFtZcUqoXlzhYdyibflcfN0MuWutavw7jHW8PqIF4DD?=
 =?us-ascii?Q?nX1CG+QWOMIwiXNHsJdMzB91+5TesTkB0yzzJGnk7QAGk+7Nv9tcmexlGsK7?=
 =?us-ascii?Q?gpLmclruabNzk0v4NMiONGoyBmYr8Y4dJLi4KAXpEbTX4icGuTNxLKF/RRQi?=
 =?us-ascii?Q?rLHS0W28fBeyFBUYbKcUGlVmXVDP60Y8dqUHbUnmr4g/FjB7hztSF1ykNqtO?=
 =?us-ascii?Q?tyJDDWaOEPLGGzANhCeqbepdXDSMfjEgamfopSTuajuS2om0t03GY4ELv3EL?=
 =?us-ascii?Q?iUm2B3LHgY3Fg/VrBKzG5WQ64g6PmUIGGXmtiZ9uAoRg8/GPZYF5hY5yjo3o?=
 =?us-ascii?Q?x4dE6Am4Il9lLg8OZES5yBLIL6lEwe+8Iq/Wt7U4RvnBjpbGwRsGjmbDvFvg?=
 =?us-ascii?Q?PjuJY05+3eGfOvlfJ4b3IRf/W3y1xwWygIupbHONkiJLsxrd+9+ThV6slvZL?=
 =?us-ascii?Q?5KMBVsm+HHLNxSgr3N+hA/jU5881BnFE3YZstKwnTjnCKFSREcYyParaO13z?=
 =?us-ascii?Q?YdaD+26t/JW9sLZ1LXz1XlOsSBxsjcUDW2wymXCy746TUcBw848yr5bkZGJ1?=
 =?us-ascii?Q?1hrRXKKCle+kC2s3/k+1KrqGy+90d/cSs9U8NlopqTXrtz+mpR4uRB6HgCkL?=
 =?us-ascii?Q?QQNVSIA5DUPLI+6X9fdgemIBdr7eBidHdolGA+w+/tzCbZPyJpCC0BwCtpJk?=
 =?us-ascii?Q?c2suBM++Xw9rYCqmCtD9cnu61lkrwK2BnNEb5+XA2z8zBrtd5WYjtVxcV374?=
 =?us-ascii?Q?CR3xQnthM6fURJSDj8TFdNQzRnNQ4vWDGt/oRTJ5Kspl6vbrWmAMjGWxpBB5?=
 =?us-ascii?Q?p9mIqYYQflRkC1ri7seuWce9GZpBzsR2ZskIUxyP20K/ErU5/xP8sG4+RM5o?=
 =?us-ascii?Q?9kcUMt0T8qwIqDSfHJdF3kk+HNpGTiLGG2YwaSqPbfjyJ5BaUjwm6on5IP1g?=
 =?us-ascii?Q?75qK5vXCR/767opKs6wxnCvSwZxOGBoS387K85DLsSzZ59Io+B+/1h+kKp6h?=
 =?us-ascii?Q?AYA+QZlo1tTMowMxJRZFQXIP8+7jYcpbu62WUHinoN3NBrzWv4cAkfGDADX4?=
 =?us-ascii?Q?Rlr9VnMDWsd7dc079GMYoVB3CRRMIfrlgA1/VL4PBVnBS23R0wVxBQi92FxF?=
 =?us-ascii?Q?OYTR6tEWTGQYAqFQ39+aTqyv0tNquqLLFrSlffZwzfQzz6IeZ7cwa2cH0JxF?=
 =?us-ascii?Q?T3pfNQpmTNAGYr49NkslxmD5J35e5qAuSgMBpHIPi04AaFafv+I3NotNVZJW?=
 =?us-ascii?Q?6CMIePKy+xgt4xoLOPxCvXJNw8U30m7wbrELgHBrEsPpZIORQ6OkRFHLdvLk?=
 =?us-ascii?Q?vsOOZYNMAy6p0CsVrytnbxcaJDa5IYg6rmdDRKm6wcaALHlc8HAABZv/gW1m?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 503686c0-e7ba-4a4a-2c16-08de1ff0bb65
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 00:33:13.2017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9Xzb8EV4S1GcXAqXlyGApiP4D/YxWFfGFbwj5oWLCjIPO1G5p6PUDUP1mwtCrJ1onmoBH/4sQpFTL3OxIuCA+enwVBwBJLiTzm8mZ3Oi4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6563
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

On Sat, Nov 08 2025, Tom Rini <trini@konsulko.com> wrote:

> On Sat, Nov 08, 2025 at 01:02:14AM +0100, Rasmus Villemoes wrote:
>> On Fri, Nov 07 2025, Tom Rini <trini@konsulko.com> wrote:
>> 
>> > On Mon, Oct 20, 2025 at 02:10:58PM +0200, Rasmus Villemoes wrote:
>> >
>> >> Implement a "part name" subcommand, mirroring the existing "part
>> >> number" subcommand.
>> >> 
>> >> In the discussion for v1 of that, it came up that there's a bit of
>> >> inconsistency in how much and what one can assume to be initialized in
>> >> 'struct disk_partition' after a successful call of one of the
>> >> get_info* family of functions. The new patch 1/2 tries to consolidate
>> >> that by making sure all ->get_info invocations go through a common
>> >> helper that at least always initializes the string members.
>> >> 
>> >> Rasmus Villemoes (2):
>> >>   disk/part.c: ensure strings in struct disk_partition are valid after
>> >>     successful get_info
>> >>   cmd/part.c: implement "part name" subcommand
>> >> 
>> >>  cmd/gpt.c              |  4 +--
>> >>  cmd/part.c             | 16 ++++++++++-
>> >>  disk/part.c            | 62 ++++++++++++++++++++++++------------------
>> >>  doc/usage/cmd/part.rst | 13 +++++++++
>> >>  include/part.h         | 16 +++++++++++
>> >>  5 files changed, 81 insertions(+), 30 deletions(-)
>> >
>> > This leads to some of the bootstd tests failing in CI, unfortunately.
>> 
>> Do you have a link?
>
> Right, sorry:
> https://source.denx.de/u-boot/u-boot/-/jobs/1292597
>
>> Also, how exactly should one run those bootstd tests? When I just build
>> sandbox_defconfig and do 'ut bootstd', I get 130 failures, so I assume I
>> need to do something extra.
>
> So, you want to run it through pytest rather than directly, I find:
> https://docs.u-boot.org/en/latest/develop/pytest/usage.html
> And then
> https://lore.kernel.org/all/20251029143346.1320868-1-kory.maincent@bootlin.com
> has the full rather than partial list of host requirements, if you don't
> want to grab the docker container CI uses and run inside that.

Thanks, I think I figured out the problem. I'll resend properly
tomorrow, but this incremental diff should fix it:

diff --git a/disk/part.c b/disk/part.c
index 194eccadb7b..49a0fca6b89 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -360,8 +360,11 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
                }
 
                ret = part_driver_get_info(drv, desc, part, info);
-               if (!ret)
+               if (ret && ret != -ENOSYS) {
+                       ret = -ENOENT;
+               } else {
                        PRINTF("## Valid %s partition found ##\n", drv->name);
+               }
        }
 
        return ret;

In essence, the problem is/was that part_get_info_by_type() used to
translate any error from ->get_info into -ENOENT, so we have to preserve
that, while still doing the -ENOSYS thing.

Rasmus
