Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F097C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4AD81115;
	Fri, 28 Feb 2025 11:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v4KndKhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB1C28110C; Fri, 28 Feb 2025 11:54:53 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40673811A7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afcIULJ4NHXhgXjZRU4qusVMSF3i9NNTNJt0XHvWjGYoJDsp+O9cdHjd1NITjYtZZ9UlcPPUqk+tHkp2otFIzrtG0DqtnLr9tP1BO0ii4+EIVM7hXwjsh+vviAkdxlSJ9/Dh1nL4W69F172DTxh46raKkjrpken9G4DKpUdDrAzhkrXagAilLmQPYmYgGMwqmjPE2BeO/3uNaIt8InB5ElOdXL9z3d7PhVJGI2/cSluky0u9a7ftwamV351QSD/DPRceQcOlpKtquLlHB/dlkxmJCuwyvKuE3rTobi8ylKXzO0p4NwXgxCAvhy8sWfjudTS1oIRpfLt8NgXu49Aqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzLHBrBUitYXwV+sriPI+I2dWYf5G4FGP6uQmV7MEjY=;
 b=w7+o9t8SW6Br9XqE9o7RS2s/BhGQCjowpS2/aSt/EtJa16Ehlq3yc4k8JpsD3q24d920Baim4Vm6hRmg7GelOy+k6DcEzudxbs4sIXkiL+UC8LRyo+HV7a6ilg1827DSn1ZaKW+1QsVrZhu+08hNnfF9Lo5EuGVfB+nUHk9qa7/zFUr8D+MX0/r4+vrzc5oz0hYA+T0i4JKLTMehu61yW+xMej8kifL+QDjQUsLIt6Cd4/iegQykbkOelkFsR8wanAyXS2g0Z24Zc84CXP+Xf2OM3cd0pdZcNuMnW2iidMgM/5DjStbJhAWTFwx1Ybg8+xgyGLeZKN1M5Aut7U52kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzLHBrBUitYXwV+sriPI+I2dWYf5G4FGP6uQmV7MEjY=;
 b=v4KndKhN1xW+c/93sBZ9uUvURYYAkk4RNzJ7OJaAo+ByVNaayI0cJRZCR1XxYr5i8Ljp77/Ur56c2r45trN2o5NxEOGE3O2+M+QQoIBma0Meuye/E9NzGeT2tWuv+1+xQIGN608wnbcsAkcJ3bfCDlzfEgQepi8lmmFkgcGgXMALEjhm91zhe8VqUHx29xcqqtVyJ7NXPymb+Om1snlZFrKieYwjr6DCD9H5aeGg1JCmXX+IRwWrOOhmRwF+1xesoUrFR/wAHkR0OfWkC5ubb9PliIUvxgaGVVUX1/fMQOidmH8nvAVbL2PcEZJq1F3ZfMPE8Bt3N6T5oG6iwiBP/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:54:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:54:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:53:55 +0800
Subject: [PATCH v6 04/20] firmware: scmi: add pin control protocol support
 to SCMI agent
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-4-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 499408b0-7276-4601-3175-08dd57e651f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c28rVzNCaTZ1RjJqV2lER243N1NYYXRMNXJqWWdUMXcvQXliMDNOSWtpd2Vs?=
 =?utf-8?B?OXpjcVh6N0xqa2ppcElZazZBOVlxSU9ycmppN1Y5NTRlUlpTbTJvL2IwaHlw?=
 =?utf-8?B?R2pia1ArWW9ZQmwxTnVvSHlTOVkrdTl2R1hyeE00V0pxWVl0NXp4N0lHYzN4?=
 =?utf-8?B?VkM5VVZYd25lbGhDTUEzQ2YxN3NDMTh0M1MvQ1FUSXd5NlRXU2VpUWVEN0Zv?=
 =?utf-8?B?ZENTMnpMcXkrV0RieC9Ganc4NHloSDlZTHVCSU5yQ3FUZFJOVmhCV3NXdUxn?=
 =?utf-8?B?UzFZK1lUcFBIVDNLSkFUS3pQQWxpcm9HUjJua1NncE85S2Z0RXNWQ1U4UmNh?=
 =?utf-8?B?TitOdkxiV05Cd3ZYd1JEbGVMazZXRFdVajgvcE1sdTZlV1dwNTFRR0NSTUYw?=
 =?utf-8?B?UU8vVmxjVVI4QVMzVU1YWVlsTitUYmhFK3FLZDRma2NJTFRjdGdUM1hKQnpa?=
 =?utf-8?B?cGNtL2gxTTN6bEdER2xXdFJTbVVneXl1eXQrSGdhVkZnNHdqS09OWE9kREVQ?=
 =?utf-8?B?Y2loVC8zcjF1dm42WWxKamErME1GSWwyMFJ3OHJXMEFpZTk5MTRNTWRTUXNL?=
 =?utf-8?B?UEI4YTZyemptQW9Obk0zOTdpU2hTblVMODZKMHdmTmdTOE1zT2l1cWQ0aUlq?=
 =?utf-8?B?anhJakl2eWlhRWVpSWo2a01MNGFmUU5xQW0yelBOdGhLeHZVTVBYQWlEd282?=
 =?utf-8?B?SHVBMlhsZEJ1NnRsSUQrV0NKcU9IT094RkZ1Qy80UE5lbzBtWVVFZC9wY0Zk?=
 =?utf-8?B?Uk9JbWZOenBzTGNJQmp2S0ZoNzMxdHVKcjNtRnF1aUdiM2J2SW1NdHpHajNo?=
 =?utf-8?B?QmQzbFBTbEVnNHhHS1RuWWlMcGc4eFYxSjZWVEY0TzhGeFRoWk53MWthZjFl?=
 =?utf-8?B?WThxZGVOcngwcUVhaG5FQmZ4QldhWFB0NzNVbTZ1MmEyZUN5aUVFT1I0dlN0?=
 =?utf-8?B?T0d3UCtIK25LZVRIR1Q1d0pvb2pQSHVyWHRnbFlaZ3JwVzR0OUQwUm9UaDVJ?=
 =?utf-8?B?VUhST09lZ0tKdFhDek9mZkhNdTdXekg0TGFpd3VDSGRVRFBmRHhiL1BjblBJ?=
 =?utf-8?B?ZStXRDFTdkRwMXFNTTJsYmpwMmljTjZOaHBDMXlnTlRaRXFFM2lUWVpKaTkw?=
 =?utf-8?B?WUdEWkdXeVk4dFZmZFRhOWFhRWZKemVpU2dxNjlQd09yVGs2RzBwQXRJcW5E?=
 =?utf-8?B?RkpialluN1lyZm4xdktWRFk0VUlGSW1kZXY2NTB6UkRnTGJSZnBWNG9ONFNo?=
 =?utf-8?B?ZlVwUHgzK204U1pyS2RIanByTEYyeGJhL3VSTkZYREhKRkliejBTNVl4UDlt?=
 =?utf-8?B?cUxPSmFRT2J5bndEUDc5VUwvQko0L1grdnNVZ3I3MnBUSHRrNWhrN1BNa1RV?=
 =?utf-8?B?RjRrcUpCOWwySlFZMHlQbDZoVzVhWTdxc3llRzZQVHFnZytaNEkrdHVKNFA4?=
 =?utf-8?B?N0FrdG1TSmJCUTU5SWZpZERFcDZXZHZJZXhSaW5zc1M5SGJYY0NIbkRJRHVI?=
 =?utf-8?B?Uk9kRHY3T0JSdzRtSFN3WjIzbElJbW45eUJGSzJ5c3JIMjBrd1FBYlVBVGF6?=
 =?utf-8?B?U3h0NnhnWVFsSWJBdzhjdHRwbjhyRkxtWHhEWmwyNm02OVRIVnBsdE0zYWFI?=
 =?utf-8?B?Q1BZSDRMRnVUM3RkR1luZmxJTjhKbktTWGtTaG5MZXZSYlNScVJUOXJlQjQr?=
 =?utf-8?B?RktpWnM2b0JNUm5odU8rVW5FMlNYa3lyYUFSbFIzbVpKYlk2VGRFRFc3NFpT?=
 =?utf-8?B?UTdyMVZvc0swZGh1NGRCUFRRSHVzeEx4KzErOUUyMGlUVEpvYnJFUkx0QnNu?=
 =?utf-8?B?azNRTU9JOW5UcW5hbXlabzlzOVdiQVFiZUtHU3kxY1hnY3VsYUpsTXk5Kzdp?=
 =?utf-8?B?eWJDMmQ2S0s3eWo0OHdXbjNWS25uWlRGUmFoZEg4RWZxelRiWG1BMUNhVG9v?=
 =?utf-8?B?RnRGZ0V0eUFxZjhlMjdPY0NsZE1CQXdGRXd6Rm9VVS9SVnBQS3Z4KzBrR01G?=
 =?utf-8?B?dnBvc05nWkJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTRWcWFuSDk4YkJ2WktaN0JQaENGeExTWG1VSjRRejloTnFuVHFOcUh1b3k2?=
 =?utf-8?B?d09GaXZqU3JBdnpkVk5zUW8yNE1rRVFPTkdmM2huYVdUSjVpOElNN1cwZ2ZC?=
 =?utf-8?B?dkZXSkMxUHpwTFR5dHg2UkJFWENUNDBEOG9pS1FSSXRqQVdOQm9uTDZ2ektB?=
 =?utf-8?B?bVV5NHh0aEhIUlB5b1ByUTd4anhrd0VkaU9QL2FTRkg4TVRuOGZkRit3OUNT?=
 =?utf-8?B?NWxsWkxrVHNWaWNUbG5CN2RMb0dtS0dLSmJVa0dpcENmZ2Y2WkVXaVZpL1RZ?=
 =?utf-8?B?ZTJNVHVMQjZvQjhQMWg5ZG9FY0JsRkpoVU12QUQwdUVBOU9ONk5CSUkrblcx?=
 =?utf-8?B?cExLSFdPelFzbDBtWWl1N2xUVklqU0hLRzlFRzBqU0FPNzNYaVQ4ZDlzazI1?=
 =?utf-8?B?TFN2ZTFwajJpb2liOWt2WE5qQWJ5dmliR3ZKYXBaNTFZRFVxZ3dkZUw5ZkZR?=
 =?utf-8?B?by9xNm1sSlhIL0I5QXQyMENyaXRHMFkva0lmSkFBdUo0WmZCSDFhMVFnK0dq?=
 =?utf-8?B?MW1aNVQ0ZWdQTi9obzB6U01weS9FYXRZQXZvcEJKZ2tLakNKS2pkWVBteUhP?=
 =?utf-8?B?cmtXdnI1dHFZSm5UaXFkaFN3QUFJVTNhR0ZnaUt4R2h3d3VhdkJielBHeU83?=
 =?utf-8?B?dTI1WnN3anZQMlRmR0VySm1oaWs4eHB4KzN0bHJISTNNa1ZXc2I5MC9xSnJQ?=
 =?utf-8?B?K2dXZDdxRHJIOUtVYUpVVHJtTWpEL2ViamdPaURnVHp2UG16RE16QWJ1enhJ?=
 =?utf-8?B?aDBNa2plZ1dqWmx1K0JvZzZRS1hsWndXN084R2tWU01mWmR0THp6SmkrNGhM?=
 =?utf-8?B?cW8yQklyd29KdGNNQW5jclpFUmtPdGNIUkVNbU9ZZnI3ZW9Rd2VSR2tYclYy?=
 =?utf-8?B?L0gyTzdjQ0N3WEFRTVBWOHBVcVZ6dE1sd2ZBL1VhVyt2QjlSZ244OFBEQkFQ?=
 =?utf-8?B?K3NOOWZDRVI3WGUxK0hUSnVCcmNIWEIxRWJqQ3ZIS1U5S1FpRHU1ZHZhdXA5?=
 =?utf-8?B?UEpVTUtmN1Z5LzU2UGtVaVpyeklmeHJMZSt3SENHcXRzalpqWlE4bFhiUkFN?=
 =?utf-8?B?YnNmS3BxcEROWlVoTFNDSS9UQ1hlZVZlQmN3NTkvOExqdjhaeXI4dFhqS2Rp?=
 =?utf-8?B?NXFuWTNmdHZ5TkdlaFVzL0RvcHN4OVpRQ2YrMVlka2VKSGplR2RsUk5XUTFi?=
 =?utf-8?B?UGFOSzgrLzg1K20ydmZFL2RLR0w4MXVxWVhBVldWd2s0a0k2N3N6T29RTEZl?=
 =?utf-8?B?dTJkdzM1NVpMVHl0bTc4TFl3Y2drU3RLazNSTGtEWk85T1lpK1dwdmUxU2hP?=
 =?utf-8?B?bGNNQjdldXBEaE5Rd1RPblVhUkN5TGdBYzlYM0dETXVmQXpUcUs4MlRFeHd4?=
 =?utf-8?B?MHUvbDFQWmJXMTJzVG5ydlg0R0drNzAwQkVra1oxZEJ5VGNCaDB2S3R5ai9H?=
 =?utf-8?B?U1FFY1UzSmhyc1h4Y0diYmR2UitKQW9OWDNHeXc5NmlWZzNJTG9CcHk1MzB0?=
 =?utf-8?B?S3Q0YWFxN1I1OUlUUk1DQllhWFA2SkhrRDN6ZkNSc0xKQ1V0WEozZzlvdXBB?=
 =?utf-8?B?cXpMMHJTMStuNWdFYXQySzBxbmVxWk1EVVl1UzgrTXhFWVZobjhMNUxXMVNj?=
 =?utf-8?B?TnlXYzUyTHZ0VW1lKzlUWUc4Ym1aRytZd1MzNmxBaG96TUNUYjRXQlpTN1Vh?=
 =?utf-8?B?VTJNOFhIUFVmdHBGSk9abGk0UVI3dnU1cGpuaUpvYmI3cllBbG9iNnFHanEv?=
 =?utf-8?B?eUIxNzFWSmE2Y1NVY1ZwMDNQMVZlY0lSVGhraGltbE1oWGJQME5LR2hoTVZD?=
 =?utf-8?B?OGEwUmVsTEZyQ24zR1hSbjZwYTRlVThRMzFvK2k3Nlk0bjFUVzVwRjd3YUN3?=
 =?utf-8?B?SVROdzEwUXNsdlM2SWdrL3RMdUJNMHNSckxTdEx6dHI2SjMzNDd1NXVoNEdq?=
 =?utf-8?B?aTl3S2Rkbm9LS09GaFliZnVjYm5YVWY2eHpxTGpiT2tKdlZ5WEhscXRJNmU4?=
 =?utf-8?B?TlJyb01YemxhdlFYMG9YM0syMllFMmlUUTl5dFgwampLaU95ZzRIODJidk5D?=
 =?utf-8?B?RDBtUTBUaldNSFFPNlFsZDZ0MkV1UDFyWHJXa2FoUTZxZHZad0xOV1NzZTEv?=
 =?utf-8?Q?EYn6yC8KNfFjj30cK2pVC96KK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499408b0-7276-4601-3175-08dd57e651f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:54:48.6958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+1efXn1MQ0pNIMGJzUHxgwII0l/J5xBuG/tb8Lo7ckPRsWWJLQiEsdXmVs+N3whP/9xpVefOu+fRLyOMrlq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

This patch adds SCMI pin control protocol support so that the pin
controller driver based on SCMI, such as
drivers/pinctrl/nxp/pinctrl-scmi.c, can be bound to the SCMI agent
device whose protocol id is 0x19.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 11 +++++++++++
 include/scmi_agent-uclass.h               |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b03..5f101f4ede 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_pinctrl_imx);
+			break;
 		default:
 			break;
 		}
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30..4beec43cb0 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)

-- 
2.43.0

