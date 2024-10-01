Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27736CF64BE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6B1891D7;
	Tue,  1 Oct 2024 15:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JK5pVtQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C38891E0; Tue,  1 Oct 2024 15:43:26 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E06891CE
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 15:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKreXgifBBc9sp30f4vySrww7BTfEK0PUYTuuEKxvIMpyvaCl+zjDJKIFWtJVdrmDMVxBCTPowDALfJ8PzfNijalJKuOF+PwIUEmJUgAMDEQ2AUatytOSPg6Af+y2M4dJy1xkpaJEWVr6V3K6+bft5OmxR0eLo/AQsH0q1cxRroOcXlYfjNf3k39uMsud5xsMtJqSgfX6d3L/m+OMBS1ZFdyOOQNZJPtEh8ZCipcHozANU6cCRiYOvAy326E3oLxeCykD2X21zMwoHQP4OVZsv3sPIlakMlTNwjiCJOzuk+NQoPurUwer+Pj7kWA4t0IbR8v4Iy9wMx2rwUhIYH4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMaAOyAAxHIj54sPQAVyZTBWDAHVmUI5TB93aKvDmEQ=;
 b=K+/pvsSAL6r+pzb3zMtd33T2Qqdh11EvcFm9puiYitkZJrdRt2LoHz1B2dZPF0+TBIpuCnNXQfIu+K1+qMxXAG9R9QMI5G97OFUtavsnfcXebx4j6c2H3gMn8s6bPfXs6VyJ0i2U/k89SOHG7luCibMv8rWlXgGPtM1wSuR+SRF2+AKhkbQ9KmX4B1cUEaRCbV1byfDkEEB7+Sbv6TxLT+RzGXU1IoPV8Dzz+LDq/DDJ7C+ZuHHIEZXgoHH7IgUvonAWRs/k8MtTPIOkmPR/grdR8qKZwTNBUINbDqFZoGeUy3PpjgrueVXTc6xxMpANH5mJ4SxuGrNb7eJFBRYUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMaAOyAAxHIj54sPQAVyZTBWDAHVmUI5TB93aKvDmEQ=;
 b=JK5pVtQ7xc4IiGgNGMZCoo3kwuza6zWFJzilOGH74epssaW2rRpX2dBqa+62cBQSeB4VNHfkZS9fvEsoR2XEO78AMgWTRpHLEr9gn5ZmBCFUu8tTtWmBTbAM91VlWVHABg0N1Yf62qhDTqgN1/A0+a7bA6AA+4jggas7Ws5yR14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 13:43:21 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:43:21 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,  Patrick Delaunay
 <patrick.delaunay@foss.st.com>,  Marek Vasut <marex@denx.de>,  Emil
 Kronborg <emil.kronborg@protonmail.com>
Subject: Re: [PATCH 0/3] env: mmc: fix use of two separate partitions with
 proper type GUID
In-Reply-To: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk> (Rasmus
 Villemoes's message of "Thu, 12 Sep 2024 15:41:38 +0200")
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
Date: Tue, 01 Oct 2024 15:43:23 +0200
Message-ID: <871q10j5vo.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0097.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7452ac-b075-438f-3482-08dce21f03b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q3BkXbM9ajXH/lhn94sN9NLsEMQXjFNT9nzHqFtqJsjLQhtaNyuwl7nWlhCm?=
 =?us-ascii?Q?jXtto/vbF9LbNqTbSMRAzlkOpVaDE6+vmtcE092JIVAaqgNoSQaWeYeRudr0?=
 =?us-ascii?Q?QYLNXe+jrbVMrW+2Gc4zFamMaAebdc78WExbez9RODHVl9afXgUZQd3Sw2NO?=
 =?us-ascii?Q?jKt5FUIeORqSZUTAX7PnY5Xsn1UOLWZlWopTukAGtoLf6fnpEjL6Ufq1huaQ?=
 =?us-ascii?Q?4FQ9hCg7Qd+Q0eO+pmfYwYYabZMItbUuGrnrWMP8xHKxMOGMAVN5wm0gsUWn?=
 =?us-ascii?Q?vjgCBm1CzLQeKe140KD3pRPACg/kqcXO168Fpipx4FsMAYaAZRMUk7FpxEBU?=
 =?us-ascii?Q?6CdneHjN1FqMOzI0lItfoXNs7KBxWb8jYzuQjMjIyLc2SNL6j9UYo/alqtW7?=
 =?us-ascii?Q?ccwFUb9SJL7yFV4XifcThY9SMwrJ0K5PdmXdIPTnYnRpgTlFmqiuj2MwhHHT?=
 =?us-ascii?Q?efral1CyghKSetCgD00x9Ur5ZlOwkrXM48z8R2n55kn/ica5qYiemvhzRYt8?=
 =?us-ascii?Q?32TOSr/zgfQcUdgSzqDS+zHSt2oqw7f97Wql7hCx63Gt3+H1IdqZkAzh1emi?=
 =?us-ascii?Q?CWJKuvQ5Q4P+eTolgsrbS+umPmFUtFs621oqO/CXUIBWjKKVa4xytpUXNEHE?=
 =?us-ascii?Q?oR3VgsguGv+pWIy+D69egy0GupjWFwb6UB5mvXjLwh6w9TvHe68sSuyKi2s6?=
 =?us-ascii?Q?ZArkfQxUA6NKGDRWF4oQexdVgv7jSSInSP6wMapE22frwn1Wy8GR3XDDCDbT?=
 =?us-ascii?Q?pFXRZOXiAz39OusgcxXAGWQ9x2kPrDBeUQFCWsd0xY5Syrq3oWhz90IhEBYF?=
 =?us-ascii?Q?9OXya7xF+jRY8yG3+rCM8niv6WX7PVcK7br/N435TXve9QhzBJim1YjbORsU?=
 =?us-ascii?Q?Cggtg0Y6PVOLxgHaP4fnPhUP9sx3eIj9aafUjOjsm1FVsFCR6JU/GAI6xgjQ?=
 =?us-ascii?Q?ZYHdeiaScMywG5xDsuws3+eJSGkfvoNN0hW5sgKQX2+wz3YRVZPFWu01dKdo?=
 =?us-ascii?Q?becRuXyTqZvLlqJnTmgsnqbdV82CRshEhzP8F4EAAkOBWc60LGiD5qeNOsoC?=
 =?us-ascii?Q?yaK9Xhux9+VX1iXTfBrxENv12ALZJsAKfM8satkLxIniOSngV7R0o/Cho1G4?=
 =?us-ascii?Q?g0RTlPPT104UNlh/ItN7XzU/FVEzoscK43Lpsk9f0ojaJBAmQatMfXYtwkMA?=
 =?us-ascii?Q?49X2q3JmeVZxaPUjY7KzKdL0v2ZLRbqnWxFtDlck7aoCkgcJwHepPdWNXaLN?=
 =?us-ascii?Q?Nqmovnd91nUreuF/wMoCxhNtXApqyDnPoq5mFPlU2AMW6ovUW2q7KM6W1BCP?=
 =?us-ascii?Q?6jKkW13pD7Ja5J0T6zLlO054OgcBHk8pBT6J0vZwz9cfCcmCvCsfLxNm91c4?=
 =?us-ascii?Q?061QuhOyFLoZZPcs3GSYHi+TDtgWaOYJ3rMt6ZzDjcUawGbbKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lzMGqPwwYjz+yHVBI8nRVvcuD84uXLyQ1XXNGxy62zqNztZN0UEbn+XFCY+A?=
 =?us-ascii?Q?fAnsn0GIFvmhZ7TvHFVOyyK7Ys9mN6ZskD8i++5ODQoUxLHZ7TeOC/Or71v0?=
 =?us-ascii?Q?p4jm/xVqAXkCmJ1Jjbf19czE0/PrtF7dR2tyoHkmA8SddfzpHJhKySF6yNwo?=
 =?us-ascii?Q?a93xopKd/l9j3zAjY44R84HQGoEYSGTM82LtX5XdDKYnScUvxVugQidXS3Ng?=
 =?us-ascii?Q?t28mdz8M1WyKwQt7kDbfSWxDn+mVtshPN0SFbA3zpGSaiID9QqS8WR7pfSXC?=
 =?us-ascii?Q?5+SMhBEP8cDG6K5bsP8zVrBLhtTlTYi3K2gBEAW6NgTRtpWJCxoyNES9Hl16?=
 =?us-ascii?Q?VmmUuXFXJrSX/OOZCVTB14pSpB+PSPIKpxYYiRE8h3RAVDjxa13Zsy/1rqnN?=
 =?us-ascii?Q?51xall/nkP4FJc2hEDkunDSupNJbnOMfmEQpPCIfmlY5Bqam5YCxd/A7RVVv?=
 =?us-ascii?Q?zjQmc8EKy3CWHPM3ThqJF5eoQkSr5tlTFhrANPy2p6QCnmhoVo4MBGmwCoOK?=
 =?us-ascii?Q?qYJMSxg9gAmCaComm3LP0bPKrujE5ga9voh8MirK4MFinx1yZcqE1ees/n29?=
 =?us-ascii?Q?R5GXYfsEUedtl7zRdAQTZvZzzzTV42sjfqKiUnJZ/U63rr/E015hFWu92A9r?=
 =?us-ascii?Q?8PCeu+Hj1o8RIKZRfItxGDPpW5FVGegXqnUY3W74bZarl6e1CQC7eJQexZ2a?=
 =?us-ascii?Q?wX0oXo9V263JFq9zf6o5P0FTpN5NmyrSbKwX6tQByJYlIUIaW0TOrE6BHtC0?=
 =?us-ascii?Q?Fs51QVgcHCeppHLGW6UMZQLFVQOjA6E7/OukhVu2rqCSzWLXnW8fQmGTGtNA?=
 =?us-ascii?Q?NWtdhFaQt41FsUerQba4UIToczK1LzE1QO+VFqmunJs2x1AQyXy5VtVdN2WQ?=
 =?us-ascii?Q?e7aTxgrqYYDketakoM/yCtiIjtiwiz2cllEbAwdDT7dl4Yz3f5fXTe4JpzG6?=
 =?us-ascii?Q?FzP678s3HWlUpNuErvhCAO4Lgp8ZotFS5hmESD5zsnKfN9+H/4G1wxhdZohW?=
 =?us-ascii?Q?zgSp2QskGD0M/TX0q6dOeO7DUrP5rMbOLIL2dyvDaF1Dh6zAMEVzEwvrG7M5?=
 =?us-ascii?Q?5yC086AZq55X2QA5RVzGUR3O8WNb+lzsC5bBC+AW8b1TC3y7xZ1X9JNi5/mV?=
 =?us-ascii?Q?+EzDtoTckrHP/fV6kmyGilUUvzFff7EHYm5HJ1N1VVcJpK1ynzb2LY5ZaCvZ?=
 =?us-ascii?Q?/5JUAE983UlkEcU3YzEFOBLa0+dm4+cLhYHZfbKnmiKUrdd54LtlyEMzocxR?=
 =?us-ascii?Q?4CWqA7pwXrXo9Xo/os0czqTDX2/UciItHT+y5cayS3EnlX4wE6yZ8CzuLPWV?=
 =?us-ascii?Q?Cmqpt099qfiIJiSTslQxeslgHzg4vqdt80crKidgTV+Mn3n1c84nW/eoxL/u?=
 =?us-ascii?Q?WClmHJ3i0kQLju0xhm/5XPx+uI9pQYkPBrdXVHfV/7C7Zo1UNdH9Z6vglsz6?=
 =?us-ascii?Q?DkkGdlH2MCP3fZtJFQq4i8Z9P1jn3I0nxWyaCfeAdaGq4b9RTVWM+46879qI?=
 =?us-ascii?Q?GM5me6zZUpuLT1hosLWptIluZkLauUZUOZwLKjaFxiZuMi6dx6gpeYuHRrgi?=
 =?us-ascii?Q?lI/mLwRkHARxxCKbwZtppQbSXnhg0tFZl4IwPQhcNtaY/osV3gKFIBffcdmc?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7452ac-b075-438f-3482-08dce21f03b9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:43:21.5729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDNgOLRRYtedsROQj/BLcTfKXPoJQ/91WdLIzo6V9z6N7BJBPE5LwfibDwyHq3cVCbd/86hddmUaH+SyV8cgt5ZUhVwxfER/zr15VFaR8fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7737
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

Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:

> I always define a disk layout with two separate partitions for the two
> copies of the U-Boot environment and, being the one who introduced the
> type GUID for such partitions, of course also set those partitions'
> type GUID appropriately.
>
> This has worked just fine, but, it turns out, only because I've never
> had CONFIG_PARTITION_TYPE_GUID enabled on any of my boards; I've
> always just set the offsets of the two partitions via the config
> variables CONFIG_ENV_OFFSET(,_REDUND).
>
> I didn't even know that env/mmc.c had learnt to look for the env
> partition based on the type GUID, or that that would overrule the
> ENV_OFFSET config variables, until I experienced weird random
> corruption while doing bringup for an stm32 board, where
> PARTITION_TYPE_GUID is automatically set because it is select'ed by
> CMD_STM32PROG.
>
> These patches try to fix the code to fit my scheme, while not changing
> anything for existing setups that use the two-copies-one-partition
> scheme, other than complaining loudly if the system is misconfigured
> and avoiding such random corruption of neighbouring partitions.

Tom, any chance these could be picked up before 2024.10 release? And if
not, at least be put in -next so I have some stable sha1s to refer to
in my own branch.

Rasmus
