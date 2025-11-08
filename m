Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AA4CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 00:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7639483D52;
	Sat,  8 Nov 2025 01:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="XmdhggxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D241C83E44; Sat,  8 Nov 2025 01:02:21 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B7283D0C
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 01:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/7dh5SRPg2/80rzoPvD4taqYrBLgg+byJH9yynfE+66gXYpwVmS2rgdjV5K2PFHML9vXOJMbFoclt/8LHVDdD2BWznDm5y6vOEhIXPmU5PsWedEE7jijIHtlNJTi8vGKCkIDdDAnYipGlJUdZRqfaaAFtI0BYwB0lvjq6zqTXiPVvcFBCI1pMags7hHSTN/s9Mz54qzYrfdssKchTT0IjuedVBhcCjs/eo3obIYHzPZkfvjUn6ixu2MupfzioIYw3rgGLtioe0qEY/UvgkGhmUJyu5qZB88I4jKXieJVsYpFEOuJRpW6xf+BBKkF6c+vHrfg26R62fVL4ck6lzOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojtCD2uvelElh5nFj2H0YxtSAjg+lq3iBjns70Bqfig=;
 b=YKi6kdhna4UO0q/rUMX71+j25MhrcleWemBOUlvwx096yoU63sO6yZMVxx4HXe9/UUxWMvmdeva5b9scEN+fc4efjEz6L6HCak1ORhThiGm5LwCadubQfyH8bIoG1jNmjDv1GcRjoqJRMpxvT6y64k/CzbfTLphUKANHhSVqqXGZO8TZp1MUeqLJczgfy61225qHYHPZrBk6ZQ35NEDri+ZjF8aMlS8pnUtMYGgZZigLEWYjJJpjJ3VPFS285vFSKw6pgpJbrgovtfQvbbBUIjghqPs3lvIztjJbBkP+No9OfBCInBsGwsEa0Oa2eAsGAmdMi52SnEywxFPWavwRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojtCD2uvelElh5nFj2H0YxtSAjg+lq3iBjns70Bqfig=;
 b=XmdhggxZieJN8AE6yDfFYoNrDqclmj6I02kUTNQNZsDFqNZqEAd9Eu0JJLCfWDyB2uKHx5wav+4b6bOV6P0z9J4QgTqNxTzdA4CgCbC6g/6PLJSNzz1UBsZy3uJ7wpwaSTKeoDUgoKvved1YTlSNPMCXl5+zQhdDMbdsFqVSSCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB5992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 00:02:17 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Sat, 8 Nov 2025
 00:02:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 0/2] 'part name' subcommand and some robustification
In-Reply-To: <20251107201927.GA2243313@bill-the-cat> (Tom Rini's message of
 "Fri, 7 Nov 2025 14:19:27 -0600")
References: <20251020121100.1742812-1-ravi@prevas.dk>
 <20251107201927.GA2243313@bill-the-cat>
Date: Sat, 08 Nov 2025 01:02:14 +0100
Message-ID: <87pl9tcry1.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::25) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f6b08e-625c-487f-58e4-08de1e5a1446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RV88NQOYqDPdlHboqM/7bqTE4s4kNXNNSji5PaFM0pDhYNvywLLVDW/QqT1i?=
 =?us-ascii?Q?YAz7DBk4CkEic24dsaTjiBWuHbZtdWj+p5n47IwzREAhDpAvis42Qom4Q9oP?=
 =?us-ascii?Q?0NrUHTmr6Dm8FxBReLUh277ewl3NYUJhiz+v2MV7Weo/lyc3xXI7yvJPndVa?=
 =?us-ascii?Q?83yNv/qQ4eAomce7Ti4TntkDL0e48hwZAZvBo9H193dmBzrDeXhZBPx9mDHF?=
 =?us-ascii?Q?Rk/pNw0zTKLxra+uLal28H3IGYPy5Oq3EmzXzLuJ0qpFWoMsLBX3ty/BHc5+?=
 =?us-ascii?Q?O7pDNm6ZlVoQhVYbnizb/DS6k+w08dfssJeBGAdg1zG9tazhwXmz9MlFkATG?=
 =?us-ascii?Q?pgKV+bA92Erx0QUMI5ZVZh/fY3Dnj6mPYTeEhT2BdiptXhqYMqpXDze1btir?=
 =?us-ascii?Q?wmHbUwo+P3SXMyx9tyaSnNqfHrytA1ohc14mR+T3+UL1bXF8Q/H4Vc0N9rg8?=
 =?us-ascii?Q?P/ryiUeYP8tFCe2wKO7PDLXASVbOb0UShy9FkBhrvDThb+4niJ8zk6a8aNhj?=
 =?us-ascii?Q?nKCcOCpaw2Ssp/xwH6NJWUpvWr+94CWG4AabKLyAcLElB2uVi2Wb8IV9r8gE?=
 =?us-ascii?Q?Ygfq2hQ9HL/LzmfxyWCX/BzzUysLNVo1VXXi6APA45qUU7iuTP6/QZV9Q7Za?=
 =?us-ascii?Q?YAX9CHG/C4RUBgQuPjNqOBfIp+dtTxNZWPCFRIZkZjdP6CBcI2bBGw1XXARH?=
 =?us-ascii?Q?jOdMJYqtNgP8R6Oai+4PQpKzVvGJnYsdaMeQ7WgDe8hwv/NM1NDa0yglb7be?=
 =?us-ascii?Q?pJebHf/1Jmm2nwM8bVcJOQOD1rwpUC3ZxZnsVjeDE4WFhmehc0yTDhfCzODv?=
 =?us-ascii?Q?4wpvhX2Qf7BY8Qu1mnAjKxsz8LwJJl3HsgZaUAjjzaEUMrsqnLJswdpB6GUz?=
 =?us-ascii?Q?R6/HMyHrJYDDCudbUHVzRe2IqDrFSjwx6qfGMXAfXDWp6ZQgyNkPIfOxXVrb?=
 =?us-ascii?Q?Qb6m1d2sshgGtyEX16H+1ECYgiMnUlPaWsH5tOxJ7mw6hg78QXMMEahJnZ7r?=
 =?us-ascii?Q?ib+ZyMJLP7KwTQNOgZG1tkpGMSIcNING+Y9zEBP7+NzqvZwEWkJZXHEdZXBs?=
 =?us-ascii?Q?45BMEvR1cYXCCukNNJ+Pa6922Tax/jwz1z6crI/nJKqrdFFGPJnHsRgmznFf?=
 =?us-ascii?Q?VdqdyTYjxjHfSo9Czc4c5LvNSVMkJyfc2EK4Zwn5OJAMYLZlarRZXZEdrM46?=
 =?us-ascii?Q?kRJqRt+KYCqWbUi87RnhFznpTi8hBr1jRWdKsqZkyFKeiVI+tyXKadiSvTVd?=
 =?us-ascii?Q?sIud2VUBpYSUd/KBa6lMNzpclFfkjD2BX41rnlPqEWSzk+cdOnuDnNsRRDV1?=
 =?us-ascii?Q?l0qHQ/3xzwuVSwB9o9/O2R8qn/wwB6Swfq4xWYzpgDjAsqBmSI7QjDSs91uW?=
 =?us-ascii?Q?eB4O+3kF0q8ITPFrDcC8GnqTuz4+HHzafSYH6Oh6T3bpVfSDRi7t1JEnOJY8?=
 =?us-ascii?Q?EPHqZ44Fle1c83AetSxO2jSwkIxMjVzkgPr4L3bLGjdlNOURR1UwB2RiT5DI?=
 =?us-ascii?Q?pbgCAId54Esgg2RNDkA8msCQgQBSHdtXa2Kg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Id4zv2Jw8Ef7bVsxNdy1b30D/7oAd7XgLvHIV6hfFcLFKIrI70IpEkC/om8R?=
 =?us-ascii?Q?lnsj3qx6DAGXvJ8daUCbsskvt+LMd58E5yXVZmWntkGz7+3/lnV35PWz/1hl?=
 =?us-ascii?Q?W9uUdPTxxvGWEL6xxrgP0zKS2EyA+rmDQJBraavnRmNSc8PUacDGpMIxikkR?=
 =?us-ascii?Q?IvcnldL7UVe9kiMVmg03YVJG4WFGynfo8U2rhH8M28UjErN3N+akL8Lror6C?=
 =?us-ascii?Q?WAYeJw+i8lM11adsbMmKPkHkdM92802LuWKexQUUX1WlIJtFPdDUgWMdUOd+?=
 =?us-ascii?Q?O7mtYxMkyUs60rgFII7g88YBxomx5kA85qfC6F64nIS38U8sD/xtxXttOdoq?=
 =?us-ascii?Q?gfGNPbQCTIC2Ap66HTvgSugSglEpgJ029Mvxnv535uFfO4E/vXmXBptJ9UoU?=
 =?us-ascii?Q?ZNX4+yryZ/fMXfHH1uyC+0VAHxovOl4ltU4/rm55F4IITK/WRLUKcMmAWlZd?=
 =?us-ascii?Q?OkQeVjoQfY1VodCHgtxMZ0DR7jEqFV+bF/cP3SHXvngY38Ef2ynknft+MMvc?=
 =?us-ascii?Q?7HJmyDvCLVdZczka4kiM9Rs8yEjlEstFMKqzXpeCRMD/+tdruiEUXF7WzV38?=
 =?us-ascii?Q?PoYajDzBsrOg3aVaQLdAt2Q67JU952Gr1mqggkH7QrHaeQSSCFGzDozXmtEk?=
 =?us-ascii?Q?3jBmX8MZfLqXqKQTUhii4ninNVTGlzdQd7IcRElBmPeH30j/qOpauNZFm+Ei?=
 =?us-ascii?Q?h6zHrXW1fuY9X3+demgdoegKipokd/ZyMJvGnRkXEUZ+CvcIm2DdXHrbq9lL?=
 =?us-ascii?Q?ywjTkSCslMZ219VEGATstfl1ijfVkFXn7T59zIs7KRlZ50XhHuTlO4oDib2W?=
 =?us-ascii?Q?nH5B1/P17UC0wNajAX8mhB4Q/3LAibQxdVvOZlANuqNybQpsA+yQpJPruV6O?=
 =?us-ascii?Q?jVmSm89MAy41XyC7MAW94ukorJeHtTmog32hez0F1dO8peLoZotoh6X4bxVB?=
 =?us-ascii?Q?25k6AYwpFfMilTOVrUZWBXx6EYokRc0xBxq0efH+3gA822sczQH1RBk0OVLC?=
 =?us-ascii?Q?0LfuJaYRmAYCLt0Nu8viQCc3gSEGW2M3klDdUBwuY5PA6PmX3ZslnnhrdW3+?=
 =?us-ascii?Q?nI6LM3VP0zoJ7PDdLPyyBNlrQ1xXBJXB1aDPVBVwdyVAjGQ9ajVvoyPe7oja?=
 =?us-ascii?Q?E+TjZf0z01zkYxuW6XnBPTzSlfNOXaqOUBTAmX5vwG89lKaoZy54VwH7f7lE?=
 =?us-ascii?Q?w/54v3NYw6ysFbi66dPzkE/c5ehByNA/0gp/4zWUhM1nyHwOML2gJt8WP7De?=
 =?us-ascii?Q?Qixt3iK2geLq331vpZ8SCb+zAOXW4aIcakPGXPDHcwvZnWHcf2qjK8Yii4g4?=
 =?us-ascii?Q?m/7xigS6tSL25NY83hRLVjnFPEmz43JVNLHDc2QXxyGeFUDgkDb4/X8HYwqh?=
 =?us-ascii?Q?CBLTezUan4g2XhjFxzUcKwZecDXbGx6e2qZ0D8iaUkRql8zlsdzobbkfxK6P?=
 =?us-ascii?Q?rPNmVEHTQGmhi+UeM5PG0k2aNum7zihbureYldG6ekzEuzIl4wcKwc2st07N?=
 =?us-ascii?Q?wvf2i/tnIICB7YamADQHNG3b1OAWbk0NB2iefWVgW8rWwMW4n1ToNag/ePsB?=
 =?us-ascii?Q?0PDsSSEXBHTS/A35fvvfXUjYBcu2YZb71F4wcrngMDkIpP9AoLPA4EWu8Oci?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f6b08e-625c-487f-58e4-08de1e5a1446
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 00:02:17.1243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJQj0vTqzHZh6bKMaM4SL0Dx0/A2RJPpgVmwg9w0jspAxzgRUMqZZp0J/HHtrdbS6A6SbhIHRJz8+pvsRB42FFUSSorQz6BpvITY0QdY3JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5992
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

On Fri, Nov 07 2025, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Oct 20, 2025 at 02:10:58PM +0200, Rasmus Villemoes wrote:
>
>> Implement a "part name" subcommand, mirroring the existing "part
>> number" subcommand.
>> 
>> In the discussion for v1 of that, it came up that there's a bit of
>> inconsistency in how much and what one can assume to be initialized in
>> 'struct disk_partition' after a successful call of one of the
>> get_info* family of functions. The new patch 1/2 tries to consolidate
>> that by making sure all ->get_info invocations go through a common
>> helper that at least always initializes the string members.
>> 
>> Rasmus Villemoes (2):
>>   disk/part.c: ensure strings in struct disk_partition are valid after
>>     successful get_info
>>   cmd/part.c: implement "part name" subcommand
>> 
>>  cmd/gpt.c              |  4 +--
>>  cmd/part.c             | 16 ++++++++++-
>>  disk/part.c            | 62 ++++++++++++++++++++++++------------------
>>  doc/usage/cmd/part.rst | 13 +++++++++
>>  include/part.h         | 16 +++++++++++
>>  5 files changed, 81 insertions(+), 30 deletions(-)
>
> This leads to some of the bootstd tests failing in CI, unfortunately.

Do you have a link?

Also, how exactly should one run those bootstd tests? When I just build
sandbox_defconfig and do 'ut bootstd', I get 130 failures, so I assume I
need to do something extra.

Rasmus
