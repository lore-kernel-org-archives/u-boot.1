Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DC6E77188
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92C5080654;
	Thu,  9 Jan 2025 03:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="azO9gFrq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766C2806B7; Thu,  9 Jan 2025 03:23:46 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F2680602
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M++x4N2RFQfPZDs/JKnd0I9W+8Y1lWEcMgp3fcN9rPNzlG3SAXKO4TW1haAR5ctXMRGCTsWxha2Pq4Dl1AEosbTyFehefHiwwkT1/MQP3urwnl5w0Cpyfgnj4E7rMJgGZZiPguHJSEsdGp5QFyridjHKnOtl/0NT7qcWkpi7RkrYaKLnnNy8dQOvzNkAhZettbZrgc8SgWBZHzQ01OjvmvXqtimUfvXF67nJQA0yaWEafJT4ON/D8Zkpb2BQlQBlUtlqfKMzb6y5VFl3ov0xcbdpxCLcN9yyeQxDT26JaqjwzhGZxWjKYdq6fFp6NSmA9Fk3iQYnMwsZxUwwow4CRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlUMGyxBQhduNy05t7RQz5g7V1u7VQrya+aWgAOdcJk=;
 b=yZASiHVgw5Idb9dqvv0w7Zd19C29EKK5N0C7NOUUXBRBg1ycNH2Wwk5xkysRKtpS3Hrc9wkGRKbQjuCO1kLcYng84NPkcJYpBIcGd6S/BTIOlCnNwgEKCwXe6t+EUPodGPQ0AKpbwep5MtinYz2kV++pzl5FyVhSgN6PBPFkZHn+DQ2afZbvU3hmYWFpLJBHUCzRFN0OmBbBNRAr4P0TxTywTmEhbRY8vzFi1dOkdRXh1iLoVXwsGXk632RI4hbU4VckxRmLLP5VgWegH+mnr8s0bmuQImSOIAGh/1eQrD2FqFeZb9EyqQGIe8RnxVLI/Rz654MJBK3c9RF1nBpjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlUMGyxBQhduNy05t7RQz5g7V1u7VQrya+aWgAOdcJk=;
 b=azO9gFrq/MfpODuT3R2RPmGVVlPfT6NMqOo34PTC7RRDwrC024pq6lq6QNlzKHT/yJFxOt1m36AV3lTFhOWk7ekiVXPFT8mrKtlrvWnoVr/u740GcRM9hxt+JjPmkIlUkMdIe6mUK7zJgmv0dkatWnYsROJUPnINbQgREnfgAERfZuy0p4QhQW5LSeDdiGrsouqENRlKj1s9atp0V1HZXzX/Be9eFaw5Tzemz4ioB9jwWUZsbMWeRTkzJt6NEJKN05epUEMotoA768TSCn+FFa6Dm5gsPWIRp01lRr56wSjtrn2tfXczEClYCX0Fd6lc223lxF5dYOIuwg6MF7JyqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:43 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:15 +0800
Subject: [PATCH v3 14/17] imx: imx8mq_evk: Enable dynamic settings to
 mmcdev and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-14-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: ae306daa-d5fa-42bc-15f4-08dd3054a318
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFZMUlZVZEtkTnNDZDV0Y1dGT05UZGdhTkJmejdueGxoaDRhQVkza1p6bCto?=
 =?utf-8?B?RjI5SHBEMjNNbzZkcVlIME5qcjFEWXZrS000VFZPdnkvOVh3MzQ3anczMUh2?=
 =?utf-8?B?SEQzSEVJMlcyL1lWQkJMMVlvWnNwZWViL3I5NUNyRTlHQkFuSHg4MzlVNkZB?=
 =?utf-8?B?ckR4ZXpnSHdkNllDSWtUYWgxVWlJajl6aVp4L0ZYVUxVRUs2eUMxVFJ5K20w?=
 =?utf-8?B?eHBLNXdlQ29qdnIzTDlWNzZlRFBsM1NhbUpqNUx6TUNDUmN1OUpVenE2YXFv?=
 =?utf-8?B?ZlZ5Y2kydEVwK1VxTmlYNXMxVmpLOEN1K0JNaDJDWTQ2ejFxVGVDSmZId0c5?=
 =?utf-8?B?QnRrRWZKang2MjluK3ZUR21lTVpJOTF5MkJjaUxBdjdnblBqeURlS29lMUNt?=
 =?utf-8?B?OTBrV2xmdkxLVlYvRnBkRWdUVUpLVDF0ZXY0N01UQkJISEtPTG9PemtKWHJW?=
 =?utf-8?B?MHFuNFNkWXlvcUQzY3BSRXJ3UUtpdmZCMHM5VnlJdGxIMVJubW5Pem9ESXBC?=
 =?utf-8?B?SHBaeE1vSndFU1VMak10K2NuSVVVOGFjYWVZdEQ2bEdhT0J0UHh4eDB2UkJD?=
 =?utf-8?B?dm9CVmpRZEN4SldOV0tRT3FPaGJkNC9saXFSMmI1SHpsZnBhRVBPSWFhRkto?=
 =?utf-8?B?V2dHNHo1QnprMFNKaEw3a0xIaklSZkh4dFFSajdmK1dKU3VyeG9pbk9UQTlB?=
 =?utf-8?B?bUUvQ2V5VmVQZklhTWUxNXdLUTJ6dWh5c2phTXI1Z1JOVTdaVmtNMVZQQVI2?=
 =?utf-8?B?OXJ0M09hTVhiTWR4RnMxUFVmbnhaVWhyc2xQY09mbC9ZbFlUdmlCRmlFLzhp?=
 =?utf-8?B?bCtnaTF3bThoTktNRDFzQ0x3TitkSndKRGF3UnJyOC8rUXg5dG1WSUs4WldG?=
 =?utf-8?B?eHJxQ2pBTUozOTJmaHNiMHFmSlFoQjZ1TkFNRm1YYzF3MHArRWdibUUxZ0J1?=
 =?utf-8?B?TWFUMzFBVk4wNzBJc2haNkRraVdWaWNBNFJjMUJVQTZDU1YrZzlNRlNoYzMx?=
 =?utf-8?B?TWoxbjB3UEptZGtpbTBUazlqUmtjaUNmL2NNTTA1UEdXaURYakRPSXBLbjRk?=
 =?utf-8?B?WCtjb3dFYUZHYU9SS1ZnTGF6MEYxYVJYUDdsWXZnNE85RDdFeG9id3VrZk1I?=
 =?utf-8?B?V1I1SFcxd0ZmMlRTcS9VUHAzRGtCUGtvaktHNDdabnNqcWppL0Z1TEFHSFdk?=
 =?utf-8?B?NURnby9YSWY0bm5zdkpBZWJDNlY0U1ROdDBNYlB4V1NIMGtlVHg0QUw4OFpx?=
 =?utf-8?B?V0tGVk84WGJwZ3RlcHJoNk1IaTVwUWEwckFmZ0QrYjNINmNwUCs2LzNoNk1M?=
 =?utf-8?B?TUNBb0hxTFFNZVJxamM4T3hlKzFkUnNJZFQwcTNBc0RDSDNtd1gxS3hxVjdW?=
 =?utf-8?B?U3ZqVm1BMytZODVwU3pOOVNDK0p6dS9BLzd5UUg5ck9yWEJ4ZjhpSVNQU25X?=
 =?utf-8?B?cEhJRjNBT2sxRnVFdGMwSStabjY1WEpzMnEzNnlTRUh6a1dvdEpoblZGS0VS?=
 =?utf-8?B?Z0NzaUVFdWRkREd1TkdNRUdQTUtWSEtqeEppMXBCMXhZZms2T0pIdzFaeVpT?=
 =?utf-8?B?NEdvTVJXcG5NSjRZemhHaXdGa1Q1eS9Ld1ZOdmZiOExpZnBvK0lwWlozbE9u?=
 =?utf-8?B?T1dKQmp6SHI4a2VjaUtybHVxS3dlNURJcW1FblZCZlVGVGg3MjJtemdtdU5B?=
 =?utf-8?B?S0wrSitaNll0SFpDS21hdjIvSnVXY0MxUm5xaFg3S2dtblBCS1NUVjlRSWI3?=
 =?utf-8?B?L3hsS01RRy9jY1ZKNGhFbS90ZFYvenlLdVlBb3NuM0thMWd0Z2VIZER4SWVw?=
 =?utf-8?B?YTQwejIwQnk4aFluV0FGWFI0TFRMSVhFWXc5Nk84eitRMXIzSEJuMnNSb2g0?=
 =?utf-8?B?NW5KZmxrQW1ldXY0L0hFUm0zRkdmZC8yWmlHalVNU3RSMFM0RWM3LzBsQzNW?=
 =?utf-8?Q?4e+z+t6wcQ5ApXy1PMqKSO2V2JoqAHvT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmhYTDd3Yk0vUzFpNHRkcStPdGhPeUFJMUUrOGpEUnlEUCtEWk53V0NyN2U1?=
 =?utf-8?B?TUtUODh1VG1NaUthNWtwanEyRVp2OTdid2FvSFcrNWY5VDJBalEzb094N3VO?=
 =?utf-8?B?d1lxWndMc1BDTExIei9JbGNscURNVXVWQVpDcktWNitSbW52WDNDcnFLS0Nv?=
 =?utf-8?B?Z0liakFzMVpzbmw1L0Z1aWo4MGVsR1F0YzVQaWJIUTU4RzhnTlJuaXZJdERK?=
 =?utf-8?B?b2NVZTdGRS91QS9BUCtWS0huN2h2cTl0L1ZxWTM4RUQrSENrRWk5cHliQmhw?=
 =?utf-8?B?RlN1NnlwOVZhQmdRc1p5UW5VaEZUT2JqRmJFSGtkTE9tWDBJbGdGdUJPTEpK?=
 =?utf-8?B?QS8veUJpTmIxYjhHU1dDaklPcnVvSlNLRU9aay84ZWF1VDQrQTBPblNEL0FU?=
 =?utf-8?B?ZXZWMkFPS1JpWFZBMFptUWplYXZYdk5aZnpSUG9DNFNxRWpGT0d5RWR1NWF6?=
 =?utf-8?B?VkhObkxMR1BmTXBOVXNHMGxwdzJucWFCV0p4L1drczRWZVpYM0IydG4raHF4?=
 =?utf-8?B?SGpVTlArNXBCVVhGSW92SGxteUlrc0hraXFMb0tiQUtlVnFDWVhmUGl4eUpo?=
 =?utf-8?B?ZXBFajlhc0k5YURBQ3UyWXdrNnJSNXREcFQ3Q2k3RWFyVzlKanZmS1N2ZTdG?=
 =?utf-8?B?eS9Fb2lxQldqMWZoRk9wYVpkMWJoSSswWXFvRDZnWGJ2MDA3aWlST05ZaVZX?=
 =?utf-8?B?VGFKU0paWTNwek9nOEtKcXBEdlluNjJqRjJRUTZuMkpuSkxHWFdqcVZlUC90?=
 =?utf-8?B?UjhpdW01OWMwV2U1d0Y1S0RYbUpDekhOaU5YVWpOUEZlQjN4bmdvME1rdG5p?=
 =?utf-8?B?eHRoVzM0SWZoSUJmdk1FellSNVJVODFNMFJWamhqSUplZC9vajNwaWl1ZG9X?=
 =?utf-8?B?VE1TRHcxTkFnL2VqelFOc1pGRkNVd1djQ0ZCN0ZmL3BjTlFuVitJcm9tQTRp?=
 =?utf-8?B?TTRoYXhlZlppQllUVTlRdnhObzZ5ejFESkNhSkdRS1hBcktPbXdLa1g3ZCtw?=
 =?utf-8?B?QThhVnBsUS9oanVjVEVMa3ViSDM3NGROU1VaUExUdDFWV1FQRHZTSlV4aXpV?=
 =?utf-8?B?WDc1amNmR2xGeHhvU2xCelVqYTBzejRqNGVwSUJlaG9qTTJjRkFtQkNGc2pS?=
 =?utf-8?B?elVJZm9ZeTREdHF0a0JXRGtvQXJtM1hzSk1RSXZodkt3c3RyQTFlQURWOFhN?=
 =?utf-8?B?KzZuNUk4MWNnMEVYblV2anRPelZPZ01nKzZyMFhZVGE4YU43bVVLT0R6dExF?=
 =?utf-8?B?MWQwTjVqeHN0V3JzQTVEbUdJRjNQZ2hpaGZDTDhWUDlLRi8zRjhGVW1SY0JW?=
 =?utf-8?B?OEtjZnM5ZllmYUl2Qmx2YWFnTThkclFzY0lZM09DMlozRzk4OGsrWDVyT0hV?=
 =?utf-8?B?Q0h4T2w3cldyazJ4YU9XU2dKTmNVdmxKSUxqNUEvWFBsMCtxQ21wL0gzNzg4?=
 =?utf-8?B?eDBSQUZhQkFaMWxPOTJROVA2bUtQWTRBK2NrYzhoRDAxQXkxTEtvSmZBNkNP?=
 =?utf-8?B?YmpUSDZVVEk0RWVQR0c3cTh0d3l2MmN4ZDY0L25nQXBHc2JpTzVTdzQxNXRj?=
 =?utf-8?B?RXhvb3A5QmJzWXY3c2hpdWtxQnJXWEtkdGtJV0cwZFEyOVErQkhTeGdmbElr?=
 =?utf-8?B?bjZwanFmYTRrTDUrQlcyQzAyVjVwZGFiZkE4eUVXWk4wcUtyZzl5bzFyL3or?=
 =?utf-8?B?aW5OQXBxejhoNFNFb0pMUm1XSXl5Wm1YYjRRU3g0aVY3ekpNQmhrRTBxT0J1?=
 =?utf-8?B?OEhzMlFnTDV3UkNnVENJc203VnFZL0R1djRXc1FDVEtXWlhJNDUzSHBuWVU1?=
 =?utf-8?B?Ukg2NlNvMlFqck1DSFBqOFl4OUtKR2JjYVRweWlNZG5Xdlozd01IbU1GWitr?=
 =?utf-8?B?a0FYd3ZHME5zMEVoZ2piS3pWQTArSkJsNzM3emRIdEFXdGtFdi82WHVBbFRx?=
 =?utf-8?B?ZXJsdzV1VllhTkVmbXdzSVB6Y3IwcVFDdFJIcTB2VExNWkVncGlCSnVUK0Qx?=
 =?utf-8?B?SllIcGFKNnl2bFJzV0FZOFdScUVWU1NsNWlsblRIQ3FhQVY0RTEvR09MTUdw?=
 =?utf-8?B?Z0s2L05iQTNIV2N6dlBxYXhDOWZhM1ZXRlBoenI3eHVlRjcxdkRhcC9YdDJZ?=
 =?utf-8?Q?TVCMKT4Vb3sHqcUznkBGKI2r7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae306daa-d5fa-42bc-15f4-08dd3054a318
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:42.9156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4NLbVgWJ3oZZEnSJXZoTr/LzU+Vo6JxRYVbcMJT46Bg/PT3YjLMNtNlUC3MuF/D9lRJnUhWUAFv+0n+ZigLHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MQ-EVK
Since we are here, clean up the including headers

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index f833996d5248eba637b443d7bc66141c3aff8f9b..18e83d90a08d653dd629bb773ffd11f50532f4b9 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -50,6 +50,10 @@ int board_mmc_get_env_dev(int devno)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "EVK");
 	env_set("board_rev", "iMX8MQ");

-- 
2.35.3

