Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E01C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0F88091A;
	Tue, 13 May 2025 14:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="HxDyr0J8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8363B81DD6; Tue, 13 May 2025 14:24:19 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC288800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 14:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv9ERL/J4nnuK+Ik0yOBQ5SZ8TnXn037DnWjkNim/QIU0JY555mSqWGj07x1XP0TPDG0PfZqp9sdOiYjoChzQTWjK0oUUb8h2Adk9Sy1cC2EznHC5YoSGsfyx3R1Bc6whDnlMeCZEvwM4hQAWU1c6vCmVTEkRKPs/ltqymiXYGJjLVbSFphghJmeHrQpTAVB0iWERtLXvBH37XEC8+6YQKcZqyS1cQs25wrssTL4HSHRbMIu27RtpihDpr/1DL+znhTEPY0aDKaRkSFmBK1lb64BllMMELoJ3dWnpyNnF58pxIKQM6kEw7nmsEUfoVkQQIz5knHD3K6k1HEDoTccYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3r+MkLNvs9vfvjY1CZSmBxUgYiCLo81XnMKOFFvkCA=;
 b=qHkC7+xfoIrAxT0tCiEzc51yccRVpA2JNPsHUn0dh8YJxH4ZchvO3AAG5O3Nt6ntw1J4rlGuNf4ZwejM5/MCni9hE9mEa0nNgmOfHFX0f2UDHeJF0Rm6iXYH7WdIwXCkbhZh8ntZdkjRhfjCNgEjw2HzumY5iFDhNrYBBq4Vlao9GVBSmfuqrpiq5rPziCbIt+ruidEdDMhEqH5UnX75xcUBvIWIMQiktz6eDVIxUMu+kHKmM4s9VsodgmumSSsnpBdxP5esYmE/LI8IDTWMvC0WfC1ulVO+PQKh1T2TL8DHyTrBRTls8ZrdZSMKgQDWj+xIuav+waa2Q5CwMHiukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3r+MkLNvs9vfvjY1CZSmBxUgYiCLo81XnMKOFFvkCA=;
 b=HxDyr0J8R8zTAmbVrxvYYeZK7zxL9JEKKumNXmXmSWb6HDgrJXzYJ+u5mJtPzwCLjkfxRsQrNT3BJl8juy8Ej4ZuqP0WAsE+TysgP7Qw3AzV+AHH/3rh/NM8H1TeYSmNphzOXSZcsor8bevneE01Us2ls0B9s1Nk3WWuRYVbRws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB9071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 12:24:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 12:24:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: <u-boot@lists.denx.de>,  NXP i.MX U-Boot Team <uboot-imx@nxp.com>,  Peng
 Fan <peng.fan@nxp.com>,  Stefano Babic <sbabic@denx.de>,  Fabio Estevam
 <festevam@gmail.com>,  Tom Rini <trini@konsulko.com>,  Tim Harvey
 <tharvey@gateworks.com>, emkan@prevas.dk
Subject: Re: [PATCH] imx8m: soc: cope with existing optee node
In-Reply-To: <20250310123621.389594-1-vincent.stehle@arm.com> ("Vincent
 =?utf-8?Q?Stehl=C3=A9=22's?= message of "Mon, 10 Mar 2025 13:36:21 +0100")
References: <20250310123621.389594-1-vincent.stehle@arm.com>
Date: Tue, 13 May 2025 14:24:13 +0200
Message-ID: <87o6vw4s2a.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MM0P280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::20) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 3488cabe-482f-4828-1584-08dd921912a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmhZVGkrbzhQeG1lZmoxVE1RWGQ5OEFDaEtsUlFXQlpwMjErZm5scDFLaHVK?=
 =?utf-8?B?RjIyQWU4YXdPdlUzd3plcmJ5bXptYW4yUFZQclVSSnJxbjl0U0dEelpTT0VM?=
 =?utf-8?B?MjdmMUlXdFA5VHZ1Z0pkakttT24va2dkRkdyR21KZnlHclpIenhpeEFoS2Fa?=
 =?utf-8?B?Y3BYdzhHMHpVM1NPZUU3MnU3WW8yaTJmOUdSSnlORG1xNHBFdWVOQnlhdmZV?=
 =?utf-8?B?bTVXdCt5YjVVNzNueFJiYkZOcnVic1lWZUVBbTBaRXRMM2hSSXoyRWhwOGtv?=
 =?utf-8?B?N0FNWXdBdkwwTlUrUHE2NkRUUHNlMlltck5CUG5GUHdXaHNseEVVQ014UGY4?=
 =?utf-8?B?L3lYYU92VTRhNWVSNExxSnRIak1xckd5WGRDY29ubmZHbVNoMHk2RnM4bFJY?=
 =?utf-8?B?V2ozeVV2d0doUVBJSlNpSXdueU1yVlQ5Vnp6MDFZZVNPTmJ5RDB4a1VWN1JK?=
 =?utf-8?B?TWR0bmJYMWZKcGpHd0JBR3FiOUJaaFRJaHFuM3ZFa1BuZ2hXZU40R0VoK3Zt?=
 =?utf-8?B?VHJGQ1Q3SG9WamhnWnVOUmozbExrOFc0UDdvc2dHNFRmVjYwSGE1MFlqUTln?=
 =?utf-8?B?MTdxdGkwbDdLTWlpbGR0U1M0NXNnaFZiS1E5QW9yYnFpQ1pRa2NCbDgrUjJ5?=
 =?utf-8?B?ZnR4N3FBN0hYdW1MVDBzUVd3ZThpd2JiQlAwcUFkVWdRTEhvRk5kemk1SEh3?=
 =?utf-8?B?a3dpRTRlelg3U2FDYjRIK1dySzlUeXNSNmRkRFhTbEFvdU01RzFlbElSd3FT?=
 =?utf-8?B?ZW40ZGsrOXliOGFjMFMyYmJEYXUrWFlYSUdXOGVuSElodU9zaEN0RjVYS0xR?=
 =?utf-8?B?cXh6RnhSVmIxbFlRTklSb2N4QVBIL3FzbGlJWXEyTllGVWFKdWdPMHlWdC9U?=
 =?utf-8?B?UzRDQ21oS0N4bHl0bElGUTJOcVJJV3JnREsyTUgxRmVvR0RYeFFQaW8zeWhk?=
 =?utf-8?B?U2VOZFNnWmFwMTZyYU4raExnOHJXbXpUS2VXa2gxeFVnVVpOaUkrTE1MUHRB?=
 =?utf-8?B?M3lMbDhUTnJRVnM4ZlZ2dXFnMms2SVdacG1zWi9sUlR5cTFHelU1S2pHb1B3?=
 =?utf-8?B?bWRJNE14Yy9WQ2I2RWZRVGJJWWtDRytocDhERVluaHhWOTZYOUdJNlkrVW5S?=
 =?utf-8?B?cGQzVG9zdzZpcExDTXM0Y0pjRFptSVVrdGFZUFB3S3VsYkdjN0VmWEdkUG1T?=
 =?utf-8?B?cVJSUHNtRkNkSjJIZ2NacHc3dTNCNGVjMkx4amlTVFN5dUdJckYyRXZsb1V3?=
 =?utf-8?B?VzB1TDNXUWpVVFd4RWdZSjk0K1hFczI5TFAyVmNsSFFSOHpiNGJrSFRPcGhP?=
 =?utf-8?B?VTJnY1VBZnNLd3FqZ2tkWDY2bXkvWjVjcUtFZWFWUXVIMEgxbTJPQ1RjLzgr?=
 =?utf-8?B?cVF3Zm93ZnQ3bXRiYjZLUXVDSHJqNVdKK0tqbTEvNWN4TVgramEzaDgwL0ZZ?=
 =?utf-8?B?ZW5JVmluT2lodG9XS2NYWjl4L0hZNjFRWFozK3oxOWUwb2I4YlBnNnIrSVIw?=
 =?utf-8?B?KzFYTDloVW52aS9yYnlKZXZ6M0E3ZnZ0Uy9zcUNoZTJrMW1NY2p5azk3RjZ4?=
 =?utf-8?B?bE1weUhpYzFmb0NnN2gyWDViTFVseUFNU085Z2RPcHN5TXVpRm1UVEpKdEJD?=
 =?utf-8?B?ZmtURlRZNlpOQWtaWXdiTk1qcjNGR2lBTkhvSzdJRzdMTDB3QUF1UUZNNlFn?=
 =?utf-8?B?L1NzUjJ0Sm1vT1pOQnhMQzRmc2tQa3dTOWxGek9wZHJpZFZSenpMQzlwMTlm?=
 =?utf-8?B?Ui9RQ3B0K2FWTnQ3bHRyOWFwYUxISkw1c0pORzdhMU9abVlQUXE0cWhmQ2Nl?=
 =?utf-8?B?ZTZmTmtsUmIxYjEzRU45RllHLzFvblExZ0xxUjdIUC9sQ1pQYzlvMTIyQzZD?=
 =?utf-8?B?eUkwRzU1RDlrVU5SU2RnUWY1V2tRNU5oZWJ3NERmZ2QrZ0ZHNjNHUWZDclpT?=
 =?utf-8?B?Mm9iS1k0UStsNU9qVWlXbC9RN21zK3ZXSFdUdEhsTmFLRy8yeFNtWWxhOW8r?=
 =?utf-8?B?L3JsdG5pMlJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNrcm8rODVLNktnejF6NSt0U3REb1phNkQ0SEZsS3FYSWd5YWNiaEROOXFJ?=
 =?utf-8?B?d01IRzFzR0YrM21PeTVNdmIzSGZXb2M4dTl1dVdBNUdPK3g1VmxLRm1vRmtL?=
 =?utf-8?B?U1U4dTh3SUd0TnNTWHJhL2hhK3BHcVhpc0lRUXVYa2VXZGppSEt5R1BHdGJR?=
 =?utf-8?B?aFR2UmNiZGl4WlZPT2ptK2h3aFpTRWFNREI0K2pSeXB4OExRRk53OWhsRnVD?=
 =?utf-8?B?dnY1d01JbnlranRHVmtRMXBjM0lWRzY5VGExcVZDb29oTDBaVTM4Q2RvMGNs?=
 =?utf-8?B?KzRVODJORGM2cngwcUdDUEE3NFIzMVBMN3piaTZydGpOaEFQNVJ2RE8xcTQ1?=
 =?utf-8?B?b0pXSUVQK2Z2VUNoSzhNa0ZxaG9kdk1CbUVYbTdrVFozYjh2NDRCQ0lCZnR2?=
 =?utf-8?B?a3N6SEJ4SEtWRkxuQU0vbUhveEhyZElndFVXNDZNUUhqYUhoU0hsVlhocEFy?=
 =?utf-8?B?WGZZUEloWisyV0h1MCt5L0MzSzRlT1JZTW9GU05VMlQ0OS93RTZRUUhOby9B?=
 =?utf-8?B?RWo1Z2xKVWM0NkJVK2plTDkyb0xOdHBRRWZSSTV2NnhVQjE5Q2F4N2Nsa0M1?=
 =?utf-8?B?VElPNmlTN2hoVitPTitDYTJtOXhSOGZTVnNmYnA3MURERGZzcjlLTzRRYmVH?=
 =?utf-8?B?cjZKR2JUZUQ0N1RrSVlnalhsci9IMUloMGJYeUNvYitubVQwU25GdS84RGI3?=
 =?utf-8?B?cnRjMStuaGR0aTVkdXBZZVZxSkhISThWZEE2VWg2RUJBVGlzRnU0dlVuYmVs?=
 =?utf-8?B?aVhQZkEwNlIzY3BzRFR0STFOam1HQVRPQlRxVUdqL280S2o3N0ViMGhVSmxs?=
 =?utf-8?B?dHhhWXRqNmVUMnRQL0wrb2NCOTJsTDFMOWl4THlGQ0tqcXM1WTZNb3lZMjE5?=
 =?utf-8?B?ZUxoQ1NWNVRrVjBONDdiUjJVWDBzYTNuMVFFdkNpbUxuVVBJdnV3bnJVUm90?=
 =?utf-8?B?NlZiUjJ0OTFhaDZBbjd4QmJGUkp6SUxWbi9BMjNhbnZtSVBqMEp0aytHT2ow?=
 =?utf-8?B?STQyU0tQaUg0RDdyZk9hZG9TS0t4bVBsakVuWDF6YVpSU0J2c2s0ZmY1azJt?=
 =?utf-8?B?WGh1TWlvTnFGYWZpS1RVUFRlM29ZQXQ3dkFPS3FadmtMaXdPR0tOSkdEOVVn?=
 =?utf-8?B?ZW9oWFUrR0VpYkM4UXl4bVZrVmt4MnE4TGRYZnlqSmc3Q0U4WjFGK1hJdzBB?=
 =?utf-8?B?d3VJb290bGEwaGppc20vRVNISVV4T1dOSXpyZUJnN0Ixd1k1SUE1WTZFdHFn?=
 =?utf-8?B?Q01IK1RQRFpIQnBuQTJWSlVEbzVuWkVDSEZaRmEwOS85TTZQLzV6VVFGUVRm?=
 =?utf-8?B?RkJKYzBUSGZIa1FvSzVrQ2pQbUxlVFZxdWdjd2pjWUl4Nys3c283V2FmNTM2?=
 =?utf-8?B?Rm0vaE5Jb0FlalJxVGY4ZXVXaVRqSFRXZnc3cWo4VitzQWR6dHFkY0NxOTRp?=
 =?utf-8?B?Vm5HaVYvWklsVUYreldVSERaNWNuTkhxY0VjZFpZVXp4Y0EzczYxOHRyYnR2?=
 =?utf-8?B?SVQvajVZUWFjaExlSWNLcWV0ZkdlbXRtbG9CWUQxUTQ0WU5Wa0w1TkFra0Uy?=
 =?utf-8?B?U21Gd0Q1b0VxbUVJV2NWeHNHMWl1Nml5Yjk0bCs0cVpCRzZtOGhPdUJmSmFw?=
 =?utf-8?B?UGdKcWM3ZWIydkFkK0Vwd1ZEU3dCNzRNUlNjeUVpOUY4TXhzYytJWHJSVzR6?=
 =?utf-8?B?NHBmQUd3VlgwRVQ0SVlaL1ZIeHpwcTkwWENaRWRTenQ1VEpLbThyT3NGZjJM?=
 =?utf-8?B?UERtVE9QWTlMT09xb202ekpuRWdtc1AweE9jL0xTRURiUGdXbnBJMy9sdEE3?=
 =?utf-8?B?eWtYOHIxeC9WQlRJV05GNEhLNE1uOVdOTHMwVFFtU2c1YlkxWU9ZMUJhbzZ0?=
 =?utf-8?B?TktRUGZFVzQvSmZkaGt5a1d2UDNkSURZL2pkWm5USU1mZ1dnREtaaFh6Nzlq?=
 =?utf-8?B?dFNKTTdvVVpaNStoenVnaFR2czR1NmMybmJMUnRUVDQ2OXpTemNpejZQQnZa?=
 =?utf-8?B?OHlnRUV4NHIyV2o2a2oyQzVQRC91amJXZTdqai82RHJkZS9TUXEzUGFSUkF5?=
 =?utf-8?B?dmJReHRDV2s4NTdYbnRvNmtLbFk1NCtySCtTbjh2ZDRHQklnZUIxSkNENno4?=
 =?utf-8?B?cFNYVHJZcEprTUVsQmVBdWlTRG1heDh2Qmtac2VKQ1VvY3hheUpqT3d4U2o5?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3488cabe-482f-4828-1584-08dd921912a2
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 12:24:14.3524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1B+kCfWIBfSgpMay/wY+XWWt80onRo9lE3wQAfg61iw76RFVL/pY+o8AevpLw2wbN6QtW4InWvz+EEU5or4BfSBhf2svNibDA9jH/aSzISw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9071
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

On Mon, Mar 10 2025, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> wrote:

> On i.MX8M SoCs, the /firmware/optee Devicetree node is created just befor=
e
> booting the OS when OP-TEE is found running. If the node already exists,
> this results in an error, which prevents the OS to boot:
>
>   Could not create optee node.
>   ERROR: system-specific fdt fixup failed: FDT_ERR_EXISTS
>    - must RESET the board to recover.
>
>   failed to process device tree
>
[...]
>
> Deal with an existing optee node gracefully at runtime to fix this issue.

We hit that exact problem on our imx8mp-evk trying to boot
v2025.04. However, since the .dtb in our kernel FIT image certainly
did/does not have a /firmware nor /firmware/optee node, I was wondering
how we could possibly hit that FDT_ERR_EXISTS, but we clearly did.

Digging, we found this, which is now commit 048fabc21bf. But I'm
wondering if this is really the right fix. Because digging further, it
seems that it is U-Boot stepping on its own toes:

We have the generic

  optee_copy_fdt_nodes()

called from image_setup_libfdt(), which copies various optee-related
nodes and properties from U-Boot's control dtb to the blob which is to
become the linux kernel's dtb. So that's where the /firmware/optee node
is really created in the first place. Later, image_setup_libfdt() calls
ft_system_setup() which in turn calls the helper

  ft_add_optee_node()

and then hits that "oh but the node already exists".=20

It seems that the two highlighted functions really try to do the
same thing, though in slightly different ways. The former copies from
U-Boot's control dtb, while the latter hard-codes the compatible and
method strings and (re-)computes the memory areas. So using the
"find_or_add" variant does feel like somewhat of a band-aid. Shouldn't
we have just one place that updates the kernel dtb, instead of one piece
of code silently changing or redoing what another piece of code has
already done?

Rasmus

PS: On a somewhat related note, it seems that the whole CONFIG_OPTEE
stuff broke our setup in another way: We used to have
loadaddr=3D0x60000000, but trying to use that address now results in

** Reading file would overwrite reserved memory **
Failed to load 'kernel.itb'

because somehow U-Boot ends up with this memory view:

lmb_dump_all:
 memory.count =3D 0x2
 memory[0]      [0x40000000-0x55ffffff], 0x16000000 bytes, flags: none
 memory[1]      [0x58000000-0x1bfffffff], 0x168000000 bytes, flags: none
 reserved.count =3D 0x2
 reserved[0]    [0x52f020c0-0x55ffffff], 0x30fdf40 bytes, flags: no-map
 reserved[1]    [0x58000000-0x1bfffffff], 0x168000000 bytes, flags: no-map

That 0x56000000-0x58000000 is carved out of memory is fine (that's where
op-tee lives), but it's really odd that all memory from 0x58000000 till
the end ends up "reserved". The first reserved entry is, I guess, U-Boot
having relocated itself to the end of the first chunk of memory.
