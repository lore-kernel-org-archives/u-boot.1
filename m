Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF173C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B15680F92;
	Wed,  5 Mar 2025 14:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oNUiY+BE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864A280F9E; Wed,  5 Mar 2025 14:28:54 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EDD80F56
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu76FL9RXlnW/v/nkOdZ5ndBD0O6wW6IZNw72uekoCMqMr2t+fDNS509ydqx0ohCOSPBGqtaAEozEaocpxOYCXhkT0XZErhybG3nAjuViT2rtB4ktQMVBUpHMN8VK3gNnHfc3DLTbtpDAy5TAZ/GshX5HoBShRQJlFN0U93GLQm5YPBfRBHQ6xyW9n2EzNyyPsiHNb9/tDpp0aCM+2YIg0UGGQR2CGUdURx3LqPY/enOKXM/3Es3gU+ckLM9FhtVFKAKE63KF5BMJ8fqnwJV4aK91eSKHYzHqqe+kxYGyXh/vwjRUCq8XavlNoU7eqJKCLyenKbk+Km7cE0Ib/O79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st5UqRw/sYIGNah7xN/2mgvbpMyLU+2JuzMumT3EVAs=;
 b=I1+0XrQYK/nEx5SPNXfqd6JOu8MPbLH6t08UrapM0BMbZCcq8fhVX/JDe8tDsgirO7vUVyTqwAEGt0dAXSG40uBDDNM4uh05NZX3YHNIwVj6JNt43289iKG1L86hvvbWivKzLbyRxsu8nzvVmBbv+nV7MNlq4AL81j0atyx9oPBznnFOK2azQAb6TquPVJKiFckiTXNWOyYFawx0aRNl1XBK0Mo4SoYsIcUKg7yzraoIxh007AgAm/ep8WP7w+dU841teLqFO7g/opD6FwHg7p782PhIOOUR9TXWO9jjpIDkl3SphCAUa/FxBRYcffEzw1hKNmU83NtLwBrNx34/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st5UqRw/sYIGNah7xN/2mgvbpMyLU+2JuzMumT3EVAs=;
 b=oNUiY+BEtNvdaxiX1qoO8kvg8BYlTSFelTQlHJ8OU5VA8ce+xXSUdE2dutiGmuoV+W+dhdDGqF9DZ/0oO8oke50OdHKmpODtPHqNiy8DyHjvKFhXiNmHuJJYi3moyIGlScVUCRkVghtEegZt3T/+xSqAWFqLjne/KJ6QF4MAgFwjPDisg9TH/D1z5D39zF19u6bpfSFw171BQRxUEF1UTKoZqrDs0/eKEj+/V8YQFvhQIaL2Ztdc1IWvI7gBNWKNqA/tQ7cQDzku9l1HMVgLKYhd6qhbDaGsM8QVWg8C8j1g9sWyUUawdVNgPlxLHnNC9DHoDS8eaH7WhY252T7kgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:28:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:28:50 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:13 +0800
Subject: [PATCH v7 01/19] firmware: scmi: smt: Interrupt communication enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-1-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: d376f6cb-2d0d-4efe-ed79-08dd5be9aa74
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXgycjAwMm8yKytUM1FZa25DNmFZSlVpeG1XZUVMNVhvUGhwazhNY3VnbFBO?=
 =?utf-8?B?cHdjYUk2b3FrdVcrYVdWWklVbUNJcDdRNzBCaTNlVVlSdFFWcmZPcjd0dllP?=
 =?utf-8?B?K3JXNXBub1VBbFNZOExWc3pnbTNmMTV4UDRhM2ZtSzd4VUtGNTlsZUt3YTJG?=
 =?utf-8?B?RlpqR1FqRElBTndCSDh6YTZ0Qk5pa0FRY3NVUDY3ZVYrMWhtT3QyZ25Mbk5y?=
 =?utf-8?B?djRzSnFnVXRtM1craFd6L25GUW5MYkFpNFZwUyt1ano1VU9OSUR6OEUycnNr?=
 =?utf-8?B?aFJOaGlVWlFuaTFqUmZJbHNnQi9NMkg2MHZUTk1CeXJJYVBtc0RsNkxvZVRt?=
 =?utf-8?B?YVNMSnhzWWtiVWtEZERwQVZOVFZuVWMzRVRvMkJqRjRZUWVoSWlORVZIZFVv?=
 =?utf-8?B?ZmMxVXBGTWFUOWtlQ2ZMS0VNcFQ3cVZnb3NKSUs5cHZHMEgva1hwalMrMzNo?=
 =?utf-8?B?SHVPN0dCa3RxNHhEbnExbng3SExGZzl3anViaE1zZ0FqN2dXVGhzVUNWbmp6?=
 =?utf-8?B?U3g3dmQySEQzTjVZZzRUbnBTeW1ZNzJoQXBhNjQvdUUzVVlEaGdhK2ZscGtu?=
 =?utf-8?B?ZnhMSkUxQ0ZWa0dkNjdQNXBhZkpXMzZYblpTbCtoNk5sbkQ4czdtQWdnUmVp?=
 =?utf-8?B?ZEdyS2laWEFPbUVUWS9NMmhyMGpJSG1LM2xSczdsWFdpS0RKZmVPQWhvaEl1?=
 =?utf-8?B?NFFuQ1VHMEtFTGFCUlJCeGtIRDFJV1JzVjhPd3VlTFhDYi82cy9zMndUYWIx?=
 =?utf-8?B?QlUzNjlCOWtqMy85R2ZqRXN0elJuM3pkbG1UYlU3YXd3ZlFhZ3ZLeTU2VFU5?=
 =?utf-8?B?ZWdWZ1p5R1MxaGVZZGZMNENRQWh5OEFBTnV1UGlsRW9RbFBFQVozblNOUDZ0?=
 =?utf-8?B?VU11cERjbmRITk14Z0hTcDRvdGt4T1pEa0EvTWhPSDNPMWVpSXZ2QUZWeE5H?=
 =?utf-8?B?aEZub1pCQ1VTbHpLVnMvdDFXa1oydXg0Z0FKY1hCVUtaWDRxRDBuVkVldy9Y?=
 =?utf-8?B?ZHJFUVVxd2x4VDQwaFF2UThFQ2VhaG9JYlQrdkQrZS9SdS9tdDkxMWVpNzM3?=
 =?utf-8?B?eEJQbys5Vys4SVdHZlQ5MFFYZDY3bWdVUE1rWEdPZVdRM1JlK01iaUtpb2k1?=
 =?utf-8?B?VjFOY1dWeldianN0Y2ZKanBpV1AwUC9Ga1pRWXlGbm9RaVpla0RFRmZCQnlZ?=
 =?utf-8?B?bXFLRUkxekRnT1RaaUhxVElQcDh4NHlNSHYrYXdyRmpZR3F5N081UmNhZjE5?=
 =?utf-8?B?L1hHM0xUSkxycWxSQlZuNDRIcGhPZkhNejF1eHVGb2h2QXYvVjlDZjdZS0ow?=
 =?utf-8?B?UWxjRFBsdU05WEFZWVNTNmU3RU15ZDRaNi9yUTljWkNRZVhSK0xaMkU3WDRV?=
 =?utf-8?B?ZHh6SFJpK0VWUnpVcnJCWURuNTFqTlZCWmY3MC83MjhlM3hVMGJMNngxYzQz?=
 =?utf-8?B?ZURKODVRUGdtWURrcVVLQkFVcTkxUFdzNVI4MEJvd05mOG0za0JSZ1pBQWVz?=
 =?utf-8?B?Q25NWG16Umo4NkNPMzQ2NWpVdXVZVjdzU2FBYjZnK0d1bjQrUUdOUUJLZm5z?=
 =?utf-8?B?eXJZS2xwRGZOdVpuWUo4bFFpTVFEV3J2cXdNTHJiTGdQNUgwaXhUaVNBZ0lO?=
 =?utf-8?B?dGFjRFg1WFBPWFplK09saEE4ZTVKSUYybXpWRHpqQXZVTE5VYUxDSFBZRm9o?=
 =?utf-8?B?TlN6ME11Q2dGdk44RjllSXk3SWRZRzBPa1V6Mi9vbWJhNUU3bGxzK2VwcWZk?=
 =?utf-8?B?dWtaVk1SVzgxbG1FRVl1MFpxOHBucnVDQ2x4ODJDTXhXUVozaWhya1c5Zzgx?=
 =?utf-8?B?aDNIUWxmWHhuVXd1OFhQVy84bmRXZGkwUUxaMEhkcHJaOS9PK29PUlpLUjNz?=
 =?utf-8?B?OG5aWHA0S1RXQ1RRcVgweVBnMmROMHR5MlZOM2hPSnV6VkpQSllKaGtGdGdl?=
 =?utf-8?B?NGowaHlZYWZ2bUlnY0tzMHZteHlZUnltNDJPWkphQThSKzcrSjZsN1plWlN3?=
 =?utf-8?B?SlJ3YkJHdGF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STQ3aXJVcVZDZ2F3OEdLYlFrV0FDMFpQV09wSFNkZjk2cmVpNElLVzRoYlpN?=
 =?utf-8?B?b1I1d0ZkcjRHZUtrcHJQQmJXVTNDSldVUTFsK3dIMERYa2dIRklYMmRMSFM5?=
 =?utf-8?B?UUpKZGRxa3N0Mno0ZFNMOW4xOVRLZnJDM2c4Z2hrL016MytiQ3RqRlhBV3FC?=
 =?utf-8?B?MDJ3ZC9WVVJmcWpBOW41SENBWnBTOS9EMWV6aHBVMlRHZGJndkg5Q0F6a0Ix?=
 =?utf-8?B?R2x1anlndDdsV1NiSUpVOUxlZ1RQVzhuR2lUVlMxZ2FyOTRaQk1nbUlQc082?=
 =?utf-8?B?eUV5ZUFpOGxnS3pIaXdpYUhic1RZVXVOZmMvZ3JNRXVqNm96WmJ1UGRsdk5Z?=
 =?utf-8?B?SWJoclVuY01HSjl1cHQ1T3VSWVozWjc3SHRjVzA3MW1Yc0U3S2J2d09EYlpz?=
 =?utf-8?B?UUE3RlE0VFlTZTZNTVM2a2FiWW01M1RvdThYbmRmekJHYUdBQ2t4ek1oOW8z?=
 =?utf-8?B?S1ZpakpzeHN0VWZObFc2RVFSRU9oUCs3UUVNRjNZcHYvYWgyTFM5emEzUzFV?=
 =?utf-8?B?NUJKejQ0akwxTk9zd1BlSVRIczN2U014bnE1eWRlN1FFMURTd0h2NjEra3Uy?=
 =?utf-8?B?c3dKYTlFQTJCUTZtc0FtWmlnNERKVTREaFBkNmNnYldVeVVuWUlKMlNIZHBL?=
 =?utf-8?B?dkdkQldCdis0UjVORzk4Y0xTRDZqYXI0c3piQmYzaVdNNnQ3RnRiL29iYjB2?=
 =?utf-8?B?ZEtGbWl3M3JGWmRtOXoyM1I5MHFxc29kNGdSNW5kYXdNNlBjcGd0NERQd3NG?=
 =?utf-8?B?TmxHZDJ1djZQYTFCQmhwZ29SWjRDMzhTdStoZFczNlZTcEVNYjBvRGY5UnMx?=
 =?utf-8?B?OUMzd0t2bjBFaG1RRXV5WDVKNWpJdHZxT1ErZm14MlprQ3hXK1ZLTms5bFR6?=
 =?utf-8?B?bUJycVp5OU41VVJBNGRSUE1JK3FnVEUwZzlCN29IRkRrN2NLOU1lOUp5ZWtj?=
 =?utf-8?B?dm1KM2ZZbGFPRCtJL29Na202dk9QUnk5aFZYcnBqYVJiUmxZbGw1SmlWbHhm?=
 =?utf-8?B?Q0EvNGx1TXJ6Wm1RVFVrNXpVVkR5bUtMamhlUkhCdSs5YUIrYWJMZ1N2VGNB?=
 =?utf-8?B?YXBEbFhPNnI2Q1RuMG1wZ1I1TElBQ2Z2ak1hWk9XTGFVNkJYVE1qcDhWSURC?=
 =?utf-8?B?a3lTSWxrUDhPdGxQdXFqOHY0elI4NENzbkhiRHo4QlplS2cwVlo4UU9SOFM4?=
 =?utf-8?B?Z2kwVXdFSEhvNUpFcUpWQzIwWHN0TTZNbStEcE1IT2VOR3ZzNXl6dzlGaVdE?=
 =?utf-8?B?ZWxxeUVMaFdobmdjZHdtWlpNY0NCM21TN2lpQm1rVElCU091bnNWQnp5QU9Q?=
 =?utf-8?B?QjN0dHZ1WDBLcVBQVWkzMm5GNUFQY0FnYkdIdXN4Qmx3WHRSNWRtM2ZUdmJn?=
 =?utf-8?B?RlIreWtCSCtTeXNva05hZXF2cVlpT2owa0VLZlVqZnRKdlpZRXVIcGNFMzVD?=
 =?utf-8?B?OHQ0VDJVbnVvUGUya0NQK25VZmVzemJ4U3Z3VHVkUHdtcW1rYllKakFwQWds?=
 =?utf-8?B?dnVkU2FPVDQwQS9tYlByaG40a29lNGwrcEJyc2VQV0sxd0RBay9aREhuNkM3?=
 =?utf-8?B?UStUS1pRcDFtbXpjYnBGV04rejFMM3JubFN4cXNMRHdPaGtBRksyQnNiR2tu?=
 =?utf-8?B?NnkyVnNQRjZKVVJoeWZ3U25GRUYxamtlMTFBYnE0Q1F3M1hJV0UvYVlLNjNs?=
 =?utf-8?B?enYxWkdhMEZPWTBEbnRqUElBRzEwS2Q0cU8vTFFLcmZMSFNleDBYd0VCMm5v?=
 =?utf-8?B?TmtSR2Y5c3VIemQwck5mQTYyeFVOalYzbTB4VHFQSnl3bGdjS3hwVlpNejdk?=
 =?utf-8?B?M0xMRVFPTEVRS3lhNnFJL1B5ZHkzMXdmUlNIT1JKc0dBWllHZ3duN3k5ZnJy?=
 =?utf-8?B?eDVZNkx1Y05wTnlJR0ZsM3lmalI1andhVTlmWk5TSXh4ZDRMU1JzNGhNaUlD?=
 =?utf-8?B?TnIvL1NwN0c2U293dFpvVDNPdU9hU3NkUi9xSXdkOHRueVJBcTZNV096dGF2?=
 =?utf-8?B?MFZKNks3aGpleEFUc0wrYVpZNm9aTzhuWm5Xdmp0REVvZW5NR3hYRkcwd3N1?=
 =?utf-8?B?VEVCSk81Y1EycHZrV1JERnk4bUhuajRNRGdXaHl3akFRQ1UxajQxUm5URUxL?=
 =?utf-8?Q?bMtcCV/bYGCbLQ+HpM0HB81hU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d376f6cb-2d0d-4efe-ed79-08dd5be9aa74
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:28:50.5024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X68vo7xiWbPD68ayw3mfteMm7lSyvyd3EUXbd/F67sm2gnij3BWK6tQe3oIRntM0LUs6p5BrV4J+fyG3J2xULw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
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

From: Viorel Suman <viorel.suman@nxp.com>

i.MX95 System Manager uses interrupt driven communication which requires
the caller to set Bit[0] of channel flags to 1. When transmission
completes and the previous general purpose interrupt has been processed
by the other core, i.MX95 System Manager will set General Purpose
Interrupt Control Register (GCR). U-Boot polls General-purpose Status
(GSR) to check if the operation is finished.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/Kconfig |  6 ++++++
 drivers/firmware/scmi/smt.c   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index 8cf85f0d7a..eb62b88615 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -41,3 +41,9 @@ config SCMI_AGENT_OPTEE
 	help
 	  Enable the SCMI communication channel based on OP-TEE transport
 	  for compatible "linaro,scmi-optee".
+
+config SCMI_TRANSPORT_SMT_INTR
+	bool
+	depends on SCMI_FIRMWARE
+	help
+	  Enable interrupt communication of shared memory based transport.
diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f45002..a0489f9718 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -20,6 +20,16 @@
 
 #include "smt.h"
 
+static void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 /**
  * Get shared memory configuration defined by the referred DT phandle
  * Return with a errno compliant value.
@@ -48,6 +58,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),

-- 
2.43.0

