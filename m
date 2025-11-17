Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4541CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 12:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2333983A79;
	Mon, 17 Nov 2025 13:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cUL9HWkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B7383AEF; Mon, 17 Nov 2025 13:51:51 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6215A83A64
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 13:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwj12wMVZoodRJWmDnYO/v3WyKbUgPaHYqiY4+9oL3Nsu3BSgbbDRroz2P3UTm/NN3wnHpFQJFAieA9gKeigc+56KyOAMKB/43xxaPuMl6/ROF16ZIfleXJquKOVNJj/gQUY2Uta6RAbdJlDRNFB99gFO6nM9uZ/w1YD2kCYeNf17ZuTX4hEX3bILuRl0CWHYq9WJ+t8PdCV6Ccz6ZZR/rl0wa3II/pMaGzGyuGgEPz7xdv3S1632TdZX3xAEPtVZAZESCssuyTcQBDKFpeARVYYSvoa3qTCug6b7ABAxH8qhKhp2nDNzWAwhe31rjBqMXYX/h6gr8kjhcJlK3/QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOGyYhWbJbTAK0uzvEIzZi56Jx6oai6EfqzJTbQ2wF0=;
 b=IByYKrICgI4sT4ngvRdWFwx5lot3YOoJZYqKvB2UyugdBY06xzl3R4khspJTssHmPV+4o43yHpxzd+uq2bL+vexFVb45dGE2/H+je4V8G0Gf528yZR1AlvS6Hqrng+Ua5n+33brUl7Y5DWPiojZTPFDXb1x1oJmMDS8TscGclgwx+H9b9lKAyeKLbJA+7A0iHoVnILSJ1sD1CeiLI0RbvPLJKO5lnmLNg+u0vYpiAtanw+trUi+xDFQ3RRFLEVm8RVHUkIBQtOfVFm6VMVuNDylOx1Xmm2NxryS/LaBw+FoSleqq3u7ctmUD6ka4/TVLMSjul+KHM7LgPYVtQvn8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOGyYhWbJbTAK0uzvEIzZi56Jx6oai6EfqzJTbQ2wF0=;
 b=cUL9HWkHXy8kfr586txWHYYuDYTA76iwmZDT4yw9ByfA6XZDPP4J8tEhUgqUJOf19PfXVBE8iQw8+SZQhC4/zx2ETSY6kE/KHkVDVXZcGIuLm20avJ4hfBX/ER4FdgPO1LJjwzYZuJGNoj+dDPYYs9clM+LC9UWmHJAOoFxmoXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 12:51:47 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 12:51:46 +0000
Message-ID: <47b59caf-b0ed-4d0c-a81e-1cabea3bada7@cherry.de>
Date: Mon, 17 Nov 2025 13:51:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20251113093313.362055-1-kory.maincent@bootlin.com>
 <86bf47cb-60e2-466a-a471-b08ece0efacd@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <86bf47cb-60e2-466a-a471-b08ece0efacd@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d47e08-0875-4b2d-e52f-08de25d81147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1orcU9ueGk1RTBaMVRkeFJReTZ4L2JOYzRYWGE4WlNQb1hrS3NmdnBJaEwz?=
 =?utf-8?B?VStKU0VlcDN1VlYrVHB6OGVKdDVTb0VvaUNjN0ZpK3lxbWlEWVdNZ25wK0RM?=
 =?utf-8?B?cEFKdzRpYmY1UEhkMW1zNlQrSDh2YjZETEh2dE1qc0wzUldTbkhFNUg2Q1cy?=
 =?utf-8?B?TG9QQng1VEZzY1VqYmI1djZ6ZURjMXVjeW5aSkFlZkZjNVhuTkNTaGdEVkw2?=
 =?utf-8?B?T0p4c01pZXduRjhlM0s3VnFsTzlqTFlsalJtcWNhbm5tWTNQNFhBRHY2V21Z?=
 =?utf-8?B?NFVaUjBGSVFKWHJCREkyeWRyZkVwYmlRUDBSeExkTnNiVEk4bU9ySjFQRmRq?=
 =?utf-8?B?YmphM0lzajd1Sm9sN3RXcWcxMS9qTTR3dnp3RmlUMmpuZXBEUlNKWjVDa0xk?=
 =?utf-8?B?ZkJLT1Z1cHcvZWhGOC9ZbUs1ckNIZTF5NjlkNWZRTnVaRjE0RUozWUlORHFJ?=
 =?utf-8?B?UVM1TnBRL3ZmSFIrS1Q3M2VDWE4reHk3OWFrK3oxT1A3ZC9OYUFBS2FTMXZw?=
 =?utf-8?B?UnN4WDVRV0RETjZ4ZUd5ZXFhQW54Y09nQmlVanZhVGM3blhOWnFIRFo4NWtm?=
 =?utf-8?B?ajZxc0JrZ0IxN2I2dzZ6U0FMRTEySjYvbGhCRzVrS2IvRlMrN1kzbFMvUWtV?=
 =?utf-8?B?a1Z0NE5lVDR1ZWZEZzlIc0xPQWlKSkdralBoU2dydm9UZzJLVnhJKzRPbWxm?=
 =?utf-8?B?Q0ZPUkRqTFlJL0U0TnA2MVhVcDNKRWFlUXFSbXk4NEZRbGhWZC9tREpZeEVl?=
 =?utf-8?B?aHEyWXJEbU9QcThmSFRlRVN6L1lSdjUrN0M4OEpDRTRGQ3Rtb0d5RzZtaDBB?=
 =?utf-8?B?NUNqVW5BdXB1MXoxYy9mQmdySUF1Z2hXQXBMVHV4dXkwK2w3MnZQTmh3N1NQ?=
 =?utf-8?B?bkJsK3Rzc1pBYjBQSlRZRlUrdVgrTEd4a2w2WHBkUzBRZFRNYXV2OVpac1k1?=
 =?utf-8?B?RjZ6WVYxQTlYVFExVkY3MTZVUzZQQlJ5d0lGdm9LT3ZENUppV0FnTml6S1dO?=
 =?utf-8?B?WVVabVErUTEzdDVJdzQvdjViUlVLTUFlUmY0MjBreTZFVGI0dUx3S2RNZk5o?=
 =?utf-8?B?U1pzQjBqVHFzRSsrOWRYZjFyWGUrbWJlYkNKSG16eEdzc0Nreno3YTh5RmIw?=
 =?utf-8?B?VUNaZ1haS2hYclIrUHFjaWZtZ3JMWHlUR1hUNFlYcHNqaEtQcW9Oc1UreGpQ?=
 =?utf-8?B?eW5nd0hJR2lCeEJmZGxVZjd0QlBMb2RnQ2N2NmFuS2ZFQ1hLSllOeFc5TXRX?=
 =?utf-8?B?ZUJuU1pkaURYZlRuU2cxWHlZeVp4U2Y4dmJ4WVRiaUp6MEVTdCtac2tpSHEv?=
 =?utf-8?B?aHFGVFM5cHJNbmRQTW0yZ3R2b05EUjhZT1hMNkxYVUxIQzA5L3QyZnNUblVl?=
 =?utf-8?B?YjRVUWx1dDFVc0dYZWRkL09Cb1g1SG95b0pwS0JMSGVVMFI4YmJzTnp5YXFW?=
 =?utf-8?B?M3BYdWpEM2ZWUWVEOFlJWFJ6My9pVEVNbGpOTFFsR0oxc3UrN2Q0TTRhZlRU?=
 =?utf-8?B?ZkQxVmdKdTZRY1FsK1V6VkQzVkJvNEkzdVdJN3E4SVJVdXJCS3Z0ZDdZSEt2?=
 =?utf-8?B?bitKTHgycm5nckNhaHZSTDFBWVdIdjJYUTJub0xyd2J4Mm5kajM4QkRSWE55?=
 =?utf-8?B?OU1EWUxMNG1tNnZvaDJ3ZEpmNlZBNFkvbTUyNnZ5QTV0ZVg4dG5SbVFXbzhF?=
 =?utf-8?B?RVVHeFpkbStkTVhoYmc0VVBseExvRVRnVkpFS0w1YU1aYkF0ZjZTT1RRNm91?=
 =?utf-8?B?VkxrV2VtNU5GWi96YXpCdGpvUEVPSEo0SlFhV3hTbDVGQnE4dURnR2wzSC9T?=
 =?utf-8?B?TGppZzE0QVdESUVpNmtUQTF0T1FicG54UzFvbGl5U2JvaldnMXNER1BhU2tk?=
 =?utf-8?B?VWdSNVVpbHhVT1hYZUo2VVY0TDRDVUZWUXpHT3p5Ym1JQzU3WVlCc2huZnMw?=
 =?utf-8?Q?5burp8kV+LbHXLFzy+IVGoiZzr9cBuaW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEkweWlKZ2hDYjU3bWd5SDc4TlM5Zlc3RVduSWNXUTRnQUcxb2FRQXB1MVdo?=
 =?utf-8?B?SWRBU3hFa0pkNVJaT2FXc2Vja3c4d3REWlFYT3hKZ2JqOWNrSm1UYVZ4TEVN?=
 =?utf-8?B?VXNPcWxqQmNWejcwVTcrekFBRUdLNCt4amZsbWw3d0N3ejZXRWRtdVdGdU42?=
 =?utf-8?B?dTZzMDZERkt1RTNZQy9SblBjSWVRbGRxeGRRTjZUQUdiMGRkUzVTTEF1VGN6?=
 =?utf-8?B?ZDFZZWZQdytjelJLWi9iQmxvTDJnM0x0RXlhZGp5TWFyKzFuZEV2OEgrZWh1?=
 =?utf-8?B?Z1hieVk1b3VXa240QUtiK2VheDFCeStwbHZhV1V0RnJDajlHaUNpOThFYWpa?=
 =?utf-8?B?TUJnN0tjZHkvZUpJa1ptMTd1Q2pxRFMybHhsTDBzYTRFVmI2a2dVYkVmNDU1?=
 =?utf-8?B?dXc2NUdJZjVteEwxQmE4Vm1zMlJUa0dWdlp1U2h3WEN5anAxUlF3RHBrT3hX?=
 =?utf-8?B?eldKQ1h5Skp1cUMxbVZVOE91YlFiU0djY3NTZzZJTzNEbjIzdG9ubEI2UUxI?=
 =?utf-8?B?VndMVVd6ZlRVSEVTdGRXSnZjcFQ1VGl4MjlkOWxzSXIwM0lPcGtXNmlTRG9Y?=
 =?utf-8?B?QVFyWVArZ2ZreTU4eWI3Zmw5ekpuK21EVmo4Sm8yUlFVQzFkRzhmdERFWk9L?=
 =?utf-8?B?MnVzSlNxeFZQZEVKS0Q5NXl1SDhMYjJwWXpZQWtnRFBVY1BLejFVTHdXM2xw?=
 =?utf-8?B?SHdndm1vKzJMRU5JY0lKbEZQUkJQMVNrUzJ2YURWenMwUStEeFp6L21KTVQ4?=
 =?utf-8?B?UzMxVGx2WHBWTkZNdkxvZU4valpDTWhsejZKa1E0SXFLS3BTSDlWTFhudUZx?=
 =?utf-8?B?aG9EZkJWbWtZcDRURW45SzZBOWRvUzdoaUg1akRKQnpuMHkzZWw2ZHFLTFFP?=
 =?utf-8?B?Vk5hWUlxSWQ5cVl1YXRyVWxFZ1JZcTFML2FyTUE1WVFCWUJleWphNUwxdFY1?=
 =?utf-8?B?ZzZUQmtOdC85dlRXMTJ4Z2Ezb0ZwMGtWN3AxMzY1ZU84elk4VlkxeFF4LzNF?=
 =?utf-8?B?ZkpMaFhmWitVQW04UTh0WkJBcXdqN0VvQy90UXlPaWl3ZTZJb0FRUWJKZmJH?=
 =?utf-8?B?UzlJRm1qSXVTdjJ6ZFI0Y3RwNk51MGxYWC9ZL3dLcCt2T09wa2NWc0NIeG41?=
 =?utf-8?B?a3dGd3Jrd0phOXk4T08xVTMwV2l3WHkwb05lSTl5YklueVdBdkFJdmk5d1Mv?=
 =?utf-8?B?UWxzaUtiMDdsNVFPamlvdk1rNC9KaW80TGc4Z0ZtNUd0dFZnczFZYW9IOHl0?=
 =?utf-8?B?TkwzOWhXSXpFaGEwcENWdlZUb0lya1BQN1hSOEl1RkFlYXBXTGpSTVIrQ1Ir?=
 =?utf-8?B?YjlPSXJaWlRYYmhGVlpTT2RmMHpKdE1EcTRSMjcvRnowUlRHdGtwUlBYYWFQ?=
 =?utf-8?B?blZKb3F4MklPMzVXUjEva1gwc0J4dDdjTzlEWUxGSG5qelRCc0Q2SGE3SSta?=
 =?utf-8?B?c3I1RVhXM01WZDZiYXo3N2p2dmpucnFpL2N0OFdpMGlrekcxSGcxK1hOenlW?=
 =?utf-8?B?Y0RUcjJDNEgvNGRIUDN1QW1WZVA4NlNzTXFPUkNYYWVvVk5rRUdQSXplOFFr?=
 =?utf-8?B?Ull3cllpdGlQNUUzd2FOTGc1VExGQ2lFOVI0TjRlYW83Qk1xekd6eFNiYit3?=
 =?utf-8?B?RWpQeERMNkcwY0I2MWxyc3VUV0hjVGtjbVhQVXFiU2VDNHVyU2Nicnp5QUNn?=
 =?utf-8?B?OGV2eldoMTJYemRGTXk4MEpEYVRpRDZjeDJmc3hpa20rOUVBTjgrcFJDWFh3?=
 =?utf-8?B?WGZpMkUvZ09lb3lTeklEZE5WNUJwN0dXdEo3L2UxUWpBOXIwUkt0cnYvVWZo?=
 =?utf-8?B?d2VyU1hLalhnS2MzRGU0YzFqalhSTjg4bzNaSWVSNHlHZWpCNnRURkNNNHFI?=
 =?utf-8?B?cU5uTjFrY20zdlpSK0hmZDE1ZVFSaStYd2x4a2l3aGVyZnc5L0FnMkt2MEFm?=
 =?utf-8?B?Q0kwU3Nsa2hJVlZ6bUJ0blJGSHZjQ1gweGQyRTFJRjFsakpDVjI0Q010RTFE?=
 =?utf-8?B?NXZQUFFWWTR4bi9TeEV5TzZZZzZibUgrZ0VMUXNxYjFUVTVuRjNtTW80bVow?=
 =?utf-8?B?bjBFUGlTZGZmZjVsSisrRXR6NHFjZjBSUmI4SWlnMHI5M0diUWVQU2hZSG9t?=
 =?utf-8?B?QmgvOTFGMkNEbWdwMCtCVkZ0cEpMZ0dLbGc4bCtWTElYZUk0ckp3S1ZScUM4?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d47e08-0875-4b2d-e52f-08de25d81147
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 12:51:46.8024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0JgIHyG7tywz4MP98YAJwAyYJJQ7U0Y7uY3T1+KNnRu4sMa66TX0A914x0i5PoXr8iKECNuFoY2XmGK6O//TtYO2fotFq2WZSA+QfQ51bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064
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

On 11/17/25 11:55 AM, Heinrich Schuchardt wrote:
> On 11/13/25 10:33, Kory Maincent wrote:
>> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
[...]
>> ---
>>
>> Change in v2:
>> - Extract calloc and snprintf of the if condition.
>> ---
>>   boot/pxe_utils.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
>> index 038416203fc..7549a93bdad 100644
>> --- a/boot/pxe_utils.c
>> +++ b/boot/pxe_utils.c
>> @@ -473,18 +473,18 @@ static void label_boot_extension(struct 
>> pxe_context *ctx,
>>           else
>>               slash = "";
>> -        dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
>> -        overlay_dir = calloc(1, len);
>> -        if (!overlay_dir)
>> -            return;
>> -
>> -        snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
>> -             slash);
>> +        dir_len = len + strlen(slash) + 1;
> 
> This line could be moved after the else branch to simplify the code by 
> avoiding separate assignments to dir_len.
> 

We need to init len to 0 for that to work when label->fdtdir is NULL.

Cheers,
Quentin
