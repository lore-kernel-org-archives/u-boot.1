Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A455C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 13:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0331983145;
	Mon, 21 Jul 2025 15:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YPMkOlKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C1C83152; Mon, 21 Jul 2025 15:01:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8F483118
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 15:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjX+dP9WgCXtwww4LoJC5GJqvGFFYWWIWomv2EBaPpotjvzPJCAOf6cmV60UOCM45qGIOVepMSD5VIAixZqrG/XIogh6q0PfixWpWvciVwLjiKViJXI7sQxnrGl0fWcKCzdQNQQWkSjB2Kxlc1i6eJmcTuaNIHEmqUIoIvUFytkz7qrl0j3LyUlAcVs2zXx/fBxbpBEVTGZSrlrtU3SrNEX5WF740+VW2+GwICSwC+Q4037axdFMpS9LKIUOY1XRb3LENQMb6a9T14eg4CmI0K4WguMz/3oDlosGLnzJhNTPoKwxuiiAlM5W+vfzc8FE+YTFfd1bwLJC/TEvYwjoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgJeJEHjLii0idCgX/KDnh8Rkd1XaGtWqcqtK2lhIsw=;
 b=oUbHr1tNJi2e1q1R1z3isOguFVxgCUYfhqwG1mPVg917eynMDGthNdgQKef5bFD++pfdzePdVM/PKP1KTN9kd4Aqk0gDbEbCZCDPQEKrq9pytbvt11QpgVB2NEFRY51AvDTTu32LlcejgiASlw+OICaGSVVYzyGp1ausN7O7LA+ROOGs8XjwdVlZWOzVoYNpccksfYEzY+lQzsC6/MIKmeWVJbFymfgMFQ731v+BVZRZf2TwOED889J4nUyqIN/m1HnPtp9iWMmRT7vmmjnbta8jJ0MqvV7aWidRKyYUu/b2yGruUzTCooNJmUZT0P5Pxm8z9cUgp0us1aHwqHG2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgJeJEHjLii0idCgX/KDnh8Rkd1XaGtWqcqtK2lhIsw=;
 b=YPMkOlKlEwNdmTNzDcG50grW+75UjV6LE5uh3jjZufl3hvAya0moh/ELA9IIK4oC05LuYqlGg9W+zW5wWxHd4Xn5aBmGj9dtCEJLJ4uDBrG8A1Xd5y2wrm9XnwcTkL5bjjNk2enioYjMPiFX222rTtSCt3g7XmGaloc/FOw0W2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB9486.eurprd04.prod.outlook.com (2603:10a6:102:2a3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 13:01:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 13:01:36 +0000
Message-ID: <20a08d1b-2b68-451b-b7e3-6e6f2bed7601@cherry.de>
Date: Mon, 21 Jul 2025 15:01:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx6dl-sielaff: Convert to OF_UPSTREAM
To: Frieder Schrempf <frieder@fris.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20250721125148.167020-1-frieder@fris.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250721125148.167020-1-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0031.eurprd09.prod.outlook.com
 (2603:10a6:802:1::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2bfc81-4cd7-4f8b-60aa-08ddc856b962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFhia2hOMkNVdFVucGhUVUpzenlSWEp4M25ieVlnbkMzbDNzRFNUalprLzdw?=
 =?utf-8?B?c1RqWXorNmxaejRFRWYyUys5VVB0TTJHanEzNzVhSkZRQUx1SC9oYWFCSWln?=
 =?utf-8?B?bk9Vd3lEbFNiMi8xa0pzdGtUUnNiclZmOWUrK1lOT2RFTENYeUwwcnNPMzRl?=
 =?utf-8?B?SkNaNUVYZ0xaZlJUR1JzMkxURXZGYlJlRFM1Y0lWZER5U3M2a3NHeXVaM2lt?=
 =?utf-8?B?M2VmTnF4VEt0VjMxRzdYRlhQY2FiaVYxV211Q3YxSXZFMEYvZGs3dXdCWUhB?=
 =?utf-8?B?VUkzbWt0WHcyREhwRm9wUWFTVVl4czQwTGRGcUhYcTlsbnBzc2pmMjYxUmRL?=
 =?utf-8?B?ZmpkYURMUTBWd3lNc1BUd3dCeUs5SG5TQkhuY2NueUpHVVV3WjYxUHBQN3lV?=
 =?utf-8?B?VFNVcDVjWVZkdkVsangyb00vT3NiTjF3U0VyS0R3NldQVlJDSFZQZmgwRzY0?=
 =?utf-8?B?VmhiSzNEOUdaYUZ1VTBZTUhIVGI4S1RkK1JuTDFnU3dnWElXNU5lREF4UlFn?=
 =?utf-8?B?T2ZFdUllMWZ0eHNqSHpRT1hqTWp0MVl4NGo1LytIVS9pdFFxRnlmZ1RPTXlZ?=
 =?utf-8?B?TmQ2MDFLczd1NWN6dUtLUit0V29yay9Dd3BvbVY2eUN2NlhLU1Z5STRla25W?=
 =?utf-8?B?ZFFXMjFJRm5ScUdPK1JNYzlYVUpSN2kvTENGYlJZdnVrM0h4Z2hSV0lzbXph?=
 =?utf-8?B?NUhyNVVCU2ZiR09qMEVodzk4TmtYTGYzWmsvVlUreVEybTgwRkc1d0tNelF4?=
 =?utf-8?B?b1NIeEtqTVVCT1RNa25weXE1ZDBGV25SQS9zRWxPSnVIZUJ5dXdMNzNMa1ZJ?=
 =?utf-8?B?SVRRV2RPK2I3WnRZNG5heVBuL2VOOFcvK0R1NWxWc1E1eDlUL2dza25TY25x?=
 =?utf-8?B?aUFMNnFQRDRwM04rZUIxeWhuV25yS0pmdVIyZHdQLy9WRFBpUktPbDdaN0JU?=
 =?utf-8?B?N01nOGVPVlNGdUJkb2lZVFY3UjVzaFQrZjVJa25tVmp3WU4xYjZzWjVpVk14?=
 =?utf-8?B?cG84RDRoeW5RcFRuUVRPNHdxZFlBOXFHTDZOamhnMHE3M2VpV1RZWWRXREpq?=
 =?utf-8?B?K3BzQWpMV1lnV0lVc05qaERTUzZSQzZCc3NEbW9RVXJFNHRjaThwN3Eyd1dP?=
 =?utf-8?B?N2dxRFVpbTZwQ29ZdXBxUXZPUVZmK1JkOXdERHdTQnI0dGVsWEhhU0tCUzJU?=
 =?utf-8?B?K1JvdytXQnYrc0hLbS9DSGhDMW9rU3J6aHdEMXNGTXlNaUg5eENQUXlxZWdK?=
 =?utf-8?B?b21xM0dQaS9DQk11anYyUmtRWFRaOGZCdGFOaUNWV2NGZlVFUXhvNGo5eVYz?=
 =?utf-8?B?MVlBbUxRT3BqaVhIWER0TWRVcVZwcWR0czAyQm10NldWVUZwMzRPZmVBQkVw?=
 =?utf-8?B?NTNpMnJiS0xKSDR4eVFLaXJobEJJWWhkV00yMGh3V3hLdWp2MXVLbWE3Y0Nx?=
 =?utf-8?B?bE92YmZ1OVArMnkyb2kyY0JQVFFwdm9Cb2JaTy9la3ZyYXpMdXNzbzU5MTYx?=
 =?utf-8?B?YVNIY25UMm9zNmg0YmFWOTlyTUJiaGNHNWlNdjNBeVBSWTJsU2JBVHpDZ0s3?=
 =?utf-8?B?VEJPS3RlVUgreGgrLzVDZHdwUWpCRjM2dG9OMXZuZVRRMEZEc256YnVoN2RR?=
 =?utf-8?B?N2phRUY5Z0FoaFRXZ0xiSHArUW81cEJrWmtHWnJqZ3JSOUZzdWtVK1hOSFRN?=
 =?utf-8?B?ZENPQzhhZEJpa1VTSXVzZW5kaEhjWlA0ZGZqMmNnUmIwSTN5UlV3WjhHRzlY?=
 =?utf-8?B?QWt4VEU1aWZmdmhKTm1FSnZUM0k3NzVyS3dXUG9UVjFNbzlUMkVwR0Q5aWlp?=
 =?utf-8?B?WjBQdGY2YjFtZHM0Rmc5amJkWEloQTlReGFwRzFaNFh0bjcrUGhoeWF4em1R?=
 =?utf-8?B?d0R4eU5EOVNEQzc5NTkxYVA5OWRDZGp4dHFwQ3ZmbUo0MUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVtSVlDUkk3eDRRMC9zRGtHdGVaQTdkOVhrbUNhbVd1V2JsaXpWWlJtTDhW?=
 =?utf-8?B?YkdaU0hZbWpWWDdpRnpiQlpXd05GdldKd1lveENzRDdyZXN2dU1DTHVDZkRn?=
 =?utf-8?B?NGxMYS9UWTUwU2RPMUdPcitabURERFFkZnZpaHRpdWpMa2d1dzBrNWdXb2gr?=
 =?utf-8?B?M1hGY2RYblNQV0RIOFpZcWpoMktYMEtkaGJKdFlEdldsVG1ubzgvckczMG54?=
 =?utf-8?B?VTFvVThvRnJJLzlZdUg0QVdGVi8yaUN4bEpKRzZKdEJ1bURMc1MzSWlXdmJt?=
 =?utf-8?B?OGpSYm5EWkROdHVFRjBlS0d3TUNvSzViamwrRU16SkJNSUMrSHJocDBCbjNS?=
 =?utf-8?B?bEZJVDYwR1lucDI5cTJ3SUxVUkxEbHJjNzVuK1duWW4va2pBbzJyU1JEeEc2?=
 =?utf-8?B?QWJZellaYXNRcDdRalFIY1VsdXFxemlWZW9WUGNlTEppbGc2OFdOSmlaR0lZ?=
 =?utf-8?B?Q29yWDJMc1FyT0pmRVVkb0pOcnh5NGJ0ODZzaitPSGl5TDFmRE5JN3J2VERI?=
 =?utf-8?B?clB1Wkc5QURDSmhqRHRNaFZvRmh6RiszL1Boc1NUMU0rZlN1b2ErNWhucFpJ?=
 =?utf-8?B?L3dhMFBhNGp5Mm9rUzRNNEZBelI1bnp0MjZuOFUwMEZkTEFjSzMzWEtQWENU?=
 =?utf-8?B?aStOZlQyV2RlZERhWU9rVWdQUDNqSUlKendqVW5VenVybFIwWHg5aktMbjRm?=
 =?utf-8?B?TDZ5cnRVRHFrYmRuQmFTV29mVFFmRm1jditocVFzdDU4eDVGR212Nm9Bd1BN?=
 =?utf-8?B?bXBvaURna2hiRVdvc21UVlBDR0RWZmFJUTdxQ2xhei9hdTYweFV5TEZsVXhu?=
 =?utf-8?B?bDdRdXIzQmVDcldvbzdNTXZiUGRZeFdZdEYyNWF1UEYvMEp5bWd0L2plaGw2?=
 =?utf-8?B?bExwYTdFVDUxNFhLdjhqcVEzOVdHSGZjREVpUlZ6ZUxoeG9IbldVVU93V3hO?=
 =?utf-8?B?M1I2Qk81aE4xeHYxOU5rMGZkTEg2WHN5WTVHeXFuajNNK3B6WEtTRVBtTFRQ?=
 =?utf-8?B?ck1nbFFQcnRzaDlWRkQ3b1dqbURQQWtpUWEwQlVRTzNDOUdOWnQ0SitKOENT?=
 =?utf-8?B?UVMzVDM0QlkxOGNTa2FhVDRueDV4TkE1YjRkQkJrV3ZJbzljWmloWkgrUVcz?=
 =?utf-8?B?cjNoaUNRTzJIZlZnRmo3OVVtbVhJbFlqWVl1ZllES0g5Tmx2bG5DSlZDR2hl?=
 =?utf-8?B?ZTNKWis3bkwzMkpsUjFZSVlybEhaWHR6Wk9MYWx4UlBxU3dHdHYxWDVHMXpY?=
 =?utf-8?B?R2wrclZ3ZkpIb2JxM0pvQm04SEs1ajJOQk54MTB3dS9iSlZ5K0YrbUsrbTNx?=
 =?utf-8?B?dklKOVJMajRTeWcvTFBPU05mTWJBbFFOYU9McVI5NDBrQTVKWXVka1VDS2Y5?=
 =?utf-8?B?bjJBL1hXWW1Tbm5OVlM2azViMU9XMDB5VWhwSUFsR1B3QzZiaDM5RzVHdndI?=
 =?utf-8?B?L2lvNy96aTQrZkNhNGswOGp0NDZLTnQ3VUwvb2Z0a2xaN2RsenJwUVlOTmll?=
 =?utf-8?B?TlRUbHk1RFhYeFFLZytUV3EyYmlsRURWSjRCaENVakFhOXY1d0RFWUptUkEy?=
 =?utf-8?B?QWVUbXBaMmRBTUxpR1Q3UjZJTzhnQ2ZHNktOMDhHSnB6VTQ0c1JjdDFqN1NV?=
 =?utf-8?B?U2c3aEZaM1RreWN6aksxbXV1Q1NaelpGeHZFU0N0aWxKRms0NXRaNHlZUzRS?=
 =?utf-8?B?NUQ3NkV5Y2FhT3RBMmxYaEZzeC9wb3J0dWJHbUo5cjQxSjROMUZPOVl4enV6?=
 =?utf-8?B?b2pZeHhZck5SUFNTbDRtb3V2T0haU3RZQTJhWk0rRCtXdTFtTmRmY1R0QnU2?=
 =?utf-8?B?TnRzMzBLWDJpV2U1RkpQQVRUeWJCSFpxVCtvZWhka0haNmNYM1BvY2pKVk4x?=
 =?utf-8?B?T2lId1RUNTdmazZRTm5vcksrYXUwbkxMRmJVZ2lvU2ZXenVRRkFLSzE3c3ls?=
 =?utf-8?B?TWxwdmJSSGJZU093QnZ1MGNJamlhcXFkaUdCNkxHS25ZWmZOMWkyV1FoNlgx?=
 =?utf-8?B?dkFDaVg0MnRaaDRVUEVyS0NaT3B0RXRCcEJrdFNGc24yWVk5SlZ1YWs1YzBv?=
 =?utf-8?B?Uy9oTXJzTnV0TkJLZ0VaZnlxRXQxNS9xOHN0L0pvUnAzTk94Wm1neGd1N1B5?=
 =?utf-8?B?dnJyVEtiVENkOVNyNm9ZUGp1V2JMNXB6Ryt1Ly9ydjJERTkwVDd1b094NzQ0?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2bfc81-4cd7-4f8b-60aa-08ddc856b962
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:01:36.2868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyMfz0CrEWJJL7jRIDbJ14FDoitB/VJ+ZlBko9C7coYoMH71G/57NCwgDb5S2Tfy/7FJv5aLUQ0xiIJmSPIjHMyQbSlbhPkpH96+8kw1LZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9486
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

Hi Frieder,

On 7/21/25 2:51 PM, Frieder Schrempf wrote:
> [You don't often get email from frieder@fris.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Switch to OF_UPSTREAM to make use of the upstream devicetree.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>   arch/arm/dts/Makefile            |   1 -
>   arch/arm/dts/imx6dl-sielaff.dts  | 533 -------------------------------
>   arch/arm/mach-imx/mx6/Kconfig    |   1 +
>   configs/imx6dl_sielaff_defconfig |   2 +-
>   4 files changed, 2 insertions(+), 535 deletions(-)
>   delete mode 100644 arch/arm/dts/imx6dl-sielaff.dts
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index db83abb5967..d3cb7cf3f43 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -760,7 +760,6 @@ dtb-y += \
>          imx6dl-riotboard.dtb \
>          imx6dl-sabreauto.dtb \
>          imx6dl-sabresd.dtb \
> -       imx6dl-sielaff.dtb \
>          imx6dl-wandboard-revd1.dtb
> 
>   endif
> diff --git a/arch/arm/dts/imx6dl-sielaff.dts b/arch/arm/dts/imx6dl-sielaff.dts
> deleted file mode 100644
> index 7de8d5f2651..00000000000
> --- a/arch/arm/dts/imx6dl-sielaff.dts
> +++ /dev/null
> @@ -1,533 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR MIT
> -/*
> - * Copyright (C) 2022 Kontron Electronics GmbH
> - */
> -
> -/dts-v1/;
> -
> -#include "imx6dl.dtsi"
> -#include <dt-bindings/clock/imx6qdl-clock.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -
> -/ {
> -       model = "Sielaff i.MX6 Solo";
> -       compatible = "sielaff,imx6dl-board", "fsl,imx6dl";
> -
> -       chosen {
> -               stdout-path = &uart2;
> -       };
> -
> -       backlight: pwm-backlight {
> -               compatible = "pwm-backlight";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_backlight>;
> -               pwms = <&pwm3 0 50000 0>;
> -               brightness-levels = <0 0 64 88 112 136 184 232 255>;
> -               default-brightness-level = <4>;
> -               enable-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
> -               power-supply = <&reg_backlight>;
> -       };
> -
> -       cec {
> -               compatible = "cec-gpio";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_hdmi_cec>;
> -               cec-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
> -               hdmi-phandle = <&hdmi>;
> -       };
> -
> -       enet_ref: clock-enet-ref {
> -               compatible = "fixed-clock";
> -               #clock-cells = <0>;
> -               clock-frequency = <50000000>;
> -               clock-output-names = "enet-ref";
> -       };
> -
> -       gpio-keys {
> -               compatible = "gpio-keys";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_keys>;
> -
> -               key-0 {
> -                       gpios = <&gpio2 16 0>;
> -                       debounce-interval = <10>;
> -                       linux,code = <1>;
> -               };
> -
> -               key-1 {
> -                       gpios = <&gpio3 27 0>;
> -                       debounce-interval = <10>;
> -                       linux,code = <2>;
> -               };
> -
> -               key-2 {
> -                       gpios = <&gpio5 4 0>;
> -                       debounce-interval = <10>;
> -                       linux,code = <3>;
> -               };
> -       };
> -
> -       leds {
> -               compatible = "gpio-leds";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_leds>;
> -
> -               led-debug {
> -                       label = "debug-led";
> -                       gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>;
> -                       default-state = "off";
> -                       linux,default-trigger = "heartbeat";
> -               };
> -       };
> -
> -       memory@80000000 {
> -               reg = <0x80000000 0x20000000>;
> -               device_type = "memory";
> -       };
> -
> -       osc_eth_phy: clock-osc-eth-phy {
> -               compatible = "fixed-clock";
> -               #clock-cells = <0>;
> -               clock-frequency = <25000000>;
> -               clock-output-names = "osc-eth-phy";
> -       };
> -
> -       panel {
> -               compatible = "lg,lb070wv8";
> -               backlight = <&backlight>;
> -               power-supply = <&reg_3v3>;
> -
> -               port {
> -                       panel_in_lvds: endpoint {
> -                               remote-endpoint = <&lvds_out>;
> -                       };
> -               };
> -       };
> -
> -       reg_3v3: regulator-3v3 {
> -               compatible = "regulator-fixed";
> -               regulator-name = "3v3";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -       };
> -
> -       reg_backlight: regulator-backlight {
> -               compatible = "regulator-fixed";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_reg_backlight>;
> -               enable-active-high;
> -               gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
> -               regulator-name = "backlight";
> -               regulator-min-microvolt = <12000000>;
> -               regulator-max-microvolt = <12000000>;
> -       };
> -
> -       reg_usb_otg_vbus: regulator-usb-otg-vbus {
> -               compatible = "regulator-fixed";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_reg_usbotg_vbus>;
> -               enable-active-high;
> -               gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
> -               regulator-name = "usb_otg_vbus";
> -               regulator-min-microvolt = <5000000>;
> -               regulator-max-microvolt = <5000000>;
> -       };
> -};
> -
> -&ecspi2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_ecspi2>;
> -       cs-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
> -       status = "okay";
> -
> -       flash@0 {
> -               compatible = "jedec,spi-nor";
> -               reg = <0>;
> -               spi-max-frequency = <20000000>;
> -       };
> -};
> -
> -&fec {
> -       /*
> -        * Set PTP clock to external instead of internal reference, as the
> -        * REF_CLK from the PHY is fed back into the i.MX6 and the GPR
> -        * register needs to be set accordingly (see mach-imx6q.c).
> -        */
> -       clocks = <&clks IMX6QDL_CLK_ENET>,
> -                <&clks IMX6QDL_CLK_ENET>,
> -                <&enet_ref>,
> -                <&clks IMX6QDL_CLK_ENET_REF>;
> -       clock-names = "ipg", "ahb", "ptp", "enet_out";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_enet>;
> -       phy-connection-type = "rmii";
> -       phy-handle = <&ethphy>;
> -       status = "okay";
> -
> -       mdio {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               ethphy: ethernet-phy@1 {
> -                       reg = <1>;
> -                       clocks = <&osc_eth_phy>;
> -                       clock-names = "rmii-ref";
> -                       micrel,led-mode = <1>;
> -                       reset-assert-us = <500>;
> -                       reset-deassert-us = <100>;
> -                       reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -};
> -
> -&gpio1 {
> -       gpio-line-names =
> -               "", "", "", "", "", "", "", "",
> -               "", "", "", "", "", "", "key-out", "key-in",
> -               "", "", "", "", "", "", "", "",
> -               "", "", "", "", "", "", "", "";
> -};
> -
> -&gpio2 {
> -       gpio-line-names =
> -               "", "", "", "", "", "", "", "",
> -               "lan9500a-rst", "", "", "", "", "", "", "",
> -               "", "", "", "", "", "", "", "",
> -               "", "", "", "", "", "", "", "";
> -};
> -
> -&gpmi {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_gpmi_nand>;
> -       status = "okay";
> -};
> -
> -&hdmi {
> -       ddc-i2c-bus = <&i2c4>;
> -       status = "okay";
> -};
> -
> -&i2c2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c2>;
> -       clock-frequency = <100000>;
> -       status = "okay";
> -
> -       rtc@51 {
> -               compatible = "nxp,pcf8563";
> -               reg = <0x51>;
> -       };
> -};
> -
> -&i2c3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c3>;
> -       clock-frequency = <100000>;
> -       status = "okay";
> -
> -       touchscreen@55 {
> -               compatible = "sitronix,st1633";
> -               reg = <0x55>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_touch>;
> -               interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
> -               interrupt-parent = <&gpio5>;
> -               gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> -               status = "disabled";
> -       };
> -
> -       touchscreen@5d {
> -               compatible = "goodix,gt928";
> -               reg = <0x5d>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_touch>;
> -               interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
> -               interrupt-parent = <&gpio5>;
> -               irq-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
> -               reset-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> -               status = "disabled";
> -       };
> -};
> -
> -&i2c4 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c4>;
> -       clock-frequency = <100000>;
> -       status = "okay";
> -};
> -
> -&ldb {
> -       status = "okay";
> -
> -       lvds: lvds-channel@0 {
> -               fsl,data-mapping = "spwg";
> -               fsl,data-width = <24>;
> -               status = "okay";
> -
> -               port@4 {
> -                       reg = <4>;
> -
> -                       lvds_out: endpoint {
> -                               remote-endpoint = <&panel_in_lvds>;
> -                       };
> -               };
> -       };
> -};
> -
> -&pwm3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pwm3>;
> -       status = "okay";
> -};
> -
> -&uart1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart1>;
> -       status = "okay";
> -};
> -
> -&uart2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart2>;
> -       status = "okay";
> -};
> -
> -&uart3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart3>;
> -       status = "okay";
> -};
> -
> -&usbh1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_usbh1>;
> -       disable-over-current;
> -       status = "okay";
> -
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -
> -       usb1@1 {
> -               compatible = "usb4b4,6570";
> -               reg = <1>;
> -               clocks = <&clks IMX6QDL_CLK_CKO>;
> -
> -               assigned-clocks = <&clks IMX6QDL_CLK_CKO>,
> -                                 <&clks IMX6QDL_CLK_CKO2_SEL>;
> -               assigned-clock-parents = <&clks IMX6QDL_CLK_CKO2>,
> -                                        <&clks IMX6QDL_CLK_OSC>;
> -               assigned-clock-rates = <12000000 0>;
> -       };
> -};
> -
> -&usbotg {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_usbotg>;
> -       dr_mode = "host";
> -       over-current-active-low;
> -       vbus-supply = <&reg_usb_otg_vbus>;
> -       status = "okay";
> -};
> -
> -&usdhc3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_usdhc3>;
> -       cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> -       vmmc-supply = <&reg_3v3>;
> -       voltage-ranges = <3300 3300>;
> -       no-1-8-v;
> -       status = "okay";
> -};
> -
> -&wdog1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_wdog>;
> -       fsl,ext-reset-output;
> -       status = "okay";
> -};
> -
> -&iomuxc {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_hog>;
> -
> -       pinctrl_hog: hoggrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_RGMII_RD0__GPIO6_IO25        0x1b0b0 /* PMIC_IRQ */
> -                       MX6QDL_PAD_SD2_DAT3__GPIO1_IO12         0x1b0b0
> -                       MX6QDL_PAD_SD2_DAT1__GPIO1_IO14         0x1b0b0
> -                       MX6QDL_PAD_SD2_DAT0__GPIO1_IO15         0x1b0b0
> -                       MX6QDL_PAD_SD4_DAT0__GPIO2_IO08         0x1b0b0
> -                       MX6QDL_PAD_EIM_D29__GPIO3_IO29          0x1b0b0
> -               >;
> -       };
> -
> -       pinctrl_backlight: backlightgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_NANDF_CS3__GPIO6_IO16        0x100b1
> -               >;
> -       };
> -
> -       pinctrl_ecspi2: ecspi2grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_CSI0_DAT10__ECSPI2_MISO      0x100b1
> -                       MX6QDL_PAD_CSI0_DAT9__ECSPI2_MOSI       0x100b1
> -                       MX6QDL_PAD_CSI0_DAT8__ECSPI2_SCLK       0x100b1
> -                       MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29       0x100b1
> -               >;
> -       };
> -
> -       pinctrl_enet: enetgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_ENET_MDIO__ENET_MDIO         0x1b0b0
> -                       MX6QDL_PAD_ENET_MDC__ENET_MDC           0x1b0b0
> -                       MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0     0x1b0b0
> -                       MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1     0x1b0b0
> -                       MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN      0x1b0b0
> -                       MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER       0x1b0b0
> -                       MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0     0x1b0b0
> -                       MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1     0x1b0b0
> -                       MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN       0x1b0b0
> -                       MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0x4001b0a8
> -                       MX6QDL_PAD_EIM_A25__GPIO5_IO02          0x100b1
> -               >;
> -       };
> -
> -       pinctrl_gpio_keys: gpiokeysgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_EIM_A22__GPIO2_IO16          0x1b080
> -                       MX6QDL_PAD_EIM_D27__GPIO3_IO27          0x1b080
> -                       MX6QDL_PAD_EIM_A24__GPIO5_IO04          0x1b080
> -               >;
> -       };
> -
> -       pinctrl_gpio_leds: gpioledsgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21       0x1b0b0
> -               >;
> -       };
> -
> -       pinctrl_gpmi_nand: gpminandgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_NANDF_CLE__NAND_CLE          0xb0b1
> -                       MX6QDL_PAD_NANDF_ALE__NAND_ALE          0xb0b1
> -                       MX6QDL_PAD_NANDF_WP_B__NAND_WP_B        0xb0b1
> -                       MX6QDL_PAD_NANDF_RB0__NAND_READY_B      0xb000
> -                       MX6QDL_PAD_NANDF_CS0__NAND_CE0_B        0xb0b1
> -                       MX6QDL_PAD_SD4_CMD__NAND_RE_B           0xb0b1
> -                       MX6QDL_PAD_SD4_CLK__NAND_WE_B           0xb0b1
> -                       MX6QDL_PAD_NANDF_D0__NAND_DATA00        0xb0b1
> -                       MX6QDL_PAD_NANDF_D1__NAND_DATA01        0xb0b1
> -                       MX6QDL_PAD_NANDF_D2__NAND_DATA02        0xb0b1
> -                       MX6QDL_PAD_NANDF_D3__NAND_DATA03        0xb0b1
> -                       MX6QDL_PAD_NANDF_D4__NAND_DATA04        0xb0b1
> -                       MX6QDL_PAD_NANDF_D5__NAND_DATA05        0xb0b1
> -                       MX6QDL_PAD_NANDF_D6__NAND_DATA06        0xb0b1
> -                       MX6QDL_PAD_NANDF_D7__NAND_DATA07        0xb0b1
> -               >;
> -       };
> -
> -       pinctrl_hdmi_cec: hdmicecgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_EIM_A21__GPIO2_IO17          0x1b8b1
> -               >;
> -       };
> -
> -       pinctrl_i2c2: i2c2grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_KEY_COL3__I2C2_SCL           0x4001b8b1
> -                       MX6QDL_PAD_KEY_ROW3__I2C2_SDA           0x4001b8b1
> -               >;
> -       };
> -
> -       pinctrl_i2c3: i2c3grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_GPIO_5__I2C3_SCL             0x4001f8b1
> -                       MX6QDL_PAD_GPIO_6__I2C3_SDA             0x4001f8b1
> -               >;
> -       };
> -
> -       pinctrl_i2c4: i2c4grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_GPIO_7__I2C4_SCL             0x4001b8b1
> -                       MX6QDL_PAD_GPIO_8__I2C4_SDA             0x4001b8b1
> -               >;
> -       };
> -
> -       pinctrl_pwm3: pwm3grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_SD4_DAT1__PWM3_OUT           0x1b0b1
> -               >;
> -       };
> -
> -       pinctrl_reg_backlight: regbacklightgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_ENET_REF_CLK__GPIO1_IO23     0x1b0b1
> -               >;
> -       };
> -
> -       pinctrl_reg_usbotg_vbus: regusbotgvbusgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_KEY_ROW4__GPIO4_IO15         0x1b0b1
> -               >;
> -       };
> -
> -       pinctrl_touch: touchgrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b0
> -                       MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18      0x1b0b0
> -               >;
> -       };
> -
> -       pinctrl_uart1: uart1grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA      0x1b0b1
> -                       MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA      0x1b0b1
> -               >;
> -       };
> -
> -       pinctrl_uart2: uart2grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA      0x1b0b1
> -                       MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA      0x1b0b1
> -               >;
> -       };
> -
> -       pinctrl_uart3: uart3grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_EIM_D24__UART3_TX_DATA       0x1b0b0
> -                       MX6QDL_PAD_EIM_D25__UART3_RX_DATA       0x1b0b0
> -               >;
> -       };
> -
> -       pinctrl_usbh1: usbh1grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_GPIO_3__USB_H1_OC            0x1b0b1
> -                       MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1         0x1b0b0
> -               >;
> -       };
> -
> -       pinctrl_usbotg: usbotggrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_KEY_COL4__USB_OTG_OC         0x1b0b1
> -               >;
> -       };
> -
> -       pinctrl_usdhc3: usdhc3grp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_SD3_CMD__SD3_CMD             0x17059
> -                       MX6QDL_PAD_SD3_CLK__SD3_CLK             0x10059
> -                       MX6QDL_PAD_SD3_DAT0__SD3_DATA0          0x17059
> -                       MX6QDL_PAD_SD3_DAT1__SD3_DATA1          0x17059
> -                       MX6QDL_PAD_SD3_DAT2__SD3_DATA2          0x17059
> -                       MX6QDL_PAD_SD3_DAT3__SD3_DATA3          0x17059
> -                       MX6QDL_PAD_GPIO_4__GPIO1_IO04           0x100b1
> -               >;
> -       };
> -
> -       pinctrl_wdog: wdoggrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_GPIO_9__WDOG1_B              0x1b0b0
> -               >;
> -       };
> -};
> diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
> index 465e258f8e4..0798eac68f5 100644
> --- a/arch/arm/mach-imx/mx6/Kconfig
> +++ b/arch/arm/mach-imx/mx6/Kconfig
> @@ -366,6 +366,7 @@ config TARGET_MX6S_SIELAFF
>          select DM_THERMAL
>          select SUPPORT_SPL
>          imply CMD_DM
> +       imply OF_UPSTREAM

Why "imply" only here? It won't build without OF_UPSTREAM anymore no? 
Shouldn't it be "select" instead?

Looks good to me otherwise!

Cheers,
Quentin
