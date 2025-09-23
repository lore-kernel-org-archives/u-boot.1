Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE0BCAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5223E83448;
	Tue, 23 Sep 2025 13:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HvsxfWuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7A983448; Tue, 23 Sep 2025 13:12:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C765E80050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHl3EVnc/zEYPzuyHcg1o6I64aX6IycGC3FNa0x9Vsacg7oH1P8JJfRNT17tnKWHX8fJAWOmDmeHtKnClvaXtOiSDii7q5KmIC1uzfzDaN7QsqL2wpTLp3HoTby1jwkks3huCeBXv3jKsZmd7nGN52G/cJCY7J1by6giWv13MjW7u/+HUQ8aqo6u6GxYhy702uzuQKt4+z8Wlgrvj33hSxv3qqBnuBLcrAEwaVLXoGI6R54/HB4D0YqNvoofNHTczJ1JlqDevSUD2heB4r+ILHrYnjM1U/m38X6BlJIGpb40ECZahzjpPXFWgJB58u0kepzD67uSR87I7Rp5TWYyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y9qsJAmZMlTC68OotkdaebBPNwIdSqIIrLwhV9qjuM=;
 b=dgZIZuC6AP9EaOzNz6eV81ZhL21Dhu1x6nd+Qv9p7K7Rmk3jG1BtRMpJGJ23Bh6iQ/oL2R0QS/+bc8C8gX378kb2qgPMuody3728qsmW+HdXRYbibWyIS5ZJj+lpji4ADVnPafsqkrah+oumEqw/XWm+swhFAuXxL77li2T5GSUajoRsoGcmqK7k9KBkya3d2Rj6re6HBD/UUXc9nQDnQLIv6pywZcsflF1ryh8GmSohSzGNzTQuEI8HYK6hXj4U31CNEk76OyyTpluTvMqSFF2aUZpjccaMTVRPyfGXhYGrbwJUWdrhBdRF/OTyEqU43K/lMAdAmnI2TzmBFT+9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y9qsJAmZMlTC68OotkdaebBPNwIdSqIIrLwhV9qjuM=;
 b=HvsxfWuFFhAAzparVlJ+JZf5zRzVu7LmjttjkM4wVITpq9CVGa31MXL7xb5XpbB+T5O7YZfAhOF46L8VM+z7SzdYD4BV4V2ONrJ5aJHiiNdpI46nCarY4Gl6zSAVB9Vop7upDnsO2tLpJWX9i+QNYI4qJWReHWPvFAtqggmhJ1VkDxeeYm+S+SK+he2QohqpPYwy+eUJ971umWwH969pr575MKQWYRkWgmVbKhXADlojUYTQmInApQhkxR5TGgPFA+okJ+HktJmm/aOpafZTtkJUsyi4ksldOxyR/397TE0OPQiKYacqC7RATKybw8JVQ98iTXYmc0YMHrbmTv2i0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:10 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:45 +0800
Subject: [PATCH 01/10] usb: ehci-mx6: Extend support to i.MX91, i.MX93,
 i.MX94, and i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-1-507cddbe7214@oss.nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4efb35-26b0-416f-6ea7-08ddfa920a24
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3hndnkwR1IyekRHSEJsRldMWmdKbnRkM3l6aEpqeUF1WXBYdUkyYm9UeEla?=
 =?utf-8?B?SnZ6ZGdyaFREQzJBQ1JiSlRuTVZUek13YUtQa1hadE4zRnppU09jK21oMHp4?=
 =?utf-8?B?V0dScktaLzF3VituZU1YL05QYXB3M3MzcU9RekZKOUtWdnh2UVpMTUVTc096?=
 =?utf-8?B?bWlIMEFndU9oS0c2cUVVdFJQdjArZmJVd3dydjhQTDBrQUhKK3lGRUE1bGl5?=
 =?utf-8?B?VkRzUHpuK2syU0tNSTh4TWxHRHlXbEpPenY2a0g5SjN2dTgxNG5qOS92K2FS?=
 =?utf-8?B?VkRncHNJVEJHQ2ttUXAvMmZMNmVsNGVOMXQyb2xBZ2VaaU5UQStpWDJ1YVpY?=
 =?utf-8?B?L25wODBySlZHcXljTkdWRFR2QWt0cXpSSyt4YXMwTTFUMmJVZDJsVWtIRlND?=
 =?utf-8?B?NHRRc3RQTW5ZOUZRTkhMcmFOeGJWb3N1VUwyKzc3U0toS3lteWdHSjltazQ4?=
 =?utf-8?B?UGtSTlY0TDB0WW9hZlJEVkhpWElRMzhUcTZkbERzR1EvWEJlcWhZSHNyQTda?=
 =?utf-8?B?dExQcDY2VE55NjNTaTFnRTd3T3BhbTRWM3VyK3RvTzAwRW1hdmQ4Rk1SaGY5?=
 =?utf-8?B?aTJsSk92OFBsUnBIbFROcUpubGhYZVNDRXBoWTFQK0dDMTZJR1gwM3FYRGZ5?=
 =?utf-8?B?ekFvMHZNMy8rN1J4OEJrdnhMNVRid2d6VTNhWHh6NUNvd1h6K2JuNEtDZGdB?=
 =?utf-8?B?SGhZR2U2Rms3cXIySVZXckg5YmdFRTA5YWZURjBhSFVraFdFS3NXcnlYUmZn?=
 =?utf-8?B?azFWSklTUUxZYVVTVmNQeUxLZlZhb2lhUCtIZTlDN1NQOFlSQUlTZlZPM3dQ?=
 =?utf-8?B?YmZvS0YraFNCQkxuSGZkU0xoTmJmNmRLU3Q0MXB0ei9pbitBTEN1bWFEdDBs?=
 =?utf-8?B?UDdVNG96YkpnQkw0ZUpsblB3c0JjcmQyNDEyYVFKZTI2UmFQZE9XcXNkQzB6?=
 =?utf-8?B?VGhnbTF4WXdvdmp0UVdrR3FMNmp5WVdMT0hKNjQ2WGhzSkswTEo0NUpNcnAw?=
 =?utf-8?B?c3pNMUVucDQ3anN6UFNXOFB5L3lxYklrMzNxeDhORkpGeW5iZXhYWElNUkNu?=
 =?utf-8?B?cEliUzJLVlNjRmU0VU55WWt1SlFDT1Y1elIyUFRabUZ3OUhUMTZrdklURGU0?=
 =?utf-8?B?cXJKOWkvNkllcjhmOVJlN1VjRlhlSEZ5eEx2bkVkZ1IxZE1mRklPRmJhYjAv?=
 =?utf-8?B?ODBWL1lHZXlYNDZSdFZGajhNNzF6TS92U1ZzN3dWaXdlSTE3UGVmRmJMbCtl?=
 =?utf-8?B?SDVxTm1VUWVaZ3ZCOWVIdzlFdzI3ZTI1TjdCRGZVSzZYVVVUZWQ0bHRuTmh6?=
 =?utf-8?B?Y2lIeGlVT2hYVytONFR5bmcxL05ydzhWdHlIdjlyRlNVMFZZMElEVEdmSGdz?=
 =?utf-8?B?RTcvT281Lyt3QXBnalI0M1BNdnE0ZVZMQ1lMWmtIaExDMTFPVUk0MHljRjRv?=
 =?utf-8?B?bTlMTUpFbFIrS05TQTgvUlBpaWQ2T3FYNE53VjV5QnhuTUhkcDlqc2k2R3hS?=
 =?utf-8?B?WGIvazZCeGU4dWR0UGYxU3Q2bjZCZEdnK0RYcDlNWGkxV3Z2RFUrcFFuekpk?=
 =?utf-8?B?a3dvdmxtdmx5NnlsdmwzSDEwVmxpNGF6U1dXc1R4TGttak9OR24rRXNXOFlJ?=
 =?utf-8?B?RWFmYjdFa2RldldVaFplSm9QR1djSUY2OW02Y04rNHdMWEJHQXBGdmtndEgr?=
 =?utf-8?B?VnRaemFtV3Rqc3ZIRldQVkxYWWc4amJVOUoxS2FuRE5lMmJvV21DSHNVeUtl?=
 =?utf-8?B?QmlDZGc4OThKd1pNeEk0U0p4R04zcnZ5ek9DVW01UWkzUFZ0ZW93SGtqaFlj?=
 =?utf-8?B?MmxDZWRMcEh5OGllb2U3U3hMSGYyOFYrMXpnL2J1NjhxcUxjUEFIczBKRW9j?=
 =?utf-8?B?MnF1MGdlWTgyNEJxd2l4MUtBTFp0cUNKSlh3Smoyc0JGRXNSNW95Nkd2ZHht?=
 =?utf-8?B?Z0VTQWVrTSsyN0ZpQ1VVV0dpR3NjRHUzUmxiRnFPRC9LeWhvaTYvTGNaUVNK?=
 =?utf-8?Q?hKCUD+sUytst4EGunp9q82p52qYgW0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5oYkpoZVh6M1JZMVl0NUw5cytIanNRcDZVcEt0dlZNYVBoR05FUDdEU2pT?=
 =?utf-8?B?QWxndUljS1BxeXZ4UDJTanRIQitUSVNyMEJ2Wk9nTEZwVFNDeFpHaVVzS3ZT?=
 =?utf-8?B?M3JWY3MvWHovcjcyaFo4VlVFcld0MlBSR2ZIZXVjOFUvU0FtNjNEZXFiVk1E?=
 =?utf-8?B?V21ySUZ0cGVRUFd0TGpyRHA4cHdSM1cwdlZvWDQ4OWs1MEhUUjM0ZUJHSENE?=
 =?utf-8?B?MzhjWWtGcC92YzBrM3Jha0ZUWUJJNWh0OEovM3BHc0J1VjJiYVhOdCt6RjZp?=
 =?utf-8?B?aysxWWQvMjFGcEZBbXBJWmlYbDhGNkxLaE9XZ3pPTThBVWJURm1IRXJXbGhp?=
 =?utf-8?B?SlE0c0p0MGpYYmUwcnczRlY0WTZxUm5uTGgrQ0NtMlB5R1pzalgwaFJ5SFBT?=
 =?utf-8?B?VFlBVzRMaFhkbktsRUFWL3dSenpGUUxsM1lqVlNoLzl4aGFPbWxpTXc4RzJT?=
 =?utf-8?B?bytiZDRGK0ZMc1lvZzJiamJzN0FJY01NZkFUVW1KcnowYTlGdWJvRytDcnAx?=
 =?utf-8?B?dE85SnZaYlZWOXh1UjZ3ZHFRMEx1aHkwSDNMNnN2elZsemtiMTRTSXBFb1c1?=
 =?utf-8?B?SGozcXRHSW0vMGtDdEFwS3pXRXV1dTJPZENBUnJEaHIvVHU4ZXpQM3R1Rkh4?=
 =?utf-8?B?RUNsVE9Sa2tqMDhrZ3NvR2hvbEs5Qnd6YXhVNk5hK01iOTQwSVYyR3djcWUr?=
 =?utf-8?B?d0RsMHFXbVk1VmQvTFl4N1A1QWduVXRSSGtSTHhiYVN4OGNQa1NyK2pSMTRO?=
 =?utf-8?B?VGp4bFZaVEtGQ1Vwc1FSTEpKT2p3c0dBWkhJc1NGRXEzQXo1STluanIxalRV?=
 =?utf-8?B?elVsc2ZUSVB5bUhFb1NmT1ZzcCtMNklpSllpdXBUeExMSzIzdnRGdGhnQUhJ?=
 =?utf-8?B?RlZQcHI4WmF4ZzkvZTg5OUt6SGtBaituMkUyWDlXN3ZFUTk5Mm1uVURZaEJU?=
 =?utf-8?B?TUFOdDhHTDNKb0wzY2NtRC81L3pPdTVZYjlqSEI2MTFZSjZWVWhVZ1Jzd1No?=
 =?utf-8?B?K1BwSUxWTGcreTZwQ0lBTHoxbUJ4ZE44VTkrZTF0ZGZHS0d3dEExalRyTDhj?=
 =?utf-8?B?Q3k1YmMzT3U5cmZ0SFB6RUNISzd1ZWR3WjBLT1BnR2plSmcvWk1CRW9KcW5a?=
 =?utf-8?B?SUlzazVnM29wK3k2QkZTempZOXUrcGtCOHdtS2YxNm5uVVBIRXkrVENQNG9Y?=
 =?utf-8?B?cnk1SjBxYWJ0QnRTT1RmRW1BbTBUV3ZIaHMvOHhkZ0pzR24xMk96NHRtanpS?=
 =?utf-8?B?ZmczUmpnTEVPTnVpUHNpZFo0ZFlQZmdUdlpZM09USERRV0xiVjJ1NitoM2pS?=
 =?utf-8?B?dzRjejA4UDl0K0RXVlVVS2FaQm1RUXBQc1FIUWJ3SFlLWWFzWWNldFZtNjZt?=
 =?utf-8?B?QlZxMlZYSnhMVzBEVkhQNTBJczZaU1NPanVacnNMVnRKTGRCUGhQUTdIbWJp?=
 =?utf-8?B?OXc3U1VDSlIrdGNQVGU1eE1lMFZoMXp4ZzVGVWFpNFp0TVNGamJOOExqUDJ3?=
 =?utf-8?B?ZzJYbXFpNjZYTTZJV0ZBZzNtVmdmZ0grUzY1dXlrWWZ5Tm82SXJ2aGNQR01Q?=
 =?utf-8?B?U0t2OE9BV3Q4eUdHcHB6NVFJcTZkbFRZeFoxTDZrRHRSb3dJb3lpR04rYVps?=
 =?utf-8?B?UjJqTGVsaUl4U3BLajg2VlZNWEttK0V4aDRoYlhBSjZBV3EwSHZMaWVIY2FZ?=
 =?utf-8?B?dDBGbTlMZnVnclZ2cUFBTHZVb1dzbnhFcUlQNnVCMWZWN0ZkZDRXQzNlVWdE?=
 =?utf-8?B?NjAzRTlsbllwdkloTEFHVTRGRFB0c0ZJbUVEWS9oWmZhY0Y2L1Q5OTllZVkz?=
 =?utf-8?B?cHFnRE9lT2dDZGJTNVBIdUdoeUQzelhlS0lZdFp2cjYreVJ4dC93KzBDVWhW?=
 =?utf-8?B?VC9FdVBjdUZEQjlvTzdoZm10YmpzL1lSUTJBWHhnS0VHbU9rOUJuSlZQVGxT?=
 =?utf-8?B?NnBnTVdtcDcwWGZ6TFhBRVpsdnFMem00Wkp1TnJUZTljQ3VGa1pUZUdETmli?=
 =?utf-8?B?YXh3S2FwR2V4NGhmVGR3dFp0RExTcktEZFhiaVg4MHVHRVVWRVBKVlNoMnIz?=
 =?utf-8?B?Y1pTQkJLaFluWUJBNnAwcy9QTlJyUTMveE41MkxFa1Z0eXpUMHZkajdSWkZ1?=
 =?utf-8?Q?z4uKXCmpT9zsv2ccWjtvPcXOE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4efb35-26b0-416f-6ea7-08ddfa920a24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:10.0427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNAHpS4FsLCuik59YEtG0cMil/I36CKaIiWwVOXDzbQuGFR69dl/IsOWTCX2FkjB5eo5u7XaTByEArJj5gNWlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
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

From: Alice Guo <alice.guo@nxp.com>

Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
i.MX95, the condition check is updated to use IMX9.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/host/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5c9e8fc9d15..16f210b1281 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -209,10 +209,10 @@ config USB_EHCI_MX6
 
 config USB_EHCI_MX7
 	bool "Support for i.MX7/i.MX8M/i.MX9 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M || IMX93 || IMX95
+	depends on ARCH_MX7 || IMX8M || IMX9
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M || IMX93 || IMX95
-	select NOP_PHY if IMX8M || IMX93 || IMX95
+	select PHY if IMX8M || IMX9
+	select NOP_PHY if IMX8M || IMX9
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.

-- 
2.43.0

