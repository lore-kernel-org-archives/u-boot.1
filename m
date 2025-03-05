Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7213DC282EC
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD308122F;
	Wed,  5 Mar 2025 14:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QMMzZA6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1837807B1; Wed,  5 Mar 2025 14:29:15 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF6C812D9
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuRscPkqruno1bYs+R7QSLQBRfL/G4q11htCs3AaRMX40IJx2um7zabln7TSoHuJMHPHJmPyPb5p1C3G/SQ/99mnpnvR/mTDIi08u1VAQnDL8ZFa/DPweZgVjT1A4nsF6jR39vEN9bSz9RuwLtIkPmbwGhxUDjXBydvlpgSFmeQWhIROSDkAagGzbtjmq6jdYgGNBXk4gLvNJX5+JpWDK25C3KBqjRtuLYDprUTlvTF8WRbGdzr9ZplswrqqF9t2JZ28e2bccqle3kCMC/clv6VrrG0mUsmmS70SngKCXZPDuMyAoywVX+MMQGG3zs58ItE3cWf40cZQZsS4DxB2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euoCfgEyNIjKygIFQEdk40hnSxJ9anyhoNm+L0j4GVY=;
 b=KiNI3maV2U9cp3B/Xj1G2piAkNMQD979//2wJmvNcTgIDfO0/K4hD6qcTcjS+enbM1lPHVnad/k9HG+Zge2sNI1aay7hod6PWwZdd5gD148axEDlpPOYd+syAk9Lg/oteF1mVU/OO7Ihh7IPYbO6emU5XAlI5p9EcPaH+NekLobAqjCapaXtM/tDSGmdYmm11mMYprxMwx7pZ56S27dww1ZOiv6vbJ0FJR1rzSzMyzDurGTAdIOXraj4JM56A2WNvYMIQkKtPRKwtpGD+icjQ+Iwz6UG6/2cEjegvMLh4ZCLVY3uzKQRTd8od8Z3fE6/oVY6/UBwrK3jUVWUaF7eoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoCfgEyNIjKygIFQEdk40hnSxJ9anyhoNm+L0j4GVY=;
 b=QMMzZA6i3A2we3+HxvNtholDshG0Fv3cyA+ckJMqtxV7UziqLYpWITwJW4PnKXBOkNCSaIqnbAwBS0U37qXOG0Wl4mIcXQeiglDqb/3e3OkhS2xh1yrFerdGQuXVbYaJlIcYVNDoH/o/Co+XA0BQwkdpqIOEDIVuVHM8Mdao+UJU24wjoMhtkVYNIYO2OhuXB5OuOIY1vE0ArSXkSKlPNTr9XiUPrfNIFvl9ifUC0I++opTWHMGD+KDotAy0u2MtnbyRxyIKeSINfGf33cQxpucjPs9RoSgYC94tOPdoRjf9z8C0GcAtuRwYkZq8pQFEyDwGt6SCsIEu6xdpAEG/uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:29:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:10 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:17 +0800
Subject: [PATCH v7 05/19] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-5-286d15acbb8a@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: bc349163-efb8-4b38-0f40-08dd5be9b6ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2RnMTN4RCtmcjVtWUpjWUIyZ29icWNYdXlYZnUrcU51RVY0dEtkbEVVVXRj?=
 =?utf-8?B?K1hSeUdySFJNWE4zZ1pJS2kyTFIwTW1NcWs3Y0JTcmtvUXVFTGgzZ1ZRSHJK?=
 =?utf-8?B?d3FHZVJCaFd2d2tXaXkvZkthUTBuNnNjeVhmV2tLOVZNNmx6dnpqWEdFdjRF?=
 =?utf-8?B?SzRubzE4R2FRL2FVMGhhNnZzU0xhaENDWVc4cGdGZFFKbUJ4MENQNEloMUZx?=
 =?utf-8?B?R2kySlgvUFE0anhKenFmYzFxd3BpMkkxZkljNnZZZCsrL3hMQVZOeDZPOWpO?=
 =?utf-8?B?R1hWcW8xMkJoQ1FsUWt3V3poZmt3MzZTc00wallJWFAvNTMxa3pyQlhqeGwy?=
 =?utf-8?B?a2tDUE1YZ2UzSnNGMTRieExrdnBBOWRUSEFPd1FJMUJFYnFZM0FSSzlZWi9O?=
 =?utf-8?B?UUlGV1BuRStsdmFUcE43aE8wYlY1bjBveWxOd3lKcEUrUzZON2VkdG1wTDgv?=
 =?utf-8?B?UWdTZEc0ZkViWGdvRnZnZ0tqWnRlTlRqMnprVlM5cU9uYXJmNDFjRDVvMEhp?=
 =?utf-8?B?VEZaVWRIbWZTaXA0UjNJWGVhU0U0UlV1dE9meFdlQXo0U3NUUVM2NzQzcXNw?=
 =?utf-8?B?dlFLbXZDaGtUSG1LbkpJVGxhUDJkYjhrc09MK1VNazN6bXM1K1pvb05IbnM0?=
 =?utf-8?B?TWY1M2J4Ym0vNXdqdXM2RlFKcXFRWXFicHZBV3BFUnZ6ckFTR0Z5b2lBeTFq?=
 =?utf-8?B?N0p0Vzc5QWNnemlyT0dvTlNaY3l1VTRzWHpQMWdTb2NwdnppTG84QXhjSWty?=
 =?utf-8?B?a0pxYUNNOEFsWnAzeWRIY2pTcDRaK3k4ZjFCcExQL1ZQRDFCQjk3QlQySjRS?=
 =?utf-8?B?VzdWZzhCdG82Smt5V0ZnYkI0amlYdmVnYUIwQ0xaRlUxbVpmTGxKa1NuQ2U5?=
 =?utf-8?B?NXVjZTRmVnNlK0RrUlFmT1I5NXBzS2RKNFBJRkpRVmZ0cjVqS1ltNW8vTEhX?=
 =?utf-8?B?THBpS2xHU2Y1alA5WTluVzIxS25hZHpOandxeHF2aWF4V2lqN3ZkU2lEaWM1?=
 =?utf-8?B?ZllpS0M1NnZseHJ6NkR2TDRUbVFoTUxWMnIyb21IOUlnR2EwYzZ6S01XVnhO?=
 =?utf-8?B?OGJFRGo1djdkYlJWTEt6S2daNVE0ZDlNTUxCMlVoellVVlU0b1hZclcwMzRm?=
 =?utf-8?B?b0RBc1VqQ2VrdjA5Z2ZwK0VhTnhyMXB5MGwxK3AxcmhwMzJmaEZRR1JIL1BY?=
 =?utf-8?B?NlBJaWR2TE5KdHU4TEZMZ1c0dXNSalE1MDF4azh6RWd3NENFaTVrQjZIMERW?=
 =?utf-8?B?UVdaNXJTdVlDQURQdFhYaUprMjF5bjN6NktMcTA5cG5ieUxtRW9EUVZQd3k0?=
 =?utf-8?B?clEwc0FHSGE5TkRobS9ubVg2S0ljV3BiTHpDY1RnR2E0NUdMUzFaa3ZlYXlP?=
 =?utf-8?B?YjI0UmpQVFJEUUhqNy9SM1A5MFNKam93RWRoT3B5bGhtRTduVVEyZ3ZBV3JJ?=
 =?utf-8?B?OFlTdEsrNTJQekdGVlJPdmVQbnhGaER4V25IdFhWUHpUM3RqNmU2Tm85RkJm?=
 =?utf-8?B?RmZSUlRxTkdSczl4OEFndHN5V2Y2cUtCK1VjOWkyeXhpSThZdzcyeVM4T1l1?=
 =?utf-8?B?RW5Sa01KQzQyT1d2aTUxdWRZQUdMTVJUUHBvSjh6WkJGaFd4a1ZibUo5Kzkx?=
 =?utf-8?B?MlVBZnY2UzhhazBYQ3dZbWdxci9wM282bU9aNjZLMXV4WUZveHVBSTc4NHpn?=
 =?utf-8?B?UWxoazhwbVhIaWhNcnd1akxmSTR6cW5lUEFXN1pqRFFHZ04wdTVRK1FHQ2Na?=
 =?utf-8?B?K040MVJYaGRjRGNNL1I0WndXdVhWNUF2Nk0vbGpHZ1hkc2ZZSm8yMlRtUnJR?=
 =?utf-8?B?ZGZacTNVT2t0M1N2RUtLdnRMZTA2cDFHQWU5RjhFYW9mQ1A2OTVmSC9ORWhr?=
 =?utf-8?B?TmZtR2E4eExRQS9TOXNEem1YaEcyMWU1OUtuZ0hXQ3V0d0VaYWVsbWcxYWtp?=
 =?utf-8?B?b0QrS2s5WEYxbURpOEtMd3ZLb1EwdGk2L0xLUWV3N3pZM2RHY255dU4zSUxv?=
 =?utf-8?B?WFBQd2dYbkVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9vV1dhL1d3Vm5DSzJkVjFjaHBaR3Rpb283VjVyeDd2NkhtV1MyaGwyc3cx?=
 =?utf-8?B?RWVxSS9wUGRBcGt6OHJoZUJ0K0ZBRG4rUklBM3BYYWN3aGRiWDMxS1loZnBk?=
 =?utf-8?B?Ny9LTWxLa3BXSVphNnJBa09hZWhBZDMrUnZFTmtoU1pwSnY1M2hYQWRuem1R?=
 =?utf-8?B?a21uY2U2dUNNZi9aMHZzUHZ3aEozbndvRDh2NVlrcFFKdzlYQTM1dVZTc3Rm?=
 =?utf-8?B?VTYrcWdBSFhLTi9VQ3lYMjdSYU9FeHZBUHF6QlNwQVA3WHhiVDJkdm80MWdL?=
 =?utf-8?B?a3NhZnlNMElWU0ltKzJ1MkhMcHcrUUxFbGxRVTN5MnkvYkd5ZVB5QnZQdGpI?=
 =?utf-8?B?NFVKaE1qQjBldWVYeVFuMVhkNjFhekwxVS8rU013U2FKMk5WQml1TmdyQVFQ?=
 =?utf-8?B?ZXRTaHhjNXdBRzhjQ0RZdGRLbnQwV0NwbXVObm90TE1Pbyt4OU1naUVTZkdW?=
 =?utf-8?B?cytNMFFNTEkyYlpxWXNFYmNFOHBMaVRpTkVMK0JBKzZiMS9oT3V1UmN1V3Ex?=
 =?utf-8?B?OS9NWmZ3cTlZdzZvcjdlSVYxeDdieUJONkxBcDRBM1NuS1VabVoxYlVMUHhY?=
 =?utf-8?B?YWlGSG1uUzJSbzVsVmE2ZVFiVDdQVVFMbnRQSElHaGw1d0ZMc3lGQndTYW1F?=
 =?utf-8?B?ZDdmeWRMbEpnWGd0dUlHdlRNNkZaUXg4cnBTaktCd2hoZFZyWWhmaUV2QnNu?=
 =?utf-8?B?b0I1eERUZTBNcGhSc0o2Z2pRdHIydk8vU3AwTW5JMS9EaFJYSWJidURBRDNy?=
 =?utf-8?B?emV6RDNVQitDWjZZcDZkZklwazUrdmZKZnlFa2VKRm1IL3BWV2dUZmJHN1p2?=
 =?utf-8?B?Vk5UT3pLZFVVUVVMODU0UkpsZHFmZEEza09zM0pQWlRVcWhCbUdFbzdnMEcr?=
 =?utf-8?B?M2NRYW1DZFlxOThxYjJMZmpoMVFwdGhaLzRvTkhtMktHSHNMQmdldDRDVG5q?=
 =?utf-8?B?UGU5TjJjMmxwd1NPbm9NUXQ1OHhzSXVnRG4xbU0zTHlPbTlmVDgyRXFjUStS?=
 =?utf-8?B?c1hNZGl3cEYwYUwwd2RHSjZaNjE1RkV3ZVRrUGpZS2J6dTF2UG5uSHRjRTRI?=
 =?utf-8?B?ZEVQTkczN3JSZXZhWG9ncTlzbzVLdVVwZXF2YnlIZjlxUk1Oa0ltUVhEalZF?=
 =?utf-8?B?eWFmdlhkRzVxTlA1RThBSlZVTzR6RkNaSW4veVFXSmRPZ3ROVWV5ZmZQYWdk?=
 =?utf-8?B?VkVoY2FFM3AyNHNJaFNPZTI3NDk4anpkN1E1SnVPNUFLQnZsSW9mcDZMQmY2?=
 =?utf-8?B?bFR1U211VGRJdEZLKzVHR2hVWFBVVFJqN1NVQ1BWZFFJTDI4dzg4KzBJREU5?=
 =?utf-8?B?c2lLVDlyTE9MQUdhbkJOZzZucFVTZFZUQkpReXB2ZXVaZDM3b2JwMDdaajVp?=
 =?utf-8?B?NHBETWpET1RHUlVIbUlQOEN1L2RmL1paRmJXRG1zMU9NdVlOU21DUFBXSkFs?=
 =?utf-8?B?OGpiVGVPU3Roemd3cytXeGNMT1lteERkeHdJN3pselEwUmV1VkkvRzN2eHFi?=
 =?utf-8?B?b2ozd0RUNk5TYjIvQm9GbkswREZjUFJCeHpNd2k2M3RUVThQdFlQa2lTV1RW?=
 =?utf-8?B?bkJqS3k2Z1E3aTNYbzRhYkh3MStDMlAxZjRLVGVwa3YrakpucUhFYTZuTFpn?=
 =?utf-8?B?SDNHREh3RjIzVVFrTjBPdFRLV3BET2srcXdtMCs3RlNPVzVTVGlDVTdoU08y?=
 =?utf-8?B?S2xLN0FFeXhiaThGUnNsMmFvMGlZcFJyN3BVa3JZMWxvbXc3OU12a3V4M292?=
 =?utf-8?B?RGcrZWIrc2dOL2xlU0lFN05FRnhydzNONzBoYWljSDB5KzdaRHJ3RDN3VTg2?=
 =?utf-8?B?bDcwRisrSDV3ZU5pUWFrVTgvOHNhNys2bjIxRWlNa21ETENZZWZqTWFxNWpN?=
 =?utf-8?B?dTJvS1V2QWk5Qjg5Ti9nYmNLNXA5L1VFdDZIUUxPK2dmMFNpN3pwcVFibkxC?=
 =?utf-8?B?T2l1VFlFNjZWK1J5SDlnc09mZ0dKMjdHcjlMMkh3SmZpNkVmZksrM2VNTDcx?=
 =?utf-8?B?ZFp4V0FaTkJVNExGQkdjeEpXRnlGVldDbmtBeTRVSXJYcXJpMHlrcTRRLzBm?=
 =?utf-8?B?VnFLWGpDd0hLTWNVcE1JNzQ0b00xdjNiQjcrSUxkbW52aUhkR1dqc2M2K3lm?=
 =?utf-8?Q?ygtigPyCn+EAzbO6NPbsMWeFr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc349163-efb8-4b38-0f40-08dd5be9b6ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:10.7657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33JX3brTnikdikI97fC+zo/HRfi5lGMQ3YbiNrKqeWwnh/hvhTCY5hcFUOd+u/PXYZWiBtprD5agFD3ZE7LL3A==
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

From: Peng Fan <peng.fan@nxp.com>

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 06de4a601f..34f272c448 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1046,4 +1046,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

