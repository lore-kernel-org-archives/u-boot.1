Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63064D61010
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 12:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2B683EF9;
	Thu, 29 Jan 2026 13:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KnlyCR+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045D083F26; Thu, 29 Jan 2026 13:34:56 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D252783D9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 13:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqKGc0ILLtgsJ37RwnnT/pGr71/kUBTWaUxIYyeMzJEJGDrLGl9GcFwslCXc/iB/pjBQ4Q+SdXjsG4B/BzNRr57mNn8o71XVbaTx7tgcqm2u7BNP/djMAHkOpYgiL+ASuvV2iKFd86ZbPMCcWlE6acshkoVduhlXUa96x11NpkytaI4TPWZg1CtS229onJUnCWUPu8OO5p148n1d3UaOulOtrH814mlPFyMuirenloCwTVMYCHKn5GJoOk/v/+gxnWbgXo1d/odtXDawIK0IGOrh0wJiHEsATxE//rGcpUXjW667k/Hl92o4I8scsaC9cUkLcPnDWdNhMaBYykEthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENDCMkKDU2dlglkhmGmw8MzL84M3CxFYBFTpCgJctys=;
 b=mOgig7I7rhF6+fQKYR6XkuQoZ4pUP5yfPP95/8giuFOEFAg840KGX9xDAcmE9LO46hP6e8AY8zUJHCSxsbfa3BhdSEiyulP3u2db19x8av6WpqoSCVkDkx1q//ubTK+pvsYJbeLUvBzdFDPCNSSdLH+DGXY7tGZHvOcF9dQifEmHDyyy0GICso7AK/7sFar8Y6LUAdrF9GBIGJnI5aFaKSbuG6PVCDJCSMfB6v/cdvX8gPcpe82OiZDqSOkaeso7wF+BzWWdxwNKdxBbk+4EQpDB2sRyAfyr7fe5QUA5p1LbGgg91cMQFsDnDjEKdDhuQlF9jl5UQx/B31FavCApeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENDCMkKDU2dlglkhmGmw8MzL84M3CxFYBFTpCgJctys=;
 b=KnlyCR+2zNxcIlTp2Xsoa39/xHWZ3ZZAvVPwe8wnnhwD/ayKN9yFhH/oiRiRSEXvtMBGTdEXhoExBBqJQ52tEG+texdPAC6tvahRvHZLR8XdzrFcPdRR/nLgESoYd/h146l9AzMXVWcFd5iuBc6fIRE48wHjE3HbG2WHJcCHGxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAWPR10MB8066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:384::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 12:34:49 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 12:34:49 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Olivier Benjamin <olivier.benjamin@bootlin.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [RFC] Kernel command line from FIT image
In-Reply-To: <553E6DA2-7E8D-447D-BBD4-B7F0DA8B359C@getmailspring.com> (Olivier
 Benjamin's message of "Thu, 29 Jan 2026 10:40:31 +0100")
References: <553E6DA2-7E8D-447D-BBD4-B7F0DA8B359C@getmailspring.com>
Date: Thu, 29 Jan 2026 13:34:47 +0100
Message-ID: <87a4xwr40o.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0003.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::12)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAWPR10MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e56a82-30ab-4bc2-2696-08de5f32caed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j2qbHj1QKzN25rPRMbXoa+Kh7Jl22Dvv/EYRHL2+1FVv+R41267wb4mmbKZM?=
 =?us-ascii?Q?NEWwOrj+4fSwiPMcUu26oIwR0WbIueNV72AvmSs334LO9alompkt9YVH0Age?=
 =?us-ascii?Q?7XChVAuATmXGuwuty84gmIHeoZh7iQHV7pmsz6AoxmQeW8JXbDE5oiM5ZzWq?=
 =?us-ascii?Q?UJ4MwfC6XEL1lt2SULdbaUirOjLZ/jykano79kuPdNyyrTb8mkC5tPtCS1vs?=
 =?us-ascii?Q?7GRgkSX4fnpsjbfs6dolBGJrtozVchjize2BYRujTyGyACNsUuvcaD/DPKzN?=
 =?us-ascii?Q?020qlWi35+blUVEQCKNfRBhFUxTe6wOrsUpZ74k+95xVtePZWHaCrv27vgMd?=
 =?us-ascii?Q?24DT01VBO+M7GqdTKLfJXyTO8b++CVFad99BJJOuh6PfvKF90WcYY6jUhxm7?=
 =?us-ascii?Q?P+ouoG1H7wdpcl3AWynRHWJORVLVs8JGf/4vlGA2omW0m0SvdcBrKCNN2Z5I?=
 =?us-ascii?Q?m7jbe32u6SgI82+7u7mtxNPwHecY0q3lvbsl3cM+6ByZ37zEHRJwk6LI+LaK?=
 =?us-ascii?Q?JCl/wPY/0MqDcmJpNkrQUfjwkTQ6DA0+3ExyS1kEUaXI/1jwIdSBz8RN5R4X?=
 =?us-ascii?Q?D64pewwVMXtDIerU4O+MpZodMEUZNxwzHBbi0wfl9qcXtH/3Cq6CRcKT1Nd9?=
 =?us-ascii?Q?5Zia996kYdJmIFhL4cxJWhd9hanOg0ecQuJvIte1r4x4XPovB9fugoePcbdL?=
 =?us-ascii?Q?JrlWV2bW0qbxeh4EfQJvYQjjntEUaJcSAS/xjMWp23mraa9x5/ejfZ1wPZA2?=
 =?us-ascii?Q?6S0fCnz05qhSuXUqW2KyH1T15TJ7JNBLokLNRxSUE0tzjf6KH9ZDDCYYSs5A?=
 =?us-ascii?Q?SqYU470TImP04TR1zZXaCB7ZGCsYA9zVaXLWM7xSeiuiwvrS43aO/re0C/mA?=
 =?us-ascii?Q?xbC9yjurzO/5jjAaDc3f9FaJCr0cDNbUgvoQov6BMKETONc7dkA5BvV9AD51?=
 =?us-ascii?Q?PB9OACQahGR1EFp3eklUgWeJ8EVy0XL7C7Wb8vEnJv2z92HK1E/SfskqX/gn?=
 =?us-ascii?Q?7i8JJZRZ/X6QWWSUt+b4dXbQK7dVFFs7W466Hsbsv90NkhoN4maf5cY7YX7+?=
 =?us-ascii?Q?JgPthljcH6mOS4WCRVsQLX8OxuHKAL4Ufo2+lFFKfiec+Zq3bkdlFz9g18CC?=
 =?us-ascii?Q?NO1IWjUgswDpCcuop1eFI/ekTJn3WUF01sKV7OqYLPysVuGN8olYy7mOxvuS?=
 =?us-ascii?Q?+yqQJWpNKipaizk1DmDeE0iMP5zlHG3vBQQMplcwCIF2Y1r8Ka4xcl0XG57f?=
 =?us-ascii?Q?uzNLQO61UBGONgU5Pir9u405q/KcgFqRNPcgkEbUInH6QgnR5eCtr3EY2hZt?=
 =?us-ascii?Q?Ui6O7p/JFYi190oXF9QpSldE2IK1NmdGdsBZ4PlONTcgY1rYl3SZ3tuq6Tif?=
 =?us-ascii?Q?icKVphgq8omI//aLLdVtSGXmCYdmsjF4axM0FKXKcLd+2cIKXPQCkUADl8SU?=
 =?us-ascii?Q?7VDV0L66jLAUvAmJQwAdIabeP0Ha4wpBdommLNz3YFk4gnja4kF+iJ22uFgx?=
 =?us-ascii?Q?gVtC8sc613v0nwTUvDEFQHxOOcCVxupg77KbcnY3PUlpdnWpybOMMl1pSNLD?=
 =?us-ascii?Q?O7Gz8zYm3UpyYl7+M2/ggC2lCeSTrSfx9QaamKutlEQI7FnMy4hCl8vrTaAh?=
 =?us-ascii?Q?tesYI2IEIG5DEhm24cNtj6U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7142099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJXlHboWpZby3vtLqQfM/OkHUKE+t74DeV375tsfGtgaf27lBsm/VhM1qaZ3?=
 =?us-ascii?Q?FUZE8xdfVl8baYUrgAJc18EQyuCmhyFhFYOVc1o1FNvbL996A0pgUZId8T7o?=
 =?us-ascii?Q?lKTfLHKecxZCpTLjYdxk82DHPkiNs4umsbUtLsdbWC/YArOfMg/PdvKgPwaY?=
 =?us-ascii?Q?2zQfH+CkKIqEQz0TcYUTuGBJl4HAb3qKfV07A1tz5ny2YcFZ14spdnIq0lLA?=
 =?us-ascii?Q?cBDJjbxTJvSWtbrjfS5PS4l3kuxwKib5EZ2ObQf6/O5QwzW6NSKo64XKWUTe?=
 =?us-ascii?Q?su1JgxkleKmTxlN7N4idgl06z4hJ4lHsjPEaCE41xyBWOGvhieGB1CsgT7jM?=
 =?us-ascii?Q?CaxGmRuxvQp62vqMdVeqH6R3POjPICBi+wxvoBhw12X/g8UZGRSFcOpW5Ytn?=
 =?us-ascii?Q?xP/YnVzXdGclku5AKFJKe/X0yXkyeSsdAcxPQ95QEmciEJDG9LX/ouM+HiRB?=
 =?us-ascii?Q?q70BwhWW0R/5mGLmbXnrSgtQNLL/oRAFR090bNaphN4E/rtNZzb2EMfJr767?=
 =?us-ascii?Q?CXDlFyatMzQdWtBdWpTtGuShv7rVasqFVFKcC2cqton6zEADSwA2NLl0g2PT?=
 =?us-ascii?Q?TC6w6Tw6b2LtBxt+cQlbDk3ZAdUPlo5DChCzxh44iJEZoUb/jKtWRiF0xj2t?=
 =?us-ascii?Q?Axg1HIwR06HEAhCXwy+PrVJJHQzKJDTIHenn5tXsUuRFPXBxu1JXo/VjQSaZ?=
 =?us-ascii?Q?AUdBCLjuvfwbIgefnEWju0P7b9QMVdhBFsKLLXCuo0FKy+B987WwiKWxo7wu?=
 =?us-ascii?Q?PXluKRa0tkGy2YfhQNAILkikKjrHvphP9/ozq9jMwyr1QE3jitp5V3uRIFKO?=
 =?us-ascii?Q?09/OXCrjKM+VLJqiuLtVaLBZMiAo2wtkzaxnLSWiCJbduKB5lydutERZ2488?=
 =?us-ascii?Q?umgAfbyu0tLxeqj3I14/IV1YZoB+RW3oYfnX83kLaYjaCALFnpbURVuQUKBo?=
 =?us-ascii?Q?HafeSbfKVcyDDbDYzU0Q9Zq2d4FXU5T80zoaSvjJtsOVeQKjyWXrMHkiXSW5?=
 =?us-ascii?Q?lQhZxMrMUnkQHOSWCFUxT8yPvSRUbqxc9pkY03vLRE4xFQbIa2o97cBIWLMS?=
 =?us-ascii?Q?c7R450JOKXFX1usUFP7VlDiH/Gkk+J5f0BIrTO7Uny5PaHMgv5VIhE4rPPMl?=
 =?us-ascii?Q?gPxggNdLkQHm9Zl6ow3PxCnra8eJhLEJF9ZzHI7pMyuXm4dW7pihyPz21bPa?=
 =?us-ascii?Q?LZdm94JW6MpthTdMsvkzH79jsHCLWsCh8CR2qjvR85pNuhFVOAffwZBn4EJV?=
 =?us-ascii?Q?H6cdHvKDoUSGI3r/Lg0HaisTzgT8+G61ECyy+ePIZbdA80f3coTNtQOJJwFt?=
 =?us-ascii?Q?K2pXEkAi5igmPTuIQbJcS44CuOfcchH76BDDHhr8iqY7q9dJgYkKHfKYfiTY?=
 =?us-ascii?Q?bYKBfcFGSysHJdQ5tnt+p+wC85wp6tla2fXLLxHaM1IocvsMyr3+qzO3a27/?=
 =?us-ascii?Q?7Qpv4ClBI1hBDvMMqiFk7EbDhCM2Xq/IIeZrUrcDxVGaxxRf/uk+ZN39Ph9s?=
 =?us-ascii?Q?gJzm/EBrFDgadM73r7/6bH96HIN2uHuTvQN4nJhbZ2V4vxr6vSX/8JPEAfAV?=
 =?us-ascii?Q?yXs/Qc1TkBWTVUZxZogPMG0BIISwcvV8LFIi6tf9/aDXitOLXfDuByhiRyPd?=
 =?us-ascii?Q?tCcCde8e3+/DgHCeD9Ca957eSy+ramZ7L4la03KLsaTe+q83r08vDVwKFkvl?=
 =?us-ascii?Q?8KFUvn21JTG9n2YoZn9F4jEXD2lJCmjaF0d00KaJGv4F67CkFM6Ac/0qK13+?=
 =?us-ascii?Q?ij6gCdfoPcGxF7I4wXmmsiV0pMBWzbs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e56a82-30ab-4bc2-2696-08de5f32caed
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 12:34:49.1999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FU77weR6qRS9eTeNDzDvW8wYnsk45n26HThEkcO/Mn8hReWwz5xfapqEIB54bKl4tTBhXiNQTjtMcMqfindwyGkAHbFNH/2lCVlPpckUZ+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8066
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

On Thu, Jan 29 2026, Olivier Benjamin <olivier.benjamin@bootlin.com> wrote:

> Hello,
>
> While reading section 5.7.3 of the FIT image spec [1], I noticed the
> "cmdline" property:
>
> "cmdline
> Command line passed to the next boot stage, e.g. the operating system
> kernel. The value is an UTF-8 encoded string." 
>
> However, looking at the mkimage sources, more specifically
> include/image.h [2], it looks like this property is unsupported.
>
> If properly implemented so that the cmdline can be signed, this would
> imho be a viable option for passing the dm-verity bootargs in verified boot.
> It could be an alternative to the option of sourcing a script that has
> to be referenced via the configuration, as discussed in [3].
>
> I have not found a discussion regarding supporting this property in
> U-Boot, has it been discussed and rejected, or has it not made it to
> contributor's priority list?

Not really an answer, but IME it is much easier to embed the kernel
command line with the kernel image itself via the CONFIG_BOOT_CONFIG
mechanism. That way the cmdline is automatically verified by whatever
mechanism verifies the kernel image.

Yes, if the purpose is to embed a root hash for use with dm-verity, it's
very annoying to rebuild the entire kernel whenever the rootfs changes,
i.e. all the time. But we don't to that, we boot using an initramfs that
has that root hash embedded, and rebuilding the initramfs (and then the
FIT image) is much less of a hassle. 

Rasmus
