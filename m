Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFCFD1681C
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AC083F56;
	Fri,  9 Jan 2026 12:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="iF5tBtfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E19842FC; Fri,  9 Jan 2026 12:56:04 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B9283CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+5nvg8CAjNJxbstgb0h5AYynMmUwDwGr8ohlhbwjdHx+cljpHe5otpHMXIFnZRjYjdzPiTiwXKHGg7SrW9E+2oyiJh6g3nrIL/iT3pFtXZcxvYUSi7EVFOwRGGmQbDzPkIbXmmRdH3l2UY5jjrQvUrtTfBTbIhDN519QqOh7+FkLHWY55tMiQqCCha1ARP0WecwTlJQ2S7uIwCWcnqdJgQZbp8X2Snazc+cDV4Us27Rdn0le3c/b52Q2zjhFnC64Bh95bt0Vv4ikKHmmyitqkfJf9yGAJpV8Ud3MyWfYa/8noJqfiDAs1PTuo19MQHztC6wTC3RuRv02OTTGNLdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MInLjNboXh+tGEl5iMuG3MEdX+fIUfj6fz3ip5hsWg=;
 b=ZsNDZhDegUJTNYGWPnJA7MgPD1sW2v1k16AcTLlj6a56kmJU/MwSB7bMFk8eePOi5D+t+0cGUffA2KZWOZtgOBvhynOTMa2D9xGrvdVvXyvPJOzlT3EjiuOz3YSQrGCW1oQCsIPkeDrzDiEyhOqOffpJ54LjCdEn2uLzMBExdKIguGHQsqAehCVRQyV9gelcJkteJwxO86ktLqH0D9DHQkon8d2wUhyzIsXtxdNBQp6jRdZDN0Fu6nTrEnMU5K8IOZy0PDnFfQZn8XtWSAklFyy9Igcpb6qvufABulmucPaILoelUH8omVixc/uGwOxgIWzeUNuNArYGUFxzf9w54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MInLjNboXh+tGEl5iMuG3MEdX+fIUfj6fz3ip5hsWg=;
 b=iF5tBtfrbq1aoYrvclhq/ZFjZ5WCZKqm/Lr0z3oNFhdTjXQckFifm8RGx2fUlpRkO1sNhTc09KuF6AAsesGB4ndmI6qqfGLHAHeF4leeiqphkYOJI0JT/75aUO29b9f3PaaSPjyQQZAaa43b30izHwxoe9x8FA56QtgutWDlLxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7586.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 11:55:58 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 11:55:58 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Simon Glass <sjg@chromium.org>,  casey.connolly@linaro.org,
 neil.armstrong@linaro.org,  sumit.garg@kernel.org,  trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com,  joe.hershberger@ni.com,
 ilias.apalodimas@linaro.org,  quentin.schulz@cherry.de,
 javier.tia@linaro.org,  quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org,  michal.simek@amd.com,
 ansuelsmth@gmail.com,  mwalle@kernel.org,  anshuld@ti.com,
 jan.kiszka@siemens.com,  javierm@redhat.com,  u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/4] env: scsi: Add support for partition type GUID
 based environment
In-Reply-To: <bb66d91b-667a-4c28-8acc-b64fa84fb7f6@oss.qualcomm.com> (Balaji
 Selvanathan's message of "Fri, 9 Jan 2026 14:21:28 +0530")
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
 <CAFLszTg6X8PeD4ZyY08WsTSs+qnRb_-jJjyupzSmi-jDzEhWUQ@mail.gmail.com>
 <bb66d91b-667a-4c28-8acc-b64fa84fb7f6@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 12:55:56 +0100
Message-ID: <874iovrodv.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e29169-d767-4495-3938-08de4f760d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z8OxG+rhCQGKBd+O3kUD9CXWde4xW4Yo9g6uhn0V4FZSH/zg1IYpsXNKvFwk?=
 =?us-ascii?Q?Xy3JFHL0dGUhLq5F2Lthsjc+rOGtD/1fzCE9LmmhPj1zNX93MxfspMf/PT/j?=
 =?us-ascii?Q?LoZCFeEXl3vQEhJeZHOo7FWclXGToChVZdNeam4+abUu2nLDTO6TOlpln6WG?=
 =?us-ascii?Q?qffCrEgmpYpGQPiTghB3QfGaPD1ZaMBjc578vTtt9UbdBugNjjodamjWJD0j?=
 =?us-ascii?Q?ASCSQkT4VcCpGWiB8SxLe4KyQEm/IqIKaR0HLZeMTI2Uqz7m5zDHmoMXEQVW?=
 =?us-ascii?Q?/PX2lDLvDpBPVjwFzhL6Srpg7pytv6wcdJ1YHR0gC4V+iai21qRA8ne6dKqg?=
 =?us-ascii?Q?x+XK7XmTIMu+yT61Rihzh0pnLfiinVdeG0Rh5E1lk+FlTPjTZDabpPkQVyRo?=
 =?us-ascii?Q?6as0CMtBTRrwrfS6tMZk3C0wbq2QtdjBJGSqMzu7O1iKEFAyKUIHZjSiPtjE?=
 =?us-ascii?Q?KFi7PT5a5IB9uglAcP+1M4ZF8Af3dGzqpbYExfw5pGS8f0wKO9TMbGECmSZO?=
 =?us-ascii?Q?ixG1d5DF5hHeL1yWygEjjufIWWuklMXPRXHUw5CZm1X+ewrXIEiQhjTkxWvh?=
 =?us-ascii?Q?k2l8iV5fraf7LeScBJji8vR6db4vS5oCUBUNURHx2Sbf840QBvaFVMNFyAZ8?=
 =?us-ascii?Q?t/cD9CaO/cL5wu+wpHWaklqUIFp/FkPHMKVPU7eabSHV0EhVNQgMYAI/jXRK?=
 =?us-ascii?Q?M+/QxhpLyWAuVNwHLwC5lpWimL46ZZiY3+gBJo5C8K9N221pzUCGmASS6MPB?=
 =?us-ascii?Q?Wyy0xEPydPcJKcLtCtxVz2wE/y2ltHhUk4mwvSf7Jdvj50KDdfXxOsScnHcl?=
 =?us-ascii?Q?vXfL6TqSiHtTyyj5FSS5QtH4m+dDuILXnDA608ez/UHC6iqBgrhJzI31APVx?=
 =?us-ascii?Q?ujmn7HR5/XlAm6evYTAp1XWoqvcGEQkEcCektUEPL5QwmAe53lFkTYrt7Sax?=
 =?us-ascii?Q?IHHW7TEtS3//YiHnlxPs9KO9ERODvZRy8DWQDVf7x5b/MszOUFGamb1iTvdd?=
 =?us-ascii?Q?VSEfXq7/RtfH+0lUV6c2Ownnha2i2n9j9HlazyAznJMAHvrVhvcoHGM7DNlT?=
 =?us-ascii?Q?k95D4lAmTeGWgkuoZzH2qS07l1ndufpc8GgK+C1e2PrhexzNLHoDu1aU/2iD?=
 =?us-ascii?Q?jSD9ld8hxw302cY/a5PoF1UivmUcfhYWTNKylT5zcskhNMU3vXWv9/u8hAUL?=
 =?us-ascii?Q?5tgg4ckgfzJdkw0rV2Xsn48RNIvJE8OCLjR/eIovM5P+yFg3FBzteV9XUi9d?=
 =?us-ascii?Q?q155InPClfFL0x5NSkkwSu+kfSs+QGa8lPsqr3jaE5JrJMov40/HnnfGwgxE?=
 =?us-ascii?Q?JhiUUi6rNAostnkH2snY1TRAjI9h+hZsGumEsCy9XcaI2KUJbykzAByNI/s8?=
 =?us-ascii?Q?A/7T7tz4rW4X/LPwCPNS59wqatVcsvGZFeIf+TvXgXWp/p6oLoPl5GfYowjI?=
 =?us-ascii?Q?LxDL1bdA8ubOgAtvIs3dC2UftuVi/PpGHfg0BafaTyWJ2FGQbwRWnGtBQ1M0?=
 =?us-ascii?Q?kWGM1V5ZlYFpISlPscu/g6gFcXNMteW7o4tp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a0Xoux6mHeUuBjqmIJvNkAmSqcQqNcofxNrMOpzfOG2g/Dr4ezVOTuG0M9DJ?=
 =?us-ascii?Q?3zcYG4PgljzTdsH6HH8OfMGUh3vaeSuBk7Wxi9kMJwFE++p2xMLuaN8z26CA?=
 =?us-ascii?Q?MeLXggFRiUnDAT2v/cN2TKUaeWzFnJA2r8qSMPdGwg3xroNc8YM8RnnuAsPM?=
 =?us-ascii?Q?aX994BCaWQccjgsmzizmeeKKLvAIC+kQvn0ELOGGUROxkN9Y4u5Bf0tHToQ2?=
 =?us-ascii?Q?VrLTlSYcXDgFBd14MOA6+JdYGTdL5+zoBky2clEDt2onyJxeUCUbYnlrKlIC?=
 =?us-ascii?Q?IMPgMZK5ezE3U564pZnNBrygcORGgjWKc2VKrEr7m6TzJMuuDIeZdnR93LBM?=
 =?us-ascii?Q?qHNm5n+S6ZSm/2i+U25Nc1jimpHLjI32p1tjBqB+GOwVOzVLuaYoJL5Iv9km?=
 =?us-ascii?Q?Kk9mT+Qh0fzJlryvCPzdVFPl4gveyuF+r/6Gyddgdeb2+YDBqaYyQcnAOYrE?=
 =?us-ascii?Q?g6xve3+Iba6bpGXMIKTO+vRyMCfh0qK3t4DHfKhgMqr+zlSPMRwH9cWkyskO?=
 =?us-ascii?Q?sNuP7X398zdAE9pPxV+Hpyqo0qe0Hxwg/f/jt+WuLnrjHHs0oyL59BlytcJE?=
 =?us-ascii?Q?vInoxYOX7BVHkkA9Vq19cGJ4Kuvrkdo96XdeagjIKwG5ublfFgYiAXNXUn7w?=
 =?us-ascii?Q?Y894M1qE5/pgx0UpjBrKqWxJ2H2qAhaw+z8Jw34K7kzX8iu0lnEQ/orn8Z4z?=
 =?us-ascii?Q?rT2OX4ea3/GBMPkPkYVlum4/DRDWNDNPGYqqesCmC6Rxmv7bjaBqXcHDo7Dj?=
 =?us-ascii?Q?S9htlVZGHjR4j7TsqFpYY/V2CnAoO/e+06CkjWhZWeegsKKtK6eu3lAKNP/d?=
 =?us-ascii?Q?iWufFL0rHJKhKZ+nxhpnWEwTtlIRuRMqs/XjeqV0/QvqTszoD3o0q26L2LXC?=
 =?us-ascii?Q?3Hnuy0hQYMJD8d7UqDTAajebRiESztxBZq2n/P/pn/T6zpHDvgvq1mMsgGk6?=
 =?us-ascii?Q?mMJYCa9NZYLOf1jJf6zYHaQd84MFyDvqj3Stt4R20gU+GiCRJ3fbbXQQwE2C?=
 =?us-ascii?Q?w/no7cCzO4ZmLB+68265QHHfEvGr8y9+10I6POt971SD0nk+o+2A8p23Mhy7?=
 =?us-ascii?Q?54lb81xa+9HbTJKaYCLb5U+5UGISUBdWFW17pbvHdS3K9JkW0sZMGOVAHGiM?=
 =?us-ascii?Q?oMvNJ/s56uRH6ZWB3WTvJp6/NTlBqsCq88KTbJbTbmGr9qmhNObi2Gyz7OPq?=
 =?us-ascii?Q?Q+Uc5NPEMYqRefV1EspI35u+Wm1/jD8D+2mCkEH08F+CYN1Skhj6nhim/B0E?=
 =?us-ascii?Q?R+FcfnP9EEEba4r8br2BmV3ZTjs6xfGn5XU2Bwpe2RezxfYmHYO/K7dmmpGs?=
 =?us-ascii?Q?RBVcJKpaKDIrzEC6iDXisJwV48rupUM+Jw7LoEX4SWe5kgts1lew5oBjT5y+?=
 =?us-ascii?Q?lB88IHbdD1/KjFAjQePRJUSrCR5xq/cL+fc1/yF/Ax1d2Sw0cHmbfXSe87wd?=
 =?us-ascii?Q?Yh0rmrKnBOAAhzrNIN6uVMvbVYi1N97d7P1J6RyD9oJErBVE/XbMQ4d0yt4w?=
 =?us-ascii?Q?qrzq5ukStzdLbwrY6gthU0dKVUlkI+mTMfSeK/qvw/FRbpnBKMWm/x3BGGY0?=
 =?us-ascii?Q?fDaAQpPLrv+8PZi1t6aVZ5/8pulcnvptZiJjsDLeD4Ea7qWRE/nYMHkyDaGk?=
 =?us-ascii?Q?mGAkSoIJDbdQRp3uZDNuGHUBx1UV/EmaIwaJ61nGjl31CcMQWpVBNvIkAp/+?=
 =?us-ascii?Q?x8XVc8neBwl11aui0I4zsF8HFC9xw4iIZVL9MG3jgs8bb2ROqY51rWm5v+YV?=
 =?us-ascii?Q?WUXgmC2BXDI78wyIqjBVKnJh0zLZvxk=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e29169-d767-4495-3938-08de4f760d75
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:55:58.4963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwjzizgytZmLAfhht6wVMPxKoFTcuse3HB1It2uMoc4LIUBHHs8AIQ6yfkyUHr7FZXV3HDWEMwJsbNo/yx4CDcSAyWw0c/FTlL5qxQyd8+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7586
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

On Fri, Jan 09 2026, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

> Hi Simon,
>
> On 1/8/2026 11:12 PM, Simon Glass wrote:
>> Hi Balaji,
>>
>> On Wed, 7 Jan 2026 at 23:50, Balaji Selvanathan
>> <balaji.selvanathan@oss.qualcomm.com> wrote:
>>> Add support for locating SCSI environment partition using GPT type
>>> GUID instead of unique UUID. This enables the saveenv command to
>>> work with partitions identified by their type rather than unique
>>> identifiers, providing flexibility for systems where partition
>>> UUIDs may vary across devices but types remain constant.
>>>
>>> Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
>>> allows specifying a partition type GUID for environment storage.
>>> When enabled, the environment subsystem uses the new type GUID
>>> based lookup method via scsi_get_blk_by_type_guid() to find the
>>> first matching partition.
>>>
>>> This change maintains backward compatibility with the existing
>>> UUID-based approach.
>>>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>>   env/Kconfig |  7 +++++++
>>>   env/scsi.c  | 13 +++++++++++++
>>>   2 files changed, 20 insertions(+)
>>>
>>> diff --git a/env/Kconfig b/env/Kconfig
>>> index b312f9b5324..97cb3d05daf 100644
>>> --- a/env/Kconfig
>>> +++ b/env/Kconfig
>>> @@ -768,6 +768,13 @@ config SCSI_ENV_PART_UUID
>>>          help
>>>            UUID of the SCSI partition that you want to store the environment in.
>>>
>>> +config SCSI_ENV_PART_TYPE_GUID
>>> +       string "SCSI partition type GUID for saving environment"
>>> +       depends on ENV_IS_IN_SCSI
>>> +       help
>>> +         Type GUID of the SCSI partition to store the environment in.
>>> +         Uses the first partition matching this type GUID.
>>> +
>>>   config ENV_USE_DEFAULT_ENV_TEXT_FILE
>>>          bool "Create default environment from file"
>>>          depends on !COMPILE_TEST
>>> diff --git a/env/scsi.c b/env/scsi.c
>>> index 207717e17b1..6182ae26679 100644
>>> --- a/env/scsi.c
>>> +++ b/env/scsi.c
>>> @@ -35,8 +35,13 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
>>>   {
>>>          struct env_scsi_info *ep = &env_part;
>>>
>>> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
>>> +       if (scsi_get_blk_by_type_guid(CONFIG_SCSI_ENV_PART_TYPE_GUID, &ep->blk, &ep->part))
>> Can you use if IS_ENABLED(CONFIG_SCSI_ENV_PART_TYPE_GUID)
>>
>> (we try to avoid #ifdef)
> Thanks for the feedback.
>
> In this respin
> https://lore.kernel.org/u-boot/20260109070912.4106466-4-balaji.selvanathan@oss.qualcomm.com/,
> I've introduced a choice statement in env/Kconfig to ensure mutual
> exclusivity between CONFIG_SCSI_ENV_PART_UUID and
> CONFIG_SCSI_ENV_PART_TYPE_GUID.
>
> Due to this choice-based configuration, only one of these string
> configs is defined at compile time. When I attempted to use `if
> (IS_ENABLED(...))` for the string concatenation cases, I encountered
> compilation errors because the compiler tries to evaluate both
> branches, but the undefined config macro causes an "undeclared
> identifier" error.
>

I think you could do

config SCSI_ENV_PART_TYPE_GUID
	string "SCSI partition type GUID for saving environment" if SCSI_ENV_PART_USE_TYPE_GUID
	help
	  Type GUID of the SCSI partition to store the environment in.
	  Uses the first partition matching this type GUID.

instead of

config SCSI_ENV_PART_TYPE_GUID
	string "SCSI partition type GUID for saving environment"
	depends on SCSI_ENV_PART_USE_TYPE_GUID
	help
	  Type GUID of the SCSI partition to store the environment in.
	  Uses the first partition matching this type GUID.


Then the config symbol always exists, but is only visible/changable when
relevant.

Also, I suggest adding

  default "3de21764-95bd-54bd-a5c3-4abe786f38a8"

There's really no reason everybody should come up with their own, and we
already have exactly that type guid defined to mean "partition
containing a u-boot environment".

Rasmus
