Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41B5CFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB5683F93;
	Tue, 25 Nov 2025 09:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vXjxwg8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A67983F87; Tue, 25 Nov 2025 09:13:34 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CBD683EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch0Ybo3zTBtY+6UTqYdUtBVGdls4hGvZWBcjVJdgRm6gpnJi80KkFF52yjTPZSoLcP2ocTX0wiNUaB8mqtUDy/X0rBf6sXpPYzC7OGZPSyPiGCdlUwa8jIbdyVpDaRncmB65zABkqxluIsasmxpMeTuZUeRoY1w+oh3659pIyMxBPX5X3evBZw79/3iuSRJDlkTe9BO63E4dgfUp2zDJeoxdXtHkoiTrX2mVeIiq5HoziLZpdXQrCIZUdyThD4udfxJcq4kxKevzqRmXOQf5WAlL8qBQNtw7phxNzG2SrbE36Umx9Tig7gWhCmbmQ0gl45BBzba0V0b8J0tfRgKBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8etTl4i0Hu5qXTEcfCEG/t3mqnpyNBClUtM1KXn6B3g=;
 b=nTO5jtOzzYe/nG6U8KYdD1WV/EhMk2WqQf385t1aVvYhfNDSrBENFxtflk66kvq4EAfpmxRAYHP93ROroFRRSpWES/U+Zj5H0N9/URvsg9/gj/n7q1tItSRM5gYVQ5JThPfbSNvfffNr8o7p0gv/0G8mpM3/dnd32uyIup8WMPWWIafwwkCqU/2kQ1DPWJgqd2kd+1a5CbgtOk5m/SCU0LPzV2jANIKBQtCzFeb8kIwv0IVwR0wwJH8zSdB7lwkcUC/2Fm9mLs0x9kib2wZZ5ObPMcC+6vwqRJCSF2j+pehDcBozVGRm2tJcr39PmWoe24m+rabmMIWe7NvrPIvoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8etTl4i0Hu5qXTEcfCEG/t3mqnpyNBClUtM1KXn6B3g=;
 b=vXjxwg8MFuSZSLX4+NcOvwfMT+zUNvCVxeZcCgCQ1zHw5QtZKmUdw1rUNvp3yOIb3pobS8Ww4vIMlad9qRYML/21l8uCyiF/ncucmSrnDuqap//B9k05pvYh0K3lxnALdRqVajWCIkTwdSX4ngtyGuYA4Zw8wweM9rxAobYQQsGFwLfTyR/an+vqHzZb+jrdtr+vp01YSGqAexVJD0g93eiUguSrY+XVK/qkUgMe+YPtMYPxuFE9ZwnqJqb0tdCjl7ba3kQooy441U3I+Az9NpbDxtmOvOGAVNic6QhK8a3f/h4MQ1OmuvrT0ak90oIrX3AZv5NJtuMxV5jpP9xJnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:28 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:28 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 0/8]SoCFPGA: Update Boot Support for CycloneV in U-Boot
Date: Tue, 25 Nov 2025 00:13:08 -0800
Message-ID: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS7PR03MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e56d19-f8f5-40e7-ace6-08de2bfa836d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1Q4dktLanJpN0NBVkJBTTdRODBjYjZqTENVaWlMY29OQktOT3ZHM29TQnUz?=
 =?utf-8?B?MWlwRnNDaXpKZzAwR295eTM5dUpFV0dpRVg4bElpaXU3WS9DbFV0T0ozN0g1?=
 =?utf-8?B?QUo1aVNVVDNIMFdtSXBoM1ZKZTFzQmdpRkZRTjUxeVdrcmZGVlAvU3FmNEdr?=
 =?utf-8?B?bTVjbDEwS1hmWXlJVDByYVV3T3RaMURSdytQR2prZXdMcThCVUhkRUNyU1Y5?=
 =?utf-8?B?QUZvT1g4NzdOSXR4c2N3NUxwWEMyZk4xWjN5QlByZ2kyV1FtNi9VN3NXN3VH?=
 =?utf-8?B?WEM5UkF1Q25WUWU1dWJtT2V6VHd3ZzlKVWtQaVNXZU5xVkhuclhOUFAzalFP?=
 =?utf-8?B?Y3lZZi9FOWsyb29LNVRJcVU0SEFmUjNGMzlSamd4bHNnaGFEVzVMaUQ2S2pT?=
 =?utf-8?B?RzFHbFlNMTZLMnZkT1dGQkpKaWh4TDdLb1QrQVF6VW5hamIvVVloQ2d2RlEr?=
 =?utf-8?B?TE9PYmdjc3BHajhUR1BtdUZMWnNCd1ZkLzlybWhZRVJnNDNleldiS3RqMXR6?=
 =?utf-8?B?ZlpwQjJmbEo5T0prdk1QVmtnMlBkajYweEdUclk0ajRCWTJVVjRvcUdiWjNu?=
 =?utf-8?B?WG5NZ3BNZWdFbFA1Z0lQOGtsb0dDWXJVTkFYdjJ4YnQwV0FNYVlYRWhOWTho?=
 =?utf-8?B?Mnl1d2d5ZUZZQ24xVlZVcXd1SGFqNktaOVplaGk1OFVoL29KdE4vZ1lDMU5D?=
 =?utf-8?B?VzNsOW5yQVNublFpU1ExVWh4S2dPQ1FLVHVUZTVGVDcrb0ZRQmd3QWtKMFRw?=
 =?utf-8?B?aGNxVnkxZWN2L1RRQjN2azhSWVdVL3o4Q1VLMmhJUndUVGUxSllnUnM3VXdX?=
 =?utf-8?B?ZjB0SnRTUk1Oenk5RUJRRUNQUzJjWlRTY3ltVkxTK05JazlDejExUzY3ZUJh?=
 =?utf-8?B?N3Eyck1PMlU0aHVxV1VvT0ZEUFAyemQ3anRTQVNpbmFrTk1Kdlp0TUhjMGUx?=
 =?utf-8?B?YzJaWFc5NDFyY3JGaEI1REl6M3RLY3pZNklhSytFaEF2eWcxbTZ5V2t0Zm9J?=
 =?utf-8?B?VUdLOW5hb2xRN0NGQkFSb1BuQWE4aTRVK2laVnRaT0pNclNQaC9pQTI5UWRG?=
 =?utf-8?B?TXlybFNvVjd2S1M4K1J5NHM0MzVYMHFBZHd1L2tTSG1oVUZnay9xMXI5djZW?=
 =?utf-8?B?UUkvK3VPTzNKcXltd1daRGdmV054cWRNSmk3Mlh1OHdiQkZrcXpVNEVBRUtt?=
 =?utf-8?B?YTRpUkZhdFdwOHZzUEhnbjRhYy8vYW5zK1diN0lMcWVzMUwzNkFmcFJGRElI?=
 =?utf-8?B?ZUZmUzlhUGRmRWhLYndlbzBEOFplcThnMHBnT3AxUjIrN0hPcnhUMDJHQi9t?=
 =?utf-8?B?M1c1OElabW1xOGVqQ2gwZG01clhGM2llenNmYVIvQy8xL2lOeklhOHhvQzc4?=
 =?utf-8?B?emxpZ0daNDlSTzZvZVlFcUYvVjBFMmNGZ1Zqb21FSHJwUHJMdmFwbXZLTm5x?=
 =?utf-8?B?MFRiMFkrQ2puTFFPS3RCVytTbnQvbTIreEVDTnQybG9MYnNHdXpvZU9JUWdW?=
 =?utf-8?B?TVdmVVFYdkNWTUlQWXZzdUpxWDJ3QUVsMHpTS05JeXh1ZThXSFdRME5Ga0Vq?=
 =?utf-8?B?dFFFMFBPWjdLeThoSzJoOVRYYS9IUlU0Y25OT2ZxSWhadGJBNFk5RmphZUtI?=
 =?utf-8?B?V3pDS3NvMjg1ZFcxSlVxek5pbHl2QlpYbFp1RGMvSHhkOE1kd1p5bmxlVFla?=
 =?utf-8?B?YXJEVW1vK2dqWTNGaURqY0txL0FoSWQwYm15cnY4Z0V1WHBNVU1WRE9pTExs?=
 =?utf-8?B?MHhkQmJVRG9pZzl3ZjJOalR1bkNINTBRaG4yMzdkcXJxNXN6RzRCM0RUemJv?=
 =?utf-8?B?ZHNOeWZpUXJSUlNjTWlRWkFPSk5COW16TkNYd2Y4RTV5RmZ5V1hXRm56a0Fi?=
 =?utf-8?B?ejhjUWR4dDNmd0ZWcjJvK1Z3c0F3MS9zUG9sbnI5Yzg5dFhaZFVXSkszd25z?=
 =?utf-8?Q?JTsTp3uZQJip3M9/UJwxB0RtLhT88P4d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M21UV2g2OGtjT0F3cGJwaWRTdFpvVU1JNDZCV1dEWjdzV210YTYwV0Z2R3Zu?=
 =?utf-8?B?U2pWYWNTSnRiNXJBRkxMOUxxcmRZc0dQdTBTa1RURW9qZy9tTjVTcTkvd25T?=
 =?utf-8?B?WUUzSTJPWFJteWxkSjVnWXg1R3dSdlRraW9lSDdvb0lrWEVCeHJtUllkL0sr?=
 =?utf-8?B?bXV3UUdsR1NMRjBtbTlCNWlqQlp5K3VaOHdBL3J5UnFEaHMxdlFHUXZmUzJw?=
 =?utf-8?B?WEcyR2dCSXZrMnRrMlFJYkRoUC9mSDRGK0xqQS8yN1VWcExxcWNTUENITjd4?=
 =?utf-8?B?a091dkh6WktlVXNjTTFNYVh4SUhBaWorVnJpZ2s1RFNNa0JRRnQ2SEVSZnVM?=
 =?utf-8?B?Uy81K0lnMWZhVmtFWkFvTlJyVlV1cUJvMkZiTUN3bUdFSU9rYXBNbUhxaWxp?=
 =?utf-8?B?ZUhWa0VHV3ZCR2R6N1Vqa0k5T0FQME9CNTE4ME9BZVlBejRpU2wzRFkzcENR?=
 =?utf-8?B?QUM3Ujl5M3ZvMFdxeStJYllVOWpGMHkwSkxDUU9mVTJkSUw0WlJQbEJHeEs1?=
 =?utf-8?B?dURlT3FGTVpGQ0tXUTVISmRSTlR3dWVXOEZQR1p5bFZpNHh4U1hyZ3BqZ09M?=
 =?utf-8?B?aUVnU3p3OW9VOTE2alJxWGtReUlRNzFPdTVlUExDOVh6NGJFaUwrdmFPNk1Y?=
 =?utf-8?B?ZVZ2V2IxRmROeFVFRHIxQkk5a2djTmxrNEdhcjhNd0hQWmxJMEVzNEc1Tk54?=
 =?utf-8?B?akFrQVJlMlJOVzY0dGMvYXJYODBGSHdmRkpBK3oxcllYSFZ3ajUrbmU2dmJC?=
 =?utf-8?B?L1FPSnZVbjcyWmZHdzVWc004cEhYMzBuVjJGU3ZqWVVRVkdybUFYdlVOdkVQ?=
 =?utf-8?B?dzJyanNUa2V3V0prUlo4WVgwRWpYRUV2WXJONldueEFvVXVJUEd6aUp6TFZ0?=
 =?utf-8?B?S0ZrVXhXTW4vcWZudGhuN0R1RjczQVVqaTB5eEZnRmNjQWpkOVhyRVIwcGQ5?=
 =?utf-8?B?OWNTQlJ4bnRiSjJzaDROVlJrT1FkOEgzdFUrNlovTDdsdGcvV1k2ZmRlY1Fv?=
 =?utf-8?B?SGVlOHNsdDM4VTZGZkhyZDRpRnRIVDFWMEN3VTRraTNNOGdHMmQ3MnREbEc1?=
 =?utf-8?B?UzJhMnA2czliNmV4WEY1OFl6bjJDZFV6N1pxeDdCY0tydVVUR2hTU2ZWR0Y1?=
 =?utf-8?B?WEw3OVFmNFJ5S1IzNG02TXBxd1VRM0NDTFVsWVhhZzhLaVQ3SjhjWUZIRSs2?=
 =?utf-8?B?ZWdITFArbTdSdGgrc1JmSDB4eTNoVTRpMXZsNUJZTXE0a2Y2bTVyRERobW9X?=
 =?utf-8?B?TnVOY0xaNTJHVElhNzU2c3poSzRyS3NrdDJERXhMS1B0SHAwSmVMTFpLT3JR?=
 =?utf-8?B?ODFXYzVSNzFYVU81OGxOdW91cENteWRSYmlDMWwwcGRSMUtoNUZBcjFNeFF5?=
 =?utf-8?B?Uzkzb202Vm9ZaEZtTUE0ZmxTcksyQ0ZkOG4vL2J1c1JoMzcrMURHTmVudVFR?=
 =?utf-8?B?N1QwcEdGUjN5eXROUWFYbGZURW9QTGVjVVlnOFZlckk1Ym9JR0QvWmxSWGxs?=
 =?utf-8?B?NFRObmx6c0NjSDFYUEx6VTZGL0t0aVl6cFdvc2pXK0M1NVlFVC9xSi9ZS2RW?=
 =?utf-8?B?cXlhR0JvK1RvVC9ZaGExb29FK0ZPbEVielhreWQ5cHZ1SDhZenUzUW9WbEFx?=
 =?utf-8?B?TUpRM1NTVUswUVpXa01MQzQwekt3UG5EaWF4SnVPMU94eVYvQkY3YnVJb0xw?=
 =?utf-8?B?OEM5aVJ1bi95aTNuTjQxcjVNNmczc2p1STJkRWs4d25ZR05WbGpYT1ZZQnpa?=
 =?utf-8?B?cm96ZFpaNE8xZ3dMZlY1N1dZVFpXZnB4aUJpeVYzNkdqRWtnUTVOMm1FandV?=
 =?utf-8?B?bkRHRVJLYXEvNEIrZEphZjZleWVvNEVhTWZiTXlOdUhTQnBzNVRtcDM0Wk12?=
 =?utf-8?B?WTgyRFlGWm94eTF4NEdadTRVMVJITjhOU2lhM0k0aHdwNGNML2huT1g0UnFV?=
 =?utf-8?B?Q2huSWdsZmRwaHZReUY3RXEzSDZPc2xLV2k0VXJvM0JkZXhVZjJDdUxkMXF3?=
 =?utf-8?B?UkhTTU9SeExNNjcxaXFmL29wUkFCM0Z4cEd3MWRHUkxxSjAxYm95L1pGc3dJ?=
 =?utf-8?B?UVkvKy9oanA1V0FiU0dmOExCK2UvSmpiV1NUL1VLYW1XUkpqditOeFcrN1FP?=
 =?utf-8?B?NjNhYUJUQko3TXRwL0RrVDAreW9Obzd3eEhoZ1hYZDF5L3grRzFYY3NkdHNG?=
 =?utf-8?Q?f6K0VTNGLWid986cr6x8hw0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e56d19-f8f5-40e7-ace6-08de2bfa836d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:28.1350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2AjeSMhQ1sJKTvVmXOxX5uSbTufnBPC2+MnZnuBXs/bLWEd73QR2GKIhYmMpJb9i1g4np+PcHcQZiT/NoIMmvWP7s4hNAupdLQQpq5HSMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5447
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

This patch set updates the boot support for the Altera SoCFPGA CycloneV platform in U-Boot. The changes include:
	1. Board-specific configurations and setup required to enable CycloneV multiboot operation in U-Boot.
	2. Migration from raw to FAT mode for SPL MMC boot
	3. Backwards compatibility support for legacy SoCFPGA devices to enable/disable SDMMC clock in common SoCFPGA MMC driver.

This patch set has been tested on CycloneV devkit with SDMMC boot and RAM boot (TFTP & ARM DS debugger).

Alif Zakuan Yuslaimi (7):
  configs: cyclone5: Disable mkeficapsule tool build
  configs: cyclone5: Enable random MAC address
  mmc: socfpga_dw_mmc: Restore legacy clkmgr address retrieval
  spl: Remove ARCH_SOCFPGA from MMC raw mode enablement
  configs: cyclone5: Enable SPL FAT support
  configs: cyclone5: Update boot command for CycloneV
  configs: cyclone5: Disable SPI in SPL

Tien Fong Chee (1):
  arm: Fix "file truncated" linker errors from empty built-in.a in
    SPL/TPL/VPL builds

 arch/arm/cpu/Makefile              |  2 +-
 arch/arm/cpu/dummy.c               |  7 +++++
 cmd/Makefile                       |  4 ++-
 cmd/dummy.c                        |  7 +++++
 common/spl/Kconfig                 |  4 +--
 configs/socfpga_cyclone5_defconfig |  8 +++++-
 disk/Makefile                      |  5 ++++
 disk/dummy.c                       |  7 +++++
 drivers/mmc/socfpga_dw_mmc.c       | 46 +++++++++++++++++++-----------
 dts/Makefile                       |  5 ++++
 dts/dummy.c                        |  7 +++++
 env/Makefile                       |  5 ++++
 env/dummy.c                        |  7 +++++
 13 files changed, 93 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/cpu/dummy.c
 create mode 100644 cmd/dummy.c
 create mode 100644 disk/dummy.c
 create mode 100644 dts/dummy.c
 create mode 100644 env/dummy.c

-- 
2.43.7

