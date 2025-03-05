Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE31C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCBBC812BF;
	Wed,  5 Mar 2025 14:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C4M1pHWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD9E812BC; Wed,  5 Mar 2025 14:29:42 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E634807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5XuSw1HusrPTeppPpqlSWGaIHjzPpuClpCJ5IBiM3uzLm0VXylcMwBYex2tyNA8T2s+42qJ6JmxRJPGyhECH76Y71YubMxAwScS9eG0hP4jcsjo9VDZa/fIpSEJ/YSXE7VuHlep27sMmEeJlF0FMd/9xyo9WVvnsNHRAg6oEhkBE6z9tmnjmBZTD8nXGROP7uitg2JB9rxD6s/3OKLdvjGiH0PlRZUPweCIG86ZX4ZFY6J21DM5YH2U79kx5FBO6XJ4h0UPRuTD4VU5yIZlvZHZRP3CZDuCPSycN5QSrA3CYcxa2olhbodmge+c+2EalV+ktkKX7Gyd/vdRk/UhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C7O0XqCBKG19nVmCnvEKCvnJvycf046hJ01u5iPS8s=;
 b=xrKYzS0falyALiP5+cL0ZVMKlZnIDfcxDXlUkgAKmdkrGqwuCIXbXBEfYPC23dQa1SbLgEo8kZ07xld8u1OCtshTvPTEXvCck+PSh8B1qkeZk2+X+feySHWkWmpqCp6YxeXp901IbsBF+Mxn+NEy+XqoMEsBfJtWLzOjo4+S1VpTFU3fKoM+AOzA+Ccl3c//YPgw6UqyHKHUPHfPK92dtPQN+V4Qb3Y84EHexnKqiF3TAf7CZVvbEDkbMCg1VfYEXSS5slg8fxUV7OKT7VQ1ZxFlGdflBXazS+lVKcTAji1J6cGD48w5jaAUP+dQ4jflJCyuSmtw9ALTE6RzermRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C7O0XqCBKG19nVmCnvEKCvnJvycf046hJ01u5iPS8s=;
 b=C4M1pHWIycGHu66ah/BYUaw/z7+KJVyqe+0uSuWLLwEjWN6XOOR9pzh3ymYDsB28tmVbOriPaWB2lMMU1OQ74j+kLIIw4zNVhvNA4Hy6ckoE4IQoz1DNAWtYRO2TLOj+SQbfQaFza9TtY1/MwSIhlndpr6PhcoYITehrA8ABFKM138pF03SryBjr5/C9DPNyZEWKMJB0quOmFLbI1oJVMdlioGEs+w0lQp8hCNw6X317RXOhkRw8Dp//Er7NBa2aFG9nGVn9sMiFle9Xj2UPMMzL2/FQXKRh/6dd3Fe6FEfCrpHOHLeDuSkW89DK+OxxtaRnA9zW2AbkWrNd7OTwJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:29:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:36 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:22 +0800
Subject: [PATCH v7 10/19] imx9: scmi: add i.MX95 SoC and clock related code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-10-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c2eec1-5ef6-4e54-9531-08dd5be9c609
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2ZuY3BEeExabDluUVBQczlTMkRFTTA2bnRGd2VQTFp6MVhuVlp1OENJdDZX?=
 =?utf-8?B?aVc3L0dWNzJERy9jSWgwYzVZV0tVM3ZKdWxxQ2x0cysrRFA0NndlSnhqRW9o?=
 =?utf-8?B?dldKd2sydm8rM3RsZFVYdUdFWFZ6Q0NUZzhkall0a2lBWFgranRaYnpkU2gy?=
 =?utf-8?B?dndkZVBvVWdINlZXT2JEaHBCQlN4bUV3WHVVTTJXRno0ZEIwYUlpM1Nvd3Mx?=
 =?utf-8?B?M0MwZ284R0ljb1ZodThYbkxuLy9QSVYvR09sWjFGcytSWDRYUmxucjFYRkJ1?=
 =?utf-8?B?cXBWUS9UUTlINmpRMFIzRURQcFMxSy9wMlZLNlZHT1BCVFV6TGpBVFd6TUt5?=
 =?utf-8?B?eCsrZ0hBTmp0YlI4ZXFWeFB2MERpVCtobUFwY2JCd3VFR3owdFkvbWR0dlU3?=
 =?utf-8?B?THl0VVlLMDZENVBYck9hSzRNY2V3RjJEQUpkTFVhYVFVdWtjKzRiRkRMb29w?=
 =?utf-8?B?UHpjcHpmMlZBenBWNFh1QlAvcmU2allmNjVPd0tRWjlrcG4wYXVkYi9RcmFN?=
 =?utf-8?B?NzdCbHRaZkcxQm5BK2I2Qmp6OXhxYWY4ZFJiNU5YdEJhNXgyYmZsekRMMFJZ?=
 =?utf-8?B?RGtZamxURUczR016Q1FFaE5KOEtIbUFhUHVtOGc0NUw0VFlWSW1ZSTBZOGhV?=
 =?utf-8?B?bnFwVHJZM2JlTktaWTJPWTBneHJ0Ym1IQXNjWFA1YkhSRkFGcVpVdDMzd3JH?=
 =?utf-8?B?dUxYY3pXZVlNNHhDbjVQajVMaktLVVB4TzhMVFNaUWEyYm80ZVhQTk5Gem9W?=
 =?utf-8?B?L0RDdE5aZWRPYjlWVm5VNE4wQ09oc045UGwxNUs0bE9Na0pBa1dJN2JEczA2?=
 =?utf-8?B?ak94TjdBNzlkaDFxL2hpZDJweGpORDd1ejhPZGtxWUUxWFUrSUxNRDl4NnZV?=
 =?utf-8?B?NnRhVGZDU3lmOFN2bTUvN2R4bWNCQVVYdlE1SFp3bTMrVkJGZlVFb0IrR082?=
 =?utf-8?B?d2o4OUJvbm9HQTZPU1R3Q1ZxRzNKTUVSOGMyR0hpVHFQUlRha2JlL3dIYjlW?=
 =?utf-8?B?d2hOczhJazZleHF4WHVRZ2U4V2RPeXo2eW52akRiZ2ZoSVA2c3kyTnoyMUZr?=
 =?utf-8?B?U01zNWZJTTZhSGVzMEtpR1ozVXp5ZDRqVUt1ZW1jdk9sV1VCYWg3NG1RbmdX?=
 =?utf-8?B?REdDa3NGK2lzSjJpTHliaHBlV3dOUTZrUkJXeHBXRjl3UWpyeEEzS1VITDUy?=
 =?utf-8?B?Mysvd0JvL2VDRG55WHBIQmdnNE05dU00VHJJb1BHdUd5SzZBa1NudC9RM2RU?=
 =?utf-8?B?Snh6Snk1bDRJK0c2dWZmOEhXN1huWEh0SGtjbnVxaXIvWHo3WDBCWkoxL0Ra?=
 =?utf-8?B?RDhXZU5DalpnWHhQMEhmNHh4c2RqM3BLcWhacnI5MEcrQlEvQVpkRWg2Smxn?=
 =?utf-8?B?RHVpQ3pQTVVsNnROcUo1YmdPWmFIbWNuR3NlRHRmNXFrUGNqSVdFRXpnVXRv?=
 =?utf-8?B?bDVBblViRTQ2TUxmQXF3RGRidUwyVTBNN1k0Z2I1MkdXU244ekhPa2xnNnkv?=
 =?utf-8?B?QVVqMDlrNmp2Sk4xcmhLM1U0ZGFrS09mVHFHYlRRQU5vWkhsSFE5VGt6bUpy?=
 =?utf-8?B?SHp2UnFvV2ZxMy9qNDhvMFp1RkFaZGNrRUxrNUlIVk9CR2dKMWVQSmM5Ukh4?=
 =?utf-8?B?djNQQWtmek55ZFlOUXhzZitJakl5WGo2SDQ2clVUQktvelJkYS9DNzRoWGZs?=
 =?utf-8?B?Ty9SclNWMnZ5T2ppc3JqL3FJK2oyVzNJdW82ZjZLQlM1ZkgxeklKd1pTTnUz?=
 =?utf-8?B?eUlER0JWNGlwMXZlSWVaRVdVZitldVlzdmpaSmJSSkh4dm53UUo1OFVLb1FB?=
 =?utf-8?B?bFRMQlN0MjVFUWVQUldkSWlHVVZsaytZMmRENXV2bXFnK3BRMVVPc3dnYUIw?=
 =?utf-8?B?VnFGQ0JqM0t2UXE3VUVzQXlkSW9BL3NsakNXVjNNVUFZY0NQR0VNSHFCM1dm?=
 =?utf-8?B?SWZkbXI4ZEdsc3o0QlpHdXF5VDhwZlJDNGtwQUFTV3ZoTG9ZWmwwRGFSazJr?=
 =?utf-8?B?NHNXdDl4V2d3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eSs0Z1VtaFdYQitnMXBXeWFaalhxYUhTSG53OW1BbG9qek1YYkc4eTRVZXhE?=
 =?utf-8?B?MzVBRkNOcjVtbWs4aG1VUFd0TExjdWJtUVE4bzBwb0FpaGJpL1pzOTBpZmth?=
 =?utf-8?B?VVQ3Z0JNN1hJYTZjeU85VllpQ1p3ejZvM3I3SFR4cURsMm5xcE9kWjgxUVV5?=
 =?utf-8?B?VWpzR0p4dCtRNGszMTlRTncxZlBhcUJYdm4xS1l6K3pUR2c3OTNqQzYrb3lS?=
 =?utf-8?B?NjJpU0tJNjRjcUFsbTl0R2JFc0c2MDRwUmtERCt4ZkJaYjZNSGVMMjhnTDgz?=
 =?utf-8?B?emRpS2FZZzRwdG42OHBrT3htejEzcDc5dHVIQzdWcEpyWjBMS3dsbmt0NFh3?=
 =?utf-8?B?eW02K3dZSEw0ZnBFSFA3R1RXSE5YdTFsbWhqRy83VWVWajhVMkxWelgxcmQ5?=
 =?utf-8?B?MS9GZk5zMjBVaVBpbUh2TFU0M2FRN05HTEt5b2p0cTNBeVp1N3JXSHI0N0li?=
 =?utf-8?B?LzNIQ1lKMUNxK3k5NEZ1RHY3NUlHZ3hHUzM2czlkVlRja1A3dmdNcUk4Zklo?=
 =?utf-8?B?Y3ZlR1Izd1d1UGNnUmVweUFvSld6QnNDZzN6VEcvSmpnaG1QQVl6SzdyK3lR?=
 =?utf-8?B?c0o2ZmxuejRBa3dIanVMSFlUUUpVcE1obkpUQ2RrdjBLOFk5VjVBMjVmL3Jk?=
 =?utf-8?B?SDBpWHoxWndRTWRiK2U4cmRlb3Q3Z0VvUTc0Y1hRazdlRElVMHNhTjV2MHpQ?=
 =?utf-8?B?blZhZHBFV21HNGU3NyttMmFLYTBwTlhsZGNPSnRzSC9iNTZreW1UWStLYWlC?=
 =?utf-8?B?aHlPWmZjazN6SGNFQUNPTlBOa1QxRUtTVlRqWFBQNVN5MmxxSGpJSWVGd0w0?=
 =?utf-8?B?a1pFUndYT0ZBaUZYN1JFbjRzQWZRQlljTXRVK3I3Y1AxNjRaS1M3L05WUFM3?=
 =?utf-8?B?VEVyaFBMWDdIRjJhRmxTeFZhemRvMVdwNDRtSmVwVkNHOHBLbGZEOUp1NHMv?=
 =?utf-8?B?bUpzcUFib3NUZzgzMDdmVEMyU1hwcE15YzNxRkpEMDVqUjE3Q2o0akc0YnVs?=
 =?utf-8?B?SzJEekZ4aVJiNjdmbFVZYUxON1ZsNWdFYjk5bis3M1JBLzRGRy9FL0Rzb2Fx?=
 =?utf-8?B?ZEwvVkR2UVRaZkRaYk9QdExnUkNQUkREbDdJaXVOaE9YU3JDVnhQaUdjRFFm?=
 =?utf-8?B?QnFTUHJUYzVpaGNiaEl1cFY5RzZ2NlpZMm9ydFZlUTgyUTF0bVFHdWw1YlJK?=
 =?utf-8?B?VGNoZkF1WWNZSkdPaEtUUE5oZE1KSnk5eDl5V2xqclpaREFud0QyT2h0eVp3?=
 =?utf-8?B?NXNRaWZqRW1jZmorcG9mdVl6emE5UllrMXJmSFl6Vjd4RzdsM0FHekRlOTMx?=
 =?utf-8?B?YjV5bE1CSmZXdVRxR2RHRmJmdlUwWUFJYWR3ZkZTN0lPaldvSlc2VkF5eDd6?=
 =?utf-8?B?OUdiMU1LRDA3b2JhTExERmowT041YlRtMFN0NnFHeGVRY3ZjdjYyRi9mZ2JU?=
 =?utf-8?B?QlZNOVZXVUZUUkZPcjRvL0FXMDZLcFE2M3pINXBhbmwzbUhMdjJaL2NvTFlI?=
 =?utf-8?B?aGNISE5MQzhPWUtsc0tSc1hlMzhXMUpCNVNzM050cWZ3bCtaeUVyRjY2aXZB?=
 =?utf-8?B?dUpqb1AxeTdVeEJPcytQak45ZnVGa0pHMjdQeE1CVFlVaUl4ZXpGM1BvUXpB?=
 =?utf-8?B?UDVrekZ5eDNDZ250QWFrZDE2WElCMGlBZk1IL1A4SFhYOG56OStCOXhYUVlQ?=
 =?utf-8?B?Y1RLVlMvQzFiWWdHQ0I5WUNmTFlIWGhQanRPKzVBdjg3RUlQOXc0U0RuWGVt?=
 =?utf-8?B?MGJmYWNMblQxdGlMMHJUdDYxV2k2ZDY3T0lma1JFc0RjUm1OcFgvNTFoTEVu?=
 =?utf-8?B?ajVTWFJCaU5ta1k1eStNbjdLVWhxQjRaamZnSWZxMjE3ZGdRZnQvREZjVU96?=
 =?utf-8?B?YlZPVVNnUkFVbm5jU2k2a1M4ZThzMU1IMG1lVSs1Mmxnc09xQU4reGV0Y2Zo?=
 =?utf-8?B?VTg4ZUVGdUI3Tk1lNVYrdHp2TXNKNlRiaHNVeUZpem9QOWVsd29aSFd2TGho?=
 =?utf-8?B?cklzMmRNb1NpbVlUWXE2dk10N1VvdWtIcFErTFMyR1ROc1lkTldjTjkzVGpP?=
 =?utf-8?B?cXdjc28zSFo3b2pWNEZqcDB5dnNWWDBvOUJybkorL2grTllUb0ZNbDlnbkF6?=
 =?utf-8?Q?hUmqurnihZGSZy2HMkklYJ+nl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c2eec1-5ef6-4e54-9531-08dd5be9c609
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:36.6457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRJirAybcSqVhkj69K3B8SM228ZTrOkuoGwiGuT6/8USbdarHdLNV1FnEbjR6KhqRqqSJ/+aMgPgp+++ptWKGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037
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

From: Peng Fan <peng.fan@nxp.com>

This patch adds i.MX95 SoC and clock related code. Because they are
based on SCMI, put them in the scmi subfolder.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h        |   2 +
 arch/arm/include/asm/arch-imx9/clock.h     |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |   5 +
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h  |  39 ++
 arch/arm/mach-imx/imx9/scmi/Makefile       |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c        | 105 ++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c   | 133 +++++
 arch/arm/mach-imx/imx9/scmi/soc.c          | 788 +++++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h       |   2 +-
 10 files changed, 1090 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 0d7a573461..1f669c72d0 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -76,6 +76,8 @@
 #define MXC_CPU_IMX9111		0xCD /* dummy ID */
 #define MXC_CPU_IMX9101		0xCE /* dummy ID */
 
+#define MXC_CPU_IMX95		0x1C1 /* dummy ID */
+
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
 #define MXC_SOC_IMX8M		0x80
diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 60d48b13b1..ffaf6b5f7d 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -255,5 +255,15 @@ int ccm_shared_gpr_tz_access(u32 gpr, bool non_secure, bool user_mode, bool lock
 void enable_usboh3_clk(unsigned char enable);
 int set_clk_enet(enum enet_freq type);
 int set_clk_eqos(enum enet_freq type);
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable);
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate);
+ulong imx_clk_scmi_get_rate(u32 clock_id);
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id);
 void set_arm_clk(ulong freq);
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable);
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate);
+ulong imx_clk_scmi_get_rate(u32 clock_id);
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id);
 #endif
diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index ef9538bd42..f7f9c706e1 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -20,6 +20,11 @@
 #define WDG4_BASE_ADDR      0x424a0000UL
 #define WDG5_BASE_ADDR      0x424b0000UL
 
+#define GPIO2_BASE_ADDR	    0x43810000UL
+#define GPIO3_BASE_ADDR	    0x43820000UL
+#define GPIO4_BASE_ADDR	    0x43840000UL
+#define GPIO5_BASE_ADDR	    0x43850000UL
+
 #define FSB_BASE_ADDR       0x47510000UL
 
 #define ANATOP_BASE_ADDR    0x44480000UL
diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index e4bf6a6342..df2148a53c 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -12,6 +12,7 @@ enum imx9_soc_voltage_mode {
 	VOLT_LOW_DRIVE = 0,
 	VOLT_NOMINAL_DRIVE,
 	VOLT_OVER_DRIVE,
+	VOLT_SUPER_OVER_DRIVE,
 };
 
 void soc_power_init(void);
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 109a806852..0780f99b49 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -97,6 +97,8 @@ struct bd_info;
 #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
 #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
+#define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
+
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
 #define is_imx9111() (is_cpu_type(MXC_CPU_IMX9111))
 #define is_imx9101() (is_cpu_type(MXC_CPU_IMX9101))
@@ -216,6 +218,43 @@ ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev);
 u32 rom_api_download_image(u8 *dest, u32 offset, u32 size);
 u32 rom_api_query_boot_infor(u32 info_type, u32 *info);
 
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+typedef struct rom_passover {
+	u16 tag;                   // Tag
+	u8  len;                   // Fixed value of 0x80
+	u8  ver;                   // Version
+	u32 boot_mode;             // Boot mode
+	u32 card_addr_mode;        // SD card address mode
+	u32 bad_blks_of_img_set0;  // NAND bad block count skipped 1
+	u32 ap_mu_id;              // AP MU ID
+	u32 bad_blks_of_img_set1;  // NAND bad block count skipped 1
+	u8  boot_stage;            // Boot stage
+	u8  img_set_sel;           // Image set booted from
+	u8  rsv0[2];               // Reserved
+	u32 img_set_end;           // Offset of Image End
+	u32 rom_version;           // ROM version
+	u8  boot_dev_state;        // Boot device state
+	u8  boot_dev_inst;         // Boot device type
+	u8  boot_dev_type;         // Boot device instance
+	u8  rsv1;                  // Reserved
+	u32 dev_page_size;         // Boot device page size
+	u32 cnt_header_ofs;        // Container header offset
+	u32 img_ofs;               // Image offset
+}  __packed rom_passover_t;
+
+/**
+ * struct scmi_rom_passover_out - Response payload for ROM_PASSOVER_GET command
+ * @status:	SCMI clock ID
+ * @attributes:	Attributes of the targets clock state
+ */
+struct scmi_rom_passover_get_out {
+	u32 status;
+	u32 numPassover;
+	u32 passover[(sizeof(rom_passover_t) + 8) / 4];
+};
+
+#endif
+
 /* For i.MX ULP */
 #define BT0CFG_LPBOOT_MASK	0x1
 #define BT0CFG_DUALBOOT_MASK	0x2
diff --git a/arch/arm/mach-imx/imx9/scmi/Makefile b/arch/arm/mach-imx/imx9/scmi/Makefile
new file mode 100644
index 0000000000..4534db08d2
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+obj-y += soc.o
+obj-y += clock_scmi.o clock.o
diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
new file mode 100644
index 0000000000..9ebd380976
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/clock.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <dm/uclass.h>
+#include <scmi_agent.h>
+#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+
+u32 get_arm_core_clk(void)
+{
+	u32 val;
+
+	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
+	if (val)
+		return val;
+	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
+}
+
+void set_arm_core_max_clk(void)
+{
+	int ret;
+	u32 arm_domain_id = 8;
+
+	struct scmi_perf_in in = {
+		.domain_id = arm_domain_id,
+		.perf_level = 3,
+	};
+	struct scmi_perf_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PERF, SCMI_PERF_LEVEL_SET, in, out);
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		printf("%s: %d\n", __func__, ret);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		printf("%s: %d\n", __func__, ret);
+}
+
+int clock_init_early(void)
+{
+	return 0;
+}
+
+/* Set bus and A55 core clock per voltage mode */
+int clock_init_late(void)
+{
+	set_arm_core_max_clk();
+
+	return 0;
+}
+
+void init_uart_clk(u32 index)
+{
+	u32 clock_id;
+
+	switch (index) {
+	case 0:
+		clock_id = IMX95_CLK_LPUART1;
+		break;
+	case 1:
+		clock_id = IMX95_CLK_LPUART2;
+		break;
+	case 2:
+		clock_id = IMX95_CLK_LPUART3;
+		break;
+	default:
+		return;
+	}
+
+	/* 24MHz */
+	imx_clk_scmi_enable(clock_id, false);
+	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
+	imx_clk_scmi_set_rate(clock_id, 24000000);
+	imx_clk_scmi_enable(clock_id, true);
+}
+
+unsigned int mxc_get_clock(enum mxc_clock clk)
+{
+	switch (clk) {
+	case MXC_ARM_CLK:
+		return get_arm_core_clk();
+	case MXC_IPG_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
+	case MXC_CSPI_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
+	case MXC_ESDHC_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
+	case MXC_ESDHC2_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
+	case MXC_ESDHC3_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
+	case MXC_UART_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
+	case MXC_FLEXSPI_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
+	default:
+		return -1;
+	};
+
+	return -1;
+};
diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
new file mode 100644
index 0000000000..fa15b5f8df
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <dm/uclass.h>
+#include <scmi_agent.h>
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable)
+{
+	struct scmi_clk_state_in in = {
+		.clock_id = clock_id,
+		.attributes = (enable) ? 1 : 0,
+	};
+	struct scmi_clk_state_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_CONFIG_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate)
+{
+	struct scmi_clk_rate_set_in in = {
+		.clock_id = clock_id,
+		.flags = SCMI_CLK_RATE_ROUND_CLOSEST,
+		.rate_lsb = (u32)rate,
+		.rate_msb = (u32)((u64)rate >> 32),
+	};
+	struct scmi_clk_rate_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_RATE_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0)
+		return ret;
+
+	struct scmi_clk_rate_get_in in_rate = {
+		.clock_id = clock_id,
+	};
+	struct scmi_clk_rate_get_out out_rate;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK, SCMI_CLOCK_RATE_GET, in_rate, out_rate);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out_rate.status);
+	if (ret < 0)
+		return ret;
+
+	return (ulong)(((u64)out_rate.rate_msb << 32) | out_rate.rate_lsb);
+}
+
+ulong imx_clk_scmi_get_rate(u32 clock_id)
+{
+	struct scmi_clk_rate_get_in in = {
+		.clock_id = clock_id,
+	};
+	struct scmi_clk_rate_get_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_RATE_GET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0)
+		return ret;
+
+	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
+}
+
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clock_id,
+		.parent_clk = parent_id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0 && ret != -EACCES)
+		printf("%s: %d, clock_id %u\n", __func__, ret, clock_id);
+
+	return ret;
+}
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
new file mode 100644
index 0000000000..217e7ed41a
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -0,0 +1,788 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/armv8/mmu.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/setup.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <env_internal.h>
+#include <fuse.h>
+#include <imx_thermal.h>
+#include <scmi_agent.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static rom_passover_t rom_passover_data = {0};
+
+uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
+{
+	/* Read ROM passover data */
+	struct scmi_rom_passover_get_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_MISC_ROM_PASSOVER_GET,
+		.in_msg = (u8 *)NULL,
+		.in_msg_sz = 0,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret == 0 && out.status == 0) {
+		memcpy(rom_data, (struct rom_passover_t *)out.passover, sizeof(rom_passover_t));
+	} else {
+		printf("Failed to get ROM passover data, scmi_err = %d, size_of(out) = %ld\n",
+		       out.status, sizeof(out));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
+__weak int board_mmc_get_env_dev(int devno)
+{
+	return devno;
+}
+
+int mmc_get_env_dev(void)
+{
+	int ret;
+	u16 boot_type;
+	u8 boot_instance;
+
+	volatile gd_t *pgd = gd;
+	rom_passover_t *rdata;
+
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+	rdata = &rom_passover_data;
+#else
+	rom_passover_t rom_data = {0};
+
+	if (!pgd->reloc_off)
+		rdata = &rom_data;
+	else
+		rdata = &rom_passover_data;
+#endif
+	if (rdata->tag == 0) {
+		ret = scmi_get_rom_data(rdata);
+		if (ret != 0) {
+			puts("SCMI: failure at rom_boot_info\n");
+			return CONFIG_SYS_MMC_ENV_DEV;
+		}
+	}
+	boot_type = rdata->boot_dev_type;
+	boot_instance = rdata->boot_dev_inst;
+	set_gd(pgd);
+
+	debug("boot_type %d, instance %d\n", boot_type, boot_instance);
+
+	/* If not boot from sd/mmc, use default value */
+	if (boot_type != BOOT_TYPE_SD && boot_type != BOOT_TYPE_MMC)
+		return env_get_ulong("mmcdev", 10, CONFIG_SYS_MMC_ENV_DEV);
+
+	return board_mmc_get_env_dev(boot_instance);
+}
+#endif
+
+u32 get_cpu_speed_grade_hz(void)
+{
+	u32 speed, max_speed;
+	int ret;
+	u32 val, word, offset;
+
+	word = 17;
+	offset = 14;
+
+	ret = fuse_read(word / 8, word % 8, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	val >>= offset;
+	val &= 0xf;
+
+	max_speed = 2300000000;
+	speed = max_speed - val * 100000000;
+
+	if (is_imx95())
+		max_speed = 2000000000;
+
+	/* In case the fuse of speed grade not programmed */
+	if (speed > max_speed)
+		speed = max_speed;
+
+	return speed;
+}
+
+u32 get_cpu_temp_grade(int *minc, int *maxc)
+{
+	int ret;
+	u32 val, word, offset;
+
+	word = 17;
+	offset = 12;
+
+	ret = fuse_read(word / 8, word % 8, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	val >>= offset;
+	val &= 0x3;
+
+	if (minc && maxc) {
+		if (val == TEMP_AUTOMOTIVE) {
+			*minc = -40;
+			*maxc = 125;
+		} else if (val == TEMP_INDUSTRIAL) {
+			*minc = -40;
+			*maxc = 105;
+		} else if (val == TEMP_EXTCOMMERCIAL) {
+			*minc = -20;
+			*maxc = 105;
+		} else {
+			*minc = 0;
+			*maxc = 95;
+		}
+	}
+	return val;
+}
+
+static void set_cpu_info(struct ele_get_info_data *info)
+{
+	gd->arch.soc_rev = info->soc;
+	gd->arch.lifecycle = info->lc;
+	memcpy((void *)&gd->arch.uid, &info->uid, 4 * sizeof(u32));
+}
+
+u32 get_cpu_rev(void)
+{
+	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
+
+	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
+}
+
+#define UNLOCK_WORD 0xD928C520 /* unlock word */
+#define REFRESH_WORD 0xB480A602 /* refresh word */
+
+static void disable_wdog(void __iomem *wdog_base)
+{
+	u32 val_cs = readl(wdog_base + 0x00);
+
+	if (!(val_cs & 0x80))
+		return;
+
+	/* default is 32bits cmd */
+	writel(REFRESH_WORD, (wdog_base + 0x04)); /* Refresh the CNT */
+
+	if (!(val_cs & 0x800)) {
+		writel(UNLOCK_WORD, (wdog_base + 0x04));
+		while (!(readl(wdog_base + 0x00) & 0x800))
+			;
+	}
+	writel(0x0, (wdog_base + 0x0C)); /* Set WIN to 0 */
+	writel(0x400, (wdog_base + 0x08)); /* Set timeout to default 0x400 */
+	writel(0x2120, (wdog_base + 0x00)); /* Disable it and set update */
+
+	while (!(readl(wdog_base + 0x00) & 0x400))
+		;
+}
+
+static struct mm_region imx9_mem_map[] = {
+	{
+		/* ROM */
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = 0x100000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		/* TCM */
+		.virt = 0x201c0000UL,
+		.phys = 0x201c0000UL,
+		.size = 0x80000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* OCRAM */
+		.virt = 0x20480000UL,
+		.phys = 0x20480000UL,
+		.size = 0xA0000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		/* AIPS */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* Flexible Serial Peripheral Interface */
+		.virt = 0x28000000UL,
+		.phys = 0x28000000UL,
+		.size = 0x8000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* DRAM1 */
+		.virt = PHYS_SDRAM,
+		.phys = PHYS_SDRAM,
+		.size = PHYS_SDRAM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				 PTE_BLOCK_OUTER_SHARE
+	}, {
+#ifdef PHYS_SDRAM_2_SIZE
+		/* DRAM2 */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = PHYS_SDRAM_2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+#endif
+		/* empty entry to split table entry 5 if needed when TEEs are used */
+		0,
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = imx9_mem_map;
+
+static unsigned int imx9_find_dram_entry_in_mem_map(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx9_mem_map); i++)
+		if (imx9_mem_map[i].phys == CFG_SYS_SDRAM_BASE)
+			return i;
+
+	hang();	/* Entry not found, this must never happen. */
+}
+
+void enable_caches(void)
+{
+	/* If OPTEE runs, remove OPTEE memory from MMU table to avoid speculative prefetch
+	 * If OPTEE does not run, still update the MMU table according to dram banks structure
+	 * to set correct dram size from board_phys_sdram_size
+	 */
+	int i = 0;
+	/*
+	 * please make sure that entry initial value matches
+	 * imx9_mem_map for DRAM1
+	 */
+	int entry = imx9_find_dram_entry_in_mem_map();
+	u64 attrs = imx9_mem_map[entry].attrs;
+
+	while (i < CONFIG_NR_DRAM_BANKS &&
+	       entry < ARRAY_SIZE(imx9_mem_map)) {
+		if (gd->bd->bi_dram[i].start == 0)
+			break;
+		imx9_mem_map[entry].phys = gd->bd->bi_dram[i].start;
+		imx9_mem_map[entry].virt = gd->bd->bi_dram[i].start;
+		imx9_mem_map[entry].size = gd->bd->bi_dram[i].size;
+		imx9_mem_map[entry].attrs = attrs;
+		debug("Added memory mapping (%d): %llx %llx\n", entry,
+		      imx9_mem_map[entry].phys, imx9_mem_map[entry].size);
+		i++; entry++;
+	}
+
+	icache_enable();
+	dcache_enable();
+}
+
+__weak int board_phys_sdram_size(phys_size_t *size)
+{
+	phys_size_t start, end;
+	phys_size_t val;
+
+	if (!size)
+		return -EINVAL;
+
+	val = readl(REG_DDR_CS0_BNDS);
+	start = (val >> 16) << 24;
+	end   = (val & 0xFFFF);
+	end   = end ? end + 1 : 0;
+	end   = end << 24;
+	*size = end - start;
+
+	val = readl(REG_DDR_CS1_BNDS);
+	start = (val >> 16) << 24;
+	end   = (val & 0xFFFF);
+	end   = end ? end + 1 : 0;
+	end   = end << 24;
+	*size += end - start;
+
+	return 0;
+}
+
+int dram_init(void)
+{
+	phys_size_t sdram_size;
+	int ret;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return ret;
+
+	/* rom_pointer[1] contains the size of TEE occupies */
+	if (rom_pointer[1])
+		gd->ram_size = sdram_size - rom_pointer[1];
+	else
+		gd->ram_size = sdram_size;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	int bank = 0;
+	int ret;
+	phys_size_t sdram_size;
+	phys_size_t sdram_b1_size, sdram_b2_size;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return ret;
+
+	/* Bank 1 can't cross over 4GB space */
+	if (sdram_size > 0x80000000) {
+		sdram_b1_size = 0x100000000UL - PHYS_SDRAM;
+		sdram_b2_size = sdram_size - sdram_b1_size;
+	} else {
+		sdram_b1_size = sdram_size;
+		sdram_b2_size = 0;
+	}
+
+	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
+	if (rom_pointer[1]) {
+		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
+		phys_size_t optee_size = (size_t)rom_pointer[1];
+
+		gd->bd->bi_dram[bank].size = optee_start - gd->bd->bi_dram[bank].start;
+		if ((optee_start + optee_size) < (PHYS_SDRAM + sdram_b1_size)) {
+			if (++bank >= CONFIG_NR_DRAM_BANKS) {
+				puts("CONFIG_NR_DRAM_BANKS is not enough\n");
+				return -1;
+			}
+
+			gd->bd->bi_dram[bank].start = optee_start + optee_size;
+			gd->bd->bi_dram[bank].size = PHYS_SDRAM +
+				sdram_b1_size - gd->bd->bi_dram[bank].start;
+		}
+	} else {
+		gd->bd->bi_dram[bank].size = sdram_b1_size;
+	}
+
+	if (sdram_b2_size) {
+		if (++bank >= CONFIG_NR_DRAM_BANKS) {
+			puts("CONFIG_NR_DRAM_BANKS is not enough for SDRAM_2\n");
+			return -1;
+		}
+		gd->bd->bi_dram[bank].start = 0x100000000UL;
+		gd->bd->bi_dram[bank].size = sdram_b2_size;
+	}
+
+	return 0;
+}
+
+phys_size_t get_effective_memsize(void)
+{
+	int ret;
+	phys_size_t sdram_size;
+	phys_size_t sdram_b1_size;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (!ret) {
+		/* Bank 1 can't cross over 4GB space */
+		if (sdram_size > 0x80000000)
+			sdram_b1_size = 0x100000000UL - PHYS_SDRAM;
+		else
+			sdram_b1_size = sdram_size;
+
+		if (rom_pointer[1]) {
+			/* We will relocate u-boot to Top of dram1. Tee position has two cases:
+			 * 1. At the top of dram1,  Then return the size removed optee size.
+			 * 2. In the middle of dram1, return the size of dram1.
+			 */
+			if ((rom_pointer[0] + rom_pointer[1]) == (PHYS_SDRAM + sdram_b1_size))
+				return ((phys_addr_t)rom_pointer[0] - PHYS_SDRAM);
+		}
+
+		return sdram_b1_size;
+	} else {
+		return PHYS_SDRAM_SIZE;
+	}
+}
+
+void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
+{
+	u32 val[2] = {};
+	int ret;
+
+	if (dev_id == 0) {
+		ret = fuse_read(39, 3, &val[0]);
+		if (ret)
+			goto err;
+
+		ret = fuse_read(39, 4, &val[1]);
+		if (ret)
+			goto err;
+
+		mac[0] = val[1] >> 8;
+		mac[1] = val[1];
+		mac[2] = val[0] >> 24;
+		mac[3] = val[0] >> 16;
+		mac[4] = val[0] >> 8;
+		mac[5] = val[0];
+
+	} else {
+		ret = fuse_read(39, 5, &val[0]);
+		if (ret)
+			goto err;
+
+		ret = fuse_read(39, 4, &val[1]);
+		if (ret)
+			goto err;
+
+		if (is_soc_rev(CHIP_REV_1_0)) {
+			mac[0] = val[1] >> 24;
+			mac[1] = val[1] >> 16;
+			mac[2] = val[0] >> 24;
+			mac[3] = val[0] >> 16;
+			mac[4] = val[0] >> 8;
+			mac[5] = val[0];
+		} else {
+			mac[0] = val[0] >> 24;
+			mac[1] = val[0] >> 16;
+			mac[2] = val[0] >> 8;
+			mac[3] = val[0];
+			mac[4] = val[1] >> 24;
+			mac[5] = val[1] >> 16;
+		}
+	}
+
+	debug("%s: MAC%d: %02x.%02x.%02x.%02x.%02x.%02x\n",
+	      __func__, dev_id, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+	return;
+err:
+	memset(mac, 0, 6);
+	printf("%s: fuse read err: %d\n", __func__, ret);
+}
+
+const char *get_imx_type(u32 imxtype)
+{
+	switch (imxtype) {
+	case MXC_CPU_IMX95:
+		return "95";/* iMX95 FULL */
+	default:
+		return "??";
+	}
+}
+
+int print_cpuinfo(void)
+{
+	u32 cpurev, max_freq;
+	int minc, maxc;
+
+	cpurev = get_cpu_rev();
+
+	printf("CPU:   i.MX%s rev%d.%d",
+	       get_imx_type((cpurev & 0x1FF000) >> 12),
+	       (cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0);
+
+	max_freq = get_cpu_speed_grade_hz();
+	if (!max_freq || max_freq == mxc_get_clock(MXC_ARM_CLK)) {
+		printf(" at %dMHz\n", mxc_get_clock(MXC_ARM_CLK) / 1000000);
+	} else {
+		printf(" %d MHz (running at %d MHz)\n", max_freq / 1000000,
+		       mxc_get_clock(MXC_ARM_CLK) / 1000000);
+	}
+
+	puts("CPU:   ");
+	switch (get_cpu_temp_grade(&minc, &maxc)) {
+	case TEMP_AUTOMOTIVE:
+		puts("Automotive temperature grade ");
+		break;
+	case TEMP_INDUSTRIAL:
+		puts("Industrial temperature grade ");
+		break;
+	case TEMP_EXTCOMMERCIAL:
+		if (is_imx93())
+			puts("Extended Industrial temperature grade ");
+		else
+			puts("Extended Consumer temperature grade ");
+		break;
+	default:
+		puts("Consumer temperature grade ");
+		break;
+	}
+	printf("(%dC to %dC)", minc, maxc);
+
+	puts("\n");
+
+	return 0;
+}
+
+void build_info(void)
+{
+	u32 fw_version, sha1, res, status;
+	int ret;
+
+	printf("\nBuildInfo:\n");
+
+	ret = ele_get_fw_status(&status, &res);
+	if (ret) {
+		printf("  - ELE firmware status failed %d, 0x%x\n", ret, res);
+	} else if ((status & 0xff) == 1) {
+		ret = ele_get_fw_version(&fw_version, &sha1, &res);
+		if (ret) {
+			printf("  - ELE firmware version failed %d, 0x%x\n", ret, res);
+		} else {
+			printf("  - ELE firmware version %u.%u.%u-%x",
+			       (fw_version & (0x00ff0000)) >> 16,
+			       (fw_version & (0x0000ff00)) >> 8,
+			       (fw_version & (0x000000ff)), sha1);
+			((fw_version & (0x80000000)) >> 31) == 1 ? puts("-dirty\n") : puts("\n");
+		}
+	} else {
+		printf("  - ELE firmware not included\n");
+	}
+	puts("\n");
+}
+
+int arch_misc_init(void)
+{
+	build_info();
+	return 0;
+}
+
+#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_SPL_BUILD)
+int board_fix_fdt(void *fdt)
+{
+	return 0;
+}
+#endif
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)
+void get_board_serial(struct tag_serialnr *serialnr)
+{
+	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
+	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
+
+	serialnr->low = gd->arch.uid[0];
+	serialnr->high = gd->arch.uid[3];
+}
+#endif
+
+static void gpio_reset(ulong gpio_base)
+{
+	writel(0, gpio_base + 0x10);
+	writel(0, gpio_base + 0x14);
+	writel(0, gpio_base + 0x18);
+	writel(0, gpio_base + 0x1c);
+}
+
+int arch_cpu_init(void)
+{
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
+		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+
+		clock_init_early();
+
+		gpio_reset(GPIO2_BASE_ADDR);
+		gpio_reset(GPIO3_BASE_ADDR);
+		gpio_reset(GPIO4_BASE_ADDR);
+		gpio_reset(GPIO5_BASE_ADDR);
+	}
+
+	return 0;
+}
+
+int imx9_probe_mu(void)
+{
+	struct udevice *dev;
+	int node, ret;
+	u32 res;
+	struct ele_get_info_data info;
+
+	ret = uclass_get_device_by_driver(UCLASS_SCMI_AGENT, DM_DRIVER_GET(scmi_mbox), &dev);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19", &dev);
+	if (ret)
+		return ret;
+
+	node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "fsl,imx93-mu-s4");
+
+	ret = uclass_get_device_by_of_offset(UCLASS_MISC, node, &dev);
+	if (ret)
+		return ret;
+
+	if (gd->flags & GD_FLG_RELOC)
+		return 0;
+
+	ret = ele_get_info(&info, &res);
+	if (ret)
+		return ret;
+
+	set_cpu_info(&info);
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx9_probe_mu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, imx9_probe_mu);
+
+int timer_init(void)
+{
+	gd->arch.tbl = 0;
+	gd->arch.tbu = 0;
+
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		unsigned long freq = 24000000;
+
+		asm volatile("msr cntfrq_el0, %0" : : "r" (freq) : "memory");
+	}
+
+	return 0;
+}
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	enum boot_device dev = get_boot_device();
+	enum env_location env_loc = ENVL_UNKNOWN;
+
+	if (prio)
+		return env_loc;
+
+	switch (dev) {
+	case QSPI_BOOT:
+		env_loc = ENVL_SPI_FLASH;
+		break;
+	case SD1_BOOT:
+	case SD2_BOOT:
+	case SD3_BOOT:
+	case MMC1_BOOT:
+	case MMC2_BOOT:
+	case MMC3_BOOT:
+		env_loc =  ENVL_MMC;
+		break;
+	default:
+		env_loc = ENVL_NOWHERE;
+		break;
+	}
+
+	return env_loc;
+}
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
+{
+	u32 speed = get_cpu_speed_grade_hz();
+	enum imx9_soc_voltage_mode voltage = VOLT_OVER_DRIVE;
+
+	if (is_imx95()) {
+		if (speed == 2000000000)
+			voltage = VOLT_SUPER_OVER_DRIVE;
+		else if (speed == 1800000000)
+			voltage = VOLT_OVER_DRIVE;
+		else if (speed == 1400000000)
+			voltage = VOLT_NOMINAL_DRIVE;
+		else /* boot not support low drive mode according to AS */
+			printf("Unexpected A55 freq %u, default to OD\n", speed);
+	}
+
+	return voltage;
+}
+
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+enum boot_device get_boot_device(void)
+{
+	volatile gd_t *pgd = gd;
+	int ret;
+	u16 boot_type;
+	u8 boot_instance;
+	enum boot_device boot_dev = 0;
+	rom_passover_t *rdata;
+
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+	rdata = &rom_passover_data;
+#else
+	rom_passover_t rom_data = {0};
+
+	if (pgd->reloc_off == 0)
+		rdata = &rom_data;
+	else
+		rdata = &rom_passover_data;
+#endif
+	if (rdata->tag == 0) {
+		ret = scmi_get_rom_data(rdata);
+		if (ret != 0) {
+			puts("SCMI: failure at rom_boot_info\n");
+			return -1;
+		}
+	}
+	boot_type = rdata->boot_dev_type;
+	boot_instance = rdata->boot_dev_inst;
+
+	set_gd(pgd);
+
+	switch (boot_type) {
+	case BT_DEV_TYPE_SD:
+		boot_dev = boot_instance + SD1_BOOT;
+		break;
+	case BT_DEV_TYPE_MMC:
+		boot_dev = boot_instance + MMC1_BOOT;
+		break;
+	case BT_DEV_TYPE_NAND:
+		boot_dev = NAND_BOOT;
+		break;
+	case BT_DEV_TYPE_FLEXSPINOR:
+		boot_dev = QSPI_BOOT;
+		break;
+	case BT_DEV_TYPE_USB:
+		boot_dev = boot_instance + USB_BOOT;
+		if (IS_ENABLED(CONFIG_IMX95))
+			boot_dev -= 3; //iMX95 usb instance start at 3
+		break;
+	default:
+		break;
+	}
+
+	return boot_dev;
+}
+#endif
diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index b30e536a35..c9717118bc 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -110,7 +110,7 @@ struct sandbox_scmi_devices {
 	size_t regul_count;
 };
 
-#ifdef CONFIG_SCMI_FIRMWARE
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
 /**
  * sandbox_scmi_channel_id - Get the channel id
  * @dev:	Reference to the SCMI protocol device

-- 
2.43.0

